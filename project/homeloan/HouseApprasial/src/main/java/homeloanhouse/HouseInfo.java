
package homeloanhouse;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="nationalID" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="address" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="bedroom" type="{http://www.w3.org/2001/XMLSchema}byte"/>
 *         &lt;element name="bathroom" type="{http://www.w3.org/2001/XMLSchema}byte"/>
 *         &lt;element name="landSize" type="{http://www.w3.org/2001/XMLSchema}short"/>
 *         &lt;element name="appraisedValue" type="{http://www.w3.org/2001/XMLSchema}byte"/>
 *       &lt;/sequence>
 *       &lt;attribute name="infotype" type="{http://www.w3.org/2001/XMLSchema}string" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "nationalID",
    "address",
    "bedroom",
    "bathroom",
    "landSize",
    "appraisedValue"
})
@XmlRootElement(name = "HouseInfo")
public class HouseInfo {

    @XmlElement(required = true)
    protected String nationalID;
    @XmlElement(required = true)
    protected String address;
    protected byte bedroom;
    protected byte bathroom;
    protected short landSize;
    protected byte appraisedValue;
    @XmlAttribute(name = "infotype")
    protected String infotype;

    /**
     * Gets the value of the nationalID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNationalID() {
        return nationalID;
    }

    /**
     * Sets the value of the nationalID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNationalID(String value) {
        this.nationalID = value;
    }

    /**
     * Gets the value of the address property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAddress() {
        return address;
    }

    /**
     * Sets the value of the address property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAddress(String value) {
        this.address = value;
    }

    /**
     * Gets the value of the bedroom property.
     * 
     */
    public byte getBedroom() {
        return bedroom;
    }

    /**
     * Sets the value of the bedroom property.
     * 
     */
    public void setBedroom(byte value) {
        this.bedroom = value;
    }

    /**
     * Gets the value of the bathroom property.
     * 
     */
    public byte getBathroom() {
        return bathroom;
    }

    /**
     * Sets the value of the bathroom property.
     * 
     */
    public void setBathroom(byte value) {
        this.bathroom = value;
    }

    /**
     * Gets the value of the landSize property.
     * 
     */
    public short getLandSize() {
        return landSize;
    }

    /**
     * Sets the value of the landSize property.
     * 
     */
    public void setLandSize(short value) {
        this.landSize = value;
    }

    /**
     * Gets the value of the appraisedValue property.
     * 
     */
    public byte getAppraisedValue() {
        return appraisedValue;
    }

    /**
     * Sets the value of the appraisedValue property.
     * 
     */
    public void setAppraisedValue(byte value) {
        this.appraisedValue = value;
    }

    /**
     * Gets the value of the infotype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInfotype() {
        return infotype;
    }

    /**
     * Sets the value of the infotype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInfotype(String value) {
        this.infotype = value;
    }

}

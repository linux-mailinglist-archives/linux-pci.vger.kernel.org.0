Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4A1C17FA
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgEAOk2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 10:40:28 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38898 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728724AbgEAOk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 10:40:27 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041EcXNY011367;
        Fri, 1 May 2020 10:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=f5EhUg+2qViBuYRqls1JIQPK8/jrT+h/lixC+byaNic=;
 b=KgpfV2LtQO7myD0PIJmWBCvPgPJtyY0ghvpNftCtBdqLc6+nA/5Z8/SJBDmzHLqiCZzC
 m+4g0yDZD/GS8AR4FOa8ottT9f5H8fy53lpCU2ojE71nF3Zjl+0vbjfPC9abL8kFOu52
 uT3H31TaQxwX6UWZj2yxGZkY5wAgum1KneCK8mie0WuFe5Y5sf2kQObTd3GyTZqO6Avi
 ew0UYn4YLmMrIKUUx+qekCCreaxcqZ4TRgIqRnJnIeYCYAjIUlQDHWqt6z1kTXuCtFtO
 SqwnE5JfhlYj/1o9ZiwuFXwxkUISM4p9Ab6+REaS1bJIxOBej6tY0ggmgnB3czYkF99S 2Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30r7ga9bq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 10:40:26 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041EeLkJ144164;
        Fri, 1 May 2020 10:40:25 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 30r8v8fur4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 10:40:25 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1438325864"
From:   <Austin.Bolen@dell.com>
To:     <helgaas@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <Austin.Bolen@dell.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>,
        <Mario.Limonciello@dell.com>, <jonathan.derrick@intel.com>,
        <mr.nuke.me@gmail.com>, <rjw@rjwysocki.net>, <kbusch@kernel.org>,
        <okaya@kernel.org>, <tbaicar@codeaurora.org>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Thread-Topic: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Thread-Index: AQHWH0BTLJAR9qHhEEijsUMwMfFiow==
Date:   Fri, 1 May 2020 14:40:23 +0000
Message-ID: <42c53d43bc094889b33c1ac8c2b99d33@AUSX13MPC107.AMER.DELL.COM>
References: <20200430230218.GA72958@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_08:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010117
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010116
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/30/2020 6:02 PM, Bjorn Helgaas wrote:=0A=
> [EXTERNAL EMAIL] =0A=
>=0A=
> [Austin, help us understand the FIRMWARE_FIRST bit! :)]=0A=
>=0A=
> On Thu, Apr 30, 2020 at 05:40:22PM -0500, Bjorn Helgaas wrote:=0A=
>> On Sun, Apr 26, 2020 at 11:30:06AM -0700, sathyanarayanan.kuppuswamy@lin=
ux.intel.com wrote:=0A=
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.inte=
l.com>=0A=
>>>=0A=
>>> Currently PCIe AER driver uses HEST FIRMWARE_FIRST bit to=0A=
>>> determine the PCIe AER Capability ownership between OS and=0A=
>>> firmware. This support is added based on following spec=0A=
>>> reference.=0A=
>>>=0A=
>>> Per ACPI spec r6.3, table 18-387, 18-388, 18-389, HEST table=0A=
>>> flags field BIT-0 and BIT-1 can be used to expose the=0A=
>>> ownership of error source between firmware and OSPM.=0A=
>>>=0A=
>>> Bit [0] - FIRMWARE_FIRST: If set, indicates that system=0A=
>>>           firmware will handle errors from this source=0A=
>>>           first.=0A=
>>> Bit [1] =96 GLOBAL: If set, indicates that the settings=0A=
>>>           contained in this structure apply globally to all=0A=
>>>           PCI Express Bridges.=0A=
>>>=0A=
>>> Although above spec reference states that setting=0A=
>>> FIRMWARE_FIRST bit means firmware will handle the error source=0A=
>>> first, it does not explicitly state anything about AER=0A=
>>> ownership. So using HEST to determine AER ownership is=0A=
>>> incorrect.=0A=
>>>=0A=
>>> Also, as per following specification references, _OSC can be=0A=
>>> used to negotiate the AER ownership between firmware and OS.=0A=
>>> Details are,=0A=
>>>=0A=
>>> Per ACPI spec r6.3, sec 6.2.11.3, table titled =93Interpretation=0A=
>>> of _OSC Control Field=94 and as per PCI firmware specification r3.2,=0A=
>>> sec 4.5.1, table 4-5, OS can set bit 3 of _OSC control field=0A=
>>> to request control over PCI Express AER. If the OS successfully=0A=
>>> receives control of this feature, it must handle error reporting=0A=
>>> through the AER Capability as described in the PCI Express Base=0A=
>>> Specification.=0A=
>>>=0A=
>>> Since above spec references clearly states _OSC can be used to=0A=
>>> determine AER ownership, don't depend on HEST FIRMWARE_FIRST bit.=0A=
>> I pulled out the _OSC part of this to a separate patch.  What's left=0A=
>> is below, and is essentially equivalent to Alex's patch:=0A=
>>=0A=
>>   https://lore.kernel.org/r/20190326172343.28946-3-mr.nuke.me@gmail.com/=
=0A=
>>=0A=
>> I like what this does, but what I don't like is the fact that we now=0A=
>> have this thing called pcie_aer_get_firmware_first() that is not=0A=
>> connected with the ACPI FIRMWARE_FIRST bit at all.=0A=
> Austin, if we remove this, we'll have no PCIe-related code that looks=0A=
> at the HEST FIRMWARE_FIRST bit at all.  Presumably it's there for some=0A=
> reason, but I'm not sure what the reason is.=0A=
>=0A=
> Alex's mail [1] has a nice table of _OSC AER/HEST FFS bits that looks=0A=
> useful, but the only actionable thing I can see is that in the (1,1)=0A=
> case, OSPM should do some initialization with masks/enables.=0A=
>=0A=
> But I have no clue what that means or how to connect that with the=0A=
> spec.  What are the masks/enables?  Is that something connected with=0A=
> ERST?=0A=
>=0A=
> [1] https://lore.kernel.org/r/20190326172343.28946-1-mr.nuke.me@gmail.com=
/=0A=
=0A=
The only values that make sense to me are (1, 0) for full native OS=0A=
init/handling of AER and (0, 1) for the firmware first model where=0A=
firmware does the init and handles errors first then passes control to=0A=
the OS. For these cases the FIRMWARE_FIRST flag in HEST is redundant and=0A=
not needed.=0A=
=0A=
We did discuss the (1, 1) case in the ACPI working group and there were=0A=
a potential use case (which Alex documented in the link you provided)=0A=
but there is nothing specified in the standard about how that model=0A=
would actually work AFAICT. And no x86 system has the hardware support=0A=
needed for what was proposed that I'm aware of (not sure about other=0A=
architectures).=0A=
=0A=
So unless and until someone documents how the firmware and OS are=0A=
supposed to behave in the (1, 1) or (0, 0) scenario and expresses a need=0A=
for those models, I would not bother adding support for them.  Just my 2=0A=
cents.=0A=
=0A=
>=0A=
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c=0A=
>>> index f4274d301235..85d73d28ec26 100644=0A=
>>> --- a/drivers/pci/pcie/aer.c=0A=
>>> +++ b/drivers/pci/pcie/aer.c=0A=
>>> @@ -217,133 +217,19 @@ void pcie_ecrc_get_policy(char *str)=0A=
>>>  }=0A=
>>>  #endif	/* CONFIG_PCIE_ECRC */=0A=
>>>  =0A=
>>> -#ifdef CONFIG_ACPI_APEI=0A=
>>> -static inline int hest_match_pci(struct acpi_hest_aer_common *p,=0A=
>>> -				 struct pci_dev *pci)=0A=
>>> -{=0A=
>>> -	return   ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(pci->bus) &&=
=0A=
>>> -		 ACPI_HEST_BUS(p->bus)     =3D=3D pci->bus->number &&=0A=
>>> -		 p->device                 =3D=3D PCI_SLOT(pci->devfn) &&=0A=
>>> -		 p->function               =3D=3D PCI_FUNC(pci->devfn);=0A=
>>> -}=0A=
>>> -=0A=
>>> -static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,=
=0A=
>>> -				struct pci_dev *dev)=0A=
>>> -{=0A=
>>> -	u16 hest_type =3D hest_hdr->type;=0A=
>>> -	u8 pcie_type =3D pci_pcie_type(dev);=0A=
>>> -=0A=
>>> -	if ((hest_type =3D=3D ACPI_HEST_TYPE_AER_ROOT_PORT &&=0A=
>>> -		pcie_type =3D=3D PCI_EXP_TYPE_ROOT_PORT) ||=0A=
>>> -	    (hest_type =3D=3D ACPI_HEST_TYPE_AER_ENDPOINT &&=0A=
>>> -		pcie_type =3D=3D PCI_EXP_TYPE_ENDPOINT) ||=0A=
>>> -	    (hest_type =3D=3D ACPI_HEST_TYPE_AER_BRIDGE &&=0A=
>>> -		(dev->class >> 16) =3D=3D PCI_BASE_CLASS_BRIDGE))=0A=
>>> -		return true;=0A=
>>> -	return false;=0A=
>>> -}=0A=
>>> -=0A=
>>> -struct aer_hest_parse_info {=0A=
>>> -	struct pci_dev *pci_dev;=0A=
>>> -	int firmware_first;=0A=
>>> -};=0A=
>>> -=0A=
>>> -static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)=
=0A=
>>> -{=0A=
>>> -	if (hest_hdr->type =3D=3D ACPI_HEST_TYPE_AER_ROOT_PORT ||=0A=
>>> -	    hest_hdr->type =3D=3D ACPI_HEST_TYPE_AER_ENDPOINT ||=0A=
>>> -	    hest_hdr->type =3D=3D ACPI_HEST_TYPE_AER_BRIDGE)=0A=
>>> -		return 1;=0A=
>>> -	return 0;=0A=
>>> -}=0A=
>>> -=0A=
>>> -static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *dat=
a)=0A=
>>> -{=0A=
>>> -	struct aer_hest_parse_info *info =3D data;=0A=
>>> -	struct acpi_hest_aer_common *p;=0A=
>>> -	int ff;=0A=
>>> -=0A=
>>> -	if (!hest_source_is_pcie_aer(hest_hdr))=0A=
>>> -		return 0;=0A=
>>> -=0A=
>>> -	p =3D (struct acpi_hest_aer_common *)(hest_hdr + 1);=0A=
>>> -	ff =3D !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);=0A=
>>> -=0A=
>>> -	/*=0A=
>>> -	 * If no specific device is supplied, determine whether=0A=
>>> -	 * FIRMWARE_FIRST is set for *any* PCIe device.=0A=
>>> -	 */=0A=
>>> -	if (!info->pci_dev) {=0A=
>>> -		info->firmware_first |=3D ff;=0A=
>>> -		return 0;=0A=
>>> -	}=0A=
>>> -=0A=
>>> -	/* Otherwise, check the specific device */=0A=
>>> -	if (p->flags & ACPI_HEST_GLOBAL) {=0A=
>>> -		if (hest_match_type(hest_hdr, info->pci_dev))=0A=
>>> -			info->firmware_first =3D ff;=0A=
>>> -	} else=0A=
>>> -		if (hest_match_pci(p, info->pci_dev))=0A=
>>> -			info->firmware_first =3D ff;=0A=
>>> -=0A=
>>> -	return 0;=0A=
>>> -}=0A=
>>> -=0A=
>>> -static void aer_set_firmware_first(struct pci_dev *pci_dev)=0A=
>>> -{=0A=
>>> -	int rc;=0A=
>>> -	struct aer_hest_parse_info info =3D {=0A=
>>> -		.pci_dev	=3D pci_dev,=0A=
>>> -		.firmware_first	=3D 0,=0A=
>>> -	};=0A=
>>> -=0A=
>>> -	rc =3D apei_hest_parse(aer_hest_parse, &info);=0A=
>>> -=0A=
>>> -	if (rc)=0A=
>>> -		pci_dev->__aer_firmware_first =3D 0;=0A=
>>> -	else=0A=
>>> -		pci_dev->__aer_firmware_first =3D info.firmware_first;=0A=
>>> -	pci_dev->__aer_firmware_first_valid =3D 1;=0A=
>>> -}=0A=
>>> -=0A=
>>>  int pcie_aer_get_firmware_first(struct pci_dev *dev)=0A=
>>>  {=0A=
>>> +	struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);=0A=
>>> +=0A=
>>>  	if (!pci_is_pcie(dev))=0A=
>>>  		return 0;=0A=
>>>  =0A=
>>>  	if (pcie_ports_native)=0A=
>>>  		return 0;=0A=
>>>  =0A=
>>> -	if (!dev->__aer_firmware_first_valid)=0A=
>>> -		aer_set_firmware_first(dev);=0A=
>>> -	return dev->__aer_firmware_first;=0A=
>>> +	return !host->native_aer;=0A=
>>>  }=0A=
>>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h=0A=
>>> index 64b5e081cdb2..c05b49d740f4 100644=0A=
>>> --- a/drivers/pci/pcie/portdrv.h=0A=
>>> +++ b/drivers/pci/pcie/portdrv.h=0A=
>>> @@ -147,16 +147,7 @@ static inline bool pcie_pme_no_msi(void) { return =
false; }=0A=
>>>  static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool=
 en) {}=0A=
>>>  #endif /* !CONFIG_PCIE_PME */=0A=
>>>  =0A=
>>> -#ifdef CONFIG_ACPI_APEI=0A=
>>>  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);=0A=
>>> -#else=0A=
>>> -static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)=
=0A=
>>> -{=0A=
>>> -	if (pci_dev->__aer_firmware_first_valid)=0A=
>>> -		return pci_dev->__aer_firmware_first;=0A=
>>> -	return 0;=0A=
>>> -}=0A=
>>> -#endif=0A=
>>>  =0A=
>>>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service)=
;=0A=
>>>  #endif /* _PORTDRV_H_ */=0A=
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h=0A=
>>> index 83ce1cdf5676..43f265830eca 100644=0A=
>>> --- a/include/linux/pci.h=0A=
>>> +++ b/include/linux/pci.h=0A=
>>> @@ -420,8 +420,6 @@ struct pci_dev {=0A=
>>>  	 * mappings to make sure they cannot access arbitrary memory.=0A=
>>>  	 */=0A=
>>>  	unsigned int	untrusted:1;=0A=
>>> -	unsigned int	__aer_firmware_first_valid:1;=0A=
>>> -	unsigned int	__aer_firmware_first:1;=0A=
>>>  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */=
=0A=
>>>  	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */=0A=
>>>  	unsigned int	irq_managed:1;=0A=
>>> -- =0A=
>>> 2.17.1=0A=
>>>=0A=
=0A=

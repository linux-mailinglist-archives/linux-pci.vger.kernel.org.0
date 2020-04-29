Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68A1BE285
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD2PYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 11:24:45 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:42102 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgD2PYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 11:24:45 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TFJ3Dv005941;
        Wed, 29 Apr 2020 11:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=dNU7tDfWdNR29kmhKa0HT/IjGl0+Bf09aCf6zBhUofE=;
 b=GlyAARv2kgng/iXpaQ1aJuAyNgea7ugbMCdaARKULh4IP04WVdX8kcGy4gKP0WH1bFGe
 ytZqBinACr4YMRZk9T2d3apxvrMxRhRojJJz3UfLIO+VQfrQmoBba6fQ2zxSFOF3Q0bP
 OgyjBsGVn8p15J3Jmd3IkxZfqAFLA0HewSQicO/VcbgQIB7Ghf4Bl17DEkm2Ojb7Tw/X
 lp6oIyjurnJemDqDcRyMIgMdVVdodtksUJ5v6hloe9UNHEo4XLweU2i9YqnP03b2LYfE
 9TaW4SQi8cYzIh52OhJ+10j2ZwJrYyDrauHNWxlH7fFFuFblqalABIBc6Jlsgaec/Dxr 8Q== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30mh20kkhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 11:24:43 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TFFHHo093358;
        Wed, 29 Apr 2020 11:24:43 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 30q4c372gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 11:24:42 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="496776035"
From:   <Austin.Bolen@dell.com>
To:     <helgaas@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <Mario.Limonciello@dell.com>, <Austin.Bolen@dell.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ashok.raj@intel.com>, <jonathan.derrick@intel.com>,
        <mr.nuke.me@gmail.com>, <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Thread-Topic: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Thread-Index: AQHWHZzGLJAR9qHhEEijsUMwMfFiow==
Date:   Wed, 29 Apr 2020 15:24:41 +0000
Message-ID: <a3535fbc69604425b1e8f008348950ab@AUSX13MPC107.AMER.DELL.COM>
References: <20200428203657.GA206580@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_07:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290128
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/28/2020 3:37 PM, Bjorn Helgaas wrote:=0A=
> [EXTERNAL EMAIL] =0A=
>=0A=
> [+to Mario, Austin, Rafael; Dell folks, I suspect this commit will=0A=
> break Dell servers but I'd like your opinion]=0A=
>=0A=
> <snip>=0A=
Thanks Bjorn, for the heads up. I checked with our server BIOS team and=0A=
they say that only checking _OSC for AER should work on our servers.  We=0A=
always configure_OSC and the HEST FIRMWARE_FIRST flag to retain firmware=0A=
control of AER so either could be checked.=0A=
=0A=
> I *really* want the patch because the current mix of using both _OSC=0A=
> and FIRMWARE_FIRST to determine AER capability ownership is a mess and=0A=
> getting worse, but I'm more and more doubtful.=0A=
>=0A=
> My contention is that if firmware doesn't want the OS to use the AER=0A=
> capability it should simply decline to grant control via _OSC.=0A=
I agree per spec that _OSC should be used and this was confirmed by the=0A=
ACPI working group. Alex had submitted a patch for us [2] to switch to=0A=
using _OSC to determine AER ownership following the decision in the ACPI=0A=
working group.=0A=
=0A=
[2] https://lkml.org/lkml/2018/11/16/202=0A=
=0A=
>=0A=
> But things like 0584396157ad ("PCI: PCIe AER: honor ACPI HEST FIRMWARE=0A=
> FIRST mode") [1] suggest that some machines grant AER control to the=0A=
> OS via _OSC, but still expect the OS to leave AER alone for certain=0A=
> devices.=0A=
AFAIK, no Dell server, including the 11G servers mentioned in that=0A=
patch, have granted control of AER via _OSC and set HEST FIRMWARE_FIRST=0A=
for some devices. I don't think this model is even support by the=0A=
ACPI/PCIe standards.  Yes, you can set the bits that way, but there is=0A=
no text I've found that says how the OS/firmware should behave in that=0A=
scenario. In order to be interoperable, I think someone would need to=0A=
standardized how the OS/firmware would could co-ordinate in such a model.=
=0A=
>=0A=
> I think the FIRMWARE_FIRST language in the ACPI spec is really too=0A=
> vague to tell the OS not to use the AER Capability, but it seems like=0A=
> that's what commits like [1] rely on.=0A=
>=0A=
> The current _OSC definition (PCI Firmware r3.2) applies only to=0A=
> PNP0A03/PNP0A08 devices, but it's conceivable that it could be=0A=
> extended to other devices if we need per-device AER Capability=0A=
> ownership.=0A=
>=0A=
> [1] https://git.kernel.org/linus/0584396157ad=0A=
>=0A=
>> commit 8f8e42e7c2dd ("PCI/AER: Use only _OSC to determine AER ownership"=
)=0A=
>> Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.int=
el.com>=0A=
>> Date:   Mon Apr 27 18:25:13 2020 -0500=0A=
>>=0A=
>>     PCI/AER: Use only _OSC to determine AER ownership=0A=
>>     =0A=
>>     Per the PCI Firmware spec, r3.2, sec 4.5.1, the OS can request contr=
ol of=0A=
>>     AER via bit 3 of the _OSC Control Field.  In the returned value of t=
he=0A=
>>     Control Field:=0A=
>>     =0A=
>>       The firmware sets [bit 3] to 1 to grant control over PCI Express A=
dvanced=0A=
>>       Error Reporting.  ...  after control is transferred to the operati=
ng=0A=
>>       system, firmware must not modify the Advanced Error Reporting Capa=
bility.=0A=
>>       If control of this feature was requested and denied or was not req=
uested,=0A=
>>       firmware returns this bit set to 0.=0A=
>>     =0A=
>>     Previously the pci_root driver looked at the HEST FIRMWARE_FIRST bit=
 to=0A=
>>     determine whether to request ownership of the AER Capability.  This =
was=0A=
>>     based on ACPI spec v6.3, sec 18.3.2.4, and similar sections, which s=
ay=0A=
>>     things like:=0A=
>>     =0A=
>>       Bit [0] - FIRMWARE_FIRST: If set, indicates that system firmware w=
ill=0A=
>>                 handle errors from this source first.=0A=
>>     =0A=
>>       Bit [1] - GLOBAL: If set, indicates that the settings contained in=
 this=0A=
>>                 structure apply globally to all PCI Express Devices.=0A=
>>     =0A=
>>     These ACPI references don't say anything about ownership of the AER=
=0A=
>>     Capability.=0A=
>>     =0A=
>>     Remove use of the FIRMWARE_FIRST bit and rely only on the _OSC bit t=
o=0A=
>>     determine whether we have control of the AER Capability.=0A=
>>     =0A=
>>     Link: https://lore.kernel.org/r/67af2931705bed9a588b5a39d369cb70b994=
2190.1587925636.git.sathyanarayanan.kuppuswamy@linux.intel.com=0A=
>>     [bhelgaas: commit log, split patches]=0A=
>>     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswam=
y@linux.intel.com>=0A=
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>=0A=
>>=0A=
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c=0A=
>> index ac8ad6cb82aa..9e235c1a75ff 100644=0A=
>> --- a/drivers/acpi/pci_root.c=0A=
>> +++ b/drivers/acpi/pci_root.c=0A=
>> @@ -483,13 +483,8 @@ static void negotiate_os_control(struct acpi_pci_ro=
ot *root, int *no_aspm,=0A=
>>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))=0A=
>>  		control |=3D OSC_PCI_SHPC_NATIVE_HP_CONTROL;=0A=
>>  =0A=
>> -	if (pci_aer_available()) {=0A=
>> -		if (aer_acpi_firmware_first())=0A=
>> -			dev_info(&device->dev,=0A=
>> -				 "PCIe AER handled by firmware\n");=0A=
>> -		else=0A=
>> -			control |=3D OSC_PCI_EXPRESS_AER_CONTROL;=0A=
>> -	}=0A=
>> +	if (pci_aer_available())=0A=
>> +		control |=3D OSC_PCI_EXPRESS_AER_CONTROL;=0A=
>>  =0A=
>>  	/*=0A=
>>  	 * Per the Downstream Port Containment Related Enhancements ECN to=0A=
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c=0A=
>> index f4274d301235..efc26773cc6d 100644=0A=
>> --- a/drivers/pci/pcie/aer.c=0A=
>> +++ b/drivers/pci/pcie/aer.c=0A=
>> @@ -318,30 +318,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev=
)=0A=
>>  		aer_set_firmware_first(dev);=0A=
>>  	return dev->__aer_firmware_first;=0A=
>>  }=0A=
>> -=0A=
>> -static bool aer_firmware_first;=0A=
>> -=0A=
>> -/**=0A=
>> - * aer_acpi_firmware_first - Check if APEI should control AER.=0A=
>> - */=0A=
>> -bool aer_acpi_firmware_first(void)=0A=
>> -{=0A=
>> -	static bool parsed =3D false;=0A=
>> -	struct aer_hest_parse_info info =3D {=0A=
>> -		.pci_dev	=3D NULL,	/* Check all PCIe devices */=0A=
>> -		.firmware_first	=3D 0,=0A=
>> -	};=0A=
>> -=0A=
>> -	if (pcie_ports_native)=0A=
>> -		return false;=0A=
>> -=0A=
>> -	if (!parsed) {=0A=
>> -		apei_hest_parse(aer_hest_parse, &info);=0A=
>> -		aer_firmware_first =3D info.firmware_first;=0A=
>> -		parsed =3D true;=0A=
>> -	}=0A=
>> -	return aer_firmware_first;=0A=
>> -}=0A=
>>  #endif=0A=
>>  =0A=
>>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |=
 \=0A=
>> @@ -1523,7 +1499,7 @@ static struct pcie_port_service_driver aerdriver =
=3D {=0A=
>>   */=0A=
>>  int __init pcie_aer_init(void)=0A=
>>  {=0A=
>> -	if (!pci_aer_available() || aer_acpi_firmware_first())=0A=
>> +	if (!pci_aer_available())=0A=
>>  		return -ENXIO;=0A=
>>  	return pcie_port_service_register(&aerdriver);=0A=
>>  }=0A=
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h=0A=
>> index 2d155bfb8fbf..11c98875538a 100644=0A=
>> --- a/include/linux/pci-acpi.h=0A=
>> +++ b/include/linux/pci-acpi.h=0A=
>> @@ -125,10 +125,4 @@ static inline void acpi_pci_add_bus(struct pci_bus =
*bus) { }=0A=
>>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }=0A=
>>  #endif	/* CONFIG_ACPI */=0A=
>>  =0A=
>> -#ifdef CONFIG_ACPI_APEI=0A=
>> -extern bool aer_acpi_firmware_first(void);=0A=
>> -#else=0A=
>> -static inline bool aer_acpi_firmware_first(void) { return false; }=0A=
>> -#endif=0A=
>> -=0A=
>>  #endif	/* _PCI_ACPI_H_ */=0A=
=0A=
=0A=

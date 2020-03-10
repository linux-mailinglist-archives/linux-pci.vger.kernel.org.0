Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C6E180843
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 20:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCJTjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 15:39:10 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:1108 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgCJTjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2020 15:39:09 -0400
X-Greylist: delayed 5083 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 15:39:07 EDT
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AHvsKw022204;
        Tue, 10 Mar 2020 14:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=qoOEggxv7eMK/hYbpNs78wkoejPyvI7FJOGsE7klJ48=;
 b=HdiMZg3zsw41HJZ3EWF1Oo2zOxBprFp4cf1SR446FVV5M/GcuAJsy/TP1kyhCbSm2lXr
 VDXEGTOKt5p2lxgSGz3X8/9dALzxg9ZhWpFyiDbeQPiPh8U4AKmaXa83fN4PWM5/GeEJ
 o35rcHiPkxnSz2X6Ugkad/wRh53Ef7NsZKZZgye4+SR9frH/4BioHBqbpt/Endv4hM0N
 P8mqkKYRq5pxyTyh+47M70Rdw6d5k7UODsYR+zv60N18rJe1uXhtxAzM8uFFIV8cG1iW
 wD4csnUxqQUv7uw+zNl3/3bMMdX65ALZyFF9VY5vXmvAL0ZrgOQCGEmDLPfw2Tv9YLRz bQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2ym7trknc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 14:14:23 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AIAuOq031981;
        Tue, 10 Mar 2020 14:14:22 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2yp9jhew32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 14:14:22 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1534426643"
From:   <Austin.Bolen@dell.com>
To:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <helgaas@kernel.org>,
        <Austin.Bolen@dell.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ashok.raj@intel.com>
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Topic: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Index: AQHV9oVCCTYsDGOZY0iqPe3akO+s+A==
Date:   Tue, 10 Mar 2020 18:14:20 +0000
Message-ID: <0476c948e73f4c68a9bf221afccfcf7e@AUSX13MPC107.AMER.DELL.COM>
References: <20200310024017.GA231196@google.com>
 <de0cd5cc-9b59-882c-e40a-9bf00d20fbd4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_12:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100109
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100109
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> Hi Bjorn,=0A=
> =0A=
> On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:=0A=
>> [+cc Austin, tentative Linux patches on this git branch:=0A=
>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/dri=
vers/pci/pcie?h=3Dreview/edr]=0A=
>>=0A=
>> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@lin=
ux.intel.com wrote:=0A=
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.inte=
l.com>=0A=
>>>=0A=
>>> As per PCI firmware specification r3.2 System Firmware Intermediary=0A=
>>> (SFI) _OSC and DPC Updates ECR=0A=
>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC=
=0A=
>>> Event Handling Implementation Note", page 10, Error Disconnect Recover=
=0A=
>>> (EDR) support allows OS to handle error recovery and clearing Error=0A=
>>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()=
=0A=
>>> which allows clearing AER registers without FF mode checks.=0A=
>>=0A=
>> I see that this ECR was released as an ECN a few days ago:=0A=
>> https://members.pcisig.com/wg/PCI-SIG/document/14076=0A=
>> Regrettably the title in the PDF still says "ECR" (the rendered title=0A=
>> *page* says "ENGINEERING CHANGE NOTIFICATION", but some metadata=0A=
>> buried in the file says "ECR - SFI _OSC Support and DPC Updates".=0A=
=0A=
I'll see if PCI-SIG can update the metadata and repost.=0A=
=0A=
>>=0A=
>> Anyway, I think I see the note you refer to (now on page 12):=0A=
>>=0A=
>>     IMPLEMENTATION NOTE=0A=
>>     DPC Event Handling=0A=
>>=0A=
>>     The flow chart below documents the behavior when firmware maintains=
=0A=
>>     control of AER and DPC and grants control of PCIe Hot-Plug to the=0A=
>>     operating system.=0A=
>>=0A=
>>     ...=0A=
>>=0A=
>>     Capture and clear device AER status. OS may choose to offline=0A=
>>     devices3, either via SW (not load driver) or HW (power down device,=
=0A=
>>     disable Link5,6,7). Otherwise process _HPX, complete device=0A=
>>     enumeration, load drivers=0A=
>>=0A=
>> This clearly suggests that the OS should clear device AER status.=0A=
>> However, according to the intro text, firmware has retained control of=
=0A=
>> AER, so what gives the OS the right to clear AER status?=0A=
>>=0A=
>> The Downstream Port Containment Related Enhancements ECN (sec 4.5.1,=0A=
>> table 4-6) contains an exception that allows the OS to read/write=0A=
>> DPC registers during recovery.  But=0A=
>>=0A=
>>     - that is for *DPC* registers, not for AER registers, and=0A=
>>=0A=
>>     - that exception only applies between OS receipt of the EDR=0A=
>>       notification and OS release of DPC by clearing the DPC Trigger=0A=
>>       Status bit.=0A=
>>=0A=
>> The flowchart in the SFI ECN shows the OS releasing DPC before=0A=
>> clearing AER status:=0A=
>>=0A=
>>     - Receive EDR notification=0A=
>>=0A=
>>     - Cleanup - Notify and unload child drivers below Port=0A=
>>=0A=
>>     - Bring Port out of DPC, clear port error status, assign bus numbers=
=0A=
>>       to child devices.=0A=
>>=0A=
>>       I assume this box includes clearing DPC error status and clearing=
=0A=
>>       Trigger Status?  They seem to be out of order in the box.=0A=
=0A=
OS clears the DPC Trigger Status bit which will bring port below it out =0A=
of containment. Then OS will clear the "port" error status bits (i.e., =0A=
the AER and DPC status bits in the root port or downstream port that =0A=
triggered containment). I don't think it would hurt to do this two steps =
=0A=
in reverse order but don't think it is necessary. Note that error status =
=0A=
bits for devices below the port in containment are cleared later after =0A=
f/w has a chance to log them.=0A=
=0A=
>>=0A=
>>     - Evaluate _OST=0A=
>>=0A=
>>     - Capture and clear device AER status.=0A=
>>=0A=
>>       This seems suspect to me.  Where does it say the OS is allowed to=
=0A=
>>       write AER status when firmware retains control of AER?=0A=
>>=0A=
>> This patch series does things in this order:=0A=
>>=0A=
>>     - Receive EDR notification (edr_handle_event(), edr.c)=0A=
>>=0A=
>>     - Read, log, and clear DPC error regs (dpc_process_error(), dpc.c).=
=0A=
>>=0A=
>>       This also clears AER uncorrectable error status when the relevant=
=0A=
>>       HEST entries do not have the FIRMWARE_FIRST bit set.  I think this=
=0A=
>>       is incorrect: the test should be based the _OSC negotiation for=0A=
>>       AER ownership, not on the HEST entries.  But this problem=0A=
>>       pre-dates this patch series.=0A=
>>=0A=
>>     - Clear AER status (pci_aer_raw_clear_status(), aer.c).=0A=
>>=0A=
>>       This is at least inside the EDR recovery window, but again, I=0A=
>>       don't see where it says the OS is allowed to write the AER status.=
=0A=
> =0A=
> Implementation note is the only reference we have regarding clearing the=
=0A=
> AER registers.=0A=
> =0A=
> But since the spec says both DPC and AER needs to be always controlled=0A=
> together by the either OS or firmware, and when firmware relinquishes=0A=
> control over DPC registers in EDR notification window, we can assume=0A=
> that we also have control over AER registers.=0A=
> =0A=
> But I agree that is not explicitly spelled out any where outside the=0A=
> implementation note.=0A=
> =0A=
> =0A=
> Austin,=0A=
> =0A=
> May be ECN (section 4.5.1, table 4-6) needs to be updated to add this=0A=
> clarification.=0A=
=0A=
Sure we can update to section 4.5.1, table 4-6 to indicate when OS can =0A=
clear the AER status bits. It will just follow what's done in the =0A=
implementation note so I think it's acceptable to follow implementation =0A=
guidance for now.=0A=
=0A=
> =0A=
>>=0A=
>>     - Attempt recovery (pcie_do_recovery(), err.c)=0A=
>>=0A=
>>     - Clear DPC Trigger Status (dpc_reset_link(), dpc.c)=0A=
>>=0A=
>>     - Evaluate _OST (acpi_send_edr_status(), edr.c)=0A=
>>=0A=
>> What am I missing?=0A=
>>=0A=
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@l=
inux.intel.com>=0A=
>>> ---=0A=
>>>    drivers/pci/pci.h      |  2 ++=0A=
>>>    drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----=0A=
>>>    2 files changed, 20 insertions(+), 4 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h=0A=
>>> index e57e78b619f8..c239e6dd2542 100644=0A=
>>> --- a/drivers/pci/pci.h=0A=
>>> +++ b/drivers/pci/pci.h=0A=
>>> @@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_=
group;=0A=
>>>    void pci_aer_clear_fatal_status(struct pci_dev *dev);=0A=
>>>    void pci_aer_clear_device_status(struct pci_dev *dev);=0A=
>>>    int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);=0A=
>>> +int pci_aer_raw_clear_status(struct pci_dev *dev);=0A=
>>>    #else=0A=
>>>    static inline void pci_no_aer(void) { }=0A=
>>>    static inline void pci_aer_init(struct pci_dev *d) { }=0A=
>>> @@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs=
(struct pci_dev *dev)=0A=
>>>    {=0A=
>>>    	return -EINVAL;=0A=
>>>    }=0A=
>>> +int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }=
=0A=
>>>    #endif=0A=
>>>    =0A=
>>>    #ifdef CONFIG_ACPI=0A=
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c=0A=
>>> index c0540c3761dc..41afefa562b7 100644=0A=
>>> --- a/drivers/pci/pcie/aer.c=0A=
>>> +++ b/drivers/pci/pcie/aer.c=0A=
>>> @@ -420,7 +420,16 @@ void pci_aer_clear_fatal_status(struct pci_dev *de=
v)=0A=
>>>    		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);=
=0A=
>>>    }=0A=
>>>    =0A=
>>> -int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)=0A=
>>> +/**=0A=
>>> + * pci_aer_raw_clear_status - Clear AER error registers.=0A=
>>> + * @dev: the PCI device=0A=
>>> + *=0A=
>>> + * NOTE: Allows clearing error registers in both FF and=0A=
>>> + * non FF modes.=0A=
>>> + *=0A=
>>> + * Returns 0 on success, or negative on failure.=0A=
>>> + */=0A=
>>> +int pci_aer_raw_clear_status(struct pci_dev *dev)=0A=
>>>    {=0A=
>>>    	int pos;=0A=
>>>    	u32 status;=0A=
>>> @@ -433,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_de=
v *dev)=0A=
>>>    	if (!pos)=0A=
>>>    		return -EIO;=0A=
>>>    =0A=
>>> -	if (pcie_aer_get_firmware_first(dev))=0A=
>>> -		return -EIO;=0A=
>>> -=0A=
>>>    	port_type =3D pci_pcie_type(dev);=0A=
>>>    	if (port_type =3D=3D PCI_EXP_TYPE_ROOT_PORT) {=0A=
>>>    		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);=0A=
>>> @@ -451,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_d=
ev *dev)=0A=
>>>    	return 0;=0A=
>>>    }=0A=
>>>    =0A=
>>> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)=0A=
>>> +{=0A=
>>> +	if (pcie_aer_get_firmware_first(dev))=0A=
>>> +		return -EIO;=0A=
>>> +=0A=
>>> +	return pci_aer_raw_clear_status(dev);=0A=
>>> +}=0A=
>>> +=0A=
>>>    void pci_save_aer_state(struct pci_dev *dev)=0A=
>>>    {=0A=
>>>    	struct pci_cap_saved_state *save_state;=0A=
>>> -- =0A=
>>> 2.25.1=0A=
>>>=0A=
> =0A=
=0A=

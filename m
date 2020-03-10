Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225CD1808B3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 21:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCJUGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 16:06:25 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:44666 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgCJUGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2020 16:06:24 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AJvJtA018948;
        Tue, 10 Mar 2020 16:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=q8NFsq0BumiNBC6+W5xPurAXWd0/OXsfbmsEzeCMVf8=;
 b=YpNMmUnzpYPsl6fsrHNCg5rcE+RxY0sto9+ra4yzuh1Wr4VD+lwIzMXqMJFTKB1zZtKq
 sNCJIuU5p3g+xCgEHA6KbaIHBFW1Ozw8wXyL2SO28PmBEF0sbxtVFl6+TNJg0RFNKuJF
 QZ/bSBP0Kre22YQ9bq7oH8/vxcp4kpAIeV8yRIoAC9KJWCK0oiMQucyCBpjALqGWpy9F
 Zbck+LyxvT5tzQyTIeGuOwcb+V+BhqERSRRLZ09WQcwXPUs5VnXBZvlp8yWoZBwuSD9S
 GOGmtN/iuFUJ3KTjun0f7b3cwTo7mOj0lDDomC5mwetNGT0HrHCDB6ReveTLoD2OlcJt Ng== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2ym95vm07w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 16:06:23 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AK5AMo194010;
        Tue, 10 Mar 2020 16:06:23 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2yp9u285vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 16:06:22 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="922195689"
From:   <Austin.Bolen@dell.com>
To:     <helgaas@kernel.org>, <Austin.Bolen@dell.com>
CC:     <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ashok.raj@intel.com>
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Topic: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Index: AQHV9oVCCTYsDGOZY0iqPe3akO+s+A==
Date:   Tue, 10 Mar 2020 20:06:21 +0000
Message-ID: <38277b0f6c2e4c5d88e741b7354c72d1@AUSX13MPC107.AMER.DELL.COM>
References: <20200310193257.GA170043@google.com>
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
 definitions=2020-03-10_13:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003100118
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100117
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/10/2020 2:33 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Tue, Mar 10, 2020 at 06:14:20PM +0000, Austin.Bolen@dell.com wrote:=0A=
>> On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:=0A=
>>> On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:=0A=
>>>> [+cc Austin, tentative Linux patches on this git branch:=0A=
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/d=
rivers/pci/pcie?h=3Dreview/edr]=0A=
>>>>=0A=
>>>> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@l=
inux.intel.com wrote:=0A=
>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.in=
tel.com>=0A=
>>>>>=0A=
>>>>> As per PCI firmware specification r3.2 System Firmware Intermediary=
=0A=
>>>>> (SFI) _OSC and DPC Updates ECR=0A=
>>>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "D=
PC=0A=
>>>>> Event Handling Implementation Note", page 10, Error Disconnect Recove=
r=0A=
>>>>> (EDR) support allows OS to handle error recovery and clearing Error=
=0A=
>>>>> Registers even in FF mode. So create new API pci_aer_raw_clear_status=
()=0A=
>>>>> which allows clearing AER registers without FF mode checks.=0A=
>>>>=0A=
>>>> I see that this ECR was released as an ECN a few days ago:=0A=
>>>> https://members.pcisig.com/wg/PCI-SIG/document/14076=0A=
>>>> Regrettably the title in the PDF still says "ECR" (the rendered title=
=0A=
>>>> *page* says "ENGINEERING CHANGE NOTIFICATION", but some metadata=0A=
>>>> buried in the file says "ECR - SFI _OSC Support and DPC Updates".=0A=
>>=0A=
>> I'll see if PCI-SIG can update the metadata and repost.=0A=
> =0A=
> If that's possible, it would be nice to update the metadata for the=0A=
> "Downstream Port Containment related Enhancements" ECN as well.  That=0A=
> one currently says "ECR - CardBus Header Proposal", which means that's=0A=
> what's in the window title bar and icons in the panel.=0A=
=0A=
Sure, I'll check.=0A=
=0A=
> =0A=
>>>> Anyway, I think I see the note you refer to (now on page 12):=0A=
>>>>=0A=
>>>>      IMPLEMENTATION NOTE=0A=
>>>>      DPC Event Handling=0A=
>>>>=0A=
>>>>      The flow chart below documents the behavior when firmware maintai=
ns=0A=
>>>>      control of AER and DPC and grants control of PCIe Hot-Plug to the=
=0A=
>>>>      operating system.=0A=
>>>>=0A=
>>>>      ...=0A=
>>>>=0A=
>>>>      Capture and clear device AER status. OS may choose to offline=0A=
>>>>      devices3, either via SW (not load driver) or HW (power down devic=
e,=0A=
>>>>      disable Link5,6,7). Otherwise process _HPX, complete device=0A=
>>>>      enumeration, load drivers=0A=
>>>>=0A=
>>>> This clearly suggests that the OS should clear device AER status.=0A=
>>>> However, according to the intro text, firmware has retained control of=
=0A=
>>>> AER, so what gives the OS the right to clear AER status?=0A=
>>>>=0A=
>>>> The Downstream Port Containment Related Enhancements ECN (sec 4.5.1,=
=0A=
>>>> table 4-6) contains an exception that allows the OS to read/write=0A=
>>>> DPC registers during recovery.  But=0A=
>>>>=0A=
>>>>      - that is for *DPC* registers, not for AER registers, and=0A=
>>>>=0A=
>>>>      - that exception only applies between OS receipt of the EDR=0A=
>>>>        notification and OS release of DPC by clearing the DPC Trigger=
=0A=
>>>>        Status bit.=0A=
>>>>=0A=
>>>> The flowchart in the SFI ECN shows the OS releasing DPC before=0A=
>>>> clearing AER status:=0A=
>>>>=0A=
>>>>      - Receive EDR notification=0A=
>>>>=0A=
>>>>      - Cleanup - Notify and unload child drivers below Port=0A=
>>>>=0A=
>>>>      - Bring Port out of DPC, clear port error status, assign bus numb=
ers=0A=
>>>>        to child devices.=0A=
>>>>=0A=
>>>>        I assume this box includes clearing DPC error status and cleari=
ng=0A=
>>>>        Trigger Status?  They seem to be out of order in the box.=0A=
>>=0A=
>> OS clears the DPC Trigger Status bit which will bring port below it out=
=0A=
>> of containment. Then OS will clear the "port" error status bits (i.e.,=
=0A=
>> the AER and DPC status bits in the root port or downstream port that=0A=
>> triggered containment). I don't think it would hurt to do this two steps=
=0A=
>> in reverse order but don't think it is necessary. Note that error status=
=0A=
>> bits for devices below the port in containment are cleared later after=
=0A=
>> f/w has a chance to log them.=0A=
> =0A=
> Maybe I'm misreading the DPC enhancements ECN.  I think it says the OS=0A=
> can read/write DPC registers until it clears the DPC Trigger Status.=0A=
> If the OS clears Trigger Status first, my understanding is that we're=0A=
> now out of the EDR notification processing window and the OS is not=0A=
> permitted to write DPC registers.=0A=
> =0A=
> If it's OK for the OS to clear Trigger Status before clearing DPC=0A=
> error status, what is the event that determines when the OS may no=0A=
> longer read/write the DPC registers?=0A=
=0A=
I think there are a few different registers to consider... DPC Control, =0A=
DPC Status, various AER registers, and the RP PIO registers. At this =0A=
point in the flow, the firmware has already had a chance to read all of =0A=
them and so it really doesn't matter the order the OS does those two =0A=
things. The firmware isn't going to get notified again until _OST so by =0A=
then both operation will be done and system firmware will have no idea =0A=
which order the OS did them in, nor will it care.  But since the =0A=
existing normative text specifies and order, I would just follow that.=0A=
=0A=
> =0A=
>>>>      - Evaluate _OST=0A=
>>>>=0A=
>>>>      - Capture and clear device AER status.=0A=
>>>>=0A=
>>>>        This seems suspect to me.  Where does it say the OS is=0A=
>>>>        allowed to write AER status when firmware retains control=0A=
>>>>        of AER?=0A=
>>>>=0A=
>>>> This patch series does things in this order:=0A=
>>>>=0A=
>>>>      - Receive EDR notification (edr_handle_event(), edr.c)=0A=
>>>>=0A=
>>>>      - Read, log, and clear DPC error regs (dpc_process_error(),=0A=
>>>>        dpc.c).=0A=
>>>>=0A=
>>>>        This also clears AER uncorrectable error status when the=0A=
>>>>        relevant HEST entries do not have the FIRMWARE_FIRST bit=0A=
>>>>        set.  I think this is incorrect: the test should be based=0A=
>>>>        the _OSC negotiation for AER ownership, not on the HEST=0A=
>>>>        entries.  But this problem pre-dates this patch series.=0A=
>>>>=0A=
>>>>      - Clear AER status (pci_aer_raw_clear_status(), aer.c).=0A=
>>>>=0A=
>>>>        This is at least inside the EDR recovery window, but again,=0A=
>>>>        I don't see where it says the OS is allowed to write the=0A=
>>>>        AER status.=0A=
>>>=0A=
>>> Implementation note is the only reference we have regarding=0A=
>>> clearing the AER registers.=0A=
>>>=0A=
>>> But since the spec says both DPC and AER needs to be always=0A=
>>> controlled together by the either OS or firmware, and when=0A=
>>> firmware relinquishes control over DPC registers in EDR=0A=
>>> notification window, we can assume that we also have control over=0A=
>>> AER registers.=0A=
>>>=0A=
>>> But I agree that is not explicitly spelled out any where outside=0A=
>>> the implementation note.=0A=
> =0A=
> This is all quite unsatisfying since implementation notes are not=0A=
> normative.  I would far rather reference actual spec text.=0A=
=0A=
Yes, the change I mention below would be to add normative text.=0A=
=0A=
> =0A=
>>> Austin,=0A=
>>>=0A=
>>> May be ECN (section 4.5.1, table 4-6) needs to be updated to add=0A=
>>> this clarification.=0A=
>>=0A=
>> Sure we can update to section 4.5.1, table 4-6 to indicate when OS=0A=
>> can clear the AER status bits. It will just follow what's done in=0A=
>> the implementation note so I think it's acceptable to follow=0A=
>> implementation guidance for now.=0A=
> =0A=
> There are no events after the "clear device AER status" box.  That=0A=
> seems to mean the OS can write the AER status registers at any time.=0A=
> But the whole implementation note assumes firmware maintains control=0A=
> of AER.=0A=
> =0A=
=0A=
In this model the OS doesn't own DPC or AER but the model allows OS to =0A=
touch both DPC and AER registers at certain times.  I would view =0A=
ownership in this case as who is the primary owner and not who is the =0A=
sole entity allowed to access the registers.=0A=
=0A=
For the normative text describing when OS clears the AER bits following =0A=
the informative flow chart, it could say that OS clears AER as soon as =0A=
possible after OST returns and before OS processes _HPX and loading =0A=
drivers.  Open to other suggestions as well.=0A=
=0A=
>>>>      - Attempt recovery (pcie_do_recovery(), err.c)=0A=
>>>>=0A=
>>>>      - Clear DPC Trigger Status (dpc_reset_link(), dpc.c)=0A=
>>>>=0A=
>>>>      - Evaluate _OST (acpi_send_edr_status(), edr.c)=0A=
>>>>=0A=
>>>> What am I missing?=0A=
> =0A=
=0A=

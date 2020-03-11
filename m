Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECD181C2A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgCKPTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 11:19:54 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:38778 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729408AbgCKPTy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 11:19:54 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BF8ckx024167;
        Wed, 11 Mar 2020 11:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=idq+0kRj9Jozc1zHEbRneFjr+J7eDDDRBgrqvSAQg8M=;
 b=ueiRKikR9hQHVmK9fRyLDsJlkCOM2SVLSYkxkalBQy2TDCv+bwO4ZWLi/mVd+yO6p9Um
 K5Idsj+zFLNXweaPKOHLf58l7pAv0OG0PtgWoYsucqa1l31GAwfyuqnvHK/jmSoMPV7W
 YuYpAZxgflHya7ChXcMEjUwpOiPBFArmUXsJHe2nAlHCmP9E2xv8NfFBiJK58dZd22z0
 jLUmW4m+yNuReEm9DzAwg+9/DlU/mpZO8NjWnE2xHOVkCzmorG2E3mhwqDi/t4ubNEG1
 27W1GB+ZkNeUHKwNSx7qalzWMcbNAI7C/4VcTIIbFW8s51nJasHEmm/B7N3/e+09N85S eA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ypk0jbv1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 11:19:53 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BF9URF052328;
        Wed, 11 Mar 2020 11:19:53 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2ypk14cktk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 11:19:53 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1534730440"
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
Date:   Wed, 11 Mar 2020 15:19:44 +0000
Message-ID: <0890801daa6c4564bca1690fd8439dab@AUSX13MPC107.AMER.DELL.COM>
References: <20200311144556.GA208157@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_05:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110097
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110097
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/11/2020 9:46 AM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Tue, Mar 10, 2020 at 08:06:21PM +0000, Austin.Bolen@dell.com wrote:=0A=
>> On 3/10/2020 2:33 PM, Bjorn Helgaas wrote:=0A=
>>> On Tue, Mar 10, 2020 at 06:14:20PM +0000, Austin.Bolen@dell.com wrote:=
=0A=
>>>> On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:=0A=
>>>>> On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:=0A=
>>>>>> [+cc Austin, tentative Linux patches on this git branch:=0A=
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree=
/drivers/pci/pcie?h=3Dreview/edr]=0A=
>>>>>>=0A=
>>>>>> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy=
@linux.intel.com wrote:=0A=
>>>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>=0A=
>>>>>>>=0A=
>>>>>>> As per PCI firmware specification r3.2 System Firmware Intermediary=
=0A=
>>>>>>> (SFI) _OSC and DPC Updates ECR=0A=
>>>>>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled =
"DPC=0A=
>>>>>>> Event Handling Implementation Note", page 10, Error Disconnect Reco=
ver=0A=
>>>>>>> (EDR) support allows OS to handle error recovery and clearing Error=
=0A=
>>>>>>> Registers even in FF mode. So create new API pci_aer_raw_clear_stat=
us()=0A=
>>>>>>> which allows clearing AER registers without FF mode checks.=0A=
> =0A=
>>>> OS clears the DPC Trigger Status bit which will bring port below it ou=
t=0A=
>>>> of containment. Then OS will clear the "port" error status bits (i.e.,=
=0A=
>>>> the AER and DPC status bits in the root port or downstream port that=
=0A=
>>>> triggered containment). I don't think it would hurt to do this two ste=
ps=0A=
>>>> in reverse order but don't think it is necessary.=0A=
> =0A=
>>>> Note that error status bits for devices below the port in=0A=
>>>> containment are cleared later after f/w has a chance to log them.=0A=
> =0A=
> Thanks for pointing out this wrinkle about devices below the port in=0A=
> containment.  I think we might have an issue here with the current=0A=
> series because evaluating _OST is the last thing the EDR notify=0A=
> handler does.  More below.=0A=
> =0A=
>>> Maybe I'm misreading the DPC enhancements ECN.  I think it says the OS=
=0A=
>>> can read/write DPC registers until it clears the DPC Trigger Status.=0A=
>>> If the OS clears Trigger Status first, my understanding is that we're=
=0A=
>>> now out of the EDR notification processing window and the OS is not=0A=
>>> permitted to write DPC registers.=0A=
>>>=0A=
>>> If it's OK for the OS to clear Trigger Status before clearing DPC=0A=
>>> error status, what is the event that determines when the OS may no=0A=
>>> longer read/write the DPC registers?=0A=
>>=0A=
>> I think there are a few different registers to consider... DPC=0A=
>> Control, DPC Status, various AER registers, and the RP PIO=0A=
>> registers. At this point in the flow, the firmware has already had a=0A=
>> chance to read all of them and so it really doesn't matter the order=0A=
>> the OS does those two things. The firmware isn't going to get=0A=
>> notified again until _OST so by then both operation will be done and=0A=
>> system firmware will have no idea which order the OS did them in,=0A=
>> nor will it care.  But since the existing normative text specifies=0A=
>> and order, I would just follow that.=0A=
> =0A=
> OK, this series clears DPC error status before clearing DPC Trigger=0A=
> Status, so I think we can keep that as-is.=0A=
> =0A=
>>> There are no events after the "clear device AER status" box.  That=0A=
>>> seems to mean the OS can write the AER status registers at any=0A=
>>> time.  But the whole implementation note assumes firmware=0A=
>>> maintains control of AER.=0A=
>>=0A=
>> In this model the OS doesn't own DPC or AER but the model allows OS=0A=
>> to touch both DPC and AER registers at certain times.  I would view=0A=
>> ownership in this case as who is the primary owner and not who is=0A=
>> the sole entity allowed to access the registers.=0A=
> =0A=
> I'm not sure how to translate the idea of primary ownership into code.=0A=
=0A=
I would just add text that said when it's ok for OS to touch these bits =0A=
even when they don't own them similar to what's done for the DPC bits.=0A=
=0A=
> =0A=
>> For the normative text describing when OS clears the AER bits=0A=
>> following the informative flow chart, it could say that OS clears=0A=
>> AER as soon as possible after OST returns and before OS processes=0A=
>> _HPX and loading drivers.  Open to other suggestions as well.=0A=
> =0A=
> I'm not sure what to do with "as soon as possible" either.  That=0A=
> doesn't seem like something firmware and the OS can agree on.=0A=
> =0A=
=0A=
I can just state that it's done after OST returns but before _HPX or =0A=
driver is loaded. Any time in that range is fine. I can't get super =0A=
specific here because different OSes do different things.  Even for a =0A=
given OS they change over time. And I need something generic enough to =0A=
support a wide variety of OS implementations.=0A=
=0A=
> For the port that triggered DPC containment, I think the easiest thing=0A=
> to understand and implement would be to allow AER access during the=0A=
> same EDR processing window where DPC access is allowed.=0A=
Agreed.=0A=
=0A=
> =0A=
> For child devices of that port, obviously it's impossible to access=0A=
> AER registers until DPC Trigger Status is cleared, and the flowchart=0A=
> says the OS shouldn't access them until after _OST.=0A=
> =0A=
> I'm actually not sure we currently do *anything* with child device AER=0A=
> info in the EDR path.  pcie_do_recovery() does walk the sub-hierarchy=0A=
> of child devices, but it only calls error handling callbacks in the=0A=
> child drivers; it doesn't do anything with the child AER registers=0A=
> itself.  And of course, this happens before _OST, so it would be too=0A=
> early in any case.  But maybe I'm missing something here.=0A=
=0A=
My understanding is that the OS read/clears AER in the case where OS has =
=0A=
native control of AER.  Feedback from OSVs is they wanted to continue to =
=0A=
do that to keep the native OS controlled AER and FF mechanism similar. =0A=
The other way we could have done it would be to have the firmware =0A=
read/clear AER and report them to OS via APEI.=0A=
=0A=
> =0A=
> BTW, if/when this is updated, I have another question: the _OSC DPC=0A=
> control bit currently allows the OS to write DPC Control during that=0A=
> window.  I understand the OS writing the RW1C *Status* bits to clear=0A=
> them, but it seems like writing the DPC Control register is likely to=0A=
> cause issues.  The same question would apply to the AER access we're=0A=
> talking about.=0A=
=0A=
We could specify which particular bits can and can't be touched.  But =0A=
it's hard to maintain as new bits are added.  Probably better to add =0A=
some guidance that OS should read/clear error status, DPC Trigger =0A=
Status, etc. but shouldn't change masks/severity/control bits/etc.=0A=
=0A=
> =0A=
> Bjorn=0A=
> =0A=
=0A=

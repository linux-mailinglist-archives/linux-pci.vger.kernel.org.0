Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4B181F69
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgCKR1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 13:27:39 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:58938 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730201AbgCKR1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 13:27:39 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BHMTsN018938;
        Wed, 11 Mar 2020 13:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=/ll3Ds4Z1oJFCKk9QDNg57mU56GcgUtNxcS/uh64Slg=;
 b=eDf/BVLa4Tjc0OAbVqXv1WlJbZOBaztDszUqTrrh0SxG5rn3tdeJZXEj/2xsv0vTaX/B
 2wpA8+AdRnOAQH2BEBjVDuNKPl2yp4s6ioW3G5fCisvDxR1oId3x6boaPxQKkcvP4ov2
 UoRI5AA2CJqqEWJmjuDtgbC88sAdxVS46kKpAyzbrf1PqjCQCj8gdVIvtUJ7u/JBzxD2
 Uqs0hcC0He3McsmTKCUABKNR0T5dWIILZD5q9hfzE9Nppio+cKo34k5FmD/WG3FpmiSk
 V5bWYqGJB+b2laGCvKCQYtDNh1OT/ItAeBmmusALLz09F2FSZnaQuexOkjXbecFKZ0u/ Nw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2ypk294eac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 13:27:38 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BHAgZn084118;
        Wed, 11 Mar 2020 13:27:37 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2ypk1s6pwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 13:27:37 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="528498970"
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
Date:   Wed, 11 Mar 2020 17:27:35 +0000
Message-ID: <7b8d47f9180e43a7bdb01f9d8754c9f6@AUSX13MPC107.AMER.DELL.COM>
References: <20200311171203.GA137848@google.com>
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
 definitions=2020-03-11_07:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003110101
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110101
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/11/2020 12:12 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
<SNIP>=0A=
> =0A=
> I'm probably missing your intent, but that sounds like "the OS can=0A=
> read/write AER bits whenever it wants, regardless of ownership."=0A=
> =0A=
> That doesn't sound practical to me, and I don't think it's really=0A=
> similar to DPC, where it's pretty clear that the OS can touch DPC bits=0A=
> it doesn't own but only *during the EDR processing window*.=0A=
=0A=
Yes, by treating AER bits like DPC bits I meant I'd define the specific =0A=
time windows when OS can touch the AER status bits similar to how it's =0A=
done for DPC in the current ECN.=0A=
=0A=
> =0A=
>>>> For the normative text describing when OS clears the AER bits=0A=
>>>> following the informative flow chart, it could say that OS clears=0A=
>>>> AER as soon as possible after OST returns and before OS processes=0A=
>>>> _HPX and loading drivers.  Open to other suggestions as well.=0A=
>>>=0A=
>>> I'm not sure what to do with "as soon as possible" either.  That=0A=
>>> doesn't seem like something firmware and the OS can agree on.=0A=
>>=0A=
>> I can just state that it's done after OST returns but before _HPX or=0A=
>> driver is loaded. Any time in that range is fine. I can't get super=0A=
>> specific here because different OSes do different things.  Even for=0A=
>> a given OS they change over time. And I need something generic=0A=
>> enough to support a wide variety of OS implementations.=0A=
> =0A=
> Yeah.  I don't know how to solve this.=0A=
> =0A=
> Linux doesn't actually unload and reload drivers for the child devices=0A=
> (Sathy, correct me if I'm wrong here) even though DPC containment=0A=
> takes the link down and effectively unplugs and replugs the device.  I=0A=
> would *like* to handle it like hotplug, but some higher-level software=0A=
> doesn't deal well with things like storage devices disappearing and=0A=
> reappearing.=0A=
> =0A=
> Since Linux doesn't actually re-enumerate the child devices, it=0A=
> wouldn't evaluate _HPX again.  It would probably be cleaner if it did,=0A=
> but it's all tied up with the whole unplug/replug problem.=0A=
=0A=
DPC resets everything below it and so to get it back up and running it =0A=
would mean that all buses and resources need to be assigned, _HPX =0A=
evaluated, and drivers reloaded. If those things don't happen then the =0A=
whole hierarchy below the port that triggered DPC will be inaccessible.=0A=
=0A=
For higher level software not handling storage device disappearing due =0A=
to hot-plug, they will have the same problem with DPC since DPC holds =0A=
the port in the disabled state (and hence will be inaccessible). And =0A=
once DPC is released the devices will be unconfigured and so still =0A=
inaccessible to upper-level software.  A lot of upper-level storage =0A=
software I've seen can already handle this gracefully.=0A=
=0A=
> =0A=
>>> For child devices of that port, obviously it's impossible to=0A=
>>> access AER registers until DPC Trigger Status is cleared, and the=0A=
>>> flowchart says the OS shouldn't access them until after _OST.=0A=
>>>=0A=
>>> I'm actually not sure we currently do *anything* with child device=0A=
>>> AER info in the EDR path.  pcie_do_recovery() does walk the=0A=
>>> sub-hierarchy of child devices, but it only calls error handling=0A=
>>> callbacks in the child drivers; it doesn't do anything with the=0A=
>>> child AER registers itself.  And of course, this happens before=0A=
>>> _OST, so it would be too early in any case.  But maybe I'm missing=0A=
>>> something here.=0A=
>>=0A=
>> My understanding is that the OS read/clears AER in the case where OS=0A=
>> has native control of AER.  Feedback from OSVs is they wanted to=0A=
>> continue to do that to keep the native OS controlled AER and FF=0A=
>> mechanism similar.  The other way we could have done it would be to=0A=
>> have the firmware read/clear AER and report them to OS via APEI.=0A=
> =0A=
> When Linux has native control of AER, it reads/clears AER status.=0A=
> The flowchart is for the case where firmware has AER control, so I=0A=
> guess Linux would not field AER interrupts and wouldn't expect to=0A=
> read/clear AER status.  So I *guess* Linux would assume APEI?  But=0A=
> that doesn't seem to be what the flowchart assumes.=0A=
=0A=
Correct on the flowchart.  The OSVs we talked with did not want to use =0A=
APEI.  They wanted to read and clear AER themselves and hence the =0A=
flowchart is written that way.=0A=
=0A=
> =0A=
>>> BTW, if/when this is updated, I have another question: the _OSC=0A=
>>> DPC control bit currently allows the OS to write DPC Control=0A=
>>> during that window.  I understand the OS writing the RW1C *Status*=0A=
>>> bits to clear them, but it seems like writing the DPC Control=0A=
>>> register is likely to cause issues.  The same question would apply=0A=
>>> to the AER access we're talking about.=0A=
>>=0A=
>> We could specify which particular bits can and can't be touched.=0A=
>> But it's hard to maintain as new bits are added.  Probably better to=0A=
>> add some guidance that OS should read/clear error status, DPC=0A=
>> Trigger Status, etc. but shouldn't change masks/severity/control=0A=
>> bits/etc.=0A=
> =0A=
> Yeah.  I didn't mean at the level of individual bits; I was thinking=0A=
> more of status/log/etc vs control registers.  But maybe even that is=0A=
> hard, I dunno.=0A=
> =0A=
I'll see if I can break it out by register.=0A=
=0A=

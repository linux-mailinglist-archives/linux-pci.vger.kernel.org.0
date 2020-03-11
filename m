Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77AF182440
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgCKVxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 17:53:34 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:2290 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729328AbgCKVxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 17:53:34 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BLqfDb012424;
        Wed, 11 Mar 2020 17:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JqIvNefucxmnjRxRtdojHg0NXnSD/09pQnw/ebyuI+Y=;
 b=k3zJpp01aHaC4N++32xd9HY8diy0f7Z9TOjeQYZJRW0zrZimJ/tcABJyJkTm4WwCy0M+
 a77PwglFW9Nac6Fkur/n20pgQfJ9s1GS3xQBiteQmRQtEWhMA0jBqBPjh+kb8FSUhY1J
 ABRLsLVam1o4xl43YnFobQ5vBMPFbiOfz+bFshsXOTMuotSQO7/EWZm6JHJVhQJboeC0
 JfQDQtMFC3cJV1DAwG9XnAa00NYDu387DjjNfIck7nGRfy06PiCPzm9sfJFKbt+m1wVv
 ByVkJq6r9mvfAmnWja/2rz+S4frKmoLqyJX0C3JqYu2Yj/HUSez4ofp4XM2NHQlQmmWj 8Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ypjykdptw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 17:53:33 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BLmJxQ180633;
        Wed, 11 Mar 2020 17:53:33 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2ypk0e26cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 17:53:32 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1366619265"
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
Date:   Wed, 11 Mar 2020 21:53:30 +0000
Message-ID: <868a9cc8b34f428e8f59c1b0213131d7@AUSX13MPC107.AMER.DELL.COM>
References: <20200311203326.GA163074@google.com>
 <ddf5d142-09e7-67ee-16e4-37447df6b112@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_11:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110121
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110121
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/11/2020 4:27 PM, Kuppuswamy Sathyanarayanan wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> Hi,=0A=
> =0A=
> On 3/11/20 1:33 PM, Bjorn Helgaas wrote:=0A=
>> On Wed, Mar 11, 2020 at 05:27:35PM +0000, Austin.Bolen@dell.com wrote:=
=0A=
>>> On 3/11/2020 12:12 PM, Bjorn Helgaas wrote:=0A=
>>>> [EXTERNAL EMAIL]=0A=
>>>>=0A=
>>> <SNIP>=0A=
>>>> I'm probably missing your intent, but that sounds like "the OS can=0A=
>>>> read/write AER bits whenever it wants, regardless of ownership."=0A=
>>>>=0A=
>>>> That doesn't sound practical to me, and I don't think it's really=0A=
>>>> similar to DPC, where it's pretty clear that the OS can touch DPC bits=
=0A=
>>>> it doesn't own but only *during the EDR processing window*.=0A=
>>> Yes, by treating AER bits like DPC bits I meant I'd define the specific=
=0A=
>>> time windows when OS can touch the AER status bits similar to how it's=
=0A=
>>> done for DPC in the current ECN.=0A=
>> Makes sense, thanks.=0A=
>>=0A=
>>>>>>> For the normative text describing when OS clears the AER bits=0A=
>>>>>>> following the informative flow chart, it could say that OS clears=
=0A=
>>>>>>> AER as soon as possible after OST returns and before OS processes=
=0A=
>>>>>>> _HPX and loading drivers.  Open to other suggestions as well.=0A=
>>>>>> I'm not sure what to do with "as soon as possible" either.  That=0A=
>>>>>> doesn't seem like something firmware and the OS can agree on.=0A=
>>>>> I can just state that it's done after OST returns but before _HPX or=
=0A=
>>>>> driver is loaded. Any time in that range is fine. I can't get super=
=0A=
>>>>> specific here because different OSes do different things.  Even for=
=0A=
>>>>> a given OS they change over time. And I need something generic=0A=
>>>>> enough to support a wide variety of OS implementations.=0A=
>>>> Yeah.  I don't know how to solve this.=0A=
>>>>=0A=
>>>> Linux doesn't actually unload and reload drivers for the child devices=
=0A=
>>>> (Sathy, correct me if I'm wrong here) even though DPC containment=0A=
>>>> takes the link down and effectively unplugs and replugs the device.  I=
=0A=
>>>> would *like* to handle it like hotplug, but some higher-level software=
=0A=
>>>> doesn't deal well with things like storage devices disappearing and=0A=
>>>> reappearing.=0A=
>>>>=0A=
>>>> Since Linux doesn't actually re-enumerate the child devices, it=0A=
>>>> wouldn't evaluate _HPX again.  It would probably be cleaner if it did,=
=0A=
>>>> but it's all tied up with the whole unplug/replug problem.=0A=
>>> DPC resets everything below it and so to get it back up and running it=
=0A=
>>> would mean that all buses and resources need to be assigned, _HPX=0A=
>>> evaluated, and drivers reloaded. If those things don't happen then the=
=0A=
>>> whole hierarchy below the port that triggered DPC will be inaccessible.=
=0A=
>> Hmm, I think I might be confusing this with another situation.  Sathy,=
=0A=
>> can you help me understand this?  I don't have a way to actually=0A=
>> exercise this EDR path.  Is there some way the pciehp hotplug driver=0A=
>> gets involved here?=0A=
=0A=
If the port has hot-plug enabled then DPC trigger will cause the link to =
=0A=
go down (disabled state) and will generate a DLLSC hot-plug interrupt. =0A=
When DPC is released, the link will become active and generate another =0A=
DLLSC hot-plug interrupt.=0A=
=0A=
>>=0A=
>> Here's how this seems to work as far as I can tell:=0A=
>>=0A=
>>     - Linux does not have DPC or AER control=0A=
>>=0A=
>>     - Linux installs EDR notify handler=0A=
>>=0A=
>>     - Linux evaluates DPC Enable _DSM=0A=
>>=0A=
>>     - DPC containment event occurs=0A=
>>=0A=
>>     - Firmware fields DPC interrupt=0A=
>>=0A=
>>     - DPC event is not a surprise remove=0A=
>>=0A=
>>     - Firmware sends EDR notification=0A=
>>=0A=
>>     - Linux EDR notify handler evaluates Locate _DSM=0A=
>>=0A=
>>     - Linux reads and logs DPC and AER error information for port in=0A=
>>       containment mode.  [If it was an RP PIO error, Linux clears RP PIO=
=0A=
>>       error status, which is an asymmetry with the non-RP PIO path.]=0A=
>>=0A=
>>     - Linux clears AER error status (pci_aer_raw_clear_status())=0A=
>>=0A=
>>     - Linux calls driver .error_detected() methods for all child devices=
=0A=
>>       of the port in containment mode (pcie_do_recovery()).  These=0A=
>>       devices are inaccessible because the link is down.=0A=
>>=0A=
>>     - Linux clears DPC Trigger Status (dpc_reset_link() from=0A=
>>       pcie_do_recovery()).=0A=
>>=0A=
>>     - Linux calls driver .mmio_enabled() methods for all child devices.=
=0A=
>>=0A=
>> This is where I get lost.  These child devices are now accessible, but=
=0A=
>> they've been reset, so I don't know how their config space got=0A=
>> restored.  Did pciehp enumerate them?  Did we do something like=0A=
>> pci_restore_state()?  I don't see where either of these happens.=0A=
> AFAIK, AER error status registers=A0 are sticky (RW1CS) and hence=0A=
> will be preserved during reset.=0A=
=0A=
In our testing, the device directly connected to the port that was =0A=
contained does get reprogrammed and the driver is reloaded.  These are =0A=
hot-plug slots and so might be due to DLLSC hot-plug interrupt when =0A=
containment is released and link goes back to active state.=0A=
=0A=
However, if a switch is connected to the port where DPC was triggered =0A=
then we do not see the whole switch hierarchy being re-enumerated.=0A=
=0A=
Also, DPC could be enabled on non-hot-plug slots so can't always rely on =
=0A=
hot-plug to re-init devices in the recovery path.=0A=
=0A=
>>=0A=
>> So they want to basically do native AER handling even though firmware=0A=
>> owns AER?  My head hurts.=0A=
> No, Its meant only for clearing AER registers. In EDR path, since=0A=
> OS owns clearing DPC registers, they want to let OS own clearing AER=0A=
> registers as well. Also,=A0 it would give OS a chance to decide whether=
=0A=
> we want to keep the device on based on error status and history of the=0A=
> device attached.=0A=
=0A=
Right.  The way it was pitched to me was that the OSVs wanted to =0A=
read/clear the error status bits so they could re-use the code that does =
=0A=
that when OS natively owns AER/DPC.=0A=
=0A=
>>=0A=
>> Bjorn=0A=
> =0A=
=0A=

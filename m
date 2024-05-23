Return-Path: <linux-pci+bounces-7783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2729A8CD637
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 16:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92A2839F3
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB279D2;
	Thu, 23 May 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JP6gCcA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52E5680;
	Thu, 23 May 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475973; cv=none; b=uP05lV/hk22aNXt229EXefYOJjPuQyq2G+2edmMlpypgg2X0HWTH00SZi1mhPuAijzvce7diItk60y/YnCYY11loHGvjL3MD7lkQCc1sBcb8XZHgcu2GQH4BMhJ5WRMjlSxXcS2XuAmvw/LZY13a39AFeHaFV72qIg+ZShlre3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475973; c=relaxed/simple;
	bh=ZIEEGARke47aoEBrCJS7qGYhBQ56bLVDblXUD8kYmCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsTF1zhuOc2GCQMsKPL9reEDg0nTvTjr3TDwJEWekn1rBhFBZHa4MoCGDt11YPrVhVvdx73YGiy0IlFUkclGgWwacY2zNZ7/b2Y7jcFku0wchI7ZJOHDBK03FqQNjzGI8SO1UnWdT/pOGfF5OEmw1yRxUIgbdZ9+3f8JhqqPz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JP6gCcA7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEl5Zr032741;
	Thu, 23 May 2024 14:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5LRyyaNPc4FhhYm3hhzL0Pb1Ayr+g8Z4wyngarDR8Z4=;
 b=JP6gCcA78NyTo8Yj0Lqf1mYrUEzdR35d2A8D7U3BdR32VY6n2ZJ7lzy6m2hdMUPefhg1
 7Q2sT6wz6qj0OtDjF3BfCSIt02rtNFSFsCfdLTs24+fjL8/vSu80V85YekJpm3pJ5pwu
 Oolm+gx9gclSFcA0yw8ffbv2EBdvZ5ywmtrTyl7pDL4IOslqKEpkLTNg6Pnsc3UeRcst
 arGqVZC+CzL18nSUOPcHyXGhtfMFWUhxDVqJVRf61/oUKqjw+5/89uk+SpqXTvXzJiRF
 qhNnatKTJrDNwdmG0OeGPf6cOC19hQBrxDw9TQ5oIKljL6k/aCaE7JxYVEV2QWpoizwD Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya7v200pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 14:52:42 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44NEprDr010605;
	Thu, 23 May 2024 14:52:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya7v200pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 14:52:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44NCZ0XF008232;
	Thu, 23 May 2024 14:52:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vma6m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 14:52:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44NEqZZo33620468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 14:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C2F820043;
	Thu, 23 May 2024 14:52:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C72D620040;
	Thu, 23 May 2024 14:52:32 +0000 (GMT)
Received: from [9.109.241.85] (unknown [9.109.241.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 May 2024 14:52:32 +0000 (GMT)
Message-ID: <66572ca5-88aa-4495-b926-5a3bfe6ae1da@ibm.com>
Date: Thu, 23 May 2024 20:22:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc: hotplug driver bridge support
To: "Oliver O'Halloran" <oohall@gmail.com>,
        krishna kumar <krishnak@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, mahesh@linux.ibm.com,
        Gaurav Batra <gbatra@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20240514135303.176134-1-krishnak@linux.ibm.com>
 <20240514135303.176134-3-krishnak@linux.ibm.com>
 <CAOSf1CFDCTMdmrjoSRdP09rJgtzPVDnCPXpfS-S+J7XKHzKRCw@mail.gmail.com>
 <fd0e22ab-5998-4b57-828e-224dda6bf490@linux.ibm.com>
 <CAOSf1CE2r4Gju-BkGVzuAyWoiFZ+9csNMj=v+KkQMmixUAHH6w@mail.gmail.com>
Content-Language: en-US
From: Krishna Kumar <krishna.kumar11@ibm.com>
In-Reply-To: <CAOSf1CE2r4Gju-BkGVzuAyWoiFZ+9csNMj=v+KkQMmixUAHH6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5k4wRxPes8Wf8c6zJOdf2T8XZG5UC5so
X-Proofpoint-GUID: RJ1x57we6IDc0sXP4XVbIZ9TyJIwS285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230102



Hi Oliver,

Thanks for your suggestions. Pls find my response:

On 5/20/24 20:29, Oliver O'Halloran wrote:
> On Fri, May 17, 2024 at 9:15 PM krishna kumar <krishnak@linux.ibm.com> wrote:
>>> Uh, if I'm reading this right it looks like your "slot" C5 is actually
>>> the PCIe switch's internal bus which is definitely not hot pluggable.
>> It's a hotplug slot. Please see the snippet below:
>>
>> :~$ sudo lspci -vvv -s 0004:02:00.0 | grep --color HotPlug
>>           SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise-
>> :~$
>>
>> :~$ sudo lspci -vvv -s 0004:02:01.0 | grep --color HotPlug
>>          SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise-
>> :~$
>>
>> :~$ sudo lspci -vvv -s 0004:02:02.0 | grep --color HotPlug
>>          SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise-
>> :~$
>>
>> :~$ sudo lspci -vvv -s 0004:02:03.0 | grep --color HotPlug
>>          SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise-
>> :~$
> All this is showing is that the switch downstream ports on bus 0004:02
> have a slot capability. I already know that (see what I said
> previously about physical links). The fact the downstream ports have a
> slot capability also has absolutely nothing to do with anything I was
> saying. Look at the lspci output for 0004:01:00.0 which is the
> switch's upstream port. The upstream port device will not have a slot
> capability because it's a bridge into the virtual PCI bus that is
> internal to the switch.

Let me try to understand your suggestion and what needs to be done now:

lspci -nn snippet in current scenario:

0004:01:00.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
0004:01:00.1 Memory controller [0580]: PMC-Sierra Inc. Device [11f8:4052]
0004:02:00.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
0004:02:01.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
0004:02:02.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
0004:02:03.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]

lspci -tv snippet in current scenario:

+-[0001:00]---00.0-[01-0a]--+-00.0-[02-0a]--+-00.0-[03-07]--
  |                           |               +-01.0-[08]--+-00.0  Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe
  |                           |               |            +-00.1  Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe
  |                           |               |            +-00.2  Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe
  |                           |               |            \-00.3  Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe
  |                           |               +-02.0-[09]----00.0  Broadcom / LSI SAS3216 PCI-Express Fusion-MPT SAS-3
  |                           |               \-03.0-[0a]----00.0  IBM PCI-E IPR SAS Adapter (ASIC)
  |                           \-00.1  PMC-Sierra Inc. Device 4052

C5 bus address:

[root@ltczzess2-lp1 ~]# cat /sys/bus/pci/slots/C5/address
0004:02:00
[root@ltczzess2-lp1 ~]#

0004:01:00.0 doesn't have hotplug capability but 0004:02:00.0 does
have this capability. Below snippet tells about this:

[root@ltczzess2-lp1 ~]# sudo lspci -vvv -s 0004:01:00.0 | grep --color HotPlug
[root@ltczzess2-lp1 ~]#
[root@ltczzess2-lp1 ~]# sudo lspci -vvv -s 0004:02:00.0 | grep --color HotPlug
         SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise-
[root@ltczzess2-lp1 ~]#

In Function -  pnv_php_register_one() is responsible for slot creation from
hotplug capable device node:

Below is the current code that does check the device node for hot plug
capability and takes the decision

  /* Check if it's hotpluggable slot */
         ret = of_property_read_u32(dn, "ibm,slot-pluggable", &prop32);
         if (ret || !prop32){
                 return -ENXIO;
         }

Its obvious that 0004:01:00.0 does not get above criteria fulfilled but
0004:02:00.0 does, so is the current behavior (Upstream port is not became
C5 slot but downstream port became C5 slot).

I am summarizing your suggested changes. Please let
me know if I've got it right:

1. Do you want me to modify the code so that the C5
device-bdf and bus-address become 0004:01:00/0004:01
instead of 0004:02:00/0004:01?

2. When performing a hot-unplug operation on C5,
should all devices from 0004:01 be removed? And
should all devices from 0004:02 also be removed?
I think the answer is yes, but please confirm.

3. When performing a hot-plug operation on C5,
should all the devices removed earlier from 0004:01
  and 0004:02 be re-attached?

4. Will there be any PCIe topology changes in this workflow?

Once you confirm the above requirements, we can discuss
how to proceed further.
I have some follow up questions from your last mail and I am
putting these questions in below paragraphs as inline statements.
It will confirm me if we should do above things or not.


>> It seems like your explanation about the missing 0004:01:00.0 may be
>> correct and could be due to a firmware bug. However, the scope of this
>> patch does not relate to this issue. Additionally, if it starts with
>> 0004:01:00.0 to 0004:01:03.0, the behavior of hot-unplug and hot-plug
>> operations will remain inconsistent. This patch aims to address the
>> inconsistent behavior of hot-unplug and hot-plug.
>>
>> *snip*
>>
>>> It might be worth adding some logic to pnv_php to verify the PCI
>>> bridge upstream of the slot actually has the PCIe slot capability to
>>> guard against this problem.
>> We can have a look at this problem in another patch.
> The point of this series is to fix the behaviour of pnv_php, is it
> not?

Yes and we will do necessary things.

> Powering off a PCI(e) slot is supposed to render it safe to
> remove the card  in that slot.

Do you mean physical-removal of the device after power-off ?

>   Currently if you "power off" C5, the
> kernel is still going to have active references to the switch's
> upstream port device (at 0004:01:00.0) and the switch management
> function (at 0004:01:00.1).

Yes, since we are only operating on the downstream port of C5,
upstream ports' reference to the kernel will remain the same.

> If the kernel has active references to PCI
> devices physically located in the slot we supposedly powered off, then
> the hotplug driver isn't doing its job.

We have only powered off the downstream ports, not the upstream port.
The upstream port will remain powered on. Do you mean to say that it
will cause a problem if we physically remove the device while the
upstream port is powered on and the downstream port is powered off?
Will it cause a kernel crash? Is this the reason for designating the
upstream port as a C5 slot and performing a hot-plug operation on it?
Is it correct to select a device port that is not hot-pluggable,
designate it as a C5 slot, and perform a hot-plug operation on it?


> The asymmetry between hot add
> and removal that you're trying to fix here is a side effect of the
> fact that pnv_php is advertising the wrong thing as a slot.

Pnv-php is displaying the information, what it receives from the
device node property. We will attempt to modify the code
path that is responsible for this. I am not sure yet what
additional code is needed for this, but I will figure it
out. Is it okay to change this code?

>   I think
> you should stop pnv_php from advertising something as a slot when it's
> not actually a slot because that's the root of all your problems.

Okay, I am aligned but need some more clarification. Currently,
we are observing this behavior with the PMC-Sierra bridge.
Will this behavior occur with all bridges? In other words,
will the upstream port capability not be hot-pluggable for
all bridges and switches, and therefore not be considered
for slot selection?

In a previous email, you mentioned that this problem is due
to a firmware bug, causing the driver to behave incorrectly
and advertise the wrong port as a slot. Assuming the firmware
bug is not present, what will be the behavior? Will there be
any expected PCI-topology changes in the above "lspci -tv"
command? Also, if the firmware bug is not present, do we still
need to make changes to the driver code?


Best Regards,
Krishna

>> We wanted to handle the more generic case and did not want to be confined to
>> only one device assumption. We want to fix the current inconsistent behavior
>> more generically.
> Right, as I said above I don't think handing the more generic case is
> actually required if pnv_php is doing its job properly. It doesn't
> hurt though.
>
>> Regarding the fix, the fix is obvious:
> really?
>
>> We have to traverse
>> and find the bridge ports from DT and invoke  pci_scan_slot() on them. This will
>> discover and create the entry for bridge ports (0004:02:00.0 to 0004:02:00.3 on
>> the given bus- 0004:02). There is already an existing function, pci_scan_bridge()
>> which is doing invocation of pci_scan_slot () for the devices behind the bridge,
>> in this case for  SAS device. So eventually, we are doing a scan of all the entities
>> behind the slot.
> I already read your patch so I'm not sure why you feel the need to
> re-describe it in tedious detail.
>
>> Would you like me to combine the non-bridge and bridge cases into one? I can attempt
>> to do this. Hopefully, if we incorporate the iterate sibling logic case correctly,
>> we may not need to maintain these two separate cases for bridge and non-bridge. I
>> will attempt this, and if it works, I will include it in the next patch. Thanks.
> Yes, do that.
>
> Also, do not post HTML emails to linux development lists. It breaks
> plain text inline quoting which makes your messages annoying to reply
> to. Some linux development lists will also silently drop HTML emails.
> Please talk to the other LTC engineers about how to set up your mail
> client to send plain text emails to avoid these problems in the
> future.
>
> Oliver


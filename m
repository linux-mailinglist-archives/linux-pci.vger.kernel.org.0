Return-Path: <linux-pci+bounces-30476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B748AE5D6B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 09:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47A91B64BDD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2712376EF;
	Tue, 24 Jun 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="POyXbBbj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C16335BA;
	Tue, 24 Jun 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748884; cv=none; b=WF0n8vCGlfEqoe7DprNa82ch78pNu/bavOdI51MJiCyoys1YH+WLrL88U9x0Jf2cvgPvr22+caKYisg166OVwt79mEFCCVnx2xqARztySphMkQa/wKrPd0l4x51Lo7SNd6yCu6iQPBOtihqRwOZuu5Tg7WcNvZsHOBTunCNqH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748884; c=relaxed/simple;
	bh=oqSr2xtKiKfQpF6Z4VJ56D8mrWv16KSSWxaQrXmeTfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKcaypnF7WhTKue1+hbi4PhBCd7I0Lf8wfvS/fuNYYlyz+Tsu7gZT5GeAKr8Pv1yT3SIKRCTcU6pocb6m2LLpjIaz4JOf5v+dct/IOPWWv5WVyfL1wgxz15KSrdKsjkjY3uF8bV3tvzFGwN7lbCzMQWAFR/0fWn1chp+LeUZ/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=POyXbBbj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O6wUjJ014328;
	Tue, 24 Jun 2025 07:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XKapUf
	ZDIRpZsvUfShTI6gU1ArnoNOc2wCFhpUXSj1Q=; b=POyXbBbjT9I8ZXXSq3y+6f
	V4PiiRRkMO6kn2SSMnj3iS7BkIh4FYUzT97wqJ5w9djGTImmMW20YDSxMAxskZec
	9hHe3imc+1BFyBVUCZk9UwaqcFYbDeYXpJ1/XuTSjNwBKyn1nkQuSh8JtQiWASH4
	qlnq4Gy/g5wWbhqQJ3RdrzkyMsMK65cffSpj6TS/WnNAn22D9LGtNXlLVCmQaO48
	qS003YMw2tHsUKqvGqTiORL8yquWqYkC0T8/6idYaTgVCzbYT+8B6ma4plIf1DZ6
	v0b+huXrYsUgLJjbgpq111Kzv9r/S5M7VuMxpq4nAcM4IdifxZP8WUfZulq4kfmg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tq0a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 07:07:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55O6x9HP001274;
	Tue, 24 Jun 2025 07:07:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tq0a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 07:07:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5R8cP014988;
	Tue, 24 Jun 2025 07:07:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72tjwn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 07:07:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55O77b7n53477688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 07:07:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3BE120043;
	Tue, 24 Jun 2025 07:07:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63B5520040;
	Tue, 24 Jun 2025 07:07:34 +0000 (GMT)
Received: from [9.109.241.85] (unknown [9.109.241.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 07:07:34 +0000 (GMT)
Message-ID: <06aa6c91-9580-43a6-b63d-e219e9f363aa@linux.ibm.com>
Date: Tue, 24 Jun 2025 12:37:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250618190146.GA1213349@bhelgaas>
 <1469323476.1312174.1750293474949.JavaMail.zimbra@raptorengineeringinc.com>
 <19689b53-ac23-4b48-97c7-b26f360a7b75@linux.ibm.com>
 <1675876510.1317449.1750518311479.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Krishna Kumar <krishnak@linux.ibm.com>
In-Reply-To: <1675876510.1317449.1750518311479.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iF6G89JNexf13vSoF_aaZkPRFuPbVoeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1NyBTYWx0ZWRfX3knRMXXc+g2w WDRjSfaTGatYb0cE9yGlJ6brxTj2txkxGwDZaJWn4IPTBQ0+hcoP+hwTAhOTC1ucGZXwwgmkbv+ KBVEd/LDqgn+lx6AaFCRHMCznDSOnAW9nZ2gXmrjk12FnXzAliT5obt57dskc++7B9iJCSl89U6
 QywZXkBV7XyuVODzQ/+oEF+eGd45cHA6aQMNTM0zXZD3mT/z+m9OI2iZ3qcTh96uXMze34sia5j 1imK0BdtpLdkYqjsNQxWezz/0HHXb5ZsORsOMikJ49zogt5Jdt9Q/IhtfzN6RmOtbC16PF8aWoe b58olKcmsEGHcvWQtzDINuZ5SXwffT0+U+WXIUIGGqeqyjxckK9K9HxpIKttJaNjlI2Yo40Spqv
 5oy9cWzH+fcZI5qhMgEn+4bD0a+xRTHRNxjdu2IEGN6fmA+zbN9YLJkAkag/5Ls6GjwusCEF
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685a4ebc cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=_AprYWD3AAAA:8 a=VwQbUJbxAAAA:8 a=1UX6Do5GAAAA:8
 a=1XWaLZrsAAAA:8 a=a15puGd0XAYGejVufmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=fKH2wJO7VO9AkD4yHysb:22 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: sMJwxdDqKxS75hvnWMYmfxe3JcHFYVux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240057


On 6/21/25 8:35 PM, Timothy Pearson wrote:
>
> ----- Original Message -----
>> From: "Krishna Kumar" <krishnak@linux.ibm.com>
>> To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Timothy Pearson" <tpearson@raptorengineering.com>, "Shawn
>> Anastasio" <sanastasio@raptorengineering.com>
>> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
>> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
>> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
>> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
>> Sent: Friday, June 20, 2025 4:26:51 AM
>> Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention indicator
>> Shawn, Timothy:
>>
>> Thanks for posting the series of patch. Few things I wanted to do better
>> understand Raptor problem -
>>
>>
>> 1. Last time my two patches solved all the hotunplug operation and Kernel crash
>> issue except nvme case. It did not work with
>>
>>     NVME since dpc support was not there. I was not able to do that due to being
>>       occupied in some other work.
> With the current series all hotplug is working correctly, including not only NVMe on root port and bridge ports, but also suprise plug of the entire PCIe switch at the root port.  The lack of DPC support *might* be related to the PE freeze, but in any case we prefer the hotplug driver to be able to recover from a PE freeze (e.g. if a bridge card is faulty and needs to be replaced) without also requiring a reboot, so I would consider DPC implementation orthogonal to this patch set.
Sounds Good !!
>
>> 2. I want to understand the delta from last yr problem to this problem. Is the
>> PHB freeze or hotunplug failure happens
>>
>>     only for particular Microsemi switch or it happens with all the switches. When
>>     did this problem started coming ? Till last yr
> Hotplug has never worked reliably for us, if it worked at all it was always rolling the dice on whether the kernel would oops and take down the host.  Even if the kernel didn't oops, suprise plug and auto-add / auto-remove never worked beyond one remove operation.
I would like to see this problem may be during our zoom/teams meeting. Though I have not tested surprise plug/unplug and only tested via sysfs, you may be correct but I want to have a look of this problem.
>
>>     it was not there. Is it specific to particular Hardware ? Can I get your setup
>>     to test this problem and your patch ?
> Because you will need to be able to physically plug and unplug cards and drives this may be a bit tricky.  Do you have access to a POWER9 host system with a x16 PCIe slot?  If so, all you need is a Supermicro SLC-AO3G-8E2P card and some random U.2 NVMe drives -- these cards are readily available and provide relatively standardized OCuLink access to a Switchtec bridge.
>
> If you don't have access to a POWER9 host, we can set you up with remote access, but it won't show all of the crashing and problems that occur with surprise plug unless we set up a live debug session (video call or similar).


Video Call should be fine. During the call I will have a look of existing problem and fix along with driver/kernel logs.

>
>> 3. To me, hot unplug opertaion  --> AER triggering --> DPC support, this flow
>> should mask the error to reach root port/cpu and it
>>
>>     should solve the PHB freeze/ hot unplug failure operation. If there are AER/EEH
>>     related synchronization issue we need to solve them.
>>
>>     Can you pls list the issue, I will pass it to EEH/AER team. But yeah, to me if
>>     AER implementation is correct and we add DPC support,
>>
>>     all the error will be contained by switch itself. The PHB/root port/cpu will not
>>     be impacted by this and there should not be any freeze.
> While this is a good goal to work toward, it only solves one possible fault mode.  The patch series posted here will handle the general case of a PE freeze without requiring a host reboot, which is great for high-reliability systems where there might be a desire to replace the entire switch card (this has been tested with the patch series and works perfectly).


You may be correct on this and this is possible. If the driver and AER/EEH errors/events are properly 

handled then we may not need DPC in all cases. The point of DPC was to absorb the error at switch port 

itself so that it will not reach to PHB/Root-port/Cpu and will avoid further corruption. I was hoping that if 

DPC gets enabled, we may not need explicit reboot for drives to come up in case of surprise hot unplug.

But yeah, we can compare this with current result when this support will be enabled.

>
>> 4. Ofcourse we can pick some of the fixes from pciehp driver if its missing in
>> pnv_php.c. Also at the same time you have done
>>
>>     some cleanup in hot unplug path and fixed the attenuation button related code.
>>     If these works fine, we can pick it. But I want to test it.
>>
>>      Pls provide me setup.
>>
>> 5. If point 3 and 4 does not solve the problem, then only we should move to
>> pciehp.c. But AFAIK, PPC/Powernv is DT based while pciehp.c
>>
>>      may be only supporting acpi (I have to check it on this).  We need to provide
>>      PHB related information via DTB and maintain the related
>>
>>      topology information via dtb and then it can be doable. Also , we need to do
>>      thorough planning/testing if we think to choose pciehp.c.
>>
>>      But yeah, lets not jump here and lets try to fix the current issues via point 3
>>      & 4. Point 5 will be our last option.
> If possible I would like to see this series merged vs. being blocked on DPC.  Again, from where I sit DPC is orthogonal; many events can cause a PE freeze and implementing DPC only solves one.  We do *not* want to require a host reboot in any situation whatsoever short of a complete failure of a critical element (e.g. the PHB itself or a CPU package); our use case as deployed is five nines critical infrastructure, and the broken hotplug has already been the sole reason we have not maintained 100% uptime on a key system.

If you are in hurry and want to defer DPC for some time, I am fine with it since it serves larger purpose like PE freeze and NVME drives working 

along with surprise hotplug fixes.  I have gone through your pnv_php.c changes and I am mostly fine with it. But, I would like to review it again 

from larger prespective w.r.t to EEH & pciehp.c, so give me some time.  Also, if possible you can show me 

the problem/fix along with log  during video call. it would be great if we can meet sometimes next month in early first week may be on 5th of July.

I will request few of the EEH/AER developer to have a look into the patch and to join the meeting if they have bandwidth. Please shoot the 

mail/invite on krishna.kumar11@ibm.com along with this email id. I am based in Bangalore but can be available till night 10:00 pm.

>
> Thanks!


Thanks & Best Regards,

Krishna

>


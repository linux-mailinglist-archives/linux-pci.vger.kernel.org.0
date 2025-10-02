Return-Path: <linux-pci+bounces-37464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6EBBB4F0C
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CFF3AF8AA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41312C544;
	Thu,  2 Oct 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cAxSKnS4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC527AC21;
	Thu,  2 Oct 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431052; cv=none; b=ftW/jl1jJPke2xc0D1Fk7WDrvFs3IJRkUaZ6OoOkUNC69j86lqVo99Ip/eEKOyze7g325swIbKtTfVlXN0ZfTZWlWE1klfYgkP+EL8s3Uv8vppvRUOesRsR3n5qBMjhx/MHMSwIQSmBBk4tRRt/0XzzqhHF5BnhzTx4G50IZV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431052; c=relaxed/simple;
	bh=Kdw3oUoePYW5vC3mEFbd4h97YjYzPOfFhb9E2rBa8E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qeog+ZEMitN9BH+pTR/afGTrbye+Im+HJgQjFZgc1z6MASB65IbqRLb7UQR38+7OH3zmZL/1tlE0IO8zgsnQ79Gm1j2Tzkb7V8acV4skonGHxzQBy//Qewfoy+V/3aOC0vyB7kmP0Nyp+IKNHpKOvcVaffmgdZ+QYZ0fyRLAT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cAxSKnS4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Ej3ct016881;
	Thu, 2 Oct 2025 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=iPvwz5fwlDDHwrdSOiaec/47jbSk/nrE2oMhcXavEyY=; b=cAxSKnS4c2Kk
	zqNkGLP6nD6AGJGB3Y+l7XFbxG+i8tqgLrJoyafSbgxsCMrxGJgD5u4S9dcO0IBo
	Wf2KseeK0nm44WImgfH9s+BtZ2/RQ21SpvZ8ydzEOwFfOQM2b8vPIMwH7fOuJdkf
	IKjBXsbFAVaTezyQmaPblaqSW51RmywQt5QTjnYk0FhhJIDjyo4pamGScl+3XGFV
	r/T5Oy8xk4CnoA3MmfepuzRe/BvOtg7X2yjKPqDsAY2swPFSRFkMIUXZJRJmENaq
	n3gfpOQDMyB5oc8iwxK5gHFL91/Q5M3wObUNjhSVuijVxHYQmt76cN4+aGexyxGl
	Jrt+OBxtfg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5br6edd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 18:50:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 592IonRW011885;
	Thu, 2 Oct 2025 18:50:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5br6edb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 18:50:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592GlfQR007331;
	Thu, 2 Oct 2025 18:50:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk7ckr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 18:50:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592Iolmw23200372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 18:50:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B51B5805C;
	Thu,  2 Oct 2025 18:50:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38CA358054;
	Thu,  2 Oct 2025 18:50:46 +0000 (GMT)
Received: from [9.61.250.14] (unknown [9.61.250.14])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Oct 2025 18:50:46 +0000 (GMT)
Message-ID: <8e1d9a1d-48bb-4512-8186-3b6419dc50c4@linux.ibm.com>
Date: Thu, 2 Oct 2025 13:50:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
 <4dd8a92a-0843-4009-a9c6-3a1336dbf217@linux.ibm.com>
 <67de8faa7eca891c7c39ae83540f74369de5b783.camel@linux.ibm.com>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <67de8faa7eca891c7c39ae83540f74369de5b783.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX+ybSSAIIFcEb
 9SZQiM5WIB1kyh0OxA5AyrvKlYFQhIXV91Klv9LtvG3dDNseC9K/J4w5zx+frw6NISvV25nw0S9
 zIvxcT1UPVuou4sJwcj5xj7FHxDse5hlhNDOlLQe+h2XVJkEaJQQj4q1qTC6MOB7qrz74dMrHgU
 JArE298m1vQI4CNjEqImHTjg7HqbH2wgBjevinZr5OCMDdJraEi4XKs91oa+E/0lQz90CdQu2kw
 ieNZmZVY6v1TqmMJCtf7rk8Avdh6Jd0jDKkVMI74BGtEsDdb4KW9x8F+oS1n6+2GoGxgt663m1Y
 PxbOAvglWol+7tDh5+FWyxeKLXiNTmnIOH9CrZNH7a544KrPuHYHkinKtowB8Z0Y9z7aNwnbNyR
 /VjBz6hBaKD8D4QFBk5mKvPTFwLd9g==
X-Proofpoint-GUID: N7zPw6IQj-emt01wsMrCcmDFMmsBXQhj
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dec989 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=oZwCn2ns5QSMFa2rwvUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WkdimONA7j2adAYPGpsVeBlMyxH-G5uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214


On 9/26/2025 1:36 PM, Niklas Schnelle wrote:
> On Fri, 2025-09-26 at 11:34 -0500, Ramesh Errabolu wrote:
>> On 9/24/2025 8:14 AM, Niklas Schnelle wrote:
>>
>>> On s390, an individual PCI function can generally be identified by two
>>> IDs, depending on the scope and the platform configuration.
>> It would help to name the two IDs - FID and ???
> How about:
> "On s390, an individual PCI function can generally be identified by two
> identifiers, the FID and the UID. Which identifier is used depends on
> the scope and the platform configuration."
>
> And then reword the below without "so-called".
>
>>> The first ID is the so-called FID, which is always available and
>>> identifies a PCI device uniquely within a machine. The FID may be
>>> virtualized by hypervisors, but on the LPAR level, the machine scope
>>> makes it impossible to reuse the same configuration based on FIDs on two
>>> different LPARs.

Wondering if the statement about reusable configuration can be 
simplified. Can you say it

directly i.e. it is impossible to reuse FID based configuration on two 
different LPARs

>>>
>>> Such matching LPAR configurations are useful, though, allowing
>>> standardized setups and booting a Linux installation on different
>>> machines. To allow this, a second user-defined identifier called UID was
>>> introduced. It is only guaranteed to be unique within an LPAR and only
>>> if the platform indicates so via the UID Checking flag.
>> The paragraph as I read is not clear. Your intention is to highlight the
>> need for UID to allow standardized setups.
> Yes, that was my intention. Also here is where the second ID is
> introduced so I'll reword this a bit if the name is already mentioned
> in the first paragraph.

The first paragraph is introducing the impossibility of reuse of FID 
based configuration

But folks may not know what benefits arise from a matching 
configuration. Therefore simply

elaborate on the benefits of having a matching configuration and that 
UID are introduced to support

that specific purpose.


>>> On s390, which uses a machine hypervisor, a per PCI function hotplug
>>> model is used. The shortcoming with the UID then is, that it is not
>>> visible to the user without first attaching the PCI function and
>>> accessing the "uid" device attribute. The FID, on the other hand, is
>>> used as slot number and is thus known even with the PCI function in
>>> standby.
>>>
>>> Remedy this shortcoming by providing the UID as an attribute on the slot
>>> allowing the user to identify a PCI function based on the UID without
>>> having to first attach it. Do this via a macro mechanism analogous to
>>> what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
>>> pdev->dev.groups") for the PCI device attributes.
>>>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ---
>>> Note: I considered adding the UID as a generic "index" via the hotplug
>>> slot driver but opted for a minimal solution to open the discussion. In
>>> particular my concern with a generic attribute is that it would be hard
>>> to find a format that fits everyone. For example on PCI devices we also
>>> use the "index" attribute for UIDs analogous to SMBIOS but having it in
>>> decimal is odd on s390 where these are usual in hexadecimal.
>>> ---
>>>    arch/s390/include/asm/pci.h |  4 ++++
>>>    arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
>>>    drivers/pci/slot.c          | 13 ++++++++++++-
>>>    3 files changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>>> index 41f900f693d92522ff729829e446b581977ef3ff..23eed78d9dce72ef466679f31c78aca52ba00f99 100644
>>> --- a/arch/s390/include/asm/pci.h
>>> +++ b/arch/s390/include/asm/pci.h
>>> @@ -207,6 +207,10 @@ extern const struct attribute_group zpci_ident_attr_group;
>>>    			    &pfip_attr_group,		 \
>>>    			    &zpci_ident_attr_group,
>>>    
>>> +extern const struct attribute_group zpci_slot_attr_group;
>>> +
>>> +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
>>> +
>>>    extern unsigned int s390_pci_force_floating __initdata;
>>>    extern unsigned int s390_pci_no_rid;
>>>    
>> Will this not lead to linking error when the patch is built on non-s390
>> architecture. You could refer to zpci_slot_attr_group using a
>> CONFIG_..... and discard the #define ARCH_PCI_SLOT_GROUPS. I didn't find
>> a relevant CONFIG_... that could be used.
> This code is in arch/s390/ it will not be build on non-s390. For the
> non s390 case ARCH_PCI_SLOT_GROUPS will be undefined and the #ifdef in
> slot.c makes sure we're not trying to insert ARCH_PCI_SLOT_GROUPs in
> the array as it is not defined.
>
> Thanks,
>
> Niklas


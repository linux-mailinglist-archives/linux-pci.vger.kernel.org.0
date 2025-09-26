Return-Path: <linux-pci+bounces-37123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D966BA4E97
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C163AD36B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67201E1C22;
	Fri, 26 Sep 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DSmk+3aL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B24C81;
	Fri, 26 Sep 2025 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912286; cv=none; b=UQ2yMT3WFH3E72V79x5yr+E08DXhAiW/eBzKkJjcVv3Oalrk4u+sCxOGFhD/kux8NLtuum4nb3jA9t9OAIPueAUgX4UXOVQBJ2nJk5TyEgRG6qJJ5UWCr4o3K4RlFPHNRRVS2VRLQR/KIbfd910bbczpjfWhdyz/DMTIHNy/cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912286; c=relaxed/simple;
	bh=A7Le6uma8JN9KcppDV8PAkPLPeqr+dPSkrokTaOlNJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bADHiEZOq2XQSNELpb5vQ7wmfrNN9Fq8JTd2ObUUNyW4MoN9iGP8HP3EVm3eW51fqxkU69Cl8tehvz18dnMsCom7/sWjVs/PyktXaVktXdga1mk1bi4ITaF2TuloFR47a+yIHXaLc2JEvhRnfCRxoZh83LZK10LgkgFlVoRsm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DSmk+3aL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHF1Km029912;
	Fri, 26 Sep 2025 18:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=U0bIX0y+m98lPphIhY6ko7upQV06c9wlXoyPw1mEOlo=; b=DSmk+3aLqS1a
	iV1hm+QaqnW9taWOstMD0E7rqiQgbFFXcYZ/eZ7qXI6E8qhlcTjp2uzU8C8jV3e0
	K+01PhIg1nvZ0YS4qq/afaMadovxHIIac7BUmH010arbMxkSD/qfvQdZx14dAAUq
	9PaWulupUG6+FNHkOqpeahyVuWp8xfcHI3nMyt4jjBHahCTTYqVfyjESz3/6SpAX
	ogAujVxe1DaxfrgiSFlJOE8Q6pDwm0YNXrN6ohmY3B/ywS2HDFNA1K1MxfixlG1p
	I+BwZ7RQZpf/XmwnWhYfRB1yDt3Px8O5PeS0pukD2O+pctY6d5vvkLrLBZiiANWP
	nSQhphh0ew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbapgys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:44:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58QIb7Mk013648;
	Fri, 26 Sep 2025 18:44:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbapgyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:44:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHH71s025848;
	Fri, 26 Sep 2025 18:44:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawpwq5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:44:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QIifEs40632834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 18:44:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F50B5805D;
	Fri, 26 Sep 2025 18:44:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F20158043;
	Fri, 26 Sep 2025 18:44:40 +0000 (GMT)
Received: from [9.61.248.170] (unknown [9.61.248.170])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 18:44:40 +0000 (GMT)
Message-ID: <fa1db8bb-a99f-4efe-af72-4858ee638bd1@linux.ibm.com>
Date: Fri, 26 Sep 2025 13:44:39 -0500
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
X-Proofpoint-GUID: GXVjw1JWOBH-6ExwKV31-tyAsnJ3yX_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX4cPn1zzTv9lq
 c7qUbcqcBBPivfcDg6jaM8yGmhLmehlWGPUF5qAE7wFvk+TI6lkHiUjoARN52yIgBbmvwpR5XRy
 9ijDbXagICWt6LnwYjqqMSlbOTtRXB/Fe/Ky92CzfcqpYMyUo8tMz4G9Hf3ULX//ZbTDZE7m4mJ
 cgp5726H5fSWXh76IRrda0z05bqhlMkJg5m3sbZ9MO6LwZ53mAz/IV83Xpqc7B3k1kUgO8xd9+b
 J/feguT6Lu32OhDNuJH1DLRFgd3FEjZfeu0ghIAGjcCGgeE7E4MGlMQRsoqYkuZ2iCMJbnUlJbG
 HfLobgoY1X/MegYI9roNwlfm+VWeXAEvq2CPXF+wgIyaGsQ/GXJzyXKfSdQoA9B2fIf+XL4bKme
 GX8Vpaos4luwcHwreA2Q8uI4wIBHtw==
X-Proofpoint-ORIG-GUID: Di6Ss-odSHoAP8UaCHCd-0pAfJps-Ity
X-Authority-Analysis: v=2.4 cv=B6W0EetM c=1 sm=1 tr=0 ts=68d6df1b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=UMODVSnWySmH3eSmB1kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174


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
That will help a lot
>>> The first ID is the so-called FID, which is always available and
>>> identifies a PCI device uniquely within a machine. The FID may be
>>> virtualized by hypervisors, but on the LPAR level, the machine scope
>>> makes it impossible to reuse the same configuration based on FIDs on two
>>> different LPARs.
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
Will await your next update
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
You are right, I completely overlooked it. My comment is incorrect.
>
> Thanks,
>
> Niklas


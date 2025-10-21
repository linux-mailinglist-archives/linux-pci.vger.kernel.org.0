Return-Path: <linux-pci+bounces-38943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56408BF8B59
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 22:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0CD19C51C5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D17D3F9FB;
	Tue, 21 Oct 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kWQrQV20"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC542561C2;
	Tue, 21 Oct 2025 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078173; cv=none; b=G1OxeRhWupKWMCjH7hJ30Z7v/14BFtKuZrzn0J7JxzWfgh3wd8A+kat0STl4UP9G2DILtfOSYIC+mQfFqZL/8XJrMXbMFAg0ifdMpoxOmaeAd1nyKfImfnQ68i6RX6aUr7OYRmjArMJvTOKrQdstuycy5yzYv8udDYAO7sh5cMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078173; c=relaxed/simple;
	bh=j1/9Zn64S+rdPHLo4FHM6+vjbfyF5VAgvH31TrIGStQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jbnr760yfyOnmZ5I2SqXf0pnwF+o83ozzzWnbdtenzNdAlgLTfrmqqd4xMOxsokhnN9Q0a5MEDicCg7MuCXjA5ZRks6ucdSib/R9HHVqYOaE7Z98RxU/Pk0BLbzKFQTsQfeA1J/ukoY2c2OAnSKwnQjmZorJ7w5fQjFT2WSQIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kWQrQV20; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LGAHwM011773;
	Tue, 21 Oct 2025 20:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DVWHq3
	w1V9bird66o/HT3IQgYq83pLC6FZywZkJrf00=; b=kWQrQV20B6KwMkoLiXLs2Y
	mJ1vu88hk3HEpiuZc19pv0pdlUwGxPDHfKKhI1dutyQCGMk2BXihcF/byyCr2G2f
	JimkkLWUQhWCXqocw4wYyQLvjAkf5axiD8VA4hxTKiU1C0Etnkkq1Vb8NlAxLFVO
	VlMUjWHVxqsNfOS1DNV0byodKskUvNh6PLPFmPi14jLpgYhaonQ+dbHYDwPak88d
	vDQIsrwNFYYbuoks/bXTjiSqkJ1mm7H6Q/wrRo1b+JfzNqX2epHrlfFjsC9DTetW
	krpx2VBRgfZBrKuCkgdD91uAEZ4MTd0Q7Rv/vDWSgJn4IWkuadVEyx0irfJHDttg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c7u8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 20:22:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LJeGmA011075;
	Tue, 21 Oct 2025 20:22:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx14ewj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 20:22:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LKMjDY17105426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 20:22:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76F5058055;
	Tue, 21 Oct 2025 20:22:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDC3158043;
	Tue, 21 Oct 2025 20:22:44 +0000 (GMT)
Received: from [9.61.241.19] (unknown [9.61.241.19])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 20:22:44 +0000 (GMT)
Message-ID: <41c90334-9bee-4252-9366-a4f5c38c83b9@linux.ibm.com>
Date: Tue, 21 Oct 2025 13:22:39 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] PCI: Allow per function PCI slots
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, stable@vger.kernel.org, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
References: <20251020190200.1365-1-alifm@linux.ibm.com>
 <20251020190200.1365-2-alifm@linux.ibm.com>
 <f8d1619917f105ec805b212af9e940aa73925b70.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <f8d1619917f105ec805b212af9e940aa73925b70.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pMJL_spnLMC3cmT05Fdl1YmBnIvIlqUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8xHNaqHe1Lx0
 vpwIfS420Ot8iWmKPy6POV1rLw6jwSpIxAEUuCCOxyiR9PVuODMiXVkm26qsQDjmX5SOwlxajGc
 5lTnHkZVDPxm3nwdmCnnfk33TpiYwNtiOwC2ziNUxPi0w9+iyiJ+RGbWjg7I36tuf2TMZKvZq/j
 Pa+sbI01QH25InSKyYxa6y6XlAQSnDwPI7TGbM7Bjfg/RbdwxgCiCdP6VInB/o99fYK4UKnyCgB
 0vq8p+GIlr/4S2GvEnAPBepNCIEPO81t1Hv+yFpDwxzWNXWYGJpRrccEgp+Q05H4+81rcW5mX9e
 Zg86KABvmuggaGzr//qZnAyVgHWPxXmVi4r863lBE+9iELDt0244Y0DOPAmdOkMklpaqjJcw+hr
 1yAbu4/++/YbVFL7qYxvHnKAhDYqtw==
X-Proofpoint-GUID: pMJL_spnLMC3cmT05Fdl1YmBnIvIlqUL
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f7eb98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1mzHYz07CPLjn6S_tm4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 10/21/2025 5:49 AM, Niklas Schnelle wrote:
> On Mon, 2025-10-20 at 12:01 -0700, Farhan Ali wrote:
>> On s390 systems, which use a machine level hypervisor, PCI devices are
>> always accessed through a form of PCI pass-through which fundamentally
>> operates on a per PCI function granularity. This is also reflected in the
>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>> functions. Its reset_slot() function, which is a wrapper for
>> zpci_hot_reset_device(), thus also resets individual functions.
>>
>> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
>> to multifunction devices. This approach worked fine on s390 systems that
>> only exposed virtual functions as individual PCI domains to the operating
>> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> s390 supports exposing the topology of multifunction PCI devices by
>> grouping them in a shared PCI domain. When attempting to reset a function
>> through the hotplug driver, the shared slot assignment causes the wrong
>> function to be reset instead of the intended one. It also leaks memory as
>> we do create a pci_slot object for the function, but don't correctly free
>> it in pci_slot_release().
>>
>> Add a flag for struct pci_slot to allow per function PCI slots for
>> functions managed through a hypervisor, which exposes individual PCI
>> functions while retaining the topology.
>>
>> Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/hotplug/s390_pci_hpc.c | 10 ++++++++--
>>   drivers/pci/pci.c                  |  5 +++--
>>   drivers/pci/slot.c                 | 14 +++++++++++---
>>   include/linux/pci.h                |  1 +
>>   4 files changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
>> index d9996516f49e..8b547de464bf 100644
>> --- a/drivers/pci/hotplug/s390_pci_hpc.c
>> +++ b/drivers/pci/hotplug/s390_pci_hpc.c
>> @@ -126,14 +126,20 @@ static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
>>   
>>   int zpci_init_slot(struct zpci_dev *zdev)
>>   {
>> +	int ret;
>>   	char name[SLOT_NAME_SIZE];
>>   	struct zpci_bus *zbus = zdev->zbus;
>>   
>>   	zdev->hotplug_slot.ops = &s390_hotplug_slot_ops;
>>   
>>   	snprintf(name, SLOT_NAME_SIZE, "%08x", zdev->fid);
>> -	return pci_hp_register(&zdev->hotplug_slot, zbus->bus,
>> -			       zdev->devfn, name);
>> +	ret = pci_hp_register(&zdev->hotplug_slot, zbus->bus,
>> +				zdev->devfn, name);
>> +	if (ret)
>> +		return ret;
>> +
>> +	zdev->hotplug_slot.pci_slot->per_func_slot = 1;
> I think the way this works is a bit odd. Due to the order of setting
> the flag pci_create_slot() in pci_hp_register() tries to match using
> the wrong per_func_slot == 0. This doesn't really cause mismatches
> though because the slot->number won't match the PCI_SLOT(dev->devfn)
> except for the slot->number 0 where it is fine.
>
> One way to improve(?) on this is to have a per_func_slot flag also in
> the struct hotplug_slot and then copy it over into the newly created
> struct pci_slot. But then we have this flag twice. Or maybe this really
> should be an argument to pci_create_slot()?

This would still work as we associate the struct pci_dev to struct 
pci_slot in pci_dev_assign_slot(), when we would have the flag set. But 
I do see your point that there is room for improvement here. As 
discussed offline we can maybe have the flag in struct pci_bus since we 
already have the slots list. This would allow us to set the flag for 
zpci devices at the creation of the pci_bus. And can be used by 
pci_create_slot() and pci_dev_assign_slot() to correctly set the slot 
for the pci dev. Will post a v2 with this.

Thanks

Farhan




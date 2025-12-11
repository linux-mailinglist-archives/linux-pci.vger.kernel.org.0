Return-Path: <linux-pci+bounces-42952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB4ACB5E48
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17CB30062FC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFC30FF20;
	Thu, 11 Dec 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KXPYi1LP"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B342D3EDF
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456590; cv=none; b=OP23sgnIU+JLc2U8vT6gdoQu+J2D6USLB3OP8X00oBsP9K+2HwQZVJ+2v67IzdrWh6R6Ccy6aJg5MP/7oZY7KtZKlLemdbk+0ub7QOazycVLAbJlZ5xe39nL729BNb4WpcULYINqQobqf1UeyTfFpa07c8CZXWM6mBGh1nZxSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456590; c=relaxed/simple;
	bh=Tqm4np+wrST9lYKnBPZpm0zAxIMxqaY4v9M+DUNa54c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4Mi6gBB3KYL8309M7BH8nCh7llKdXxnxssdVKsmYvv0UmgEM3aX6c5S5wcaiP0m81mXpTvXfV/AsGDAmEyOE3BHQ6JBGwtSNyo7cWEDfNcpvWyzDozZBS0rx6HODYOFu6nCxHnG30aZvH7JCQ0kzQGQbquGh9WV0T+O6yPSZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KXPYi1LP; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765456578; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n+Kdp6Ci8cXcDkenX64z5bvqeK+7SYH8T3XndMTNRqw=;
	b=KXPYi1LPHThtgijrKBfGyakrZrADNXrZzjUyeXSVxKkAUMFLQXQu2HUxZwIOfVtFzK8hSY7J8+Oi6KV1MTaZ5GKKunSIEt9Tqn2mMAJDp1ZJA387kh2NF9QdqiQtsBAqvJryjP91Q76WV1t5JiRAvpQhKMBR+bW9DtYtZh83vDo=
Received: from 30.178.203.102(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuaPF1C_1765456577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 20:36:17 +0800
Message-ID: <d1cc0963-3834-498c-aa0e-5cd12f25f313@linux.alibaba.com>
Date: Thu, 11 Dec 2025 20:36:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v8 1/2] PCI: Introduce named defines for pci rom
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
References: <20251211120540.3362-1-kanie@linux.alibaba.com>
 <20251211120540.3362-2-kanie@linux.alibaba.com>
 <9002bfe1-0dc1-8f0c-3abf-9166c451cbdd@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <9002bfe1-0dc1-8f0c-3abf-9166c451cbdd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/11 20:14, Ilpo Järvinen 写道:
> On Thu, 11 Dec 2025, Guixin Liu wrote:
>
> Please capitalize PCI and ROM in the subject.
>
>> This is a preparation patch for the next fix patch.
>> Convert some magic numbers to named defines.
> This should be reasonable to read even without reading what's in the
> subject first, so it would be better to duplicate the information that
> this relates to PCI ROM header fields ("some" is extremely vague :-)).
OK, changed in v9.
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/pci/rom.c | 35 ++++++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>> index e18d3a4383ba..3cb0e94f0e86 100644
>> --- a/drivers/pci/rom.c
>> +++ b/drivers/pci/rom.c
>> @@ -5,6 +5,8 @@
>>    * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
>>    * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>>    */
>> +
>> +#include <linux/bits.h>
>>   #include <linux/kernel.h>
>>   #include <linux/export.h>
>>   #include <linux/pci.h>
>> @@ -12,6 +14,16 @@
>>   
>>   #include "pci.h"
>>   
>> +#define PCI_ROM_HEADER_SIZE			0x1A
>> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
>> +#define PCI_ROM_IMAGE_LEN			0x10
>> +#define PCI_ROM_IMAGE_LEN_UNIT_SZ_512		512
> I'm sorry I didn't notice immediately, but this is what I meant:
>
> #define PCI_ROM_IMAGE_LEN_UNIT_BYTES		SZ_512
>
> + you need linux/sizes.h for SZ_512.
Sure, changed in v8, thanks.

Best Regards,
Guixin Liu
>> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
>> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
>> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A
>> +
>>   /**
>>    * pci_enable_rom - enable ROM decoding for a PCI device
>>    * @pdev: PCI device to enable
>> @@ -91,26 +103,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>>   	do {
>>   		void __iomem *pds;
>>   		/* Standard PCI ROMs start out with these bytes 55 AA */
>> -		if (readw(image) != 0xAA55) {
>> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>> -				 readw(image));
>> +		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
>> +			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
>> +				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
>>   			break;
>>   		}
>>   		/* get the PCI data structure and check its "PCIR" signature */
>> -		pds = image + readw(image + 24);
>> -		if (readl(pds) != 0x52494350) {
>> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>> -				 readl(pds));
>> +		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
>> +		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
>> +			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
>> +				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
>>   			break;
>>   		}
>> -		last_image = readb(pds + 21) & 0x80;
>> -		length = readw(pds + 16);
>> -		image += length * 512;
>> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
>> +				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
>> +		length = readw(pds + PCI_ROM_IMAGE_LEN);
>> +		image += length * PCI_ROM_IMAGE_LEN_UNIT_SZ_512;
>>   		/* Avoid iterating through memory outside the resource window */
>>   		if (image >= rom + size)
>>   			break;
>>   		if (!last_image) {
>> -			if (readw(image) != 0xAA55) {
>> +			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
>>   				pci_info(pdev, "No more image in the PCI ROM\n");
>>   				break;
>>   			}
>>
> The code change looked fine otherwise.
>



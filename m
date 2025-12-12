Return-Path: <linux-pci+bounces-42983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41725CB79AB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 03:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0203015AB7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6AC1339B1;
	Fri, 12 Dec 2025 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sqHcDiwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F31FDA
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504972; cv=none; b=R72P7fb3qdl4+6q05JgJYN4h+6MhJ4h1EdhGIsubirdcXbkT2Zb9wOK98SWICUZiXZQgvkOYSV6qVP6/P/L2KeHtwbmfsNFRRNRi7r2YmFyTu2zl84uH3YbzuCEjSmEcKa5UCexF31qOHolAaySdG+j9fKCXzwDwtsF6VJZMz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504972; c=relaxed/simple;
	bh=Xj9D1OIlzrgZSasF6eGN3/1dH74HBd5GiVbtv27jRp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oya4bNlcZr1/Sm887/pyFMp85Zc8cEg0KmR/0ZFxm6u5A3AdF8KWcoN7YPri1BNNXqg1Jf97v9AJyoWjZlUTjDva3h9zpVsULxRF4oBsesqmTXdLTSBlGyJ66T/wK44hgPBRRJvhWpr7l3qZW9ETs/6tX+l7iAsspOC1Zsd69IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sqHcDiwO; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765504967; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Eqn+45s6QXmQFXVOBIrkB67nWMgMlfLCgbeuVldTBvU=;
	b=sqHcDiwOqKauiKDfvRobVD5DjwTW3WbpT8bkFlT0ClRoVZI2lPSIslNUCLfpCutYHqs2gZp+SzZ/DB0LbepaF6PkmdZsrk4AhnFvlKrLD+rvTuOOK7yFFhbsA1225fk3q3Igojm+k52FrDvMqJTa3Enf4JBj1CoPtWcKPoytOZk=
Received: from 30.178.83.32(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WucHl.F_1765504648 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 09:57:29 +0800
Message-ID: <89e44eda-99c0-4158-946d-21a951a48206@linux.alibaba.com>
Date: Fri, 12 Dec 2025 09:57:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v9 1/2] PCI: Introduce named defines for pci rom
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org
References: <20251211125906.57027-1-kanie@linux.alibaba.com>
 <20251211125906.57027-2-kanie@linux.alibaba.com>
 <aTrPtxDdg__tabSE@smile.fi.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <aTrPtxDdg__tabSE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/11 22:05, Andy Shevchenko 写道:
> On Thu, Dec 11, 2025 at 08:59:05PM +0800, Guixin Liu wrote:
>> Convert the magic numbers associated with PCI ROM into named
>> definitions. Some of these definitions will be used in the second
>> fix patch.
> Please, give at least 24h between the versions in order other being able (quick
> enough) to review the changes.
>
> ...
OK, I will be more carefule next time.
>> +#include <linux/bits.h>
>>   #include <linux/kernel.h>
>>   #include <linux/export.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>> +#include <linux/sizes.h>
> 'i' goes before 'l', yeah it's hard to see in small monospace fonts.
>
> ...
OK, changed in v10.
>
>> +#define PCI_ROM_HEADER_SIZE			0x1A
>> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
>> +#define PCI_ROM_IMAGE_LEN			0x10
>> +#define PCI_ROM_IMAGE_LEN_UNIT_BYTES		SZ_512
> I'm a bit confused by the naming here.
>
> There are two definitions that end with _LEN, but the meaning of them is
> the offset where the respective "len" can be read from.
>
> Now, there is a _LEN_UNIT_BYTES, which seems related to _LEN, but in unclear
> way.
>
> With all the AA55 signature it pretty much sounds to me like a sector division
> (legacy from the era of floppies).
>
> That said, I would name the size of the "unit" as
>
> #define PCI_ROM_IMAGE_SECTOR_SIZE		SZ_512
>
> (without or with _BYTES on your choice, usually we don't use unit for bytes
>   when there is no room for misinterpretation).
OK, I will change this to PCI_ROM_IMAGE_SECTOR_SIZE in next version.
>> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
> Despite the below comment explains this, I would explicitly state it here
>
> /* Data structure signature is "PCIR" in ASCII representation */
Added in v10, thanks.

Best Regards,
Guixin Liu
>> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
>> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A



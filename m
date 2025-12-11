Return-Path: <linux-pci+bounces-42941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1FCB59FB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9B7300725F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1A2D9EF4;
	Thu, 11 Dec 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qsDtIlJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3F29C351
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451914; cv=none; b=gB++TVmNuDEkc5Vrcsr7CZSXAU1RpniYBkZMr7xSlktOsjJxHn32W4lNYfSiyLSa9zmMOVlOArqYAPjJhwkDU9nvk+ejgde62C/cF5RYcOGlPNl/YL3rv8sVXXsi67VorLNY8Bb4DcD46hE0WSQ6GSsAL1nrawcWaHYOUP24hsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451914; c=relaxed/simple;
	bh=iTwuO0EwBcugxe/Z8b9dB1vK4hpzQWWEYYYe9SKVcfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEMWlNqF5EYsGMQD1r9MxMdTvFiQ2/UiKvwUX6SegC+iJOPcNmk6PCiE9ov8W8AzL3NvQ0bvfZG1Mq3XbORUFOENH/LaO6O6s8VdgcNlr4HhepED+Z6lxX7wBLClp6eAy0DK4MV/p7jFrhd8/TTDoRAgMheERXXYgVk+g8G4g7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qsDtIlJU; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765451902; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AdgshK34ppTzBxXXkaKV/UnISDPhkgysu4zTPfmHYwU=;
	b=qsDtIlJU9XpMwtIzbvIu0NOjQ/oNBT3uJAQY/VI67pr0NgBauGcDmT+HgkfKT1JtkdVlXsDIu0Kq9x4L2c+MOCIWhQThgX8fWQsJynJR1mYvUOPAWycBDUNzU8tR9jP+TWkRt1kNlaNF+5X1cff46pZkjvEKf9+RFPjK71VYFtc=
Received: from 30.178.203.102(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuaJdsZ_1765451901 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 19:18:21 +0800
Message-ID: <e3f9f75f-d6d0-458a-81c9-ba9659b5f7c2@linux.alibaba.com>
Date: Thu, 11 Dec 2025 19:18:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v7 1/2] PCI: Introduce named defines for pci rom
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
References: <20251211033741.53072-1-kanie@linux.alibaba.com>
 <20251211033741.53072-2-kanie@linux.alibaba.com>
 <a0f0fead-ee26-943a-53b3-873e8652811f@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <a0f0fead-ee26-943a-53b3-873e8652811f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/11 17:33, Ilpo Järvinen 写道:
> On Thu, 11 Dec 2025, Guixin Liu wrote:
>
>> This is a preparation patch for the next fix patch.
>> Convert some magic numbers to named defines.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/pci/rom.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>> index e18d3a4383ba..3e00611fa76b 100644
>> --- a/drivers/pci/rom.c
>> +++ b/drivers/pci/rom.c
>> @@ -9,9 +9,20 @@
>>   #include <linux/export.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>> +#include <linux/bits.h>
> Includes should always be ordered alphabetically when they already are so.
>
> Even in to other cases it's better try to place them close to the
> right place wrt. other headers when it comes to alphabetical order, even
> if some pre-existing headers would violate it still.
OK, Changed in v8, thanks.
>>   #include "pci.h"
>>   
>> +#define PCI_ROM_HEADER_SIZE			0x1A
>> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
>> +#define PCI_ROM_IMAGE_LEN			0x10
>> +#define PCI_ROM_IMAGE_LEN_UNIT_SZ_512		512
>> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
>> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
>> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A
>> +
>>   /**
>>    * pci_enable_rom - enable ROM decoding for a PCI device
>>    * @pdev: PCI device to enable
> You should convert the literals in the code too in this patch already.
>
> I know it's a bit work to rebase the second patch on top of this, but you
> actually don't need to do it that way (you can just make changes to this
> patch and then use git diff to produce the very same end result so you
> don't need to resolve any rebase conflicts).
OK, I wil do this.

Best Regards,
Guixin Liu



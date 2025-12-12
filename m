Return-Path: <linux-pci+bounces-42982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEFCB79A2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 03:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5240230319BC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 01:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC1289811;
	Fri, 12 Dec 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GQI/n4Q4"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA722579E
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504740; cv=none; b=rrgkXtH9C4r+VwtPud8h/ajRlo0yOwStXhmEdwAoEa/MfOuMZp5KwnUkrS64PRfVmL0aGc1MK/ZDp/NKgsfj4y3num3tpA4E6sZb1sn6l/ErwRisKNUj1cDqQysLCpUsrlvf7GGZikzG4Mc1iQ7w6+qtkGuMlRU7+icymDNXqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504740; c=relaxed/simple;
	bh=T35uBsLqjrw4s0h+08fDC+iFXPICekdXy+0jVMiu/2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gwa69+zPlnL0tQ/OHI8hg0V4ePO2xl0TzhTqfaoBZPrnm+piZROc+BIt87P1DVv7AOBLpZQKaL55NRie5xuA8AUGwNoh3FyX0BuS7fsalqMV3nbX3SStsQiLO90/10pInwf6/lZ7NWlT/FqPuHL/RjxLsPzRjPelTY6XBONXfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GQI/n4Q4; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765504729; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mnt0j7uJFHzTrZXKVff1ONYJDEghKFGFw/kt3uf+Ta8=;
	b=GQI/n4Q4HUSwNw9aLC0G1VF56HD5yNu2JhpCtKHyRZmz/rY6XRHua2Qp2u4qVzaXG1aOBdnajn7y6gOiGu1dEIIICjREWtRPsh5Pw+q4bY55aVsXavB1iVzzTiGmpvGRzZUHaP9G3Gtz5/MVNlkMAPLWfajI0uIGQfAsHbWEhOY=
Received: from 30.178.83.32(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WucPXLC_1765504728 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 09:58:49 +0800
Message-ID: <22a877be-508c-4367-bdb0-617c5398ac60@linux.alibaba.com>
Date: Fri, 12 Dec 2025 09:58:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v9 2/2] PCI: Check rom header and data structure addr
 before accessing
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org
References: <20251211125906.57027-1-kanie@linux.alibaba.com>
 <20251211125906.57027-3-kanie@linux.alibaba.com>
 <aTrQJ3HuTIlpRwmO@smile.fi.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <aTrQJ3HuTIlpRwmO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/11 22:07, Andy Shevchenko 写道:
> On Thu, Dec 11, 2025 at 08:59:06PM +0800, Guixin Liu wrote:
>> We meet a crash when running stress-ng on x86_64 machine:
>>
>>    BUG: unable to handle page fault for address: ffa0000007f40000
>>    RIP: 0010:pci_get_rom_size+0x52/0x220
>>    Call Trace:
>>    <TASK>
>>      pci_map_rom+0x80/0x130
>>      pci_read_rom+0x4b/0xe0
>>      kernfs_file_read_iter+0x96/0x180
>>      vfs_read+0x1b1/0x300
>>
>> Our analysis reveals that the rom space's start address is
>> 0xffa0000007f30000, and size is 0x10000. Because of broken rom
>> space, before calling readl(pds), the pds's value is
>> 0xffa0000007f3ffff, which is already pointed to the rom space
>> end, invoking readl() would read 4 bytes therefore cause an
>> out-of-bounds access and trigger a crash.
>> Fix this by adding image header and data structure checking.
>>
>> We also found another crash on arm64 machine:
>>
>>    Unable to handle kernel paging request at virtual address
>> ffff8000dd1393ff
>>    Mem abort info:
>>    ESR = 0x0000000096000021
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x21: alignment fault
>>
>> The call trace is the same with x86_64, but the crash reason is
>> that the data structure addr is not aligned with 4, and arm64
>> machine report "alignment fault". Fix this by adding alignment
>> checking.
> ...
>
>> +#include <linux/align.h>
>>   #include <linux/bits.h>
>> -#include <linux/kernel.h>
>>   #include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/overflow.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   #include <linux/sizes.h>
> I would not touch kernel.h position in this patch. The real change (a third one
> if you wish to make that) should replace kernel.h with real includes, making it
> disappear. Now this move is unneeded churn.
>
OK, I will not touch kernel.h in v10.

Best Regards,
Guixin Liu



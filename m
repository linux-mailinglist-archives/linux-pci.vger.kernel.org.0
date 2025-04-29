Return-Path: <linux-pci+bounces-27009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D46AA1065
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662DC4647AF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A22A221556;
	Tue, 29 Apr 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gc1sewHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B5221555;
	Tue, 29 Apr 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940326; cv=none; b=sic4NbjIu3ZZwkHX03mXBBDMwfle05lRWmpw9yeDTz2inTK37+GGpksKoL0u4q64m4FsoykWydyLjA7cWLWOztZYIfsd/El695YGMTVFsjlFlTFOdJkVb7WrHCN1/QKmAasJhC37SV8hWQCxdeIq6RzA99HxC9YyPFzWldNAMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940326; c=relaxed/simple;
	bh=oYAdU0jkvuI+0Ij59NKXPgF9vmCiJv8dZouUG1rcl6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8gwyhstpQ6BgtQPOjo+kNiwCScnlKNyfKG3eKOaEdQiDqzTxlVqKuQyP4AOgigop/sxtUg1d+FjA6RnHqmIRcPxl9w6bulRGLRvkq9f/R3+BA0QuFLX7z1IGIEhaA4EyVhqHfoRCOtHTIesmCZEsPwx6LRzXbJTd7Te+Lcn6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gc1sewHC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=x+SauMl1lNpFDwDKg4OnckesseNQRn5XI+n9hs9dTi8=;
	b=Gc1sewHC2v57NYJF+0dbcNruGB6y9pQkSF3Zu2AbfhDINXlJ8M8iBr2163GlRb
	4zPiAX8h5wJAr4DQof0AAjh5Sb+kU6NOL76KzXndoQq+ysdWD99ght77/4yMTNhg
	sHzsJaXiSTToeN9BQtV3l53AzpkkAaRDFr1E8DETOh348=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAX1PQP7xBo7IxcDQ--.2207S2;
	Tue, 29 Apr 2025 23:24:00 +0800 (CST)
Message-ID: <2e502bf0-d65e-4394-9629-55392e496ed5@163.com>
Date: Tue, 29 Apr 2025 23:23:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] PCI: Clean up __pci_find_next_cap_ttl()
 readability
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250429125036.88060-1-18255117159@163.com>
 <20250429125036.88060-3-18255117159@163.com>
 <66cdb108-80f5-fe7c-329b-8c60caf55b64@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <66cdb108-80f5-fe7c-329b-8c60caf55b64@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX1PQP7xBo7IxcDQ--.2207S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrKw18tw1xCw4fXrWfuFg_yoW5XFWfpF
	98CFy7AF48JFyjka1v9w1ayF12qayDKFW8KryYg3WUZFy2yr1xGw4vkr1Y9FnrZrWvvF10
	q34q93s5uryYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRP8n5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgU+o2gQ7ZYkXQAAsY



On 2025/4/29 23:17, Ilpo Järvinen wrote:
> On Tue, 29 Apr 2025, Hans Zhang wrote:
> 
>> Refactor the __pci_find_next_cap_ttl() to improve code clarity:
>> - Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
>> - Use ALIGN_DOWN() for position alignment instead of manual bitmask.
>> - Extract PCI capability fields via FIELD_GET() with standardized masks.
>> - Add necessary headers (linux/align.h, uapi/linux/pci_regs.h).
>>
>> The changes are purely non-functional cleanups, ensuring behavior remains
>> identical to the original implementation.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v9:
>> - None
>>
>> Changes since v8:
>> - Split into patch 1/6, patch 2/6.
>> - The
>>   drivers/pci/pci.c             | 10 ++++++----
>>   include/uapi/linux/pci_regs.h |  2 ++
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 4d7c9f64ea24..1c29e8f20cb5 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -9,6 +9,7 @@
>>    */
>>   
>>   #include <linux/acpi.h>
>> +#include <linux/align.h>
>>   #include <linux/kernel.h>
>>   #include <linux/delay.h>
>>   #include <linux/dmi.h>
>> @@ -30,6 +31,7 @@
>>   #include <asm/dma.h>
>>   #include <linux/aer.h>
>>   #include <linux/bitfield.h>
>> +#include <uapi/linux/pci_regs.h>
> 
> linux/pci.h will pull this in through <uapi/linux/pci.h> so you don't need
> to add it (basically anywhere).
> 
>>   #include "pci.h"
>>   
>>   DEFINE_MUTEX(pci_slot_mutex);
>> @@ -432,17 +434,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>>   	pci_bus_read_config_byte(bus, devfn, pos, &pos);
>>   
>>   	while ((*ttl)--) {
>> -		if (pos < 0x40)
>> +		if (pos < PCI_STD_HEADER_SIZEOF)
>>   			break;
>> -		pos &= ~3;
>> +		pos = ALIGN_DOWN(pos, 4);
>>   		pci_bus_read_config_word(bus, devfn, pos, &ent);
>>   
>> -		id = ent & 0xff;
>> +		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
>>   		if (id == 0xff)
>>   			break;
>>   		if (id == cap)
>>   			return pos;
>> -		pos = (ent >> 8);
>> +		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
>>   	}
>>   	return 0;
>>   }
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index ba326710f9c8..b59179e1210a 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -206,6 +206,8 @@
>>   /* 0x48-0x7f reserved */
>>   
>>   /* Capability lists */
>> +#define PCI_CAP_ID_MASK		0x00ff
>> +#define PCI_CAP_LIST_NEXT_MASK	0xff00
> 
> Consider adding a comment after the value as is done for most  defines in
> this file.

Dear Ilpo,

Thank you very much for your reply. Will add.

Best regards,
Hans

> 
>>   
>>   #define PCI_CAP_LIST_ID		0	/* Capability ID */
>>   #define  PCI_CAP_ID_PM		0x01	/* Power Management */
>>
> 



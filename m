Return-Path: <linux-pci+bounces-28868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF53ACCA60
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251603A4962
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CEC23C513;
	Tue,  3 Jun 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OYL3r/5n"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89B140E34;
	Tue,  3 Jun 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965371; cv=none; b=N+bAztdhWfwrheQaC6ifwOB4zMP5TcFSIbpWEVFR4GfP4WukuLXEed1R/joA9Rokn8Ffc1w3TQPcvPOXQrC0Rw2peO6AaCwNg6k/p2giuS7CJR5GNZkPRRyOKXZSkZso/xKiy5TlurYdSyDyoAxObDIuiZ7nJ3Qvr3Jqkpj0NPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965371; c=relaxed/simple;
	bh=hB2MxKwPMC076JO0hAISW1ZoTMbJR5Sgkfl2WQ0MtT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxeaabTJC7xCtk+ekhV6HxEQK6p1k8pF4SNa8spq/JxPHet1AvlE4SYWtZsznh1dxe4gcEX/sTRi9lSiEnVGAQRpB67Ri0Wa0dlYSKdFABsTfrA3MxlLnL55MLi1bUSyElGmG0xQzZ1hTt4NKAuWOuT0vvqhsMDacKdC8ahJDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OYL3r/5n; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zQkvIuzbpkgJBUTC9lp/MUGV2IMSjKUSaK9yLyoEtoY=;
	b=OYL3r/5n2J3JAxmZgSRSmPeYfISQF2dh7KkHVmlx+z0z7hr5sQwKBunocLxVFp
	I8Dm1OkKnkBedcDSWR1MFLDeItyzFGhGNg2bTnbib12y6x4Y/Wi9NBynJwPf9HP2
	0PQweRZpd3TUOEXbFhQl8OGWSvKGw8VnPgX2QELop2tSE=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBH59fYFz9oh8TjFg--.7625S2;
	Tue, 03 Jun 2025 23:42:17 +0800 (CST)
Message-ID: <5ce7f320-7a50-475a-9406-ace4af47192b@163.com>
Date: Tue, 3 Jun 2025 23:42:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/6] PCI: Clean up __pci_find_next_cap_ttl()
 readability
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250514161258.93844-1-18255117159@163.com>
 <20250514161258.93844-3-18255117159@163.com>
 <987609ec-7a1b-057c-1e3b-8bf564965036@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <987609ec-7a1b-057c-1e3b-8bf564965036@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH59fYFz9oh8TjFg--.7625S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrKw18tw1xCw4fXrWfuFg_yoW5XF1fpr
	98C3ZFyF48JFWjka1v93ZxJF12q3WDtrW8GryYg3s8XFy2yF18KFs2kryYvFnrZrZ7uF1F
	qFWqv3s5uF90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRgtxDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhBho2g-EXSmOAABsF



On 2025/6/3 17:30, Ilpo Järvinen wrote:
> On Thu, 15 May 2025, Hans Zhang wrote:
> 
>> Refactor the __pci_find_next_cap_ttl() to improve code clarity:
>> - Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
>> - Use ALIGN_DOWN() for position alignment instead of manual bitmask.
>> - Extract PCI capability fields via FIELD_GET() with standardized masks.
>> - Add necessary headers (linux/align.h).
>>
>> The changes are purely non-functional cleanups, ensuring behavior remains
>> identical to the original implementation.
> 
> If you want a simpler wording for this, this is often used:
> 
> No functional changes intended.

Dear Ilpo,

Will change.

> 
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v11:
>> - None
>>
>> Changes since v10:
>> - Remove #include <uapi/linux/pci_regs.h> and add macro definition comments.
>>
>> Changes since v9:
>> - None
>>
>> Changes since v8:
>> - Split into patch 1/6, patch 2/6.
>> - The
>> ---
>>   drivers/pci/pci.c             | 9 +++++----
>>   include/uapi/linux/pci_regs.h | 2 ++
>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e77d5b53c0ce..27d2adb18a30 100644
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
>> @@ -432,17 +433,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
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
>> index ba326710f9c8..35051f9ac16a 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -206,6 +206,8 @@
>>   /* 0x48-0x7f reserved */
>>   
>>   /* Capability lists */
>> +#define PCI_CAP_ID_MASK		0x00ff	/* Capability ID mask */
>> +#define PCI_CAP_LIST_NEXT_MASK	0xff00	/* Next Capability Pointer mask */
>>   
>>   #define PCI_CAP_LIST_ID		0	/* Capability ID */
> 
> I'd add those here with the extra space before name and add empty line in
> between them and the capability id list.
> 

Will change.


Best regards,
Hans

>>   #define  PCI_CAP_ID_PM		0x01	/* Power Management */
>>
> 



Return-Path: <linux-pci+bounces-27010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D9AA1073
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FD51BA1445
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64622157F;
	Tue, 29 Apr 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VFTqFMRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5361221F35;
	Tue, 29 Apr 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940411; cv=none; b=JUyGHKlFt4YgzoCmlvyt83TnEa4MLhtVZ2E2Kzapni467JMDWY/b1ddZ5sjfI+oZDZM7NXQxafn7I3bMcFhfxxMbYeHx0aBAj62xCiz7hIVcRvskblAZWhQhY85ctEYsuwLkLweMBTEi60Z8LH9O2PMhhpMhM1ob31WAYSFNsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940411; c=relaxed/simple;
	bh=Ocdg9p1ctJ34kTikV98uKisN6axye0zRmxXT2hdowhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fq185f5/8LDXaadCmoK5/d4640BTVbopKBFPWMQsCjM1PA7Y+May3rsxrslgHCGuZFmJWiODliK7d4Wzc6Jv4wHqa/YciLM+ux46Np/plkV9rgECIqvUWKcIa6jcMpA6GhYqc7RIUnpTDYaHhCl/07I3xKMlZFe1yanhnkvbHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VFTqFMRE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=iM10/XhGFlmUW9vhdC/BAbzUo2I7KWviLdph8pwrgag=;
	b=VFTqFMREl4GnHzlZaiymepapo5fUzjBU3hbZqrIFBdnyH4eeq5oHU2jOEU8W+1
	cUEDwHiWMKr8RryF5uRU7+uZPhPfg/TwM6QqOkOysOCdfOY4dFXq/TLdjPYl9pRa
	4eX6dmJ5waGgN2zVneW+uJlyYwNYQJHWwUngPntgiBWXE=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXNCqX7xBoGqqMDQ--.8760S2;
	Tue, 29 Apr 2025 23:26:15 +0800 (CST)
Message-ID: <4ee5d1cd-bf48-48d4-aa9c-051c5103bc0c@163.com>
Date: Tue, 29 Apr 2025 23:26:15 +0800
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
X-CM-TRANSID:_____wDXNCqX7xBoGqqMDQ--.8760S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8db1UUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwA+o2gQ5kbo+wAAsN



On 2025/4/29 23:17, Ilpo Järvinen wrote:
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

Dear Ilpo,

Will delete.

Best regards,
Hans



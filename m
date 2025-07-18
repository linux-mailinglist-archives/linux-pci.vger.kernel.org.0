Return-Path: <linux-pci+bounces-32546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0270AB0A90E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C013A19A6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591FD2E7649;
	Fri, 18 Jul 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuzfHFed"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519B2E7187
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858384; cv=none; b=ZrwMDVZ54H2icWTaJL7f77gqxb25zyhKTzXpOtwHZ6CLfRUC10yImGeYoQcR1xICArXgAvTntQVwe4Jf1fvI+tR1oMy4KhTmNqLQvNqkpPQZJygqVuaT9oIE2t9fLBXn6DPwRVMcD7SlNxabz8jdXqxBFlt8KU1E/abEW82z7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858384; c=relaxed/simple;
	bh=zWZp+q0wKlmDF9f9ZD3wJgEJPTkG7pa/13R+7XMWIMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Isy0+XlwoSebUEldkpSsujBscfyZC9JppccgB8GiNt0SdO+ZwpHCIVkoZIu/t1pPxZbgmQSizYcrS1QLtesKq7d2InVRqGhO9tssATovgxVoxI9p2Wk1gEkPAwe5h9YtQfBvk3ld5MfymxKMMuThucbS2AUuQ3rhTOUAw7iaw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuzfHFed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38DC4CEF7;
	Fri, 18 Jul 2025 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858384;
	bh=zWZp+q0wKlmDF9f9ZD3wJgEJPTkG7pa/13R+7XMWIMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EuzfHFedsjdt1+ok6Ex/h6mp2dt5KOvn++IXb14LRmI5Ja7ncY1av6/AJsXSzhUGH
	 cD22OUPSanbbBZxe0nXGPIb//hByiJbSjYiJTh3pQibvXjRpsZ4gFG4iNazX81S4AF
	 ge32oG2PgKA98jbjaws49/oYrQuBkXHYjIbc1d4qNSU75NXuLrrN7i/qXmXsY2uGDh
	 8vO3ssHmzNgyiUMvRx8NLAs6QpP/CaBeDGuXiuQ5BjbAmEk5ksY93ehWTy3MI3FYxU
	 mDs5HBt9uue9xJObKTODr/t5eng9WTVDB9M0exvZnBFNh1ziZIdbzPlv/O8A9uxT/t
	 tljCIz5jaa3og==
Message-ID: <b15cf1f2-7155-413a-973a-d632e5170596@kernel.org>
Date: Fri, 18 Jul 2025 12:06:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix warning without CONFIG_VIDEO
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
References: <20250718134134.1710578-1-superm1@kernel.org>
 <rdqrqwoye3b4tut4mgqckshmlslycg2weyleasduxawhyoifq6@pyykudf4ncke>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <rdqrqwoye3b4tut4mgqckshmlslycg2weyleasduxawhyoifq6@pyykudf4ncke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/2025 12:00 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 08:41:33AM GMT, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
>> never create a sysfs file for boot_display. Guard the sysfs file
>> declaration against CONFIG_VIDEO.
>>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 6b1a0ae254d3a..f6540a72204d3 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
>>   	NULL,
>>   };
>>   
>> +#ifdef CONFIG_VIDEO
>>   static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
>>   				 char *buf)
>>   {
>>   	return sysfs_emit(buf, "1\n");
>>   }
>>   static DEVICE_ATTR_RO(boot_display);
> 
> I failed to give my comment during the offending series itself, but it is never
> late than never. Why are we adding non-PCI attributes under bus/pci in the first
> place? Though the underlying device uses PCI as a transport, only the PCI bus
> specific attrbutes should be placed under bus/pci and the driver/peripheral
> specific attrbutes should belong to the respective bus/class/device hierarchy.
> 
> Now, if other peripherals (like netdev) start adding these device specific
> attributes under bus/pci, it will turn out to be a mess.
> 
> - Mani
> 

It was mostly to mirror the location of where boot_vga is, which 
arguably has the same issue you raise.

I would be incredibly surprised if there was a proposal to add a 
'boot_display' attribute from netdev..


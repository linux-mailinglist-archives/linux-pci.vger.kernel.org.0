Return-Path: <linux-pci+bounces-32660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE114B0C79C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0DA3B66B3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB952DFF17;
	Mon, 21 Jul 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFb5cYLB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9E2D1301
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111740; cv=none; b=Cc2Vopzz22FPXMSwEBWQzTR1BcVvarkhFteCbLrA68agql4F6VfXfnI8PwwIE1eNZXMU9AbORJXF9hEDxelUc+/YJ2pNXK51LRwEEEjl7r+vlit5JJWzP9ZaBeRsWq39YmQTZsXD8yFPFiyKbm5pCpZchJa4Z5QCS1UTFj5goM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111740; c=relaxed/simple;
	bh=2g/acu3UuslQU6OldpYLm1rIR6R5quqCWxEj7tujaJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIYgYi82SZglsE2CjgKcXliwUJdcbsPPBr+s2QFJkOKRC/wU0/plnUCSVEg6hYF/ShVrZu3g3immI8IINvdE955ckkkG4ZWgZKKZop9SKHOQVSiIgmx2eze1pFzEqUTGFCrjHBYYUHoK9jImnPYklfbpdC3REfPnBhV1V0krG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFb5cYLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E72C4CEED;
	Mon, 21 Jul 2025 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111739;
	bh=2g/acu3UuslQU6OldpYLm1rIR6R5quqCWxEj7tujaJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QFb5cYLBhYnblDYPCGe6vCXEakk3B3xrq7Md3rcaOxtGiwKOKpG3xGaEoEk++x+sd
	 lCcTPZo5B5G1jvnyqH3I7gcTrrpjVA/ogVMcHI7syTobfmLZqlxGKL3LZMC4Bz3FVL
	 oH3PHtpuhiJQ3DOhvKojMHHm/zxZhmh0oAA4eizHcTmoic0Ly2piWCyvQuzhg2P5gA
	 xqet2Q/cLQfzpfwSfE3daCuh3j2FCUC+XmV/PqquUIvUf2kakOHgoRP0kPohsIQd5P
	 9CR9IWb24J+5iRd1CVRjCWKSZ6vx2qZg9ezN/E5S15LVbyu9nY+PpwrkpKwhGAmUaq
	 px/+REgNxg67w==
Message-ID: <119a8f09-a326-45fb-aeca-9d2f37fe36c7@kernel.org>
Date: Mon, 21 Jul 2025 10:28:58 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Adjust visibility of boot_display attribute
 instead of creation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
References: <20250720151551.735348-1-superm1@kernel.org>
 <20250721105744.000046bc@huawei.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250721105744.000046bc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/25 4:57 AM, Jonathan Cameron wrote:
> On Sun, 20 Jul 2025 10:15:08 -0500
> Mario Limonciello <superm1@kernel.org> wrote:
> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> There is a desire to avoid creating new sysfs files late, so instead
>> of dynamically deciding to create the boot_display attribute, make
>> it static and use sysfs_update_group() to adjust visibility on the
>> applicable devices.
>>
>> This also fixes a compilation warning when compiled without
>> CONFIG_VIDEO on sparc.
>>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Leaving aside the 'where to call it' discussions, a few bits of feedback on the
> code. See inline.
> 

Thanks!

> 
>> ---
>> v2:
>>   * Change to sysfs_update_group() instead
>> ---
>>   drivers/pci/pci-sysfs.c | 59 +++++++++++++++++------------------------
>>   1 file changed, 25 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 6b1a0ae254d3a..462a90d13eb87 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1059,37 +1059,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
>>   }
>>   #endif /* HAVE_PCI_LEGACY */
>>   
>> -/**
>> - * pci_create_boot_display_file - create a file in sysfs for @dev
>> - * @pdev: dev in question
>> - *
>> - * Creates a file `boot_display` in sysfs for the PCI device @pdev
>> - * if it is the boot display device.
>> - */
>> -static int pci_create_boot_display_file(struct pci_dev *pdev)
>> -{
>> -#ifdef CONFIG_VIDEO
>> -	if (video_is_primary_device(&pdev->dev))
>> -		return sysfs_create_file(&pdev->dev.kobj, &dev_attr_boot_display.attr);
>> -#endif
>> -	return 0;
>> -}
>> -
>> -/**
>> - * pci_remove_boot_display_file - remove the boot display file for @dev
>> - * @pdev: dev in question
>> - *
>> - * Removes the file `boot_display` in sysfs for the PCI device @pdev
>> - * if it is the boot display device.
>> - */
>> -static void pci_remove_boot_display_file(struct pci_dev *pdev)
>> -{
>> -#ifdef CONFIG_VIDEO
>> -	if (video_is_primary_device(&pdev->dev))
>> -		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_boot_display.attr);
>> -#endif
>> -}
>> -
>>   #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
>>   /**
>>    * pci_mmap_resource - map a PCI resource into user memory space
>> @@ -1691,6 +1660,29 @@ static const struct attribute_group pci_dev_resource_resize_group = {
>>   	.is_visible = resource_resize_is_visible,
>>   };
>>   
>> +static struct attribute *pci_display_attrs[] = {
>> +	&dev_attr_boot_display.attr,
>> +	NULL,
> 
> Trivial but I'd drop the comma after the NULL. It's at terminating entry and
> we don't want it to be easy to add stuff after it!

Thanks!
Sounds sensible.  If I spin a v4 keeping it in pci-sysfs.c I'll drop it.

> 
>> +};
>> +
>> +static umode_t pci_boot_display_visible(struct kobject *kobj,
>> +					struct attribute *a, int n)
>> +{
>> +#ifdef CONFIG_VIDEO
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	if (a == &dev_attr_boot_display.attr && video_is_primary_device(&pdev->dev))
> Is video_is_primary_device() stubbed out on !CONFIG_VIDEO?
> 
> There seems to be a stub in include/asm-generic/video.h
> 
> If it always is, drop the ifdef guards whilst you are here as the compiler
> can see that and remove the code anyway.
> 

I feel like there was a reason for this from earlier in the versions of 
the series introducing boot_display, but with how things are now I think 
you're right.

I'll do some test builds without CONFIG_VIDEO set to convince myself.

> 
>> +		return a->mode;
>> +#endif
>> +	return 0;
>> +}
>> +
>> +static const struct attribute_group pci_display_attr_group = {
>> +	.attrs = pci_display_attrs,
>> +	.is_visible = pci_boot_display_visible,
>> +};
>> +
>>   int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>>   {
>>   	int retval;
>> @@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>>   	if (!sysfs_initialized)
>>   		return -EACCES;
>>   
>> -	retval = pci_create_boot_display_file(pdev);
>> +	retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -1716,7 +1708,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
>>   	if (!sysfs_initialized)
>>   		return;
>>   
>> -	pci_remove_boot_display_file(pdev);
>>   	pci_remove_resource_files(pdev);
>>   }
>>   
>> @@ -1755,7 +1746,6 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>>   
>>   	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>>   		return a->mode;
>> -
> Unrelated change.
Thanks, that snuck in when I was rearranging and I totally missed it.
I dropped it in v3.

> 
>>   	return 0;
>>   }
>>   
>> @@ -1845,6 +1835,7 @@ static const struct attribute_group pcie_dev_attr_group = {
>>   
>>   const struct attribute_group *pci_dev_attr_groups[] = {
>>   	&pci_dev_attr_group,
>> +	&pci_display_attr_group,
>>   	&pci_dev_hp_attr_group,
>>   #ifdef CONFIG_PCI_IOV
>>   	&sriov_pf_dev_attr_group,
> 



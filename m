Return-Path: <linux-pci+bounces-37541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9551BB6F77
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AC53345BF5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53072145A05;
	Fri,  3 Oct 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="e8/5q6r2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCF35942
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497499; cv=none; b=B4wsNLi0rSOWQCN1Y4GsHjkKL7+X7gx6KQ3j9eoP68UnHLYIGPBgKu7y91tu1HZfGR22yOnMvDyPRJuYHx4PAy7l/yAR1HQC0MwZiTxr/feB5ThVfdkT263Y7VF9CNO2DBCWoLhXJfkA5IDqQ9X+NeTyfpimqbTTI8UqIXxGVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497499; c=relaxed/simple;
	bh=pGdrEcqpje2NTQWu37aM/RqYR9TY3cPIGZNvXOSgwUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN8iuZQXMWXZbCoCd8bqiq5m5pertR6WBhDOlT08on+icw+33e5+2iQfo8DsL9P0nK1SOvQjHiAoaI4NpAeDFCpIa7bqJjYchUkg+z9Zrtog73+6xq1OWYuQX45+/9kaNvtJIGwhmKr3VIUg129FgPJdd5QZpHCIn3VqIYZVcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=e8/5q6r2; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cdTkG49j8z4DL6;
	Fri,  3 Oct 2025 09:18:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759497495; bh=pGdrEcqpje2NTQWu37aM/RqYR9TY3cPIGZNvXOSgwUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e8/5q6r2qUXtCDkJgrVRneYWdyt7pS0f8ubYxJY3mpXJgnC84SjQ73P1GUXOBu7jY
	 3PTVq4O7lWEm7P6jNfCciyw6FIxTDxdpK0kBPjOWa9ea9lMY7bNsmsFRFVPQeIr94J
	 sYXCjw1V4o6/O55IS3WJlTKz4a5hrDR+bnNk1qaw=
Message-ID: <7a21fb05-f7bd-4010-8488-10870b404bbc@panix.com>
Date: Fri, 3 Oct 2025 06:18:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>,
 "David E. Box" <david.e.box@linux.intel.com>, Kenneth C <kenny@panix.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
 <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
 <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
 <b955d5a6-5553-4659-b02a-a763993fcd82@panix.com>
 <wfdzfzzemspxjecijckhrzurdfuxebnxff4lyyrcw4zrqcxio5@z4uaz3hcty6f>
 <69a89a6f-1708-4e34-86a4-f8f3a74e4da2@panix.com>
 <qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


That seems to have done the trick, thank you.

LMK when you need me to test the formal solution.

BTW, the VMD has been somewhat problematic (for unrelated PM reasons), 
so I've added the/a VMD devel (David Box) to this discussion, in case 
you guys should sync up.

-Kenny

On 10/3/25 05:01, Inochi Amaoto wrote:
> On Thu, Oct 02, 2025 at 10:36:35PM -0700, Kenneth Crudup wrote:
>>
>> On 10/2/25 19:03, Inochi Amaoto wrote:
>>
>>> Weird, this seems like affects more than the vmd itself.
>>> I think I need to know hierarchical information of the irq
>>> controller. Can you do me a favor for rebuilding a kernel
>>> with CONFIG_GENERIC_IRQ_DEBUGFS enabled and check the
>>> irq information under /sys/kernel/debug/irq/. Any of the
>>> vmd irq and NVMe irq should show the information for it.
>>>
>>> Regards,
>>> Inochi
>>>
>>
>> /proc/interrupts and egrep -r . /sys/kernel/debug/irq attached.
>>
>>
>> Also, FWIW if I revert back to the commit in the Subject (but no further),
>> and comment out the
>> .irq_startup entry in the MSIX msi_domain_template struct, the system boots
>> normally.
>>
> 
> I think I know why, the reason for this behavior is because I register
> the irq_startup and irq_shutdown in the template msi domain, which is
> called in the irq_startup() and irq_shutdown() and mask the enable/disable
> callback.
> 
> And there is a diff for you to verify what I say (Just for verification,
> not a formal patch), it should work for you.
> 
> ```
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 1bd5bf4a6097..8abca46c9b73 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -309,6 +309,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>   	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
>   		return false;
>   
> +	info->chip->irq_startup		= NULL;
> +	info->chip->irq_shutdown	= NULL;
>   	info->chip->irq_enable		= vmd_pci_msi_enable;
>   	info->chip->irq_disable		= vmd_pci_msi_disable;
>   	return true;
> ```
> 
> If this is worked, I think I should find an formal way to adapt the
> new behavior. (convert this into startup/shutdown or maybe mask/umask).
> 
> Regards,
> Inochi
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA



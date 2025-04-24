Return-Path: <linux-pci+bounces-26687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C2A9AFEF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B80168731
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6418FC89;
	Thu, 24 Apr 2025 13:58:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C51624E9;
	Thu, 24 Apr 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503129; cv=none; b=mgQXdT/UgktYbNIRRhuYFDhIGzfz8lp/PWRYZ8K5G7oKhC2fKIZDXLj86ikb7ChSsYMK2sG0jQ3jD1pClTbv6oNdCzN2YJjxzdK/RfnHEfqJ5kZel11OuvuRBBrnBqJpV0OBxOtgU/fhnxsBA1RYFoncF2DoHm59YP0wyVH6A0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503129; c=relaxed/simple;
	bh=GKD+gkPElawo8czkMB4gd9u+/i+vf91GGYLhQ7q/F6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rod71oaXq9jIFsgz/Wu4KuYUQD+4OC2DVNvg8aoxGv7Sx+5CJefr7Pr2bu+20XOcWsWGmsqAPmWz+DDAv2MTEJaDheZp/Qxt3H+UCAQjahj0+VZhD0hBROerYdONcKlB9g+1ZNJE25ZajOEEmn2NGdJawRcihzHpUWImK6+0r30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B13781063;
	Thu, 24 Apr 2025 06:58:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AB5A3F66E;
	Thu, 24 Apr 2025 06:58:41 -0700 (PDT)
Message-ID: <f55869ea-0a96-4cef-b394-7c6bf0359617@arm.com>
Date: Thu, 24 Apr 2025 14:58:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Johan Hovold <johan@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z_jMiC1uj_MJpKVj@hovoldconsulting.com>
 <50a06ba8-0a99-40d2-8601-778ebf451f6a@arm.com>
 <Z_52heGno2Y5M6uF@hovoldconsulting.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z_52heGno2Y5M6uF@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2025 4:08 pm, Johan Hovold wrote:
> On Mon, Apr 14, 2025 at 04:37:59PM +0100, Robin Murphy wrote:
>> On 2025-04-11 9:02 am, Johan Hovold wrote:
>>> On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> 
>>>> @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>>>>    		dev_iommu_free(dev);
>>>>    	mutex_unlock(&iommu_probe_device_lock);
>>>>    
>>>> -	if (!err && dev->bus)
>>>> +	/*
>>>> +	 * If we're not on the iommu_probe_device() path (as indicated by the
>>>> +	 * initial dev->iommu) then try to simulate it. This should no longer
>>>> +	 * happen unless of_dma_configure() is being misused outside bus code.
>>>> +	 */
>>>
>>> This assumption does not hold as there is nothing preventing iommu
>>> driver probe from racing with a client driver probe.
>>
>> Not sure I follow - *this* assumption is that if we arrived here with
>> dev->iommu already allocated then __iommu_probe_device() is already in
>> progress for this device, either in the current callchain or on another
>> thread, and so we can (and should) skip calling into it again. There's
>> no ambiguity about that.
> 
> I was referring to the this "should no longer happen unless
> of_dma_configure() is being misused outside bus code" claim, which
> appears to be false given the splat below.

That's not an assumption so much as a statement of intent. And really 
it's the other way round anyway, as a reminder that this replay call is 
only still here (unlike in the ACPI path) because there *is* still 
plenty of sketchy usage of of_dma_configure() which I'm wary of breaking.
>>>> +	if (!err && dev->bus && !dev_iommu_present)
>>>>    		err = iommu_probe_device(dev);
>>>>    
>>>>    	if (err && err != -EPROBE_DEFER)
>>>
>>> I hit the (now moved) dev_WARN() on the ThinkPad T14s where the GPU SMMU
>>> is probed late due to a clock dependency and can end up probing in
>>> parallel with the GPU driver.
>>
>> And what *should* happen is that the GPU driver probe waits for the
>> IOMMU driver probe to finish. Do you have fw_devlink enabled?
> 
> Yes, but you shouldn't rely on devlinks for correctness.
> 
> That said it does seem like something is not working as you think it is
> here, and indeed the iommu supplier link is not created until SMMUv2
> probe_device() (see arm_smmu_probe_device()).
> 
> So client devices can start to be probed (bus dma_configure() is called)
> before their iommu is ready also with devlinks enabled (and I do see
> this happen on every boot).

I didn't mean the explicit power management links created by the SMMU 
driver itself, I meant the fwnode links created automatically by 
fw_devlink_link_device() at device_add() time, which infer a 
supplier-consumer relationship from the "iommus" DT property, wherein 
device_links_check_suppliers() would then defer the GPU driver probe 
until the SMMU driver probe has completed successfully probing and 
called device_links_driver_bound().

Except it turns out that "iommus" is one of the optional properties 
which are only linked that way under "fw_devlink=strict", so that 
explains that, fair enough.
>>> [    3.805282] arm-smmu 3da0000.iommu: probing hardware configuration...
> 
>>> [    3.829042] platform 3d6a000.gmu: Adding to iommu group 8
>>>
>>> [    3.992050] ------------[ cut here ]------------
>>> [    3.993045] adreno 3d00000.gpu: late IOMMU probe at driver bind, something fishy here!
>>> [    3.994058] WARNING: CPU: 9 PID: 343 at drivers/iommu/iommu.c:579 __iommu_probe_device+0x2b0/0x4ac
>>>
>>> [    4.003272] CPU: 9 UID: 0 PID: 343 Comm: kworker/u50:2 Not tainted 6.15.0-rc1 #109 PREEMPT
>>> [    4.003276] Hardware name: LENOVO 21N2ZC5PUS/21N2ZC5PUS, BIOS N42ET83W (2.13 ) 10/04/2024
>>>
>>> [    4.025943] Call trace:
>>> [    4.025945]  __iommu_probe_device+0x2b0/0x4ac (P)
>>> [    4.030453]  iommu_probe_device+0x38/0x7c
>>> [    4.030455]  of_iommu_configure+0x188/0x26c
>>> [    4.030457]  of_dma_configure_id+0xcc/0x300
>>> [    4.030460]  platform_dma_configure+0x74/0xac
>>> [    4.030462]  really_probe+0x74/0x38c
>>
>> Indeed this is exactly what is *not* supposed to be happening - does
>> this patch help at all?
>>
>> https://lore.kernel.org/linux-iommu/09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com/
> 
> I've only seen that splat once so far so I don't have a reliable
> reproducer.
> 
> But AFAICS that patch won't help help here where we appear to have iommu
> probe racing with bus dma_configure() called from really_probe() for the
> client device.

Well, tightening up __iommu_probe_device() would stand to slightly 
reduce the window in general while bus_set_iommu() is running. However 
you're right that this is a different race from the ones implicated 
there. I have now managed to provoke it on my Juno board with 
"driver_async_probe=*" (which does also require that patch for other 
reasons), and I think I've got a reasonable fix which I shall finish 
writing up and send shortly. Thanks for helping me nail this one down!

Cheers,
Robin.


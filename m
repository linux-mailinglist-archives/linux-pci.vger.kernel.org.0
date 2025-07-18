Return-Path: <linux-pci+bounces-32551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32FB0A96C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00441C81C4D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBEC2E7177;
	Fri, 18 Jul 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAlCdLTv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFA2DCF4A
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859611; cv=none; b=BvsZJAn2P4OXlUb7tbRbuum3RzJfrElX+r6vAUccI3sLd4fc4v/Q4b3zwK3mBcWeb1Np/Z2/m+FTxiRp0axJPpPUyfDxfn/QId+6X1cIBHuEr9o6lAcoZFK8NfDsi8n2LNMGdQlOUg+2JcMyPQImKWMbzS4DpFdqhFqku/6a1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859611; c=relaxed/simple;
	bh=8g7IrQcwl+6yXKAZxs2GmeVGt44lDoVaNhNbJ8JIL7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bp3hehZyT8lUyANtqjTAgKwzpoiYnxmO1hLLKIz+X2EqHBVYezEdclxuagX6JgCXO8jfyhkuviA1KIkkbVmiFb2nTnbRdoSt2xWXa0NHCTDNRgSbWLRXNvG6vzTovlgyU+riTKvsxmQ8PRsoVzmqG0YTvOfOA2ZuPJ/DyufHukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAlCdLTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73759C4CEED;
	Fri, 18 Jul 2025 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752859611;
	bh=8g7IrQcwl+6yXKAZxs2GmeVGt44lDoVaNhNbJ8JIL7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VAlCdLTvllkkGBUwxEo63u3TPIrCVyVTYpQOWZktUw/T9fmf3k5mCxrsZFEQyr+zw
	 i3+Ui8xgi5WpGX4WN1NC7ZL64K5VutSsuwUAnDggWxm4NABC1h0M3m77A1pzRErKFm
	 92EmJuM45VwdjwVRiliwPes8G8WCWfD0D2eKRHFJVuBDGLvmSHseqz3MvOnrk685XH
	 MjTNXbCjFjuJt10+fHEu9my5tRtyE9pdFXFakumm3w0CF9mm2u2Ecl07dwtmLujZE3
	 z6y02f0kqiXctkqgZboez6d9GVZCCwOvAh3aZ6ZrR6LkV0mMgyF1WOqryFGlGZ57w6
	 CWatml1lgwldw==
Message-ID: <ca34c473-579b-4991-984d-4e037005c979@kernel.org>
Date: Fri, 18 Jul 2025 12:26:49 -0500
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
 <b15cf1f2-7155-413a-973a-d632e5170596@kernel.org>
 <hwdswlzbejlrawrrsgdlqtmzb6437kyei4hl5uqpe24orey2qd@2u7i7dzkhfyu>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <hwdswlzbejlrawrrsgdlqtmzb6437kyei4hl5uqpe24orey2qd@2u7i7dzkhfyu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/2025 12:23 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 12:06:22PM GMT, Mario Limonciello wrote:
>> On 7/18/2025 12:00 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Jul 18, 2025 at 08:41:33AM GMT, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
>>>> never create a sysfs file for boot_display. Guard the sysfs file
>>>> declaration against CONFIG_VIDEO.
>>>>
>>>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>>> Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/pci/pci-sysfs.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>> index 6b1a0ae254d3a..f6540a72204d3 100644
>>>> --- a/drivers/pci/pci-sysfs.c
>>>> +++ b/drivers/pci/pci-sysfs.c
>>>> @@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
>>>>    	NULL,
>>>>    };
>>>> +#ifdef CONFIG_VIDEO
>>>>    static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
>>>>    				 char *buf)
>>>>    {
>>>>    	return sysfs_emit(buf, "1\n");
>>>>    }
>>>>    static DEVICE_ATTR_RO(boot_display);
>>>
>>> I failed to give my comment during the offending series itself, but it is never
>>> late than never. Why are we adding non-PCI attributes under bus/pci in the first
>>> place? Though the underlying device uses PCI as a transport, only the PCI bus
>>> specific attrbutes should be placed under bus/pci and the driver/peripheral
>>> specific attrbutes should belong to the respective bus/class/device hierarchy.
>>>
>>> Now, if other peripherals (like netdev) start adding these device specific
>>> attributes under bus/pci, it will turn out to be a mess.
>>>
>>> - Mani
>>>
>>
>> It was mostly to mirror the location of where boot_vga is, which arguably
>> has the same issue you raise.
>>
> 
> Yes, I agree. But 'boot_vga' has set a bad precedence IMO.
> 
>> I would be incredibly surprised if there was a proposal to add a
>> 'boot_display' attribute from netdev..
> 
> Not 'boot_display' but why not 'boot_network' or something else. I was just
> merely pointing out the fact that the other subsystems can start dumping
> device/usecase specific attributes under bus/pci.
> 
> - Mani
> 

This is a pretty general problem that exists that attributes are first 
come first served.  For example amdgpu adds mem_busy_percent and it has 
certain semantics.  Now PCI core can't add that.

And if nouveau.ko wants to add the same thing they need to follow the 
same semantics because userspace will look for those.


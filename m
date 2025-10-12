Return-Path: <linux-pci+bounces-37858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E9BD0A5A
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 21:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275B81891A2C
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86486295DB8;
	Sun, 12 Oct 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koUnk/1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A41A275;
	Sun, 12 Oct 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760296019; cv=none; b=m6TIoNzivCwGoOu7MF2xxyO/Ww4dmIloRFmUo3ErR02i5u3hdpC9is4I6gS6oGjp3Jd9vlh+jjBWOx/QTda+2Dx6S5rcAkqLU5QmCYKFCKXxzfTGFQV31A22O8MU/ri+UDaha8Y059OEm4/Tz7bUg0KFzer6GPPJ2A5Z/2ddZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760296019; c=relaxed/simple;
	bh=DnR0msbAZQb+cqUGYPlAa9RGqHdYtjRoz9MBPzHQDIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPM7ox2ww5A9tt1cvzgsjLJZInFSR+tqeUDSM6qSGDAZfK5QKF8NngBSxfpOkmjRHBCfnqmuJqStRnOp7HmTXW2I4Sv9eAY+wdrbybAIaDKGX03Ya3AnjMsw6i5I7qxCmXDIIsjpJSy5tOG6xFHWHazIm8ENJnPMazCCppANQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koUnk/1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D5C4CEE7;
	Sun, 12 Oct 2025 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760296018;
	bh=DnR0msbAZQb+cqUGYPlAa9RGqHdYtjRoz9MBPzHQDIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koUnk/1MK6Oa1TymZBtnRqXIiDLZyuCW5goUBwiCYEdMIsu3ki0zr5T2RYMPjZsZ6
	 CuNpcNu6da6S/LH0gASrPQSh+yGvJC79jELyQ+vBanWk/QPdKMXbYYbUUr3+EczDL0
	 Mi48QmgwAZF2GBDufa3xPISdwziEpGSdwXaBPLLE+9LkrLvz9L8oO303YMb83z9K7O
	 YYLwOhOpts41G3RBqxPi3fQXy+C2bH5bYWjPTzTHZNv42VwxNOgSYkrwvqX/Ro8RbX
	 btQIZYq4INTruynJFf/9ltxXPc2H218RjqQPkNatxjMcsmybz/Z/JdwymQjUBWxvqc
	 uirkp/OlP/Hrw==
Message-ID: <65c24236-044c-4b65-baaa-dc0011ea69d8@kernel.org>
Date: Sun, 12 Oct 2025 14:06:56 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with a
 screen info check
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>
References: <20250811162606.587759-1-superm1@kernel.org>
 <20250811162606.587759-3-superm1@kernel.org> <20251012182302.GA3412@sol>
 <1be1a119-1fbd-435f-bb27-70f48d677ebf@kernel.org> <20251012184717.GB3412@sol>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251012184717.GB3412@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/25 1:47 PM, Eric Biggers wrote:
> On Sun, Oct 12, 2025 at 01:37:33PM -0500, Mario Limonciello wrote:
>>
>>
>> On 10/12/25 1:23 PM, Eric Biggers wrote:
>>> Hi,
>>>
>>> On Mon, Aug 11, 2025 at 11:26:04AM -0500, Mario Limonciello (AMD) wrote:
>>>> vga_is_firmware_default() checks firmware resources to find the owner
>>>> framebuffer resources to find the firmware PCI device.  This is an
>>>> open coded implementation of screen_info_pci_dev().  Switch to using
>>>> screen_info_pci_dev() instead.
>>>>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>
>>> I'm getting a black screen on boot on mainline, and it bisected to this
>>> commit.  Reverting this commit fixed it.
>>>
>>> Please revert.
>>>
>>> - Eric
>>
>> Can you please share more information about your issue before we jump
>> straight into a revert?  What kind of hardware do you have?  Perhaps a
>> kernel log from mainline and another from mainline with the revert could
>> help identify what's going on?
>>
>> A revert might be the right solution, but I would rather fix the issue if
>> it's plausible to do so.
> 
> Relevant hardware is:
>      AMD Ryzen 9 9950X 16-Core Processor
>      Radeon RX 9070
> 
> The following message appears in the good log but not the bad log:
> 
>      fbcon: amdgpudrmfb (fb0) is primary device
> 
> I don't have CONFIG_SCREEN_INFO enabled, so the commit changed
> vga_is_firmware_default() to always return false.

Thanks, that definitely explains it.

> 
> If DRM_AMDGPU depends on SCREEN_INFO now, it needs to select it.
> 
> - Eric

Well the question now is which driver should actually select it.

Although it manifested for you in amdgpu, I don't think this is going to 
be an amdgpu unique issue.

Maybe this:

diff --git a/drivers/video/fbdev/core/Kconfig 
b/drivers/video/fbdev/core/Kconfig
index 006638eefa41..ce2544924b0e 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -5,6 +5,7 @@

  config FB_CORE
         select VIDEO
+       select SCREEN_INFO
         tristate

  config FB_NOTIFY


Return-Path: <linux-pci+bounces-35484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F784B449BB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0482B1BC6CE8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54282E8DE9;
	Thu,  4 Sep 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvVQrcDq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8587199E94;
	Thu,  4 Sep 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025376; cv=none; b=H3tMAsVrpHCXvnNrFsB/Khto+VlCrSTyABwj0NJRpXPzoS3BCDZ7sed5XDg9HJNg4AR+UCfrr7G1+cNj+nodmpynhC5E5bBeGtGblxsuB11NFQOIym5R6NtRnkxWPc7cXBRbtIz5JhvADxkFvwR3PGECnrDI30UNOB89GgzxCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025376; c=relaxed/simple;
	bh=+jvnovwIWpaY42Wn0hYwzFOX+ztSFMbSrRlNbp+m5pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWrpvAl1vvnOeS/WZJV4tJA2hK3+D0/jU5zbPMFoz5MtSer0ojoarah4xUvzl1bdHLPZcqtwoCaptTx1mE1Ui+t6v6I+RP4N/93I2wisKvTW+A6tPzYQhC33o2IjENTjSopHm8t161rEfhBkgAcwAV7ugABSEtoctCOhlBO+RH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvVQrcDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA757C4CEF0;
	Thu,  4 Sep 2025 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757025375;
	bh=+jvnovwIWpaY42Wn0hYwzFOX+ztSFMbSrRlNbp+m5pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CvVQrcDq3NPvEgjuaZDa9bs/BwBnjKw5VBrjKhnkXLFmEo9qiljIyohhH1jzt4HqW
	 Fnc/vfz2Tr+E+ZxgviYLzeYEYrx4TzuXN7hkwwlivpQAq100wwGliU2D1c1HQ2HBW9
	 dto/FeO6g+nfb3xSXS3d9vZFuf9/NMkpkWmvNi4k1ShMzg4rTRzAgtW9y/JW85ithA
	 kMH0lmMgvOQd5cNEbIN0RZQMLx+JrGNJUIN8SfQFQUe2N14VsLUAX6suwvliDCe+FY
	 P9gHRSZtL6ENqliVfXCaCwvoI0PAAdRwegGWLryPNnLaapovKCG6YPb7sB2JqZQuqF
	 cBgA0ZLajNcfA==
Message-ID: <95c66d6c-a91e-4174-a556-9a9669d53c57@kernel.org>
Date: Thu, 4 Sep 2025 17:36:10 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] Adjust fbcon console device detection
To: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250811162606.587759-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250811162606.587759-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/2025 11:26 AM, Mario Limonciello (AMD) wrote:
> Systems with more than one GPU userspace doesn't know which one to be
> used to treat as primary.  The concept of primary is important to be
> able to decide which GPU is used for display and  which is used for
> rendering.  If it's guessed wrong then both GPUs will be kept awake
> burning a lot of power.
> 
> Historically it would use the "boot_vga" attribute but this isn't
> present on modern GPUs.
> 
> This series started out as changes to VGA arbiter to try to handle a case
> of a system with 2 GPUs that are not VGA devices and avoid changes to
> userspace.  This was discussed but decided not to overload the VGA arbiter
> for non VGA devices.
> 
> Instead move the x86 specific detection of framebuffer resources into x86
> specific code that the fbcon can use to properly identify the primary
> device. This code is still called from the VGA arbiter, and the logic does
> not change there. To avoid regression default to VGA arbiter and only fall
> back to looking up with x86 specific detection method.
> 
> In order for userspace to also be able to discover which device was the
> primary video display device create a new sysfs file 'boot_display'.
> 
> A matching userspace implementation for this file is available here:
> Link: https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/39
> Link: https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/2038
> 
> Dave Airlie has been pinged for a comment on this approach.
> Dave had suggested in the past [1]:
> 
> "
>   But yes if that doesn't work, then maybe we need to make the boot_vga
>   flag mean boot_display_gpu, and fix it in the kernel
> "
> 
> This was one of the approached tried in earlier revisions and it was
> rejected in favor of creating a new sysfs file (which is what this
> version does).
> 
> As the dependendent symbols are in 6.17-rc1 this can merge through
> drm-misc-next.
> 
> Link: https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/37#note_2938602 [1]
> 
> ---
> v10:
>   * Add patches that didn't merge to v6.17-rc1 in
>   * Move sysfs file to drm ownership
> 
> Mario Limonciello (AMD) (4):
>    Fix access to video_is_primary_device() when compiled without
>      CONFIG_VIDEO
>    PCI/VGA: Replace vga_is_firmware_default() with a screen info check
>    fbcon: Use screen info to find primary device
>    DRM: Add a new 'boot_display' attribute
> 
>   Documentation/ABI/testing/sysfs-class-drm |  8 +++++
>   arch/parisc/include/asm/video.h           |  2 +-
>   arch/sparc/include/asm/video.h            |  2 ++
>   arch/x86/include/asm/video.h              |  2 ++
>   arch/x86/video/video-common.c             | 25 +++++++++++++-
>   drivers/gpu/drm/drm_sysfs.c               | 41 +++++++++++++++++++++++
>   drivers/pci/vgaarb.c                      | 31 +++--------------
>   7 files changed, 83 insertions(+), 28 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-drm
> 
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585

DRM maintainers, can I please get a review on patch 4 [0]?  This changes 
the ABI of DRM to offer a new file, so I would like to make sure that is 
amenable.  All other patches have reviews.

In the earlier versions of this series it was done by PCI, but there was 
a push to move to DRM.

[0] 
https://lore.kernel.org/dri-devel/20250811162606.587759-5-superm1@kernel.org/#t


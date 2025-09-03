Return-Path: <linux-pci+bounces-35351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F8CB4139E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 06:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D855432B3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 04:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF692D3EFD;
	Wed,  3 Sep 2025 04:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjFXhU0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F22D3EF6;
	Wed,  3 Sep 2025 04:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874579; cv=none; b=RyRMmx+RYwWNTxF2fVaInkns8fb+YyFimaS9G6pdWIf+LMQsTzb0zVH3Z9Eoe3goWtZSbCLWanmpO9bYMnNtCjSGiBvj2eN84f3EBEwZnEytYCBcpJ2OaS1V9z+tk3QGfinV0NKtwzFBUO0geY1aUT6Q3dk5ofZIePF49O/BlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874579; c=relaxed/simple;
	bh=aWz5MDl+vUp3tC2LaOmVwlwThf5DJzTm0+LvRWNW0BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoyiMtgQL2/zhKYyD1ISj7WBvpfa6YSAF6spdP+sc9AVb1VXCUvT9oeFn0yZRRG7uuYFUiEdaEMN8lMIsD1lfsthHaOIObFSLK1t+VvO+MvhSE4XJjW1sOxG6F4mgTvITGbh19vfE1aE1HtED8h1DPm8GznYrbzzOxuQdOcvWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjFXhU0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC1AC4CEF0;
	Wed,  3 Sep 2025 04:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756874579;
	bh=aWz5MDl+vUp3tC2LaOmVwlwThf5DJzTm0+LvRWNW0BU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CjFXhU0cO5IsSRZTwXpbGzZrNsCGG3WbO57KNfS3fpMcQ6VCmn0L76qI2+Scs931C
	 kMMPcYyiw3RPL6gj0gkM/dfrL+33sX9He6/18ykz5xBTZp7QVg1PYJ3ELRLitwB/qE
	 8ctu6g6/+eo+OsuoggDLPxRpR0NgJz7HjpiHNKqOj2ts8se92yJitpiEF9w/AnQkiv
	 WyVAgHzzJqKqNOhe4e8IKfqWXaALmAuzlXRif9C8UM5S4oBeGeDLTVp4CBCiIh2zQ4
	 ewx0NUjbKG+3psobCjDMIdr2unEij/Y3e1gImlSEGCn3ksoyJ5CoOHim7SDgk2oAZ4
	 X8goCEB0EbShA==
Message-ID: <4e3d62bb-11de-4538-a244-251bd7d0d52e@kernel.org>
Date: Tue, 2 Sep 2025 23:42:57 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] Adjust fbcon console device detection
To: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>
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

Bjorn,

Any feedback for this series?

Thanks,



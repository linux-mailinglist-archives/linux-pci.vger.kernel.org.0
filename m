Return-Path: <linux-pci+bounces-35478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24631B44794
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92063BD91E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1C283FD5;
	Thu,  4 Sep 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCZ7Bgh6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B92253FB;
	Thu,  4 Sep 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018579; cv=none; b=TaQEdqoEOQjetFFrflRrvsChdK4NvHB8vbRthOa7zsBRxfbWXN2vR8JqKvzs3SfE/iFLbcZq46TYVwhu39iBtcDE9LXS/jSG476PvUQCgs7uyb3R3X20D9ihu5kWS8LSmtOT1jLAaiMm/1gXUA89sk76AXD4bLlUfsq+f+LjGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018579; c=relaxed/simple;
	bh=gl6feTJt/B+TOZvG57z5VrXnOhVpynrQD6B5PUvbN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rPGP0kmi3iNCa/lQUjSS77XiCuFkqqISze81v+Y4wo+AkyNZvF6gT7xTcgKJF5tM6qU04gPUJeFjnZ+O5XgNU2cLsmJ0T0c2lyYFUXt1YNXAiPQ6jFAidqRaLwhbYy1+8haecInqglOetpPlpgKL7dnEezXQbBrM1ALVwBdGLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCZ7Bgh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F1EC4CEF0;
	Thu,  4 Sep 2025 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757018578;
	bh=gl6feTJt/B+TOZvG57z5VrXnOhVpynrQD6B5PUvbN1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jCZ7Bgh6T2k6NL9SXYmBR+3vZgQiykuOeKOay4XKp5Ym9hPplZwgMUqiO6utxiUhH
	 BTUYEmBS5yzuMUpLe7p0j6vIealxoJE7ENcLCSZVh7JNuIa+xGaxMeZREnwHs/muLO
	 Kwz7f0WpcDpzwhzaGojx8Dwi67YZP7utHWrec3YEfoEM2UtuOnkx3gGhY7ntvHwNHi
	 1+YFt5oIHK//Dc9QVJEOoPXMgwWyHMNYMSLByyGh4VSeZQp/ghZfTF3YvlcdsyHkPF
	 tEeVXPWs1JhaNXWuE1W+FPydbcF5m67/7Gg2vZsQfHI5qroM7hsXxrqMy1kiJ079lf
	 QhMltA3H3mmhA==
Date: Thu, 4 Sep 2025 15:42:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>
Subject: Re: [PATCH v10 3/4] fbcon: Use screen info to find primary device
Message-ID: <20250904204256.GA1277756@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811162606.587759-4-superm1@kernel.org>

On Mon, Aug 11, 2025 at 11:26:05AM -0500, Mario Limonciello (AMD) wrote:
> On systems with non VGA GPUs fbcon can't find the primary GPU because
> video_is_primary_device() only checks the VGA arbiter.
> 
> Add a screen info check to video_is_primary_device() so that callers
> can get accurate data on such systems.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

I don't think you need my ack for this, but it does look fine to me.

I wish __screen_info_pci_dev() didn't have to use pci_get_base_class()
to iterate through all the devices, but you didn't change that and
maybe somebody will dream up a more efficient way someday.

Let me know if you need anything more from me.  Thanks for persevering
with this!

> ---
> v10:
>  * Rebase on 6.17-rc1
>  * Squash 'fbcon: Stop using screen_info_pci_dev()'
> ---
>  arch/x86/video/video-common.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index 81fc97a2a837a..e0aeee99bc99e 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/screen_info.h>
>  #include <linux/vgaarb.h>
>  
>  #include <asm/video.h>
> @@ -27,6 +28,11 @@ EXPORT_SYMBOL(pgprot_framebuffer);
>  
>  bool video_is_primary_device(struct device *dev)
>  {
> +#ifdef CONFIG_SCREEN_INFO
> +	struct screen_info *si = &screen_info;
> +	struct resource res[SCREEN_INFO_MAX_RESOURCES];
> +	ssize_t i, numres;
> +#endif
>  	struct pci_dev *pdev;
>  
>  	if (!dev_is_pci(dev))
> @@ -34,7 +40,24 @@ bool video_is_primary_device(struct device *dev)
>  
>  	pdev = to_pci_dev(dev);
>  
> -	return (pdev == vga_default_device());
> +	if (!pci_is_display(pdev))
> +		return false;
> +
> +	if (pdev == vga_default_device())
> +		return true;
> +
> +#ifdef CONFIG_SCREEN_INFO
> +	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
> +	for (i = 0; i < numres; ++i) {
> +		if (!(res[i].flags & IORESOURCE_MEM))
> +			continue;
> +
> +		if (pci_find_resource(pdev, &res[i]))
> +			return true;
> +	}
> +#endif
> +
> +	return false;
>  }
>  EXPORT_SYMBOL(video_is_primary_device);
>  
> -- 
> 2.43.0
> 


Return-Path: <linux-pci+bounces-39516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173DC14198
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 11:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A653A4A67
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3E29CB3C;
	Tue, 28 Oct 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="QmTHE+1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0A3019DE;
	Tue, 28 Oct 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647218; cv=none; b=mbgOuTEaAeYWIOTlV/IBr6qUOcNOtS0Dj7Bprx3kChqXcvLAsZxAaFO/15vyWTGiZYnU641vKbQXGJe1GgYX1FdWqE4ktDWa9/bS5iXAuGvhcVRyMPJ8PS3qG+sSNSYe3Bmxg8UrcDf89ELQ5/I/Y3eQpeRDvmczu8ye6SVaTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647218; c=relaxed/simple;
	bh=fGPfVLmHb+wl9h4eE562Vwd7sPPgvOxQ4yq0Gh3pNIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWj+iMmgxbPSVWOxlRCBeKw5D393To2+C2h7hFne559RFonIat/F+7dNJfHfr0xRN8A9f0xEXGL3i2T3jMnMmdebWlcqabhTebe7Kc1ul0bqolS7SQ140Dq7bgFHJb0HQbM2VFY8KO89qtlYCIfWNkrgQ9n6F1razh+dxEtsveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=QmTHE+1z; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.10.11.27] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 16A932FC004D;
	Tue, 28 Oct 2025 11:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1761646613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMx59YWeliqF/lFY/+ujXIhGSvd8cbjYB40wlB1RYFA=;
	b=QmTHE+1zUU91L74zpwra1sUslqOLhjB8in8RHnroIZSWxQ6lBjrUjbIVH+zGHq++nET7u/
	yusdq9wdM0bxM+vKOVtS6z6N71IW27l7SXCBsr4YeMBySbCjoAmDKI2WWgUKx8bZgmaGrn
	YuJJXxhjlgqW5Vec8+nkonQBlBqJzLc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <e172ebf2-4b65-4781-b9e7-eb7bd4fa956a@tuxedocomputers.com>
Date: Tue, 28 Oct 2025 11:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] fbcon: Use screen info to find primary device
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
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
 <20250811162606.587759-4-superm1@kernel.org>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <20250811162606.587759-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On Mon, Aug 11, 2025 at 11:26:05AM -0500, Mario Limonciello (AMD) wrote:
> On systems with non VGA GPUs fbcon can't find the primary GPU because
> video_is_primary_device() only checks the VGA arbiter.
> 
> Add a screen info check to video_is_primary_device() so that callers
> can get accurate data on such systems.

I have a question regarding this change. To me, the function name 
video_is_primary_device() implies that there is only one primary GPU.
I would also expect that the 'boot_display' attribute added later in 
the patch series based on this function is only set for one GPU, but 
that is not necessarily the case. Since I'm working on a user-space
program that reads the 'boot_display' attribute, I need to know what
behavior is intended in order to do a correct implementation.

> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
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

This can mark a VGA device as primary GPU.

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

And then the new code can also choose a primary GPU.

> +
> +	return false;
>  }
>  EXPORT_SYMBOL(video_is_primary_device);
>  

In particular, I have hardware that has this exact configuration where
two GPUs are marked as primary and have a 'boot_display' attribute: the
first one through vga_default_device(), the second one through the new
detection method.

Is this intended?

Kind regards
Aaron



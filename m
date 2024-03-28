Return-Path: <linux-pci+bounces-5349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89C8907C8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FE5B265EE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285340856;
	Thu, 28 Mar 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx1+tUAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6582C6B1;
	Thu, 28 Mar 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648552; cv=none; b=axlqJb5KrgoeugbYE8mVCh2zFqijK3ZN8IToxQBIBcyFWvPOkDm65Vm+2u3eFBmPRvbDoEFaiH5FEjaFM3Z0YXHg/cjBjNhwPZN2+ZsMBRo2o+nz5m8CiXZBd0tqyyOpv9TH5yLdN9poqjD/ZiykqCubIr25F7htuxj8CsW7HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648552; c=relaxed/simple;
	bh=uCi1IbyXG6tACQ/Me3G6pXFaxsFaEaBpZ5A7Q7HE4rE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r+vFetbsxOlXzTxgHQeKhRSiTluoL+i6eqWpDjOuqDKbx9IhAMiptLorVd4XHCoZVdk7pjRuhXQhefKkcXNQYYFbouudtTe8qOSnAdeGBZpRWFbKrT+Pkf9udPX/2q9vYBnZHp2sIVbF/B1iAOIzj0jYEQj/122470gwhQa80Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx1+tUAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5EBC433C7;
	Thu, 28 Mar 2024 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711648551;
	bh=uCi1IbyXG6tACQ/Me3G6pXFaxsFaEaBpZ5A7Q7HE4rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jx1+tUATA6l2LQsQNv77ConMqeewK72ISeFBP9ORiPKozLpHPgRH5bJ0A4F+0kr5F
	 mL77SIpkMQMgW39Mxup0ojOopzOFNbl6lwL4P2pKVjYespF2iSP/2JI5TGGNdtDf6z
	 UALpOZhg445yl/pd7U1scbe6CMotblxsap4Gj8c02UtDZJQJhuNFYDYHG5EDbFDCiF
	 txtGwPkYZu+Zp2cEoWcYdLYJoRhuRHVybsdhfhFVo4wzLe1LM1seyBssNzz4a4hnwf
	 YrDTNiuo7yVmb9kGgKkUvaz1q4wE9XdYkGSXB6b5vGkNelDn9+MFZU0bxb6m+0NIjg
	 GzNiPRoeF66YA==
Date: Thu, 28 Mar 2024 12:55:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@kernel.vger.org
Subject: Re: [PATCH v4 10/10] drm/vboxvideo: fix mapping leaks
Message-ID: <20240328175549.GA1574238@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112959.21947-11-pstanner@redhat.com>

On Fri, Mar 01, 2024 at 12:29:58PM +0100, Philipp Stanner wrote:
> When the PCI devres API was introduced to this driver, it was wrongly
> assumed that initializing the device with pcim_enable_device() instead
> of pci_enable_device() will make all PCI functions managed.
> 
> This is wrong and was caused by the quite confusing PCI devres API in
> which some, but not all, functions become managed that way.
> 
> The function pci_iomap_range() is never managed.
> 
> Replace pci_iomap_range() with the actually managed function
> pcim_iomap_range().
> 
> CC: <stable@kernel.vger.org> # v5.10+

This is marked for stable but depends on the preceding patches in this
series, which are not marked for stable.

The rest of this series might be picked up automatically for stable,
but I personally wouldn't suggest backporting it because it's quite a
lot of change and I don't think it fits per
Documentation/process/stable-kernel-rules.rst.

So I think the best way to fix the vboxvideo leaks would be to fix
them independently of this series, then include as a separate patch a
conversion to the new pcim_iomap_range() in this series (or possibly
for the next merge window to avoid merge conflicts).

> Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/gpu/drm/vboxvideo/vbox_main.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
> index 42c2d8a99509..d4ade9325401 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_main.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
> @@ -42,12 +42,11 @@ static int vbox_accel_init(struct vbox_private *vbox)
>  	/* Take a command buffer for each screen from the end of usable VRAM. */
>  	vbox->available_vram_size -= vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE;
>  
> -	vbox->vbva_buffers = pci_iomap_range(pdev, 0,
> -					     vbox->available_vram_size,
> -					     vbox->num_crtcs *
> -					     VBVA_MIN_BUFFER_SIZE);
> -	if (!vbox->vbva_buffers)
> -		return -ENOMEM;
> +	vbox->vbva_buffers = pcim_iomap_range(
> +			pdev, 0, vbox->available_vram_size,
> +			vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE);
> +	if (IS_ERR(vbox->vbva_buffers))
> +		return PTR_ERR(vbox->vbva_buffers);
>  
>  	for (i = 0; i < vbox->num_crtcs; ++i) {
>  		vbva_setup_buffer_context(&vbox->vbva_info[i],
> @@ -116,11 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
>  	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
>  
>  	/* Map guest-heap at end of vram */
> -	vbox->guest_heap =
> -	    pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
> -			    GUEST_HEAP_SIZE);
> -	if (!vbox->guest_heap)
> -		return -ENOMEM;
> +	vbox->guest_heap = pcim_iomap_range(pdev, 0,
> +			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
> +	if (IS_ERR(vbox->guest_heap))
> +		return PTR_ERR(vbox->guest_heap);
>  
>  	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
>  	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
> -- 
> 2.43.0
> 


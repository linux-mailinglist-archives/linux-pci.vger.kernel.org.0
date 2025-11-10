Return-Path: <linux-pci+bounces-40797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A984C49A9C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46A754E308A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FF2EDD6C;
	Mon, 10 Nov 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYW7qlLh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BE285042;
	Mon, 10 Nov 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815297; cv=none; b=Q3wUWuFy9LJsFittHffGqcanb1akPiX9Rhx6vyHcWZfG3fDL9AdwMBBML/eaaku8OmgUhQu3ImUVK3aCbpO60LRmAAdnpGUZ7ZJPKFhLFEpsnFywX19XfbcsP/nqGqHF5Yit13UlmLER0EpdUBqjScpWtzhNt668TkccXOsdGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815297; c=relaxed/simple;
	bh=JrMKdvGveORYut1YwylpofTm4t/bITD/8GFHc/v+mSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AvafCAOikCZeNZteCLBVwiaiz5cDw8SXZFPM3BLx61IT7bY3QoJTmACqZzyT6Oq8xEAn0l88s4aKZXUy+H5yZ8bFmFXduvl2Bj6V/NwpMXC9w0Jyu1Klf+hDcnYDXIdlypn1hiyNiuwQcimv8pIni77ZmPrdUT4jm59wZwNMf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYW7qlLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1462C113D0;
	Mon, 10 Nov 2025 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762815297;
	bh=JrMKdvGveORYut1YwylpofTm4t/bITD/8GFHc/v+mSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iYW7qlLh+3jJ2kVDJoqPJKkmUfizQ7aKJJ/v/Ts+DPOU/Z7SvLuwDQi52YTMYcQad
	 2nS0a76zgWCKyPSTxSfpzbKkEre2+ZHRUxODkmgZdas2vQ5e26nFTSDGuzC1Il6SzZ
	 ZQqJU+hZz+IwEWgKqtmefu0fC8yt5tOJW8eHsvE1dEjuxTMaZME0lnz6ITpCGFC4Vk
	 QNOSOnQ7/LoR5CLeH6POBpdhPKTpkxF188iQr3Pn+URYU9KDFZUy9EF2KlFUJ24USC
	 B2TBg3lCjaEz/FCHIWch4kGs2fHGYkNxQyaHs4PJqHjoUrHUp7DD6630mE2kXPPFpS
	 4gpP3U7GkhotA==
Date: Mon, 10 Nov 2025 16:54:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] drm/amdgpu: Remove driver side BAR release before
 resize
Message-ID: <20251110225455.GA2141964@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028173551.22578-9-ilpo.jarvinen@linux.intel.com>

amdgpu folks, any objection to this?

On Tue, Oct 28, 2025 at 07:35:50PM +0200, Ilpo Järvinen wrote:
> PCI core handles releasing device's resources and their rollback in
> case of failure of a BAR resizing operation. Releasing resource prior
> to calling pci_resize_resource() prevents PCI core from restoring the
> BARs as they were.
> 
> Remove driver-side release of BARs from the amdgpu driver.
> 
> Also remove the driver initiated assignment as pci_resize_resource()
> should try to assign as much as possible. If the driver side call
> manages to get more required resources assigned in some scenario, such
> a problem should be fixed inside pci_resize_resource() instead.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a899fb4de29..65474d365229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1729,12 +1729,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  	pci_write_config_word(adev->pdev, PCI_COMMAND,
>  			      cmd & ~PCI_COMMAND_MEMORY);
>  
> -	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
> +	/* Tear down doorbell as resizing will release BARs */
>  	amdgpu_doorbell_fini(adev);
> -	if (adev->asic_type >= CHIP_BONAIRE)
> -		pci_release_resource(adev->pdev, 2);
> -
> -	pci_release_resource(adev->pdev, 0);
>  
>  	r = pci_resize_resource(adev->pdev, 0, rbar_size);
>  	if (r == -ENOSPC)
> @@ -1743,8 +1739,6 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  	else if (r && r != -ENOTSUPP)
>  		dev_err(adev->dev, "Problem resizing BAR0 (%d).", r);
>  
> -	pci_assign_unassigned_bus_resources(adev->pdev->bus);
> -
>  	/* When the doorbell or fb BAR isn't available we have no chance of
>  	 * using the device.
>  	 */
> -- 
> 2.39.5
> 


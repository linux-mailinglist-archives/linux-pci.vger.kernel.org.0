Return-Path: <linux-pci+bounces-40796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91FC49A80
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F5E18898A9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E69285042;
	Mon, 10 Nov 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXvbE+bs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A82F83BE;
	Mon, 10 Nov 2025 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815229; cv=none; b=hsOlojQA/825LifSAk9YyCwX/Ibig7+SntVi+DPch8ro1JoZfGiD3Q1BwH4yNv7KBL1EXD8fq20WshE7pmk+kYUUHkn8YEoFyDDeU0C53rnYOw2sqAnum9vU1Smg26mNn3oYoUTYjwv4+bVCvzgiwdKqqhWv6LXma0PEsneKUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815229; c=relaxed/simple;
	bh=niFGSKVsL+zl2v1NgWvR+689qDLujQv0fgthWWg1O2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cRz6BA3JadlstHBjs/OsiS1IE16h7VKRSeZ63Y95nw50MKI46MKehKh9a+/6Ntrm9l8dcbJqZzMD5bQu22BL4O1yliX5Dktb3nuCFb2eThS+T4uEe0xfnCTpXZ2et7HQiiatsNVp3ATPrxEu0vAB0zzz3r+z7TEkwTHTQ4uxxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXvbE+bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB51C4CEF5;
	Mon, 10 Nov 2025 22:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762815228;
	bh=niFGSKVsL+zl2v1NgWvR+689qDLujQv0fgthWWg1O2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PXvbE+bsYdzImXhOzu4GtEnYN7ofgLNYfZq6A8so+Li1RSjxOKuGL8LZOL/Y96AEj
	 PVoIK6AisVdB+f9xIOngJs+DYlN3QCss5Nl2oGrhyy8C+5rqF6ZgCg0Hu0rxwAyEZO
	 D9VF3zs+P4D3nM98QMAU2jvZA7ID3lwGxBQdwn1SrdqcRryjUQ0GmamkMlhIgXglJ/
	 ik7YMOzthsQ0JMcBwyhJ1QaJUZ6PXO32fdi/FEYuwY7Psr9Ct/rbXJPXkKQBce7SPx
	 ZxJnOT3CdRfA++/LkUYKx/CollXuexELu9G+dA81aSS/kxdyE3TTNss7g+95QhykaW
	 Nl7h2j6lz21IQ==
Date: Mon, 10 Nov 2025 16:53:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-pci@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] drm/i915: Remove driver side BAR release before
 resize
Message-ID: <20251110225347.GA2141838@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028173551.22578-8-ilpo.jarvinen@linux.intel.com>

i915 folks, any objection to this?

On Tue, Oct 28, 2025 at 07:35:49PM +0200, Ilpo Järvinen wrote:
> PCI core handles releasing device's resources and their rollback in
> case of failure of a BAR resizing operation. Releasing resource prior
> to calling pci_resize_resource() prevents PCI core from restoring the
> BARs as they were.
> 
> Remove driver-side release of BARs from the i915 driver.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> index 51bb27e10a4f..ca3de61451a3 100644
> --- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> +++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> @@ -18,16 +18,6 @@
>  #include "gt/intel_gt_regs.h"
>  
>  #ifdef CONFIG_64BIT
> -static void _release_bars(struct pci_dev *pdev)
> -{
> -	int resno;
> -
> -	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
> -		if (pci_resource_len(pdev, resno))
> -			pci_release_resource(pdev, resno);
> -	}
> -}
> -
>  static void
>  _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
>  {
> @@ -35,8 +25,6 @@ _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
>  	int bar_size = pci_rebar_bytes_to_size(size);
>  	int ret;
>  
> -	_release_bars(pdev);
> -
>  	ret = pci_resize_resource(pdev, resno, bar_size);
>  	if (ret) {
>  		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
> -- 
> 2.39.5
> 


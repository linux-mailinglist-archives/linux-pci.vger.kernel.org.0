Return-Path: <linux-pci+bounces-7656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E578C9D30
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3533F1C213C3
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F653E25;
	Mon, 20 May 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvdPj+IR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F952F74
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208044; cv=none; b=le4W+sZd8BPrirV8er1l40qdT6Ehsgmel4enZJJgZCqcbRplQPoMLFpNFuoL76goxicvBuNrlZK4p1WrGSgtkbaPYpgRQ6qO8F8pR3dVEkvfNtjd78QJuE8SA6oX+JMQYv0fUquYX7ZnOYn4T5iLZI0UZciJ5Do+zQcq+PrbvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208044; c=relaxed/simple;
	bh=kI+oFa0OIqzV/mhgXfE3tKcJG31Gw5HZVcejCjJMRbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GO1FayCDtqatKAJS22hOOcx5atUgYZEpwvJS/mPCs2Nm8pK09Wu/txWj6CfZ6Jofz+F6k0MOD8iu5VWSduUf1DMtyhov6ugnyM3LpQutUumIY5THLeqoJeyr30Z7wlL3kfv8nh0kuQu2xiEyVfWlJF7iv1II+ldxt94onLoVe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvdPj+IR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208041; x=1747744041;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kI+oFa0OIqzV/mhgXfE3tKcJG31Gw5HZVcejCjJMRbg=;
  b=HvdPj+IR3f6fYq6WAUJ3UrRsBKBcbkpUBdoZoQNknsgvZrqi78BCyQK0
   fha8isS1PO+ymEMkmlrFpvsNtYd5Wpw8JGcbI6VlqHYwBoMwKWII3lbga
   f+IN0rv20uLWLt0kx59aplgYB9d3Yecc8z2hTkpj+iIhCVVanwkH3WxYd
   NY/XYZzpNwosxzaOcF8iZMsvUi2yyohG7lZOAtPxH/fxVROsaZ6CuLOyP
   279zvLb/c985xiVCRjeDkS0ekTIw9S19LRuCEHVtpZFw8/4LWsA3BwoGm
   VAUXO2kG/JeZS4yI872uPwkFnORY+ELWc+NeHQMKJaSEBJgdnSDLkFf4X
   g==;
X-CSE-ConnectionGUID: Xofa2PKWROG7WVJWM1SyEw==
X-CSE-MsgGUID: u0e9Dbe0RvSkJjKeAjXn5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16158745"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="16158745"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:27:20 -0700
X-CSE-ConnectionGUID: DMkbe+w0Q3eH83+qsPKCpw==
X-CSE-MsgGUID: lB9eBQ0aSEGnGbiOCzM72w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32418628"
Received: from unknown (HELO localhost) ([10.245.246.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:27:16 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Lucas De
 Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 1/2] drm/i915/pciids: switch to xe driver style PCI ID
 macros
In-Reply-To: <20240515165651.1230465-1-jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240515165651.1230465-1-jani.nikula@intel.com>
Date: Mon, 20 May 2024 15:27:13 +0300
Message-ID: <87y184sm72.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 15 May 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> The PCI ID macros in xe_pciids.h allow passing in the macro to operate
> on each PCI ID, making it more flexible. Convert i915_pciids.h to the
> same pattern.
>
> INTEL_IVB_Q_IDS() for Quanta transcode remains a special case, and
> unconditionally uses INTEL_QUANTA_VGA_DEVICE().
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Bjorn, since I asked for acks on the last ones, I probably should here
too. :)

I'm hoping to stop mucking with the macros after this.

BR,
Jani.


> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> ---
>
> Tip: It's probably easiest to apply and use 'git show --color-words' for
> review.
>
> This transformation is completely scripted:
>
> | #!/bin/bash
> |
> | FILE=include/drm/i915_pciids.h
> |
> | sed -i 's/[\t ]*\\/ \\/' $FILE
> |
> | sed -i 's/^\(#define [A-Za-z0-9_]\+\)_IDS(info)/\1_IDS(MACRO__, ...)/' $FILE
> |
> | sed -i 's/^\t\([A-Za-z0-9_]\+\)(info)/\t\1(MACRO__, ## __VA_ARGS__)/' $FILE
> |
> | sed -i 's/^\tINTEL_VGA_DEVICE(\([A-Fa-f0-9x]\+\), info)/\tMACRO__(\1, ## __VA_ARGS__)/' $FILE
> |
> | # Special case: IVB Q transcode
> | sed -i 's/^\t\(INTEL_QUANTA_VGA_DEVICE\)(MACRO__, ## /\t\1(/' $FILE
> |
> | # Change all users
> | for file in $(git grep -l "#include <drm/i915_pciids.h>"); do
> | 	for macro in $(git grep -ho "#define [A-Za-z0-9_]\+_IDS" $FILE | sed 's/#define //'); do
> | 		sed -i "s/$macro(/$macro(INTEL_VGA_DEVICE, /" $file
> | 	done
> | done
> ---
>  arch/x86/kernel/early-quirks.c                |   80 +-
>  .../drm/i915/display/intel_display_device.c   |   86 +-
>  drivers/gpu/drm/i915/i915_pci.c               |  150 +-
>  drivers/gpu/drm/i915/intel_device_info.c      |   88 +-
>  include/drm/i915_pciids.h                     | 1348 ++++++++---------
>  5 files changed, 876 insertions(+), 876 deletions(-)
>
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index fd74d7f26f01..1c137771c5d2 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -518,46 +518,46 @@ static const struct intel_early_ops gen11_early_ops __initconst = {
>  
>  /* Intel integrated GPUs for which we need to reserve "stolen memory" */
>  static const struct pci_device_id intel_early_ids[] __initconst = {
> -	INTEL_I830_IDS(&i830_early_ops),
> -	INTEL_I845G_IDS(&i845_early_ops),
> -	INTEL_I85X_IDS(&i85x_early_ops),
> -	INTEL_I865G_IDS(&i865_early_ops),
> -	INTEL_I915G_IDS(&gen3_early_ops),
> -	INTEL_I915GM_IDS(&gen3_early_ops),
> -	INTEL_I945G_IDS(&gen3_early_ops),
> -	INTEL_I945GM_IDS(&gen3_early_ops),
> -	INTEL_VLV_IDS(&gen6_early_ops),
> -	INTEL_PNV_IDS(&gen3_early_ops),
> -	INTEL_I965G_IDS(&gen3_early_ops),
> -	INTEL_G33_IDS(&gen3_early_ops),
> -	INTEL_I965GM_IDS(&gen3_early_ops),
> -	INTEL_GM45_IDS(&gen3_early_ops),
> -	INTEL_G45_IDS(&gen3_early_ops),
> -	INTEL_ILK_IDS(&gen3_early_ops),
> -	INTEL_SNB_IDS(&gen6_early_ops),
> -	INTEL_IVB_IDS(&gen6_early_ops),
> -	INTEL_HSW_IDS(&gen6_early_ops),
> -	INTEL_BDW_IDS(&gen8_early_ops),
> -	INTEL_CHV_IDS(&chv_early_ops),
> -	INTEL_SKL_IDS(&gen9_early_ops),
> -	INTEL_BXT_IDS(&gen9_early_ops),
> -	INTEL_KBL_IDS(&gen9_early_ops),
> -	INTEL_CFL_IDS(&gen9_early_ops),
> -	INTEL_WHL_IDS(&gen9_early_ops),
> -	INTEL_CML_IDS(&gen9_early_ops),
> -	INTEL_GLK_IDS(&gen9_early_ops),
> -	INTEL_CNL_IDS(&gen9_early_ops),
> -	INTEL_ICL_IDS(&gen11_early_ops),
> -	INTEL_EHL_IDS(&gen11_early_ops),
> -	INTEL_JSL_IDS(&gen11_early_ops),
> -	INTEL_TGL_IDS(&gen11_early_ops),
> -	INTEL_RKL_IDS(&gen11_early_ops),
> -	INTEL_ADLS_IDS(&gen11_early_ops),
> -	INTEL_ADLP_IDS(&gen11_early_ops),
> -	INTEL_ADLN_IDS(&gen11_early_ops),
> -	INTEL_RPLS_IDS(&gen11_early_ops),
> -	INTEL_RPLU_IDS(&gen11_early_ops),
> -	INTEL_RPLP_IDS(&gen11_early_ops),
> +	INTEL_I830_IDS(INTEL_VGA_DEVICE, &i830_early_ops),
> +	INTEL_I845G_IDS(INTEL_VGA_DEVICE, &i845_early_ops),
> +	INTEL_I85X_IDS(INTEL_VGA_DEVICE, &i85x_early_ops),
> +	INTEL_I865G_IDS(INTEL_VGA_DEVICE, &i865_early_ops),
> +	INTEL_I915G_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_I915GM_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_I945G_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_I945GM_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_VLV_IDS(INTEL_VGA_DEVICE, &gen6_early_ops),
> +	INTEL_PNV_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_I965G_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_G33_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_I965GM_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_GM45_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_G45_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_ILK_IDS(INTEL_VGA_DEVICE, &gen3_early_ops),
> +	INTEL_SNB_IDS(INTEL_VGA_DEVICE, &gen6_early_ops),
> +	INTEL_IVB_IDS(INTEL_VGA_DEVICE, &gen6_early_ops),
> +	INTEL_HSW_IDS(INTEL_VGA_DEVICE, &gen6_early_ops),
> +	INTEL_BDW_IDS(INTEL_VGA_DEVICE, &gen8_early_ops),
> +	INTEL_CHV_IDS(INTEL_VGA_DEVICE, &chv_early_ops),
> +	INTEL_SKL_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_BXT_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_KBL_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_CFL_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_WHL_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_CML_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_GLK_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_CNL_IDS(INTEL_VGA_DEVICE, &gen9_early_ops),
> +	INTEL_ICL_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_EHL_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_JSL_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_TGL_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_RKL_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_ADLS_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_ADLP_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_ADLN_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_RPLS_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
> +	INTEL_RPLP_IDS(INTEL_VGA_DEVICE, &gen11_early_ops),
>  };
>  
>  struct resource intel_graphics_stolen_res __ro_after_init = DEFINE_RES_MEM(0, 0);
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 89069cff06b4..950e66cdba0a 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -788,7 +788,7 @@ __diag_pop();
>  static bool has_no_display(struct pci_dev *pdev)
>  {
>  	static const struct pci_device_id ids[] = {
> -		INTEL_IVB_Q_IDS(0),
> +		INTEL_IVB_Q_IDS(INTEL_VGA_DEVICE, 0),
>  		{}
>  	};
>  
> @@ -802,48 +802,48 @@ static const struct {
>  	u32 devid;
>  	const struct intel_display_device_info *info;
>  } intel_display_ids[] = {
> -	INTEL_I830_IDS(&i830_display),
> -	INTEL_I845G_IDS(&i845_display),
> -	INTEL_I85X_IDS(&i85x_display),
> -	INTEL_I865G_IDS(&i865g_display),
> -	INTEL_I915G_IDS(&i915g_display),
> -	INTEL_I915GM_IDS(&i915gm_display),
> -	INTEL_I945G_IDS(&i945g_display),
> -	INTEL_I945GM_IDS(&i945gm_display),
> -	INTEL_I965G_IDS(&i965g_display),
> -	INTEL_G33_IDS(&g33_display),
> -	INTEL_I965GM_IDS(&i965gm_display),
> -	INTEL_GM45_IDS(&gm45_display),
> -	INTEL_G45_IDS(&g45_display),
> -	INTEL_PNV_IDS(&pnv_display),
> -	INTEL_ILK_D_IDS(&ilk_d_display),
> -	INTEL_ILK_M_IDS(&ilk_m_display),
> -	INTEL_SNB_IDS(&snb_display),
> -	INTEL_IVB_IDS(&ivb_display),
> -	INTEL_HSW_IDS(&hsw_display),
> -	INTEL_VLV_IDS(&vlv_display),
> -	INTEL_BDW_IDS(&bdw_display),
> -	INTEL_CHV_IDS(&chv_display),
> -	INTEL_SKL_IDS(&skl_display),
> -	INTEL_BXT_IDS(&bxt_display),
> -	INTEL_GLK_IDS(&glk_display),
> -	INTEL_KBL_IDS(&skl_display),
> -	INTEL_CFL_IDS(&skl_display),
> -	INTEL_WHL_IDS(&skl_display),
> -	INTEL_CML_IDS(&skl_display),
> -	INTEL_ICL_IDS(&icl_display),
> -	INTEL_EHL_IDS(&jsl_ehl_display),
> -	INTEL_JSL_IDS(&jsl_ehl_display),
> -	INTEL_TGL_IDS(&tgl_display),
> -	INTEL_DG1_IDS(&dg1_display),
> -	INTEL_RKL_IDS(&rkl_display),
> -	INTEL_ADLS_IDS(&adl_s_display),
> -	INTEL_RPLS_IDS(&adl_s_display),
> -	INTEL_ADLP_IDS(&xe_lpd_display),
> -	INTEL_ADLN_IDS(&xe_lpd_display),
> -	INTEL_RPLU_IDS(&xe_lpd_display),
> -	INTEL_RPLP_IDS(&xe_lpd_display),
> -	INTEL_DG2_IDS(&xe_hpd_display),
> +	INTEL_I830_IDS(INTEL_VGA_DEVICE, &i830_display),
> +	INTEL_I845G_IDS(INTEL_VGA_DEVICE, &i845_display),
> +	INTEL_I85X_IDS(INTEL_VGA_DEVICE, &i85x_display),
> +	INTEL_I865G_IDS(INTEL_VGA_DEVICE, &i865g_display),
> +	INTEL_I915G_IDS(INTEL_VGA_DEVICE, &i915g_display),
> +	INTEL_I915GM_IDS(INTEL_VGA_DEVICE, &i915gm_display),
> +	INTEL_I945G_IDS(INTEL_VGA_DEVICE, &i945g_display),
> +	INTEL_I945GM_IDS(INTEL_VGA_DEVICE, &i945gm_display),
> +	INTEL_I965G_IDS(INTEL_VGA_DEVICE, &i965g_display),
> +	INTEL_G33_IDS(INTEL_VGA_DEVICE, &g33_display),
> +	INTEL_I965GM_IDS(INTEL_VGA_DEVICE, &i965gm_display),
> +	INTEL_GM45_IDS(INTEL_VGA_DEVICE, &gm45_display),
> +	INTEL_G45_IDS(INTEL_VGA_DEVICE, &g45_display),
> +	INTEL_PNV_IDS(INTEL_VGA_DEVICE, &pnv_display),
> +	INTEL_ILK_D_IDS(INTEL_VGA_DEVICE, &ilk_d_display),
> +	INTEL_ILK_M_IDS(INTEL_VGA_DEVICE, &ilk_m_display),
> +	INTEL_SNB_IDS(INTEL_VGA_DEVICE, &snb_display),
> +	INTEL_IVB_IDS(INTEL_VGA_DEVICE, &ivb_display),
> +	INTEL_HSW_IDS(INTEL_VGA_DEVICE, &hsw_display),
> +	INTEL_VLV_IDS(INTEL_VGA_DEVICE, &vlv_display),
> +	INTEL_BDW_IDS(INTEL_VGA_DEVICE, &bdw_display),
> +	INTEL_CHV_IDS(INTEL_VGA_DEVICE, &chv_display),
> +	INTEL_SKL_IDS(INTEL_VGA_DEVICE, &skl_display),
> +	INTEL_BXT_IDS(INTEL_VGA_DEVICE, &bxt_display),
> +	INTEL_GLK_IDS(INTEL_VGA_DEVICE, &glk_display),
> +	INTEL_KBL_IDS(INTEL_VGA_DEVICE, &skl_display),
> +	INTEL_CFL_IDS(INTEL_VGA_DEVICE, &skl_display),
> +	INTEL_WHL_IDS(INTEL_VGA_DEVICE, &skl_display),
> +	INTEL_CML_IDS(INTEL_VGA_DEVICE, &skl_display),
> +	INTEL_ICL_IDS(INTEL_VGA_DEVICE, &icl_display),
> +	INTEL_EHL_IDS(INTEL_VGA_DEVICE, &jsl_ehl_display),
> +	INTEL_JSL_IDS(INTEL_VGA_DEVICE, &jsl_ehl_display),
> +	INTEL_TGL_IDS(INTEL_VGA_DEVICE, &tgl_display),
> +	INTEL_DG1_IDS(INTEL_VGA_DEVICE, &dg1_display),
> +	INTEL_RKL_IDS(INTEL_VGA_DEVICE, &rkl_display),
> +	INTEL_ADLS_IDS(INTEL_VGA_DEVICE, &adl_s_display),
> +	INTEL_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_display),
> +	INTEL_ADLP_IDS(INTEL_VGA_DEVICE, &xe_lpd_display),
> +	INTEL_ADLN_IDS(INTEL_VGA_DEVICE, &xe_lpd_display),
> +	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, &xe_lpd_display),
> +	INTEL_RPLP_IDS(INTEL_VGA_DEVICE, &xe_lpd_display),
> +	INTEL_DG2_IDS(INTEL_VGA_DEVICE, &xe_hpd_display),
>  
>  	/*
>  	 * Do not add any GMD_ID-based platforms to this list.  They will
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 74202925d13f..84cd2f0343a2 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -797,81 +797,81 @@ __diag_pop();
>   * PCI ID matches, otherwise we'll use the wrong info struct above.
>   */
>  static const struct pci_device_id pciidlist[] = {
> -	INTEL_I830_IDS(&i830_info),
> -	INTEL_I845G_IDS(&i845g_info),
> -	INTEL_I85X_IDS(&i85x_info),
> -	INTEL_I865G_IDS(&i865g_info),
> -	INTEL_I915G_IDS(&i915g_info),
> -	INTEL_I915GM_IDS(&i915gm_info),
> -	INTEL_I945G_IDS(&i945g_info),
> -	INTEL_I945GM_IDS(&i945gm_info),
> -	INTEL_I965G_IDS(&i965g_info),
> -	INTEL_G33_IDS(&g33_info),
> -	INTEL_I965GM_IDS(&i965gm_info),
> -	INTEL_GM45_IDS(&gm45_info),
> -	INTEL_G45_IDS(&g45_info),
> -	INTEL_PNV_G_IDS(&pnv_g_info),
> -	INTEL_PNV_M_IDS(&pnv_m_info),
> -	INTEL_ILK_D_IDS(&ilk_d_info),
> -	INTEL_ILK_M_IDS(&ilk_m_info),
> -	INTEL_SNB_D_GT1_IDS(&snb_d_gt1_info),
> -	INTEL_SNB_D_GT2_IDS(&snb_d_gt2_info),
> -	INTEL_SNB_M_GT1_IDS(&snb_m_gt1_info),
> -	INTEL_SNB_M_GT2_IDS(&snb_m_gt2_info),
> -	INTEL_IVB_Q_IDS(&ivb_q_info), /* must be first IVB */
> -	INTEL_IVB_M_GT1_IDS(&ivb_m_gt1_info),
> -	INTEL_IVB_M_GT2_IDS(&ivb_m_gt2_info),
> -	INTEL_IVB_D_GT1_IDS(&ivb_d_gt1_info),
> -	INTEL_IVB_D_GT2_IDS(&ivb_d_gt2_info),
> -	INTEL_HSW_GT1_IDS(&hsw_gt1_info),
> -	INTEL_HSW_GT2_IDS(&hsw_gt2_info),
> -	INTEL_HSW_GT3_IDS(&hsw_gt3_info),
> -	INTEL_VLV_IDS(&vlv_info),
> -	INTEL_BDW_GT1_IDS(&bdw_gt1_info),
> -	INTEL_BDW_GT2_IDS(&bdw_gt2_info),
> -	INTEL_BDW_GT3_IDS(&bdw_gt3_info),
> -	INTEL_BDW_RSVD_IDS(&bdw_rsvd_info),
> -	INTEL_CHV_IDS(&chv_info),
> -	INTEL_SKL_GT1_IDS(&skl_gt1_info),
> -	INTEL_SKL_GT2_IDS(&skl_gt2_info),
> -	INTEL_SKL_GT3_IDS(&skl_gt3_info),
> -	INTEL_SKL_GT4_IDS(&skl_gt4_info),
> -	INTEL_BXT_IDS(&bxt_info),
> -	INTEL_GLK_IDS(&glk_info),
> -	INTEL_KBL_GT1_IDS(&kbl_gt1_info),
> -	INTEL_KBL_GT2_IDS(&kbl_gt2_info),
> -	INTEL_KBL_GT3_IDS(&kbl_gt3_info),
> -	INTEL_KBL_GT4_IDS(&kbl_gt3_info),
> -	INTEL_AML_KBL_GT2_IDS(&kbl_gt2_info),
> -	INTEL_CFL_S_GT1_IDS(&cfl_gt1_info),
> -	INTEL_CFL_S_GT2_IDS(&cfl_gt2_info),
> -	INTEL_CFL_H_GT1_IDS(&cfl_gt1_info),
> -	INTEL_CFL_H_GT2_IDS(&cfl_gt2_info),
> -	INTEL_CFL_U_GT2_IDS(&cfl_gt2_info),
> -	INTEL_CFL_U_GT3_IDS(&cfl_gt3_info),
> -	INTEL_WHL_U_GT1_IDS(&cfl_gt1_info),
> -	INTEL_WHL_U_GT2_IDS(&cfl_gt2_info),
> -	INTEL_AML_CFL_GT2_IDS(&cfl_gt2_info),
> -	INTEL_WHL_U_GT3_IDS(&cfl_gt3_info),
> -	INTEL_CML_GT1_IDS(&cml_gt1_info),
> -	INTEL_CML_GT2_IDS(&cml_gt2_info),
> -	INTEL_CML_U_GT1_IDS(&cml_gt1_info),
> -	INTEL_CML_U_GT2_IDS(&cml_gt2_info),
> -	INTEL_ICL_IDS(&icl_info),
> -	INTEL_EHL_IDS(&ehl_info),
> -	INTEL_JSL_IDS(&jsl_info),
> -	INTEL_TGL_IDS(&tgl_info),
> -	INTEL_RKL_IDS(&rkl_info),
> -	INTEL_ADLS_IDS(&adl_s_info),
> -	INTEL_ADLP_IDS(&adl_p_info),
> -	INTEL_ADLN_IDS(&adl_p_info),
> -	INTEL_DG1_IDS(&dg1_info),
> -	INTEL_RPLS_IDS(&adl_s_info),
> -	INTEL_RPLU_IDS(&adl_p_info),
> -	INTEL_RPLP_IDS(&adl_p_info),
> -	INTEL_DG2_IDS(&dg2_info),
> -	INTEL_ATS_M_IDS(&ats_m_info),
> -	INTEL_MTL_IDS(&mtl_info),
> +	INTEL_I830_IDS(INTEL_VGA_DEVICE, &i830_info),
> +	INTEL_I845G_IDS(INTEL_VGA_DEVICE, &i845g_info),
> +	INTEL_I85X_IDS(INTEL_VGA_DEVICE, &i85x_info),
> +	INTEL_I865G_IDS(INTEL_VGA_DEVICE, &i865g_info),
> +	INTEL_I915G_IDS(INTEL_VGA_DEVICE, &i915g_info),
> +	INTEL_I915GM_IDS(INTEL_VGA_DEVICE, &i915gm_info),
> +	INTEL_I945G_IDS(INTEL_VGA_DEVICE, &i945g_info),
> +	INTEL_I945GM_IDS(INTEL_VGA_DEVICE, &i945gm_info),
> +	INTEL_I965G_IDS(INTEL_VGA_DEVICE, &i965g_info),
> +	INTEL_G33_IDS(INTEL_VGA_DEVICE, &g33_info),
> +	INTEL_I965GM_IDS(INTEL_VGA_DEVICE, &i965gm_info),
> +	INTEL_GM45_IDS(INTEL_VGA_DEVICE, &gm45_info),
> +	INTEL_G45_IDS(INTEL_VGA_DEVICE, &g45_info),
> +	INTEL_PNV_G_IDS(INTEL_VGA_DEVICE, &pnv_g_info),
> +	INTEL_PNV_M_IDS(INTEL_VGA_DEVICE, &pnv_m_info),
> +	INTEL_ILK_D_IDS(INTEL_VGA_DEVICE, &ilk_d_info),
> +	INTEL_ILK_M_IDS(INTEL_VGA_DEVICE, &ilk_m_info),
> +	INTEL_SNB_D_GT1_IDS(INTEL_VGA_DEVICE, &snb_d_gt1_info),
> +	INTEL_SNB_D_GT2_IDS(INTEL_VGA_DEVICE, &snb_d_gt2_info),
> +	INTEL_SNB_M_GT1_IDS(INTEL_VGA_DEVICE, &snb_m_gt1_info),
> +	INTEL_SNB_M_GT2_IDS(INTEL_VGA_DEVICE, &snb_m_gt2_info),
> +	INTEL_IVB_Q_IDS(INTEL_VGA_DEVICE, &ivb_q_info), /* must be first IVB */
> +	INTEL_IVB_M_GT1_IDS(INTEL_VGA_DEVICE, &ivb_m_gt1_info),
> +	INTEL_IVB_M_GT2_IDS(INTEL_VGA_DEVICE, &ivb_m_gt2_info),
> +	INTEL_IVB_D_GT1_IDS(INTEL_VGA_DEVICE, &ivb_d_gt1_info),
> +	INTEL_IVB_D_GT2_IDS(INTEL_VGA_DEVICE, &ivb_d_gt2_info),
> +	INTEL_HSW_GT1_IDS(INTEL_VGA_DEVICE, &hsw_gt1_info),
> +	INTEL_HSW_GT2_IDS(INTEL_VGA_DEVICE, &hsw_gt2_info),
> +	INTEL_HSW_GT3_IDS(INTEL_VGA_DEVICE, &hsw_gt3_info),
> +	INTEL_VLV_IDS(INTEL_VGA_DEVICE, &vlv_info),
> +	INTEL_BDW_GT1_IDS(INTEL_VGA_DEVICE, &bdw_gt1_info),
> +	INTEL_BDW_GT2_IDS(INTEL_VGA_DEVICE, &bdw_gt2_info),
> +	INTEL_BDW_GT3_IDS(INTEL_VGA_DEVICE, &bdw_gt3_info),
> +	INTEL_BDW_RSVD_IDS(INTEL_VGA_DEVICE, &bdw_rsvd_info),
> +	INTEL_CHV_IDS(INTEL_VGA_DEVICE, &chv_info),
> +	INTEL_SKL_GT1_IDS(INTEL_VGA_DEVICE, &skl_gt1_info),
> +	INTEL_SKL_GT2_IDS(INTEL_VGA_DEVICE, &skl_gt2_info),
> +	INTEL_SKL_GT3_IDS(INTEL_VGA_DEVICE, &skl_gt3_info),
> +	INTEL_SKL_GT4_IDS(INTEL_VGA_DEVICE, &skl_gt4_info),
> +	INTEL_BXT_IDS(INTEL_VGA_DEVICE, &bxt_info),
> +	INTEL_GLK_IDS(INTEL_VGA_DEVICE, &glk_info),
> +	INTEL_KBL_GT1_IDS(INTEL_VGA_DEVICE, &kbl_gt1_info),
> +	INTEL_KBL_GT2_IDS(INTEL_VGA_DEVICE, &kbl_gt2_info),
> +	INTEL_KBL_GT3_IDS(INTEL_VGA_DEVICE, &kbl_gt3_info),
> +	INTEL_KBL_GT4_IDS(INTEL_VGA_DEVICE, &kbl_gt3_info),
> +	INTEL_AML_KBL_GT2_IDS(INTEL_VGA_DEVICE, &kbl_gt2_info),
> +	INTEL_CFL_S_GT1_IDS(INTEL_VGA_DEVICE, &cfl_gt1_info),
> +	INTEL_CFL_S_GT2_IDS(INTEL_VGA_DEVICE, &cfl_gt2_info),
> +	INTEL_CFL_H_GT1_IDS(INTEL_VGA_DEVICE, &cfl_gt1_info),
> +	INTEL_CFL_H_GT2_IDS(INTEL_VGA_DEVICE, &cfl_gt2_info),
> +	INTEL_CFL_U_GT2_IDS(INTEL_VGA_DEVICE, &cfl_gt2_info),
> +	INTEL_CFL_U_GT3_IDS(INTEL_VGA_DEVICE, &cfl_gt3_info),
> +	INTEL_WHL_U_GT1_IDS(INTEL_VGA_DEVICE, &cfl_gt1_info),
> +	INTEL_WHL_U_GT2_IDS(INTEL_VGA_DEVICE, &cfl_gt2_info),
> +	INTEL_AML_CFL_GT2_IDS(INTEL_VGA_DEVICE, &cfl_gt2_info),
> +	INTEL_WHL_U_GT3_IDS(INTEL_VGA_DEVICE, &cfl_gt3_info),
> +	INTEL_CML_GT1_IDS(INTEL_VGA_DEVICE, &cml_gt1_info),
> +	INTEL_CML_GT2_IDS(INTEL_VGA_DEVICE, &cml_gt2_info),
> +	INTEL_CML_U_GT1_IDS(INTEL_VGA_DEVICE, &cml_gt1_info),
> +	INTEL_CML_U_GT2_IDS(INTEL_VGA_DEVICE, &cml_gt2_info),
> +	INTEL_ICL_IDS(INTEL_VGA_DEVICE, &icl_info),
> +	INTEL_EHL_IDS(INTEL_VGA_DEVICE, &ehl_info),
> +	INTEL_JSL_IDS(INTEL_VGA_DEVICE, &jsl_info),
> +	INTEL_TGL_IDS(INTEL_VGA_DEVICE, &tgl_info),
> +	INTEL_RKL_IDS(INTEL_VGA_DEVICE, &rkl_info),
> +	INTEL_ADLS_IDS(INTEL_VGA_DEVICE, &adl_s_info),
> +	INTEL_ADLP_IDS(INTEL_VGA_DEVICE, &adl_p_info),
> +	INTEL_ADLN_IDS(INTEL_VGA_DEVICE, &adl_p_info),
> +	INTEL_DG1_IDS(INTEL_VGA_DEVICE, &dg1_info),
> +	INTEL_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_info),
> +	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, &adl_p_info),
> +	INTEL_RPLP_IDS(INTEL_VGA_DEVICE, &adl_p_info),
> +	INTEL_DG2_IDS(INTEL_VGA_DEVICE, &dg2_info),
> +	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
> +	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, pciidlist);
> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
> index a39497971994..82bb34416fb1 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.c
> +++ b/drivers/gpu/drm/i915/intel_device_info.c
> @@ -131,77 +131,77 @@ void intel_device_info_print(const struct intel_device_info *info,
>  #define INTEL_VGA_DEVICE(id, info) (id)
>  
>  static const u16 subplatform_ult_ids[] = {
> -	INTEL_HSW_ULT_GT1_IDS(0),
> -	INTEL_HSW_ULT_GT2_IDS(0),
> -	INTEL_HSW_ULT_GT3_IDS(0),
> -	INTEL_BDW_ULT_GT1_IDS(0),
> -	INTEL_BDW_ULT_GT2_IDS(0),
> -	INTEL_BDW_ULT_GT3_IDS(0),
> -	INTEL_BDW_ULT_RSVD_IDS(0),
> -	INTEL_SKL_ULT_GT1_IDS(0),
> -	INTEL_SKL_ULT_GT2_IDS(0),
> -	INTEL_SKL_ULT_GT3_IDS(0),
> -	INTEL_KBL_ULT_GT1_IDS(0),
> -	INTEL_KBL_ULT_GT2_IDS(0),
> -	INTEL_KBL_ULT_GT3_IDS(0),
> -	INTEL_CFL_U_GT2_IDS(0),
> -	INTEL_CFL_U_GT3_IDS(0),
> -	INTEL_WHL_U_GT1_IDS(0),
> -	INTEL_WHL_U_GT2_IDS(0),
> -	INTEL_WHL_U_GT3_IDS(0),
> -	INTEL_CML_U_GT1_IDS(0),
> -	INTEL_CML_U_GT2_IDS(0),
> +	INTEL_HSW_ULT_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_HSW_ULT_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_HSW_ULT_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULT_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULT_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULT_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULT_RSVD_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_SKL_ULT_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_SKL_ULT_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_SKL_ULT_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_KBL_ULT_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_KBL_ULT_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_KBL_ULT_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_CFL_U_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_CFL_U_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_WHL_U_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_WHL_U_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_WHL_U_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_CML_U_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_CML_U_GT2_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_ulx_ids[] = {
> -	INTEL_HSW_ULX_GT1_IDS(0),
> -	INTEL_HSW_ULX_GT2_IDS(0),
> -	INTEL_BDW_ULX_GT1_IDS(0),
> -	INTEL_BDW_ULX_GT2_IDS(0),
> -	INTEL_BDW_ULX_GT3_IDS(0),
> -	INTEL_BDW_ULX_RSVD_IDS(0),
> -	INTEL_SKL_ULX_GT1_IDS(0),
> -	INTEL_SKL_ULX_GT2_IDS(0),
> -	INTEL_KBL_ULX_GT1_IDS(0),
> -	INTEL_KBL_ULX_GT2_IDS(0),
> -	INTEL_AML_KBL_GT2_IDS(0),
> -	INTEL_AML_CFL_GT2_IDS(0),
> +	INTEL_HSW_ULX_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_HSW_ULX_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULX_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULX_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULX_GT3_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_BDW_ULX_RSVD_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_SKL_ULX_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_SKL_ULX_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_KBL_ULX_GT1_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_KBL_ULX_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_AML_KBL_GT2_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_AML_CFL_GT2_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_portf_ids[] = {
> -	INTEL_ICL_PORT_F_IDS(0),
> +	INTEL_ICL_PORT_F_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_uy_ids[] = {
> -	INTEL_TGL_GT2_IDS(0),
> +	INTEL_TGL_GT2_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_n_ids[] = {
> -	INTEL_ADLN_IDS(0),
> +	INTEL_ADLN_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_rpl_ids[] = {
> -	INTEL_RPLS_IDS(0),
> -	INTEL_RPLU_IDS(0),
> -	INTEL_RPLP_IDS(0),
> +	INTEL_RPLS_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_RPLP_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_rplu_ids[] = {
> -	INTEL_RPLU_IDS(0),
> +	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_g10_ids[] = {
> -	INTEL_DG2_G10_IDS(0),
> -	INTEL_ATS_M150_IDS(0),
> +	INTEL_DG2_G10_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_ATS_M150_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_g11_ids[] = {
> -	INTEL_DG2_G11_IDS(0),
> -	INTEL_ATS_M75_IDS(0),
> +	INTEL_DG2_G11_IDS(INTEL_VGA_DEVICE, 0),
> +	INTEL_ATS_M75_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static const u16 subplatform_g12_ids[] = {
> -	INTEL_DG2_G12_IDS(0),
> +	INTEL_DG2_G12_IDS(INTEL_VGA_DEVICE, 0),
>  };
>  
>  static bool find_devid(u16 id, const u16 *p, unsigned int num)
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 04f6ca3dc5c1..3e39d644ebaa 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -35,752 +35,752 @@
>   * Don't use C99 here because "class" is reserved and we want to
>   * give userspace flexibility.
>   */
> -#define INTEL_VGA_DEVICE(id, info) {		\
> -	0x8086,	id,				\
> -	~0, ~0,					\
> -	0x030000, 0xff0000,			\
> +#define INTEL_VGA_DEVICE(id, info) { \
> +	0x8086,	id, \
> +	~0, ~0, \
> +	0x030000, 0xff0000, \
>  	(unsigned long) info }
>  
> -#define INTEL_QUANTA_VGA_DEVICE(info) {		\
> -	0x8086,	0x16a,				\
> -	0x152d,	0x8990,				\
> -	0x030000, 0xff0000,			\
> +#define INTEL_QUANTA_VGA_DEVICE(info) { \
> +	0x8086,	0x16a, \
> +	0x152d,	0x8990, \
> +	0x030000, 0xff0000, \
>  	(unsigned long) info }
>  
> -#define INTEL_I810_IDS(info)					\
> -	INTEL_VGA_DEVICE(0x7121, info), /* I810 */		\
> -	INTEL_VGA_DEVICE(0x7123, info), /* I810_DC100 */	\
> -	INTEL_VGA_DEVICE(0x7125, info)  /* I810_E */
> +#define INTEL_I810_IDS(MACRO__, ...) \
> +	MACRO__(0x7121, ## __VA_ARGS__), /* I810 */ \
> +	MACRO__(0x7123, ## __VA_ARGS__), /* I810_DC100 */ \
> +	MACRO__(0x7125, ## __VA_ARGS__)  /* I810_E */
>  
> -#define INTEL_I815_IDS(info)					\
> -	INTEL_VGA_DEVICE(0x1132, info)  /* I815*/
> +#define INTEL_I815_IDS(MACRO__, ...) \
> +	MACRO__(0x1132, ## __VA_ARGS__)  /* I815*/
>  
> -#define INTEL_I830_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x3577, info)
> +#define INTEL_I830_IDS(MACRO__, ...) \
> +	MACRO__(0x3577, ## __VA_ARGS__)
>  
> -#define INTEL_I845G_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2562, info)
> +#define INTEL_I845G_IDS(MACRO__, ...) \
> +	MACRO__(0x2562, ## __VA_ARGS__)
>  
> -#define INTEL_I85X_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x3582, info), /* I855_GM */ \
> -	INTEL_VGA_DEVICE(0x358e, info)
> +#define INTEL_I85X_IDS(MACRO__, ...) \
> +	MACRO__(0x3582, ## __VA_ARGS__), /* I855_GM */ \
> +	MACRO__(0x358e, ## __VA_ARGS__)
>  
> -#define INTEL_I865G_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2572, info) /* I865_G */
> +#define INTEL_I865G_IDS(MACRO__, ...) \
> +	MACRO__(0x2572, ## __VA_ARGS__) /* I865_G */
>  
> -#define INTEL_I915G_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2582, info), /* I915_G */ \
> -	INTEL_VGA_DEVICE(0x258a, info)  /* E7221_G */
> +#define INTEL_I915G_IDS(MACRO__, ...) \
> +	MACRO__(0x2582, ## __VA_ARGS__), /* I915_G */ \
> +	MACRO__(0x258a, ## __VA_ARGS__)  /* E7221_G */
>  
> -#define INTEL_I915GM_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2592, info) /* I915_GM */
> +#define INTEL_I915GM_IDS(MACRO__, ...) \
> +	MACRO__(0x2592, ## __VA_ARGS__) /* I915_GM */
>  
> -#define INTEL_I945G_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2772, info) /* I945_G */
> +#define INTEL_I945G_IDS(MACRO__, ...) \
> +	MACRO__(0x2772, ## __VA_ARGS__) /* I945_G */
>  
> -#define INTEL_I945GM_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x27a2, info), /* I945_GM */ \
> -	INTEL_VGA_DEVICE(0x27ae, info)  /* I945_GME */
> +#define INTEL_I945GM_IDS(MACRO__, ...) \
> +	MACRO__(0x27a2, ## __VA_ARGS__), /* I945_GM */ \
> +	MACRO__(0x27ae, ## __VA_ARGS__)  /* I945_GME */
>  
> -#define INTEL_I965G_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2972, info), /* I946_GZ */	\
> -	INTEL_VGA_DEVICE(0x2982, info),	/* G35_G */	\
> -	INTEL_VGA_DEVICE(0x2992, info),	/* I965_Q */	\
> -	INTEL_VGA_DEVICE(0x29a2, info)	/* I965_G */
> +#define INTEL_I965G_IDS(MACRO__, ...) \
> +	MACRO__(0x2972, ## __VA_ARGS__), /* I946_GZ */ \
> +	MACRO__(0x2982, ## __VA_ARGS__),	/* G35_G */ \
> +	MACRO__(0x2992, ## __VA_ARGS__),	/* I965_Q */ \
> +	MACRO__(0x29a2, ## __VA_ARGS__)	/* I965_G */
>  
> -#define INTEL_G33_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x29b2, info), /* Q35_G */ \
> -	INTEL_VGA_DEVICE(0x29c2, info),	/* G33_G */ \
> -	INTEL_VGA_DEVICE(0x29d2, info)	/* Q33_G */
> +#define INTEL_G33_IDS(MACRO__, ...) \
> +	MACRO__(0x29b2, ## __VA_ARGS__), /* Q35_G */ \
> +	MACRO__(0x29c2, ## __VA_ARGS__),	/* G33_G */ \
> +	MACRO__(0x29d2, ## __VA_ARGS__)	/* Q33_G */
>  
> -#define INTEL_I965GM_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2a02, info),	/* I965_GM */ \
> -	INTEL_VGA_DEVICE(0x2a12, info)  /* I965_GME */
> +#define INTEL_I965GM_IDS(MACRO__, ...) \
> +	MACRO__(0x2a02, ## __VA_ARGS__),	/* I965_GM */ \
> +	MACRO__(0x2a12, ## __VA_ARGS__)  /* I965_GME */
>  
> -#define INTEL_GM45_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2a42, info) /* GM45_G */
> +#define INTEL_GM45_IDS(MACRO__, ...) \
> +	MACRO__(0x2a42, ## __VA_ARGS__) /* GM45_G */
>  
> -#define INTEL_G45_IDS(info)				\
> -	INTEL_VGA_DEVICE(0x2e02, info), /* IGD_E_G */ \
> -	INTEL_VGA_DEVICE(0x2e12, info), /* Q45_G */ \
> -	INTEL_VGA_DEVICE(0x2e22, info), /* G45_G */ \
> -	INTEL_VGA_DEVICE(0x2e32, info), /* G41_G */ \
> -	INTEL_VGA_DEVICE(0x2e42, info), /* B43_G */ \
> -	INTEL_VGA_DEVICE(0x2e92, info)	/* B43_G.1 */
> -
> -#define INTEL_PNV_G_IDS(info) \
> -	INTEL_VGA_DEVICE(0xa001, info)
> -
> -#define INTEL_PNV_M_IDS(info) \
> -	INTEL_VGA_DEVICE(0xa011, info)
> -
> -#define INTEL_PNV_IDS(info) \
> -	INTEL_PNV_G_IDS(info), \
> -	INTEL_PNV_M_IDS(info)
> -
> -#define INTEL_ILK_D_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0042, info)
> -
> -#define INTEL_ILK_M_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0046, info)
> -
> -#define INTEL_ILK_IDS(info) \
> -	INTEL_ILK_D_IDS(info), \
> -	INTEL_ILK_M_IDS(info)
> -
> -#define INTEL_SNB_D_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0102, info), \
> -	INTEL_VGA_DEVICE(0x010A, info)
> -
> -#define INTEL_SNB_D_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0112, info), \
> -	INTEL_VGA_DEVICE(0x0122, info)
> -
> -#define INTEL_SNB_D_IDS(info) \
> -	INTEL_SNB_D_GT1_IDS(info), \
> -	INTEL_SNB_D_GT2_IDS(info)
> -
> -#define INTEL_SNB_M_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0106, info)
> -
> -#define INTEL_SNB_M_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0116, info), \
> -	INTEL_VGA_DEVICE(0x0126, info)
> -
> -#define INTEL_SNB_M_IDS(info) \
> -	INTEL_SNB_M_GT1_IDS(info), \
> -	INTEL_SNB_M_GT2_IDS(info)
> -
> -#define INTEL_SNB_IDS(info) \
> -	INTEL_SNB_D_IDS(info), \
> -	INTEL_SNB_M_IDS(info)
> -
> -#define INTEL_IVB_M_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0156, info) /* GT1 mobile */
> -
> -#define INTEL_IVB_M_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0166, info) /* GT2 mobile */
> -
> -#define INTEL_IVB_M_IDS(info) \
> -	INTEL_IVB_M_GT1_IDS(info), \
> -	INTEL_IVB_M_GT2_IDS(info)
> -
> -#define INTEL_IVB_D_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0152, info), /* GT1 desktop */ \
> -	INTEL_VGA_DEVICE(0x015a, info)  /* GT1 server */
> -
> -#define INTEL_IVB_D_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0162, info), /* GT2 desktop */ \
> -	INTEL_VGA_DEVICE(0x016a, info)  /* GT2 server */
> -
> -#define INTEL_IVB_D_IDS(info) \
> -	INTEL_IVB_D_GT1_IDS(info), \
> -	INTEL_IVB_D_GT2_IDS(info)
> -
> -#define INTEL_IVB_IDS(info) \
> -	INTEL_IVB_M_IDS(info), \
> -	INTEL_IVB_D_IDS(info)
> -
> -#define INTEL_IVB_Q_IDS(info) \
> -	INTEL_QUANTA_VGA_DEVICE(info) /* Quanta transcode */
> -
> -#define INTEL_HSW_ULT_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0A02, info), /* ULT GT1 desktop */ \
> -	INTEL_VGA_DEVICE(0x0A06, info), /* ULT GT1 mobile */ \
> -	INTEL_VGA_DEVICE(0x0A0A, info), /* ULT GT1 server */ \
> -	INTEL_VGA_DEVICE(0x0A0B, info)  /* ULT GT1 reserved */
> -
> -#define INTEL_HSW_ULX_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0A0E, info) /* ULX GT1 mobile */
> -
> -#define INTEL_HSW_GT1_IDS(info) \
> -	INTEL_HSW_ULT_GT1_IDS(info), \
> -	INTEL_HSW_ULX_GT1_IDS(info), \
> -	INTEL_VGA_DEVICE(0x0402, info), /* GT1 desktop */ \
> -	INTEL_VGA_DEVICE(0x0406, info), /* GT1 mobile */ \
> -	INTEL_VGA_DEVICE(0x040A, info), /* GT1 server */ \
> -	INTEL_VGA_DEVICE(0x040B, info), /* GT1 reserved */ \
> -	INTEL_VGA_DEVICE(0x040E, info), /* GT1 reserved */ \
> -	INTEL_VGA_DEVICE(0x0C02, info), /* SDV GT1 desktop */ \
> -	INTEL_VGA_DEVICE(0x0C06, info), /* SDV GT1 mobile */ \
> -	INTEL_VGA_DEVICE(0x0C0A, info), /* SDV GT1 server */ \
> -	INTEL_VGA_DEVICE(0x0C0B, info), /* SDV GT1 reserved */ \
> -	INTEL_VGA_DEVICE(0x0C0E, info), /* SDV GT1 reserved */ \
> -	INTEL_VGA_DEVICE(0x0D02, info), /* CRW GT1 desktop */ \
> -	INTEL_VGA_DEVICE(0x0D06, info), /* CRW GT1 mobile */	\
> -	INTEL_VGA_DEVICE(0x0D0A, info), /* CRW GT1 server */ \
> -	INTEL_VGA_DEVICE(0x0D0B, info), /* CRW GT1 reserved */ \
> -	INTEL_VGA_DEVICE(0x0D0E, info)  /* CRW GT1 reserved */
> -
> -#define INTEL_HSW_ULT_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0A12, info), /* ULT GT2 desktop */ \
> -	INTEL_VGA_DEVICE(0x0A16, info), /* ULT GT2 mobile */	\
> -	INTEL_VGA_DEVICE(0x0A1A, info), /* ULT GT2 server */ \
> -	INTEL_VGA_DEVICE(0x0A1B, info)  /* ULT GT2 reserved */ \
> -
> -#define INTEL_HSW_ULX_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0A1E, info) /* ULX GT2 mobile */ \
> -
> -#define INTEL_HSW_GT2_IDS(info) \
> -	INTEL_HSW_ULT_GT2_IDS(info), \
> -	INTEL_HSW_ULX_GT2_IDS(info), \
> -	INTEL_VGA_DEVICE(0x0412, info), /* GT2 desktop */ \
> -	INTEL_VGA_DEVICE(0x0416, info), /* GT2 mobile */ \
> -	INTEL_VGA_DEVICE(0x041A, info), /* GT2 server */ \
> -	INTEL_VGA_DEVICE(0x041B, info), /* GT2 reserved */ \
> -	INTEL_VGA_DEVICE(0x041E, info), /* GT2 reserved */ \
> -	INTEL_VGA_DEVICE(0x0C12, info), /* SDV GT2 desktop */ \
> -	INTEL_VGA_DEVICE(0x0C16, info), /* SDV GT2 mobile */ \
> -	INTEL_VGA_DEVICE(0x0C1A, info), /* SDV GT2 server */ \
> -	INTEL_VGA_DEVICE(0x0C1B, info), /* SDV GT2 reserved */ \
> -	INTEL_VGA_DEVICE(0x0C1E, info), /* SDV GT2 reserved */ \
> -	INTEL_VGA_DEVICE(0x0D12, info), /* CRW GT2 desktop */ \
> -	INTEL_VGA_DEVICE(0x0D16, info), /* CRW GT2 mobile */ \
> -	INTEL_VGA_DEVICE(0x0D1A, info), /* CRW GT2 server */ \
> -	INTEL_VGA_DEVICE(0x0D1B, info), /* CRW GT2 reserved */ \
> -	INTEL_VGA_DEVICE(0x0D1E, info)  /* CRW GT2 reserved */
> -
> -#define INTEL_HSW_ULT_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0A22, info), /* ULT GT3 desktop */ \
> -	INTEL_VGA_DEVICE(0x0A26, info), /* ULT GT3 mobile */ \
> -	INTEL_VGA_DEVICE(0x0A2A, info), /* ULT GT3 server */ \
> -	INTEL_VGA_DEVICE(0x0A2B, info), /* ULT GT3 reserved */ \
> -	INTEL_VGA_DEVICE(0x0A2E, info)  /* ULT GT3 reserved */
> -
> -#define INTEL_HSW_GT3_IDS(info) \
> -	INTEL_HSW_ULT_GT3_IDS(info), \
> -	INTEL_VGA_DEVICE(0x0422, info), /* GT3 desktop */ \
> -	INTEL_VGA_DEVICE(0x0426, info), /* GT3 mobile */ \
> -	INTEL_VGA_DEVICE(0x042A, info), /* GT3 server */ \
> -	INTEL_VGA_DEVICE(0x042B, info), /* GT3 reserved */ \
> -	INTEL_VGA_DEVICE(0x042E, info), /* GT3 reserved */ \
> -	INTEL_VGA_DEVICE(0x0C22, info), /* SDV GT3 desktop */ \
> -	INTEL_VGA_DEVICE(0x0C26, info), /* SDV GT3 mobile */ \
> -	INTEL_VGA_DEVICE(0x0C2A, info), /* SDV GT3 server */ \
> -	INTEL_VGA_DEVICE(0x0C2B, info), /* SDV GT3 reserved */ \
> -	INTEL_VGA_DEVICE(0x0C2E, info), /* SDV GT3 reserved */ \
> -	INTEL_VGA_DEVICE(0x0D22, info), /* CRW GT3 desktop */ \
> -	INTEL_VGA_DEVICE(0x0D26, info), /* CRW GT3 mobile */ \
> -	INTEL_VGA_DEVICE(0x0D2A, info), /* CRW GT3 server */ \
> -	INTEL_VGA_DEVICE(0x0D2B, info), /* CRW GT3 reserved */ \
> -	INTEL_VGA_DEVICE(0x0D2E, info)  /* CRW GT3 reserved */
> -
> -#define INTEL_HSW_IDS(info) \
> -	INTEL_HSW_GT1_IDS(info), \
> -	INTEL_HSW_GT2_IDS(info), \
> -	INTEL_HSW_GT3_IDS(info)
> -
> -#define INTEL_VLV_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0f30, info), \
> -	INTEL_VGA_DEVICE(0x0f31, info), \
> -	INTEL_VGA_DEVICE(0x0f32, info), \
> -	INTEL_VGA_DEVICE(0x0f33, info)
> -
> -#define INTEL_BDW_ULT_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1606, info), /* GT1 ULT */ \
> -	INTEL_VGA_DEVICE(0x160B, info)  /* GT1 Iris */
> -
> -#define INTEL_BDW_ULX_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x160E, info) /* GT1 ULX */
> -
> -#define INTEL_BDW_GT1_IDS(info) \
> -	INTEL_BDW_ULT_GT1_IDS(info), \
> -	INTEL_BDW_ULX_GT1_IDS(info), \
> -	INTEL_VGA_DEVICE(0x1602, info), /* GT1 ULT */ \
> -	INTEL_VGA_DEVICE(0x160A, info), /* GT1 Server */ \
> -	INTEL_VGA_DEVICE(0x160D, info)  /* GT1 Workstation */
> -
> -#define INTEL_BDW_ULT_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1616, info), /* GT2 ULT */ \
> -	INTEL_VGA_DEVICE(0x161B, info)  /* GT2 ULT */
> -
> -#define INTEL_BDW_ULX_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x161E, info) /* GT2 ULX */
> -
> -#define INTEL_BDW_GT2_IDS(info) \
> -	INTEL_BDW_ULT_GT2_IDS(info), \
> -	INTEL_BDW_ULX_GT2_IDS(info), \
> -	INTEL_VGA_DEVICE(0x1612, info), /* GT2 Halo */	\
> -	INTEL_VGA_DEVICE(0x161A, info), /* GT2 Server */ \
> -	INTEL_VGA_DEVICE(0x161D, info)  /* GT2 Workstation */
> -
> -#define INTEL_BDW_ULT_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1626, info), /* ULT */ \
> -	INTEL_VGA_DEVICE(0x162B, info)  /* Iris */ \
> -
> -#define INTEL_BDW_ULX_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x162E, info)  /* ULX */
> -
> -#define INTEL_BDW_GT3_IDS(info) \
> -	INTEL_BDW_ULT_GT3_IDS(info), \
> -	INTEL_BDW_ULX_GT3_IDS(info), \
> -	INTEL_VGA_DEVICE(0x1622, info), /* ULT */ \
> -	INTEL_VGA_DEVICE(0x162A, info), /* Server */ \
> -	INTEL_VGA_DEVICE(0x162D, info)  /* Workstation */
> -
> -#define INTEL_BDW_ULT_RSVD_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1636, info), /* ULT */ \
> -	INTEL_VGA_DEVICE(0x163B, info)  /* Iris */
> -
> -#define INTEL_BDW_ULX_RSVD_IDS(info) \
> -	INTEL_VGA_DEVICE(0x163E, info) /* ULX */
> -
> -#define INTEL_BDW_RSVD_IDS(info) \
> -	INTEL_BDW_ULT_RSVD_IDS(info), \
> -	INTEL_BDW_ULX_RSVD_IDS(info), \
> -	INTEL_VGA_DEVICE(0x1632, info), /* ULT */ \
> -	INTEL_VGA_DEVICE(0x163A, info), /* Server */ \
> -	INTEL_VGA_DEVICE(0x163D, info)  /* Workstation */
> -
> -#define INTEL_BDW_IDS(info) \
> -	INTEL_BDW_GT1_IDS(info), \
> -	INTEL_BDW_GT2_IDS(info), \
> -	INTEL_BDW_GT3_IDS(info), \
> -	INTEL_BDW_RSVD_IDS(info)
> -
> -#define INTEL_CHV_IDS(info) \
> -	INTEL_VGA_DEVICE(0x22b0, info), \
> -	INTEL_VGA_DEVICE(0x22b1, info), \
> -	INTEL_VGA_DEVICE(0x22b2, info), \
> -	INTEL_VGA_DEVICE(0x22b3, info)
> -
> -#define INTEL_SKL_ULT_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1906, info), /* ULT GT1 */ \
> -	INTEL_VGA_DEVICE(0x1913, info)  /* ULT GT1.5 */
> -
> -#define INTEL_SKL_ULX_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x190E, info), /* ULX GT1 */ \
> -	INTEL_VGA_DEVICE(0x1915, info)  /* ULX GT1.5 */
> -
> -#define INTEL_SKL_GT1_IDS(info)	\
> -	INTEL_SKL_ULT_GT1_IDS(info), \
> -	INTEL_SKL_ULX_GT1_IDS(info), \
> -	INTEL_VGA_DEVICE(0x1902, info), /* DT  GT1 */ \
> -	INTEL_VGA_DEVICE(0x190A, info), /* SRV GT1 */ \
> -	INTEL_VGA_DEVICE(0x190B, info), /* Halo GT1 */ \
> -	INTEL_VGA_DEVICE(0x1917, info)  /* DT  GT1.5 */
> -
> -#define INTEL_SKL_ULT_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1916, info), /* ULT GT2 */ \
> -	INTEL_VGA_DEVICE(0x1921, info)  /* ULT GT2F */
> -
> -#define INTEL_SKL_ULX_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x191E, info) /* ULX GT2 */
> -
> -#define INTEL_SKL_GT2_IDS(info)	\
> -	INTEL_SKL_ULT_GT2_IDS(info), \
> -	INTEL_SKL_ULX_GT2_IDS(info), \
> -	INTEL_VGA_DEVICE(0x1912, info), /* DT  GT2 */ \
> -	INTEL_VGA_DEVICE(0x191A, info), /* SRV GT2 */ \
> -	INTEL_VGA_DEVICE(0x191B, info), /* Halo GT2 */ \
> -	INTEL_VGA_DEVICE(0x191D, info)  /* WKS GT2 */
> -
> -#define INTEL_SKL_ULT_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1923, info), /* ULT GT3 */ \
> -	INTEL_VGA_DEVICE(0x1926, info), /* ULT GT3e */ \
> -	INTEL_VGA_DEVICE(0x1927, info)  /* ULT GT3e */
> -
> -#define INTEL_SKL_GT3_IDS(info) \
> -	INTEL_SKL_ULT_GT3_IDS(info), \
> -	INTEL_VGA_DEVICE(0x192A, info), /* SRV GT3 */ \
> -	INTEL_VGA_DEVICE(0x192B, info), /* Halo GT3e */ \
> -	INTEL_VGA_DEVICE(0x192D, info)  /* SRV GT3e */
> -
> -#define INTEL_SKL_GT4_IDS(info) \
> -	INTEL_VGA_DEVICE(0x1932, info), /* DT GT4 */ \
> -	INTEL_VGA_DEVICE(0x193A, info), /* SRV GT4e */ \
> -	INTEL_VGA_DEVICE(0x193B, info), /* Halo GT4e */ \
> -	INTEL_VGA_DEVICE(0x193D, info) /* WKS GT4e */
> -
> -#define INTEL_SKL_IDS(info)	 \
> -	INTEL_SKL_GT1_IDS(info), \
> -	INTEL_SKL_GT2_IDS(info), \
> -	INTEL_SKL_GT3_IDS(info), \
> -	INTEL_SKL_GT4_IDS(info)
> -
> -#define INTEL_BXT_IDS(info) \
> -	INTEL_VGA_DEVICE(0x0A84, info), \
> -	INTEL_VGA_DEVICE(0x1A84, info), \
> -	INTEL_VGA_DEVICE(0x1A85, info), \
> -	INTEL_VGA_DEVICE(0x5A84, info), /* APL HD Graphics 505 */ \
> -	INTEL_VGA_DEVICE(0x5A85, info)  /* APL HD Graphics 500 */
> -
> -#define INTEL_GLK_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3184, info), \
> -	INTEL_VGA_DEVICE(0x3185, info)
> -
> -#define INTEL_KBL_ULT_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5906, info), /* ULT GT1 */ \
> -	INTEL_VGA_DEVICE(0x5913, info)  /* ULT GT1.5 */
> -
> -#define INTEL_KBL_ULX_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x590E, info), /* ULX GT1 */ \
> -	INTEL_VGA_DEVICE(0x5915, info)  /* ULX GT1.5 */
> -
> -#define INTEL_KBL_GT1_IDS(info)	\
> -	INTEL_KBL_ULT_GT1_IDS(info), \
> -	INTEL_KBL_ULX_GT1_IDS(info), \
> -	INTEL_VGA_DEVICE(0x5902, info), /* DT  GT1 */ \
> -	INTEL_VGA_DEVICE(0x5908, info), /* Halo GT1 */ \
> -	INTEL_VGA_DEVICE(0x590A, info), /* SRV GT1 */ \
> -	INTEL_VGA_DEVICE(0x590B, info) /* Halo GT1 */
> -
> -#define INTEL_KBL_ULT_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5916, info), /* ULT GT2 */ \
> -	INTEL_VGA_DEVICE(0x5921, info)  /* ULT GT2F */
> -
> -#define INTEL_KBL_ULX_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x591E, info)  /* ULX GT2 */
> -
> -#define INTEL_KBL_GT2_IDS(info)	\
> -	INTEL_KBL_ULT_GT2_IDS(info), \
> -	INTEL_KBL_ULX_GT2_IDS(info), \
> -	INTEL_VGA_DEVICE(0x5912, info), /* DT  GT2 */ \
> -	INTEL_VGA_DEVICE(0x5917, info), /* Mobile GT2 */ \
> -	INTEL_VGA_DEVICE(0x591A, info), /* SRV GT2 */ \
> -	INTEL_VGA_DEVICE(0x591B, info), /* Halo GT2 */ \
> -	INTEL_VGA_DEVICE(0x591D, info) /* WKS GT2 */
> -
> -#define INTEL_KBL_ULT_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5926, info) /* ULT GT3 */
> -
> -#define INTEL_KBL_GT3_IDS(info) \
> -	INTEL_KBL_ULT_GT3_IDS(info), \
> -	INTEL_VGA_DEVICE(0x5923, info), /* ULT GT3 */ \
> -	INTEL_VGA_DEVICE(0x5927, info) /* ULT GT3 */
> -
> -#define INTEL_KBL_GT4_IDS(info) \
> -	INTEL_VGA_DEVICE(0x593B, info) /* Halo GT4 */
> +#define INTEL_G45_IDS(MACRO__, ...) \
> +	MACRO__(0x2e02, ## __VA_ARGS__), /* IGD_E_G */ \
> +	MACRO__(0x2e12, ## __VA_ARGS__), /* Q45_G */ \
> +	MACRO__(0x2e22, ## __VA_ARGS__), /* G45_G */ \
> +	MACRO__(0x2e32, ## __VA_ARGS__), /* G41_G */ \
> +	MACRO__(0x2e42, ## __VA_ARGS__), /* B43_G */ \
> +	MACRO__(0x2e92, ## __VA_ARGS__)	/* B43_G.1 */
> +
> +#define INTEL_PNV_G_IDS(MACRO__, ...) \
> +	MACRO__(0xa001, ## __VA_ARGS__)
> +
> +#define INTEL_PNV_M_IDS(MACRO__, ...) \
> +	MACRO__(0xa011, ## __VA_ARGS__)
> +
> +#define INTEL_PNV_IDS(MACRO__, ...) \
> +	INTEL_PNV_G_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_PNV_M_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_ILK_D_IDS(MACRO__, ...) \
> +	MACRO__(0x0042, ## __VA_ARGS__)
> +
> +#define INTEL_ILK_M_IDS(MACRO__, ...) \
> +	MACRO__(0x0046, ## __VA_ARGS__)
> +
> +#define INTEL_ILK_IDS(MACRO__, ...) \
> +	INTEL_ILK_D_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_ILK_M_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_D_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x0102, ## __VA_ARGS__), \
> +	MACRO__(0x010A, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_D_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x0112, ## __VA_ARGS__), \
> +	MACRO__(0x0122, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_D_IDS(MACRO__, ...) \
> +	INTEL_SNB_D_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SNB_D_GT2_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_M_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x0106, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_M_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x0116, ## __VA_ARGS__), \
> +	MACRO__(0x0126, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_M_IDS(MACRO__, ...) \
> +	INTEL_SNB_M_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SNB_M_GT2_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_SNB_IDS(MACRO__, ...) \
> +	INTEL_SNB_D_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SNB_M_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_IVB_M_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x0156, ## __VA_ARGS__) /* GT1 mobile */
> +
> +#define INTEL_IVB_M_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x0166, ## __VA_ARGS__) /* GT2 mobile */
> +
> +#define INTEL_IVB_M_IDS(MACRO__, ...) \
> +	INTEL_IVB_M_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_IVB_M_GT2_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_IVB_D_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x0152, ## __VA_ARGS__), /* GT1 desktop */ \
> +	MACRO__(0x015a, ## __VA_ARGS__)  /* GT1 server */
> +
> +#define INTEL_IVB_D_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x0162, ## __VA_ARGS__), /* GT2 desktop */ \
> +	MACRO__(0x016a, ## __VA_ARGS__)  /* GT2 server */
> +
> +#define INTEL_IVB_D_IDS(MACRO__, ...) \
> +	INTEL_IVB_D_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_IVB_D_GT2_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_IVB_IDS(MACRO__, ...) \
> +	INTEL_IVB_M_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_IVB_D_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_IVB_Q_IDS(MACRO__, ...) \
> +	INTEL_QUANTA_VGA_DEVICE(__VA_ARGS__) /* Quanta transcode */
> +
> +#define INTEL_HSW_ULT_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x0A02, ## __VA_ARGS__), /* ULT GT1 desktop */ \
> +	MACRO__(0x0A06, ## __VA_ARGS__), /* ULT GT1 mobile */ \
> +	MACRO__(0x0A0A, ## __VA_ARGS__), /* ULT GT1 server */ \
> +	MACRO__(0x0A0B, ## __VA_ARGS__)  /* ULT GT1 reserved */
> +
> +#define INTEL_HSW_ULX_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x0A0E, ## __VA_ARGS__) /* ULX GT1 mobile */
> +
> +#define INTEL_HSW_GT1_IDS(MACRO__, ...) \
> +	INTEL_HSW_ULT_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_HSW_ULX_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x0402, ## __VA_ARGS__), /* GT1 desktop */ \
> +	MACRO__(0x0406, ## __VA_ARGS__), /* GT1 mobile */ \
> +	MACRO__(0x040A, ## __VA_ARGS__), /* GT1 server */ \
> +	MACRO__(0x040B, ## __VA_ARGS__), /* GT1 reserved */ \
> +	MACRO__(0x040E, ## __VA_ARGS__), /* GT1 reserved */ \
> +	MACRO__(0x0C02, ## __VA_ARGS__), /* SDV GT1 desktop */ \
> +	MACRO__(0x0C06, ## __VA_ARGS__), /* SDV GT1 mobile */ \
> +	MACRO__(0x0C0A, ## __VA_ARGS__), /* SDV GT1 server */ \
> +	MACRO__(0x0C0B, ## __VA_ARGS__), /* SDV GT1 reserved */ \
> +	MACRO__(0x0C0E, ## __VA_ARGS__), /* SDV GT1 reserved */ \
> +	MACRO__(0x0D02, ## __VA_ARGS__), /* CRW GT1 desktop */ \
> +	MACRO__(0x0D06, ## __VA_ARGS__), /* CRW GT1 mobile */ \
> +	MACRO__(0x0D0A, ## __VA_ARGS__), /* CRW GT1 server */ \
> +	MACRO__(0x0D0B, ## __VA_ARGS__), /* CRW GT1 reserved */ \
> +	MACRO__(0x0D0E, ## __VA_ARGS__)  /* CRW GT1 reserved */
> +
> +#define INTEL_HSW_ULT_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x0A12, ## __VA_ARGS__), /* ULT GT2 desktop */ \
> +	MACRO__(0x0A16, ## __VA_ARGS__), /* ULT GT2 mobile */ \
> +	MACRO__(0x0A1A, ## __VA_ARGS__), /* ULT GT2 server */ \
> +	MACRO__(0x0A1B, ## __VA_ARGS__)  /* ULT GT2 reserved */ \
> +
> +#define INTEL_HSW_ULX_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x0A1E, ## __VA_ARGS__) /* ULX GT2 mobile */ \
> +
> +#define INTEL_HSW_GT2_IDS(MACRO__, ...) \
> +	INTEL_HSW_ULT_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_HSW_ULX_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x0412, ## __VA_ARGS__), /* GT2 desktop */ \
> +	MACRO__(0x0416, ## __VA_ARGS__), /* GT2 mobile */ \
> +	MACRO__(0x041A, ## __VA_ARGS__), /* GT2 server */ \
> +	MACRO__(0x041B, ## __VA_ARGS__), /* GT2 reserved */ \
> +	MACRO__(0x041E, ## __VA_ARGS__), /* GT2 reserved */ \
> +	MACRO__(0x0C12, ## __VA_ARGS__), /* SDV GT2 desktop */ \
> +	MACRO__(0x0C16, ## __VA_ARGS__), /* SDV GT2 mobile */ \
> +	MACRO__(0x0C1A, ## __VA_ARGS__), /* SDV GT2 server */ \
> +	MACRO__(0x0C1B, ## __VA_ARGS__), /* SDV GT2 reserved */ \
> +	MACRO__(0x0C1E, ## __VA_ARGS__), /* SDV GT2 reserved */ \
> +	MACRO__(0x0D12, ## __VA_ARGS__), /* CRW GT2 desktop */ \
> +	MACRO__(0x0D16, ## __VA_ARGS__), /* CRW GT2 mobile */ \
> +	MACRO__(0x0D1A, ## __VA_ARGS__), /* CRW GT2 server */ \
> +	MACRO__(0x0D1B, ## __VA_ARGS__), /* CRW GT2 reserved */ \
> +	MACRO__(0x0D1E, ## __VA_ARGS__)  /* CRW GT2 reserved */
> +
> +#define INTEL_HSW_ULT_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x0A22, ## __VA_ARGS__), /* ULT GT3 desktop */ \
> +	MACRO__(0x0A26, ## __VA_ARGS__), /* ULT GT3 mobile */ \
> +	MACRO__(0x0A2A, ## __VA_ARGS__), /* ULT GT3 server */ \
> +	MACRO__(0x0A2B, ## __VA_ARGS__), /* ULT GT3 reserved */ \
> +	MACRO__(0x0A2E, ## __VA_ARGS__)  /* ULT GT3 reserved */
> +
> +#define INTEL_HSW_GT3_IDS(MACRO__, ...) \
> +	INTEL_HSW_ULT_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x0422, ## __VA_ARGS__), /* GT3 desktop */ \
> +	MACRO__(0x0426, ## __VA_ARGS__), /* GT3 mobile */ \
> +	MACRO__(0x042A, ## __VA_ARGS__), /* GT3 server */ \
> +	MACRO__(0x042B, ## __VA_ARGS__), /* GT3 reserved */ \
> +	MACRO__(0x042E, ## __VA_ARGS__), /* GT3 reserved */ \
> +	MACRO__(0x0C22, ## __VA_ARGS__), /* SDV GT3 desktop */ \
> +	MACRO__(0x0C26, ## __VA_ARGS__), /* SDV GT3 mobile */ \
> +	MACRO__(0x0C2A, ## __VA_ARGS__), /* SDV GT3 server */ \
> +	MACRO__(0x0C2B, ## __VA_ARGS__), /* SDV GT3 reserved */ \
> +	MACRO__(0x0C2E, ## __VA_ARGS__), /* SDV GT3 reserved */ \
> +	MACRO__(0x0D22, ## __VA_ARGS__), /* CRW GT3 desktop */ \
> +	MACRO__(0x0D26, ## __VA_ARGS__), /* CRW GT3 mobile */ \
> +	MACRO__(0x0D2A, ## __VA_ARGS__), /* CRW GT3 server */ \
> +	MACRO__(0x0D2B, ## __VA_ARGS__), /* CRW GT3 reserved */ \
> +	MACRO__(0x0D2E, ## __VA_ARGS__)  /* CRW GT3 reserved */
> +
> +#define INTEL_HSW_IDS(MACRO__, ...) \
> +	INTEL_HSW_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_HSW_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_HSW_GT3_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_VLV_IDS(MACRO__, ...) \
> +	MACRO__(0x0f30, ## __VA_ARGS__), \
> +	MACRO__(0x0f31, ## __VA_ARGS__), \
> +	MACRO__(0x0f32, ## __VA_ARGS__), \
> +	MACRO__(0x0f33, ## __VA_ARGS__)
> +
> +#define INTEL_BDW_ULT_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x1606, ## __VA_ARGS__), /* GT1 ULT */ \
> +	MACRO__(0x160B, ## __VA_ARGS__)  /* GT1 Iris */
> +
> +#define INTEL_BDW_ULX_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x160E, ## __VA_ARGS__) /* GT1 ULX */
> +
> +#define INTEL_BDW_GT1_IDS(MACRO__, ...) \
> +	INTEL_BDW_ULT_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_ULX_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x1602, ## __VA_ARGS__), /* GT1 ULT */ \
> +	MACRO__(0x160A, ## __VA_ARGS__), /* GT1 Server */ \
> +	MACRO__(0x160D, ## __VA_ARGS__)  /* GT1 Workstation */
> +
> +#define INTEL_BDW_ULT_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x1616, ## __VA_ARGS__), /* GT2 ULT */ \
> +	MACRO__(0x161B, ## __VA_ARGS__)  /* GT2 ULT */
> +
> +#define INTEL_BDW_ULX_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x161E, ## __VA_ARGS__) /* GT2 ULX */
> +
> +#define INTEL_BDW_GT2_IDS(MACRO__, ...) \
> +	INTEL_BDW_ULT_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_ULX_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x1612, ## __VA_ARGS__), /* GT2 Halo */ \
> +	MACRO__(0x161A, ## __VA_ARGS__), /* GT2 Server */ \
> +	MACRO__(0x161D, ## __VA_ARGS__)  /* GT2 Workstation */
> +
> +#define INTEL_BDW_ULT_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x1626, ## __VA_ARGS__), /* ULT */ \
> +	MACRO__(0x162B, ## __VA_ARGS__)  /* Iris */ \
> +
> +#define INTEL_BDW_ULX_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x162E, ## __VA_ARGS__)  /* ULX */
> +
> +#define INTEL_BDW_GT3_IDS(MACRO__, ...) \
> +	INTEL_BDW_ULT_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_ULX_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x1622, ## __VA_ARGS__), /* ULT */ \
> +	MACRO__(0x162A, ## __VA_ARGS__), /* Server */ \
> +	MACRO__(0x162D, ## __VA_ARGS__)  /* Workstation */
> +
> +#define INTEL_BDW_ULT_RSVD_IDS(MACRO__, ...) \
> +	MACRO__(0x1636, ## __VA_ARGS__), /* ULT */ \
> +	MACRO__(0x163B, ## __VA_ARGS__)  /* Iris */
> +
> +#define INTEL_BDW_ULX_RSVD_IDS(MACRO__, ...) \
> +	MACRO__(0x163E, ## __VA_ARGS__) /* ULX */
> +
> +#define INTEL_BDW_RSVD_IDS(MACRO__, ...) \
> +	INTEL_BDW_ULT_RSVD_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_ULX_RSVD_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x1632, ## __VA_ARGS__), /* ULT */ \
> +	MACRO__(0x163A, ## __VA_ARGS__), /* Server */ \
> +	MACRO__(0x163D, ## __VA_ARGS__)  /* Workstation */
> +
> +#define INTEL_BDW_IDS(MACRO__, ...) \
> +	INTEL_BDW_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_BDW_RSVD_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_CHV_IDS(MACRO__, ...) \
> +	MACRO__(0x22b0, ## __VA_ARGS__), \
> +	MACRO__(0x22b1, ## __VA_ARGS__), \
> +	MACRO__(0x22b2, ## __VA_ARGS__), \
> +	MACRO__(0x22b3, ## __VA_ARGS__)
> +
> +#define INTEL_SKL_ULT_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x1906, ## __VA_ARGS__), /* ULT GT1 */ \
> +	MACRO__(0x1913, ## __VA_ARGS__)  /* ULT GT1.5 */
> +
> +#define INTEL_SKL_ULX_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x190E, ## __VA_ARGS__), /* ULX GT1 */ \
> +	MACRO__(0x1915, ## __VA_ARGS__)  /* ULX GT1.5 */
> +
> +#define INTEL_SKL_GT1_IDS(MACRO__, ...) \
> +	INTEL_SKL_ULT_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SKL_ULX_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x1902, ## __VA_ARGS__), /* DT  GT1 */ \
> +	MACRO__(0x190A, ## __VA_ARGS__), /* SRV GT1 */ \
> +	MACRO__(0x190B, ## __VA_ARGS__), /* Halo GT1 */ \
> +	MACRO__(0x1917, ## __VA_ARGS__)  /* DT  GT1.5 */
> +
> +#define INTEL_SKL_ULT_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x1916, ## __VA_ARGS__), /* ULT GT2 */ \
> +	MACRO__(0x1921, ## __VA_ARGS__)  /* ULT GT2F */
> +
> +#define INTEL_SKL_ULX_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x191E, ## __VA_ARGS__) /* ULX GT2 */
> +
> +#define INTEL_SKL_GT2_IDS(MACRO__, ...) \
> +	INTEL_SKL_ULT_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SKL_ULX_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x1912, ## __VA_ARGS__), /* DT  GT2 */ \
> +	MACRO__(0x191A, ## __VA_ARGS__), /* SRV GT2 */ \
> +	MACRO__(0x191B, ## __VA_ARGS__), /* Halo GT2 */ \
> +	MACRO__(0x191D, ## __VA_ARGS__)  /* WKS GT2 */
> +
> +#define INTEL_SKL_ULT_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x1923, ## __VA_ARGS__), /* ULT GT3 */ \
> +	MACRO__(0x1926, ## __VA_ARGS__), /* ULT GT3e */ \
> +	MACRO__(0x1927, ## __VA_ARGS__)  /* ULT GT3e */
> +
> +#define INTEL_SKL_GT3_IDS(MACRO__, ...) \
> +	INTEL_SKL_ULT_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x192A, ## __VA_ARGS__), /* SRV GT3 */ \
> +	MACRO__(0x192B, ## __VA_ARGS__), /* Halo GT3e */ \
> +	MACRO__(0x192D, ## __VA_ARGS__)  /* SRV GT3e */
> +
> +#define INTEL_SKL_GT4_IDS(MACRO__, ...) \
> +	MACRO__(0x1932, ## __VA_ARGS__), /* DT GT4 */ \
> +	MACRO__(0x193A, ## __VA_ARGS__), /* SRV GT4e */ \
> +	MACRO__(0x193B, ## __VA_ARGS__), /* Halo GT4e */ \
> +	MACRO__(0x193D, ## __VA_ARGS__) /* WKS GT4e */
> +
> +#define INTEL_SKL_IDS(MACRO__, ...) \
> +	INTEL_SKL_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SKL_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SKL_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_SKL_GT4_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_BXT_IDS(MACRO__, ...) \
> +	MACRO__(0x0A84, ## __VA_ARGS__), \
> +	MACRO__(0x1A84, ## __VA_ARGS__), \
> +	MACRO__(0x1A85, ## __VA_ARGS__), \
> +	MACRO__(0x5A84, ## __VA_ARGS__), /* APL HD Graphics 505 */ \
> +	MACRO__(0x5A85, ## __VA_ARGS__)  /* APL HD Graphics 500 */
> +
> +#define INTEL_GLK_IDS(MACRO__, ...) \
> +	MACRO__(0x3184, ## __VA_ARGS__), \
> +	MACRO__(0x3185, ## __VA_ARGS__)
> +
> +#define INTEL_KBL_ULT_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x5906, ## __VA_ARGS__), /* ULT GT1 */ \
> +	MACRO__(0x5913, ## __VA_ARGS__)  /* ULT GT1.5 */
> +
> +#define INTEL_KBL_ULX_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x590E, ## __VA_ARGS__), /* ULX GT1 */ \
> +	MACRO__(0x5915, ## __VA_ARGS__)  /* ULX GT1.5 */
> +
> +#define INTEL_KBL_GT1_IDS(MACRO__, ...) \
> +	INTEL_KBL_ULT_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_KBL_ULX_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x5902, ## __VA_ARGS__), /* DT  GT1 */ \
> +	MACRO__(0x5908, ## __VA_ARGS__), /* Halo GT1 */ \
> +	MACRO__(0x590A, ## __VA_ARGS__), /* SRV GT1 */ \
> +	MACRO__(0x590B, ## __VA_ARGS__) /* Halo GT1 */
> +
> +#define INTEL_KBL_ULT_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x5916, ## __VA_ARGS__), /* ULT GT2 */ \
> +	MACRO__(0x5921, ## __VA_ARGS__)  /* ULT GT2F */
> +
> +#define INTEL_KBL_ULX_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x591E, ## __VA_ARGS__)  /* ULX GT2 */
> +
> +#define INTEL_KBL_GT2_IDS(MACRO__, ...) \
> +	INTEL_KBL_ULT_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_KBL_ULX_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x5912, ## __VA_ARGS__), /* DT  GT2 */ \
> +	MACRO__(0x5917, ## __VA_ARGS__), /* Mobile GT2 */ \
> +	MACRO__(0x591A, ## __VA_ARGS__), /* SRV GT2 */ \
> +	MACRO__(0x591B, ## __VA_ARGS__), /* Halo GT2 */ \
> +	MACRO__(0x591D, ## __VA_ARGS__) /* WKS GT2 */
> +
> +#define INTEL_KBL_ULT_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x5926, ## __VA_ARGS__) /* ULT GT3 */
> +
> +#define INTEL_KBL_GT3_IDS(MACRO__, ...) \
> +	INTEL_KBL_ULT_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x5923, ## __VA_ARGS__), /* ULT GT3 */ \
> +	MACRO__(0x5927, ## __VA_ARGS__) /* ULT GT3 */
> +
> +#define INTEL_KBL_GT4_IDS(MACRO__, ...) \
> +	MACRO__(0x593B, ## __VA_ARGS__) /* Halo GT4 */
>  
>  /* AML/KBL Y GT2 */
> -#define INTEL_AML_KBL_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x591C, info),  /* ULX GT2 */ \
> -	INTEL_VGA_DEVICE(0x87C0, info) /* ULX GT2 */
> +#define INTEL_AML_KBL_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x591C, ## __VA_ARGS__),  /* ULX GT2 */ \
> +	MACRO__(0x87C0, ## __VA_ARGS__) /* ULX GT2 */
>  
>  /* AML/CFL Y GT2 */
> -#define INTEL_AML_CFL_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x87CA, info)
> +#define INTEL_AML_CFL_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x87CA, ## __VA_ARGS__)
>  
>  /* CML GT1 */
> -#define INTEL_CML_GT1_IDS(info)	\
> -	INTEL_VGA_DEVICE(0x9BA2, info), \
> -	INTEL_VGA_DEVICE(0x9BA4, info), \
> -	INTEL_VGA_DEVICE(0x9BA5, info), \
> -	INTEL_VGA_DEVICE(0x9BA8, info)
> +#define INTEL_CML_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x9BA2, ## __VA_ARGS__), \
> +	MACRO__(0x9BA4, ## __VA_ARGS__), \
> +	MACRO__(0x9BA5, ## __VA_ARGS__), \
> +	MACRO__(0x9BA8, ## __VA_ARGS__)
>  
> -#define INTEL_CML_U_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x9B21, info), \
> -	INTEL_VGA_DEVICE(0x9BAA, info), \
> -	INTEL_VGA_DEVICE(0x9BAC, info)
> +#define INTEL_CML_U_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x9B21, ## __VA_ARGS__), \
> +	MACRO__(0x9BAA, ## __VA_ARGS__), \
> +	MACRO__(0x9BAC, ## __VA_ARGS__)
>  
>  /* CML GT2 */
> -#define INTEL_CML_GT2_IDS(info)	\
> -	INTEL_VGA_DEVICE(0x9BC2, info), \
> -	INTEL_VGA_DEVICE(0x9BC4, info), \
> -	INTEL_VGA_DEVICE(0x9BC5, info), \
> -	INTEL_VGA_DEVICE(0x9BC6, info), \
> -	INTEL_VGA_DEVICE(0x9BC8, info), \
> -	INTEL_VGA_DEVICE(0x9BE6, info), \
> -	INTEL_VGA_DEVICE(0x9BF6, info)
> -
> -#define INTEL_CML_U_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x9B41, info), \
> -	INTEL_VGA_DEVICE(0x9BCA, info), \
> -	INTEL_VGA_DEVICE(0x9BCC, info)
> -
> -#define INTEL_CML_IDS(info) \
> -	INTEL_CML_GT1_IDS(info), \
> -	INTEL_CML_GT2_IDS(info), \
> -	INTEL_CML_U_GT1_IDS(info), \
> -	INTEL_CML_U_GT2_IDS(info)
> -
> -#define INTEL_KBL_IDS(info) \
> -	INTEL_KBL_GT1_IDS(info), \
> -	INTEL_KBL_GT2_IDS(info), \
> -	INTEL_KBL_GT3_IDS(info), \
> -	INTEL_KBL_GT4_IDS(info), \
> -	INTEL_AML_KBL_GT2_IDS(info)
> +#define INTEL_CML_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x9BC2, ## __VA_ARGS__), \
> +	MACRO__(0x9BC4, ## __VA_ARGS__), \
> +	MACRO__(0x9BC5, ## __VA_ARGS__), \
> +	MACRO__(0x9BC6, ## __VA_ARGS__), \
> +	MACRO__(0x9BC8, ## __VA_ARGS__), \
> +	MACRO__(0x9BE6, ## __VA_ARGS__), \
> +	MACRO__(0x9BF6, ## __VA_ARGS__)
> +
> +#define INTEL_CML_U_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x9B41, ## __VA_ARGS__), \
> +	MACRO__(0x9BCA, ## __VA_ARGS__), \
> +	MACRO__(0x9BCC, ## __VA_ARGS__)
> +
> +#define INTEL_CML_IDS(MACRO__, ...) \
> +	INTEL_CML_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CML_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CML_U_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CML_U_GT2_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_KBL_IDS(MACRO__, ...) \
> +	INTEL_KBL_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_KBL_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_KBL_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_KBL_GT4_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_AML_KBL_GT2_IDS(MACRO__, ## __VA_ARGS__)
>  
>  /* CFL S */
> -#define INTEL_CFL_S_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3E90, info), /* SRV GT1 */ \
> -	INTEL_VGA_DEVICE(0x3E93, info), /* SRV GT1 */ \
> -	INTEL_VGA_DEVICE(0x3E99, info)  /* SRV GT1 */
> -
> -#define INTEL_CFL_S_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3E91, info), /* SRV GT2 */ \
> -	INTEL_VGA_DEVICE(0x3E92, info), /* SRV GT2 */ \
> -	INTEL_VGA_DEVICE(0x3E96, info), /* SRV GT2 */ \
> -	INTEL_VGA_DEVICE(0x3E98, info), /* SRV GT2 */ \
> -	INTEL_VGA_DEVICE(0x3E9A, info)  /* SRV GT2 */
> +#define INTEL_CFL_S_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x3E90, ## __VA_ARGS__), /* SRV GT1 */ \
> +	MACRO__(0x3E93, ## __VA_ARGS__), /* SRV GT1 */ \
> +	MACRO__(0x3E99, ## __VA_ARGS__)  /* SRV GT1 */
> +
> +#define INTEL_CFL_S_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x3E91, ## __VA_ARGS__), /* SRV GT2 */ \
> +	MACRO__(0x3E92, ## __VA_ARGS__), /* SRV GT2 */ \
> +	MACRO__(0x3E96, ## __VA_ARGS__), /* SRV GT2 */ \
> +	MACRO__(0x3E98, ## __VA_ARGS__), /* SRV GT2 */ \
> +	MACRO__(0x3E9A, ## __VA_ARGS__)  /* SRV GT2 */
>  
>  /* CFL H */
> -#define INTEL_CFL_H_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3E9C, info)
> +#define INTEL_CFL_H_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x3E9C, ## __VA_ARGS__)
>  
> -#define INTEL_CFL_H_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3E94, info),  /* Halo GT2 */ \
> -	INTEL_VGA_DEVICE(0x3E9B, info) /* Halo GT2 */
> +#define INTEL_CFL_H_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x3E94, ## __VA_ARGS__),  /* Halo GT2 */ \
> +	MACRO__(0x3E9B, ## __VA_ARGS__) /* Halo GT2 */
>  
>  /* CFL U GT2 */
> -#define INTEL_CFL_U_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3EA9, info)
> +#define INTEL_CFL_U_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x3EA9, ## __VA_ARGS__)
>  
>  /* CFL U GT3 */
> -#define INTEL_CFL_U_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3EA5, info), /* ULT GT3 */ \
> -	INTEL_VGA_DEVICE(0x3EA6, info), /* ULT GT3 */ \
> -	INTEL_VGA_DEVICE(0x3EA7, info), /* ULT GT3 */ \
> -	INTEL_VGA_DEVICE(0x3EA8, info)  /* ULT GT3 */
> -
> -#define INTEL_CFL_IDS(info)	   \
> -	INTEL_CFL_S_GT1_IDS(info), \
> -	INTEL_CFL_S_GT2_IDS(info), \
> -	INTEL_CFL_H_GT1_IDS(info), \
> -	INTEL_CFL_H_GT2_IDS(info), \
> -	INTEL_CFL_U_GT2_IDS(info), \
> -	INTEL_CFL_U_GT3_IDS(info), \
> -	INTEL_AML_CFL_GT2_IDS(info)
> +#define INTEL_CFL_U_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x3EA5, ## __VA_ARGS__), /* ULT GT3 */ \
> +	MACRO__(0x3EA6, ## __VA_ARGS__), /* ULT GT3 */ \
> +	MACRO__(0x3EA7, ## __VA_ARGS__), /* ULT GT3 */ \
> +	MACRO__(0x3EA8, ## __VA_ARGS__)  /* ULT GT3 */
> +
> +#define INTEL_CFL_IDS(MACRO__, ...) \
> +	INTEL_CFL_S_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CFL_S_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CFL_H_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CFL_H_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CFL_U_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_CFL_U_GT3_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_AML_CFL_GT2_IDS(MACRO__, ## __VA_ARGS__)
>  
>  /* WHL/CFL U GT1 */
> -#define INTEL_WHL_U_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3EA1, info), \
> -	INTEL_VGA_DEVICE(0x3EA4, info)
> +#define INTEL_WHL_U_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x3EA1, ## __VA_ARGS__), \
> +	MACRO__(0x3EA4, ## __VA_ARGS__)
>  
>  /* WHL/CFL U GT2 */
> -#define INTEL_WHL_U_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3EA0, info), \
> -	INTEL_VGA_DEVICE(0x3EA3, info)
> +#define INTEL_WHL_U_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x3EA0, ## __VA_ARGS__), \
> +	MACRO__(0x3EA3, ## __VA_ARGS__)
>  
>  /* WHL/CFL U GT3 */
> -#define INTEL_WHL_U_GT3_IDS(info) \
> -	INTEL_VGA_DEVICE(0x3EA2, info)
> +#define INTEL_WHL_U_GT3_IDS(MACRO__, ...) \
> +	MACRO__(0x3EA2, ## __VA_ARGS__)
>  
> -#define INTEL_WHL_IDS(info) \
> -	INTEL_WHL_U_GT1_IDS(info), \
> -	INTEL_WHL_U_GT2_IDS(info), \
> -	INTEL_WHL_U_GT3_IDS(info)
> +#define INTEL_WHL_IDS(MACRO__, ...) \
> +	INTEL_WHL_U_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_WHL_U_GT2_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_WHL_U_GT3_IDS(MACRO__, ## __VA_ARGS__)
>  
>  /* CNL */
> -#define INTEL_CNL_PORT_F_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5A44, info), \
> -	INTEL_VGA_DEVICE(0x5A4C, info), \
> -	INTEL_VGA_DEVICE(0x5A54, info), \
> -	INTEL_VGA_DEVICE(0x5A5C, info)
> -
> -#define INTEL_CNL_IDS(info) \
> -	INTEL_CNL_PORT_F_IDS(info), \
> -	INTEL_VGA_DEVICE(0x5A40, info), \
> -	INTEL_VGA_DEVICE(0x5A41, info), \
> -	INTEL_VGA_DEVICE(0x5A42, info), \
> -	INTEL_VGA_DEVICE(0x5A49, info), \
> -	INTEL_VGA_DEVICE(0x5A4A, info), \
> -	INTEL_VGA_DEVICE(0x5A50, info), \
> -	INTEL_VGA_DEVICE(0x5A51, info), \
> -	INTEL_VGA_DEVICE(0x5A52, info), \
> -	INTEL_VGA_DEVICE(0x5A59, info), \
> -	INTEL_VGA_DEVICE(0x5A5A, info)
> +#define INTEL_CNL_PORT_F_IDS(MACRO__, ...) \
> +	MACRO__(0x5A44, ## __VA_ARGS__), \
> +	MACRO__(0x5A4C, ## __VA_ARGS__), \
> +	MACRO__(0x5A54, ## __VA_ARGS__), \
> +	MACRO__(0x5A5C, ## __VA_ARGS__)
> +
> +#define INTEL_CNL_IDS(MACRO__, ...) \
> +	INTEL_CNL_PORT_F_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x5A40, ## __VA_ARGS__), \
> +	MACRO__(0x5A41, ## __VA_ARGS__), \
> +	MACRO__(0x5A42, ## __VA_ARGS__), \
> +	MACRO__(0x5A49, ## __VA_ARGS__), \
> +	MACRO__(0x5A4A, ## __VA_ARGS__), \
> +	MACRO__(0x5A50, ## __VA_ARGS__), \
> +	MACRO__(0x5A51, ## __VA_ARGS__), \
> +	MACRO__(0x5A52, ## __VA_ARGS__), \
> +	MACRO__(0x5A59, ## __VA_ARGS__), \
> +	MACRO__(0x5A5A, ## __VA_ARGS__)
>  
>  /* ICL */
> -#define INTEL_ICL_PORT_F_IDS(info) \
> -	INTEL_VGA_DEVICE(0x8A50, info), \
> -	INTEL_VGA_DEVICE(0x8A52, info), \
> -	INTEL_VGA_DEVICE(0x8A53, info), \
> -	INTEL_VGA_DEVICE(0x8A54, info), \
> -	INTEL_VGA_DEVICE(0x8A56, info), \
> -	INTEL_VGA_DEVICE(0x8A57, info), \
> -	INTEL_VGA_DEVICE(0x8A58, info),	\
> -	INTEL_VGA_DEVICE(0x8A59, info),	\
> -	INTEL_VGA_DEVICE(0x8A5A, info), \
> -	INTEL_VGA_DEVICE(0x8A5B, info), \
> -	INTEL_VGA_DEVICE(0x8A5C, info), \
> -	INTEL_VGA_DEVICE(0x8A70, info), \
> -	INTEL_VGA_DEVICE(0x8A71, info)
> -
> -#define INTEL_ICL_IDS(info) \
> -	INTEL_ICL_PORT_F_IDS(info), \
> -	INTEL_VGA_DEVICE(0x8A51, info), \
> -	INTEL_VGA_DEVICE(0x8A5D, info)
> +#define INTEL_ICL_PORT_F_IDS(MACRO__, ...) \
> +	MACRO__(0x8A50, ## __VA_ARGS__), \
> +	MACRO__(0x8A52, ## __VA_ARGS__), \
> +	MACRO__(0x8A53, ## __VA_ARGS__), \
> +	MACRO__(0x8A54, ## __VA_ARGS__), \
> +	MACRO__(0x8A56, ## __VA_ARGS__), \
> +	MACRO__(0x8A57, ## __VA_ARGS__), \
> +	MACRO__(0x8A58, ## __VA_ARGS__), \
> +	MACRO__(0x8A59, ## __VA_ARGS__), \
> +	MACRO__(0x8A5A, ## __VA_ARGS__), \
> +	MACRO__(0x8A5B, ## __VA_ARGS__), \
> +	MACRO__(0x8A5C, ## __VA_ARGS__), \
> +	MACRO__(0x8A70, ## __VA_ARGS__), \
> +	MACRO__(0x8A71, ## __VA_ARGS__)
> +
> +#define INTEL_ICL_IDS(MACRO__, ...) \
> +	INTEL_ICL_PORT_F_IDS(MACRO__, ## __VA_ARGS__), \
> +	MACRO__(0x8A51, ## __VA_ARGS__), \
> +	MACRO__(0x8A5D, ## __VA_ARGS__)
>  
>  /* EHL */
> -#define INTEL_EHL_IDS(info) \
> -	INTEL_VGA_DEVICE(0x4541, info), \
> -	INTEL_VGA_DEVICE(0x4551, info), \
> -	INTEL_VGA_DEVICE(0x4555, info), \
> -	INTEL_VGA_DEVICE(0x4557, info), \
> -	INTEL_VGA_DEVICE(0x4570, info), \
> -	INTEL_VGA_DEVICE(0x4571, info)
> +#define INTEL_EHL_IDS(MACRO__, ...) \
> +	MACRO__(0x4541, ## __VA_ARGS__), \
> +	MACRO__(0x4551, ## __VA_ARGS__), \
> +	MACRO__(0x4555, ## __VA_ARGS__), \
> +	MACRO__(0x4557, ## __VA_ARGS__), \
> +	MACRO__(0x4570, ## __VA_ARGS__), \
> +	MACRO__(0x4571, ## __VA_ARGS__)
>  
>  /* JSL */
> -#define INTEL_JSL_IDS(info) \
> -	INTEL_VGA_DEVICE(0x4E51, info), \
> -	INTEL_VGA_DEVICE(0x4E55, info), \
> -	INTEL_VGA_DEVICE(0x4E57, info), \
> -	INTEL_VGA_DEVICE(0x4E61, info), \
> -	INTEL_VGA_DEVICE(0x4E71, info)
> +#define INTEL_JSL_IDS(MACRO__, ...) \
> +	MACRO__(0x4E51, ## __VA_ARGS__), \
> +	MACRO__(0x4E55, ## __VA_ARGS__), \
> +	MACRO__(0x4E57, ## __VA_ARGS__), \
> +	MACRO__(0x4E61, ## __VA_ARGS__), \
> +	MACRO__(0x4E71, ## __VA_ARGS__)
>  
>  /* TGL */
> -#define INTEL_TGL_GT1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x9A60, info), \
> -	INTEL_VGA_DEVICE(0x9A68, info), \
> -	INTEL_VGA_DEVICE(0x9A70, info)
> -
> -#define INTEL_TGL_GT2_IDS(info) \
> -	INTEL_VGA_DEVICE(0x9A40, info), \
> -	INTEL_VGA_DEVICE(0x9A49, info), \
> -	INTEL_VGA_DEVICE(0x9A59, info), \
> -	INTEL_VGA_DEVICE(0x9A78, info), \
> -	INTEL_VGA_DEVICE(0x9AC0, info), \
> -	INTEL_VGA_DEVICE(0x9AC9, info), \
> -	INTEL_VGA_DEVICE(0x9AD9, info), \
> -	INTEL_VGA_DEVICE(0x9AF8, info)
> -
> -#define INTEL_TGL_IDS(info) \
> -	INTEL_TGL_GT1_IDS(info), \
> -	INTEL_TGL_GT2_IDS(info)
> +#define INTEL_TGL_GT1_IDS(MACRO__, ...) \
> +	MACRO__(0x9A60, ## __VA_ARGS__), \
> +	MACRO__(0x9A68, ## __VA_ARGS__), \
> +	MACRO__(0x9A70, ## __VA_ARGS__)
> +
> +#define INTEL_TGL_GT2_IDS(MACRO__, ...) \
> +	MACRO__(0x9A40, ## __VA_ARGS__), \
> +	MACRO__(0x9A49, ## __VA_ARGS__), \
> +	MACRO__(0x9A59, ## __VA_ARGS__), \
> +	MACRO__(0x9A78, ## __VA_ARGS__), \
> +	MACRO__(0x9AC0, ## __VA_ARGS__), \
> +	MACRO__(0x9AC9, ## __VA_ARGS__), \
> +	MACRO__(0x9AD9, ## __VA_ARGS__), \
> +	MACRO__(0x9AF8, ## __VA_ARGS__)
> +
> +#define INTEL_TGL_IDS(MACRO__, ...) \
> +	INTEL_TGL_GT1_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_TGL_GT2_IDS(MACRO__, ## __VA_ARGS__)
>  
>  /* RKL */
> -#define INTEL_RKL_IDS(info) \
> -	INTEL_VGA_DEVICE(0x4C80, info), \
> -	INTEL_VGA_DEVICE(0x4C8A, info), \
> -	INTEL_VGA_DEVICE(0x4C8B, info), \
> -	INTEL_VGA_DEVICE(0x4C8C, info), \
> -	INTEL_VGA_DEVICE(0x4C90, info), \
> -	INTEL_VGA_DEVICE(0x4C9A, info)
> +#define INTEL_RKL_IDS(MACRO__, ...) \
> +	MACRO__(0x4C80, ## __VA_ARGS__), \
> +	MACRO__(0x4C8A, ## __VA_ARGS__), \
> +	MACRO__(0x4C8B, ## __VA_ARGS__), \
> +	MACRO__(0x4C8C, ## __VA_ARGS__), \
> +	MACRO__(0x4C90, ## __VA_ARGS__), \
> +	MACRO__(0x4C9A, ## __VA_ARGS__)
>  
>  /* DG1 */
> -#define INTEL_DG1_IDS(info) \
> -	INTEL_VGA_DEVICE(0x4905, info), \
> -	INTEL_VGA_DEVICE(0x4906, info), \
> -	INTEL_VGA_DEVICE(0x4907, info), \
> -	INTEL_VGA_DEVICE(0x4908, info), \
> -	INTEL_VGA_DEVICE(0x4909, info)
> +#define INTEL_DG1_IDS(MACRO__, ...) \
> +	MACRO__(0x4905, ## __VA_ARGS__), \
> +	MACRO__(0x4906, ## __VA_ARGS__), \
> +	MACRO__(0x4907, ## __VA_ARGS__), \
> +	MACRO__(0x4908, ## __VA_ARGS__), \
> +	MACRO__(0x4909, ## __VA_ARGS__)
>  
>  /* ADL-S */
> -#define INTEL_ADLS_IDS(info) \
> -	INTEL_VGA_DEVICE(0x4680, info), \
> -	INTEL_VGA_DEVICE(0x4682, info), \
> -	INTEL_VGA_DEVICE(0x4688, info), \
> -	INTEL_VGA_DEVICE(0x468A, info), \
> -	INTEL_VGA_DEVICE(0x468B, info), \
> -	INTEL_VGA_DEVICE(0x4690, info), \
> -	INTEL_VGA_DEVICE(0x4692, info), \
> -	INTEL_VGA_DEVICE(0x4693, info)
> +#define INTEL_ADLS_IDS(MACRO__, ...) \
> +	MACRO__(0x4680, ## __VA_ARGS__), \
> +	MACRO__(0x4682, ## __VA_ARGS__), \
> +	MACRO__(0x4688, ## __VA_ARGS__), \
> +	MACRO__(0x468A, ## __VA_ARGS__), \
> +	MACRO__(0x468B, ## __VA_ARGS__), \
> +	MACRO__(0x4690, ## __VA_ARGS__), \
> +	MACRO__(0x4692, ## __VA_ARGS__), \
> +	MACRO__(0x4693, ## __VA_ARGS__)
>  
>  /* ADL-P */
> -#define INTEL_ADLP_IDS(info) \
> -	INTEL_VGA_DEVICE(0x46A0, info), \
> -	INTEL_VGA_DEVICE(0x46A1, info), \
> -	INTEL_VGA_DEVICE(0x46A2, info), \
> -	INTEL_VGA_DEVICE(0x46A3, info), \
> -	INTEL_VGA_DEVICE(0x46A6, info), \
> -	INTEL_VGA_DEVICE(0x46A8, info), \
> -	INTEL_VGA_DEVICE(0x46AA, info), \
> -	INTEL_VGA_DEVICE(0x462A, info), \
> -	INTEL_VGA_DEVICE(0x4626, info), \
> -	INTEL_VGA_DEVICE(0x4628, info), \
> -	INTEL_VGA_DEVICE(0x46B0, info), \
> -	INTEL_VGA_DEVICE(0x46B1, info), \
> -	INTEL_VGA_DEVICE(0x46B2, info), \
> -	INTEL_VGA_DEVICE(0x46B3, info), \
> -	INTEL_VGA_DEVICE(0x46C0, info), \
> -	INTEL_VGA_DEVICE(0x46C1, info), \
> -	INTEL_VGA_DEVICE(0x46C2, info), \
> -	INTEL_VGA_DEVICE(0x46C3, info)
> +#define INTEL_ADLP_IDS(MACRO__, ...) \
> +	MACRO__(0x46A0, ## __VA_ARGS__), \
> +	MACRO__(0x46A1, ## __VA_ARGS__), \
> +	MACRO__(0x46A2, ## __VA_ARGS__), \
> +	MACRO__(0x46A3, ## __VA_ARGS__), \
> +	MACRO__(0x46A6, ## __VA_ARGS__), \
> +	MACRO__(0x46A8, ## __VA_ARGS__), \
> +	MACRO__(0x46AA, ## __VA_ARGS__), \
> +	MACRO__(0x462A, ## __VA_ARGS__), \
> +	MACRO__(0x4626, ## __VA_ARGS__), \
> +	MACRO__(0x4628, ## __VA_ARGS__), \
> +	MACRO__(0x46B0, ## __VA_ARGS__), \
> +	MACRO__(0x46B1, ## __VA_ARGS__), \
> +	MACRO__(0x46B2, ## __VA_ARGS__), \
> +	MACRO__(0x46B3, ## __VA_ARGS__), \
> +	MACRO__(0x46C0, ## __VA_ARGS__), \
> +	MACRO__(0x46C1, ## __VA_ARGS__), \
> +	MACRO__(0x46C2, ## __VA_ARGS__), \
> +	MACRO__(0x46C3, ## __VA_ARGS__)
>  
>  /* ADL-N */
> -#define INTEL_ADLN_IDS(info) \
> -	INTEL_VGA_DEVICE(0x46D0, info), \
> -	INTEL_VGA_DEVICE(0x46D1, info), \
> -	INTEL_VGA_DEVICE(0x46D2, info), \
> -	INTEL_VGA_DEVICE(0x46D3, info), \
> -	INTEL_VGA_DEVICE(0x46D4, info)
> +#define INTEL_ADLN_IDS(MACRO__, ...) \
> +	MACRO__(0x46D0, ## __VA_ARGS__), \
> +	MACRO__(0x46D1, ## __VA_ARGS__), \
> +	MACRO__(0x46D2, ## __VA_ARGS__), \
> +	MACRO__(0x46D3, ## __VA_ARGS__), \
> +	MACRO__(0x46D4, ## __VA_ARGS__)
>  
>  /* RPL-S */
> -#define INTEL_RPLS_IDS(info) \
> -	INTEL_VGA_DEVICE(0xA780, info), \
> -	INTEL_VGA_DEVICE(0xA781, info), \
> -	INTEL_VGA_DEVICE(0xA782, info), \
> -	INTEL_VGA_DEVICE(0xA783, info), \
> -	INTEL_VGA_DEVICE(0xA788, info), \
> -	INTEL_VGA_DEVICE(0xA789, info), \
> -	INTEL_VGA_DEVICE(0xA78A, info), \
> -	INTEL_VGA_DEVICE(0xA78B, info)
> +#define INTEL_RPLS_IDS(MACRO__, ...) \
> +	MACRO__(0xA780, ## __VA_ARGS__), \
> +	MACRO__(0xA781, ## __VA_ARGS__), \
> +	MACRO__(0xA782, ## __VA_ARGS__), \
> +	MACRO__(0xA783, ## __VA_ARGS__), \
> +	MACRO__(0xA788, ## __VA_ARGS__), \
> +	MACRO__(0xA789, ## __VA_ARGS__), \
> +	MACRO__(0xA78A, ## __VA_ARGS__), \
> +	MACRO__(0xA78B, ## __VA_ARGS__)
>  
>  /* RPL-U */
> -#define INTEL_RPLU_IDS(info) \
> -	INTEL_VGA_DEVICE(0xA721, info), \
> -	INTEL_VGA_DEVICE(0xA7A1, info), \
> -	INTEL_VGA_DEVICE(0xA7A9, info), \
> -	INTEL_VGA_DEVICE(0xA7AC, info), \
> -	INTEL_VGA_DEVICE(0xA7AD, info)
> +#define INTEL_RPLU_IDS(MACRO__, ...) \
> +	MACRO__(0xA721, ## __VA_ARGS__), \
> +	MACRO__(0xA7A1, ## __VA_ARGS__), \
> +	MACRO__(0xA7A9, ## __VA_ARGS__), \
> +	MACRO__(0xA7AC, ## __VA_ARGS__), \
> +	MACRO__(0xA7AD, ## __VA_ARGS__)
>  
>  /* RPL-P */
> -#define INTEL_RPLP_IDS(info) \
> -	INTEL_VGA_DEVICE(0xA720, info), \
> -	INTEL_VGA_DEVICE(0xA7A0, info), \
> -	INTEL_VGA_DEVICE(0xA7A8, info), \
> -	INTEL_VGA_DEVICE(0xA7AA, info), \
> -	INTEL_VGA_DEVICE(0xA7AB, info)
> +#define INTEL_RPLP_IDS(MACRO__, ...) \
> +	MACRO__(0xA720, ## __VA_ARGS__), \
> +	MACRO__(0xA7A0, ## __VA_ARGS__), \
> +	MACRO__(0xA7A8, ## __VA_ARGS__), \
> +	MACRO__(0xA7AA, ## __VA_ARGS__), \
> +	MACRO__(0xA7AB, ## __VA_ARGS__)
>  
>  /* DG2 */
> -#define INTEL_DG2_G10_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5690, info), \
> -	INTEL_VGA_DEVICE(0x5691, info), \
> -	INTEL_VGA_DEVICE(0x5692, info), \
> -	INTEL_VGA_DEVICE(0x56A0, info), \
> -	INTEL_VGA_DEVICE(0x56A1, info), \
> -	INTEL_VGA_DEVICE(0x56A2, info), \
> -	INTEL_VGA_DEVICE(0x56BE, info), \
> -	INTEL_VGA_DEVICE(0x56BF, info)
> -
> -#define INTEL_DG2_G11_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5693, info), \
> -	INTEL_VGA_DEVICE(0x5694, info), \
> -	INTEL_VGA_DEVICE(0x5695, info), \
> -	INTEL_VGA_DEVICE(0x56A5, info), \
> -	INTEL_VGA_DEVICE(0x56A6, info), \
> -	INTEL_VGA_DEVICE(0x56B0, info), \
> -	INTEL_VGA_DEVICE(0x56B1, info), \
> -	INTEL_VGA_DEVICE(0x56BA, info), \
> -	INTEL_VGA_DEVICE(0x56BB, info), \
> -	INTEL_VGA_DEVICE(0x56BC, info), \
> -	INTEL_VGA_DEVICE(0x56BD, info)
> -
> -#define INTEL_DG2_G12_IDS(info) \
> -	INTEL_VGA_DEVICE(0x5696, info), \
> -	INTEL_VGA_DEVICE(0x5697, info), \
> -	INTEL_VGA_DEVICE(0x56A3, info), \
> -	INTEL_VGA_DEVICE(0x56A4, info), \
> -	INTEL_VGA_DEVICE(0x56B2, info), \
> -	INTEL_VGA_DEVICE(0x56B3, info)
> -
> -#define INTEL_DG2_IDS(info) \
> -	INTEL_DG2_G10_IDS(info), \
> -	INTEL_DG2_G11_IDS(info), \
> -	INTEL_DG2_G12_IDS(info)
> -
> -#define INTEL_ATS_M150_IDS(info) \
> -	INTEL_VGA_DEVICE(0x56C0, info), \
> -	INTEL_VGA_DEVICE(0x56C2, info)
> -
> -#define INTEL_ATS_M75_IDS(info) \
> -	INTEL_VGA_DEVICE(0x56C1, info)
> -
> -#define INTEL_ATS_M_IDS(info) \
> -	INTEL_ATS_M150_IDS(info), \
> -	INTEL_ATS_M75_IDS(info)
> +#define INTEL_DG2_G10_IDS(MACRO__, ...) \
> +	MACRO__(0x5690, ## __VA_ARGS__), \
> +	MACRO__(0x5691, ## __VA_ARGS__), \
> +	MACRO__(0x5692, ## __VA_ARGS__), \
> +	MACRO__(0x56A0, ## __VA_ARGS__), \
> +	MACRO__(0x56A1, ## __VA_ARGS__), \
> +	MACRO__(0x56A2, ## __VA_ARGS__), \
> +	MACRO__(0x56BE, ## __VA_ARGS__), \
> +	MACRO__(0x56BF, ## __VA_ARGS__)
> +
> +#define INTEL_DG2_G11_IDS(MACRO__, ...) \
> +	MACRO__(0x5693, ## __VA_ARGS__), \
> +	MACRO__(0x5694, ## __VA_ARGS__), \
> +	MACRO__(0x5695, ## __VA_ARGS__), \
> +	MACRO__(0x56A5, ## __VA_ARGS__), \
> +	MACRO__(0x56A6, ## __VA_ARGS__), \
> +	MACRO__(0x56B0, ## __VA_ARGS__), \
> +	MACRO__(0x56B1, ## __VA_ARGS__), \
> +	MACRO__(0x56BA, ## __VA_ARGS__), \
> +	MACRO__(0x56BB, ## __VA_ARGS__), \
> +	MACRO__(0x56BC, ## __VA_ARGS__), \
> +	MACRO__(0x56BD, ## __VA_ARGS__)
> +
> +#define INTEL_DG2_G12_IDS(MACRO__, ...) \
> +	MACRO__(0x5696, ## __VA_ARGS__), \
> +	MACRO__(0x5697, ## __VA_ARGS__), \
> +	MACRO__(0x56A3, ## __VA_ARGS__), \
> +	MACRO__(0x56A4, ## __VA_ARGS__), \
> +	MACRO__(0x56B2, ## __VA_ARGS__), \
> +	MACRO__(0x56B3, ## __VA_ARGS__)
> +
> +#define INTEL_DG2_IDS(MACRO__, ...) \
> +	INTEL_DG2_G10_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_DG2_G11_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_DG2_G12_IDS(MACRO__, ## __VA_ARGS__)
> +
> +#define INTEL_ATS_M150_IDS(MACRO__, ...) \
> +	MACRO__(0x56C0, ## __VA_ARGS__), \
> +	MACRO__(0x56C2, ## __VA_ARGS__)
> +
> +#define INTEL_ATS_M75_IDS(MACRO__, ...) \
> +	MACRO__(0x56C1, ## __VA_ARGS__)
> +
> +#define INTEL_ATS_M_IDS(MACRO__, ...) \
> +	INTEL_ATS_M150_IDS(MACRO__, ## __VA_ARGS__), \
> +	INTEL_ATS_M75_IDS(MACRO__, ## __VA_ARGS__)
>  
>  /* MTL */
> -#define INTEL_MTL_IDS(info) \
> -	INTEL_VGA_DEVICE(0x7D40, info), \
> -	INTEL_VGA_DEVICE(0x7D41, info), \
> -	INTEL_VGA_DEVICE(0x7D45, info), \
> -	INTEL_VGA_DEVICE(0x7D51, info), \
> -	INTEL_VGA_DEVICE(0x7D55, info), \
> -	INTEL_VGA_DEVICE(0x7D60, info), \
> -	INTEL_VGA_DEVICE(0x7D67, info), \
> -	INTEL_VGA_DEVICE(0x7DD1, info), \
> -	INTEL_VGA_DEVICE(0x7DD5, info)
> +#define INTEL_MTL_IDS(MACRO__, ...) \
> +	MACRO__(0x7D40, ## __VA_ARGS__), \
> +	MACRO__(0x7D41, ## __VA_ARGS__), \
> +	MACRO__(0x7D45, ## __VA_ARGS__), \
> +	MACRO__(0x7D51, ## __VA_ARGS__), \
> +	MACRO__(0x7D55, ## __VA_ARGS__), \
> +	MACRO__(0x7D60, ## __VA_ARGS__), \
> +	MACRO__(0x7D67, ## __VA_ARGS__), \
> +	MACRO__(0x7DD1, ## __VA_ARGS__), \
> +	MACRO__(0x7DD5, ## __VA_ARGS__)
>  
>  #endif /* _I915_PCIIDS_H */

-- 
Jani Nikula, Intel


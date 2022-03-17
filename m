Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B7E4DCCE4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 18:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiCQRvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiCQRvi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 13:51:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E31F6356
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647539421; x=1679075421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=y0gbt+gWtYyS4i13ONHal6pzWNEopf5NIGAIsSvrzDg=;
  b=hDjklJ0Qlacrqq73T9a/CbNj8rkWoH36R7B4xe9hw40SO2ky5MF09zJd
   HP+fkm8gpra1STDvTM369ya45nw1l9mBbn6ZSrdvQQn/HOc3u2ljZ+XZH
   eaQ9G0Z7pWOa8uzJ2rOzT9X6kbjy5z/hgWIgp6KyRsCQNpZEm4vH8SvDO
   Orc0p245JZQ3e9PfPpc/Mp+XjIAgceInLz+vAcW5MIpSCjaET1Ft8Ubl2
   6ydyk5IWIodClioyVSQivkHRT4kUoQUOJaIDgzrWMptTZjOKwMVYqAHGA
   O/24OIX2NZcc6973twXIZabw3bth7Em1eFOq9z5VRbNRt+J2UwJxR7ntc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237551359"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237551359"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="513513093"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
  by orsmga002.jf.intel.com with SMTP; 17 Mar 2022 10:50:17 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 17 Mar 2022 19:50:17 +0200
Date:   Thu, 17 Mar 2022 19:50:17 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915: include uapi/drm/i915_drm.h
 directly where needed
Message-ID: <YjN02ff81NR8EPFI@intel.com>
References: <20220311100639.114685-1-jani.nikula@intel.com>
 <20220311100639.114685-2-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311100639.114685-2-jani.nikula@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 11, 2022 at 12:06:39PM +0200, Jani Nikula wrote:
> Remove the uapi/drm/i915_drm.h include from drm/i915_drm.h, and stop
> being a proxy for uapi/drm/i915_drm.h. Include uapi/drm/i915_drm.h and
> drm/i915_drm.h only where needed.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Looks sensible to me. Series is 
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_lmem.c     | 2 ++
>  drivers/gpu/drm/i915/gem/i915_gem_region.c   | 2 ++
>  drivers/gpu/drm/i915/intel_memory_region.c   | 2 ++
>  drivers/gpu/drm/i915/intel_memory_region.h   | 2 +-
>  drivers/gpu/drm/i915/pxp/intel_pxp_session.c | 2 --
>  include/drm/i915_drm.h                       | 2 +-
>  6 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_lmem.c b/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
> index 444f8268b9c5..ede084f36ca9 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
> @@ -3,6 +3,8 @@
>   * Copyright © 2019 Intel Corporation
>   */
>  
> +#include <uapi/drm/i915_drm.h>
> +
>  #include "intel_memory_region.h"
>  #include "gem/i915_gem_region.h"
>  #include "gem/i915_gem_lmem.h"
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c b/drivers/gpu/drm/i915/gem/i915_gem_region.c
> index c9b2e8b91053..f4fbae2f9dcc 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
> @@ -3,6 +3,8 @@
>   * Copyright © 2019 Intel Corporation
>   */
>  
> +#include <uapi/drm/i915_drm.h>
> +
>  #include "intel_memory_region.h"
>  #include "i915_gem_region.h"
>  #include "i915_drv.h"
> diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
> index 1c841f68169a..ded78b83e0b5 100644
> --- a/drivers/gpu/drm/i915/intel_memory_region.c
> +++ b/drivers/gpu/drm/i915/intel_memory_region.c
> @@ -5,6 +5,8 @@
>  
>  #include <linux/prandom.h>
>  
> +#include <uapi/drm/i915_drm.h>
> +
>  #include "intel_memory_region.h"
>  #include "i915_drv.h"
>  #include "i915_ttm_buddy_manager.h"
> diff --git a/drivers/gpu/drm/i915/intel_memory_region.h b/drivers/gpu/drm/i915/intel_memory_region.h
> index 21dcbd620758..bbc35ec5c090 100644
> --- a/drivers/gpu/drm/i915/intel_memory_region.h
> +++ b/drivers/gpu/drm/i915/intel_memory_region.h
> @@ -10,7 +10,7 @@
>  #include <linux/mutex.h>
>  #include <linux/io-mapping.h>
>  #include <drm/drm_mm.h>
> -#include <drm/i915_drm.h>
> +#include <uapi/drm/i915_drm.h>
>  
>  struct drm_i915_private;
>  struct drm_i915_gem_object;
> diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
> index 598840b73dfa..92b00b4de240 100644
> --- a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
> +++ b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
> @@ -3,8 +3,6 @@
>   * Copyright(c) 2020, Intel Corporation. All rights reserved.
>   */
>  
> -#include <drm/i915_drm.h>
> -
>  #include "i915_drv.h"
>  
>  #include "intel_pxp.h"
> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
> index afbf3ef5643e..7adce327c1c2 100644
> --- a/include/drm/i915_drm.h
> +++ b/include/drm/i915_drm.h
> @@ -26,7 +26,7 @@
>  #ifndef _I915_DRM_H_
>  #define _I915_DRM_H_
>  
> -#include <uapi/drm/i915_drm.h>
> +#include <linux/types.h>
>  
>  /* For use by IPS driver */
>  unsigned long i915_read_mch_val(void);
> -- 
> 2.30.2

-- 
Ville Syrjälä
Intel

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4270F74F066
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGKNjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGKNjX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:39:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AC2E69;
        Tue, 11 Jul 2023 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689082762; x=1720618762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SvVZcp0S2hY+uXhZp9wo8Qq7oQErKF5vDvaioaBE7KI=;
  b=h9rjvoMqA8gWySZ7uPpK/IuOuUYHeFCvVlCUmEfMIWTpyxVuVuiROQ8G
   WFT8Lzv9jafRGpURb5wjsDKKVH5L3n1dm86lREegykbejDNudzHRlWBtV
   PiDGPjX4KQ50XRLb6Us9DMwvrp+6dUSlKtyQzmFw8qRlcSr3O33RhiQo/
   o4iSe4slpW7RhZre2TDmE+1CojKLwnNL7J+Aeqv3PzNF2KbivNgLPEl0q
   0R7AxyBWNePhHeB1aHXFo600qIL10NZ/mKh2IVqOzm0wE/7F/ztgpPORf
   7oNtqjotUefnf2z/0w0KWdyWWC/4uVfpQ/5x0dK3rJmm4Slb3th9OCCfW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367197978"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367197978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="865735211"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="865735211"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 06:39:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDa4-001rWK-1b;
        Tue, 11 Jul 2023 16:39:04 +0300
Date:   Tue, 11 Jul 2023 16:39:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 05/13] ALSA: hda/i915:  Use global PCI match macro
Message-ID: <ZK1beJ3eI3wIxeJx@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-6-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-6-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:18PM +0200, Amadeusz Sławiński wrote:
> Instead of using local macro to match PCI device, use global one.

FWIW,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/hda/hdac_i915.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 161a9711cd63..2a451ff4fe6a 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -11,11 +11,6 @@
>  #include <sound/hda_i915.h>
>  #include <sound/hda_register.h>
>  
> -#define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
> -				((pci)->device == 0x0c0c) || \
> -				((pci)->device == 0x0d0c) || \
> -				((pci)->device == 0x160c))
> -
>  /**
>   * snd_hdac_i915_set_bclk - Reprogram BCLK for HSW/BDW
>   * @bus: HDA core bus
> @@ -39,7 +34,7 @@ void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
>  
>  	if (!acomp || !acomp->ops || !acomp->ops->get_cdclk_freq)
>  		return; /* only for i915 binding */
> -	if (!IS_HSW_CONTROLLER(pci))
> +	if (!HDA_CONTROLLER_IS_HSW(pci))
>  		return; /* only HSW/BDW */
>  
>  	cdclk_freq = acomp->ops->get_cdclk_freq(acomp->dev);
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



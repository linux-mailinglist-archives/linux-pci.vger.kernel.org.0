Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB974F04A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGKNhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKNhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:37:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B97BC;
        Tue, 11 Jul 2023 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689082669; x=1720618669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sDKsooMzYAP81kDUoSO2n2MLd1qZqSlgq3mclaJSUS4=;
  b=Mfaw/GvEg4n67sXM3DfPJnE+wH6b67f8iIbX/YdPEKdvIh6aI1qwKKjs
   7+P8GkUhdP7TMRfsY9ueiFdbIfIQUOjofteHfj4Dj/NqTB7pxBQq1jp9e
   f0y8HK1oHtVSQIBNWcMZZr65dodHmTpUAARYBwQxipiU3Xdr62ASCrP1t
   O6+ldiwkZQkdR2/LP03hK2upAE/Zvl1LjlRjVVRWAoL3/ngQ/bEoA1zuh
   zZBh+Y2unhW+YCWcw+z1R0zNJEbHR2YyvKCaAGxm7prb8EfMqH0ESZrZp
   9tu1KEVbLo7mHSyCBfG3l7wWelORIfWAIU4qH0bbTqY4WOjL9pLmnSetp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="428315944"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="428315944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="721091183"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="721091183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2023 06:37:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDYi-001rVJ-1K;
        Tue, 11 Jul 2023 16:37:40 +0300
Date:   Tue, 11 Jul 2023 16:37:40 +0300
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
Subject: Re: [PATCH 04/13] ALSA: hda: Use global PCI match macro
Message-ID: <ZK1bJJpZLv75acvc@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-5-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-5-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:17PM +0200, Amadeusz Sławiński wrote:
> Instead of using local macro to match PCI device, use global one.

I believe from the previous discussion that this one needs a couple of words
w.r.t. BXT --> APL change.

Otherwise, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/pci/hda/hda_intel.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index ef831770ca7d..143efa54b9bf 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -330,18 +330,6 @@ enum {
>  #define needs_eld_notify_link(chip)	false
>  #endif
>  
> -#define CONTROLLER_IN_GPU(pci) (((pci)->vendor == 0x8086) &&         \
> -				       (((pci)->device == 0x0a0c) || \
> -					((pci)->device == 0x0c0c) || \
> -					((pci)->device == 0x0d0c) || \
> -					((pci)->device == 0x160c) || \
> -					((pci)->device == 0x490d) || \
> -					((pci)->device == 0x4f90) || \
> -					((pci)->device == 0x4f91) || \
> -					((pci)->device == 0x4f92)))
> -
> -#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
> -
>  static const char * const driver_short_names[] = {
>  	[AZX_DRIVER_ICH] = "HDA Intel",
>  	[AZX_DRIVER_PCH] = "HDA Intel PCH",
> @@ -573,7 +561,7 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
>  	snd_hdac_set_codec_wakeup(bus, false);
>  
>  	/* reduce dma latency to avoid noise */
> -	if (IS_BXT(pci))
> +	if (HDA_CONTROLLER_IS_APL(pci))
>  		bxt_reduce_dma_latency(chip);
>  
>  	if (bus->mlcap != NULL)
> @@ -2175,7 +2163,7 @@ static int azx_probe(struct pci_dev *pci,
>  #endif /* CONFIG_SND_HDA_PATCH_LOADER */
>  
>  #ifndef CONFIG_SND_HDA_I915
> -	if (CONTROLLER_IN_GPU(pci))
> +	if (HDA_CONTROLLER_IN_GPU(pci))
>  		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
>  #endif
>  
> @@ -2283,7 +2271,7 @@ static int azx_probe_continue(struct azx *chip)
>  			 * for other chips, still continue probing as other
>  			 * codecs can be on the same link.
>  			 */
> -			if (CONTROLLER_IN_GPU(pci)) {
> +			if (HDA_CONTROLLER_IN_GPU(pci)) {
>  				dev_err(chip->card->dev,
>  					"HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
>  				goto out_free;
> @@ -2294,7 +2282,7 @@ static int azx_probe_continue(struct azx *chip)
>  		}
>  
>  		/* HSW/BDW controllers need this power */
> -		if (CONTROLLER_IN_GPU(pci))
> +		if (HDA_CONTROLLER_IN_GPU(pci))
>  			hda->need_i915_power = true;
>  	}
>  
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



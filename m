Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312274F074
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGKNlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGKNle (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:41:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631610CA;
        Tue, 11 Jul 2023 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689082893; x=1720618893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dxME0Zys7vT/pFBpwkj80hNNsU8yTqns5rOzcHDTwMQ=;
  b=OThB08fj836LPaWfOdOdm02AXHQoCgJSq+p34QAZ5NWwlHlrC3gwojcb
   Yptkd3s4Vz+6snTwFszpZ+7JSx0BQY9PKKvtej3ENFw//2v5b6Vo6pae9
   zgIep2BlJC9dqwylW6zIONPf1DFlCtJIEwgOmm89uiiO21ObeNk9WAwGu
   c4VeIUNwXVzVSzW5RYTub6t8m7UZhSskt/m69PjM2X7MzJ9UCRzE7+YJ9
   kHBIrZF4Wo9xLUqAW/BKKDH5sZmhsrOEiAg3q5xi/Vx4Fsq+0F7bU3aeI
   loRkjRc98RKzJtt6j7FvLuU9a1pefeaECyr4o1aBGW6KE/b6vnyqb1whn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367198502"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367198502"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="865735985"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="865735985"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 06:41:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDcL-001rY7-2H;
        Tue, 11 Jul 2023 16:41:25 +0300
Date:   Tue, 11 Jul 2023 16:41:25 +0300
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
Subject: Re: [PATCH 06/13] ASoC: Intel: Skylake: Use global PCI match macro
Message-ID: <ZK1cBWO4KWFDJMcA@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-7-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-7-amadeuszx.slawinski@linux.intel.com>
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

On Tue, Jul 11, 2023 at 02:57:19PM +0200, Amadeusz Sławiński wrote:
> Instead of using local macro to match PCI device, use global one.

Same comment as per another patch, i.e. explain CFL/BXT --> APL (*).
With that,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

*) I think it's something like "the BXT/APL/CFL line of SoCs has the same
(compatible?) HDA IP blablabla".

> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  include/sound/hda_codec.h         | 3 ---
>  sound/soc/intel/skylake/skl-pcm.c | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
> index bbb7805e85d8..5497dc9c396a 100644
> --- a/include/sound/hda_codec.h
> +++ b/include/sound/hda_codec.h
> @@ -18,9 +18,6 @@
>  #include <sound/hda_verbs.h>
>  #include <sound/hda_regmap.h>
>  
> -#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
> -#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
> -
>  /*
>   * Structures
>   */
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index a4209d88b0c6..ac3dc8c63c26 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -13,6 +13,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
> +#include <sound/hdaudio.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include "skl.h"
> @@ -152,7 +153,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
>  	 * The recommended SDxFMT programming sequence for BXT
>  	 * platforms is to couple the stream before writing the format
>  	 */
> -	if (IS_BXT(skl->pci)) {
> +	if (HDA_CONTROLLER_IS_APL(skl->pci)) {
>  		snd_hdac_ext_stream_decouple(bus, stream, false);
>  		err = snd_hdac_stream_setup(hdac_stream(stream));
>  		snd_hdac_ext_stream_decouple(bus, stream, true);
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



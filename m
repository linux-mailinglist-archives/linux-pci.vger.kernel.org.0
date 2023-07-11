Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700774F145
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjGKOKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjGKOKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:10:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C310CB;
        Tue, 11 Jul 2023 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689084644; x=1720620644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xj/NaD7rJVegzRnQWSku6xyrxDMtYG0ROyHoK88TJTI=;
  b=MAvRm020VBKswQ1HZY9Sx4bkLp125D28dzLrlWocW9iDy1wEXz7qs8u3
   Se1OepW1ZI5p/B/tdVmk1bX/caEZqOIO6bzuuy3Ta7m6Zkr+JX0GdgKKg
   4cLrLC+kduoGrHhe/MIXNdOOjjyMzMj2wkoe2wrsJzF6E+NOgkbOLqNWv
   Frv1AR0yDoEHciOhG4eUzws3tK8LTwfW+HsE50CL6yqINx4YfcP9D4OO9
   d5QeotvSD5oIVbFi7UaF8fBOX6ynuvC5HHqLttn4QkJCNZWwpkM+1vMUQ
   kbkpqqw9wyATWDO7aTnmWx3vDjvjcn376D1RSpJSqCswmknb2xhnk6nLJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="364664850"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="364664850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="791219489"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="791219489"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2023 07:10:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJE4c-001ryG-3C;
        Tue, 11 Jul 2023 17:10:38 +0300
Date:   Tue, 11 Jul 2023 17:10:38 +0300
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
Subject: Re: [PATCH 11/13] ASoC: Intel: Skylake: Convert to PCI device IDs
 defines
Message-ID: <ZK1i3pvgtuka8nJW@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-12-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-12-amadeuszx.slawinski@linux.intel.com>
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

On Tue, Jul 11, 2023 at 02:57:24PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_DEVICE_DATA() macro, to simplify declarations.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

BXT --> APL ?

> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/intel/skylake/skl-messages.c | 16 ++++++------
>  sound/soc/intel/skylake/skl.c          | 36 +++++++-------------------
>  2 files changed, 18 insertions(+), 34 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
> index d31509298a0a..fc2eb04da172 100644
> --- a/sound/soc/intel/skylake/skl-messages.c
> +++ b/sound/soc/intel/skylake/skl-messages.c
> @@ -169,7 +169,7 @@ static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
>  
>  static const struct skl_dsp_ops dsp_ops[] = {
>  	{
> -		.id = 0x9d70,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
>  		.num_cores = 2,
>  		.loader_ops = skl_get_loader_ops,
>  		.init = skl_sst_dsp_init,
> @@ -177,7 +177,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = skl_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0x9d71,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
>  		.num_cores = 2,
>  		.loader_ops = skl_get_loader_ops,
>  		.init = skl_sst_dsp_init,
> @@ -185,7 +185,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = skl_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0x5a98,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_APL,
>  		.num_cores = 2,
>  		.loader_ops = bxt_get_loader_ops,
>  		.init = bxt_sst_dsp_init,
> @@ -193,7 +193,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = bxt_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0x3198,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_GML,
>  		.num_cores = 2,
>  		.loader_ops = bxt_get_loader_ops,
>  		.init = bxt_sst_dsp_init,
> @@ -201,7 +201,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = bxt_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0x9dc8,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_CNL_LP,
>  		.num_cores = 4,
>  		.loader_ops = bxt_get_loader_ops,
>  		.init = cnl_sst_dsp_init,
> @@ -209,7 +209,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = cnl_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0xa348,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_CNL_H,
>  		.num_cores = 4,
>  		.loader_ops = bxt_get_loader_ops,
>  		.init = cnl_sst_dsp_init,
> @@ -217,7 +217,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = cnl_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0x02c8,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
>  		.num_cores = 4,
>  		.loader_ops = bxt_get_loader_ops,
>  		.init = cnl_sst_dsp_init,
> @@ -225,7 +225,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.cleanup = cnl_sst_dsp_cleanup
>  	},
>  	{
> -		.id = 0x06c8,
> +		.id = PCI_DEVICE_ID_INTEL_HDA_CML_H,
>  		.num_cores = 4,
>  		.loader_ops = bxt_get_loader_ops,
>  		.init = cnl_sst_dsp_init,
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 998bd0232cf1..77408a981b97 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -608,8 +608,8 @@ struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id)
>  static void init_skl_xtal_rate(int pci_id)
>  {
>  	switch (pci_id) {
> -	case 0x9d70:
> -	case 0x9d71:
> +	case PCI_DEVICE_ID_INTEL_HDA_SKL_LP:
> +	case PCI_DEVICE_ID_INTEL_HDA_KBL_LP:
>  		skl_clk_src[0].rate = 24000000;
>  		return;
>  
> @@ -1145,44 +1145,28 @@ static void skl_remove(struct pci_dev *pci)
>  /* PCI IDs */
>  static const struct pci_device_id skl_ids[] = {
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
> -	/* Sunrise Point-LP */
> -	{ PCI_DEVICE(0x8086, 0x9d70),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP, &snd_soc_acpi_intel_skl_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
> -	/* BXT-P */
> -	{ PCI_DEVICE(0x8086, 0x5a98),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &snd_soc_acpi_intel_bxt_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
> -	/* KBL */
> -	{ PCI_DEVICE(0x8086, 0x9D71),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_LP, &snd_soc_acpi_intel_kbl_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_GLK)
> -	/* GLK */
> -	{ PCI_DEVICE(0x8086, 0x3198),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &snd_soc_acpi_intel_glk_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CNL)
> -	/* CNL */
> -	{ PCI_DEVICE(0x8086, 0x9dc8),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_LP, &snd_soc_acpi_intel_cnl_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CFL)
> -	/* CFL */
> -	{ PCI_DEVICE(0x8086, 0xa348),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_H, &snd_soc_acpi_intel_cnl_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_LP)
> -	/* CML-LP */
> -	{ PCI_DEVICE(0x8086, 0x02c8),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_LP, &snd_soc_acpi_intel_cnl_machines) },
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_H)
> -	/* CML-H */
> -	{ PCI_DEVICE(0x8086, 0x06c8),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_H, &snd_soc_acpi_intel_cnl_machines) },
>  #endif
>  	{ 0, }
>  };
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



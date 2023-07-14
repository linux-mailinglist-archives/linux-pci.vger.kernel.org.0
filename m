Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD7753AFF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjGNMaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjGNMaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:30:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9C3C20;
        Fri, 14 Jul 2023 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337778; x=1720873778;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=paNCn0i0ocmnyoUcYofPrK6VJYyVDAF9BUUDGQr8dR0=;
  b=fB+bX9BCf2hjN44fGIOxz+dmN9pnLcu2JEC5cCf9/lcXP4Ht7V4sy0ST
   eDc/oHbuhPA/noOk0qEMj0n0+G47NAsTmVXC2o9jH2owUwZMo0LBSEgXi
   slK20vSAb4yS36DkVoaJE8W+Eogg9OJHUs5EED6Pw7RRnVkuUyGL74oBO
   C1thX1Wo4ImeeppsEdM+YizULrvgRzQiHAgQ8vve9mzhzWBbNlazWdzQt
   FODhPD+rPSjlbH7PxSlER65DgnkErReRus8gbXFaSkyHbRWPV7rlIhf49
   eqwUBSPzBFe0U/UOmdjejjyIFF287nj8RcG5kAy+uEJaBbfKwNy6yqopl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368101721"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="368101721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812415922"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="812415922"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:29:12 -0700
Date:   Fri, 14 Jul 2023 15:29:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-2?Q?Amadeusz_S=B3awi=F1ski?= 
        <amadeuszx.slawinski@linux.intel.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 07/15] ALSA: hda/i915:  Use global PCI match macro
In-Reply-To: <20230714202457.423866-8-amadeuszx.slawinski@linux.intel.com>
Message-ID: <9d3c56af-e9ff-7791-1644-2d362e428f48@linux.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com> <20230714202457.423866-8-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1404882682-1689337755=:1695"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1404882682-1689337755=:1695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

Just a small nit, you have an extra space in the shortlog line.

-- 
 i.

On Fri, 14 Jul 2023, Amadeusz Sławiński wrote:

> Instead of using local macro to match PCI device, use global one.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
> 
--8323329-1404882682-1689337755=:1695--

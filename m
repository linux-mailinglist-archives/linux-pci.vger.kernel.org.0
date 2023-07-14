Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00579753964
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjGNLSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjGNLSs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:18:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10E2D63;
        Fri, 14 Jul 2023 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333527; x=1720869527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0ubeB2ewfY7fKKoRvOlcQcyx4Sk1yqmWwpc7WYBL0gY=;
  b=kNsrz2WmShvTbTXhCnqHjynheLZFHxdLvFF0z9CL9qBQEn9jFODDBPSL
   dkQtKYcBFaD85j4oKRqwTAat1/5Mwr2GknL9NFw2jnmyAxqLBetn36+2e
   6P8XQ7ZyD63E++Jtcdf0TGa3xyxpcRQ7Sm9WTzz4BMxQ5XqHWIpTVXgK/
   W3j5XD7WpLa0IebQbay7vjnEDSzSvmpcfP9MmM56LvaLZKjQJt8LM7fmW
   fHayYZCfXn+sl7WtRktJnvX6op8flM6hk9z8Ncbm4Gx9cw4xUaTGJG389
   xdmsvmVAYTxV+CTKv4j1inNjSQQJAdZuPy76FwfPk5HEwL2B+Uv/QWbmM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396261229"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="396261229"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835997944"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="835997944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jul 2023 04:18:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKGoe-002dwB-1k;
        Fri, 14 Jul 2023 14:18:28 +0300
Date:   Fri, 14 Jul 2023 14:18:28 +0300
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
Subject: Re: [PATCH v2 04/15] ALSA: Remove unused Broxton PCI ID
Message-ID: <ZLEvBIFM9p/1u9Pv@smile.fi.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-5-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714185615.370597-5-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 08:56:04PM +0200, Amadeusz Sławiński wrote:
> Current code references 0x1a98 which is BXT-M (not -T as it is
> commented) and it's an RVP, BXT-M B0 to be specific. From what we know
> no BXT is available on market.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/pci/hda/hda_intel.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index ef831770ca7d..8f0cebb83302 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2564,9 +2564,6 @@ static const struct pci_device_id azx_ids[] = {
>  	/* Broxton-P(Apollolake) */
>  	{ PCI_DEVICE(0x8086, 0x5a98),
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
> -	/* Broxton-T */
> -	{ PCI_DEVICE(0x8086, 0x1a98),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>  	/* Gemini-Lake */
>  	{ PCI_DEVICE(0x8086, 0x3198),
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



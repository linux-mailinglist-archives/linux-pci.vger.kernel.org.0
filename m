Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5863974F0FD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjGKOCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGKOCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:02:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E229E;
        Tue, 11 Jul 2023 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689084151; x=1720620151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=akEEbdgIackI+bwcJjUC7oCu6EgQWkViNrk7VaPnBp4=;
  b=D7hfNuCdcNwDfVazU4Z8zAtFPMYB7BVwbhx8HFaBhmFqmdGYGhcBE3pL
   wrerP9R36yVq9EAhsYWA/hSLeJFJ+rXhGZOlA59aMHVANHSdCeLTwqNmc
   wWp7spD9rq4TvWrCPwF9Qpdubeva5Vv4UWuYp1ATqtDSPyuklBGrLbYB8
   /o9/+J171OIJzD/f8lxz3sFeG9J7LI+VFJl6m24NeaJCRI8V+y+2GAwEV
   xBLQTt5tJ39e9AK4WKhP8P8z+sh7athpuK3mmYBQHsodoHnjaAVeSQUuJ
   yNa3r/st/WCVfe1B58F2HF7qWOn5YLVx5Ad2xOqshP/JjLFizxwPPRjRb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344223042"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="344223042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="671381929"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="671381929"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2023 07:02:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDwf-001rsM-2M;
        Tue, 11 Jul 2023 17:02:25 +0300
Date:   Tue, 11 Jul 2023 17:02:25 +0300
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
Subject: Re: [PATCH 09/13] ASoC: Intel: avs: Convert to PCI device IDs defines
Message-ID: <ZK1g8VgO8PHwbWy4@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-10-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-10-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:22PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_DEVICE_DATA() macro, to simplify declarations.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/intel/avs/core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index 637501850728..859b217fc761 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -745,14 +745,14 @@ static const struct avs_spec apl_desc = {
>  };
>  
>  static const struct pci_device_id avs_ids[] = {
> -	{ PCI_VDEVICE(INTEL, 0x9d70), (unsigned long)&skl_desc }, /* SKL */
> -	{ PCI_VDEVICE(INTEL, 0xa170), (unsigned long)&skl_desc }, /* SKL-H */
> -	{ PCI_VDEVICE(INTEL, 0x9d71), (unsigned long)&skl_desc }, /* KBL */
> -	{ PCI_VDEVICE(INTEL, 0xa171), (unsigned long)&skl_desc }, /* KBL-H */
> -	{ PCI_VDEVICE(INTEL, 0xa2f0), (unsigned long)&skl_desc }, /* KBL-S */
> -	{ PCI_VDEVICE(INTEL, 0xa3f0), (unsigned long)&skl_desc }, /* CML-V */
> -	{ PCI_VDEVICE(INTEL, 0x5a98), (unsigned long)&apl_desc }, /* APL */
> -	{ PCI_VDEVICE(INTEL, 0x3198), (unsigned long)&apl_desc }, /* GML */
> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP, &skl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL, &skl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_LP, &skl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL, &skl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_H, &skl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_S, &skl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &apl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &apl_desc) },
>  	{ 0 }
>  };
>  MODULE_DEVICE_TABLE(pci, avs_ids);
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



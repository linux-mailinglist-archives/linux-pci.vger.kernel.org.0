Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0609D74F13C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjGKOJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGKOJV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:09:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDD10E7;
        Tue, 11 Jul 2023 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689084558; x=1720620558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OItnSNHuKeCQX1TJzcCcwRvIxNHYN/3rVnIlwqJU1DE=;
  b=atYmhBS1PSbnSc29MrvVF0GVEMbi3qTdkrqFJCFIPsYKpZOT6oh3hOB2
   0dlAmpXcMg7AQNpxbBcsCeuJo/03SHkQwDV5aXA8ZpLj0ZlzFOGxV59ZQ
   wGdbKJk7J9NkbfwXYxP1o5HmKFDeATTLQtuGA1fDocMxsRtX+G0KhI3ng
   TQ3p4MIUScOhrWLfkKkinbCbctoEj2bLXhSoGZj0WvD1COkWH5pLa9Xdm
   0lCOJ9Ja4r1KREr60BlHZ6hGV2U4HljfqtUI1VqPpQlGzFy66qASgn0d1
   jKmQOYGFtESjmX9RgLoYPOvAtCHIc0qeW2xZLHrdjgKwazDoUhzWDeaJm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="364664517"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="364664517"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="895185821"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="895185821"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Jul 2023 07:09:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJE3F-001rxJ-05;
        Tue, 11 Jul 2023 17:09:13 +0300
Date:   Tue, 11 Jul 2023 17:09:12 +0300
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
Subject: Re: [PATCH 10/13] ASoC: Intel: avs: Convert to PCI device IDs defines
Message-ID: <ZK1iiMgmjpCA02x+@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-11-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-11-amadeuszx.slawinski@linux.intel.com>
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

On Tue, Jul 11, 2023 at 02:57:23PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY() macro,
> so device ID can be provided in short form.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/intel/avs/board_selection.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
> index 60f8fb0bff95..b32e02940e30 100644
> --- a/sound/soc/intel/avs/board_selection.c
> +++ b/sound/soc/intel/avs/board_selection.c
> @@ -263,14 +263,14 @@ struct avs_acpi_boards {
>  };
>  
>  #define AVS_MACH_ENTRY(_id, _mach) \
> -	{ .id = (_id), .machs = (_mach), }
> +	{ .id = PCI_DEVICE_ID_INTEL_##_id, .machs = (_mach), }
>  
>  /* supported I2S boards per platform */
>  static const struct avs_acpi_boards i2s_boards[] = {
> -	AVS_MACH_ENTRY(0x9d70, avs_skl_i2s_machines), /* SKL */
> -	AVS_MACH_ENTRY(0x9d71, avs_kbl_i2s_machines), /* KBL */
> -	AVS_MACH_ENTRY(0x5a98, avs_apl_i2s_machines), /* APL */
> -	AVS_MACH_ENTRY(0x3198, avs_gml_i2s_machines), /* GML */
> +	AVS_MACH_ENTRY(HDA_SKL_LP, avs_skl_i2s_machines),
> +	AVS_MACH_ENTRY(HDA_KBL_LP, avs_kbl_i2s_machines),
> +	AVS_MACH_ENTRY(HDA_APL, avs_apl_i2s_machines),
> +	AVS_MACH_ENTRY(HDA_GML, avs_gml_i2s_machines),

Maybe sort them by name?

>  	{},
>  };
>  
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3095B741409
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjF1OrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:47:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:5218 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbjF1OrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963635; x=1719499635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rtGlV6TiHru15yGIIxQm3Jfi0dIBkNUCTwGVyxrpVgY=;
  b=eSsqxDALVTdoCaO7cUw5dwZidHDKiyV6zTkHAoJ4QZjqnHUgeYPzaTGM
   DpfWB4Z9q3ZJ7ekYXBr1K6pYrOqdJBJbD70OHGULCBLoBSCDz2CCnJa5y
   PCknjpGARwhnGP4Qca7p8F+cJdSyOLOWdcpylrdc8WiU4uJ3eOpVYaDkc
   T0rpI+nGiLnFRvd1IFtkT6NmFgUd6rwZ7Q2YzGYy6lnGTfs6yJfbAsThL
   T8HoSqCvaCdwgpbxsHFPSfYTDvOq+/DGgo38FF+l2/B1cGyysbwqCqgTK
   saRUNv4WU+2tPVM0B+iTCcJHa62vRVZzgdEn2dwsSXSJkhq2t7FUK08rC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="361906362"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361906362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="830148071"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="830148071"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2023 07:47:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWRq-000cs2-1A;
        Wed, 28 Jun 2023 17:47:10 +0300
Date:   Wed, 28 Jun 2023 17:47:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [RFC PATCH 3/8] ALSA: hda: Update PCI ID list
Message-ID: <ZJxH7lcU4tSzCjb1@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-4-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-4-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:30PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_VDEVICE macro, to simplify declarations. This allows to change magic
> number PCI vendor IDs to macro ones for all vendors. For Intel devices
> use device IDs macros where defined.

...

>  					((pci)->device == 0x490d) || \
>  					((pci)->device == 0x4f90) || \
>  					((pci)->device == 0x4f91) || \
>  					((pci)->device == 0x4f92)))

Why are not these be added in the header as well for the sake of consistency?

...

>  	/* CPT */
> -	{ PCI_DEVICE(0x8086, 0x1c20),
> +	{ PCI_VDEVICE(INTEL, 0x1c20),
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },

With the first patch seems all of these (x86) can be converted
to use PCI_DEVICE_DATA().

-- 
With Best Regards,
Andy Shevchenko



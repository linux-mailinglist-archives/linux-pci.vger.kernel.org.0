Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAC741406
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjF1Oox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:44:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:6230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbjF1Oow (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963492; x=1719499492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HSXxSC6s+LRdKk2lVMZTM3gnl3zRI7sk0WOuhp1qimg=;
  b=l6ZmksaVH0+tg3QNW1YMJr98PIxAakZnEQmNYlHkQmpkPZ71wU6g4xTz
   78uXHXAknrylQGEO/hinwetqbNmu0Ly/ClgMb/FiRVksniGg8dS0dv2+x
   QEMfz9MOpbwZBsW/PXsuj6dOLVJUpw84nM2oQbTQPYVyTVZ02psEr03sE
   tnPSE/D9m6UUNb/kRJ1NwmhbXgjdTyyijS085XGaIepvIy/CMMKGTtBit
   i2l1kemolsTBjdXCcbs1Tl023ESRw6sP7K0K6c/sv6CP5kykcuBa0Qmbp
   Ia8E23ZyToagJkMIZw2phoSdInGWdPf6FpZw2m3on3K1/rL4Xa8Ozjvl1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360717826"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="360717826"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="746674482"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="746674482"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2023 07:44:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWPE-000cpY-32;
        Wed, 28 Jun 2023 17:44:28 +0300
Date:   Wed, 28 Jun 2023 17:44:28 +0300
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
Subject: Re: [RFC PATCH 1/8] PCI: Add Intel Audio DSP devices to pci_ids.h
Message-ID: <ZJxHTHCq0T/y+dG0@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-2-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-2-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:28PM +0200, Amadeusz Sławiński wrote:
> Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
> Almost every use contains additional comments to identify to which
> platform those IDs refer to. Add those IDs to pci_ids.h header, so that
> there is one place which defines those names.

...

>  #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
>  #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
> +#define PCI_DEVICE_ID_INTEL_HDA_JSL_N	0x4dc8
> +#define PCI_DEVICE_ID_INTEL_HDA_TGL_H	0x43c8
> +#define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
> +#define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58

Can it be kept sorted by a value?

Didn't check the full list, though.

-- 
With Best Regards,
Andy Shevchenko



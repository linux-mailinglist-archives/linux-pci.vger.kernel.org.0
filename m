Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEAF74145B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1OzN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:55:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:10448 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232020AbjF1OzE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687964104; x=1719500104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=950ad4Q8R9S74I5gc8AWjL24I3KI0SJhn8K91bX+Hs4=;
  b=fslnnK/YsebyyyqDo8Uv4DwvFqo/cUU/EE0+NjFOUO0ncPdzgZa+JWEx
   KrkdyPrZB6DkYMLv2cQCkqJIQ9z3Bnmy+zN48EB70EEKEoKfoUkkCJSeu
   6GtKi3UPJJEyJ1ca1yeb5cRuImfBpBsuuwZdZrqHKZP2o1PfGRNxEXT7d
   TWdsha/Ssari7OXCUoLbtn4BJ/ZBjI71ivn/owSi5clXVI3ABV9OYTxRp
   vNSOcJOPzEMUnyw3saW3GzhcL6j9m3etwppRRAe6u/nKsCwawTT59xqVS
   neEHxnTYgBHh20fhaHAztPAWIP8SK4YjRQkK6f0r/dzk/JQH6nuR/vUBQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392587904"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="392587904"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667154564"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="667154564"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 07:55:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWZP-000cyz-0d;
        Wed, 28 Jun 2023 17:54:59 +0300
Date:   Wed, 28 Jun 2023 17:54:58 +0300
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
Subject: Re: [RFC PATCH 8/8] ASoC: SOF: Intel: Update PCI ID list
Message-ID: <ZJxJwliMOj/RYLsH@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-9-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-9-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:35PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_DEVICE_DATA macro, to simplify declarations.

PCI_DEVICE_DATA()

...

> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL,	&bxt_desc) },

TAB(s) vs single space?

...

>  static const struct pci_device_id sof_pci_ids[] = {
> -	{ PCI_DEVICE(0x8086, 0x119a),
> -		.driver_data = (unsigned long)&tng_desc},
> +	{ PCI_DEVICE_DATA(INTEL, HDA_MRFLD,	&tng_desc) },

Is it HDA? IIRC it was called Intel SST or so.

>  	{ 0, }
>  };

Also with the file name, I think the ID itself should use TNG suffix.

-- 
With Best Regards,
Andy Shevchenko



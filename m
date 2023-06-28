Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18174144C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjF1Ox3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:53:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:10070 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbjF1OxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963985; x=1719499985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cg7dkx2gsnXgVGaUug0ARzW7wx7R0VAqNKiR1u2VeAg=;
  b=hfG3G3PGbOjiGqQ0nOi6eeR2mKC6Ag3YIQa+p4+wt77c3Rx5LUMEi+kW
   Cxn+bneii5FHxYGgoRSZY0DFSsXpGLcvIifKiJ7sKT6wpLTh//prRRVJI
   OGg2Hu4MVlrZmW/ca0YzrZY3kPeu6Hk4o4xXdW9JnlESYF9cg1csnInYt
   ZLo+S0FbehALn0IfYg6OI7vBEyCgsTeIqSRIF695lOT5LUbyixLw7MRbO
   75Iv/2FkfULAPIsqaohy2sfrv8LqT/46QA8PKF6k46VgVc3mXns66Hs78
   PylNHjy0e79cgwynnzxF+JtLVqxEq5gRmYLnoGunZ1iD3t0fvx+Mlsk9z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392586740"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="392586740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="752279641"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="752279641"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 07:51:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWVp-000cvg-1B;
        Wed, 28 Jun 2023 17:51:17 +0300
Date:   Wed, 28 Jun 2023 17:51:17 +0300
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
Subject: Re: [RFC PATCH 6/8] ASoC: Intel: avs: Update PCI ID list
Message-ID: <ZJxI5cX6hLaBRC6w@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-7-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-7-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:33PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY macro,

AVS_MACH_ENTRY()

> so device id can be provided in short form.

ID

...

>  #define AVS_MACH_ENTRY(_id, _mach) \
> -	{ .id = (_id), .machs = (_mach), }
> +	{ .id = PCI_DEVICE_ID_INTEL_HDA_##_id, .machs = (_mach), }

I would duplicate HDA in all entries below in order to be compatible with
PCI_DEVICE_DATA() (logically, so if I grep for one, I grep exactly for
everything after PCI_DEVICE_ID_INTEL_ prefix and these won't show up.

-- 
With Best Regards,
Andy Shevchenko



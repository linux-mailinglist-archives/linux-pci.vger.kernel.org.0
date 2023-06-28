Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB712741448
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjF1OxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:53:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:30862 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbjF1Owj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963959; x=1719499959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uHOo6pxeJDOU50rDEZZ8nkN2xnoOZoCUvC36LEG0P48=;
  b=Pd0t3yImnnVmQ/62D/K8bIUBsznAtV/DGdVZuDM9612oa8tWCSK9re3s
   NibkX0HqGmuYGv+RwmUPLPsZLs1XNM7UcZp1f/fNMBDO+hK7Ha10GV4+7
   mCz6oiuSLcLaWx79i6pWNYOcVw6Azl32WQh8Rk0VAV1AKFFglcVXUznfq
   aoq83Op/ffDoz7CpxRR4DX2pRXWllFACKvVm/NYsqvOUYWTO0yNToKEs/
   mZFNlZoiTi8sNJbxYViReAugmCO6xWcWR6jPu/d0vT0rn82OV4dCBOruE
   9K08pBw0QI8ISmFB2lz/arIVot2Fx94Q+dNOAyWeuNelhr6vYxOdCxtwU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342201917"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342201917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720261514"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="720261514"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2023 07:52:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWX4-000cxD-1u;
        Wed, 28 Jun 2023 17:52:34 +0300
Date:   Wed, 28 Jun 2023 17:52:34 +0300
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
Subject: Re: [RFC PATCH 7/8] ASoC: Intel: Skylake: Update PCI ID list
Message-ID: <ZJxJMg0bldj/M7TY@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-8-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-8-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:34PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_DEVICE_DATA macro, to simplify declarations.

PCI_DEVICE_DATA()

...

> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP,	&snd_soc_acpi_intel_skl_machines) },

Do you really need TAB(s) in the parameter list?

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4B7413FA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjF1OnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:43:00 -0400
Received: from mga06b.intel.com ([134.134.136.31]:40100 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbjF1Om7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963379; x=1719499379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=peKAr0s1Kurrh+o6kbrz5QnnAIgvQneW3GDRLAasnhQ=;
  b=KU+kT9kLodqd6Q4kTAzWRZNtPggESLjS5siXXAY8VHKJJmFuNH3/jFXY
   X7Z2IAkdQigX/NfYPapreqkw3/giBjT58nhofX/1cb4EglpCeFxShFh1F
   fquAiJkbvtqELjJrfpCcnMValiM4Uri69wmCnupJmYscjeK8otgtut3vJ
   TG0UjJ/9MEQ/o56mpGxlt9Ay1sCjA9FpIsxBudAsk6SnlctGA0A+g7IWG
   92VgmGwRGl/CmeH03kXStsad9QNQYb07Ve9es8SsUTOZ/SbzTGwDskb7N
   vXlO9Zbh2qSY3WjlAlBaJtyRSSUHSkzOB50I/F6XHbcouk1D3luMR5UPE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="425533944"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="425533944"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891069714"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="891069714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 07:42:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWNi-000coK-0e;
        Wed, 28 Jun 2023 17:42:54 +0300
Date:   Wed, 28 Jun 2023 17:42:53 +0300
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
Subject: Re: [RFC PATCH 4/8] ALSA: hda/i915: Update PCI IDs
Message-ID: <ZJxG7YRroqi6kiyz@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-5-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-5-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:31PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header

Missing period at the end.

...

> -#define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
> -				((pci)->device == 0x0c0c) || \
> -				((pci)->device == 0x0d0c) || \
> -				((pci)->device == 0x160c))
> +#define IS_HSW_CONTROLLER(pci) (((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_0) || \
> +				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_2) || \
> +				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_3) || \
> +				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_BDW))

The very same macro under different name appeared in the previous patch.
Am I correct? Perhaps go further and first move it somewhere to be available
for both?

-- 
With Best Regards,
Andy Shevchenko



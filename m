Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11974143C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjF1OuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:50:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:52191 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbjF1OuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963821; x=1719499821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bFRkg/A1N0s6zxPjY9fVqj3qwmWFac2EO4cGoT+BOGg=;
  b=B2xLjE1vtCuEbCq+1vGg5o53ft0anMT5ib36v6tKAqN8ySeDnpP23zGU
   O/tAmZbRKN1tPSaaKHsPFDY6ZVLKkcpDDsoUuCBSP4SI5KOqDAh5BnSaV
   4ChUuDojY/Ai9rI5IGg7HfQxLa5XFrFzzh1Hp/kftPaMKOOnDx/vvP2TK
   MsiD4pbc9yA+1UWbl35OwE8ukzz7hCk2FLEm1cjhAyhjfodTRkbM3Gxkk
   9Es07loQc4GFN71fFERYqu40KD7Md4oJl6tAUe0BBMSSLLvZIVVxO3wPw
   6IklKbdcUFeYOWEU2HUKQo4ZbPYxFKRETsj7FpXyZRKPZax9uKnzGUYBW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="365326304"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="365326304"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="711064282"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="711064282"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2023 07:49:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWTk-000ctw-1s;
        Wed, 28 Jun 2023 17:49:08 +0300
Date:   Wed, 28 Jun 2023 17:49:08 +0300
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
Subject: Re: [RFC PATCH 0/8] PCI: Define Intel PCI IDs and use them in drivers
Message-ID: <ZJxIZGV4+5Al0CpW@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:27PM +0200, Amadeusz Sławiński wrote:
> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
> various configurations and historical reasons. Currently almost all uses
> of HDA PCI IDs have corresponding comment telling which platform it is.
> Additionally there are some inconsistencies between drivers about which
> ID corresponds to which device.
> 
> Simplify things, by adding PCI IDs to global header and make use of them
> in drivers. This allows for removal of comments by having IDs themselves
> being self explanatory. Additionally it allows for removal of existing
> inconsistencies by having one source of truth.

I'm in favour of this series. It allows to use PCI_DEVICE_DATA() in many places.
With that said, I think you can also add some more definitions to PCI IDs header
for the sake of being able to use that macro.

-- 
With Best Regards,
Andy Shevchenko



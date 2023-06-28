Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA84474143B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjF1OuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 10:50:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:52194 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbjF1OuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 10:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963821; x=1719499821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sruLiv3/xbwyVIj40BdSCpcvE/mBru7v73bQNqR+j/8=;
  b=RU5yR9uFguEyTuiEmC2nUk39n7sZae+o3Ctt0Bcn7I/V5adAEV1i5sf+
   /C1bTzi4oD8FzvToTjGfc047udt9bjfOzznF7+6WEtFYqa+ieno6yFocW
   eQFMlhYvCtb6atPn8laRSOnMIaI+ktqX3J53PVDOgsJDSGX4at1515zsF
   /kJS9PjDjGIc9l8c3cOAht6D8+6ynBgC35CX5bI62JZz7i6C9340tMU/+
   pg0Rpcm/EwTo8gtwlmGRvhnR3gx1JeWHQO+oNDVSB1QPWrUSa/Ucvq4Ue
   +4/F9bLJXHoRB9FH7myy9CzDII1asvJOLWIj0PS3UU+P5luVFqWepQ0R/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="365326097"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="365326097"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047454257"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="1047454257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 07:48:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWSk-000ctL-10;
        Wed, 28 Jun 2023 17:48:06 +0300
Date:   Wed, 28 Jun 2023 17:48:06 +0300
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
Subject: Re: [RFC PATCH 5/8] ASoC: Intel: avs: Update PCI ID list
Message-ID: <ZJxIJnIdoxb5CM/B@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-6-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-6-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:51:32PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_DEVICE_DATA macro, to simplify declarations.

PCI_DEVICE_DATA()

-- 
With Best Regards,
Andy Shevchenko



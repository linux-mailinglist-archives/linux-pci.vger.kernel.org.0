Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66374F036
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjGKNdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGKNdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:33:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2237E6A;
        Tue, 11 Jul 2023 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689082409; x=1720618409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3mWlwfyj0TpsA85OQqIB9DgXGmiMWUXRVcYEkhHKRnM=;
  b=AttkmzzchvUVHYMUdZYtzOmqx1YuR2ntQvD97XuKw1yjQO67EMMxbpY3
   VRpGyXhbFqCFBNEgJpcKPcs0wG4gpD3VtMmiTKwZG1Em1QTovWkQM2bQV
   ztKt5NkepxJNNNZdu80L7qjiTRV/mZY3bBQYCpaCzuqfoiA+rKlAkmDq6
   e0kftV/xmPfxJRiANGdMRXtTJrgGqIHYj5ySi2QrgYLNFLpkwLORpdUuO
   w48IQbs12qwA+HzYCiNQWmoycdip+jJWu7AzEabPjRSXW3BXt+WPacACw
   yKrQVfE4oQrZSxZlXWMRTrtNuYpMjJeHJ0tD42o5a06etuWMvYcuxKLfY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="368117447"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368117447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="895172613"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="895172613"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Jul 2023 06:33:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDUD-001rRp-0b;
        Tue, 11 Jul 2023 16:33:01 +0300
Date:   Tue, 11 Jul 2023 16:33:00 +0300
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
Subject: Re: [PATCH 02/13] PCI: Add Intel Audio DSP devices to pci_ids.h
Message-ID: <ZK1aDMZg+I/Dheo6@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-3-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-3-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:15PM +0200, Amadeusz Sławiński wrote:
> Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
> Almost every use contains additional comments to identify to which
> platform those IDs refer to. Add those IDs to pci_ids.h header, so that
> there is one place which defines those names.

From style looks good to me, but I think somebody from ASoC/sound needs to
carefully check HDA/non-HDA/etc.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # for the Intel Tangier ID

> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



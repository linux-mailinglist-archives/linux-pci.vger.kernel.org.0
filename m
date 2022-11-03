Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FCE618543
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 17:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKCQuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiKCQtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 12:49:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279262E8
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667494163; x=1699030163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jf3eQhOIFSlM7iLGemV5jEMLPCAHweHmbuI7D8KQczo=;
  b=GU3PFxyE+v1y1o/TAFuH1QvylEVyVgxpKT2TQsuz4fPXnoOsFdfzG8eI
   eUfVnsbHbCihLt/juRTWUxtZPsUq0ZVfO0kyGL78xzomxhkVaYovQyC/n
   cI3HPicXo6nvGq42h707TsRbtZOyLcABJNEEhrI+RVMTE8oP/ARLPC0r/
   zkcmdFMU1QxyNR+kEEG4ZlP3wWan+zAKcqjFbCOqN1lqFVfkRSiE7tB2j
   pbOZwbK4Ynku211OvTwJsk3cKWTnZRKEXY/t/Xg0kU/DgcHd3xhV7jztE
   03C35LiEI2ScokGYrd4kfyKq1C2Je9UZfuKzYLcO3L3YHo4PBRtveI7JR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396043761"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="396043761"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740263701"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="740263701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 09:49:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqdP2-006wDE-0O;
        Thu, 03 Nov 2022 18:49:16 +0200
Date:   Thu, 3 Nov 2022 18:49:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <Y2PxC+myncnWi8Dk@smile.fi.intel.com>
References: <20221103110620.30938-1-mika.westerberg@linux.intel.com>
 <Y2OsGJ5y8llo7L9R@smile.fi.intel.com>
 <Y2Ove2wE/OUNT0cq@black.fi.intel.com>
 <Y2PT9kSFkrG96JAX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PT9kSFkrG96JAX@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 04:45:11PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 03, 2022 at 02:09:31PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 03, 2022 at 01:55:04PM +0200, Andy Shevchenko wrote:

...

> > I'm fine if this patch gets ignored ;-) Sorry about the noise then.
> 
> No, that's not what I implied.
> Let me take it and see if we can do better/

I have send a new version (which become a series out of 4 patches).

-- 
With Best Regards,
Andy Shevchenko



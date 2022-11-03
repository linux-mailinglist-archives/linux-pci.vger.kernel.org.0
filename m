Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE67617C05
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 12:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCLzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 07:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiKCLzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 07:55:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC412A87
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667476509; x=1699012509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FpYMHF8wsJmryyvr2e7ypezvEUlH3vgrBQDwpgVGRgA=;
  b=ndvq0Ac9p9jalfkoEbWt+Ikir3pnTmG0bji6741Em4GMOix1N7Uln0MY
   WaQ+xrKCW2wGo7KHGZ7XY6WTwPY5EmcI8w2jToJpxTIVWNPF0UsAIQF0/
   UEHm7OnZxvbiV0WwbY5hL8NlxHI1rCXaDf1tZvqlIPxgRFFu9VDLq3YAj
   zRSs+Kmt1iolyeod7j9VYr/I+QgVragTwiwmZsZogx2x2CFSUGRMF427e
   eN1rHGJNskPPcY5O+O6QMzYufZNbeuyBea1bA2jcDhLZTUf4dpq8OnSCw
   IdUpHIM64Q4TaINz90gYDYByZk9OnspMSNcjRTecgugEYJ7VHa9LrJUBb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="290049588"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="290049588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 04:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="665940861"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="665940861"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2022 04:55:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqYoK-006h5K-0v;
        Thu, 03 Nov 2022 13:55:04 +0200
Date:   Thu, 3 Nov 2022 13:55:04 +0200
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
Message-ID: <Y2OsGJ5y8llo7L9R@smile.fi.intel.com>
References: <20221103110620.30938-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103110620.30938-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 01:06:20PM +0200, Mika Westerberg wrote:
> Instead of open-coding it everywhere introduce a tiny helper that can be
> used to iterate over each resource of a PCI device, and convert the most
> obvious users into it.
> 
> While at it drop doubled empty line before pdev_sort_resources().
> 
> No functional changes intended.

Thanks! But this has one subtle difference to what I suggested, see below.

...

> +/**
> + * pci_dev_for_each_resource() - Iterate over each PCI device resource
> + * @dev: PCI device
> + * @res: Variable that holds the current resource
> + * @i: Iterator
> + */
> +#define pci_dev_for_each_resource(dev, res, i)			\
> +	for (i = 0;						\

unsigned int i = 0;

> +	     res = &(dev)->resource[i], i < PCI_NUM_RESOURCES;	\
> +	     i++)

That's the idea to hide the iterator variable inside the loop. It might be
though needed in some cases, so for them this conversion can't be done right
now.

-- 
With Best Regards,
Andy Shevchenko



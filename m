Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE060CD56
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiJYNXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiJYNXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 09:23:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9E175372;
        Tue, 25 Oct 2022 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666704212; x=1698240212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7kwGhb0MRXm9tgMVHmxlCE5h5+VLUT9HgPyhSTdDvmc=;
  b=Z9h7bH4opqJcV8OW5Gfhz4q4RSIxC89wZuYXQltRKt71VheF7vzAjB1E
   OrSWOfx3UBRHQG6JFlBjRhFdvEEh6Kyv+ELf1EW/aopajcMcnSKQaUetp
   9M/cyH99D0+DeVAa6mALbfQNSRl7W0VmQngIxJCuesL5H/9Xf2sqYhMuW
   JfrBHaaFL2SFWYMWvLXFPTtcuK4Cyg/YKOz5yef3SQCwmAtRk1Zy7+xOX
   v5kXjEW3ZH7jWGDC2rZm0V7yK95maKfUXCsyf4qV3PU9lEdXqqBeQPlvx
   rQOOR3bfhhWKS8ePHv5SIN6uLUoqXvA3BcYXPQHxsj6rKle51hqSZPHpm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308763591"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="308763591"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806660191"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="806660191"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2022 06:23:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onJtv-00215d-1v;
        Tue, 25 Oct 2022 16:23:27 +0300
Date:   Tue, 25 Oct 2022 16:23:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: Regression: Re: [PATCH v2 4/6] PCI: Distribute available
 resources for root buses too
Message-ID: <Y1fjT6eyV8KVlNRp@smile.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
 <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
 <20221014154858.000079f2@huawei.com>
 <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
 <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
 <Y1fYNsjmUFZsvteT@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1fYNsjmUFZsvteT@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 03:36:06PM +0300, Mika Westerberg wrote:
> On Mon, Oct 24, 2022 at 02:25:12PM +0300, Mika Westerberg wrote:

Just for the record in case this code will formally go out

...

> +			for (i = 0; i < PCI_ROM_RESOURCE; i++) {
> +				const struct resource *dev_res = &dev->resource[i];

I believe this is a good candidate to have

#define for_each_pci_dev_resource(dev, res)			\
	for (unsigned int i = 0;				\
	     res = &(dev)->resource[i], i < PCI_ROM_RESOURCE;	\
	     i++)

Since we have many places in the kernel with such a snippet.

> +			}

-- 
With Best Regards,
Andy Shevchenko



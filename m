Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8E617FDE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiKCOpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKCOpQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 10:45:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98775F81
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667486715; x=1699022715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=abG+hmR81YbXaqoG9xRk5kJQYZnReokm6ZcCd+KdS8E=;
  b=GtXjZl1aOyy+fm4axmymn+/AKK3MP09H51YeiXDbaQozCQm4KJeYW3tX
   zUy4v4ttnQcLmuzBsCzI4jN34/3eyOLCfR4BBDMOkuuWqCQ4l5LyzxnxL
   66Kx8RPeeI+ZMXNSdi0tiPzAH89PczerSFZUjMjxMu2SC/3JL4vZbkYTo
   plQzKS9ZBnO1MKoCxc6sDS5QblkiPDp8dP2gSRy9UiqFJ1OP+H2iWT5X6
   gqazK+7VVeBT3zub2mBOhu9gLjSnTk4iIPSg/oT/0frx3oeuWxPb7dxr4
   g7hnkeTJk6ZjmYsIbpEdEN8MVxqYuTqC1sqw7iaPqgOzY6eEDaj8PYlXI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="309698623"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="309698623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 07:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="637202105"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="637202105"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2022 07:45:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqbSx-006tIX-02;
        Thu, 03 Nov 2022 16:45:11 +0200
Date:   Thu, 3 Nov 2022 16:45:10 +0200
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
Message-ID: <Y2PT9kSFkrG96JAX@smile.fi.intel.com>
References: <20221103110620.30938-1-mika.westerberg@linux.intel.com>
 <Y2OsGJ5y8llo7L9R@smile.fi.intel.com>
 <Y2Ove2wE/OUNT0cq@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Ove2wE/OUNT0cq@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 02:09:31PM +0200, Mika Westerberg wrote:
> On Thu, Nov 03, 2022 at 01:55:04PM +0200, Andy Shevchenko wrote:

...

> I'm fine if this patch gets ignored ;-) Sorry about the noise then.

No, that's not what I implied.
Let me take it and see if we can do better/

-- 
With Best Regards,
Andy Shevchenko



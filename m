Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5302A93C3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKFKKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 05:10:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:37750 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgKFKKA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Nov 2020 05:10:00 -0500
IronPort-SDR: Zlb18iSgnGmDW/5+nkZ/fSPhCk/GmnwVe+qPXHXvkqIgdeYDbqnnN4Tsms6VimWh8pEYivQOOb
 k2HSRuVae+LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="166936364"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="166936364"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 02:10:00 -0800
IronPort-SDR: Q//tRwzL5PbJ56tvHBk+eIOG2oOLYTfiPohZcrdpUm4iNA71gUrSQQBu//U/iY1Qk5yQSPPHZ1
 q+Siyn848LJQ==
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="529759467"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 02:09:58 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kayhw-004J3z-LC; Fri, 06 Nov 2020 12:11:00 +0200
Date:   Fri, 6 Nov 2020 12:11:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org
Cc:     alberto.vignani@fastwebnet.it,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v1 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201106101100.GG4077@smile.fi.intel.com>
References: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 08:06:43PM +0200, Andy Shevchenko wrote:
> Pericom PCIe-USB adapter ambiguously advertises MSI, but documentation says
> "The MSI Function is not implemented on this device." in the chapters 7.3.27,
> 7.3.29-7.3.31.

I have sent v2 [1].

[1]: https://lore.kernel.org/linux-usb/20201106100526.17726-1-andriy.shevchenko@linux.intel.com/

> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> Reported-by: alberto.vignani@fastwebnet.it
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



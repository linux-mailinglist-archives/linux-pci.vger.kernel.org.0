Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5C46F401
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhLITiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 14:38:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:22242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhLITiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 14:38:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="237995926"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="237995926"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:34:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="463375164"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:34:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvPAi-004EPJ-Lw;
        Thu, 09 Dec 2021 21:33:40 +0200
Date:   Thu, 9 Dec 2021 21:33:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 1/1] PCI: Introduce pci_bus_*() printing macros when
 device is not available
Message-ID: <YbJaFM0vlkdTwxUS@smile.fi.intel.com>
References: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
 <411886e9e89f797d3f9513245f94b2a5f4a33e7d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411886e9e89f797d3f9513245f94b2a5f4a33e7d.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 10:40:57AM -0800, Joe Perches wrote:
> On Thu, 2021-12-09 at 20:27 +0200, Andy Shevchenko wrote:

...

> > +#define pci_bus_printk(level, bus, devfn, fmt, arg...) \
> > +	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
> > +	       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##arg)
> 
> I have a small preference for using ... and __VA_ARGS___

It contradicts what other macros in the pci.h do.
So I will stick with current solution for the sake of consistency.

...

> and likely this should have parentheses around bus
> 
> 	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
> 	       pci_domain_nr(bus), (bus)->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##__VA_ARGS__)

This makes sense, thanks!

-- 
With Best Regards,
Andy Shevchenko



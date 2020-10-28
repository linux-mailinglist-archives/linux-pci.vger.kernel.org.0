Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F829F5DD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 21:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgJ2UHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 16:07:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:56957 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ2UHZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 16:07:25 -0400
IronPort-SDR: xAYhevKlqmxZLIaWP+/TAGrJltOcXknjjfHt7ZgHhJXYj4h6RcC7XLyYuDy1wTwFvqcVzOUZKv
 hm0PCVt0uioQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156277811"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="156277811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:07:24 -0700
IronPort-SDR: boR8HuwYZ1DDKpKJGtJM7nHx7Qt8JAR73loJuw+7B99Er1Pwu9DV3el+yvS3nJmLytI82QM6wO
 9zN79HMUDJ/w==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="323833383"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:07:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kYEDi-001UMh-5C; Thu, 29 Oct 2020 22:08:26 +0200
Date:   Wed, 28 Oct 2020 17:34:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201028153454.GV4077@smile.fi.intel.com>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201028142247.GC3932108@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028142247.GC3932108@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 09:22:47AM -0500, Rob Herring wrote:
> On Tue, Oct 27, 2020 at 02:00:11PM +0800, Wan Ahmad Zainie wrote:

...

> > +config PCIE_KEEMBAY_HOST
> > +	bool "Intel Keem Bay PCIe controller - Host mode"
> > +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
> 
> Why only ARM64 for compile test?

It's just for consistency with other Keem Bay drivers which may or may not use
ARM64 specific call. Since DWC3 core PCI driver is used on many platforms and
is being tested on other architectures, I think it's fine. This glue driver is
for certain platform. But what I'm wondering now is if the existing glue code
for some other platform can be reused here.

> > +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> > +	select PCIE_DW_HOST
> > +	select PCIE_KEEMBAY


-- 
With Best Regards,
Andy Shevchenko



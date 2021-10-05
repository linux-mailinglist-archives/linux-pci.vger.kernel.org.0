Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3E4225E8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhJEMGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 08:06:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:52530 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234455AbhJEMGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 08:06:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225662002"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225662002"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:04:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="589331287"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:04:57 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mXjBm-008sCS-MR;
        Tue, 05 Oct 2021 15:04:54 +0300
Date:   Tue, 5 Oct 2021 15:04:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies
 (PCIE_DW_HOST)
Message-ID: <YVw/Zn3fKI0CE+LW@smile.fi.intel.com>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
 <163342655846.12064.11677535124745483381.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163342655846.12064.11677535124745483381.b4-ty@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 10:36:09AM +0100, Lorenzo Pieralisi wrote:
> On Wed, 23 Jun 2021 17:01:02 +0300, Andy Shevchenko wrote:
> > First of all, the "depends on" is no-op in the selectable options.
> > Second, no need to repeat menu dependencies (PCI).
> > 
> > Clean up the users of PCIE_DW_HOST and introduce idiom
> > 
> > 	depends on PCI_MSI_IRQ_DOMAIN
> > 	select PCIE_DW_HOST
> > 
> > [...]
> 
> Applied to pci/dwc, thanks!

Sorry I have had no time to address your comments, but it seems you did it for
me, thank you!

-- 
With Best Regards,
Andy Shevchenko



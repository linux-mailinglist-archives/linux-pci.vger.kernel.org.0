Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE63E199E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhHEQgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 12:36:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:36587 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhHEQgB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 12:36:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="193790028"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="193790028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 09:35:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="668981689"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 09:35:44 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mBgLK-005WxP-Nt; Thu, 05 Aug 2021 19:35:38 +0300
Date:   Thu, 5 Aug 2021 19:35:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies
 (PCIE_DW_HOST)
Message-ID: <YQwTWoLys3wX75gY@smile.fi.intel.com>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
 <20210805135234.GA22410@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805135234.GA22410@lpieralisi>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 02:52:34PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Jun 23, 2021 at 05:01:02PM +0300, Andy Shevchenko wrote:
> > First of all, the "depends on" is no-op in the selectable options.
> > Second, no need to repeat menu dependencies (PCI).

> Define which specific "depends on" you are referring to.

I didn't get this because it stands right. It's in general.
I can be more specific since it's in align with the code,
though.

All the rest I agree with.

-- 
With Best Regards,
Andy Shevchenko



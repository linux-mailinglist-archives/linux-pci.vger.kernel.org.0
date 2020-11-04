Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891DB2A6097
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 10:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgKDJfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 04:35:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:35686 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKDJfa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 04:35:30 -0500
IronPort-SDR: 4hCOhcUKMcKrrx7tsk4W0PUrh/YEGHFoyn4u8ZUagCWZCvc4bF7WpZKq/DIIrnEVrizddrHCCV
 l0vfzYSHIhJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148467152"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="148467152"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 01:35:28 -0800
IronPort-SDR: IjWFqoVdUGufA/DjE5SJb9He/WnuwWBM3R84P8Nme2KpB49hJrTC1KGN1CfRwYRUK0yDbMNeOV
 4jra97FGtm1A==
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="353754899"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 01:35:26 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kaFDQ-003mpN-Pm; Wed, 04 Nov 2020 11:36:28 +0200
Date:   Wed, 4 Nov 2020 11:36:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201104093628.GJ4077@smile.fi.intel.com>
References: <20201027060011.25893-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201103222223.GA269610@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103222223.GA269610@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03, 2020 at 04:22:23PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 27, 2020 at 02:00:11PM +0800, Wan Ahmad Zainie wrote:
> > +static int keembay_pcie_link_up(struct dw_pcie *pci)
> > +{
> > +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> > +	u32 val, mask;
> > +
> > +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_SII_PM_STATE);
> > +	mask = SMLH_LINK_UP | RDLH_LINK_UP;
> > +
> > +	return !!((val & mask) == mask);
> 
> I think the "!!" is redundant since you're applying it to a value
> that's a boolean already.  So you should be able to do:
> 
>   return (val & mask) == mask;
> 
> But it seems like "mask" just obfuscates a little bit, too.
> Personally I think it'd be easier to add something like:
> 
>   #define PCIE_REGS_PCIE_SII_LINK_UP  (SMLH_LINK_UP | RDLH_LINK_UP)
> 
> and then:

>   if ((val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP)
>     return 1;
>   return 0;

The !! is usual way to guarantee that *int* type out of boolean will be only
0 or 1. That said, the above proposal suits better.

> or even:
> 
>   return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;

-- 
With Best Regards,
Andy Shevchenko



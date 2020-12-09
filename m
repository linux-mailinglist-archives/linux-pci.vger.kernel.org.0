Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28262D4943
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 19:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgLISnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 13:43:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:56059 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733201AbgLISnJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 13:43:09 -0500
IronPort-SDR: nkG+bGWsOoYrfG4XW5fSQDLHeGZNFl9LwHyvR+jb3Ug+OO0gl144eccUhwMkDXAwXuMcc+leMp
 /3Ed09T+3J0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="192435736"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="192435736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 10:41:14 -0800
IronPort-SDR: gZ87t0Nc/DqupPI7eEQNqHQ97pL8lkeZ2mUZ5qVhcWQ5FUkfyp4jVwSupE1aJRK6G+24OKrp8E
 oBe7TL4Yl2kw==
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="408175808"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 10:41:12 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kn4Pm-00DCiD-E0; Wed, 09 Dec 2020 20:42:14 +0200
Date:   Wed, 9 Dec 2020 20:42:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201209184214.GV4077@smile.fi.intel.com>
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201209181350.GB660537@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209181350.GB660537@robh.at.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 12:13:50PM -0600, Rob Herring wrote:
> On Wed, Dec 02, 2020 at 03:31:56PM +0800, Wan Ahmad Zainie wrote:

...

> > +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie, bool enable)
> > +{
> > +	u32 val;
> > +
> > +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_APP_CNTRL);
> > +	if (enable)
> > +		val |= APP_LTSSM_ENABLE;
> > +	else
> > +		val &= ~APP_LTSSM_ENABLE;
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_APP_CNTRL, val);
> 
> If this is the only bit in this register, do you really need RMW?

I think it's safer than do direct write and have something wrong on next
generations of hardware.

...

> > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > +				     enum pci_epc_irq_type type,
> > +				     u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		/* Legacy interrupts are not supported in Keem Bay */
> > +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > +		return -EINVAL;
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	case PCI_EPC_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > +		return -EINVAL;
> > +	}
> 
> Doesn't the lack of a 'return' give a warning?

Where? I don't see any lack of return.

> > +}

-- 
With Best Regards,
Andy Shevchenko



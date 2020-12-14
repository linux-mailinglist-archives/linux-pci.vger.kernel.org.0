Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9872D9B32
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438051AbgLNPfm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 10:35:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:29578 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407761AbgLNPfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 10:35:40 -0500
IronPort-SDR: u0ij5Ba6eXhRk5wdWtCT0k04nwCSdlgUCvbUUl5SWAxAnvRl+cnB58ysqgnpS5tuQLLhW0R0Rq
 teqnP9qZVKzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="154533059"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="154533059"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 07:33:55 -0800
IronPort-SDR: zIxaIazk4jOgt8HPRzw7UppNp4E/ygsjRldrqZnz85QEf9v1I/q+aCSRxi5GlYKObKtRJEEkxt
 8yux0UkYLueg==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="449054765"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 07:33:53 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kopsE-00EIfM-Tq; Mon, 14 Dec 2020 17:34:54 +0200
Date:   Mon, 14 Dec 2020 17:34:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201214153454.GJ4077@smile.fi.intel.com>
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201209181350.GB660537@robh.at.kernel.org>
 <20201209184214.GV4077@smile.fi.intel.com>
 <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 10, 2020 at 11:46:48AM -0600, Rob Herring wrote:
> On Wed, Dec 9, 2020 at 12:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Dec 09, 2020 at 12:13:50PM -0600, Rob Herring wrote:
> > > On Wed, Dec 02, 2020 at 03:31:56PM +0800, Wan Ahmad Zainie wrote:

...

> > > > +   struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +
> > > > +   switch (type) {
> > > > +   case PCI_EPC_IRQ_LEGACY:
> > > > +           /* Legacy interrupts are not supported in Keem Bay */
> > > > +           dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > > > +           return -EINVAL;
> > > > +   case PCI_EPC_IRQ_MSI:
> > > > +           return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > > > +   case PCI_EPC_IRQ_MSIX:
> > > > +           return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > > > +   default:
> > > > +           dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > > > +           return -EINVAL;
> > > > +   }
> > >
> > > Doesn't the lack of a 'return' give a warning?
> >
> > Where? I don't see any lack of return.
> 
> Is the compiler smart enough to recognize that with a return in every
> 'case' that we don't need a return after the switch? I wouldn't have
> thought so, but I haven't checked.

Dunno what happen with -O0, but with -O2 we certainly have no issues with above
code. (And for the record there are plenty examples of the same over the kernel)

-- 
With Best Regards,
Andy Shevchenko



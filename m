Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DDF11C0BA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 00:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLKXqb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 18:46:31 -0500
Received: from foss.arm.com ([217.140.110.172]:52186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfLKXqa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 18:46:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0CC51FB;
        Wed, 11 Dec 2019 15:46:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 661923F52E;
        Wed, 11 Dec 2019 15:46:29 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:46:27 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        gustavo.pimentel@synopsys.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v10 2/3] PCI: dwc: intel: PCIe RC controller driver
Message-ID: <20191211234627.GC24359@e119886-lin.cambridge.arm.com>
References: <7f5f0eec-465e-9c21-35ac-b6906119ed5e@linux.intel.com>
 <20191211142022.GA26342@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211142022.GA26342@google.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 08:20:22AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2019 at 05:59:58PM +0800, Dilip Kota wrote:
> > 
> > On 12/11/2019 7:49 AM, Bjorn Helgaas wrote:
> > > On Fri, Dec 06, 2019 at 03:27:49PM +0800, Dilip Kota wrote:
> > > > Add support to PCIe RC controller on Intel Gateway SoCs.
> > > > PCIe controller is based of Synopsys DesignWare PCIe core.
> > > > 
> > > > Intel PCIe driver requires Upconfigure support, Fast Training
> > > > Sequence and link speed configurations. So adding the respective
> > > > helper functions in the PCIe DesignWare framework.
> > > > It also programs hardware autonomous speed during speed
> > > > configuration so defining it in pci_regs.h.
> > > > 
> > > > Also, mark Intel PCIe driver depends on MSI IRQ Domain
> > > > as Synopsys DesignWare framework depends on the
> > > > PCI_MSI_IRQ_DOMAIN.
> > > > 
> > > > Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> > > > +static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
> > > > +{
> > > > +	u32 old;
> > > > +
> > > > +	old = readl(base + ofs);
> > > > +	val = (old & ~mask) | (val & mask);
> > > > +
> > > > +	if (val != old)
> > > > +		writel(val, base + ofs);
> > > I assume this is never used on registers where the "old & ~mask" part
> > > contains RW1C bits?  If there are RW1C bits in that part, this will
> > > corrupt them.
> > There is no impact because RW1C bits of respective registers are 0s at the
> > time of this function call.
> 
> Sounds ... dangerous, but I'll take your word for it.
> 
> > I see, this patch series is merged in the maintainer tree.
> > Should i need to submit as a separate patch on top of maintainer tree or
> > submit the new version of whole patch series?
> > Please let me know the best practice.
> 
> Sorry, I didn't realize this had already been merged to Lorenzo's
> tree.  But it's not upstream (in Linus' tree) yet.  I don't know how
> Andrew and Lorenzo want to handle this.  None of these are important,
> so you could just ignore these comments.
> 
> What I personally would do is rebase the branch, e.g.,
> lpieralisi/pci/dwc, and apply an incremental patch.  But it's up to
> Andrew and Lorenzo whether they want to do anything.

Hi Dilip,

Thanks for taking on this additional feedback.

I'd be happy for you to send an additional patch ontop of your v11 (head of
lpieralisi/pci/dwc) and we'll squash it in.

Thanks,

Andrew Murray

> 
> Bjorn

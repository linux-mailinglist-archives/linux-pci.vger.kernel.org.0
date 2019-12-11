Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77A411AD3D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfLKOUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 09:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKOUY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 09:20:24 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF6D214AF;
        Wed, 11 Dec 2019 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576074024;
        bh=2112vcRvffbbbfNLim0Vo0faBMt99YUI8qgiqHAGLqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nu8bvQlOLmTPRsrn+c+H1hyBH50QH6IXCOetMbMqKW5Y7S5UXeh13ojI5cLmBF6wt
         cSgcERk+vhQAE5dvLKeKLAt7lHT+zKNjsG/Cizxwdod0woiuW52sQ4dBNq1BjavF1y
         +6fvpZq9547S28MAHy9ZyEhc1aKFDFu2Ma/pXsfM=
Date:   Wed, 11 Dec 2019 08:20:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v10 2/3] PCI: dwc: intel: PCIe RC controller driver
Message-ID: <20191211142022.GA26342@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5f0eec-465e-9c21-35ac-b6906119ed5e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 05:59:58PM +0800, Dilip Kota wrote:
> 
> On 12/11/2019 7:49 AM, Bjorn Helgaas wrote:
> > On Fri, Dec 06, 2019 at 03:27:49PM +0800, Dilip Kota wrote:
> > > Add support to PCIe RC controller on Intel Gateway SoCs.
> > > PCIe controller is based of Synopsys DesignWare PCIe core.
> > > 
> > > Intel PCIe driver requires Upconfigure support, Fast Training
> > > Sequence and link speed configurations. So adding the respective
> > > helper functions in the PCIe DesignWare framework.
> > > It also programs hardware autonomous speed during speed
> > > configuration so defining it in pci_regs.h.
> > > 
> > > Also, mark Intel PCIe driver depends on MSI IRQ Domain
> > > as Synopsys DesignWare framework depends on the
> > > PCI_MSI_IRQ_DOMAIN.
> > > 
> > > Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

> > > +static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
> > > +{
> > > +	u32 old;
> > > +
> > > +	old = readl(base + ofs);
> > > +	val = (old & ~mask) | (val & mask);
> > > +
> > > +	if (val != old)
> > > +		writel(val, base + ofs);
> > I assume this is never used on registers where the "old & ~mask" part
> > contains RW1C bits?  If there are RW1C bits in that part, this will
> > corrupt them.
> There is no impact because RW1C bits of respective registers are 0s at the
> time of this function call.

Sounds ... dangerous, but I'll take your word for it.

> I see, this patch series is merged in the maintainer tree.
> Should i need to submit as a separate patch on top of maintainer tree or
> submit the new version of whole patch series?
> Please let me know the best practice.

Sorry, I didn't realize this had already been merged to Lorenzo's
tree.  But it's not upstream (in Linus' tree) yet.  I don't know how
Andrew and Lorenzo want to handle this.  None of these are important,
so you could just ignore these comments.

What I personally would do is rebase the branch, e.g.,
lpieralisi/pci/dwc, and apply an incremental patch.  But it's up to
Andrew and Lorenzo whether they want to do anything.

Bjorn

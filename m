Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2482C58577
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfF0PXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 11:23:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfF0PXI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 11:23:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73D83360;
        Thu, 27 Jun 2019 08:23:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3842D3F246;
        Thu, 27 Jun 2019 08:23:06 -0700 (PDT)
Date:   Thu, 27 Jun 2019 16:23:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
Message-ID: <20190627152303.GE3782@e121166-lin.cambridge.arm.com>
References: <20190618073810.30270-1-vidyas@nvidia.com>
 <20190627100616.GA30071@e121166-lin.cambridge.arm.com>
 <716ad7c9-08bb-b885-69bd-a442d6f9b2eb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716ad7c9-08bb-b885-69bd-a442d6f9b2eb@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 08:41:37PM +0530, Vidya Sagar wrote:
> On 6/27/2019 3:36 PM, Lorenzo Pieralisi wrote:
> > On Tue, Jun 18, 2019 at 01:08:10PM +0530, Vidya Sagar wrote:
> > > Currently Relaxed Ordering bit in the configuration space is enabled for
> > > all devices whereas it should be enabled only for root ports for Tegra20
> > > and Tegra30 chips to avoid deadlock in hardware.
> > 
> > This is a fix so I think you had better add a Fixes: tag and if the
> > erratum is a public document it would be good to add it to the log
> > to explain what the problem is.
> > 
> > Thanks,
> > Lorenzo
> This has been there from the beginning. I mean, if I have to give a tag as part
> of Fixes: , then I should give the tag that adds this driver itself. Is that fine?
> I can quote the following document section 31.1 for Tegra20, but the same information
> is not mentioned in Tegra30 specific public document.
> https://www.chiark.greenend.org.uk/~theom/riscos/docs/Tegra2_TRM_DP04508001v01p.pdf
> Is it fine to just quote only this document?

I am pretty sure an errata document should exist about this and Nvidia
owns it (if it is not public, well, there is nothing to quote then); I
would not quote this website, it does not look like Nvidia official
documentation.

For the Fixes: tag, it is up to you, to me this seems like a
critical bug (deadlock in hardware) and I do not think you
want to ship stable kernels with it. It depends on the entity
of the bug we are fixing, I leave it to you to decide the
best course of action, I am just trying to help.

Lorenzo

> Thanks,
> Vidya Sagar
> > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > >   drivers/pci/controller/pci-tegra.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > > index 464ba2538d52..bc7be369c1b3 100644
> > > --- a/drivers/pci/controller/pci-tegra.c
> > > +++ b/drivers/pci/controller/pci-tegra.c
> > > @@ -545,12 +545,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
> > > -/* Tegra PCIE requires relaxed ordering */
> > > +/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
> > >   static void tegra_pcie_relax_enable(struct pci_dev *dev)
> > >   {
> > >   	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
> > >   }
> > > -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
> > >   static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
> > >   {
> > > -- 
> > > 2.17.1
> > > 
> 

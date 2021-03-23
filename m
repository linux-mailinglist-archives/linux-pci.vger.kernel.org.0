Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA6346281
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhCWPNJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 11:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232727AbhCWPMw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 11:12:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C0D619C1;
        Tue, 23 Mar 2021 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616512372;
        bh=MA5YBPu4rtGbm7rfCEilpagOMIGhJYvOgD2AucgSTSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MCNlVU8Yu70hYWf7k0X11tlXsyrhmM/QJftKF8IrKxCWPO2DCbylZhY3uwVBLFnml
         121MQ9zbkdXeXo4oiMVY+PDG5cmRjxZ/TVK3nz0+iUHm5pVcZ5knOKJv11jvusCYdi
         2kNbJd2auV/YCtIK37nmXaZCHckoCFI0f7CKExpcodOm/MZ0QRuO0A0hRRqixlQLZM
         rW68zoR44+iFK2EgAPUWOuVOQlAwkVWvebBa6G2feN0/3qLeu7ffkfeLshzKT3efEY
         PMQY8IZH/zicmuvdNSI+DUypl1PCvGpgBYjaHF+MgiZNwPq/asi4xEXz9RHG2rerM0
         cdPoQzn9JLwYw==
Date:   Tue, 23 Mar 2021 10:12:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH RESEND] PCI: dwc: Fix MSI not work after resume
Message-ID: <20210323151250.GA576016@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323110115.3740f6b1@xhacker.debian>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[-cc Dilip (mail to him bounced)]

On Tue, Mar 23, 2021 at 11:01:15AM +0800, Jisheng Zhang wrote:
> On Mon, 22 Mar 2021 20:24:41 -0500 Bjorn Helgaas wrote:
> > 
> > [+cc Kishon, Richard, Lucas, Dilip]
> > 
> > On Mon, Mar 01, 2021 at 11:10:31AM +0800, Jisheng Zhang wrote:
> > > After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
> > > MSI stops working after resume. Because dw_pcie_host_init() is only
> > > called once during probe. To fix this issue, we move dw_pcie_msi_init()
> > > to dw_pcie_setup_rc().  
> > 
> > This patch looks fine, but I don't think the commit log tells the
> > whole story.
> > 
> > Prior to 59fbab1ae40e, it looks like the only dwc-based drivers with
> > resume functions were dra7xx, imx6, intel-gw, and tegra [1].
> > 
> > Only tegra called dw_pcie_msi_init() in the resume path, and I do
> > think 59fbab1ae40e broke MSI after resume because it removed the
> > dw_pcie_msi_init() call from tegra_pcie_enable_msi_interrupts().
> > 
> > I'm not convinced this patch fixes it reliably, though.  The call
> > chain looks like this:
> > 
> >   tegra_pcie_dw_resume_noirq
> >     tegra_pcie_dw_start_link
> >       if (dw_pcie_wait_for_link(pci))
> >         dw_pcie_setup_rc
> > 
> > dw_pcie_wait_for_link() returns 0 if the link is up, so we only call
> > dw_pcie_setup_rc() in the case where the link *didn't* come up.  If
> > the link comes up nicely without retry, we won't call
> > dw_pcie_setup_rc() and hence won't call dw_pcie_msi_init().
> 
> The v1 version patch was sent before commit 275e88b06a (PCI: tegra: Fix host
> link initialization"). At that time, the resume path looks like this:
> 
> tegra_pcie_dw_resume_noirq
>   tegra_pcie_dw_host_init
>     tegra_pcie_prepare_host
>       dw_pcie_setup_rc
> 
> so after patch, dw_pcie_msi_init() will be called. But now it seems that
> the tegra version needs one more fix for the resume.
> 
> So could I sent a new patch to update the commit-msg a bit?

This patch only touches the dwc core, and the commit log says
generically that it fixes MSI after resume, so one could assume that
it applies to all dwc-based drivers.  But I don't think it's that
simple, so I'd like to know *which* drivers are fixed and which
commits are related.  I don't see how 59fbab1ae40e breaks anything
except tegra.

> > Since then, exynos added a resume function.  My guess is MSI never
> > worked after resume for dra7xx, exynos, imx6, and intel-gw because
> > they don't call dw_pcie_msi_init() in their resume functions.
> > 
> > This patch looks like it should fix MSI after resume for exynos, imx6,
> > and intel-gw because they *do* call dw_pcie_setup_rc() from their
> > resume functions [2], and after this patch, dw_pcie_msi_init() will be
> > called from there.
> > 
> > I suspect MSI after resume still doesn't work on dra7xx.
> 
> I checked the dra7xx history, I'm afraid that the resume never works
> from the beginning if the host lost power during suspend, I guess the
> platform never power off the host but only the phy?

Sounds like that would make sense.

> > [1] git grep -A20 -e "static.*resume_noirq" 59fbab1ae40e^:drivers/pci/controller/dwc
> > [2] git grep -A20 -e "static.*resume_noirq" drivers/pci/controller/dwc
> > 
> > > Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > > Since v1:
> > >  - collect Reviewed-by tag
> > >
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 7e55b2b66182..e6c274f4485c 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -400,7 +400,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >       }
> > >
> > >       dw_pcie_setup_rc(pp);
> > > -     dw_pcie_msi_init(pp);
> > >
> > >       if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
> > >               ret = pci->ops->start_link(pci);
> > > @@ -551,6 +550,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> > >               }
> > >       }
> > >
> > > +     dw_pcie_msi_init(pp);
> > > +
> > >       /* Setup RC BARs */
> > >       dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
> > >       dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> > > --
> > > 2.30.1
> > >  
> 

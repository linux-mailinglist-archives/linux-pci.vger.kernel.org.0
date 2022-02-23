Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857E4C11C6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiBWLq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 06:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiBWLq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 06:46:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0621598F67;
        Wed, 23 Feb 2022 03:46:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5235106F;
        Wed, 23 Feb 2022 03:46:28 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84113F70D;
        Wed, 23 Feb 2022 03:46:27 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:46:22 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Message-ID: <20220223114622.GA27645@lpieralisi>
References: <20211226074019.2556-1-jszhang@kernel.org>
 <Ye1D4lYAIpDe7qAN@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye1D4lYAIpDe7qAN@xhacker>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 23, 2022 at 08:02:42PM +0800, Jisheng Zhang wrote:
> On Sun, Dec 26, 2021 at 03:40:19PM +0800, Jisheng Zhang wrote:
> > If the host which makes use of the IP's integrated MSI Receiver losts
> > power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> > dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> > register is always set as 0xffffffff incorrectly, thus the MSI can't
> > work after resume.
> > 
> > Fix this issue by moving pp->irq_mask[ctrl] initialization to
> > dw_pcie_host_init(), so we can correctly set the mask reg during both
> > boot and resume.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Hi all,
> 
> This patch can still be applied to the latest linus tree. Do you want
> me to rebase and send out a new version?
> 
> Without this patch, dwc host MSI interrupt(if use the IP's integrated
> MSI receiver) can't work after resume. Could it be picked up as a fix
> for v5.17?

The tricky bit with this patch is that it is not clear what piece of
logic is lost on power down and what not. IIUC MSI interrupt controller
logic is kept so it does not need to be saved/restored (but in
dw_pcie_setup_rc() we overwrite PCIE_MSI_INTR0_ENABLE even if it
is not needed on resume - actually, it can even be destructive).

Maybe we need to write suspend/resume hooks for the dwc core instead
of moving code around to fix these bugs ?

Lorenzo

> 
> Thanks
> 
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index f4755f3a03be..2fa86f32d964 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -362,6 +362,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  			if (ret < 0)
> >  				return ret;
> >  		} else if (pp->has_msi_ctrl) {
> > +			u32 ctrl, num_ctrls;
> > +
> > +			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> > +			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> > +				pp->irq_mask[ctrl] = ~0;
> > +
> >  			if (!pp->msi_irq) {
> >  				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
> >  				if (pp->msi_irq < 0) {
> > @@ -541,7 +547,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >  
> >  		/* Initialize IRQ Status array */
> >  		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> > -			pp->irq_mask[ctrl] = ~0;
> >  			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
> >  					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> >  					    pp->irq_mask[ctrl]);
> > -- 
> > 2.34.1
> > 

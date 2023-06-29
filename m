Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C6742F28
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjF2U6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 16:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjF2U6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 16:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF87194;
        Thu, 29 Jun 2023 13:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5534461607;
        Thu, 29 Jun 2023 20:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41822C433C8;
        Thu, 29 Jun 2023 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688072317;
        bh=2Nwtj5k0YiKQNrwtJVT8Z9Q1j8JiGc2hAUmkebXyjWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fk5ZDAvpL4JZehX1dXHRwCHx88y8mvLU4oiyHEPJ45V+XSXLcXi1W/3TE+XVoROwz
         djg9DgPc6T6fpVyK0J8fu62p2BvqKgKIzPq9J/aaAT5OvLSbbkDlCWuR2s4URV4C4G
         AG3+44XJvOZtfs1Wmb0Fp0MdARWLpMVAzaogk5oLVRFShMXzKaeEnYERX5qaV0CyKX
         GDI+S2uN0vC5X2Z21+0VWneB1kP+pHmP45XK7Rzq839RPUwhExYwi3LB8cJtgCQ8dH
         SDZBi4o1c+vX+moDsN5tJWQa8zYSmbp0ODJ0Xnh3K3Gap6n1Q6BJyczbJ5ylWmYcpi
         k9eFofyiHfmYA==
Date:   Thu, 29 Jun 2023 15:58:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
Message-ID: <20230629205830.GA447734@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <425880de38770e059ae4734fc72d6cdc77bf1870.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 04:42:07PM -0400, Radu Rendec wrote:
> On Thu, 2023-06-29 at 14:57 -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 29, 2023 at 02:30:19PM -0400, Radu Rendec wrote:
> > > The DesignWare PCIe host driver uses a chained interrupt to demultiplex
> > > the downstream MSI interrupts. On Qualcomm SA8540P Ride, enabling both
> > > pcie2a and pcie3a at the same time can create an interrupt storm where
> > > the parent interrupt fires continuously, even though reading the PCIe
> > > host registers doesn't identify any child MSI interrupt source. This
> > > effectively locks up CPU0, which spends all the time servicing these
> > > interrupts.
> > > 
> > > This is a clear example of how bypassing the interrupt core by using
> > > chained interrupts can be very dangerous if the hardware misbehaves.
> > > 
> > > Convert the driver to use a regular interrupt for the demultiplex
> > > handler. This allows the interrupt storm detector to detect the faulty
> > > interrupt and disable it, allowing the system to run normally.
> > 
> > There are many other users of irq_set_chained_handler_and_data() in
> > drivers/pci/controller/.  Should they be similarly converted?  If not,
> > how do we decide which need to use irq_set_chained_handler_and_data()
> > and which do not?
> 
> According to Thomas Gleixner, yes. Obviously I don't want to put words
> in his mouth, but I think that's the gist of what he said in a reply to
> an RFC patch that I sent a few weeks ago:
> https://lore.kernel.org/all/877csohcll.ffs@tglx/

Is it's a bug in pcie-designware-host.c, and it's also a bug in the
other callers, we should fix them all.

But you do imply that there's some DesignWare hardware issue involved,
too, so I guess it's possible the other drivers don't have an issue
and/or actually require the chained IRQs.  That's why I asked how we
should decide.

> > > -static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > > +static void __dw_pcie_free_msi(struct dw_pcie_rp *pp, u32 num_ctrls)
> > >  {
> > >         u32 ctrl;
> > >  
> > > -       for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> > > +       for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> > >                 if (pp->msi_irq[ctrl] > 0)
> > > -                       irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> > > -                                                        NULL, NULL);
> > > +                       free_irq(pp->msi_irq[ctrl], pp);
> > >         }
> > >  
> > >         irq_domain_remove(pp->msi_domain);
> > >         irq_domain_remove(pp->irq_domain);
> > >  }
> > >  
> > > +#define dw_pcie_free_msi(pp) __dw_pcie_free_msi(pp, MAX_MSI_CTRLS)
> > 
> > What is the benefit of the dw_pcie_free_msi() macro?
> 
> It allows me to add the num_ctrls parameter to the corresponding
> function (now renamed to __dw_pcie_free_msi()) without forcing all the
> existing call sites to send MAX_MSI_CTRLS explicitly.
> 
> I needed that extra parameter to avoid duplicating the tear down code
> on the (new) error path in dw_pcie_msi_init() - see below.
> 
> > >  static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> > >  {
> > >         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > @@ -361,9 +353,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >                 return ret;
> > >  
> > >         for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> > > -               if (pp->msi_irq[ctrl] > 0)
> > > -                       irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> > > -                                                   dw_chained_msi_isr, pp);
> > > +               if (pp->msi_irq[ctrl] > 0) {
> > > +                       ret = request_irq(pp->msi_irq[ctrl], dw_pcie_msi_isr, 0,
> > > +                                         dev_name(dev), pp);
> > > +                       if (ret) {
> > > +                               dev_err(dev, "Failed to request irq %d: %d\n",
> > > +                                       pp->msi_irq[ctrl], ret);
> > > +                               __dw_pcie_free_msi(pp, ctrl);
> 
> This is where I'm using the extra parameter. If we fail to request an
> interrupt, we need to free all the other interrupts that we have
> requested so far, to leave everything in a clean state. But we can't
> use MAX_MSI_CTRLS with __dw_pcie_free_msi() and rely on the check there
> because there may be extra interrupts that we haven't requested *yet*
> and we would attempt to free them.

Makes sense, thanks.

Bjorn

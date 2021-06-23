Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2883B1A27
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhFWMai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 08:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhFWMaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 08:30:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F56E6108E;
        Wed, 23 Jun 2021 12:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624451269;
        bh=HAVJtTVrzJxFsKJDIJrqeHQYANllpN93YiRxUl5ea+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r9uTZTY8L+cxqEC0D/c6wq3MQRcaWXF8v7sEiOA9xiQU3ruHwYZWlEDOtHm13UOCz
         19cSGVM+U+wIUWMw5KNz4JLBEaiSgi/jXU+Qd5dWM1Ju2o71bNZJQ26eFpUw9efCdc
         cDzo49YNoThQnCPYFjdZQZ/JCIX4YErETCp93OnjO7RAI11/xLR0fa1tV9LGQ+4ZKJ
         eamWbxN4iYGqMN5auJNmXQR4quHCm1r/VbRVKMuIPEdOIBddH0lftIrAGFkY1dzORL
         8Z0h2MVg7se6DDADGr3tGAgbWUcsP5cg1AKfqAxSCpXjsVT6OuEuSkYL1Wm5RvhI0t
         mmwuRI1fQgjIg==
Date:   Wed, 23 Jun 2021 07:27:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Tian Tao <tiantao6@hisilicon.com>,
        p.zabel@pengutronix.de, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        tglx@linutronix.de, maz@kernel.org
Subject: Re: [PATCH v2] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <20210623122747.GA3357115@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210623094519.GA11297@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 23, 2021 at 10:45:19AM +0100, Lorenzo Pieralisi wrote:
> [+Marc, Thomas]
> 
> thread: https://lore.kernel.org/linux-pci/1621213953-54030-1-git-send-email-tiantao6@hisilicon.com
> 
> On Mon, May 31, 2021 at 03:32:33PM +0530, Vidya Sagar wrote:
> > I want to re-examine this patch.
> > I don't see any references in the kernel where IRQ_NOAUTOEN is passed
> > directly in request_irq APIs.
> 
> AFAICS there are many references, not sure what you actually checked.
> 
> > It is always set explicitly through irq_set_status_flags() *before*
> > calling request_irq APIs.  I don't see any comment in the header file
> > either that says something like it should always be set before
> > requesting the irq.  Lorenzo/Bjorn, could you please throw some light
> > on what is correct thing to do here?
> 
> To be honest I don't know. Certainly Marc and Thomas know if they have
> a minute to chime in.

I don't know either.  If this *is* the right thing to do it needs a
much better commit log because this is not merely a simplification
that can be verified with a couple minutes of code reading.

This is the only use of IRQ_NOAUTOEN in drivers/pci/, which itself
raises the question of why we need it.

Also, please update the subject line to s/tegra/tegra194/ and start
with a capital letter to match convention.

> > On 5/17/2021 3:47 PM, Vidya Sagar wrote:
> > > Thanks for the patch.
> > > 
> > > Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> > > 
> > > - Vidya Sagar
> > > 
> > > On 5/17/2021 6:42 AM, Tian Tao wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > request_irq() after setting IRQ_NOAUTOEN as below
> > > > irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > > request_irq(dev, irq...);
> > > > can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
> > > > 
> > > > this change is just to simplify the code, no actual functional changes.
> > > > 
> > > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > > ---
> > > > 
> > > > v2: update the commit message.
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
> > > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > index bafd2c6..7349926 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > @@ -2021,14 +2021,13 @@ static int tegra_pcie_config_ep(struct
> > > > tegra_pcie_dw *pcie,
> > > >                  return -ENOMEM;
> > > >          }
> > > > 
> > > > -       irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
> > > > -
> > > >          pcie->ep_state = EP_STATE_DISABLED;
> > > > 
> > > >          ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
> > > >                                          tegra_pcie_ep_pex_rst_irq,
> > > >                                          IRQF_TRIGGER_RISING |
> > > > -                                       IRQF_TRIGGER_FALLING |
> > > > IRQF_ONESHOT,
> > > > +                                       IRQF_TRIGGER_FALLING |
> > > > +                                       IRQF_ONESHOT | IRQF_NO_AUTOEN
> > > >                                          name, (void *)pcie);
> > > >          if (ret < 0) {
> > > >                  dev_err(dev, "Failed to request IRQ for PERST:
> > > > %d\n", ret);
> > > > -- 
> > > > 2.7.4
> > > > 

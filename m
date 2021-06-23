Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671CF3B1723
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFWJrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 05:47:43 -0400
Received: from foss.arm.com ([217.140.110.172]:60902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJrn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 05:47:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2618D31B;
        Wed, 23 Jun 2021 02:45:26 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18E63F719;
        Wed, 23 Jun 2021 02:45:24 -0700 (PDT)
Date:   Wed, 23 Jun 2021 10:45:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, tglx@linutronix.de, maz@kernel.org
Subject: Re: [PATCH v2] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <20210623094519.GA11297@lpieralisi>
References: <1621213953-54030-1-git-send-email-tiantao6@hisilicon.com>
 <7e203ed5-526f-3a45-9f82-ba3f567bcc83@nvidia.com>
 <78dd0d27-aca7-9d99-a79d-8587a2fbbbfb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78dd0d27-aca7-9d99-a79d-8587a2fbbbfb@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Marc, Thomas]

thread: https://lore.kernel.org/linux-pci/1621213953-54030-1-git-send-email-tiantao6@hisilicon.com

On Mon, May 31, 2021 at 03:32:33PM +0530, Vidya Sagar wrote:
> I want to re-examine this patch.
> I don't see any references in the kernel where IRQ_NOAUTOEN is passed
> directly in request_irq APIs.

AFAICS there are many references, not sure what you actually checked.

> It is always set explicitly through irq_set_status_flags() *before*
> calling request_irq APIs.  I don't see any comment in the header file
> either that says something like it should always be set before
> requesting the irq.  Lorenzo/Bjorn, could you please throw some light
> on what is correct thing to do here?

To be honest I don't know. Certainly Marc and Thomas know if they have
a minute to chime in.

Lorenzo

> Thanks,
> Vidya Sagar
> 
> 
> On 5/17/2021 3:47 PM, Vidya Sagar wrote:
> > Thanks for the patch.
> > 
> > Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> > 
> > - Vidya Sagar
> > 
> > On 5/17/2021 6:42 AM, Tian Tao wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > request_irq() after setting IRQ_NOAUTOEN as below
> > > irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > request_irq(dev, irq...);
> > > can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
> > > 
> > > this change is just to simplify the code, no actual functional changes.
> > > 
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > ---
> > > 
> > > v2: update the commit message.
> > > ---
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index bafd2c6..7349926 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -2021,14 +2021,13 @@ static int tegra_pcie_config_ep(struct
> > > tegra_pcie_dw *pcie,
> > >                  return -ENOMEM;
> > >          }
> > > 
> > > -       irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
> > > -
> > >          pcie->ep_state = EP_STATE_DISABLED;
> > > 
> > >          ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
> > >                                          tegra_pcie_ep_pex_rst_irq,
> > >                                          IRQF_TRIGGER_RISING |
> > > -                                       IRQF_TRIGGER_FALLING |
> > > IRQF_ONESHOT,
> > > +                                       IRQF_TRIGGER_FALLING |
> > > +                                       IRQF_ONESHOT | IRQF_NO_AUTOEN
> > >                                          name, (void *)pcie);
> > >          if (ret < 0) {
> > >                  dev_err(dev, "Failed to request IRQ for PERST:
> > > %d\n", ret);
> > > -- 
> > > 2.7.4
> > > 

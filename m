Return-Path: <linux-pci+bounces-22765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42BA4C501
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76218161332
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D822ACEE;
	Mon,  3 Mar 2025 15:23:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1E22ACDF;
	Mon,  3 Mar 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015408; cv=none; b=ZWTKm25nRUtuufW8W/awbcgdsQouQ9U3IaWQcZDIN/gRqogJ3u6Qr/1bT5ahLt9GpNVhYCeFd6s6jDRcWyd7dJqrYHkZLrEzg3Zq8PAq+MpE3mIljyUdEvuPJT60ikqvgDFgzxYtvxDeWK9gTfSiPULQOGJ3Rsc+/njhmzRZmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015408; c=relaxed/simple;
	bh=x5ZHe8cKEP3sixIJgobVE8Ykce9dwCRJsbW2wPTTBm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ0kV7OfnKQ7sYlo0/z0kl54QFrlFgpBep8gTftaMWZAKxvdXaIne8D/+oh/L7VSy77fK6FQj/lNSgT37oWUl+A8IgiwA67kztfp05xUC7Ui1aJtLHekU3x4I3Sf9nbEEtv7OBylMAPZTxYbVUVEX8XRLAnOMt3UA4J7S3tIw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B6C4CEEB;
	Mon,  3 Mar 2025 15:23:24 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:53:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
Message-ID: <20250303152319.ejtt4vhlxkkzfx7h@thinkpad>
References: <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad>
 <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
 <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>
 <20250224080129.zm7fvxermgeyycav@thinkpad>
 <CANAwSgTsp19ri5SYYtD+VOYgBLYg5UqvGRrtNTXOWw7umxGCQg@mail.gmail.com>
 <20250224115452.micfqctwjkt6gwrs@thinkpad>
 <CANAwSgSdEr0X0F1AFAUfJoEjT1a63nj5Ar-ZfmehfhnE0=v+CA@mail.gmail.com>
 <20250224144155.omzrmls7hpjqw6yl@thinkpad>
 <CANAwSgQFET-vWoOSSMFWs3LZeQMaP+VgU6o2_1Rro6NmGXQbVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgQFET-vWoOSSMFWs3LZeQMaP+VgU6o2_1Rro6NmGXQbVQ@mail.gmail.com>

On Mon, Feb 24, 2025 at 09:37:14PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> On Mon, 24 Feb 2025 at 20:12, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Mon, Feb 24, 2025 at 07:33:37PM +0530, Anand Moon wrote:
> > > Hi Manivannan
> > >
> > > On Mon, 24 Feb 2025 at 17:24, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 03:38:29PM +0530, Anand Moon wrote:
> > > > > Hi Manivannan
> > > > >
> > > > > On Mon, 24 Feb 2025 at 13:31, Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > Following the change fix this warning in a kernel memory leak.
> > > > > > > Would you happen to have any comments on these changes?
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > > b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > > index 4153214ca410..5a72a5a33074 100644
> > > > > > > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > > @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
> > > > > > >         return events;
> > > > > > >  }
> > > > > > >
> > > > > > > -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> > > > > > > -{
> > > > > > > -       return IRQ_HANDLED;
> > > > > > > -}
> > > > > > > -
> > > > > > >  static void plda_handle_event(struct irq_desc *desc)
> > > > > > >  {
> > > > > > >         struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
> > > > > > > @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_device *pdev,
> > > > > > >
> > > > > > >                 if (event->request_event_irq)
> > > > > > >                         ret = event->request_event_irq(port, event_irq, i);
> > > > > > > -               else
> > > > > > > -                       ret = devm_request_irq(dev, event_irq,
> > > > > > > -                                              plda_event_handler,
> > > > > > > -                                              0, NULL, port);
> > > > > >
> > > > > > This change is not related to the memleak. But I'd like to have it in a separate
> > > > > > patch since this code is absolutely not required, rather pointless.
> > > > > >
> > > > > Yes, remove these changes to fix the memory leak issue I observed.
> > > > >
> > > >
> > > > Sorry, I don't get you. This specific code change of removing 'devm_request_irq'
> > > > is not supposed to fix memleak.
> > > >
> > > > If you are seeing the memleak getting fixed because of it, then something is
> > > > wrong with the irq implementation. You need to figure it out.
> > >
> > > Declaring request_event_irq in the host controller facilitates the
> > > creation of a dedicated IRQ event handler.
> > > In its absence, a dummy devm_request_irq was employed, but this
> > > resulted in unhandled IRQs and subsequent memory leaks.
> >
> > What do you mean by 'unhandled IRQs'? There is a dummy IRQ handler invoked to
> > handle these IRQs. Even your starfive_event_handler() that you proposed was
> > doing the same thing.
> >
> Yes, but my solution was to work around
> 

Which is what I'm trying to avoid....

> > > Eliminating the dummy code eliminated the memory leak logs.
> >
> From the code, we are creating a mapping of the IRQ event
> 
>      for_each_set_bit(i, &port->events_bitmap, port->num_events) {
>                 event_irq = irq_create_mapping(port->event_domain, i);
>                 if (!event_irq) {
>                         dev_err(dev, "failed to map hwirq %d\n", i);
>                         return -ENXIO;
>                 }
> 
>                 if (event->request_event_irq)
>                         ret = event->request_event_irq(port,
> event_irq, i);   <---
>                 else
>                         ret = devm_request_irq(dev, event_irq,
>                                                plda_event_handler,
>                                                0, NULL, port);
> 
>                 if (ret) {
>                         dev_err(dev, "failed to request IRQ %d\n", event_irq);
>                         return ret;
>                 }
>         }
> 
> in the microchip PCIe host we are requesting those IRQ events mapping.
> 
> static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
>                                 int event)
> {
>         return devm_request_irq(plda->dev, event_irq, mc_event_handler,
>                                 0, event_cause[event].sym, plda);
> }
> 
> static const struct plda_event_ops mc_event_ops = {
>         .get_events = mc_get_events,
> };
> 
> static const struct plda_event mc_event = {
>         .request_event_irq = mc_request_event_irq,
>         .intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
>         .msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
> };
> 
> > Sorry, this is not a valid justification. But as I said before, the change
> > itself (removing the dummy irq handler and related code) looks good to me as I
> > see no need for that. But I cannot accept it as a fix for the memleak.
> 
> The StarFive PCIe host lacks the necessary hardware event mapping.
> Consequently, the system attempts to handle dummy events, resulting
> in observed log messages.
> 
> The issue is likely due to devm_request_irq being called with a NULL devname,
> preventing proper IRQ mapping.
> 

Then please fix the offending devm_request_irq() call. Do not workaround the
issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


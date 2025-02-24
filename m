Return-Path: <linux-pci+bounces-22212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E9A423DD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E3A18918E1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18861C6FE5;
	Mon, 24 Feb 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjd90I9/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E938DD8;
	Mon, 24 Feb 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408122; cv=none; b=XCHQBJGvGZIwf+UFHt43LCJ8KRkHcnsc/dgWP71k5bVRki79A9HlocCy7FzTY82l00GzBoj3SKc/B3aID1SlLWpEGwaRkAWB6v3iCEmYGRWcILj+rY/2Zgs6R9MIQV6DyBYYhUhFNx4YVXrZhX0JlWz1c2F4/fm9XWLZ5z6ROWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408122; c=relaxed/simple;
	bh=C82abNrH3ZcypYfQQ4nCqd4+THVXdsD+JjQgHjKZk+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhuqB8hsvGuW5vnSuGnhmiGaDxKUDUW6zYqhQunm+kmxam1rWKHQj1RomWRKy7C6sZ41mjo+g9zovMsxMbIy04lM9hSpRiodepUdpudb7ey6aFm7IHXffyaZ1GN5YPQsuIFi5NthLE4UwKetr6RY4TLDeluGlwNdmjkfQzI9vHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjd90I9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB43C4CEE8;
	Mon, 24 Feb 2025 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740408122;
	bh=C82abNrH3ZcypYfQQ4nCqd4+THVXdsD+JjQgHjKZk+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjd90I9/+wL8z2KK+BOjI9NRv5U8HB+KR3n65ZXqDM5qGx/Rcsy5rrXI7JtVb7r0h
	 Fhmn7H6CtBCqBolOyRpzoZobWV1lZj+0zS2y+eULpllbYd6k5wXtCLI2h5iZIm0yKE
	 PijRg7ZpUCUnO1n2jhb0kpWI4Y4ScVWaNMPw+yBvlFLuCWNWdmPIkmWHeRBxKijDG6
	 +Tdi7Wyjt6k0JhhQUSd66kOsW2EMb7PUwZONeY9bos6MJXjrfZCC4LRbMXmMOmCHlX
	 +38k9pEld41DUDfDsJSXwvTDRDzgIufun8/DHpJ9kwTizCji6zV+RG/F4mcqe3kVMG
	 a3ofzWT4ovxQw==
Date: Mon, 24 Feb 2025 20:11:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20250224144155.omzrmls7hpjqw6yl@thinkpad>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
 <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad>
 <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
 <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>
 <20250224080129.zm7fvxermgeyycav@thinkpad>
 <CANAwSgTsp19ri5SYYtD+VOYgBLYg5UqvGRrtNTXOWw7umxGCQg@mail.gmail.com>
 <20250224115452.micfqctwjkt6gwrs@thinkpad>
 <CANAwSgSdEr0X0F1AFAUfJoEjT1a63nj5Ar-ZfmehfhnE0=v+CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSdEr0X0F1AFAUfJoEjT1a63nj5Ar-ZfmehfhnE0=v+CA@mail.gmail.com>

On Mon, Feb 24, 2025 at 07:33:37PM +0530, Anand Moon wrote:
> Hi Manivannan
> 
> On Mon, 24 Feb 2025 at 17:24, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Feb 24, 2025 at 03:38:29PM +0530, Anand Moon wrote:
> > > Hi Manivannan
> > >
> > > On Mon, 24 Feb 2025 at 13:31, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:
> > > >
> > > > [...]
> > > >
> > > > > Following the change fix this warning in a kernel memory leak.
> > > > > Would you happen to have any comments on these changes?
> > > > >
> > > > > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > index 4153214ca410..5a72a5a33074 100644
> > > > > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
> > > > >         return events;
> > > > >  }
> > > > >
> > > > > -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> > > > > -{
> > > > > -       return IRQ_HANDLED;
> > > > > -}
> > > > > -
> > > > >  static void plda_handle_event(struct irq_desc *desc)
> > > > >  {
> > > > >         struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
> > > > > @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_device *pdev,
> > > > >
> > > > >                 if (event->request_event_irq)
> > > > >                         ret = event->request_event_irq(port, event_irq, i);
> > > > > -               else
> > > > > -                       ret = devm_request_irq(dev, event_irq,
> > > > > -                                              plda_event_handler,
> > > > > -                                              0, NULL, port);
> > > >
> > > > This change is not related to the memleak. But I'd like to have it in a separate
> > > > patch since this code is absolutely not required, rather pointless.
> > > >
> > > Yes, remove these changes to fix the memory leak issue I observed.
> > >
> >
> > Sorry, I don't get you. This specific code change of removing 'devm_request_irq'
> > is not supposed to fix memleak.
> >
> > If you are seeing the memleak getting fixed because of it, then something is
> > wrong with the irq implementation. You need to figure it out.
> 
> Declaring request_event_irq in the host controller facilitates the
> creation of a dedicated IRQ event handler.
> In its absence, a dummy devm_request_irq was employed, but this
> resulted in unhandled IRQs and subsequent memory leaks.

What do you mean by 'unhandled IRQs'? There is a dummy IRQ handler invoked to
handle these IRQs. Even your starfive_event_handler() that you proposed was
doing the same thing.

> Eliminating the dummy code eliminated the memory leak logs.

Sorry, this is not a valid justification. But as I said before, the change
itself (removing the dummy irq handler and related code) looks good to me as I
see no need for that. But I cannot accept it as a fix for the memleak.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


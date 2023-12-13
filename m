Return-Path: <linux-pci+bounces-852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A14810DAE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BEB1C20955
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0CC2111F;
	Wed, 13 Dec 2023 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNqiqIuu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06E20B09;
	Wed, 13 Dec 2023 09:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C46C433C7;
	Wed, 13 Dec 2023 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702461031;
	bh=7DWDqmvfQ6nJsElv9hLPoTLEDMdZHlAdcpM0hp4Wl3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNqiqIuuG60sCKBzvWTT6UwePqHRX79kUeOw+oj7LuGFMAiuVRtA+yNaDyfRKB7SK
	 yUh0v0GOfQ3ZbwlNQjEcsGbRWLiD3Apj3UHLfrh0CqMx6qtPN5eG+WQ8R8FIhJW2qg
	 k0l5yQ9Lq/rPQ3cey6Z0ssPoaMp7e27byTaJfVO2ejX+K/xnOcf4walGzRbKtPT8UN
	 Q7eL53y3p3Hp9rXQ09Wod3nliL1fp8BxaWYNm60bn1WahzbVZWBPCXq6/hm9jhFSHO
	 iwX3rspvFyRciMQ5965HSfknOzuNLuP5ZuraONnCc8dkvIFFVfuXx01tLu30T4N8JA
	 LV6Gt9N/rOG4Q==
Date: Wed, 13 Dec 2023 10:50:23 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v12 15/21] PCI: microchip: Add event IRQ domain ops to
 struct plda_event
Message-ID: <ZXl+XxNRpKg170ZH@lpieralisi>
References: <20231206105839.25805-1-minda.chen@starfivetech.com>
 <20231206105839.25805-16-minda.chen@starfivetech.com>
 <ZXhB1kKpElgKx8vm@lpieralisi>
 <9523aa6b-55a8-4e6a-a3ba-45d9b1dacc77@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9523aa6b-55a8-4e6a-a3ba-45d9b1dacc77@starfivetech.com>

On Wed, Dec 13, 2023 at 04:15:39PM +0800, Minda Chen wrote:
> 
> 
> On 2023/12/12 19:19, Lorenzo Pieralisi wrote:
> > On Wed, Dec 06, 2023 at 06:58:33PM +0800, Minda Chen wrote:
> >> For lack of an MSI controller, The new added PCIe interrupts have to be
> >> added to global interrupt event field. PolarFire event domain ops can not
> >> be re-used.
> > 
> > I don't understand what this means, please explain and I will
> > add it to the commit log.
> > 
> Sorry.
> Microchip Polarfire PCIe adds 11 PCIe interrupts to PCIe global event domain.(Total 28 PCIe interrupts)
> The microchip event domain and event irqchip will handle these interrupts.
> But PLDA host contain 13 fixed PCIe interrupts. PLDA codes just process these
> 13 interrupts. Microchip the event irq codes are quite different and can't be used by PLDA codes.
> So add an event domain field support microchip and other vendor who just using the PLDA interrupts.
> >> PLDA event domain ops instances will be implemented in later patch.
> > 
> > Future patches don't exist, each commit log is a logical change
> > that must make sense on its own, I will remove this sentence.
> > 
> > Lorenzo
> 
> OK, Thanks.
> 
> >> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I am sorry folks but I still don't get what this patch is supposed
to do. To start with it looks like a preparation patch (it does
not have any net effect), that's not OK since it has to be merged
with the patches that actually apply significant changes on top
of this.

Then I need an explanation of what the problem is and what is the
code actually changing in irqdomain/irqchip specific terms.

I can't merge it as-is because I don't understand what it changes
and it is not clear by reading the commit log.

Thanks,
Lorenzo

> >> ---
> >>  drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
> >>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
> >>  2 files changed, 5 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> >> index f5e7da242aec..e6dcc572b65b 100644
> >> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> >> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> >> @@ -821,13 +821,15 @@ static const struct plda_event_ops mc_event_ops = {
> >>  };
> >>  
> >>  static const struct plda_event mc_event = {
> >> +	.domain_ops        = &mc_event_domain_ops,
> >>  	.event_ops         = &mc_event_ops,
> >>  	.request_event_irq = mc_request_event_irq,
> >>  	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
> >>  	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
> >>  };
> >>  
> >> -static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
> >> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> >> +				      const struct irq_domain_ops *ops)
> >>  {
> >>  	struct device *dev = port->dev;
> >>  	struct device_node *node = dev->of_node;
> >> @@ -941,7 +943,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> -	ret = plda_pcie_init_irq_domains(port);
> >> +	ret = plda_pcie_init_irq_domains(port, event->domain_ops);
> >>  	if (ret) {
> >>  		dev_err(dev, "failed creating IRQ domains\n");
> >>  		return ret;
> >> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> >> index df1729095952..820ea16855b5 100644
> >> --- a/drivers/pci/controller/plda/pcie-plda.h
> >> +++ b/drivers/pci/controller/plda/pcie-plda.h
> >> @@ -129,6 +129,7 @@ struct plda_pcie_rp {
> >>  };
> >>  
> >>  struct plda_event {
> >> +	const struct irq_domain_ops *domain_ops;
> >>  	const struct plda_event_ops *event_ops;
> >>  	int (*request_event_irq)(struct plda_pcie_rp *pcie,
> >>  				 int event_irq, int event);
> >> -- 
> >> 2.17.1
> >> 


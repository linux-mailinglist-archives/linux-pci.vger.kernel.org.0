Return-Path: <linux-pci+bounces-41537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A8C6BB76
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 206AD357328
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32272DC357;
	Tue, 18 Nov 2025 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDoL0hF8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA19A26E710;
	Tue, 18 Nov 2025 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501301; cv=none; b=lD0YvClKuOnaKkAxyewmWMpkxUgzhUlrbXj2ViJP2tDZHJLHkwi6YJR7C9XZeOzxwkVGR3fJle1dx/nyYSA3TgslqVjrvUFJ9OnCBD4UlUq63teCGz0Ba5bbZ3qoRIuaB6XAeudZQPOUqV4zZSRJ4AfhvwdLyMZjF41fUs5d7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501301; c=relaxed/simple;
	bh=5UEjQXutcY6Htzw86LPN2V7rK8JUwjxX9GTjRfAUJEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LM7oZ4LS936nsKv/Rk5qhCQawM6cmDah3rkyUkcBuMdcZ7Qp1iY5miPk/qq9vw+ETCRB1rZtDxBmHlJP8SXA8mrj8eD2lkWIXgKkMrsi/PenL6OXZSycZMlfRz5y5V/o4RuzEexDM8+N594KiomSNfKu553R8q+X4BW9C3FHMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDoL0hF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC496C2BC87;
	Tue, 18 Nov 2025 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763501301;
	bh=5UEjQXutcY6Htzw86LPN2V7rK8JUwjxX9GTjRfAUJEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LDoL0hF8/R17Jb4R4jcR6u6TQFpXCLUtFi+O3i3fssyxyrpALBouquyDvObHRZv3a
	 qDUx5P+X/bg2F5wTT9n6nZ/ZLUrTYhm7EKaUw1WNzJDjIn36viKneXIaeOC+qpNuWc
	 aaz5XkN8nVWfIjpdWPd5Z3KY9tQyx85+YqgFXWhfY2VXigZBp5HeiTJgg6fSlz3alg
	 /DW/8fJInl1jZNTKl1qll/BTss7TmGeRwO0ilxAc7aie/Ask9Y37rfqGdKV5V0WOx+
	 8zQTAY0AVauOIagUcHY30maVJ4hH+z7ZE0niuQbn/vqwErnE8kunm5d+ErIPZd14AH
	 K/LEhMbIKf1mA==
Date: Tue, 18 Nov 2025 15:28:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: stm32: Fix LTSSM EP race with start link.
Message-ID: <20251118212818.GA2591668@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dbd8f6-2efe-4a73-a611-9081f364d2d4@foss.st.com>

[+cc Lukas in case I got the pciehp part wrong]

On Tue, Nov 18, 2025 at 07:34:01PM +0100, Christian Bruel wrote:
> On 11/17/25 21:00, Bjorn Helgaas wrote:
> > On Mon, Nov 17, 2025 at 01:04:47PM +0100, Christian Bruel wrote:
> > > On 11/14/25 19:59, Bjorn Helgaas wrote:
> > > > On Fri, Nov 14, 2025 at 08:45:52AM +0100, Christian Bruel wrote:
> > > > > If the host has deasserted PERST# and started link training
> > > > > before the link is started on EP side, enabling LTSSM before
> > > > > the endpoint registers are initialized in the perst_irq
> > > > > handler results in probing incorrect values.
> > > > > 
> > > > > Thus, wait for the PERST# level-triggered interrupt to start
> > > > > link training at the end of initialization and cleanup the
> > > > > stm32_pcie_[start stop]_link functions.

To back up here, I'm trying to understand the race.

IIUC the relevant events are link training and register init.  In the
current stm32 EP driver, link training can start when the EP userspace
writes to the 'start' configfs file.  And the register init happens
when stm32_pcie_ep_perst_irq_thread() calls
dw_pcie_ep_init_registers().

So I guess the problem is when the EP userspace enables the LTSSM
before the host deasserts PERST#?  And the link train may complete
before stm32_pcie_ep_perst_irq_thread() runs?

And the fix here is to delay enabling the EP LTSSM until after
stm32_pcie_perst_deassert() calls dw_pcie_ep_init_registers()?

> > > > I've seen this kind of thing in other drivers, and I wondered
> > > > whether it was safe because the host asserts and deasserts
> > > > PERST# asynchronously, independent of anything the endpoint is
> > > > doing.
> > > > 
> > > > I assume it's possible that the host deasserts PERST# before
> > > > this driver has the stm32_pcie_ep_perst_irq_thread() thread
> > > > set up.  If that happens and the driver doesn't see the PERST#
> > > > interrupt, does everything still work correctly?
> > > 
> > > yes it does. the PERST# interrupt is level-triggered and, if
> > > already de-asserted, fires only when enabled (it is NOAUTOEN)
> > > with start_link.
> > > 
> > > At that point, the host can enumerate by performing a manual
> > > rescan or rebind the PCIe driver, restarting the entire probe
> > > sequence.
> > > 
> > > Tested the pcie_epf_test driver with various power-up sequences:
> > > full power-up the host or device first, and stop or standby PM
> > > suspend/resume.
> > 
> > Help me think through this.  I guess the interesting case is when
> > the host boots first and enumerates devices before the stm32
> > endpoint is ready, right?
> > 
> > I suppose the endpoint LTSSM is initially disabled, so the link is
> > down, and the host enumeration didn't find anything?
> 
> yes. When the device is not started (start_link)
> dw_pcie_wait_for_link() fails and pci_host_probe() only register the
> root port:
> 
>         /*
>          * Note: Skip the link up delay only when a Link Up IRQ is present.
>          * If there is no Link Up IRQ, we should not bypass the delay
>          * because that would require users to manually rescan for devices.
>          */
>         if (!pp->use_linkup_irq)
>                 /* Ignore errors, the link may come up later */
>                 dw_pcie_wait_for_link(pci);
> 
>        ret = pci_host_probe(bridge);
> 
> > Where does the link come up?  I see the pci_epc_start_store() that
> > eventually leads to stm32_pcie_start_link(), which enables perst_irq.
> 
> The link appears when explicitly requested by writing '1' into the bound
> endpoint device driver sysfs 'start' once the device is configured.
> 
> see https://www.kernel.org/doc/html/latest/PCI/endpoint/pci-test-howto.html
> 
> But how pci_epc_start_store() is iterated from the configfs_write_iter()
> mechanism is beyond my knowledge...

OK.  I just wanted to learn whether this was all automatic or required
user intervention.

IIUC it's never completely automatic because even if the endpoint
boots first, the endpoint LTSSM isn't enabled and the link won't train
until userspace on the endpoint writes '1' into the 'start' configfs
file.

> > Since you requested perst_irq with IRQF_TRIGGER_HIGH, and PERST#
> > is deasserted, does that trigger stm32_pcie_ep_perst_irq_thread()
> > and call stm32_pcie_perst_deassert() to enable the LTSSM?
> 
> perst_gpio is active low. So requesting the perst_irq with
> IRQF_TRIGGER_HIGH triggers when deasserted.
> 
> This part is quite confusing (for me) because gpiod_get_value()
> correctly returns 0 when the gpio is de-asserted, when the irq API
> does not know about active low so we must use TRIGGER_HIGH
> 
> > When the link comes up, if the Downstream Port supports hotplug
> > and pciehp is enabled, it might notice the link-up event and treat
> > this as a hot-add?
> 
> yes, I just tried with a host pc with hot-plug enabled. lspci found
> the stm32 EP, as you anticipated
> 
> > Otherwise the user would have to manually rescan to notice the
> > endpoint?
> 
> indeed, this is how I proceed when the host does not support
> hot-plug,

I think we would prefer if the host would enumerate the endpoint
whenever the endpoint becomes ready, even if that is after the host's
initial enumeration, but I guess that's only possible if the host is
notified when the link comes up.

The main mechanism for that is hotplug, i.e., pciehp handles presence
detect and link layer state changed events, both of which are managed
by the PCIe Slot register set.  Those registers are optional and may
not be implemented, e.g., if a Root Port is connected to a
system-integrated device.

But if they *are* implemented, I hope that pciehp makes it so no user
intervention on the host side is required.

> > > > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-stm32-ep.c | 38 ++++++------------------------
> > > > >    1 file changed, 7 insertions(+), 31 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> > > > > index 3400c7cd2d88a279c49ef36a99fc7537c381c384..d0654bb43759bb8d0f0d7badbf7bdae839241fcf 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> > > > > @@ -37,36 +37,9 @@ static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
> > > > >    		dw_pcie_ep_reset_bar(pci, bar);
> > > > >    }
> > > > > -static int stm32_pcie_enable_link(struct dw_pcie *pci)
> > > > > -{
> > > > > -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > > > -
> > > > > -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > > > -			   STM32MP25_PCIECR_LTSSM_EN,
> > > > > -			   STM32MP25_PCIECR_LTSSM_EN);
> > > > > -
> > > > > -	return dw_pcie_wait_for_link(pci);
> > > > > -}
> > > > > -
> > > > > -static void stm32_pcie_disable_link(struct dw_pcie *pci)
> > > > > -{
> > > > > -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > > > -
> > > > > -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
> > > > > -}
> > > > > -
> > > > >    static int stm32_pcie_start_link(struct dw_pcie *pci)
> > > > >    {
> > > > >    	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > > > -	int ret;
> > > > > -
> > > > > -	dev_dbg(pci->dev, "Enable link\n");
> > > > > -
> > > > > -	ret = stm32_pcie_enable_link(pci);
> > > > > -	if (ret) {
> > > > > -		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
> > > > > -		return ret;
> > > > > -	}
> > > > >    	enable_irq(stm32_pcie->perst_irq);
> > > > > @@ -77,11 +50,7 @@ static void stm32_pcie_stop_link(struct dw_pcie *pci)
> > > > >    {
> > > > >    	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > > > -	dev_dbg(pci->dev, "Disable link\n");
> > > > > -
> > > > >    	disable_irq(stm32_pcie->perst_irq);
> > > > > -
> > > > > -	stm32_pcie_disable_link(pci);
> > > > >    }
> > > > >    static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > > > @@ -152,6 +121,8 @@ static void stm32_pcie_perst_assert(struct dw_pcie *pci)
> > > > >    	dev_dbg(dev, "PERST asserted by host\n");
> > > > > +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
> > > > > +
> > > > >    	pci_epc_deinit_notify(ep->epc);
> > > > >    	stm32_pcie_disable_resources(stm32_pcie);
> > > > > @@ -192,6 +163,11 @@ static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
> > > > >    	pci_epc_init_notify(ep->epc);
> > > > > +	/* Enable link training */
> > > > > +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > > > +			   STM32MP25_PCIECR_LTSSM_EN,
> > > > > +			   STM32MP25_PCIECR_LTSSM_EN);
> > > > > +
> > > > >    	return;
> > > > >    err_disable_resources:
> > > > > 
> > > > > ---
> > > > > base-commit: 31115ecec74fe5c679a149d7037009f26b3aa8a9
> > > > > change-id: 20251113-perst_ep-0b57b9679cf9
> > > > > 
> > > > > Best regards,
> > > > > -- 
> > > > > Christian Bruel <christian.bruel@foss.st.com>
> > > > > 
> > > 
> 


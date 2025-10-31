Return-Path: <linux-pci+bounces-39890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B764CC2350D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 07:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733844078AE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511EE2E0930;
	Fri, 31 Oct 2025 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9cQjO0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C51F4C87;
	Fri, 31 Oct 2025 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890734; cv=none; b=mxWgyuwZ4Fn9PyHaf7w0B+CWzV7CObJTZOk4nYoWLZUjkKpVEFpsXom8pJAUdgNpvUmvRVfHn1u1ZKE9YuSsZKhQedqIQtGAUS9yCkMlzxRofycOVTTfeRUQKcoOhGKT3BAKTgvzNtSvNB3BKoD7wchnwfO75C4obS3ypVWe74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890734; c=relaxed/simple;
	bh=jqQTe6N9XDY3VxuJw19Hj4Vu8BlM8rHNLPg3ljunTGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRK84H5uEnN6Va76kaDWgwpJCLzHKD1pJXUjvrKBztmYNpjRrALDsG7VjzX6HIJKDDf9iuRqPCxsLVPCovXrxM1SnKZLESn29PsBDE7RUYJHOCEHDhrIVnPP7ZIQaQN+H5wRd61I4GxjR+XzobAkFUvXq9Z3k0NcMwPYn7LxypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9cQjO0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB6DC4CEE7;
	Fri, 31 Oct 2025 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761890731;
	bh=jqQTe6N9XDY3VxuJw19Hj4Vu8BlM8rHNLPg3ljunTGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9cQjO0Jmw4u9vLPZevaClVSNrpJr5AQFpI54aDK1KXyLt4zHIfC/jytwzHh5WIKF
	 v0OaVPD6jl99AvyWrW7ExIGAti7r8gjh+2Gy//Otid7HK7+ATZICn57C1xdp14K1ze
	 4++1I4wQDWbhTi0hGhgh3AsLT0a/Y+y+xLBOPCc/0tRFFmjeZZKwJPBeBKCsov+03x
	 UUdFZooabIujv4s+6bQ6U38BVPRHtqOYfV6YmHKuZutdsj+ue1+B/1jyeUq6wm1vwg
	 EhExmioV2IzQyIjfTD/87kaKdiXHWLTOMfzARJvTXF8W/2SlyPxOKO5/w8O0IbgBSn
	 kVUZFabQyGiaw==
Date: Fri, 31 Oct 2025 11:35:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de, thippeswamy.havalige@amd.com, 
	inochiama@gmail.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
Message-ID: <546kfkmfkndae32mmculbgacuni4raqwpgmeb4xnhvsuavjl3w@3pjtpmblmril>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-6-elder@riscstar.com>
 <274772thveml3xq2yc7477b7lywzzwelbjtq3hiy4louc6cqom@o5zq66mqa27h>
 <4027609d-6396-44c0-a514-11d7fe8a5b58@riscstar.com>
 <paxtbwlvndtsmllhsdiovwqoes7aqwiltac6ah4ehrpkz554y6@uj5k3w5jxeln>
 <9bebde96-485f-4f30-b54c-be9e6c16f2d6@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bebde96-485f-4f30-b54c-be9e6c16f2d6@riscstar.com>

On Wed, Oct 29, 2025 at 07:10:10PM -0500, Alex Elder wrote:
> On 10/28/25 2:06 AM, Manivannan Sadhasivam wrote:
> > On Mon, Oct 27, 2025 at 05:24:38PM -0500, Alex Elder wrote:
> > > On 10/26/25 11:55 AM, Manivannan Sadhasivam wrote:
> > > > On Mon, Oct 13, 2025 at 10:35:22AM -0500, Alex Elder wrote:
> > > > > Introduce a driver for the PCIe host controller found in the SpacemiT
> > > > > K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
> > > > > The driver supports three PCIe ports that operate at PCIe gen2 transfer
> > > > > rates (5 GT/sec).  The first port uses a combo PHY, which may be
> > > > > configured for use for USB 3 instead.
> > > > > 
> > > > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > > > ---
> 
> . . .
> 
> > > > > +	ret = devm_regulator_get_enable(dev, "vpcie3v3-supply");
> > > > > +	if (ret)
> > > > > +		return dev_err_probe(dev, ret,
> > > > > +				     "failed to get \"vpcie3v3\" supply\n");
> > > > 
> > > > As mentioned in the bindings patch, you should rely on the PWRCTRL_SLOT driver
> > > > to handle the power supplies. It is not yet handling the PERST#, but I have a
> > > > series floating for that:
> > > > https://lore.kernel.org/linux-pci/20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com/
> > > 
> > > I think that just means that I'll define a DT node compatible with
> > > "pciclass,0604", and in that node I'll specify the vpcie3v3-supply
> > > property.  That will cause that (pwrctrl) device to get and enable
> > > the supply before the "real" PCIe device probes.
> > > 
> > 
> > Right.
> > 
> > > And once your PERST work gets merged into the PCI power control
> > > framework, a callback will allow that to assert PERST# as needed
> > > surrounding power transitions.  (But I won't worry about that
> > > for now.)
> > > 
> > 
> > I'm still nervous to say that you should not worry about it (about not
> > deasserting PERST# at the right time) as it goes against the PCIe spec.
> > Current pwrctrl platforms supporting PERST# are working fine due to sheer luck.
> > 
> > So it would be better to leave the pwrctrl driver out of the equation now and
> > enable the supply in this driver itself. Later, once my pwrctrl rework gets
> > merged, I will try to switch this driver to use it.
> 
> As I understand it, PERST# should be only be deasserted after
> all power rails are known to be stable.
> 

Yes

> This driver enables the regulator during probe, shortly
> before calling dw_pcie_host_init().  That function calls
> back to k1_pcie_init(), which enables clocks, deasserts
> resets, and initializes the PHY before it changes the
> PERST# state.
> 
> By "changing the PERST# state" I mean it is asserted
> (driven low), then deasserted after 100 milliseconds
> (PCIE_T_PVPERL_MS).
> 
> I have two questions on this:
> - You say the PCI spec talks about the "right time" to
>   deassert PERST# (relative to power).  Is that at all
>   related to PCIE_T_PVPERL_MS?

The PCI CEM spec says that PERST# should be deasserted atleast 100ms after the
power becomes stable. But with the current pwrctrl design, the host controller
deasserts the PERST# even before the pwrctrl probe. So this is in violation of
the spec. But depending on the endpoint device design, this might not cause any
issue as PERST# is a level triggered signal. So once the endpoint boots up, it
will see the PERST# deassert and will start working. I'm not justifying the
current design, but just mentioning that you might not see any issue.

That being said, we are going to submit a series that reworks pwrctrl framework
such that each controller can call an API to probe pwrctrl drivers. This way,
host controller driver can make sure that the device will get powered ON before
it deasserts the PERST#.

> - I notice that PERST# is in a deasserted state at the
>   time I assert it in this sequence.  Do you see any
>   reason I should assert it early as an initialization
>   step, or is asserting it and holding it there for
>   100 msec sufficient?
> 

You should assert PERST# before doing any controller initialization sequence as
that may affect the endpoint. Once PERST# is asserted, it will cause the
endpoint to 'reset'. So you do your initialization sequence and deassert it once
done.

> > > Is that right?
> > > 
> > > > > +
> > > > > +	/* Hold the PHY in reset until we start the link */
> > > > > +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> > > > > +			APP_HOLD_PHY_RST);
> > > > > +
> > > > > +	k1->phy = devm_phy_get(dev, NULL);
> > > > > +	if (IS_ERR(k1->phy))
> > > > > +		return dev_err_probe(dev, PTR_ERR(k1->phy),
> > > > > +				     "failed to get PHY\n");
> > > > 
> > > > Once you move these properties to Root Port binding, you need to have per-Root
> > > > Port parser. Again, you can refer the STM32 driver.
> > > 
> > > I see getting the PHY in stm32_pcie_parse_port(), but nothing
> > > about the supply (which you mentioned in the other message).
> > > 
> > 
> > To conclude, you should move forward with defining the PHY and supply properties
> > in the Root Port node, but parse/handle them in this driver itself.
> 
> Got it.
> 
> > > > > +
> > > > > +	k1->pci.dev = dev;
> > > > > +	k1->pci.ops = &k1_pcie_ops;
> > > > > +	dw_pcie_cap_set(&k1->pci, REQ_RES);
> > > > > +
> > > > > +	k1->pci.pp.ops = &k1_pcie_host_ops;
> > > > > +	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
> > > > 
> > > > This driver is just using a single 'msi' vector, which can only support 32 MSIs.
> > > > But MAX_MSI_IRQS is 256. So this looks wrong.
> > > 
> > > In dw_pcie_host_init(), if unspecified, MSI_DEF_NUM_VECTORS=32 is
> > > used for num_vectors.  If it is specified, only if the value
> > > exceeds MAX_MSI_IRQS=256 is an error returned.
> > > 
> > 
> > Yes, because the driver trusts the glue drivers to provide the num_vectors if
> > they support more than 32.
> > 
> > > In dw_handle_msi_irq(), "num_ctrls" is computed based on
> > > num_vectors / MAX_MSI_IRQS_PER_CTRL=32.  A loop then
> > > iterates over those "controllers"(?) to handle each bit
> > > set in their corresponding register.
> > > 
> > > This seems OK.  Can you explain why you think it's wrong?
> > > 
> > 
> > So both 'ctrl' and 'msi' IRQs are interrelated. Each 'ctrl' can have upto 32 MSI
> > vectors only. If your platform supports more than 32 MSI vectors, like 256, then
> > the platform DT should provide 8 'msi' IRQs.
> 
> I have asked SpacemiT about this, specifically whether there
> are additional interrupts (I don't think there are), or if
> not that, additional registers to support MSI 32+ (see
> below).  In their downstream driver they handle interrupts
> differently.  I suspect num_vectors needs to be set to 32
> (or I'll leave it unset and take the default).
> 
> 
> In the DesignWare driver, there are up to 8 "ctrls", and each
> ctrl has 32 bit positions representing 32 MSI vectors.  Each
> can have an msi_irq defined.  An msi_irq is always set up for
> ctrl 0.
> 
> For any ctrl with an msi_irq assigned, dw_pcie_msi_host_init()
> sets its interrupt handler to dw_chained_msi_isr(), which just
> calls dw_handle_msi_irq().
> 
> The way dw_handle_msi_irq() works, a single ctrl apparently can
> handle up to 256 MSI vectors, as long as the block of 3 registers
> that manage the ctrl (ENABLE, MASK, and STATUS presumably) are
> consecutive in I/O memory for consecutive ctrls.
> 

I'm not sure how you came up with this observation. dw_handle_msi_irq() loops
over the 'status' using find_next_bit() of size MAX_MSI_IRQS_PER_CTRL, which is
32. So I don't see how a single ctrl can handle up to 256 vectors.

> 
> I looked for other examples.  I see that "pcie-fu740.c", which
> supports compatible "sifive,fu740-pcie", sets num_vectors to
> MAX_MSI_IRQS, but "fu740-c000.dtsi" defines just one "msi"
> interrupt.  And "pci-dra7xx.c" seems to do something similar,
> and maybe "pcie-rcar-gen4.c" too.
> 

Yes. But I think those are mistakes. I will submit patches to fix them.

> > Currently the driver is not strict about this requirement. I will send a patch
> > to print an error message if this requirement is not satisfied.
> > 
> > > > > +
> > > > > +	platform_set_drvdata(pdev, k1);
> > > > > +
> > > > 
> > > > For setting the correct runtime PM state of the controller, you should do:
> > > > 
> > > > pm_runtime_set_active()
> > > > pm_runtime_no_callbacks()
> > > > devm_pm_runtime_enable()
> > > 
> > > OK, that's easy enough.
> > > 
> > > > This will fix the runtime PM hierarchy of PCIe chain (from host controller to
> > > > client drivers). Otherwise, it will be broken.
> > > Is this documented somewhere?  (It wouldn't surprise me if it
> > > is and I just missed it.)
> > > 
> > 
> > Sorry no. It is on my todo list. But I'm getting motivation now.
> > 
> > > This driver has as its origins some vendor code, and I simply
> > > removed the runtime PM calls.  I didn't realize something would
> > > be broken without making pm_runtime*() calls.
> > > 
> > 
> > It is the PM framework requirement to mark the device as 'active' to allow it to
> > participate in runtime PM. If you do not mark it as 'active' and 'enable' it,
> > the framework will not allow propagating the runtime PM changes before *this*
> > device. For instance, consider the generic PCI topology:
> > 
> > PCI controller (platform device)
> > 	|
> > PCI host bridge
> > 	|
> > PCI Root Port
> > 	|
> > PCI endpoint device
> > 
> > If the runtime PM is not enabled for the PCI Root Port, then if the PCI endpoint
> > device runtime suspends, it will not trigger runtime suspend for the Root Port
> > and also for the PCI controller. Also, since the runtime PM framework doesn't
> > have the visibility of the devices underneath the bus (like endpoint), it may
> > assume that no devices (children) are currently active and may trigger runtime
> > suspend of the Root Port (parent) even though the endpoint device could be
> > 'active'.
> 
> So this basically marks this controller as a pass-through device that
> doesn't itself change state for runtime PM, but still communicates that
> somewhere at or below it there might be devices that do participate.

Yes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


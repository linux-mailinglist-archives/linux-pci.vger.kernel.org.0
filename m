Return-Path: <linux-pci+bounces-33354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F693B19F16
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 11:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1882B7AC343
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9A2459DC;
	Mon,  4 Aug 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE6GWYG0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A71FBCA7;
	Mon,  4 Aug 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301401; cv=none; b=Dm8FHtqimM/JlyCqvGvu8IshbLWv0PEWzWnrFFm+0DdCXFh0Co0eh2b2rEwsrSWXY7PTwqgWb0ByYmsIJkNKPGrDuceMHv9IsdwR5oNYoV/7+g1PvlFkq8TcYDfwYmTWlsfagJtxuMDt2Rtoq8625OnmlhThdmzelYnagRfcGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301401; c=relaxed/simple;
	bh=C/ENhUEs3LsCipsjC9Q/ykoF43mS7sYAKJg8VhQad9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1hHSkCmiwoDMfOudAO21sz2NwsR77utLMjO4yyKTJ1AM8GmaXbMZYQgn8Di7WLQHVoAiqyQcAAZZeyV9B6TXxKq9VSDxifx9fK+5kda/bNPU88Oc5QvU2Z2C/rMeUBlVK0GUXMQwxiTPQam+JS0TJYaRtIiFz+BgbpVWXBvWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE6GWYG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E72C4CEE7;
	Mon,  4 Aug 2025 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754301401;
	bh=C/ENhUEs3LsCipsjC9Q/ykoF43mS7sYAKJg8VhQad9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE6GWYG0POB+f7AgXEyeCI/r4BKRJGuWe6RltdxLIUboA41fonIDXFFSLRTP5uO3V
	 pLOQ+SimG90YYKj1fv+71yaXJ9T5uOhXhW8M7zFiqrM2vGvtvYYgI1LIpFPPq2kVLM
	 6997pjzttYxysj6eepYrOeENSCV4NaRNslO1oOCsdpYfkbiBK2pWlcDv4U8R49Kg5f
	 XYzukgBUCQ5/xOKG3kDJ5ZACUwMscTKUhQNPF3dfYxferMVzcdcpcIrJ1b57m28jqU
	 xCOTopap/vEtk6r7/YQxbJEev5DqRrTl2s/2zpW4D3SxAWObH29wNzWn1FqlBGgB1v
	 JhjCuOnCoeD/A==
Date: Mon, 4 Aug 2025 15:26:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <tipgh2nf5yz7sevz3mef43f7dgagwbhx6vi42qay7xmz2wtxg4@kv3nkctpqe5z>
References: <20250801-wake_irq_support-v4-3-6b6639013a1a@oss.qualcomm.com>
 <20250801212725.GA3506354@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801212725.GA3506354@bhelgaas>

On Fri, Aug 01, 2025 at 04:27:25PM GMT, Bjorn Helgaas wrote:
> On Fri, Aug 01, 2025 at 04:29:44PM +0530, Krishna Chaitanya Chundru wrote:
> > According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> > wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> > provide a means of signaling the platform to re-establish power and
> > reference clocks to the components within its domain. Adding WAKE#
> > support in PCI framework.
> 
> I think Beacon is a hardware mechanism invisible to software (PCIe
> r7.0, sec 4.2.7.8.1).
> 
> > According to the PCIe specification, multiple WAKE# signals can exist in a
> > system. In configurations involving a PCIe switch, each downstream port
> > (DSP) of the switch may be connected to a separate WAKE# line, allowing
> > each endpoint to signal WAKE# independently. To support this, the WAKE#
> > should be described in the device tree node of the upstream bridge to which
> > the endpoint is connected.
> 
> I think this says a bit more than we know.  AFAICS, the PCIe spec does
> not require any particular WAKE# routing.  WAKE# *could* be routed to
> an upstream bridge (as shown in the 5.3.3.2 implementation note), but
> it doesn't have to be.  I think we need to allow WAKE# to be described
> by an Endpoint directly (which I think this patch does).
> 
> I'm not sure about searching upstream PCI bridges.  I don't think
> there's anything in the PCIe spec about a connection between WAKE#
> routing and the PCI topology.  Maybe we need to search enclosing DT
> scopes?  I'm not really sure how DT works in this respect.  WAKE#
> could be routed to some GPIO completely unrelated to the PCI host
> bridge.
> 

PCIe spec r5, fig 5-4 describes that WAKE# is supposed to be connected to a
*slot*, not directly to the endpointi, though endpoint is the one toggling it.
And in devicetree, we describe the slot using the bridge node. So it makes sense
to add the 'wake-gpios' property to the bridge node only. It is what allowed by
the dtschema today.

> I don't see anything that would prevent a Switch Port from asserting a
> WAKE# interrupt, so I'm not sure we should restrict it to Endpoints.
> 

Atleast fig 5-4 describes that the switch has to generate Beacon to RC for WAKE#
asserted by the endpoints connected to the downstream slots.

> > For example, in a switch-based topology, the
> > WAKE# can be defined in the DSP of the switch. In a direct connection
> > scenario, the WAKE# can be defined in the root port. If all endpoints share
> > a single WAKE# line, the GPIO should be defined in the root port.
> > 
> > During endpoint probe, the driver searches for the WAKE# in its immediate
> > upstream bridge. If not found, it continues walking up the hierarchy until
> > it either finds a WAKE# or reaches the root port. Once found, the driver
> > registers the wake IRQ in shared mode, as the WAKE# may be shared among
> > multiple endpoints.
> > 
> > When the IRQ is asserted, the wake handler triggers a pm_runtime_resume().
> 
> I guess "wake handler" refers to handle_threaded_wake_irq()?  If so,
> just use the name directly to make it easier for people to follow
> this.
> 
> > The PM framework ensures that the parent device is resumed before the
> > child i.e controller driver which can bring back link to D0.
> 
> Nit: a *device* can be in D0.  Links would be in L0, etc.
> 
> > WAKE# is added in dts schema and merged based on this link.
> > 
> > Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ...
> 
> > +void pci_parse_of_wake_gpio(struct pci_dev *dev)
> > +{
> > +	struct device_node *dn __free(device_node) = pci_device_to_OF_node(dev);
> 
> I'm still trying to wrap my head around __free().  Why are we using
> __free() and no_free_ptr() here?  AFAICS we're not allocating anything
> here.
> 
> > +	struct gpio_desc *gpio;
> > +
> > +	if (!dn)
> > +		return;
> > +
> > +	gpio = fwnode_gpiod_get_index(of_fwnode_handle(no_free_ptr(dn)),
> > +				      "wake", 0, GPIOD_IN, NULL);
> > +	if (!IS_ERR(gpio))
> > +		dev->wake = gpio;
> > +}
> > +
> > +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> > +{
> > +	if (!dev->wake)
> > +		return;
> > +
> > +	gpiod_put(dev->wake);
> > +	dev->wake = NULL;
> > +}
> >  #endif	/* CONFIG_OF_IRQ */
> >  
> >  static int pci_parse_request_of_pci_ranges(struct device *dev,
> > @@ -1010,3 +1035,44 @@ int of_pci_get_equalization_presets(struct device *dev,
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > +
> > +int pci_configure_wake_irq(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *bridge = pdev;
> > +	struct gpio_desc *wake;
> > +	int ret, wake_irq;
> > +
> > +	while (bridge) {
> > +		wake = bridge->wake;
> > +		if (wake)
> > +			break;
> > +		bridge = pci_upstream_bridge(bridge);  // Move to upstream bridge
> 
> If we need to search more scopes, I think we should be searching DT
> scopes, not PCI bridges.
> 
> > +	}
> > +
> > +	if (!wake)
> > +		return 0;
> > +
> > +	wake_irq = gpiod_to_irq(wake);
> > +	if (wake_irq < 0) {
> > +		dev_err(&pdev->dev, "Failed to get wake irq: %d\n", wake_irq);
> > +		return wake_irq;
> > +	}
> > +
> > +	device_init_wakeup(&pdev->dev, true);
> > +
> > +	ret = dev_pm_set_dedicated_wake_irq_flags(&pdev->dev, wake_irq,
> > +						  IRQF_SHARED | IRQ_TYPE_EDGE_FALLING);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
> > +		device_init_wakeup(&pdev->dev, false);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void pci_remove_wake_irq(struct pci_dev *pdev)
> > +{
> > +	dev_pm_clear_wake_irq(&pdev->dev);
> > +	device_init_wakeup(&pdev->dev, false);
> > +}
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index b853585cb1f87216981bde2a7782b8ed9c337636..2a1dca1d19b914d21b300ea78be0e0dce418cc88 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -447,10 +447,19 @@ static int pci_device_probe(struct device *dev)
> >  	if (error < 0)
> >  		return error;
> >  
> > +	if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ENDPOINT) {
> 
> I guess there's a policy question here: configuring this in
> pci_device_probe() implies that we only pay attention to WAKE# when a
> driver is bound to the device.  Or, since WAKE# may be shared, I guess
> we pay attention to it if any device sharing this WAKE# IRQ has a
> driver?
> 

I don't think we check if the driver is bind to the device before putting it
into D3Cold. If the device was previously enabled from sysfs, then it cannot
ask host to wake it up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


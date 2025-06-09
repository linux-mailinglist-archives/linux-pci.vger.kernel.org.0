Return-Path: <linux-pci+bounces-29218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74EAD1CC4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 14:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F7C3AC9C3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA35256C7E;
	Mon,  9 Jun 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGDxMeRS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACC2561DD;
	Mon,  9 Jun 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470404; cv=none; b=cM6/oXrZFvXB66lU/5NLksI2XQzjBp5wFNyPrqIW5kyLL/sxIQaD9sZQh9NrJ+Vr4BnyN1Vpoyj4Xtv1d3EaJoBB6oO56ijK/tlyYEM2Tew1FrL/cwtY5Qtzv0a1DOv5VIo35MkfwIRS+kVp7rltj7E/X4FFePZ17uKJ/vFOqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470404; c=relaxed/simple;
	bh=VNK7VVJAP9oDuurE8SbOZP1RRIA6lunMWbNPz7CoQK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCqnySx6Fia2lMssna9NSvTOzTCjZVEPjqQknu+P9GOUa6XPWxzoxO7lTmYQq3nMKCP/kgebsngvz7Tr+FXojxAfkigQCzPze3VYjYnjT3PiHdsnBVqCZvqYrAGrJvK36SfC9VcSseNFGt8g1rGDkls+ISOWyUMF3oxVq0K5Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGDxMeRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC77EC4CEEB;
	Mon,  9 Jun 2025 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749470403;
	bh=VNK7VVJAP9oDuurE8SbOZP1RRIA6lunMWbNPz7CoQK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGDxMeRSJQgWr64RvYpWptgDuS+BnnL2RArQjG8mPIQz/xCBtEL5LNYHhp7XYpy7J
	 32imV7as7Kp9xPH3K5fSdcbQTPbO4Y3GSCIHI22pDlECEBOXuZyYIUAWrXmmyTT3hd
	 qo19bfTzFdwIGfFTzhmCdKdRJY9NDJiHUV0C5xBnchSoMYe02XEddCeFLWIg/IOJvq
	 Y03cIJEzI/Ncqg3WolDtVL48R1vm+1h8PJLnCa1lMuLtkBkNgY3+2XVsGrOJCHy7bj
	 I+plPPDx4TJpwrbbE1gxc2oDCa9dm9Ee+8b4SxOX/AjOOfT9HyRBd6YAtybrGb8pgE
	 DD3HtH4RaFopA==
Date: Mon, 9 Jun 2025 17:29:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Brian Norris <briannorris@chromium.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Lindgren <tony@atomide.com>, 
	JeffyChen <jeffy.chen@rock-chips.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Message-ID: <pl262pfxe5mjtxzvr4qcsxwt4cyrdjzncd3ztsqpb6zuc7gi5b@hu6njospevgk>
References: <20250605202630.GA622231@bhelgaas>
 <7b91b725-6b47-bf8f-e6e5-e4584f274ec4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b91b725-6b47-bf8f-e6e5-e4584f274ec4@oss.qualcomm.com>

+ Brian, Rafael, Tony, Jeffy (who were part of the previous attempt to add WAKE#
GPIO/interrupt support:
https://lore.kernel.org/linux-pci/20171225114742.18920-1-jeffy.chen@rock-chips.com

On Mon, Jun 09, 2025 at 11:27:49AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/6/2025 1:56 AM, Bjorn Helgaas wrote:
> > On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
> > > PCIe wake interrupt is needed for bringing back PCIe device state
> > > from D3cold to D0.
> > 
> > Does this refer to the WAKE# signal or Beacon or both?  I guess the
> > comments in the patch suggest WAKE#.  Is there any spec section we can
> > cite here?
> > 
> we are referring only WAKE# signal, I will add the PCIe spec r6.0, sec
> 5.3.3.2 in next patch version.
> > > Implement new functions, of_pci_setup_wake_irq() and
> > > of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> > > using the Device Tree.
> > > 
> > >  From the port bus driver call these functions to enable wake support
> > > for bridges.
> > 
> > What is the connection to bridges and portdrv?  WAKE# is described in
> > PCIe r6.0, sec 5.3.3.2, and PCIe CEM r6.0, sec 2.3, but AFAICS neither
> > restricts it to bridges.
> > 

You are right. WAKE# is really a PCIe slot/Endpoint property and doesn't
necessarily belong to a Root Port/Bridge. But the problem is with handling the
Wake interrupt in the host. For instance, below is the DT representation of the
PCIe hierarchy:

	PCIe Host Bridge
		|
		v
	PCIe Root Port/Bridge
		|
		|
		v
PCIe Slot <-------------> PCIe Endpoint

DTs usually define both the WAKE# and PERST# GPIOs ({wake/reset}-gpios property)
in the PCIe Host Bridge node. But we have decided to move atleast the PERST# to
the Root Port node since the PERST# lines are per slot and not per host bridge.

Similar interpretation applies to WAKE# as well, but the major difference is
that it is controlled by the endpoints, not by the host (RC/Host Bridge/Root
Port). The host only cares about the interrupt that rises from the WAKE# GPIO.
The PCIe spec, r6.0, Figure 5-4, tells us that the WAKE# is routed to the PM
controller on the host. In most of the systems that tends to be true as the
WAKE# is not tied to the PCIe IP itself, but to a GPIO controller in the host.

In this case, the PCI core somehow needs to know the IRQ number corresponding to
the WAKE# GPIO, so that it can register an IRQ handler for it to wakeup the
endpoint when an interrupt happens. Previous attempts [1], tried to add a new DT
property for the interrupts:
https://lore.kernel.org/linux-pci/20171225114742.18920-2-jeffy.chen@rock-chips.com

But that doesn't seem to fly. So Krishna came with the proposal to reuse the
WAKE# GPIO defined in the Root Port node (for DTs that have moved the properties
out of the Host Bridge node) and extract the IRQ number from it using
gpiod_to_irq() API.

And he used portdrv as the placeholder for the irq setup code, because the WAKE#
GPIO is going to be defined in the Root Port node irrespective of a PCIe Slot or
an endpoint is connected to the Root Port. And the portdrv driver is the one
controlling the Root Port. Though, this placeholder part can be subject to
discussion.

But from the previous discussions, I could infer that the PCIe Root Port/Bridge
DT node is going to be the placeholder for the WAKE# GPIOs:
https://lore.kernel.org/linux-pci/2806186.IK6EZBC0cX@aspire.rjw.lan

It also sounds sensible to me since we do not want to define the wake-gpios
property in the endpoint node as that would mean that for each device connected,
a separate DT endpoint node needs to be created just for defining the WAKE#
GPIO. Also, if there is only a PCIe slot in the board, then the property has to
be defined in the PCIe Root Port node itself as there is no separate DT node for
PCIe slot.

> The wake# is used by the endpoints to wake host to bring PCIe device
> state to D0 again, in direct attach root port wake# will be connected
> to the root port and in switch cases the wake# will connected to the
> switch Downstream ports and switch will consolidate wake# from different
> downstream ports and sends to the root port. The wake# will be used by
> root port bridges only. portdrv is the driver for root port.

This is not correct. Root Port doesn't have anything to do with the WAKE#
interrupt. We are just merely trying to reuse the Root Port driver because of
how the WAKE# GPIO is wired up in the DT. It might not be applicable for ACPI as
the FW raises GPE for the Wake interrupt and kernel doesn't parse WAKE#, afaik.

> > Unless there's some related functionality in a Root Port, RCEC, or
> > Switch Port, maybe this code should be elsewhere, like
> > set_pcie_port_type(), so we could set this up for any PCIe device that
> > has a WAKE# description?
> > 

I think it should work if we tie the Wake interrupt to the PCI device instead of
the Root Port/Bridge in the kernel, even though the DT representation is
different. In that case, PCI core should parse the Root Port node for each
device to get the WAKE# GPIO and setup an IRQ handler for it. When the Wake
interrupt happens, the PCI core should power ON the PCI hierarchy starting from
the host bridge, till the endpoint (top down approach).

I think we all agree that the WAKE# GPIO should be handled by the PCI core
instead of the PCI controller or client drivers. We should agree on the best
possible place though.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


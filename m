Return-Path: <linux-pci+bounces-29267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16E9AD2965
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC4816EEC7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6520B215;
	Mon,  9 Jun 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORKyO9mn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59DB3597B;
	Mon,  9 Jun 2025 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749508471; cv=none; b=Pbo76jkvBxmu6mj3b8r+7lv46bCSsCOltLqNQDZD0HSiSC70j5rIh/QS3D1D1hqhNBea/O962XGgchIpbpGMkj4m1sxneNLdHBJH/znlIMb54dxJsGLl4xro2JKnS7Lh1C363WQwgrG8vTJO5ffbKGVK4/3Mgh1PrpLdqAG6vGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749508471; c=relaxed/simple;
	bh=A4mU625j3YMMW9dfpyPGBAR8L+pq0PRwArA2Xezy+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ihgN/Ia/gtXR08319rV43NNviPWFQZyNh1h78pt6UU46yyMMi5O7mUdym3o0IGE1MehQbg4Qrfx0J5+eQnxXQLEI9mN9E7mwSoNivwg4M8rmw3yEQJmX2GobR6tWTlKREZ0q2r9iMlpJhSpK9zeNxG64yPqOClmZHAwnqdbcVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORKyO9mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E086C4CEEB;
	Mon,  9 Jun 2025 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749508470;
	bh=A4mU625j3YMMW9dfpyPGBAR8L+pq0PRwArA2Xezy+TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ORKyO9mnfD6Q65zMU0f3Qax70JIW7o1BR8EfhqbNO86OSEM0KhHtD3MAmdQn6juMM
	 OGgJ3yUdxs1ULO4V1IQTO4NHSQxqBSnWnovElca2H0TChRdMHucubyPcPYcpECu0Hl
	 puVzsacU1/GdW/fEzr4vhtREA9C58j0YlAiMD+BEUfK85xRzMGWkPXLN1kK3NwuCYQ
	 RIqrHXcjgH1iTpb+/XwqkKvaAnKTM5wjmsb955ZTth9g4ITlUobMYzgJHFfjQTAgev
	 G9QK/4gwJj7k4fsqGm0WVagR4nTdyWXsJUH7ltPEKQhTxF15EC6EgET4n9i+j8Spy3
	 lTcE4BUUJ8SgQ==
Date: Mon, 9 Jun 2025 17:34:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tony Lindgren <tony@atomide.com>,
	JeffyChen <jeffy.chen@rock-chips.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Message-ID: <20250609223428.GA756387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pl262pfxe5mjtxzvr4qcsxwt4cyrdjzncd3ztsqpb6zuc7gi5b@hu6njospevgk>

On Mon, Jun 09, 2025 at 05:29:49PM +0530, Manivannan Sadhasivam wrote:
> + Brian, Rafael, Tony, Jeffy (who were part of the previous attempt to add WAKE#
> GPIO/interrupt support:
> https://lore.kernel.org/linux-pci/20171225114742.18920-1-jeffy.chen@rock-chips.com
> 
> On Mon, Jun 09, 2025 at 11:27:49AM +0530, Krishna Chaitanya Chundru wrote:
> > On 6/6/2025 1:56 AM, Bjorn Helgaas wrote:
> > > On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
> > > > PCIe wake interrupt is needed for bringing back PCIe device state
> > > > from D3cold to D0.
> > > 
> > > Does this refer to the WAKE# signal or Beacon or both?  I guess the
> > > comments in the patch suggest WAKE#.  Is there any spec section we can
> > > cite here?
> > > 
> > we are referring only WAKE# signal, I will add the PCIe spec r6.0, sec
> > 5.3.3.2 in next patch version.
> > > > Implement new functions, of_pci_setup_wake_irq() and
> > > > of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> > > > using the Device Tree.
> > > > 
> > > >  From the port bus driver call these functions to enable wake support
> > > > for bridges.
> > > 
> > > What is the connection to bridges and portdrv?  WAKE# is described in
> > > PCIe r6.0, sec 5.3.3.2, and PCIe CEM r6.0, sec 2.3, but AFAICS neither
> > > restricts it to bridges.
> 
> You are right. WAKE# is really a PCIe slot/Endpoint property and
> doesn't necessarily belong to a Root Port/Bridge. But the problem is
> with handling the Wake interrupt in the host. For instance, below is
> the DT representation of the PCIe hierarchy:
> 
> 	PCIe Host Bridge
> 		|
> 		v
> 	PCIe Root Port/Bridge
> 		|
> 		|
> 		v
> PCIe Slot <-------------> PCIe Endpoint
> 
> DTs usually define both the WAKE# and PERST# GPIOs
> ({wake/reset}-gpios property) in the PCIe Host Bridge node. But we
> have decided to move atleast the PERST# to the Root Port node since
> the PERST# lines are per slot and not per host bridge.
> 
> Similar interpretation applies to WAKE# as well, but the major
> difference is that it is controlled by the endpoints, not by the
> host (RC/Host Bridge/Root Port). The host only cares about the
> interrupt that rises from the WAKE# GPIO.  The PCIe spec, r6.0,
> Figure 5-4, tells us that the WAKE# is routed to the PM controller
> on the host. In most of the systems that tends to be true as the
> WAKE# is not tied to the PCIe IP itself, but to a GPIO controller in
> the host.

If WAKE# is supported at all, it's a sideband signal independent of
the link topology.  PCIe CEM r6.0, sec 2.3, says WAKE# from multiple
connectors can be wire-ORed together, or can have individual
connections to the PM controller.

> In this case, the PCI core somehow needs to know the IRQ number
> corresponding to the WAKE# GPIO, so that it can register an IRQ
> handler for it to wakeup the endpoint when an interrupt happens.
> Previous attempts [1], tried to add a new DT property for the
> interrupts:
> https://lore.kernel.org/linux-pci/20171225114742.18920-2-jeffy.chen@rock-chips.com
> 
> But that doesn't seem to fly. So Krishna came with the proposal to
> reuse the WAKE# GPIO defined in the Root Port node (for DTs that
> have moved the properties out of the Host Bridge node) and extract
> the IRQ number from it using gpiod_to_irq() API.

I don't think we can assume a single WAKE# GPIO in a Root Port, as
above.  I think we'll have to start looking at the endpoint and search
upward till we find one.

Bjorn


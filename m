Return-Path: <linux-pci+bounces-33866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3BB22CFD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2349E6807FE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFCF23D7D1;
	Tue, 12 Aug 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCrImNZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F8305E31;
	Tue, 12 Aug 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015045; cv=none; b=Ab+xBBh/+a5Uv6KsTO/BQFfhZjVmV0uEZeJw1F7kxKVGkVQFkREAVxgHSxYuHWmBRnmQ5tNO9oOUNHwU28ZeBq4j9R/hFxm2wrSLYmKQS2aekSx6tpayek7gkOactxOcjeE1kgkSn5lEUrX9bSMsiVe5NCNCAXjaMJWbmKRK6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015045; c=relaxed/simple;
	bh=XhVe52TrqEXfUWxtoCxnby5qoLKRCgYb//QrZaQN0Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXu41mXyTmVpmw8LTHFqgPaI8csI+TnngXR2ejdESXyBJik3z7tCdbKPTJvuQvSymd8EIn5Mrx0nexq96Pul+NEHouSL1lnd4HMvlYdiR6GE+ygBzdIywHzVxze2o63AEVxUCdKwd21NJ66/GggkQNjNMJyz4OPh39KS8eNFR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCrImNZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2ABC4CEF0;
	Tue, 12 Aug 2025 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015045;
	bh=XhVe52TrqEXfUWxtoCxnby5qoLKRCgYb//QrZaQN0Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCrImNZa0C4Z+4ZDgVQKzRTpBGq+Q8ye9HFwez3Qm67TdHBXbkDn+qiMtMj4UxhwZ
	 WpeUUoxM3hnP4TrSfLDh7cjNCT7sjFkqrrU9RsOWyTaFc9NDvSIuViqEk+PAlLN8UC
	 /lWMb3MVNdVQwg4bdGhUzMgqsImVqebvP2RFIw5cyz5NxwIpIESMW6znstl926r5ai
	 7ev87eTy4KfxMKAtkaJfgvqZ0Ni1oWHj8qoyQHT30Bui7i8BhQZJpwvCBHVNk3jiXA
	 hgG5R2zUmSFi7r2q/nZO8ouVaH/J9WJoif6q/CMVoF5AL9s15JBmuGKLd8/vCWwkPX
	 9KbYwqd46EEDw==
Date: Tue, 12 Aug 2025 21:40:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Tony Lindgren <tony@atomide.com>, JeffyChen <jeffy.chen@rock-chips.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Message-ID: <aapdte7bfbkqnftrpl5twrwrzzptm5djg2lqanmpqrxgbmb5n2@fjhjavynjt6l>
References: <20250610164154.GA812762@bhelgaas>
 <9ede83ab-f494-4975-b896-da14958f727d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ede83ab-f494-4975-b896-da14958f727d@oss.qualcomm.com>

On Thu, Jul 03, 2025 at 04:21:59PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/10/2025 10:11 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 10, 2025 at 10:00:20AM +0530, Krishna Chaitanya Chundru wrote:
> > > On 6/10/2025 4:04 AM, Bjorn Helgaas wrote:
> > > > On Mon, Jun 09, 2025 at 05:29:49PM +0530, Manivannan Sadhasivam wrote:
> > > > > + Brian, Rafael, Tony, Jeffy (who were part of the previous attempt to add WAKE#
> > > > > GPIO/interrupt support:
> > > > > https://lore.kernel.org/linux-pci/20171225114742.18920-1-jeffy.chen@rock-chips.com
> > > > > 
> > > > > On Mon, Jun 09, 2025 at 11:27:49AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > On 6/6/2025 1:56 AM, Bjorn Helgaas wrote:
> > > > > > > On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > > > PCIe wake interrupt is needed for bringing back PCIe device state
> > > > > > > > from D3cold to D0.
> > > > > > > 
> > > > > > > Does this refer to the WAKE# signal or Beacon or both?  I guess the
> > > > > > > comments in the patch suggest WAKE#.  Is there any spec section we can
> > > > > > > cite here?
> > > > > > > 
> > > > > > we are referring only WAKE# signal, I will add the PCIe spec r6.0, sec
> > > > > > 5.3.3.2 in next patch version.
> > > > > > > > Implement new functions, of_pci_setup_wake_irq() and
> > > > > > > > of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> > > > > > > > using the Device Tree.
> > > > > > > > 
> > > > > > > >    From the port bus driver call these functions to enable wake support
> > > > > > > > for bridges.
> > > > > > > 
> > > > > > > What is the connection to bridges and portdrv?  WAKE# is described in
> > > > > > > PCIe r6.0, sec 5.3.3.2, and PCIe CEM r6.0, sec 2.3, but AFAICS neither
> > > > > > > restricts it to bridges.
> > > > > 
> > > > > You are right. WAKE# is really a PCIe slot/Endpoint property and
> > > > > doesn't necessarily belong to a Root Port/Bridge. But the problem is
> > > > > with handling the Wake interrupt in the host. For instance, below is
> > > > > the DT representation of the PCIe hierarchy:
> > > > > 
> > > > > 	PCIe Host Bridge
> > > > > 		|
> > > > > 		v
> > > > > 	PCIe Root Port/Bridge
> > > > > 		|
> > > > > 		|
> > > > > 		v
> > > > > PCIe Slot <-------------> PCIe Endpoint
> > > > > 
> > > > > DTs usually define both the WAKE# and PERST# GPIOs
> > > > > ({wake/reset}-gpios property) in the PCIe Host Bridge node. But we
> > > > > have decided to move atleast the PERST# to the Root Port node since
> > > > > the PERST# lines are per slot and not per host bridge.
> > > > > 
> > > > > Similar interpretation applies to WAKE# as well, but the major
> > > > > difference is that it is controlled by the endpoints, not by the
> > > > > host (RC/Host Bridge/Root Port). The host only cares about the
> > > > > interrupt that rises from the WAKE# GPIO.  The PCIe spec, r6.0,
> > > > > Figure 5-4, tells us that the WAKE# is routed to the PM controller
> > > > > on the host. In most of the systems that tends to be true as the
> > > > > WAKE# is not tied to the PCIe IP itself, but to a GPIO controller in
> > > > > the host.
> > > > 
> > > > If WAKE# is supported at all, it's a sideband signal independent of
> > > > the link topology.  PCIe CEM r6.0, sec 2.3, says WAKE# from multiple
> > > > connectors can be wire-ORed together, or can have individual
> > > > connections to the PM controller.
> > > 
> > > I believe they are referring to multi root port where WAKE# can
> > > routed to individual root port where each root port can go D3cold
> > > individually.
> > 
> > AFAICT there's no requirement that WAKE# be routed to a Root Port or a
> > Switch Port.  The routing is completely implementation specific.
> > 
> > >  From endpoint perspective they will have single WAKE# signal, the
> > > WAKE# from endpoint will be routed to its DSP's i.e root port in
> > > direct attach and in case of switch they will routed to the USP from
> > > their again they will be connected to the root port only as there is
> > > noway that individual DSP's in the switch can go to D3cold from
> > > linux point of view as linux will not have control over switch
> > > firmware to control D3cold to D0 sequence.
> > > 
> > > But still if the firmware in the DSP of a switch can allow device to
> > > go in to D3cold after moving host moving link to D3hot, the DSP in
> > > the switch needs to receive the WAKE# signal first to supply power
> > > and refclk then DSP will propagate WAKE# to host to change device
> > > state to D0. In this case if there is separate WAKE# signal routed
> > > to the host, we can define WAKE# in the device-tree assigned to the
> > > DSP of the switch. As the DSP's are also tied with the portdrv, the
> > > same existing patch will work since this patch is looking for
> > > wake-gpios property assigned to that particular port in the DT.
> > 
> > WAKE# is only defined for certain form factors, and Root Ports and
> > Switch Ports have no WAKE#-related behavior defined by the PCIe specs.
> > 
> > I don't want to make assumptions about how WAKE# is routed, whether
> > Switches have implementation-specific WAKE# handling, or how D3cold
> > transitions happen.  Those things are all implementation specific.
> > 
> > My main objections are:
> > 
> >    - Setting up a wake IRQ should be done on an endpoint, but this
> >      patch assumes doing it on a Root Port or Switch Port is enough.
> > 
> >      We can start a DT search for a wake IRQ at the endpoint and
> >      traverse up the hierarchy if necessary, of course.
> > 
> >    - The code should not be in portdrv.c.  Putting it in portdrv means
> >      it won't work unless CONFIG_PCIEPORTBUS is enabled, and WAKE# has
> >      nothing to do with the rest of portdrv.
> I went through the SPEC again and you are right the spec hasn't
> mentioned about wake# routing properly.
> 
> I will move the code from portdrv to pci core framework and for your
> 1st objection, you are suggesting to search for wake IRQ in the endpoint
> DT and then traverse up. I believe you are suggesting this because we
> may more than one wake# routed to root port from multiple endpoints.
> if this is the case then we need to register for more than one wake
> IRQ. For this case I feel better to check for wake# gpio in the DT
> when ever there is a new device is detected in the pci core and create
> the wake IRQ with the dev associated with the pci_dev.
> 

I think it makes sense to have the wake-gpios property in the endpoint node as
that will clearly describe whether the device using WAKE# or not. If we have it
in the bridge node, then the host wouldn't know to which endpoint the WAKE# is
routed to. It will lead to incorrect assumptions.

But if we define wake-gpios in the endpoint node, then host will know which
endpoint supports WAKE# and it can register the WAKE# IRQ only for that device.
Even if the WAKE# is shared with multiple endpoints, all of them could define
the same wake-gpios property and the host could use a shared IRQ with the help
of IRQF_SHARED.

But this requires the dt-binding change though. I will submit a PR for that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-29349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616EAD3F3C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30AC1BA0742
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250712417C6;
	Tue, 10 Jun 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeYtIhqv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64AF137932;
	Tue, 10 Jun 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573717; cv=none; b=D6KUR3ED9J4Bce5IA1IJo6ytWFXG9EFJSoBA/7BwobCRujkn8sdhh8ooE/KRAcl8tRzw+QptStXgMiS+jKuaywPpTGAAO7uaJDNOpsqqX6MRsRfaC/w3KVNZ1xRqiEsi19G3Ljc0e5/yV3xP0VGiAjR5/GZ5rxJgL+3HkKCLd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573717; c=relaxed/simple;
	bh=dNv04z5Hj1p4KQzygfRsRonPFMuFoIhWx4h04atNCXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ontu+9Qs17vdqvn7FMg1dwsBxN+FdoPNy0lp/9zdzL0Yv+cNHy/1RkRVgP58WXE3f8yQ3qWBioNUqNbS4hRkfQDIhuffrTZkj5dtoEBAuqD/HS96OJXeWaV+4mHMHohY5mEtSISo7OdRwcKrriteAQ2f40/2GGvBmnq1jvQEOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeYtIhqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF85C4CEED;
	Tue, 10 Jun 2025 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749573716;
	bh=dNv04z5Hj1p4KQzygfRsRonPFMuFoIhWx4h04atNCXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HeYtIhqv3n6awJrvCoWqk7Kibm0gbn9ms7M52nlLB6PaKtAPoIWNZsH8veTNuaGq2
	 ngV7X70zFw6auGIV46J1X12M5LFwFjq7rrei9L4Feayz8sVUBFKnzPaSXwUNeV2ZuM
	 8vEDSzwe42DCukrbnr+gLpOoiqxJxVoTswhLg5Va85TOKae1uwro8iJfBNG7PdYzyU
	 U22aXqTfRogiuLAehAYizZTgW/x207OmCY8s7xAeyDHmsPvB9+vrjYzvrSPfyvCWU4
	 8Jt/zUzFRB1ODbPRVqUuttIQrtPrhH9M9krxZjX5b+AHVOxrPb7xloRtX/24V5jiR5
	 c1HquqrKG9vZg==
Date: Tue, 10 Jun 2025 11:41:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <20250610164154.GA812762@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f13d04-83a1-ffae-38ec-56b14cc6f469@oss.qualcomm.com>

On Tue, Jun 10, 2025 at 10:00:20AM +0530, Krishna Chaitanya Chundru wrote:
> On 6/10/2025 4:04 AM, Bjorn Helgaas wrote:
> > On Mon, Jun 09, 2025 at 05:29:49PM +0530, Manivannan Sadhasivam wrote:
> > > + Brian, Rafael, Tony, Jeffy (who were part of the previous attempt to add WAKE#
> > > GPIO/interrupt support:
> > > https://lore.kernel.org/linux-pci/20171225114742.18920-1-jeffy.chen@rock-chips.com
> > > 
> > > On Mon, Jun 09, 2025 at 11:27:49AM +0530, Krishna Chaitanya Chundru wrote:
> > > > On 6/6/2025 1:56 AM, Bjorn Helgaas wrote:
> > > > > On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > PCIe wake interrupt is needed for bringing back PCIe device state
> > > > > > from D3cold to D0.
> > > > > 
> > > > > Does this refer to the WAKE# signal or Beacon or both?  I guess the
> > > > > comments in the patch suggest WAKE#.  Is there any spec section we can
> > > > > cite here?
> > > > > 
> > > > we are referring only WAKE# signal, I will add the PCIe spec r6.0, sec
> > > > 5.3.3.2 in next patch version.
> > > > > > Implement new functions, of_pci_setup_wake_irq() and
> > > > > > of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> > > > > > using the Device Tree.
> > > > > > 
> > > > > >   From the port bus driver call these functions to enable wake support
> > > > > > for bridges.
> > > > > 
> > > > > What is the connection to bridges and portdrv?  WAKE# is described in
> > > > > PCIe r6.0, sec 5.3.3.2, and PCIe CEM r6.0, sec 2.3, but AFAICS neither
> > > > > restricts it to bridges.
> > > 
> > > You are right. WAKE# is really a PCIe slot/Endpoint property and
> > > doesn't necessarily belong to a Root Port/Bridge. But the problem is
> > > with handling the Wake interrupt in the host. For instance, below is
> > > the DT representation of the PCIe hierarchy:
> > > 
> > > 	PCIe Host Bridge
> > > 		|
> > > 		v
> > > 	PCIe Root Port/Bridge
> > > 		|
> > > 		|
> > > 		v
> > > PCIe Slot <-------------> PCIe Endpoint
> > > 
> > > DTs usually define both the WAKE# and PERST# GPIOs
> > > ({wake/reset}-gpios property) in the PCIe Host Bridge node. But we
> > > have decided to move atleast the PERST# to the Root Port node since
> > > the PERST# lines are per slot and not per host bridge.
> > > 
> > > Similar interpretation applies to WAKE# as well, but the major
> > > difference is that it is controlled by the endpoints, not by the
> > > host (RC/Host Bridge/Root Port). The host only cares about the
> > > interrupt that rises from the WAKE# GPIO.  The PCIe spec, r6.0,
> > > Figure 5-4, tells us that the WAKE# is routed to the PM controller
> > > on the host. In most of the systems that tends to be true as the
> > > WAKE# is not tied to the PCIe IP itself, but to a GPIO controller in
> > > the host.
> > 
> > If WAKE# is supported at all, it's a sideband signal independent of
> > the link topology.  PCIe CEM r6.0, sec 2.3, says WAKE# from multiple
> > connectors can be wire-ORed together, or can have individual
> > connections to the PM controller.
>
> I believe they are referring to multi root port where WAKE# can
> routed to individual root port where each root port can go D3cold
> individually.

AFAICT there's no requirement that WAKE# be routed to a Root Port or a
Switch Port.  The routing is completely implementation specific.

> From endpoint perspective they will have single WAKE# signal, the
> WAKE# from endpoint will be routed to its DSP's i.e root port in
> direct attach and in case of switch they will routed to the USP from
> their again they will be connected to the root port only as there is
> noway that individual DSP's in the switch can go to D3cold from
> linux point of view as linux will not have control over switch
> firmware to control D3cold to D0 sequence.
>
> But still if the firmware in the DSP of a switch can allow device to
> go in to D3cold after moving host moving link to D3hot, the DSP in
> the switch needs to receive the WAKE# signal first to supply power
> and refclk then DSP will propagate WAKE# to host to change device
> state to D0. In this case if there is separate WAKE# signal routed
> to the host, we can define WAKE# in the device-tree assigned to the
> DSP of the switch. As the DSP's are also tied with the portdrv, the
> same existing patch will work since this patch is looking for
> wake-gpios property assigned to that particular port in the DT.

WAKE# is only defined for certain form factors, and Root Ports and
Switch Ports have no WAKE#-related behavior defined by the PCIe specs.

I don't want to make assumptions about how WAKE# is routed, whether
Switches have implementation-specific WAKE# handling, or how D3cold
transitions happen.  Those things are all implementation specific.

My main objections are:

  - Setting up a wake IRQ should be done on an endpoint, but this
    patch assumes doing it on a Root Port or Switch Port is enough.

    We can start a DT search for a wake IRQ at the endpoint and
    traverse up the hierarchy if necessary, of course.

  - The code should not be in portdrv.c.  Putting it in portdrv means
    it won't work unless CONFIG_PCIEPORTBUS is enabled, and WAKE# has
    nothing to do with the rest of portdrv.

Bjorn


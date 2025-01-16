Return-Path: <linux-pci+bounces-20004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E03A14159
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4710188C1BD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D922BAAD;
	Thu, 16 Jan 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxFUn4gb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C21139CFF;
	Thu, 16 Jan 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050577; cv=none; b=ivDxSJGFmOTxSQV3TbunCAlouJcw5LaKE4W38VsrENcU3J/GYyUoboKM0rI8BVuxxOMaZPssL4bxU04bcnuV7HPMoKcYB++NDHCsqUt8AyTxugD6INmpnk4vDtYR2PF/gG9sVrG7ModF6lLa8mAns9QGKhyb3HdBp0J66ZGCAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050577; c=relaxed/simple;
	bh=eugSbl6YVyckkhsPnw8vMEXY4d/2zv4a2tp5QGDe/Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kkjUOmgqjGVBzOiP7s6eAFJrtwGnRxbjTX+zf5aahKnqcZMk/O72PFqG4fndFL2tJSUWObHXK1oI0Xce65aOQ61uxU9PuCe47qC4sRtNUDFjbXhnH8ZiJSPMm38BkHUkkjeowgyQlaOrdVY7cNvSW8Nu2SWAWlLCQ1T4l0i9/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxFUn4gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01540C4CED6;
	Thu, 16 Jan 2025 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737050577;
	bh=eugSbl6YVyckkhsPnw8vMEXY4d/2zv4a2tp5QGDe/Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LxFUn4gbUoWDJDFHUbtU+tbnkQu5vCUDtfT2bQhYa49M4uum4DdD4+9woetHBO7Z+
	 1KNZGDJhJjCK4VYbJMxIRnMrVs0Jrg88qTKcr/0Ow5SLP3p8Xe/ZC+Bf71sIZDfjTD
	 J764f16ckCZeob5bgE6xvM/LTdqnaSkW6tioBViLB84DHPt8VZKVPdH3VMjbeT380r
	 3ABJwHSzr7R911oBpqCjS93Z0g48PUwi6kbby5jQiIHU516+pSa2Y0+z8s3NK3pZek
	 s1h35z7hbD8s+fyFG92TlApYnVgO0j78LK9fKVjwJGNgZt7hR6x2E7MN/aByESCiUz
	 H0+4kHNlR/uOA==
Date: Thu, 16 Jan 2025 12:02:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: daire.mcnamara@microchip.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, conor.dooley@microchip.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20250116180255.GA593378@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116-removed-evoke-1908811ab92a@spud>

On Thu, Jan 16, 2025 at 05:45:33PM +0000, Conor Dooley wrote:
> On Thu, Jan 16, 2025 at 11:07:22AM -0600, Bjorn Helgaas wrote:
> > [+cc Frank, original patch at
> > https://lore.kernel.org/r/20241011140043.1250030-2-daire.mcnamara@microchip.com]
> > 
> > On Thu, Jan 16, 2025 at 04:46:19PM +0000, Conor Dooley wrote:
> > > On Thu, Jan 16, 2025 at 09:42:53AM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> > > > > On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com wrote:
> > > > > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > > > > 
> > > > > > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> > > > > > three general-purpose Fabric Interface Controller (FIC) buses that
> > > > > > encapsulate an AXI-M interface. That FIC is responsible for managing
> > > > > > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > > > > > the Root Port driver needs to take account of that outbound address
> > > > > > translation done by the parent FIC bus before setting up its own
> > > > > > outbound address translation tables.  In all cases on MPFS,
> > > > > > the remaining outbound address translation tables are 32-bit only.
> > > > > > 
> > > > > > Limit the outbound address translation tables to 32-bit only.
> > > > > 
> > > > > I don't quite understand what this is saying.  It seems like the code
> > > > > keeps only the low 32 bits of a PCI address and throws away any
> > > > > address bits above the low 32.
> > > > > 
> > > > > If that's what the FIC does, I wouldn't describe the FIC as
> > > > > "translating the upper 32 bits" since it sounds like the translation
> > > > > is just truncation.
> > > > > 
> > > > > I guess it must be more complicated than that?  I assume you can still
> > > > > reach BARs that have PCI addresses above 4GB using CPU loads/stores?
> > > > > 
> > > > > The apertures through the host bridge for MMIO access are described by
> > > > > DT ranges properties, so this must be something that can't be
> > > > > described that way?
> > > > 
> > > > Ping?  I'd really like to understand this before the v6.14 merge
> > > > window opens on Sunday.
> > > 
> > > Daire's been having some issues getting onto the corporate VPN to send
> > > his reply, I've pasted it below on his behalf:
> > > 
> > > There are 3 Fabric Inter Connect (FIC) buses on PolarFire SoC - each of
> > > these FIC buses contain an AXI master bus and are 64-bits wide. These
> > > AXI-Masters (each with an individual 64-bit AXI base address – for example
> > > FIC1’s AXI Master has a base address of 0x2000000000) are connected to
> > > general purpose FPGA logic. This FPGA logic is, in turn, connected to a
> > > 2nd 32-bit AXI master which is attached to the PCIe block in RootPort mode.
> > > Conceptually, on the other side of this configurable logic, there is a
> > > 32-bit bus to a hard PCIe rootport.  So, again conceptually, outbound address
> > > translation looks like this:
> > > 
> > >                  Processor Complex à FIC (64-bit AXI-M) à Configurable Logic à 32-bit AXI-M à PCIe Rootport
> > > 		 (This how it came to me from Daire, I think the á is meant to
> > > 		 be an arrow)
> > > 
> > >  This allows a designer two broad choices:
> > > 
> > >     Choice of FIC (effectively choice of AXI bus)
> > >     Ability to offset the AXI address of any peripherals they add in the
> > >     Fabric.
> > > 
> > > So, for the case of an outbound AXI address, from the processors’ point
> > > of view (or Linux’ point of view if you prefer), the processor uses a
> > > 64-bit AXI address, then – in a very general way of viewing the process
> > > and thinking only about accessing the PCIe device – the FPGA logic can
> > > be configured to adjust that AXI-M address to any arbitrary “address”
> > > before it passes that new “address” to the Root Port over a second 32-bit
> > > AXI bus (the main constraint is that the FPGA logic can only use a 32-bit
> > > address on that AXI-M interface to the Root Port).
> > > 
> > > To manage this complexity, Microchip have design rules for customers
> > > building their FPGA logic where we strongly recommend that they only
> > > interact with  the upper 32 bits of the 64-bit address in the FPGA logic
> > > and pass the lower 32 bits through (unmodified) to the AXI-M side of the
> > > PCIe Root Port. This allows them to “move” a 64-bit AXI-M window for their
> > > PCIe Root Port (as viewed by the processor) for their particular design –
> > > if they need to - so that they can also access any other AXI-M windows
> > > associated with any other peripherals they might add to their design.
> > > 
> > > In practise, so far, all customers, and our own internal boards have all
> > > started by using one of two major reference designs from us (one using FIC1
> > > where the AXI-M window destined for the PCIe Root Port starts at 0x2000000000
> > > and one using FIC2 where its AXI-M window, again destined for the PCIe Root
> > > Port starts at 0x3000000000).
> > 
> > Is there something special about this that cannot be described by a DT
> > 'ranges' property?  This sounds conceptually similar to Frank's nice
> > picture at
> > https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com
> 
> Aye, it is similar, it is described using ranges properties, will end
> up looking something like:

So is this patch a symptom that is telling us we're not paying
attention to 'ranges' correctly?

The whole point of Frank's patches is to get rid of hard-coded masks
like MC_OUTBOUND_TRANS_TBL_MASK because because 'ranges' should
already contain that information.

If 'ranges' is sufficent to describe the address spaces and
translations between them, the driver wouldn't need to be concerned
with FIC and AXI-M addresses; they would just be described in a
generic way in the DT 'ranges'.

> 	fabric-pcie-bus@3000000000 {
> 		compatible = "simple-bus";
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>,
> 			 <0x30 0x0 0x30 0x0 0x10 0x0>;
> 		dma-ranges = <0x0 0x0 0x0 0x80000000 0x0 0x4000000>,
> 			     <0x0 0x4000000 0x0 0xc4000000 0x0 0x6000000>,
> 			     <0x0 0xa000000 0x0 0x8a000000 0x0 0x8000000>,
> 			     <0x0 0x12000000 0x14 0x12000000 0x0 0x10000000>,
> 			     <0x0 0x22000000 0x10 0x22000000 0x0 0x5e000000>;
> 
> 		pcie: pcie@3000000000 {
> 			compatible = "microchip,pcie-host-1.0";
> 			#address-cells = <0x3>;
> 			#interrupt-cells = <0x1>;
> 			#size-cells = <0x2>;
> 			device_type = "pci";
> 
> 			dma-noncoherent;
> 			reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43008000 0x0 0x2000>, <0x0 0x4300a000 0x0 0x2000>;
> 
> 			ranges = <0x43000000 0x0 0x9000000 0x30 0x9000000 0x0 0xf000000>,
> 				 <0x1000000 0x0 0x8000000 0x30 0x8000000 0x0 0x1000000>,
> 				 <0x3000000 0x0 0x18000000 0x30 0x18000000 0x0 0x70000000>;
> 			dma-ranges = <0x3000000 0x0 0x80000000 0x0 0x0 0x0 0x4000000>,
> 				     <0x3000000 0x0 0x84000000 0x0 0x4000000 0x0 0x6000000>,
> 				     <0x3000000 0x0 0x8a000000 0x0 0xa000000 0x0 0x8000000>,
> 				     <0x3000000 0x0 0x92000000 0x0 0x12000000 0x0 0x10000000>,
> 				     <0x3000000 0x0 0xa2000000 0x0 0x22000000 0x0 0x5e000000>;
> 
> 		};
> 	}




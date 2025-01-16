Return-Path: <linux-pci+bounces-19992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E2A14054
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062443A17EA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88022DC41;
	Thu, 16 Jan 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX3bO30m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D702AE96;
	Thu, 16 Jan 2025 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047245; cv=none; b=lxne3YBeIc02w3X4rmqLj5dWuQ1ggwDARHxvccofYX6C9kHApYEY1j7Bx9S2mOrrUGfIKgAiWGDy5IzcWtX7+n9BadlI8Y/AAT0e7Jt7vPcnky/NrwBYQZ88Is2ODu/hNhsWSByajsHQFUMufwpx0E84oDR0FvliO9y8+LZ34Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047245; c=relaxed/simple;
	bh=pHmOcJZOrilTdmTARnJBuK8Ee8LYE3oxweFl53AmY6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mLiQIkV0ajAxEJfuxapR027QhHaQWfQuEsJf7xRg8v2n8IV1zJDNXTv6t4+nztFyQF0J/6cbFS7Gif7E8ebx/GtmGr/exmYy770HY9qt1jVkf3HM0vfA8hUe1cufmbpEkdPofXh9Du+YSjw8PcCWqiIb7G1TzSzAI+gR+kYos6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX3bO30m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C4C4CED6;
	Thu, 16 Jan 2025 17:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047244;
	bh=pHmOcJZOrilTdmTARnJBuK8Ee8LYE3oxweFl53AmY6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PX3bO30mgoYZOP5FVB/STh23OfeV/3vROEx2TAAi/MVWbjPdtXiXZB2XAHpBz2OHg
	 ybmG1cGM854smS23RtuJG7xsVwg8MLL/wb1vTMvRJHWocQfyr+M5FS8xlEyCigcTej
	 uM7DR200XMszSGAjxh0747KYtMCfqXsTdQkvRGYd/vfYFOyYLIwG0wTgtHXoLZOuug
	 we6iZJMcjIKjYUpX4Y5cR0T9IMktkGZ1RMuVO8C9PXu09ZQvj4iqxhoXWM28u+WN8p
	 Fv/BlqeB6H92yF6biuUVoWRuVBqg6+P806aazHrXbmmXPElYKKbN0uc5hIR1Etv8fG
	 jo9cbjgQwT0gg==
Date: Thu, 16 Jan 2025 11:07:22 -0600
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
Message-ID: <20250116170722.GA589558@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116-debatable-hazelnut-6501986373fa@spud>

[+cc Frank, original patch at
https://lore.kernel.org/r/20241011140043.1250030-2-daire.mcnamara@microchip.com]

On Thu, Jan 16, 2025 at 04:46:19PM +0000, Conor Dooley wrote:
> On Thu, Jan 16, 2025 at 09:42:53AM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com wrote:
> > > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > > 
> > > > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> > > > three general-purpose Fabric Interface Controller (FIC) buses that
> > > > encapsulate an AXI-M interface. That FIC is responsible for managing
> > > > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > > > the Root Port driver needs to take account of that outbound address
> > > > translation done by the parent FIC bus before setting up its own
> > > > outbound address translation tables.  In all cases on MPFS,
> > > > the remaining outbound address translation tables are 32-bit only.
> > > > 
> > > > Limit the outbound address translation tables to 32-bit only.
> > > 
> > > I don't quite understand what this is saying.  It seems like the code
> > > keeps only the low 32 bits of a PCI address and throws away any
> > > address bits above the low 32.
> > > 
> > > If that's what the FIC does, I wouldn't describe the FIC as
> > > "translating the upper 32 bits" since it sounds like the translation
> > > is just truncation.
> > > 
> > > I guess it must be more complicated than that?  I assume you can still
> > > reach BARs that have PCI addresses above 4GB using CPU loads/stores?
> > > 
> > > The apertures through the host bridge for MMIO access are described by
> > > DT ranges properties, so this must be something that can't be
> > > described that way?
> > 
> > Ping?  I'd really like to understand this before the v6.14 merge
> > window opens on Sunday.
> 
> Daire's been having some issues getting onto the corporate VPN to send
> his reply, I've pasted it below on his behalf:
> 
> There are 3 Fabric Inter Connect (FIC) buses on PolarFire SoC - each of
> these FIC buses contain an AXI master bus and are 64-bits wide. These
> AXI-Masters (each with an individual 64-bit AXI base address – for example
> FIC1’s AXI Master has a base address of 0x2000000000) are connected to
> general purpose FPGA logic. This FPGA logic is, in turn, connected to a
> 2nd 32-bit AXI master which is attached to the PCIe block in RootPort mode.
> Conceptually, on the other side of this configurable logic, there is a
> 32-bit bus to a hard PCIe rootport.  So, again conceptually, outbound address
> translation looks like this:
> 
>                  Processor Complex à FIC (64-bit AXI-M) à Configurable Logic à 32-bit AXI-M à PCIe Rootport
> 		 (This how it came to me from Daire, I think the á is meant to
> 		 be an arrow)
> 
>  This allows a designer two broad choices:
> 
>     Choice of FIC (effectively choice of AXI bus)
>     Ability to offset the AXI address of any peripherals they add in the
>     Fabric.
> 
> So, for the case of an outbound AXI address, from the processors’ point
> of view (or Linux’ point of view if you prefer), the processor uses a
> 64-bit AXI address, then – in a very general way of viewing the process
> and thinking only about accessing the PCIe device – the FPGA logic can
> be configured to adjust that AXI-M address to any arbitrary “address”
> before it passes that new “address” to the Root Port over a second 32-bit
> AXI bus (the main constraint is that the FPGA logic can only use a 32-bit
> address on that AXI-M interface to the Root Port).
> 
> To manage this complexity, Microchip have design rules for customers
> building their FPGA logic where we strongly recommend that they only
> interact with  the upper 32 bits of the 64-bit address in the FPGA logic
> and pass the lower 32 bits through (unmodified) to the AXI-M side of the
> PCIe Root Port. This allows them to “move” a 64-bit AXI-M window for their
> PCIe Root Port (as viewed by the processor) for their particular design –
> if they need to - so that they can also access any other AXI-M windows
> associated with any other peripherals they might add to their design.
> 
> In practise, so far, all customers, and our own internal boards have all
> started by using one of two major reference designs from us (one using FIC1
> where the AXI-M window destined for the PCIe Root Port starts at 0x2000000000
> and one using FIC2 where its AXI-M window, again destined for the PCIe Root
> Port starts at 0x3000000000).

Is there something special about this that cannot be described by a DT
'ranges' property?  This sounds conceptually similar to Frank's nice
picture at
https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com

Bjorn


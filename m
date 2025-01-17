Return-Path: <linux-pci+bounces-20071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6DA155BD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 18:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A00164837
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96E19ADA4;
	Fri, 17 Jan 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC6Srpee"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A8A95C;
	Fri, 17 Jan 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135033; cv=none; b=ddUTmK7FyiQyBmkEohqUg3TwLZLHLpHU+7fl5ap1vWxRE3dLednoqxgkRqCZMNi3qN7XSL1CgtyCDNIB4XQqirfH71e4IzwgMKlMipRgLsCCDnpkxLdB99duP9Dx7N749Ba7gUoP9CnGunUHy4vsoA9g1XvIt5EYAg9SEjhaeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135033; c=relaxed/simple;
	bh=NwGjIFCOVGOFl9+7A1WEpEUNm8Gy0ODwXSeX7ZV4b0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ilHlpSVXQLwcOHnI2C6i1OhlN9RHccZZ4+7aP+45lLEEZ+l31TaQlK/GQXPqsb1F06cdNkIW8rtHNceeT4/4EE4Sfat8gfARM8jET9K8tuk0PFAMDNqEcRvugGiqmjgXRKOoiYzfLABWRDkO0D55rpzEl4PiSxOj7jk1s4zgCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC6Srpee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A801C4CEDD;
	Fri, 17 Jan 2025 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737135032;
	bh=NwGjIFCOVGOFl9+7A1WEpEUNm8Gy0ODwXSeX7ZV4b0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GC6SrpeeYdhVCw5M4Tolff+jxWARkXQQMX6zF3nIdU1Db7XkFGodK5kG41/mq6F+P
	 isEia74xwAal9dsd67usF0gIRBoDTsIHcgA4NxR10BseJRZ5YvOoVKSrzcZm96FEuH
	 o77MHPoKvjhmxrz1INycVBC3aAePsP+C9xkxi3mVXEWsDT3kMgXcuJcBUX7HgCidll
	 T+pELHwxcPF86lkI57b1a/LPoum9N5jHZquFnZSO2irhfmrVAsOQn84o8Gr9htrejl
	 UlGHQtwwYnEI3PM3eyuudTH9NDIeW+0fwnCvfyENC3819oAvpQ5o6QJt1MCHzZqSKn
	 k8eJEgfwD0lxg==
Date: Fri, 17 Jan 2025 11:30:31 -0600
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
Message-ID: <20250117173031.GA644050@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117-curliness-flashback-83519e708b52@spud>

On Fri, Jan 17, 2025 at 10:53:01AM +0000, Conor Dooley wrote:
> On Thu, Jan 16, 2025 at 12:02:55PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 16, 2025 at 05:45:33PM +0000, Conor Dooley wrote:
> > > On Thu, Jan 16, 2025 at 11:07:22AM -0600, Bjorn Helgaas wrote:
> > > > [+cc Frank, original patch at
> > > > https://lore.kernel.org/r/20241011140043.1250030-2-daire.mcnamara@microchip.com]
> > > > 
> > > > On Thu, Jan 16, 2025 at 04:46:19PM +0000, Conor Dooley wrote:
> > > > > On Thu, Jan 16, 2025 at 09:42:53AM -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> > > > > > > On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com wrote:
> > > > > > > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > > > > > > 
> > > > > > > > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> > > > > > > > three general-purpose Fabric Interface Controller (FIC) buses that
> > > > > > > > encapsulate an AXI-M interface. That FIC is responsible for managing
> > > > > > > > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > > > > > > > the Root Port driver needs to take account of that outbound address
> > > > > > > > translation done by the parent FIC bus before setting up its own
> > > > > > > > outbound address translation tables.  In all cases on MPFS,
> > > > > > > > the remaining outbound address translation tables are 32-bit only.
> > > > > > > > 
> > > > > > > > Limit the outbound address translation tables to 32-bit only.
> > > > > > > 
> > > > > > > I don't quite understand what this is saying.  It seems like the code
> > > > > > > keeps only the low 32 bits of a PCI address and throws away any
> > > > > > > address bits above the low 32.
> > > > > > > 
> > > > > > > If that's what the FIC does, I wouldn't describe the FIC as
> > > > > > > "translating the upper 32 bits" since it sounds like the translation
> > > > > > > is just truncation.
> > > > > > > 
> > > > > > > I guess it must be more complicated than that?  I assume you can still
> > > > > > > reach BARs that have PCI addresses above 4GB using CPU loads/stores?
> > > > > > > 
> > > > > > > The apertures through the host bridge for MMIO access are described by
> > > > > > > DT ranges properties, so this must be something that can't be
> > > > > > > described that way?
> > > > > 
> > > > > Daire's been having some issues getting onto the corporate VPN to send
> > > > > his reply, I've pasted it below on his behalf:
> > > > > 
> > > > > There are 3 Fabric Inter Connect (FIC) buses on PolarFire SoC - each of
> > > > > these FIC buses contain an AXI master bus and are 64-bits wide. These
> > > > > AXI-Masters (each with an individual 64-bit AXI base address – for example
> > > > > FIC1’s AXI Master has a base address of 0x2000000000) are connected to
> > > > > general purpose FPGA logic. This FPGA logic is, in turn, connected to a
> > > > > 2nd 32-bit AXI master which is attached to the PCIe block in RootPort mode.
> > > > > Conceptually, on the other side of this configurable logic, there is a
> > > > > 32-bit bus to a hard PCIe rootport.  So, again conceptually, outbound address
> > > > > translation looks like this:
> > > > > 
> > > > >                  Processor Complex à FIC (64-bit AXI-M) à Configurable Logic à 32-bit AXI-M à PCIe Rootport
> > > > > 		 (This how it came to me from Daire, I think the á is meant to
> > > > > 		 be an arrow)

I'm trying to match this up with the DT snippet you included earlier:

  fabric-pcie-bus@3000000000 {
    compatible = "simple-bus";
    #address-cells = <2>;
    #size-cells = <2>;
    ranges = <0x00 0x40000000 0x00 0x40000000 0x00 0x20000000>,
	     <0x30 0x00000000 0x30 0x00000000 0x10 0x00000000>;

IIUC, this describes these regions, so there's no address translation
at this point:

  [parent 0x00_40000000-0x00_5fffffff] -> [child 0x00_40000000-0x00_5fffffff]
  [parent 0x30_00000000-0x3f_ffffffff] -> [child 0x30_00000000-0x3f_ffffffff]

Here's the PCI controller:

    pcie: pcie@3000000000 {
      compatible = "microchip,pcie-host-1.0";
      #address-cells = <0x3>;
      #size-cells = <0x2>;
      device_type = "pci";

      reg = <0x30 0x00000000 0x0 0x08000000>,
	    <0x00 0x43008000 0x0 0x00002000>,
	    <0x00 0x4300a000 0x0 0x00002000>;

which has this register space (in the fabric-pcie-bus@3000000000
address space):

  [0x30_00000000-0x30_07ffffff] (128MB)
  [0x00_43008000-0x00_43009fff]   (8KB)
  [0x00_4300a000-0x00_4300bfff]   (8KB)

So if I'm reading this right (and I'm not at all sure I am), the PCI
controller a couple 8KB register regions below 4GB, and also 128MB of
register space at [0x30_00000000-0x30_07ffffff] (maybe ECAM?).  I
don't know how to reconcile this one with the 32-bit AXI-M bus leading
to it.

And it has these ranges, which *do* look like they translate
addresses:

      ranges = <0x43000000 0x0 0x09000000 0x30 0x09000000 0x0 0x0f000000>,
	       <0x01000000 0x0 0x08000000 0x30 0x08000000 0x0 0x01000000>,
	       <0x03000000 0x0 0x18000000 0x30 0x18000000 0x0 0x70000000>;

  [parent 0x30_09000000-0x30_17ffffff] -> [pci 0x09000000-0x17ffffff pref 64bit mem]
  [parent 0x30_08000000-0x30_08ffffff] -> [pci 0x08000000-0x08ffffff io]
  [parent 0x30_18000000-0x30_87ffffff] -> [pci 0x18000000-0x87ffffff 64bit mem]

    };
  }

These look like three apertures to PCI, all of which are below 4GB on
PCI (I'm not sure why the space code is 11b, which indicates 64-bit
memory space).  But all of these are *above* 4GB on the upstream side
of the PCI controller, so I have the same question about the 32-bit
AXI-M bus.

Maybe the translation in the pcie@3000000000 'ranges' should be in the 
fabric-pcie-bus@3000000000 'ranges' instead?

> > So is this patch a symptom that is telling us we're not paying
> > attention to 'ranges' correctly?
> 
> Sounds to me like there's something missing core wise, if you've got
> several drivers having to figure it out themselves.

Yeah, this doesn't seem like something each driver should have to do
by itself.

> Daire seems to think what Frank's done should work here, but it'd need
> to be looked into of course. Devicetree should look the same in both
> cases, do you want it as a new version or as a follow up?

I'd prefer if we could sort this out before merging this if we can.
I'm not sure we can squeeze Frank's work in this cycle; it seems like
we might be able to massage it and figure out some sort of common
strategy for this situation even if DesignWare, Cadence, Microchip,
etc need slightly different implementations.

Bjorn


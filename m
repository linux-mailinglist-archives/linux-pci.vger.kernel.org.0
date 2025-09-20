Return-Path: <linux-pci+bounces-36554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D65B8C033
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5171C059DE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 05:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2223183A;
	Sat, 20 Sep 2025 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDeaTUhg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888A22FE10;
	Sat, 20 Sep 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758347754; cv=none; b=afPR8yoTo92NnkZAV77646KkNnX1QHy4FAbQxzivdYKmnVc/hauSTTWJVjljIQOo0eQVn3uCWIQ06sGnXsFzQzQI8dSjk4nMNRWSi9VcYWyCEjbyEoT13F+RGtlPKKmLWuY/xGMQaGmgmYIEBFFG5sv9ZxgBdafBd9j72lqwKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758347754; c=relaxed/simple;
	bh=3RDjZzLMMBlT8RJqCNxTAYJZ4QvZRiHcC04SCejC1zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op24qGAUjY10YfmafHeQEMKiymaVYPNQSFjwXZlI3PkJ8FMS98TSWg/Jg4QePao/Y5tqQYYo4XwnowzZzLRMWMSetZR0QKPwmo3bR4lHBIdrbdkXBioHPOv9xwj/Zdc17HpBbV54wPuOOGa7WDMlgYBLQmsW9XLWv405Hrvz4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDeaTUhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A74C4CEF1;
	Sat, 20 Sep 2025 05:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758347753;
	bh=3RDjZzLMMBlT8RJqCNxTAYJZ4QvZRiHcC04SCejC1zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDeaTUhgeuweqbb9QWG0erehWBKQb6SOnpKAho6xFa53YFOxdxmARKKzW3KbEHk7E
	 6oIq9HmxM98jyuuwE5dOvYl8N1CCZEIkbAgJkPozGbsB6qdb+owkZUPQUHftgz3Dbs
	 PP0sVus8trOclyB7Ueoyht8ncGy9BfKaw1GYWOrgWjeHYSB2Nvza6twsFgDpNB5nk/
	 zxv+KiQcekQPrUI1HGTsbfPNNqH/NbJfPx6pl1KpPj7k+0akBtu5l1wvUnJOoV4Tw1
	 s8pPgS97BV1VpKEeT0dw6ePg8X4C0NTe2TeSBj89B/VSRY7U555V7IiPw8F7t24sM3
	 +gR5/C66I6OTg==
Date: Sat, 20 Sep 2025 11:25:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, vkoul@kernel.org, 
	kishon@kernel.org, dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de, 
	johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com, 
	quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex
Message-ID: <kam6fgc7ykxwnksu562etrib2z4w3sucvr27ojxq62iwyrdai3@i76ygp2anscy>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
 <tmdq6iut5z2bzemduovvyarya6ho2lwlxvvqqhazw6dnnyjpq3@72xrd2pij42h>
 <804ea57f-699f-41cc-a27c-844f107e627f@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <804ea57f-699f-41cc-a27c-844f107e627f@riscstar.com>

On Fri, Sep 19, 2025 at 03:14:05PM -0500, Alex Elder wrote:
> On 9/15/25 3:14 AM, Manivannan Sadhasivam wrote:
> > On Wed, Aug 13, 2025 at 01:46:57PM GMT, Alex Elder wrote:
> > 
> > Subject should have 'pci' prefix, not 'phy'.
> 
> OK I'll update that in the next version.
> 
> > > Add the Device Tree binding for the PCIe root complex found on the
> > > SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> > > PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> > > link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> > > typically used to support a USB 3 port.
> > > 
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
> > >   1 file changed, 141 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> > > new file mode 100644
> > > index 0000000000000..6bcca2f91a6fd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> > > @@ -0,0 +1,141 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-rc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SpacemiT K1 PCI Express Root Complex
> > > +
> > > +maintainers:
> > > +  - Alex Elder <elder@riscstar.com>
> > > +
> > > +description:
> > > +  The SpacemiT K1 SoC PCIe root complex controller is based on the
> > > +  Synopsys DesignWare PCIe IP.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: spacemit,k1-pcie-rc.yaml
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: DesignWare PCIe registers
> > > +      - description: ATU address space
> > > +      - description: PCIe configuration space
> > > +      - description: Link control registers
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: atu
> > > +      - const: config
> > > +      - const: link
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: DWC PCIe Data Bus Interface (DBI) clock
> > > +      - description: DWC PCIe application AXI-bus Master interface clock
> > > +      - description: DWC PCIe application AXI-bus Slave interface clock.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: DWC PCIe Data Bus Interface (DBI) reset
> > > +      - description: DWC PCIe application AXI-bus Master interface reset
> > > +      - description: DWC PCIe application AXI-bus Slave interface reset.
> > > +      - description: Global reset; must be deasserted for PHY to function
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +      - const: global
> > > +
> > > +  interrupts-extended:
> > > +    maxItems: 1
> > 
> > What is the purpose of this property? Is it for MSI or INTx?
> 
> It is for MSIs, which are translated into this interrupt.
> I'll add a short description indicating this.
> 
> Is there a better way to represent this?
> 

For external MSI controllers, it is recommended to use 'msi-map' property as the
client often need to pass RID, RID length and other sideband data to the MSI
controller.

> > > +
> > > +  spacemit,syscon-pmu:
> > > +    description:
> > > +      PHandle that refers to the APMU system controller, whose
> > > +      regmap is used in managing resets and link state.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > > +  device_type:
> > > +    const: pci
> > > +
> > > +  max-link-speed:
> > > +    const: 2
> > 
> > Why do you need to limit it to 5 GT/s always?
> 
> It's what the hardware overview says is the speed
> of the ports.
>     PCIE PortA Gen2x1
>     PCIE PortB Gen2x2
>     PCIE PortC Gen2x2
> 
> But I think what you're asking might be "why do you
> need to specify in DT that the link speed is limited".
> And in that case, I realize now that it is not needed.
> I will specify dw_pcie->max_link_speed to 2 before
> calling dw_pcie_host_init().
> 

You only need to specify this property if you want to limit the link speed to a
certain data rate by the controller driver than what is supported by the
hardware.

Looks like your hardware supports 5 GT/s by default for all ports. So you can
omit this property and also no need to set 'dw_pcie->max_link_speed'. In the
absence of this property, 'dw_pcie->max_link_speed' will be populated with the
hardware default value, which will be 2 in your case.

> If that's not what you meant, please let me know.
> 
> > > +  num-viewport:
> > > +    const: 8
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - resets
> > > +  - reset-names
> > > +  - spacemit,syscon-pmu
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - device_type
> > > +  - max-link-speed
> > 
> > Same comment as above.
> > 
> > > +  - bus-range
> > > +  - num-viewport
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> > > +    pcie0: pcie@ca000000 {
> > > +        compatible = "spacemit,k1-pcie-rc";
> > > +        reg = <0x0 0xca000000 0x0 0x00001000>,
> > > +              <0x0 0xca300000 0x0 0x0001ff24>,
> > > +              <0x0 0x8f000000 0x0 0x00002000>,
> > > +              <0x0 0xc0b20000 0x0 0x00001000>;
> > > +        reg-names = "dbi",
> > > +                    "atu",
> > > +                    "config",
> > > +                    "link";
> > > +
> > > +        ranges = <0x01000000 0x8f002000 0x0 0x8f002000 0x0 0x100000>,
> > 
> > I/O port CPU address starts from 0.
> 
> First, I'm not sure what this comment means.
> 

Sorry, I meant to say 'PCI address' not 'CPU address'. The second element in
your 'ranges' example corresponds to the PCI start address of the I/O port and
it should always start from 0. Also, the encoding for both tuples are wrong. It
should be:

	ranges = <0x01000000 0x0 0x00000000 0x8f002000 0x0 0x100000>,
		 <0x02000000 0x0 0x80000000 0x80000000 0x0 0x0f000000>; 

- Mani

-- 
மணிவண்ணன் சதாசிவம்


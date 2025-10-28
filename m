Return-Path: <linux-pci+bounces-39498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A45C130AB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D193A7971
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5429B224;
	Tue, 28 Oct 2025 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVK08nZs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC162EB10;
	Tue, 28 Oct 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631136; cv=none; b=Mqkd279Xb56I4k5DHyNDLMIxBsp7NBeOgpM6+cHMKhHcG1TswgYz+T2Nsrgkna4xtlkc7X5nPqBjtngB+J0ROtC3eeRzOygoYI/b021hPFkqWvyw8aZJlIkC3XlDkPpgtClyyTfe9IMjqghaDgsbzI+9JLrJCxJXhSo6/ayofuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631136; c=relaxed/simple;
	bh=5nvub1nz/PwFG6vmA7igkyADbQjAVdws9iOKjuyisY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go93TFOUPHpN7AjfQXNJ+gd27CeTUIjf1m30hXMZ++JYVLC7ytxrZql0iaN+sainqNTTZvbiIF1J0gsVAiQHL2BiLG2UxMCg4RcIaGwh+tw9k0+4qIHj9tk0EF88O4nwfWSCLFB8RodgJZtIpDTs3gpdAG184t/ESfeQEMcWezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVK08nZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F8C4CEFF;
	Tue, 28 Oct 2025 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761631136;
	bh=5nvub1nz/PwFG6vmA7igkyADbQjAVdws9iOKjuyisY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVK08nZssDlFzyc6htZVrgoiLclrduYy+8lpJK6jo55ArO+yABat8i+O7E0WGvFCV
	 DnF/OIZ93EJcX7RwRbSTs3ws/2GmdkuR9cBb00snEKh17EJEhRVWuG+8TFLAIZ3WcL
	 7aa+xbNPMohnqVVj2Q39vSaOeaMiQ13kgoKW7zxooIpSrLEKEh3NR8epqosAgojbli
	 uGP8gfOGNWgWFRSNu/7IdcMQCiAyKCdfxJjX+LNFMMEsiomtWjq8pXgHtIlz6V2mIC
	 Jw62VWaID6H4AUCsyMuP7tpMkHRXd3PAKUK/WZFZgzvFq12juFdKgc1cEjJ7ZGEB9o
	 mGGyRjLbozQ5Q==
Date: Tue, 28 Oct 2025 11:28:40 +0530
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
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
Message-ID: <tjnc4wwpdwlziboonlmki6nm7t523k5atemygwyg7ck5knsde4@anjrtcf5gcq7>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
 <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
 <ae92d3f4-5131-46be-b9b1-e8ec437c9ae9@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae92d3f4-5131-46be-b9b1-e8ec437c9ae9@riscstar.com>

On Mon, Oct 27, 2025 at 05:24:33PM -0500, Alex Elder wrote:
> On 10/26/25 11:38 AM, Manivannan Sadhasivam wrote:
> > On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
> > > Add the Device Tree binding for the PCIe root complex found on the
> > > SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> > > PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> > > link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> > > typically used to support a USB 3 port.
> > > 
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > > v2: - Renamed the binding, using "host controller"
> > >      - Added '>' to the description, and reworded it a bit
> > >      - Added reference to /schemas/pci/snps,dw-pcie.yaml
> > >      - Fixed and renamed the compatible string
> > >      - Renamed the PMU property, and fixed its description
> > >      - Consistently omit the period at the end of descriptions
> > >      - Renamed the "global" clock to be "phy"
> > >      - Use interrupts rather than interrupts-extended, and name the
> > >        one interrupt "msi" to make clear its purpose
> > >      - Added a vpcie3v3-supply property
> > >      - Dropped the max-link-speed property
> > >      - Changed additionalProperties to unevaluatedProperties
> > >      - Dropped the label and status property from the example
> > > 
> > >   .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
> > >   1 file changed, 156 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> > > new file mode 100644
> > > index 0000000000000..87745d49c53a1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> > > @@ -0,0 +1,156 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SpacemiT K1 PCI Express Host Controller
> > > +
> > > +maintainers:
> > > +  - Alex Elder <elder@riscstar.com>
> > > +
> > > +description: >
> > > +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
> > > +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
> > > +  MSI interrupt controller, and supports 256 MSIs.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: spacemit,k1-pcie
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
> > > +  spacemit,apmu:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description:
> > > +      A phandle that refers to the APMU system controller, whose
> > > +      regmap is used in managing resets and link state, along with
> > > +      and offset of its reset control register.
> > > +    items:
> > > +      - items:
> > > +          - description: phandle to APMU system controller
> > > +          - description: register offset
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: DWC PCIe Data Bus Interface (DBI) clock
> > > +      - description: DWC PCIe application AXI-bus master interface clock
> > > +      - description: DWC PCIe application AXI-bus slave interface clock
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
> > > +      - description: DWC PCIe application AXI-bus master interface reset
> > > +      - description: DWC PCIe application AXI-bus slave interface reset
> > > +      - description: Global reset; must be deasserted for PHY to function
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +      - const: phy
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: Interrupt used for MSIs
> > > +
> > > +  interrupt-names:
> > > +    const: msi
> > > +
> > > +  phys:
> > > +    maxItems: 1
> > > +
> > > +  vpcie3v3-supply:
> > > +    description:
> > > +      A phandle for 3.3v regulator to use for PCIe
> > 
> > Could you please move these Root Port specific properties (phy, vpcie3v3-supply)
> > to the Root Port node?
> > 
> > Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> 
> OK, I'll try to follow what that ST binding does (and the
> matching driver).
> 
> > For handling the 'vpcie3v3-supply', you can rely on PCI_PWRCTRL_SLOT driver.
> I looked at the code under pci/pwrctrl.  But is there some other
> documentation I should be looking at for this?
> 

Sorry, nothing available atm. But I will create one, once we fix some core
issues with pwrctrl so that it becomes useable for all (more in the driver
patch).

> It looks like it involves creating a new node compatible with
> "pciclass,0604".  And that the purpose of that driver was to
> ensure certain resources are enabled before the "real" PCI
> device gets probed.
> 
> I see two arm64 DTS files using it:  x1e80100.dtsi and r8a779g0.dtsi.
> Both define this node inside the main PCIe controller node.
> 
> Will this model (with the parent pwrctrl node and child PCI
> controller node) be used for all PCI controllers from here on?
> 

The PCI controller (host bridge) node is the parent and the Root Port node
(which gets bind to pwrctrl slot driver) will be the child.

> Or are you saying this properly represents the relationship of
> the supply with the PCIe port in this SpacemiT case?
> 

We want to use this for all the new platforms and also try to convert the old
ones too gradually.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


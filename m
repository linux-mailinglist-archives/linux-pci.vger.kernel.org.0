Return-Path: <linux-pci+bounces-35638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62448B484DF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADE9189C2B3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 07:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0352E427C;
	Mon,  8 Sep 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxAC9hDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349B13B2A4;
	Mon,  8 Sep 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315769; cv=none; b=JEq5eX2BCzSDzD9OhbWC3rkfSTxtUTb3hRzGcVju2q9iJpxgv5WsyzseOuMyW8jBahW1212PycHTzDwkMnX0H2HlbL4u88CPVTjLRnMRqiNSKqe6OylwCpQsdBXWszkxQ8Iu/TolNKjT17WNTHdDE6hxZo+M6vzbJ7cmiQ+k9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315769; c=relaxed/simple;
	bh=o/X8+JMmZpV94bYmVuVJVdlmLSO/1vPISj70P8f4jik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyidKMzTv/lcQTIvYZUqyMR2kqyRLMJPZ6WpyADeab1UPYEsqPAboABhDrIaslkFol/Cnrx4n3aOY4QADE83cnf6uu2Pap8i1YBkTI8zw7ve9Is/FAep5NJ7oHHYBGEdokzWAxsP1kk5GvxS0pgGFSQ5CFzGoEgaNBSPC63fPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxAC9hDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555BDC4CEF5;
	Mon,  8 Sep 2025 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757315768;
	bh=o/X8+JMmZpV94bYmVuVJVdlmLSO/1vPISj70P8f4jik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxAC9hDGUBNxyibzkldViVQqNA7Ne11OQjw+RsA4iZl5y9KtSvH3wawfkS7Pm9iLK
	 092lO79HND56OmopKwuTqujybgF+d6d/46aIA+rQwEoLYFdvC8U+VgntWHhEQsJdBS
	 8dGC61YLIOkbWnLWtuHrkTZVhxIV5ZPakJzBkH7Fmmy9zNhZdTJOPqzZRcEG+nENhl
	 2KBHYTXlR2dAXaMJ1kXaqm8iD+zLikxOhj0v2hTXz+NmHVYoa1pE+EvsBHkP5FLzzD
	 y9zgaTdSO3AOKqwxWqgUA2FR5QkQ51NfZZdN2GbB+eTEEioTS0wN4jP0WI8PlYQPa5
	 OCwZrh3F4ApdA==
Date: Mon, 8 Sep 2025 12:45:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, 
	shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, 
	mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe
 host controller
Message-ID: <o27wqsjza3rueqhrs3bcf6xevhflgoncjlwzzlnciehjclrq5a@akwpey4jnpbs>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>
 <nq3xoih7kbjdaxnwoduz3o2nxt2ikahbogqdraibznrlqwqw5r@ovjarka5eagm>
 <9cb374f.cc7.19913c6dd06.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cb374f.cc7.19913c6dd06.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Sep 04, 2025 at 04:10:23PM GMT, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > Send time:Monday, 01/09/2025 14:04:50
> > To: zhangsenchuan@eswincomputing.com
> > Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
> > Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe host controller
> > 
> > On Fri, Aug 29, 2025 at 04:22:37PM GMT, zhangsenchuan@eswincomputing.com wrote:
> > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > 
> > > Add Device Tree binding documentation for the ESWIN EIC7700
> > > PCIe controller module,the PCIe controller enables the core
> > > to correctly initialize and manage the PCIe bus and connected
> > > devices.
> > > 
> > > Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> > > Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > ---
> > >  .../bindings/pci/eswin,eic7700-pcie.yaml      | 142 ++++++++++++++++++
> > >  1 file changed, 142 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..65f640902b11
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> > > @@ -0,0 +1,142 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/eswin,eic7700-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Eswin EIC7700 PCIe host controller
> > > +
> > > +maintainers:
> > > +  - Yu Ning <ningyu@eswincomputing.com>
> > > +  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > +
> > > +description:
> > > +  The PCIe controller on EIC7700 SoC.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: eswin,eic7700-pcie
> > > +
> > > +  reg:
> > > +    maxItems: 3
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: config
> > > +      - const: mgmt
> > > +
> > > +  ranges:
> > > +    maxItems: 3
> > > +
> > > +  num-lanes:
> > > +    const: 4
> > > +
> > > +  '#interrupt-cells':
> > > +    const: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 9
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: msi
> > > +      - const: inta
> > > +      - const: intb
> > > +      - const: intc
> > > +      - const: intd
> > > +      - const: inte
> > > +      - const: intf
> > > +      - const: intg
> > > +      - const: inth
> > 
> > What? Are these standard INTx or something elese? PCI(e) spec defines only
> > INT{A-D}.
> > 
> 
> Dear Manivannan
> 
> Thank you for your thorough review .
> You are right, the PCI(e) spec defines only four legacy INTx interrupts (INTA#, INTB#, INTC#,  INTD#). 
> PCI(e) spec defines also mentions that INTX interrupts have two control states (Assert_INTx/Deassert_INTx Message).
> In our yaml, inta~intd corresponds to Assert_INTA~Assert_INTD, and inte~inth corresponds to Deassert_INTA~Deassert_INTD. 
> May I ask if inte~inth needs to be removed or if the naming needs to be standardized? 
> I saw that in "sifive,fu740-pcie.yaml", interrupt-names only retain inta to intd.
> 

If these are actual interrupts and these names align with the interrupt names in
the hardware IP, then you can keep it as it is and should add a comment for
inte-inth:
		- const: inte /* INTA_Deassert */
		...

If not, then you should remove inte-inth.

> > > +
> > > +  interrupt-map:
> > > +    maxItems: 4
> > > +
> > > +  interrupt-map-mask:
> > > +    items:
> > > +      - const: 0
> > > +      - const: 0
> > > +      - const: 0
> > > +      - const: 7
> > > +
> > > +  clocks:
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: mstr
> > > +      - const: dbi
> > > +      - const: pclk
> > > +      - const: aux
> > > +
> > > +  resets:
> > > +    maxItems: 3
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: cfg
> > > +      - const: powerup
> > > +      - const: pwren
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - ranges
> > > +  - num-lanes
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - interrupt-map-mask
> > > +  - interrupt-map
> > > +  - '#interrupt-cells'
> > > +  - clocks
> > > +  - clock-names
> > > +  - resets
> > > +  - reset-names
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        pcie@54000000 {
> > > +            compatible = "eswin,eic7700-pcie";
> > > +            reg = <0x0 0x54000000 0x0 0x4000000>,
> > > +                  <0x0 0x40000000 0x0 0x800000>,
> > > +                  <0x0 0x50000000 0x0 0x100000>;
> > > +            reg-names = "dbi", "config", "mgmt";
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +            #interrupt-cells = <1>;
> > > +            ranges = <0x81000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> > 
> > I/O CPU range starts from 0x0
> > 
> > Also, I don't think you need to set the relocatable flag (bit 31) for any
> > regions.
> 
> if cannot set the relocatable flag (bit 31) for any regions.Is it appropriate to write it this way：
> ranges = <0x01000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
>          <0x02000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
>          <0x43000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> 

Yes.

> > 
> > > +                     <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> > > +                     <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> > > +            bus-range = <0x0 0xff>;
> > > +            clocks = <&clock 562>,
> > > +                     <&clock 563>,
> > > +                     <&clock 564>,
> > > +                     <&clock 565>;
> > 
> > Don't you have clock definitions for these values?
> > 
> 
> Our clock and reset drivers have the definitions of these values, but the clock and reset drivers are under review. 
> Currently, these values can only be replaced by constants.
> 

Ok, you should also mention this in description or cover letter.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


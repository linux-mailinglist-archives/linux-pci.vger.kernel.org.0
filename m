Return-Path: <linux-pci+bounces-4523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E938721AC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2E61C2163C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0702126F04;
	Tue,  5 Mar 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob0xAPCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020786AF8;
	Tue,  5 Mar 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649441; cv=none; b=PMHx0I2P5Oure0BR8R3kxii82eokhbIzQf+1ZLDcyCtOv4aV6V+X1wsrZo9WQGG+3gAy16jKJFwT7uSL8l10bCUl7Lwf8CCvR/5yjwXh9Lesluvmvlfy5HnoMUTRvvGcKQOf38ShL1u6ixRBs/gE05EJef/uCaZlNNVJxIBHYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649441; c=relaxed/simple;
	bh=PFDRnUb1JFhpVTNgo/H8v1Eg/rAvjUdBBtspdiP1xLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuPzNUfaTNC6d6+gcqvKEypjeuB/SQTUkK/bqSluD+jC9rkMaMlSJcjDl02b7GQCjVRV5VGSZ2rW6VfIfB5dXe46b4xkBSkfQYE9FCW2ZSi+j6F6d4djXsDT/YYEq/4L5CokqWoQ5zUNLixVnAtgUpLzzeaWIosUSP2BiKFG51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob0xAPCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257D0C433F1;
	Tue,  5 Mar 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709649441;
	bh=PFDRnUb1JFhpVTNgo/H8v1Eg/rAvjUdBBtspdiP1xLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ob0xAPCXLnUUvG6vKIvGCdR4QIkvh+6lVlInUZZELMJzX4TugqXHs37YyBlGLqW5u
	 Fk83edGu2/KijwfNBfro6CowJf5oGyManQdZK28oysOXKanTgHEiEmX401SNeWBGhr
	 pDemzy0oMPFA5+vvoY98BpTvXvGnGAGjQBbxGojMdHQ9c+q++Bm9WZLnLBAvAX0UW6
	 Vv2HBfeO2R83LicOAvCsR5BFcA3ZyZR5VqrvHISwVMgS3v+14iixMzeET7L2ua1UdP
	 9FDISNiQfWepv9aZz4Tjiqtw6qSQg4PH0A820UB2TF1pCD+MnEaTeE7lG/YcD1mLfE
	 JIwZLdlxlUMhw==
Date: Tue, 5 Mar 2024 08:37:19 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: pci: layerscape-pci-ep: Add
 snps,dw-pcie-ep.yaml reference
Message-ID: <20240305143719.GA3310214-robh@kernel.org>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-4-Frank.Li@nxp.com>
 <20240304182049.GA851904-robh@kernel.org>
 <ZeYcOUAb7NWjTh9m@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeYcOUAb7NWjTh9m@lizhi-Precision-Tower-5810>

On Mon, Mar 04, 2024 at 02:08:41PM -0500, Frank Li wrote:
> On Mon, Mar 04, 2024 at 12:20:49PM -0600, Rob Herring wrote:
> > On Fri, Mar 01, 2024 at 11:27:41AM -0500, Frank Li wrote:
> > > Add snps,dw-pcie-ep.yaml.
> > > 
> > > Remove context that exist in snps,dw-pcie-ep.yaml.
> > > 
> > > Add an example for pcie-ep.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
> > >  1 file changed, 29 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > index cf517e4e46a33..07965683beece 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > @@ -10,8 +10,7 @@ maintainers:
> > >    - Frank Li <Frank.Li@nxp.com>
> > >  
> > >  description:
> > > -  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> > > -  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> > > +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP.
> > >  
> > >    This controller derives its clocks from the Reset Configuration Word (RCW)
> > >    which is used to describe the PLL settings at the time of chip-reset.
> > > @@ -35,31 +34,18 @@ properties:
> > >        - const: fsl,ls-pcie-ep
> > >  
> > >    reg:
> > > -    description: base addresses and lengths of the PCIe controller register blocks.
> > > +    maxItems: 2
> > > +
> > > +  reg-names:
> > > +    maxItems: 2
> > >  
> > >    interrupts:
> > > -    description: A list of interrupt outputs of the controller. Must contain an
> > > -      entry for each entry in the interrupt-names property.
> > > +    minItems: 1
> > > +    maxItems: 3
> > >  
> > >    interrupt-names:
> > >      minItems: 1
> > >      maxItems: 3
> > > -    description: It could include the following entries.
> > > -    items:
> > > -      oneOf:
> > > -        - description:
> > > -            Used for interrupt line which reports AER events when
> > > -            non MSI/MSI-X/INTx mode is used.
> > > -          const: aer
> > > -        - description:
> > > -            Used for interrupt line which reports PME events when
> > > -            non MSI/MSI-X/INTx mode is used.
> > > -          const: pme
> > > -        - description:
> > > -            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > > -            which has a single interrupt line for miscellaneous controller
> > > -            events(could include AER and PME events).
> > > -          const: intr
> > >  
> > >    fsl,pcie-scfg:
> > >      $ref: /schemas/types.yaml#/definitions/phandle
> > > @@ -68,10 +54,7 @@ properties:
> > >        The second entry is the physical PCIe controller index starting from '0'.
> > >        This is used to get SCFG PEXN registers
> > >  
> > > -  dma-coherent:
> > > -    description: Indicates that the hardware IP block can ensure the coherency
> > > -      of the data transferred from/to the IP block. This can avoid the software
> > > -      cache flush/invalid actions, and improve the performance significantly
> > > +  dma-coherent: true
> > >  
> > >    big-endian:
> > >      $ref: /schemas/types.yaml#/definitions/flag
> > > @@ -85,3 +68,24 @@ required:
> > >    - reg
> > >    - interrupt-names
> > >  
> > > +allOf:
> > > +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    soc {
> > > +      #address-cells = <2>;
> > > +      #size-cells = <2>;
> > > +
> > > +      pcie-ep@3400000 {
> > > +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> > > +        reg = <0x00 0x03400000 0x0 0x00100000
> > > +              0x80 0x00000000 0x8 0x00000000>;
> > > +        reg-names = "dbi", "addr_space";
> > > +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> > 
> > PME or...
> > 
> > > +        interrupt-names = "app";
> > 
> > app? You seem to just be changing the names to make the example happy. 
> > What do the dts files have? You need to make those pass.
> 
> It's on my plan.
> 
> First need change 'regs' to 'dbi'. 
> 
> https://lore.kernel.org/linux-pci/20240229194559.709182-1-Frank.Li@nxp.com/
> 
> After that, I can update all dts.

No! 

I'm saying you shouldn't be changing the dts files. That's an ABI 
which you are likely breaking. You should adjust the binding so the dts 
files pass. The exception is if you know the change is safe and not 
going to break the ABI or the dts is just been wrong all along (e.g. 
missing a compatible the OS doesn't rely on).

Rob


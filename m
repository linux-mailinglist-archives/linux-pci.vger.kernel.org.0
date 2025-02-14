Return-Path: <linux-pci+bounces-21452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97AA35DB2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 13:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25153AFD58
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF0263C84;
	Fri, 14 Feb 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="D5Xod9Nn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BE263C73
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536553; cv=none; b=igkddDmFGLldf3mf+vS7nDRCOrzPUopef9wBAku15UneifhV5kFheEISVbpBnIpIY7xMkehAaepoZV6pCcGHWSmSzsE23X2SFZWAqDJh905C2MDTsddgx0Eet/vQWaS4sXpnsx9fBUjGDekAMDRTRfblBdfVUBuN6i7P1XTShjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536553; c=relaxed/simple;
	bh=DhdTMX1B/VBmrfjg4gCD28dH1z0ZeJtuCVVqdYJtLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4LGweHPS1V0C1Zdy6MD3m0J2qfOjs57KIspFno+hHh5raQ032UviEcp7TKP5stdkv/1nLJbb1WOGmeGn/F3fT8ACQnIzOR38uve9bhuhuGftvDPQmB7ZilHMdyfBnkH6SqlKo+fgyN2omEJtzyKMLZVJiTCFlfWx0ByGS16nWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=D5Xod9Nn; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C7341240027
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739536549; bh=DhdTMX1B/VBmrfjg4gCD28dH1z0ZeJtuCVVqdYJtLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=D5Xod9Nnl1WE6g1L7y5neIscsjHlzP9MY5Mw6Agu8uZD51CniEAu5nc1a/M7uOuay
	 FnPzKuG+5DhX1AR2By4JLt2+6SePYX9dxTPP26BbYZz5yslylfLJ5HeYXeZKigJTD8
	 wXckP4BTVk0rpmFwPrtSM3F5JmFkYBbJwcZ9ILZoY9XREALy+R8PMLWVfRJJIqegGR
	 ip0tDQNNZvhC+Ac7P9yckRRncsRnZpwesWfImxAkK3WxgCwLbe+EOgHyElpxRWrYjw
	 JI/8foXkGFM8JegiqDKfVrOw0juWrGF0P67jAcRLWyShcX0FBJqPObf2fUnzLcM0WW
	 OMX71QAVAqbKw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YvWjq1cxCz9rxG;
	Fri, 14 Feb 2025 13:35:41 +0100 (CET)
Date: Fri, 14 Feb 2025 12:35:41 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Frank Li <Frank.li@nxp.com>
Cc: j.ne@posteo.net, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 05/12] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Message-ID: <Z684nUnDX4Sb98rQ@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-5-8137b0c42526@posteo.net>
 <Z6pV4eauZj75+911@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6pV4eauZj75+911@lizhi-Precision-Tower-5810>

On Mon, Feb 10, 2025 at 02:39:13PM -0500, Frank Li wrote:
> On Fri, Feb 07, 2025 at 10:30:22PM +0100, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> >
> > The devicetree bindings for Freescale DMA engines have so far existed as
> > a text file. This patch converts them to YAML, and specifies all the
> > compatible strings currently in use in arch/powerpc/boot/dts.
> >
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >
> > V2:
> > - remove unnecessary multiline markers
> > - fix additionalProperties to always be false
> > - add description/maxItems to interrupts
> > - add missing #address-cells/#size-cells properties
> > - convert "Note on DMA channel compatible properties" to YAML by listing
> >   fsl,ssi-dma-channel as a valid compatible value
> > - fix property ordering in examples: compatible and reg come first
> > - add missing newlines in examples
> > - trim subject line (remove "bindings")
> > ---
> >  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 140 ++++++++++++++
> >  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 123 +++++++++++++
> >  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 134 ++++++++++++++
> >  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
> >  4 files changed, 397 insertions(+), 204 deletions(-)
[...]
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      DMA General Status Register, i.e. DGSR which contains status for
> > +      all the 4 DMA channels.
> 
> needn't maxItems
> items:
>   - description: DMA ...

Good point, I'll do that.

> 
> > +
> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Controller index. 0 for controller @ 0x8100.
> > +
> > +  ranges: true
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Controller interrupt.
> 
> Needn't description because no any additional informaiton.

True.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
[...]
> > +additionalProperties: false
> 
> Need ref to dma-common.yaml?

Sounds good, but I'm not sure what to do about the #dma-cells property,
which is required by dma-common.yaml.

There aren't many examples of DMA channels being explicitly declared in
device trees. One example that I could find is the the xilinx_dma.txt
binding:


	axi_vdma_0: axivdma@40030000 {
		compatible = "xlnx,axi-vdma-1.00.a";
		#dma_cells = <1>;
		reg = < 0x40030000 0x10000 >;
		dma-ranges = <0x00000000 0x00000000 0x40000000>;
		xlnx,num-fstores = <0x8>;
		xlnx,flush-fsync = <0x1>;
		xlnx,addrwidth = <0x20>;
		clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
		clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
			      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
		dma-channel@40030000 {
			compatible = "xlnx,axi-vdma-mm2s-channel";
			interrupts = < 0 54 4 >;
			xlnx,datawidth = <0x40>;
		};
		dma-channel@40030030 {
			compatible = "xlnx,axi-vdma-s2mm-channel";
			interrupts = < 0 53 4 >;
			xlnx,datawidth = <0x40>;
		};
	};

	...

	vdmatest_0: vdmatest@0 {
		compatible ="xlnx,axi-vdma-test-1.00.a";
		dmas = <&axi_vdma_0 0
			&axi_vdma_0 1>;
		dma-names = "vdma0", "vdma1";
	};

It has #dma_cells (I'm sure #dma-cells was intended) on the controller.


Another example is in arch/powerpc/boot/dts/fsl/p1022si-post.dtsi:

	dma@c300 {
		dma00: dma-channel@0 {
			compatible = "fsl,ssi-dma-channel";
		};
		dma01: dma-channel@80 {
			compatible = "fsl,ssi-dma-channel";
		};
	};

	...

	ssi@15000 {
		compatible = "fsl,mpc8610-ssi";
		cell-index = <0>;
		reg = <0x15000 0x100>;
		interrupts = <75 2 0 0>;
		fsl,playback-dma = <&dma00>;
		fsl,capture-dma = <&dma01>;
		fsl,fifo-depth = <15>;
	};


There, the DMA channels are used directly and without additional
information (i.e. #dma-cells = <0>, althought it isn't specified).


> > +        dma-channel@0 {
> > +            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> > +            reg = <0 0x80>;
> > +            cell-index = <0>;
> > +            interrupt-parent = <&ipic>;
> > +            interrupts = <71 8>;
> 
> '8',  use predefine MACRO for irq type.

Good catch, will do

> 
> Frank

Thanks for your review!
J. Neuschäfer


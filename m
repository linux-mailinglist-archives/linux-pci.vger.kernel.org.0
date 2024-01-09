Return-Path: <linux-pci+bounces-1863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA6827D84
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 04:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF5A1F24215
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 03:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9F468B;
	Tue,  9 Jan 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5oQ67HL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C054418;
	Tue,  9 Jan 2024 03:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E683C433C7;
	Tue,  9 Jan 2024 03:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704772176;
	bh=E7n3TsSbDbPjksIo7Blfyj5PMO2YbKS3wrQ5fGz2R58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5oQ67HLaZNAn2pkjhJthcuHCjkORdRQi6bEPqRrA1Qcq2RAIj57r33jmI6jQZSDW
	 exuoE4K/MQxFN+ICDKaMa8DkSQWHfbaDIXio7RvHToQy53SFbDOhBQ16bBA/Hg43Hj
	 lkr6+xAh8ws7o4/N7h2yUodZsQRcjdknnNJDVB1SdDgelKp9sGi2MesaiFn/dOFO6g
	 lnQ1uzFrLiwIlPOT8MEeVZWTWG9QZX/XJknxrvgXdd3nZm6b0eblDTYmRu2HSXl0ZJ
	 ZBgxvVgg65tnpc2j0F3k6JZ8/kFvZhKulGuGNZk1gz2uCURttiTJc2aCEttkKpSl6N
	 AxQbY3dGHGtjg==
Received: (nullmailer pid 2606875 invoked by uid 1000);
	Tue, 09 Jan 2024 03:49:34 -0000
Date: Mon, 8 Jan 2024 20:49:34 -0700
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>, krzysztof.kozlowski@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <20240109034934.GA2602612-robh@kernel.org>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
 <20240107031506.GC3416@thinkpad>
 <ZZos6LDk4NTfQHyU@lizhi-Precision-Tower-5810>
 <20240107051917.GG3416@thinkpad>
 <ZZo4wkHf4RE2O9UN@lizhi-Precision-Tower-5810>
 <20240107062911.GP3416@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107062911.GP3416@thinkpad>

On Sun, Jan 07, 2024 at 11:59:11AM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jan 07, 2024 at 12:38:10AM -0500, Frank Li wrote:
> > On Sun, Jan 07, 2024 at 10:49:17AM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Jan 06, 2024 at 11:47:36PM -0500, Frank Li wrote:
> > > > On Sun, Jan 07, 2024 at 08:45:06AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Dec 27, 2023 at 01:27:15PM -0500, Frank Li wrote:
> > > > > > iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> > > > > > proptery for iMX8MQ to indicate pci controller index.
> > > > > > 
> > > > > 
> > > > > property
> > > > > 
> > > > > > This adjustment paves the way for eliminating the hardcoded check on the
> > > > > > base register for acquiring the controller_id.
> > > > > > 
> > > > > > 	...
> > > > > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > > > 		imx6_pcie->controller_id = 1;
> > > > > > 	...
> > > > > > 
> > > > > > The controller_id is crucial and utilized for certain register bit
> > > > > > positions. It must align precisely with the controller index in the SoC.
> > > > > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > > > > may deactivate specific PCI controllers.
> > > > > > 
> > > > > 
> > > > > You cannot change the binding for the sake of driver. But you can make this
> > > > > change in other way. See below...
> > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > > 
> > > > > > Notes:
> > > > > >     Change from v5 to v6
> > > > > >     - rework commit message to explain why need required and why auto increase
> > > > > >     id not work
> > > > > >     
> > > > > >     Change from v4 to v5
> > > > > >     - new patch at v5
> > > > > > 
> > > > > >  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
> > > > > >  1 file changed, 11 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > > > index d91b639ae7ae7..8f39b4e6e8491 100644
> > > > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > > > @@ -265,6 +265,17 @@ allOf:
> > > > > >              - const: apps
> > > > > >              - const: turnoff
> > > > > >  
> > > > > > +  - if:
> > > > > > +      properties:
> > > > > > +        compatible:
> > > > > > +          contains:
> > > > > > +            enum:
> > > > > > +              - fsl,imx8mq-pcie
> > > > > > +              - fsl,imx8mq-pcie-ep
> > > > > 
> > > > > "linux,pci-domain" is a generic property. So you cannot make it required only
> > > > > for certain SoCs. 
> > > > 
> > > > Sorry, why not? there are many generic property.
> > > > 
> > > 
> > > It doesn't make sense to make it required only for specific SoCs since it is not
> > > specific to any SoC. You can make it required for all.
> > 
> > More than 2 controller need require "linux,pci-domain".
> >
> 
> But this property is applicable to single controller also.

Not really.

I don't understand the issue. Some SoCs have a dependency on the 
numbering and need the property. Others don't. They just want 
(but don't need) consistent numbering. 

Rob


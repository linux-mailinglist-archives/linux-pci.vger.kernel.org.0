Return-Path: <linux-pci+bounces-20720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B250CA27F9F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 00:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A40116422A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4D21D018;
	Tue,  4 Feb 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="JeH//egA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010621CA1B
	for <linux-pci@vger.kernel.org>; Tue,  4 Feb 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738711873; cv=none; b=FbsLzwDX4p5YseVavTw1bG7XhhLcD3Suf3z+vzIOYCwjsGsn9Q7LuTZUQQ0NwFYMImNfRq4aN9WDRlEKC2G030vLs1bY9TPLyq/b7jp6e56uvFqxW2BDAwAbiMm+kSdp72kUrrgaxMD2abtONFdEhLsxwf9myKJBABYDRGt6J3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738711873; c=relaxed/simple;
	bh=dJP28q5tsQaLJ5Y1dJlvwdNzH08V5OcPLoDVQOBCze0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q10gE+W4jY7/Yb/qeBmj8812sUMz48505RkyihZryVRe+uqWMFdwAG+ZbEquWZljKH0t2QrP/EijR0mq8Lcb49wi2Isved0lHWJqPphgEpr+Q8WPdGuxxjXDsUozq+7AuM92DHcWSK6m+CpfaK7HNpVMLZ/6YE0gHgzlxXHddIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=JeH//egA; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 482F224002D
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 00:31:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738711866; bh=dJP28q5tsQaLJ5Y1dJlvwdNzH08V5OcPLoDVQOBCze0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=JeH//egAxdP/noC5RoCMUR3PiFz8ld6VUlVtNLxdHdQ8SVa0TA1wMdmTUh+Elqwc2
	 YF4XtdkaZoixuZJffID+g8XfpiuAhFGAU7d6unfcWOvhDIoZStaY3pjDbYkJXsBBKy
	 GosPqLrzztYl9ylpxFQK5ubT8pb5IttYHtOCXzS7TOSo/aiD+ceeNzAz4fMPciOouH
	 FYWhMleejDIQaZg53HWg6BONww1nKdZ6C3q8JgXjy+kHpRXkh0MdXLAhUC9Qtce/Kx
	 owEjoat9URBVHI6oDP9H4/fZSkfolngK6wRJ9x1TiXd1iPPQehe7ccX3oWIGO+a7NG
	 4D+DKLWIasuWw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YnfkX6mVsz6tvZ;
	Wed,  5 Feb 2025 00:31:00 +0100 (CET)
Date: Tue,  4 Feb 2025 23:31:00 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
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
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Message-ID: <Z6KjNC2tM29h1Z2M@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
 <20250127045004.GE3106458-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127045004.GE3106458-robh@kernel.org>

On Sun, Jan 26, 2025 at 10:50:04PM -0600, Rob Herring wrote:
> On Sun, Jan 26, 2025 at 07:59:01PM +0100, J. Neuschäfer wrote:
> > Supplement Documentation/devicetree/bindings/pci/fsl,pci.txt with a more
> > formal binding in YAML format.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
[...]
> > +title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
> > +
> > +description: |
> > +  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs.
> > +  See also: Documentation/devicetree/bindings/pci/fsl,pci.txt
> 
> Can you move that information here.

Will do.

> 
> > +
> > +maintainers:
> > +  - J. Neuschäfer <j.neuschaefer@gmx.net>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,mpc8308-pcie
> > +              - fsl,mpc8315-pcie
> > +              - fsl,mpc8377-pcie
> > +              - fsl,mpc8378-pcie
> > +          - const: fsl,mpc8314-pcie
> > +      - const: fsl,mpc8314-pcie
> > +      - items:
> > +          - const: fsl,mpc8360-pci
> > +          - const: fsl,mpc8349-pci
> > +      - const: fsl,mpc8349-pci
> > +      - items:
> > +          - const: fsl,mpc8540-pcix
> > +          - const: fsl,mpc8540-pci
> > +      - const: fsl,mpc8540-pci
> > +      - items:
> > +          - const: fsl,mpc8540-pcix
> > +          - const: fsl,mpc8540-pci
> > +      - const: fsl,mpc8548-pcie
> > +      - const: fsl,mpc8548-pcie
> > +      - const: fsl,mpc8641-pcie
> 
> Move all the single 'const' to 1 enum entry.

Will do

> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: internal registers
> > +      - description: config space access registers
> > +
> > +  clock-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Don't need a type for this.

Will change.


Thanks,
J. Neuschäfer


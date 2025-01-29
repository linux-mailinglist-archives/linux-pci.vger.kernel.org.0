Return-Path: <linux-pci+bounces-20545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3AA220B3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301401888435
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703391DF744;
	Wed, 29 Jan 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="rlpkpigg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DB1DE4FE
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165336; cv=none; b=aerRjeAvNnLmICEZUi8Xpe0DCxVzaDtKwe5XlkevF86YN63yix35wbPpSQiJug/Mx7H3axk2M33ot7ykAiQG0momFlzHp2hi9KB3zq4z6vwElprWbn+HGEbkgwMZebXpLbZsI6In5y5X8XXjYEdm4VG8oFhjV24Q6iT/XzAQOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165336; c=relaxed/simple;
	bh=fHuIzrO2wct7VL46Pzm/QKC1E0zvkFPkq1uaLyfrAgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5RbxbTkAEEAYvSUMXRDQF2EzVc0jC5h0PRojW0Gik7xS4vAM3swI4XJi/UUR5PgShG718QSKtWx1G6VrToTkexQZjgrOblTr15aSdmcqKdbsM8PKp8v0Nl/lo41RLrYim7MaB8ZM1eImehtP+ZE5ld2AKFthaARLcbmAAGgWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=rlpkpigg; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id AFF40240028
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 16:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738165326; bh=fHuIzrO2wct7VL46Pzm/QKC1E0zvkFPkq1uaLyfrAgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=rlpkpigg6EUUVDiz1EbkwOjWiYjmdkDcVsxj/Ai7aXCRLX7jud0bjcfEmEwLN8TnJ
	 57a1Tiinb0jjGR09AX0hi4stAQaD8cqqe7u+rYXYFlaUn/p3HcC88sOAGYTk/Ii9OB
	 vyD3bINuDPZZ1vf8KZPKx+2PuLgHk1Ib4fCcjNfDn7MpJEqhtXuGhYb9pcU0PtN68Y
	 Ucq76watDSz5EKsNcWDRaO77DJ7udHihO5cX26smuVsVcWdeCbbhtcjoCCSD32xnv4
	 yc9s8bYo6rvI9Sm6ZRhIyuei2X3a6m2FGM1dMOJsm4XI6hdLJys2btIv4x92LD1Ulg
	 OGvZ1CQi/OYxA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yjmc71lNXz9rxB;
	Wed, 29 Jan 2025 16:41:59 +0100 (CET)
Date: Wed, 29 Jan 2025 15:41:58 +0000
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
Subject: Re: [PATCH 3/9] dt-bindings: crypto: Convert fsl,sec-2.0 binding to
 YAML
Message-ID: <Z5pMRk8WEZZK9TEL@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-3-50649f51c3dd@posteo.net>
 <20250127044128.GB3106458-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127044128.GB3106458-robh@kernel.org>

On Sun, Jan 26, 2025 at 10:41:28PM -0600, Rob Herring wrote:
> On Sun, Jan 26, 2025 at 07:58:58PM +0100, J. Neuschäfer wrote:
> > Convert the Freescale security engine (crypto accelerator) binding from
> > text form to YAML. The list of compatible strings reflects what was
> > previously described in prose; not all combinations occur in existing
> > devicetrees.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  .../devicetree/bindings/crypto/fsl,sec2.0.yaml     | 139 +++++++++++++++++++++
> >  .../devicetree/bindings/crypto/fsl-sec2.txt        |  65 ----------
> >  2 files changed, 139 insertions(+), 65 deletions(-)
[...]
> > +properties:
> > +  compatible:
> > +    description: |
> 
> Don't need '|'. I imagine there are more in the series, but will let you 
> find the rest.

Yes

> > +  fsl,num-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: An integer representing the number of channels available.
> 
> minimum: 1
> maximum: ?

According to existing usage (and a cursory study of datasheets),
possible values are 1 or 4.

> 
> > +
> > +  fsl,channel-fifo-len:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      An integer representing the number of descriptor pointers each channel
> > +      fetch fifo can hold.
> 
> Constraints?

Current usage shows a typical value of 24, although I wasn't able to
find any information in the datasheets. I'll add plausible limits.

> 
> > +
> > +  fsl,exec-units-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The bitmask representing what execution units (EUs) are available.
> > +      EU information should be encoded following the SEC's Descriptor Header
> > +      Dword EU_SEL0 field documentation, i.e. as follows:
> > +
> > +        bit 0  = reserved - should be 0
> > +        bit 1  = set if SEC has the ARC4 EU (AFEU)
> > +        bit 2  = set if SEC has the DES/3DES EU (DEU)
> > +        bit 3  = set if SEC has the message digest EU (MDEU/MDEU-A)
> > +        bit 4  = set if SEC has the random number generator EU (RNG)
> > +        bit 5  = set if SEC has the public key EU (PKEU)
> > +        bit 6  = set if SEC has the AES EU (AESU)
> > +        bit 7  = set if SEC has the Kasumi EU (KEU)
> > +        bit 8  = set if SEC has the CRC EU (CRCU)
> > +        bit 11 = set if SEC has the message digest EU extended alg set (MDEU-B)
> > +
> > +      remaining bits are reserved for future SEC EUs.
> 
> So:
> 
> maximum: 0xfff

Will add.


Thank you for your reviews.

Best regards,
J. Neuschäfer


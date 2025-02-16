Return-Path: <linux-pci+bounces-21561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E32DA37553
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301EB16D6DD
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34955887;
	Sun, 16 Feb 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="pTgJM2RV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D942A8F
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721609; cv=none; b=iS5C6YyXLnhlz4phUbdQw/pX/tQ+OxpBaZUcjstTHa/T7T4jzTSvj3SARJhoFBqZn11q2VmrmdUqFiPb7EQmaitx/RqFsquQKiwlCk7LdXuPl4b6VN7nfEXx4ZXjN6JxJ8Vc+yYt8ep5Mn6z4AnK834isjZXBsWGoihuikvmS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721609; c=relaxed/simple;
	bh=EF26j1suwLuBzziUeMgwWp0X8x4RpIgeD8Jxuuo4ULs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0MY9H8RT8oq8Egg3Qq2aK+WU/RNpZ+NT6KzQOR2892NESriFPH8uaugwZrJcaQpO8rwPcGGlB3URuzgxN6ZNkeNt1DjXUCBUVEuK6p7jXIY7mQzIGMoJxB8o3Y6Tw/ZlVNE3X7WADvb+j/truVVRSqEcflSk4QwZ7iU8mO94Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=pTgJM2RV; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5E215240029
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 17:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739721604; bh=EF26j1suwLuBzziUeMgwWp0X8x4RpIgeD8Jxuuo4ULs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=pTgJM2RVrLprfYbMXybmlG4KLOjVo9E5qpqmA+ccmW85RElh5VpLIRz1jG+WN+S/n
	 /1a+/Z7pYIDe5dnKfrSx017pXnXOnaK0Z4oSx9JPbq5XY211pMBp1oBmcel4YGxq52
	 F3RFdjVJ+IRnPS7aXKXN0RW4qOCHxnRfvy1KzqoSH8ARmyd2EiaZD4HdzFGgnbeGt1
	 EF0887xrzs+xoKfuvZWrJfWF4lUIF/f4kWYDcBTen21LugjWTYJ/6EFcuL+Jof8s8x
	 Rz6Ymj2KIeS3xT0Ke1YT8gFrFa0zSQbesigmbblCfD+ohW23aPetTyHEH8BbIFFnzO
	 aesaOV6qAm6Dw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ywr8V6Vlfz9rxW;
	Sun, 16 Feb 2025 16:59:54 +0100 (CET)
Date: Sun, 16 Feb 2025 15:59:54 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: Crystal Wood <oss@buserror.net>, j.ne@posteo.net,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
	linux-mtd@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML
Message-ID: <Z7ILej_AJYot_wKP@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
 <Z6kQpuQf5m-bXTyt@buserror.net>
 <20250210215324.GA1040564-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210215324.GA1040564-robh@kernel.org>

On Mon, Feb 10, 2025 at 03:53:24PM -0600, Rob Herring wrote:
> On Sun, Feb 09, 2025 at 02:31:34PM -0600, Crystal Wood wrote:
> > On Fri, Feb 07, 2025 at 10:30:26PM +0100, J. Neuschäfer via B4 Relay wrote:
> > > From: "J. Neuschäfer" <j.ne@posteo.net>
> > > 
> > > Convert the Freescale localbus controller bindings from text form to
> > > YAML. The updated list of compatible strings reflects current usage
> > > in arch/powerpc/boot/dts/, except that many existing device trees
> > > erroneously specify "simple-bus" in addition to fsl,*elbc.
> > > 
> > > Changes compared to the txt version:
> > >  - removed the board-control (fsl,mpc8272ads-bcsr) node because it only
> > >    appears in this example and nowhere else
> > >  - added a new example with NAND flash
> > >  - updated list of compatible strings
> > > 
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
> > > 
> > > V2:
> > > - fix order of properties in examples, according to dts coding style
> > > - move to Documentation/devicetree/bindings/memory-controllers
> > > - clarify the commit message a tiny bit
> > > - remove unnecessary multiline markers (|)
> > > - define address format in patternProperties
> > > - trim subject line (remove "binding")
> > > - remove use of "simple-bus", because it's technically incorrect
> > 
> > While I admit I haven't been following recent developments in this area,
> > as someone who was involved when "simple-bus" was created (and was on the
> > ePAPR committee that standardized it) I'm surprised to hear simple-bus
> > being called "erroneous" or "technically incorrect" here.
> 
> Erroneous because the binding did not say "simple-bus" was used. Not 
> uncommon with the old .txt bindings.
> 
> Generally, if a bus has control registers or resources like clocks, then 
> we tend not to call them 'simple-bus'. And '"specific-bus", 
> "simple-bus"' gives some problems around what driver if any do you 
> bind to. 
[...]
> > You'd probably need something like commit 3e25f800afb82bd9e5f8 ("memory:
> > fsl_ifc: populate child devices without relying on simple-bus") and the 
> > subsequent fix in dd8adc713b1656 ("memory: fsl_ifc: populate child
> > nodes of buses and mfd devices")...
> > 
> > I'm curious what the reasoning was for removing simple-bus from IFC.  It
> > seems that the schema verification also played a role in that:
> > https://www.spinics.net/lists/devicetree/msg220418.html
> 
> If a kernel change is needed to support changed .dts files, then we 
> shouldn't be doing that here (being mature platforms). That would mean 
> new DTB will not work with existing kernels.

Alright, I'll keep simple-bus in the eLBC binding for historical
compatibility.


Thank you both for your discussion.


J. Neuschäfer


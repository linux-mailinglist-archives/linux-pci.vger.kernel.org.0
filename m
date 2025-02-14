Return-Path: <linux-pci+bounces-21405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD158A35474
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C33F7A19F0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FEB149C7D;
	Fri, 14 Feb 2025 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Nm3LODJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F81487DC
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498658; cv=none; b=jnoPlyjuLSCjdgtTobpuuN0MwFFQcYPuRdrWXBMks6VkdJz9qOuLeA9ArGMSL2J2jSzce6Hd6x01yaufe3w2FNqJHLraO55/fGs+deCu60Tf6ShO6BSB4FyhzKxt6gKqOJcueoVTQQKKFL5yP48xin/euDJrfE4BR98uqg6Mguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498658; c=relaxed/simple;
	bh=WhJmekLyQeapuWa9J6WUco9/aFXXshTQJPKudksd1Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6i/YS4is8vwbG46dfbb7eVF/VjUGzZx6XqzH1s5uNWfKs6hFWbv2DfB+5ZBAryfA1e4H59NRqbeaM3UNZsW23KioOmXSRt7vYChkJelojo4UjUC8eOj8CvkPSx5IWr10G6OjrO93rhkQtDDAT4cHWmFHInWwssS62KKwqx5NE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Nm3LODJX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B72F7240103
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 03:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739498648; bh=WhJmekLyQeapuWa9J6WUco9/aFXXshTQJPKudksd1Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=Nm3LODJXhqQCCv69Zz1N9FqongFoJT3V0NUa6zSUc6NA8FVuLeDXb1gY6jUNVQHk0
	 za741AL0WLueAGlA/BFA+QKYt3CF9TzSKV5uIWL7ZRmYG65M75ziCewHvxV5bFjNvF
	 iazMruPIDK5iKbKAZ/b3L7MbUm8urNpdqjf+7oZ+ilPu+gH9g8Qi0ILU6wPJ9jr/f2
	 88Oy6Dd1u/V7CrpE27zO9e3Rst0yJX5xnoQo7GnAyMla0eUpw+1+/KNjIMvlu9JPTk
	 Vkmt2BtBE48By8yPb8A9xA3GJCSUKi5lFDCACraCv2ZCkP4OvojLM4EmP/9XViOo53
	 4Xmtf91bi8dMw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YvFhy67kgz9rxF;
	Fri, 14 Feb 2025 03:04:02 +0100 (CET)
Date: Fri, 14 Feb 2025 02:04:02 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
Subject: Re: [PATCH v2 03/12] dt-bindings: crypto: Convert fsl,sec-2.0 to YAML
Message-ID: <Z66kksKzsknmOy5Q@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-3-8137b0c42526@posteo.net>
 <20250212193314.GA4134845-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212193314.GA4134845-robh@kernel.org>

On Wed, Feb 12, 2025 at 01:33:14PM -0600, Rob Herring wrote:
> On Fri, Feb 07, 2025 at 10:30:20PM +0100, J. Neuschäfer wrote:
> > Convert the Freescale security engine (crypto accelerator) binding from
> > text form to YAML. The list of compatible strings reflects what was
> > previously described in prose; not all combinations occur in existing
> > devicetrees.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > 
> > V2:
> > - several improvements suggested by Rob Herring:
> >   - remove unnecessary multiline markers
> >   - constrain fsl,num-channels to enum: [1,4]
> >   - constrain fsl,channel-fifo-len to plausible limits
> >   - constrain fsl,exec-units-mask to maximum=0xfff
> > - trim subject line (remove "binding")
> > ---
> >  .../devicetree/bindings/crypto/fsl,sec2.0.yaml     | 142 +++++++++++++++++++++
> >  .../devicetree/bindings/crypto/fsl-sec2.txt        |  65 ----------
> >  2 files changed, 142 insertions(+), 65 deletions(-)
[...]
> > +title: Freescale SoC SEC Security Engines versions 1.x-2.x-3.x
> > +
> > +maintainers:
> > +  - J. Neuschäfer <j.ne@posteo.net.
> 
> missing >

Good catch, will fix.


> > +  fsl,descriptor-types-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The bitmask representing what descriptors are available. Descriptor type
> > +      information should be encoded following the SEC's Descriptor Header Dword
> > +      DESC_TYPE field documentation, i.e. as follows:
> > +
> > +        bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
> > +        bit 1  = set if SEC supports the ipsec_esp descriptor type
> > +        bit 2  = set if SEC supports the common_nonsnoop desc. type
> > +        bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
> > +        bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
> > +        bit 5  = set if SEC supports the srtp descriptor type
> > +        bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
> > +        bit 7  = set if SEC supports the pkeu_assemble descriptor type
> > +        bit 8  = set if SEC supports the aesu_key_expand_output desc.type
> > +        bit 9  = set if SEC supports the pkeu_ptmul descriptor type
> > +        bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
> > +        bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
> 
> Why 3 variations of 'descriptor type'?

The reasons have been lost in time, I suppose. I'll normalize the spelling.


Thanks,
J. Neuschäfer


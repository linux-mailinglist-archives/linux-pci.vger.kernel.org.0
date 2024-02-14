Return-Path: <linux-pci+bounces-3426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9F8542B3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 07:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7854A1F26229
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 06:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E9C10A34;
	Wed, 14 Feb 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xw7/W+tV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2C10A2B
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891261; cv=none; b=K7nIakwKCHNs7U6ysP5RupxPP4Ng3TCAHLo5AZNjLKJlWzM/Tg3yCEziD5IZKlrny9N9xttN/cjDFIKK3QuYYnyIa8GwoEAQ/GlONJGWUbS8M2DXzB/ecPelVWGzSpykxsBlyI82DTF0NVWtvdDPrFAZ2cDfIeSfo8DXyPPmb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891261; c=relaxed/simple;
	bh=wzr+kLlknr1luythVXCJluevwdFGrIq8/RzBWxobG6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qts/m88xsaSYnB/OW+o/DEEjk2SzeohF+9OO4156WPgbE64BmT6/j5918TKd1xZ4k+sVrQgVk88NLFKEF3jXO+e0/9g2hF0buxAnsFeG2isIinDVV5S8+BVEotty0T6ss+i/Rndcxl8jWeQbkZMuaqaID1XFw4It0mUYqdUEaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xw7/W+tV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e10ac45684so194565b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 22:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707891258; x=1708496058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEAtaGDufDWhtM/apq9lA9fVfmRBlWSvuuyTiSpPBN8=;
        b=Xw7/W+tVn8tz15TyiDSxyuzY4yirc23V07bRiZp+cXe/AjFkdy0RNggkAWlZQV1hy6
         E5qkwPt54YMs7jNZBZcn3sAXCinEFMJkcHOhFCMPRayTQhHMELXmwJh7SX0w7kVKrcv1
         qdwFVZiuxMVUgfcJTd1fuSq7t3KATMqlZjmRAPKRirOCWcxNBCovdUmP00l8CUKcIg/0
         T+/8JZmIcg+knHVHgQBSEazqsnpqiPuhL+eIhIzu9dXudJ1u728qeM0d2m3WHI5roje3
         TmkcmZbJsBQPorJNVMy2PruO/A3whSHoXyeL1cxVi2N4whYEbaHpHLoPnm4wHeuwmwA4
         YpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891258; x=1708496058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEAtaGDufDWhtM/apq9lA9fVfmRBlWSvuuyTiSpPBN8=;
        b=eDF6uCgjf8S0UJ1ZK1UO4U5akc9f5LGQofkGJar5ORcYBBFkSzgogJ2kskpZuUR2vA
         3IfyEP0/S7RI0zbqGLxrfu9skjpmTIC0FSak2am+9gtAWLnCDgErAstCJCtdPlrv9tmm
         MswLY0gyxRAaccpguDeIKlyGsU+YSeOTv6SnXDlNK4hLkiw5LpYHzCyAZR14zm6kJHpD
         tVNBZCuIzQmnpDK7z0eiicYI9a629QceXNkmJfzpqe1XGlq/wc+ViMipXsWUFhc9IlqJ
         o9oCsypEPnoJ5hKdCSeHg1h/IdZzuHR291b8jIZc2CZazxgJJzmaKh38x/4w+sQV6vRB
         LdRw==
X-Forwarded-Encrypted: i=1; AJvYcCXFT51Q+bPKVupoDpE3FNey92sYdiJMkFHsMW60f6tq3YNLMWJVtHbQ+ObI2zuISAiu6yyI5zEbpbWFiJTMwnR5A1uOJrQ06WK4
X-Gm-Message-State: AOJu0Ywe689bTJ6UTuVVG++0HFxIdVBX4xtHqc938y5XTiZMHHT3gkTO
	zQSJJHRhXyGJjZx2R0JDAuEKv/HaBoq82xQvS+3ctvSG1JQqTafp/97vd2eQVw==
X-Google-Smtp-Source: AGHT+IHH8BKMmvWEAPzi0hPOk/HvNEBJyCiOUf4JLgbW6hCkwVsGkA/J5ewFI76o82rIsRzpH229/A==
X-Received: by 2002:a05:6a00:4588:b0:6e0:4e85:54f0 with SMTP id it8-20020a056a00458800b006e04e8554f0mr1429326pfb.28.1707891258180;
        Tue, 13 Feb 2024 22:14:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVw7tJYklSfjZdOK6xrlMPX/1pq0rFvKiLd5xqumFKql4taN9YfYfNDhokaiWsduAa/gKNFasJjotO82HBEWszENDUapy3J7KUH26QCAdtyrzwCV4itAMMLDHRu1FkYxYrN8RuUeRxCy5ENCKBaLFuoT6IRO46KlcObp1M8rhY9/2XgZ6qGIXhbLscBbzQrRN4qOFUVSEJuJ/JumDqLECGBuMrds4DjIJrjXfiDP3sI1B0OE8GW6V02kjaUh9P0M9ylsT9jkBfETYVcfsWuh0RwHhXNf3UsyGgsni+SnG4D7hlJjMgAMh3HBkHiZVFz53cTqfJ1IDezavyOkYqwPuTTFNwFUUtfSS5o2y8mdNeh4t3cDrsNflJEk9QBObslHK6u5k6ZMt3QZSjGd78SRWsn5B0BFdOqvnYq5k2FlTsP2GV98ZC74GqYYIwU2sIWq0=
Received: from thinkpad ([103.28.246.149])
        by smtp.gmail.com with ESMTPSA id ko19-20020a056a00461300b006ddc75edd55sm8314448pfb.152.2024.02.13.22.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:14:17 -0800 (PST)
Date: Wed, 14 Feb 2024 11:44:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <20240214061412.GB4618@thinkpad>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>

On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > 
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > 
> > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > >            const: config
> > > > > > > > +        - description:
> > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > +          const: msg
> > > > > > > 
> > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > 
> > > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > > just configure this on its own. However, since we don't describe all of 
> > > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > > would have to be handled differently too.
> > > > > 
> > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > > 
> > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > 
> > > > @rob:
> > > > 
> > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > detail direction?
> > > 
> > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > property:
> > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > 
> > > So basically Rob meant back then that
> > > either originally we should have defined a new reg-name like "atu-out"
> > > with the entire outbound iATU CPU-space specified and unpin the
> > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > or, well, stick to the chunking further. The later path was chosen
> > > after the patch with the "ecam" reg-name was accepted (see the link
> > > above).
> > > 
> > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > TLPs, etc are all application-specific features. Each of them is
> > > implemented based on a bit specific but basically the same outbound
> > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > of view it would have been enough to describe the entire outbound iATU
> > > CPU address space and then let the software do the space
> > > reconfiguration in runtime based on it' application needs.
> > 
> > There are "addr_space" in EP mode, which useful map out outbound iatu
> > region. We can reuse this name.
> > 
> > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > mem region. We can config each region size by module parameter or drvdata.
> > 
> > So we can deprecate 'config', even 'ranges'
> 
> Not sure I fully understand what you mean. In anyway the "config" reg
> name is highly utilized by the DW PCIe IP-core instances. We can't
> deprecate it that easily. At least the backwards compatibility must be
> preserved. Moreover "addr_space" is also just a single value reg which
> won't solve a problem with the disjoint DW PCIe outbound iATU memory
> regions.
> 
> The "ranges" property is a part of the DT specification.  The
> PCI-specific way of the property-based mapping is de-facto a standard
> too. So this can't be deprecated.
> 
> > 
> > > 
> > > * Rob, correct me if am wrong.
> > > 
> > > On the other hand it's possible to have more than one disjoint CPU
> > > address region handled by the outbound iATU (especially if there is no
> > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > in HW manual). Thus having a single reg-property might get to be
> > > inapplicable in some cases. Thinking about that got me to an idea.
> > > What about just extending the PCIe "ranges" property flags
> > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > use the flag to define a custom memory range for the TLP messages
> > > generation. At some point it can be also utilized for the config-space
> > > mapping. What do you think?
> > 
> 
> > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> > all IORESOURCE_* bit need move. And it is actual MEMORY regain. 
> 
> No. The lowest four bits aren't flags but the actual value. They are
> retrieved from the PCI-specific memory ranges mapping:
> https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> Currently only first four out of _sixteen_ values have been defined so
> far. So we can freely use some of the free values for custom TLPs,
> etc. Note the config-space is already defined by the ranges property
> having the 0x0 space code (see the first link above), but it isn't
> currently supported by the PCI subsystem. So at least that option can
> be considered as a ready-to-implement replacement for the "config"
> reg-name.
> 

Agree. But still, the driver has to support both options: "config" reg name and
"ranges", since ammending the binding would be an ABI break.

> > 
> > Or we can use IORESOURCE_BITS (0xff)
> > 
> > /* PCI ROM control bits (IORESOURCE_BITS) */
> > #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> > 
> > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> > #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> > 
> > we can add
> > 
> > IORESOURCE_PRIV_WINDOWS			(1<<6)
> > 
> > I think previous method was more extendable. How do you think?
> 
> IMO extending the PCIe "ranges" property semantics looks more
> promising, more flexible and more portable across various PCIe
> controllers. But the most importantly is what Rob and Bjorn think
> about that, not me.
> 

IMO, using the "ranges" property to allocate arbitrary memory region should be
the way forward, since it has almost all the info needed by the drivers to
allocate the memory regions.

But for the sake of DT backwards compatiblity, we have to keep supporting the
existing reg entries (addr_space, et al.), because "ranges" is not a required
property for EP controllers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


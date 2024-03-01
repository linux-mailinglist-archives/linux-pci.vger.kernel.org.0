Return-Path: <linux-pci+bounces-4321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0A86E07D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BBB1C2136E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEA6D517;
	Fri,  1 Mar 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKtcjxVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8856CDB8;
	Fri,  1 Mar 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292960; cv=none; b=GM+Yl3Od3FDaeODMdOIjFGsXmSJWDOM1VlYw9f4aBdI2bf1fjSlRdmWKs4lK8DgvfknSIOZbv/zXhYfuuUfbbQUK9Sp/scr0Ra1Of7hLBzcB6KhdmamQruaNtKkfDjFzUaeHZ+MRpP8xcQprsbwrlQkzcUib8igd7eYRRj1eYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292960; c=relaxed/simple;
	bh=hPPHRYYAjiKuYUJwYFhwQn9E72JeoeyndtnS4GMdisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2tv1YNlLf8OwOnW2+WLJ7F1fMKYMjD1N66KAFM4ohFZiw7rSZ/fLd2OMQlZ5YJK7kKNplear0m3tEbYYBuTYsP8UFqgZ6CQvY0E9dgkOB6i19vzD55yjMJNjR8xxPtCgs6VDf68teXcCVSkz+8VR2FB4ZO2/sIvrfhfdCojTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKtcjxVV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d220e39907so26166231fa.1;
        Fri, 01 Mar 2024 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292956; x=1709897756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oG0Vik/QGVVOFzHpt8Mm/tI6pp6RkAP0Ak6yL3nJBJk=;
        b=FKtcjxVVZQ5ZLlK1eCXGNObpTWFO/j7Lcbrt87EBS3G9KoqMlVKVwl5kOoPWjNGUEj
         xsXmK9sr7RKXUAo6J106ILZRXUiI86yzfDrt5V/pEyOFEXQki0scBsbAXgg+8ZX+kMvI
         9tS1hTEk/kv0D7xzTjMXIQGh9OWNoLKEOhoze0l2ev6Xzao8DVfFZUVdHa4f5221nEPl
         6htbl8VQwjMglbyLMldhiCzHTfgkCNc0zsCLD4Nkrve+jU0zECAI6GQCmsIqH2Xvu2cJ
         L5ngetN+ecahwudwCqWT9xtjKUwnj9nGeb+7jMwSABWSs47xi3imTTFVht0fWGLeznlH
         R9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292956; x=1709897756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG0Vik/QGVVOFzHpt8Mm/tI6pp6RkAP0Ak6yL3nJBJk=;
        b=nlI3MzK54xuLpAnVHt9wS9J9WmPF5gtaMXofoojgFcUlUp1ekJZsLOxwDGB9uH8x+x
         Na0Vv6064RSdBiG+P5TdvH/1O6YcBY61IhXmplSti0R5pNMVUydLPPAaLThiTuQizyKQ
         vL5wq+wMs7G4s8jhQbAzpbSHO/Gt60NEf2A6eoHZVy5z9LuiJ8VG3rviCL39lON1mRnJ
         jCyBbhMjGNctPTS8CS2QyueiUhMINzuCOhtp/WCRVzplNbHUBlT0/w2AzqaPzQgRrKph
         t0+OeY33G1yOYpEZxCQPgSirkdxnBn+16ZeIpacx9Ocl4huce0PQGhU3flffmd3J09Zc
         wQAg==
X-Forwarded-Encrypted: i=1; AJvYcCXHh5njTrdaazElT7SpLVYfYqDtyl4T9bpQvUqJ5BdvFrGYcxe1FG4ZNYPqH2Y6Rh9Izzgo54jXAfxsebVspkv3j9h8fh/TZ0/6b2Q6Ug2ZY2yvZ3ckvjF/EQHDItX/1quB7NCICG4H/BmxR28Fn9Ocp4lEW7ekVHDdXWwBUT6qBOmPGA==
X-Gm-Message-State: AOJu0YwZWMeNdmOOGlBzxNddZTeF8uRns4aUVfEurBThY8x0vODqeY9W
	lj8lsi3myYsIcJLqJxC8AE0/iv1aM2sr9IJamXP52cL57SI3vpS6
X-Google-Smtp-Source: AGHT+IGK7QW3ogiAzxjZwcNgqVyVh3UuMSj8wNdeB2Pd2IJ4jutKLIF7fWJT9v2CjhKSjaGhkVTcew==
X-Received: by 2002:a19:6454:0:b0:512:f833:38d9 with SMTP id b20-20020a196454000000b00512f83338d9mr1198954lfj.30.1709292956146;
        Fri, 01 Mar 2024 03:35:56 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x24-20020ac25dd8000000b005131f41e0b8sm582449lfq.76.2024.03.01.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:35:55 -0800 (PST)
Date: Fri, 1 Mar 2024 14:35:52 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <pprkba3ygxwv4lzieu5spqamcn2gzdcviv4kb2kzkzam4fbhit@6uqtmevzm5uj>
References: <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
 <20240228160346.GA4069607-robh@kernel.org>
 <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
 <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
 <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>
 <ZeCmTXte5OBTcyna@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeCmTXte5OBTcyna@lizhi-Precision-Tower-5810>

On Thu, Feb 29, 2024 at 10:44:13AM -0500, Frank Li wrote:
> On Thu, Feb 29, 2024 at 02:26:34PM +0300, Serge Semin wrote:
> > On Wed, Feb 28, 2024 at 06:39:36PM -0600, Rob Herring wrote:
> > > On Wed, Feb 28, 2024 at 10:23 AM Frank Li <Frank.li@nxp.com> wrote:
> > > >
> > > > On Wed, Feb 28, 2024 at 10:03:46AM -0600, Rob Herring wrote:
> > > > > On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > > > > > > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > > > > > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > > > > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > > > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > > > > > >
> > > > > > > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > > > > > > >            const: config
> > > > > > > > > > > > > > +        - description:
> > > > > > > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > > > > > > +          const: msg
> > > > > > > > > > > > >
> > > > > > > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > > > > > >
> > > > > > > > > > > > I do think it is a bit questionable. Ideally, the driver could
> > > > > > > > > > > > just configure this on its own. However, since we don't describe all of
> > > > > > > > > > > > the CPU address space (that's input to the iATU) already, that's not
> > > > > > > > > > > > going to be possible. I suppose we could fix that, but then config space
> > > > > > > > > > > > would have to be handled differently too.
> > > > > > > > > > >
> > > > > > > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU.
> > > > > > > > > > >
> > > > > > > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > > > > > >
> > > > > > > > > > @rob:
> > > > > > > > > >
> > > > > > > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > > > > > > detail direction?
> > > > > > > > >
> > > > > > > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > > > > > > property:
> > > > > > > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > So basically Rob meant back then that
> > > > > > > > > either originally we should have defined a new reg-name like "atu-out"
> > > > > > > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > > > > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > > > > > > or, well, stick to the chunking further. The later path was chosen
> > > > > > > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > > > > > > above).
> > > > > > > > >
> > > > > > > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > > > > > > TLPs, etc are all application-specific features. Each of them is
> > > > > > > > > implemented based on a bit specific but basically the same outbound
> > > > > > > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > > > > > > of view it would have been enough to describe the entire outbound iATU
> > > > > > > > > CPU address space and then let the software do the space
> > > > > > > > > reconfiguration in runtime based on it' application needs.
> > > > > > > >
> > > > > > > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > > > > > > region. We can reuse this name.
> > > > > > > >
> > > > > > > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > > > > > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > > > > > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > > > > > > mem region. We can config each region size by module parameter or drvdata.
> > > > > > > >
> > > > > > > > So we can deprecate 'config', even 'ranges'
> > > > > > >
> > > > > > > Not sure I fully understand what you mean. In anyway the "config" reg
> > > > > > > name is highly utilized by the DW PCIe IP-core instances. We can't
> > > > > > > deprecate it that easily. At least the backwards compatibility must be
> > > > > > > preserved. Moreover "addr_space" is also just a single value reg which
> > > > > > > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > > > > > > regions.
> > > > > > >
> > > > > > > The "ranges" property is a part of the DT specification.  The
> > > > > > > PCI-specific way of the property-based mapping is de-facto a standard
> > > > > > > too. So this can't be deprecated.
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > * Rob, correct me if am wrong.
> > > > > > > > >
> > > > > > > > > On the other hand it's possible to have more than one disjoint CPU
> > > > > > > > > address region handled by the outbound iATU (especially if there is no
> > > > > > > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > > > > > > in HW manual). Thus having a single reg-property might get to be
> > > > > > > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > > > > > > What about just extending the PCIe "ranges" property flags
> > > > > > > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > > > > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > > > > > > use the flag to define a custom memory range for the TLP messages
> > > > > > > > > generation. At some point it can be also utilized for the config-space
> > > > > > > > > mapping. What do you think?
> > > > > > > >
> > > > > > >
> > > > > > > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS,
> > > > > > > > all IORESOURCE_* bit need move. And it is actual MEMORY regain.
> > > > > > >
> > > > > > > No. The lowest four bits aren't flags but the actual value. They are
> > > > > > > retrieved from the PCI-specific memory ranges mapping:
> > > > > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > > > > > > Currently only first four out of _sixteen_ values have been defined so
> > > > > > > far. So we can freely use some of the free values for custom TLPs,
> > > > > > > etc. Note the config-space is already defined by the ranges property
> > > > > > > having the 0x0 space code (see the first link above), but it isn't
> > > > > > > currently supported by the PCI subsystem. So at least that option can
> > > > > > > be considered as a ready-to-implement replacement for the "config"
> > > > > > > reg-name.
> > > > > > >
> > > > > >
> > > > > > Agree. But still, the driver has to support both options: "config" reg name and
> > > > > > "ranges", since ammending the binding would be an ABI break.
> > > > > >
> > > > > > > >
> > > > > > > > Or we can use IORESOURCE_BITS (0xff)
> > > > > > > >
> > > > > > > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > > > > > > #define IORESOURCE_ROM_ENABLE           (1<<0)  /* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > > > > > > #define IORESOURCE_ROM_SHADOW           (1<<1)  /* Use RAM image, not ROM BAR */
> > > > > > > >
> > > > > > > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > > > > > > #define IORESOURCE_PCI_FIXED            (1<<4)  /* Do not move resource */
> > > > > > > > #define IORESOURCE_PCI_EA_BEI           (1<<5)  /* BAR Equivalent Indicator */
> > > > > > > >
> > > > > > > > we can add
> > > > > > > >
> > > > > > > > IORESOURCE_PRIV_WINDOWS                 (1<<6)
> > > > > > > >
> > > > > > > > I think previous method was more extendable. How do you think?
> > > > > > >
> > > > > > > IMO extending the PCIe "ranges" property semantics looks more
> > > > > > > promising, more flexible and more portable across various PCIe
> > > > > > > controllers. But the most importantly is what Rob and Bjorn think
> > > > > > > about that, not me.
> > > > > > >
> > > > > >
> > > > > > IMO, using the "ranges" property to allocate arbitrary memory region should be
> > > > > > the way forward, since it has almost all the info needed by the drivers to
> > > > > > allocate the memory regions.
> > > > > >
> > > > > > But for the sake of DT backwards compatiblity, we have to keep supporting the
> > > > > > existing reg entries (addr_space, et al.), because "ranges" is not a required
> > > > > > property for EP controllers.
> > > > >
> > > > > I don't know that its worth the effort to carry both. Maybe if it is
> > > > > useful on more than just DW host.
> > > > >
> > > > > I believe we had config space in ranges at some point on some
> > > > > binding and moved away from that. I forget the reasoning.
> > > >
> > > > I can alloc a 64k windows from IORESOURCE_MEM windows to do 'msg' windows
> > > > in dwc host driver in v4.
> > > >
> > > > But I think it is wonthful to discuss if we can extend of_map bits, add
> > > > more type beside CONFIG/IO/MEM/MEM64.
> > > >
> > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > >
> > > > phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> > > >
> > 
> > > > There are '000' before 'ss'.  If we use it as dwc private resource.
> > 
> > Frank, why do you mis-inform about the idea? The point was to use the
> 

> I am not sure where I mis-inform.

Right in these words: "If we use it as dwc private resource." I never
said it should have been DWC-only feature. I explicitly stated that
the solution would be portable across various devices:

On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> IMO extending the PCIe "ranges" property semantics looks more
> promising, more flexible and more portable across various PCIe
> controllers.

> 
> > ranges property for:
> > 1. PCIe Config-space mapping.
> 
> This one already exist. Just dwc driver have not use it for unknown reason.
> We can change driver to support it if want. That will not related
> dt-binding.

I bet this won't be that easy. PCIe subsystem code will need to be fixed
too, at least the devm_of_pci_get_host_bridge_resources() method and
subordinates.

>  
> > 2. PCIe TLP messages region.
> 

> So far, as I known, PCIe spec only define TLP message format, not define
> 'region'.

PCIe-spec != DT-spec.

> DWC choose use mmio region to send TLP message by ATU.

So is a lot of other controllers:
Rockchip PCIe controller (see pcie-rockchip.h AXI_WRAPPER_* macros)
Cadence PCIe controller (see pcie-cadence.h CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_* macros)
Mediatek PCIe Gen3 controller (see pcie-mediatek-gen3.c PCIE_ATR_TLP_TYPE() macro)
...

Moreover as you said yourself PCIe-spec doesn't define "regions". It's
always about TLPs. IO, MEM, CFG, INTx, PME, Vendor-defined, etc all is
kind of TLPs. Yet at least the first three are described by the
"ranges" DT-property.

Anyway let's look further in the PCIe-spec. Please note paragraph
2.1.1. of for instance the PCIe-4.0 spec:

2.1.1  Address Spaces, Transaction Types, and Usage
"Transactions form the basis for information transfer between a
Requester and Completer. Four _address spaces_ are defined, and
different Transaction types are defined, each with its own unique
intended usage, as shown in Table 2-12."

Address Space     | Transaction Types    |  Basic Usage
Memory            | Read/Write           | Transfer data to/from a
                  |                      | memory-mapped location
I/O               | Read/Write           | Transfer data to/from an
                  |                      | I/O-mapped location
Configuration     | Read/Write           | Device Function config/setup
_Message_         | Baseline (including  | From event signaling mechanism
                  | Vendor–Defined)      | to general purpose messaging

So basically the PCIe-spec defines four _address spaces_. The
_message_ space is one of them. Seeing the "ranges" DT-property is
about the space-to-space mapping there is nothing wrong with using it
for the _message_ space mapping. 

> May other
> hardware can define a register, fill TLP related information, then issue
> TLP message.

So can be, and originally was, done for the PCI config-space access.
See Mediatek PCIe controller (see pcie-mediatek.c
mtk_pcie_hw_wr_cfg()/mtk_pcie_hw_rd_cfg()) and more than half of the
drivers/pci/controllers/pci-*.c drivers. Yet we have the DT-spec
defining the PCIe-"ranges" property with the config-space mapping.

Moreover DW PCIe controllers perform the mem-to-tlp translation in the
AHB/AXI-bridge module. If not for that the address space transactions
are generated by means of the XALI/TRGT interfaces, which is a set of
the wires/signals. They can be used by the device engineers to
implement _any_ interface they wish for _any address space_. So
basically the memory, I/O and config-space transfers can be
theoretically implemented by the indirect CSRs IO in hardware. Another
story is who would wish to do that if there is a ready-to-use and
handy AXI/AHB bridges with simple memory-based interface...

> 
> > There is _nothing_ DWC-specific in the original suggestion. Case 1 has
> > already implicitly defined by the DT standard, see the link above (but
> > for some reason hasn't been implemented in the PCIe subsystem). Case 2
> > hasn't been determined, but could be seeing there are three unused
> > bits in the ss-code of the phys.hi cell. All of that can be used by
> > _any_ PCIe RC/EP device.
> 
> Please give some exmaple how you plan use these bits. 'msg' region may be
> an example, although rob doesn't like.

Rob didn't like _your_ interpretation of the suggested approach.

Anyway the implementation may look as follows:

ranges = <0x82000000 0 0x00000000 0 0xe0000000 0 0x10000000>, /* mem */
         <0x81000000 0 0x10000000 0 0xf0000000 0 0x00010000>, /* io */
         <0x80000000 0 0x10010000 0 0xf0010000 0 0x00010000>, /* cfg */
         <0x84000000 0 0x10020000 0 0xf0020000 0 0x00010000>; /* mem - note new space code 0x4 */

So the "cfg" region can be used instead of the "config" reg-name (a
more correct replacement for that), and the "mem" region with not-yet
defined space code could be utilized for various message TLPs
described in the "2.2.8 Message Request Rules" paragraph (PCIe 4.0
spec). We can go further and define various message-mapping like INTx,
PM, Vendor-specific, Locked transaction, etc, which IMO would be
better than using a single type for all kinds of the messages seeing
PCIe-spec have them described.. But it's better to get the Rob and
Bjorn opinion about the _actual_ suggestion first.

-Serge(y)

> 
> Frank
> 
> > 
> > > 
> > > DWC (or any host controller) specific things? No!
> > 
> > Rob, could you please dive deeper in this thread? The idea is to use
> > the "ranges" property for the "config" (PCIe config space) and the
> > custom PCIe TLP messages regions.

> > 
> > -Serge(y)
> > 
> > > 
> > > Rob


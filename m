Return-Path: <linux-pci+bounces-4469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA78709D2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F791F230FB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33E7869E;
	Mon,  4 Mar 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2AZW5xm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479762147;
	Mon,  4 Mar 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578144; cv=none; b=g280BvRvqgUHzW1PV10VHG6gPHMzk9CyRSfji3A3cnTBTLJq5sQHrOgLl3tXRSd9elqmHlqlR8BCbBbowWBOoQuR+CSplQdE3huWWTE5trEcc28gw8xkIdtnJ1ZKL3al+QZLiIQKHbOLQGlSn0uAea9NtCOrUcQg/VCMTKf8XK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578144; c=relaxed/simple;
	bh=wCeMmjOVaelKD8oogKosv57Mla3F7vrvDFGNe7ukOGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+gAqvBcdjXeGUgKcyCvBbHjPHPmnkKJLdgMA2jg83Uz7C1Q7Lw5tpyMXgEbEKe6otN9wt+VNPSMNgW0mxXlrbN8INEYPOR8QNwx9PGnGBy4+QLHh3khkYShGab5jxs3vJ858KfpNymu7VvSg25JN3r4eHRvkwivbsZlkCCSjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2AZW5xm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d228a132acso63633881fa.0;
        Mon, 04 Mar 2024 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578140; x=1710182940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWoJrpZOS87hlJNbNLhOaG5cqW5NwVFhPcdY4O3k/7I=;
        b=Z2AZW5xmabxQtOMwi1WgIC8LYDJ/v4OJKOW9ww/i9/CSnNVFknEbv7tNRAc0z7WImh
         9MRCq1lNcuEoMoPFCqaqEpNpPVfrUi8vuhwDJXJd0MWm0BAEnnbTiaDZamgZr96HPgbl
         q15VmyOzLgpS3IZAxPBRTJ1WPEN5wi/t6P49tyhp38jkebPvYsH97AwQMFj+Ppx8A6QU
         nPJesJDGsVZGmqUWd4vpXvv//zXl0MuQAXxJo8rH8UqmMIalxXg/ArmAyijGkxxA7S8Y
         3cnzCHdiuAQRDDeOUWFo2ls2Eyf21hBXmb9oDpQJ63UJDVKsNs9qNByk44RYAn28Yzcj
         KwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578140; x=1710182940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWoJrpZOS87hlJNbNLhOaG5cqW5NwVFhPcdY4O3k/7I=;
        b=rwjzshWhU9vj9NS3+OWVDSVFgtUDhngLgGc4Xvksxr0oEw7jL2VQF2CnAHYG7uWZqK
         4EwvLOLUaYxdaOfyHhQesvBRJRmWtv6l5ce+R4oSTFYVbKZ9p3nawYPwfLlPmF6ZBzwZ
         pLmx0OIIiT8D3PGLysTeXIhTEqHMKfGoTRdgl2whcSPLwMyVab9WkvAvvqvgwjbkWODW
         to61vbHyePiib5Xt5RpLGQuQv2zJd91C2fWNNt4U3uioWKgz0DaMZfwM+9myt5eRWfac
         53XdM2IlxPrjSJpvczngs3Xy8zWRRvkj7Eg7RXfgR16997vOruzgoGqqkLNF239JHoKC
         IZtw==
X-Forwarded-Encrypted: i=1; AJvYcCWfAzEuEs00Zhpx/rBUyBGLLLPv8jP/jG5Oai2KpbN3v5T+ySu/KRvk10pcEsEHDU6IzDuW1Ba7S183L/AKSvYLuyD2jEV5+SMVtduzzzLIVgj1Vt1TbUaI394rQGFxZhU+/IP6YqOv5Elzj2DZoiUq4+yzHePT9ul/GuQwGWX3mH4pSg==
X-Gm-Message-State: AOJu0Yw0Js0RSjoARgm4kUucTjgY75CTBoPiVuDRBQsqGby5FQTp+rkS
	DdsGu6Ag0GgK+MGWMzlbu2iGjRXCC9HmWv4ccS3j8r7MZWK/hjk4M/hZD6le
X-Google-Smtp-Source: AGHT+IE1xMAXUtFeWgPIAWFRo1Vl3Spqn6vhYkTizrLe8m+VQjFdgpfNvg8BUjW+dZPJVm/Oud5cbw==
X-Received: by 2002:a05:6512:308b:b0:513:2011:3d2f with SMTP id z11-20020a056512308b00b0051320113d2fmr7761213lfd.9.1709578139832;
        Mon, 04 Mar 2024 10:48:59 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t5-20020a056512208500b00512e263d246sm1840674lfr.296.2024.03.04.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:48:59 -0800 (PST)
Date: Mon, 4 Mar 2024 21:48:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <3nu77xnuaq7pb7lmct76n37n7g5snwhcghgodqd5q6paihdxbp@4imk4w2qfrlx>
References: <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
 <20240228160346.GA4069607-robh@kernel.org>
 <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
 <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
 <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>
 <20240301160816.GA2221899-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301160816.GA2221899-robh@kernel.org>

On Fri, Mar 01, 2024 at 10:08:16AM -0600, Rob Herring wrote:
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
> > ranges property for:
> > 1. PCIe Config-space mapping.
> > 2. PCIe TLP messages region.
> > There is _nothing_ DWC-specific in the original suggestion. Case 1 has
> > already implicitly defined by the DT standard, see the link above (but
> > for some reason hasn't been implemented in the PCIe subsystem). Case 2
> > hasn't been determined, but could be seeing there are three unused
> > bits in the ss-code of the phys.hi cell. All of that can be used by
> > _any_ PCIe RC/EP device.
> > 
> > > 
> > > DWC (or any host controller) specific things? No!
> > 
> > Rob, could you please dive deeper in this thread? The idea is to use
> > the "ranges" property for the "config" (PCIe config space) and the
> > custom PCIe TLP messages regions.
> 

> I did in my prior response. Here, I was just making it clear that 
> something host controller specific is a non-starter as you did.

Not sure what exactly you meant by "host controller specific". Did you
mean a particular host-controller or all the host-controllers? I meant
that the "msg" range could be used by _any_ host-controller, but the
usage would be platform-specific indeed because the message-type depends on
the peripheral devices.

> 
> For config, we had some bindings that did this and we moved away from 
> it. I don't remember the details. Unless it's ECAM region, I don't think 
> using ranges makes any sense as how to use the region will still be host 
> specific.

Could you please elaborate why exactly the config-region would still
be host-specific? Strictly speaking the normal MEM or IO region is
also host-specific because what lays behind depends on the attached
device and the enumeration procedure. IMO the reason of not using the
'ranges' for the config/ECAM space would be in opposite to what you
said.  Unlike the CPU-to-MEM/IO mapping the ECAM/config-space is a
pre-determined _linear_ space with in most of the case no need in
special space remapping (unless we would wish to map particular
peripheral device config-space). So normal "reg" is enough especially
seeing the config-space is a set of registers. (Please correct me if I
was wrong.)

> 
> For TLP messages, do we have other hosts that could use ranges for them? 

AFAICS the next controllers might also be able to generate the
messages via the outbound AT-memory:
Rockchip PCIe controller (see pcie-rockchip.h AXI_WRAPPER_* macros)
Cadence PCIe controller (see pcie-cadence.h CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_* macros)
Mediatek PCIe Gen3 controller (see pcie-mediatek-gen3.c PCIE_ATR_TLP_TYPE() macro)
...
although I am not absolutely sure.

> Is there something in the PCIe spec that defines TLP as an address 
> space and what that address space looks like? IIRC, some hosts (Altera?) 
> just have a message sending interface and that includes config space 
> accesses.

I already sited it in the message to Frank here:
https://lore.kernel.org/linux-pci/pprkba3ygxwv4lzieu5spqamcn2gzdcviv4kb2kzkzam4fbhit@6uqtmevzm5uj/
Here is an excerpt from there:

< Note paragraph 2.1.1. of for instance the PCIe-4.0 spec:
< 
< 2.1.1  Address Spaces, Transaction Types, and Usage
< "Transactions form the basis for information transfer between a
< Requester and Completer. Four _address spaces_ are defined, and
< different Transaction types are defined, each with its own unique
< intended usage, as shown in Table 2-12."
< 
< Address Space     | Transaction Types    |  Basic Usage
< -------------------------------------------------------------------------
< Memory            | Read/Write           | Transfer data to/from a
<                   |                      | memory-mapped location
< I/O               | Read/Write           | Transfer data to/from an
<                   |                      | I/O-mapped location
< Configuration     | Read/Write           | Device Function config/setup
< _Message_         | Baseline (including  | From event signaling mechanism
<                   | Vendor–Defined)      | to general purpose messaging
< 
< So basically the PCIe-spec defines four _address spaces_. The
< _message_ space is one of them. Seeing the "ranges" DT-property is
< about the space-to-space mapping IMO there is nothing wrong with using
< it for the _message_ space mapping.

As you can see the MEM, IO, config and Message are defined as address
space. Looking at the message request description in the spec, there
can be various types of the messages. All of them are listed in "2.2.8
Message Request Rules". Some of them can be routed by _address_ or
_ID_ (BDF), but some of them can lack of any address/ID field. In
accordance with the "Table 2-17: Message Routing" footnote there is no
message requests defined at the moment with the Address-based routing.
In the meantime for the address-less messages there is no address
translation needs to be performed, thus having the ranges-based
mapping would be just pointless for them. But if we had a message
request defined with the address-based routing then it might have
required a mapping similar to the MEM and IO ones.

Anyway giving to all of that a second thought, I more-and-more getting
further away from my original idea of having the config and message
region mapped over the "ranges" property. There is no actual address
translation performed at least in the second cases. So using the "ranges"
property for it would be pointless indeed... ( But originally the idea
seemed very attractive seeing the PCIe-specific "ranges" property has
unused mapping type flags and permitted special address format...


Let's get back to the Frank work then. What would you suggest as a
good solution? There are two options at the moment:
1. Define DWC-specific "msg" reg-name with a peace of the outbound
iATU space which would be used to generate the messages. (thus
implementing the same approach as being utilized for the config-space
mapping).
2. Manually, in the driver, reserve a peace of the CPU-to-PCIe-MEM
"ranges" region and have it utilized for the message request TLPs
(implemented in this patch).

The later one seems less safe since the entire outbound iATU range
could be dedicated for some platform-specific means. So reserving
a peace of it will cause problems in those platforms.

-Serge(y)

> 
> Rob


Return-Path: <linux-pci+bounces-3281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DF84F2B4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98DB1C22287
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B5A2A;
	Fri,  9 Feb 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHcVyIYP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BE69941;
	Fri,  9 Feb 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472380; cv=none; b=hyHeBN9tM757kg1wRzDaN1nnBiCk4WbTZiw4aon5jkvNSC1jXqEeNIVftsVJDZ/ZY8reEudVi4rO1lEI+tg0IfKEMUe6ClF9F2UE/wwL10IHxlQW5MY/gxyYUHRr+wdMdIB3zrXcApiqO7T1jNSTuk0B3YRwjkLhh6pgyPWylek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472380; c=relaxed/simple;
	bh=iVzoL3o7JUS146pZQBt+eZtE43hCFkiCYA9D9Tpn9lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHO5KDBJfSRwgSlNQcAkeLh+iydUIUH/MTak3hZ+1sH4CfmmuxvvXAMEKqJRIzQteZKYLpV5IwchjQK1ZAR7HLY290MCzT/IUbP8vsBkiiRErD9f2KXSSbs2VOi1g15P9SFS8+vqO94sWeVgTB4FPpDqNvxizGYohQ3blgN+tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHcVyIYP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso2011709e87.0;
        Fri, 09 Feb 2024 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707472376; x=1708077176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiV2K5pZJw71dGzNyLKMSPjJLxHQRGdnK/KkiTE5WaY=;
        b=bHcVyIYPVpy/2y5aeYISRptqqc2a18CHRJZG1Ts1ncgY0jxDclMtAtuuPBT4RBqJ4E
         i8M6gatNwseA68eSezqtjWBFk4kB0qumZYh/GoFnQnw5FFlcrpFhcrFrpznVI80+IXSR
         Gp8AaA/+/tIKJ7kIn9VabkleZTol3PDjprQHgbIKcWUoD5XhKkPR6zArCt8TcTnhFhxh
         vnYqRW9KpQCrI9sCnI5NADD9b4mMIu2rjVs63Xa+pmOFdlUxPulmtAgdya1T0LDVEX87
         CxogV9qBALKhKzexfPo+wf9yCd1JYDwp+Ee7ZWI3rvdnBdqVf9F087/V9R7FdmrO22YC
         roVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707472376; x=1708077176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiV2K5pZJw71dGzNyLKMSPjJLxHQRGdnK/KkiTE5WaY=;
        b=WRBQDkHpv6yIayu7M+owmnmyzfZORuhY6J3ZwyMlbFvgD06e7dSXiP664BmebEvjUa
         wsM64J8XWC2NTPfy5w4g0P97+K8YJt8v9oK31k74prIl1CQTEkzTKUfcBsbdNIRybIDN
         29IQH0JGirJn3wHQvwk68hchGZ7NvDVPMBe4XCUbm8Kt3F9TQPRc8sW7SCulDJD9JxYe
         m4gYM7UrglRWjVtuWMMX3rz7MHhbqTtxsWqKRLBdXBDS75YOsEjcwenVS8NhV0FMiVDq
         PQ0bE0z+pi13RDVJH9zTcWVfvXmO+B+B9th09F7ZW5ItJFHtFtEXg80BEerodgz3PQ2o
         eRDA==
X-Forwarded-Encrypted: i=1; AJvYcCVzj1hj8SOa3a8eB0huU4CR004GRNhqGnxm9RHwMgyma/0QO3hg882TBdKh6zBP5fQNFmY5HzwJ91sLGTsKcnwGTph4Dbb+ljWVX8bDDbsrI7Oo1hLlBGMQFv4vtOqSzHByW1AJOohznweuDfd5QdY2arroaScvxbho0n/q5UzSvGf6Ag==
X-Gm-Message-State: AOJu0Yx4cFvonQmRUAKor+Ao6peQayxTu501bbQzCCuw45mXAjcdRkkg
	97xpEF+5hmtjNgRZ46qLNWnEeLpnRf5N+1d2YEgJ1HcH3xFJTg9h
X-Google-Smtp-Source: AGHT+IHkRzAfsj6AV5nFtVc0uRgnhec7BneScP04Ft7o+QBqpDeEz/4O/PlmlO1S7CmcKMtPYmhr2w==
X-Received: by 2002:ac2:5611:0:b0:511:3bce:9157 with SMTP id v17-20020ac25611000000b005113bce9157mr211091lfd.9.1707472376208;
        Fri, 09 Feb 2024 01:52:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4Nlogw9/inrehVzw1A/MaI06NEnGBb2Wd+Ej1VNkQrwDQRJkb8zsZaHSsNJdSa8t2W5F54hkpFTcu9nSQhbEuSPWrQZrj7zYM0O8HeB7ZuwOLpHKG8rRr4a8bZpzio4QDjoF5FTNtaoP86eTNMcXCLJc/UMwhb9QtpgXgBRhI8DcHZKNY+z0H2OIu1YuWCvn9PRSIZsJw4PKuAbcLvqHBzXOoOOx/yjnxOxJkm6fvQ7D+1QOnm7quvabMZoK0QGKEA+BkOQHf++ld6Clb/f+tDJyq3Uey3uqVytSMj4ryOmXP+mDFmJnlxsVV8qSRB2FQHSYQO26F6YeRIpdQHKLDOi4wRVqqhc0MJWkRgh1bRCY2B/CILpe+6KYx1aw/3pVvGCAidwUry1IKmJzAdna5ovfx8ThVhrHPE/cOXgi3DW7lyjjXPEpEr0sWQRkasJ07Se4B/+1jHoOZr1o=
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q28-20020ac246fc000000b0051134f1cf5fsm237130lfo.271.2024.02.09.01.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:52:55 -0800 (PST)
Date: Fri, 9 Feb 2024 12:52:52 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>

On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > 
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > 
> > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > >            const: config
> > > > > > > +        - description:
> > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > +          const: msg
> > > > > > 
> > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > similar semantics I guess won't receive warm welcome.
> > > > > 
> > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > just configure this on its own. However, since we don't describe all of 
> > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > would have to be handled differently too.
> > > > 
> > > > Sorry, I have not understand what your means. Do you means, you want
> > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > 
> > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > 
> > > @rob:
> > > 
> > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > detail direction?
> > 
> > Found the Rob' note about the iATU-space chunks utilized in the reg
> > property:
> > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > 
> > So basically Rob meant back then that
> > either originally we should have defined a new reg-name like "atu-out"
> > with the entire outbound iATU CPU-space specified and unpin the
> > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > or, well, stick to the chunking further. The later path was chosen
> > after the patch with the "ecam" reg-name was accepted (see the link
> > above).
> > 
> > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > TLPs, etc are all application-specific features. Each of them is
> > implemented based on a bit specific but basically the same outbound
> > iATU engine setup. Thus from the "DT is a hardware description" point
> > of view it would have been enough to describe the entire outbound iATU
> > CPU address space and then let the software do the space
> > reconfiguration in runtime based on it' application needs.
> 
> There are "addr_space" in EP mode, which useful map out outbound iatu
> region. We can reuse this name.
> 
> To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> mem region. We can config each region size by module parameter or drvdata.
> 
> So we can deprecate 'config', even 'ranges'

Not sure I fully understand what you mean. In anyway the "config" reg
name is highly utilized by the DW PCIe IP-core instances. We can't
deprecate it that easily. At least the backwards compatibility must be
preserved. Moreover "addr_space" is also just a single value reg which
won't solve a problem with the disjoint DW PCIe outbound iATU memory
regions.

The "ranges" property is a part of the DT specification.  The
PCI-specific way of the property-based mapping is de-facto a standard
too. So this can't be deprecated.

> 
> > 
> > * Rob, correct me if am wrong.
> > 
> > On the other hand it's possible to have more than one disjoint CPU
> > address region handled by the outbound iATU (especially if there is no
> > AXI-bridge enabled, see XALI - application transmit client interfaces
> > in HW manual). Thus having a single reg-property might get to be
> > inapplicable in some cases. Thinking about that got me to an idea.
> > What about just extending the PCIe "ranges" property flags
> > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > use the flag to define a custom memory range for the TLP messages
> > generation. At some point it can be also utilized for the config-space
> > mapping. What do you think?
> 

> IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> all IORESOURCE_* bit need move. And it is actual MEMORY regain. 

No. The lowest four bits aren't flags but the actual value. They are
retrieved from the PCI-specific memory ranges mapping:
https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
Currently only first four out of _sixteen_ values have been defined so
far. So we can freely use some of the free values for custom TLPs,
etc. Note the config-space is already defined by the ranges property
having the 0x0 space code (see the first link above), but it isn't
currently supported by the PCI subsystem. So at least that option can
be considered as a ready-to-implement replacement for the "config"
reg-name.

> 
> Or we can use IORESOURCE_BITS (0xff)
> 
> /* PCI ROM control bits (IORESOURCE_BITS) */
> #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> 
> /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> 
> we can add
> 
> IORESOURCE_PRIV_WINDOWS			(1<<6)
> 
> I think previous method was more extendable. How do you think?

IMO extending the PCIe "ranges" property semantics looks more
promising, more flexible and more portable across various PCIe
controllers. But the most importantly is what Rob and Bjorn think
about that, not me.

-Serge(y)

> 
> > 
> > -Serge(y)
> > 
> > > 
> > > Frank
> > > 
> > > > 
> > > > Frank
> > > > 
> > > > > 
> > > > > Rob


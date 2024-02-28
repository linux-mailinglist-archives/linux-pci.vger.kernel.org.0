Return-Path: <linux-pci+bounces-4190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF4E86B412
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 17:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B801C212F2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC415D5BF;
	Wed, 28 Feb 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA8bFHb2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB121487DC;
	Wed, 28 Feb 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136229; cv=none; b=XRs6aO2CZBQ5KaSTZlF8YQoKOp/RLcnM7DdTpHgy0oRKMC3CA0aK5sJMutKsK2eMvsRY0sMEVmWAstb7FUQ+CGSlde0klnKkRrebVYTIwkBJH8MlzrayLAIA6v6wzKOxlmLTmhbbONqJxZb8EW2PYGfItjMkIYYgTpJE7TMS7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136229; c=relaxed/simple;
	bh=jVbwmQ5ZFgtabGqg7urBabSzgD0huGSHM7cVVYaegUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVl3P+szMzWhDdWlzBDfXtg0rM+8uCtOiy/nV5aLcDBWBMnqALhj0Z30YqPgLAStog0WnvDoZu2zHR0nhq0fZ7HMzmOymTar2vZiMEyfwfc/6Ou0M30+GyEX5OKOFf7DV8IYWRHypexX7qxRP9zucpQbLxPU+AFvH4c+27mmx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA8bFHb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3FBC433C7;
	Wed, 28 Feb 2024 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709136229;
	bh=jVbwmQ5ZFgtabGqg7urBabSzgD0huGSHM7cVVYaegUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jA8bFHb2ecDcc7pzqHtmz152M7s3OWHtMU4CPKKfThrDSqp47vbtgw1psPCC5Ph73
	 A7geVh30RIqh+9ONW9dsYuBB3xLqwDeoxgA73Wi6NyxRLTCAgqlsgOWsJJuAPMCHCw
	 TQqmYMUf6qm5Zv/p3Y3J1veQe01wngqXYNKmhPBBCXhEhKb1UwsQavnhoLnE5JvCIo
	 teXfj0/i2YU3cg8wn9MHDGFVECD8BSI61c06Zy6UT0JgerNpB5Iq6Ot2AsvjeHRth3
	 8YmX9fJSjTh8EZ4psEuVS88PLdFF49OShp1n73di4VSnkhRdbwrkcVWLJgv8pJopmq
	 Nt+dObfumCFiQ==
Date: Wed, 28 Feb 2024 10:03:46 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Frank Li <Frank.li@nxp.com>,
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
Message-ID: <20240228160346.GA4069607-robh@kernel.org>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214061412.GB4618@thinkpad>

On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > 
> > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > >            const: config
> > > > > > > > > +        - description:
> > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > +          const: msg
> > > > > > > > 
> > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > 
> > > > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > > > just configure this on its own. However, since we don't describe all of 
> > > > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > > > would have to be handled differently too.
> > > > > > 
> > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > > > 
> > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > 
> > > > > @rob:
> > > > > 
> > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > detail direction?
> > > > 
> > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > property:
> > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > 
> > > > So basically Rob meant back then that
> > > > either originally we should have defined a new reg-name like "atu-out"
> > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > or, well, stick to the chunking further. The later path was chosen
> > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > above).
> > > > 
> > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > TLPs, etc are all application-specific features. Each of them is
> > > > implemented based on a bit specific but basically the same outbound
> > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > of view it would have been enough to describe the entire outbound iATU
> > > > CPU address space and then let the software do the space
> > > > reconfiguration in runtime based on it' application needs.
> > > 
> > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > region. We can reuse this name.
> > > 
> > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > mem region. We can config each region size by module parameter or drvdata.
> > > 
> > > So we can deprecate 'config', even 'ranges'
> > 
> > Not sure I fully understand what you mean. In anyway the "config" reg
> > name is highly utilized by the DW PCIe IP-core instances. We can't
> > deprecate it that easily. At least the backwards compatibility must be
> > preserved. Moreover "addr_space" is also just a single value reg which
> > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > regions.
> > 
> > The "ranges" property is a part of the DT specification.  The
> > PCI-specific way of the property-based mapping is de-facto a standard
> > too. So this can't be deprecated.
> > 
> > > 
> > > > 
> > > > * Rob, correct me if am wrong.
> > > > 
> > > > On the other hand it's possible to have more than one disjoint CPU
> > > > address region handled by the outbound iATU (especially if there is no
> > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > in HW manual). Thus having a single reg-property might get to be
> > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > What about just extending the PCIe "ranges" property flags
> > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > use the flag to define a custom memory range for the TLP messages
> > > > generation. At some point it can be also utilized for the config-space
> > > > mapping. What do you think?
> > > 
> > 
> > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> > > all IORESOURCE_* bit need move. And it is actual MEMORY regain. 
> > 
> > No. The lowest four bits aren't flags but the actual value. They are
> > retrieved from the PCI-specific memory ranges mapping:
> > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > Currently only first four out of _sixteen_ values have been defined so
> > far. So we can freely use some of the free values for custom TLPs,
> > etc. Note the config-space is already defined by the ranges property
> > having the 0x0 space code (see the first link above), but it isn't
> > currently supported by the PCI subsystem. So at least that option can
> > be considered as a ready-to-implement replacement for the "config"
> > reg-name.
> > 
> 
> Agree. But still, the driver has to support both options: "config" reg name and
> "ranges", since ammending the binding would be an ABI break.
> 
> > > 
> > > Or we can use IORESOURCE_BITS (0xff)
> > > 
> > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> > > 
> > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> > > #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> > > 
> > > we can add
> > > 
> > > IORESOURCE_PRIV_WINDOWS			(1<<6)
> > > 
> > > I think previous method was more extendable. How do you think?
> > 
> > IMO extending the PCIe "ranges" property semantics looks more
> > promising, more flexible and more portable across various PCIe
> > controllers. But the most importantly is what Rob and Bjorn think
> > about that, not me.
> > 
> 
> IMO, using the "ranges" property to allocate arbitrary memory region should be
> the way forward, since it has almost all the info needed by the drivers to
> allocate the memory regions.
> 
> But for the sake of DT backwards compatiblity, we have to keep supporting the
> existing reg entries (addr_space, et al.), because "ranges" is not a required
> property for EP controllers.

I don't know that its worth the effort to carry both. Maybe if it is 
useful on more than just DW host.

I believe we had config space in ranges at some point on some 
binding and moved away from that. I forget the reasoning.

Rob


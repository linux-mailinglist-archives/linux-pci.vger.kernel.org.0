Return-Path: <linux-pci+bounces-4331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EB86E4FF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B97BB2172F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934D70CA2;
	Fri,  1 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfToB1yH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3039FCF;
	Fri,  1 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309298; cv=none; b=APmxbyugPWh522TV7OliPiRxv95RT6PI9OotaaX5c4VJ82TWqaWMIsSjnbZJ6sQKKh1qi6OB85LYpSGYlYHaBlZrmJ2lFgddj0HRaF9goM7ZXpWPhAkiIds07CJ7FrWAK0cWtb0riIOX8f9yjYummkYsQ2KuyrKBGzuT5RepvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309298; c=relaxed/simple;
	bh=MofuKVPG9VnvPfz0hbbfvm2OJEcM1o5Vn4BXWPfVZ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4JM6UfkUAFXiGjCV5lQsj944wIBuhxyCGqJZeSbc/4+LTE3utFGAzCSm4cf0VS3oDEIaiarNXYn1lzJjWqyEkczJdQ3nYD7vGtJDE1NQ1bgEiuB2IrPLjXNgKRi73cBxCz/nyyvUvUIlnj87gZfy+Om7Gz4jVfsPn04PBcLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfToB1yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4A0C433C7;
	Fri,  1 Mar 2024 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709309298;
	bh=MofuKVPG9VnvPfz0hbbfvm2OJEcM1o5Vn4BXWPfVZ1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfToB1yHqPCiZZOQtXI9zotpAbY5k9Indk+DtpfAn/TBufcAcVc2Gczuw6z4JIdc5
	 Y75rFCE2JH4EBvI8QCnk3illqKq+A3Jfa/+IVPshaGBiFRnZNAYljM5m4naHOR7BBU
	 Y3ikuS6nXmQCO4tGc/PTkp+t/egwZw5Oe1pfZSpdZuXFIQy19YSYwQz1muZoPpXsGR
	 i3QMOnPXDWyaht4JT1EkwziO9JSn2WsXD5WQFKg559OjD7HJTCJaUcYezNE2Ip6VQa
	 LgCCx1xwmzrTbu7OsLWfIyYOkKjgRrWI0XO5sff4punA8Y+GEwZCHIyOYUWlDIlRhy
	 xoGnZSdJOrEHw==
Date: Fri, 1 Mar 2024 10:08:16 -0600
From: Rob Herring <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20240301160816.GA2221899-robh@kernel.org>
References: <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
 <20240228160346.GA4069607-robh@kernel.org>
 <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
 <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
 <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>

On Thu, Feb 29, 2024 at 02:26:34PM +0300, Serge Semin wrote:
> On Wed, Feb 28, 2024 at 06:39:36PM -0600, Rob Herring wrote:
> > On Wed, Feb 28, 2024 at 10:23 AM Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 10:03:46AM -0600, Rob Herring wrote:
> > > > On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > > > > > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > > > > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > > > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > > > > >
> > > > > > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > > > > > >            const: config
> > > > > > > > > > > > > +        - description:
> > > > > > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > > > > > +          const: msg
> > > > > > > > > > > >
> > > > > > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > > > > >
> > > > > > > > > > > I do think it is a bit questionable. Ideally, the driver could
> > > > > > > > > > > just configure this on its own. However, since we don't describe all of
> > > > > > > > > > > the CPU address space (that's input to the iATU) already, that's not
> > > > > > > > > > > going to be possible. I suppose we could fix that, but then config space
> > > > > > > > > > > would have to be handled differently too.
> > > > > > > > > >
> > > > > > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU.
> > > > > > > > > >
> > > > > > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > > > > >
> > > > > > > > > @rob:
> > > > > > > > >
> > > > > > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > > > > > detail direction?
> > > > > > > >
> > > > > > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > > > > > property:
> > > > > > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > > > > >
> > > > > > > > So basically Rob meant back then that
> > > > > > > > either originally we should have defined a new reg-name like "atu-out"
> > > > > > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > > > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > > > > > or, well, stick to the chunking further. The later path was chosen
> > > > > > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > > > > > above).
> > > > > > > >
> > > > > > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > > > > > TLPs, etc are all application-specific features. Each of them is
> > > > > > > > implemented based on a bit specific but basically the same outbound
> > > > > > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > > > > > of view it would have been enough to describe the entire outbound iATU
> > > > > > > > CPU address space and then let the software do the space
> > > > > > > > reconfiguration in runtime based on it' application needs.
> > > > > > >
> > > > > > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > > > > > region. We can reuse this name.
> > > > > > >
> > > > > > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > > > > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > > > > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > > > > > mem region. We can config each region size by module parameter or drvdata.
> > > > > > >
> > > > > > > So we can deprecate 'config', even 'ranges'
> > > > > >
> > > > > > Not sure I fully understand what you mean. In anyway the "config" reg
> > > > > > name is highly utilized by the DW PCIe IP-core instances. We can't
> > > > > > deprecate it that easily. At least the backwards compatibility must be
> > > > > > preserved. Moreover "addr_space" is also just a single value reg which
> > > > > > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > > > > > regions.
> > > > > >
> > > > > > The "ranges" property is a part of the DT specification.  The
> > > > > > PCI-specific way of the property-based mapping is de-facto a standard
> > > > > > too. So this can't be deprecated.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > * Rob, correct me if am wrong.
> > > > > > > >
> > > > > > > > On the other hand it's possible to have more than one disjoint CPU
> > > > > > > > address region handled by the outbound iATU (especially if there is no
> > > > > > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > > > > > in HW manual). Thus having a single reg-property might get to be
> > > > > > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > > > > > What about just extending the PCIe "ranges" property flags
> > > > > > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > > > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > > > > > use the flag to define a custom memory range for the TLP messages
> > > > > > > > generation. At some point it can be also utilized for the config-space
> > > > > > > > mapping. What do you think?
> > > > > > >
> > > > > >
> > > > > > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS,
> > > > > > > all IORESOURCE_* bit need move. And it is actual MEMORY regain.
> > > > > >
> > > > > > No. The lowest four bits aren't flags but the actual value. They are
> > > > > > retrieved from the PCI-specific memory ranges mapping:
> > > > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > > > > > Currently only first four out of _sixteen_ values have been defined so
> > > > > > far. So we can freely use some of the free values for custom TLPs,
> > > > > > etc. Note the config-space is already defined by the ranges property
> > > > > > having the 0x0 space code (see the first link above), but it isn't
> > > > > > currently supported by the PCI subsystem. So at least that option can
> > > > > > be considered as a ready-to-implement replacement for the "config"
> > > > > > reg-name.
> > > > > >
> > > > >
> > > > > Agree. But still, the driver has to support both options: "config" reg name and
> > > > > "ranges", since ammending the binding would be an ABI break.
> > > > >
> > > > > > >
> > > > > > > Or we can use IORESOURCE_BITS (0xff)
> > > > > > >
> > > > > > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > > > > > #define IORESOURCE_ROM_ENABLE           (1<<0)  /* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > > > > > #define IORESOURCE_ROM_SHADOW           (1<<1)  /* Use RAM image, not ROM BAR */
> > > > > > >
> > > > > > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > > > > > #define IORESOURCE_PCI_FIXED            (1<<4)  /* Do not move resource */
> > > > > > > #define IORESOURCE_PCI_EA_BEI           (1<<5)  /* BAR Equivalent Indicator */
> > > > > > >
> > > > > > > we can add
> > > > > > >
> > > > > > > IORESOURCE_PRIV_WINDOWS                 (1<<6)
> > > > > > >
> > > > > > > I think previous method was more extendable. How do you think?
> > > > > >
> > > > > > IMO extending the PCIe "ranges" property semantics looks more
> > > > > > promising, more flexible and more portable across various PCIe
> > > > > > controllers. But the most importantly is what Rob and Bjorn think
> > > > > > about that, not me.
> > > > > >
> > > > >
> > > > > IMO, using the "ranges" property to allocate arbitrary memory region should be
> > > > > the way forward, since it has almost all the info needed by the drivers to
> > > > > allocate the memory regions.
> > > > >
> > > > > But for the sake of DT backwards compatiblity, we have to keep supporting the
> > > > > existing reg entries (addr_space, et al.), because "ranges" is not a required
> > > > > property for EP controllers.
> > > >
> > > > I don't know that its worth the effort to carry both. Maybe if it is
> > > > useful on more than just DW host.
> > > >
> > > > I believe we had config space in ranges at some point on some
> > > > binding and moved away from that. I forget the reasoning.
> > >
> > > I can alloc a 64k windows from IORESOURCE_MEM windows to do 'msg' windows
> > > in dwc host driver in v4.
> > >
> > > But I think it is wonthful to discuss if we can extend of_map bits, add
> > > more type beside CONFIG/IO/MEM/MEM64.
> > >
> > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > >
> > > phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> > >
> 
> > > There are '000' before 'ss'.  If we use it as dwc private resource.
> 
> Frank, why do you mis-inform about the idea? The point was to use the
> ranges property for:
> 1. PCIe Config-space mapping.
> 2. PCIe TLP messages region.
> There is _nothing_ DWC-specific in the original suggestion. Case 1 has
> already implicitly defined by the DT standard, see the link above (but
> for some reason hasn't been implemented in the PCIe subsystem). Case 2
> hasn't been determined, but could be seeing there are three unused
> bits in the ss-code of the phys.hi cell. All of that can be used by
> _any_ PCIe RC/EP device.
> 
> > 
> > DWC (or any host controller) specific things? No!
> 
> Rob, could you please dive deeper in this thread? The idea is to use
> the "ranges" property for the "config" (PCIe config space) and the
> custom PCIe TLP messages regions.

I did in my prior response. Here, I was just making it clear that 
something host controller specific is a non-starter as you did.

For config, we had some bindings that did this and we moved away from 
it. I don't remember the details. Unless it's ECAM region, I don't think 
using ranges makes any sense as how to use the region will still be host 
specific.

For TLP messages, do we have other hosts that could use ranges for them? 
Is there something in the PCIe spec that defines TLP as an address 
space and what that address space looks like? IIRC, some hosts (Altera?) 
just have a message sending interface and that includes config space 
accesses.

Rob


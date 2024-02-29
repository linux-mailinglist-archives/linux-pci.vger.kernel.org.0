Return-Path: <linux-pci+bounces-4220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974986BCE8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 01:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967421C2361D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 00:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE5107B3;
	Thu, 29 Feb 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e41Am+6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4421350;
	Thu, 29 Feb 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167192; cv=none; b=s0YZWO4FMu2Cl1+j4OSkIzC2c362YmNX2k9VKawAZ9m+aA7b+VsrR/01puf/dZCTQU/2Hk9DsqiQ16Xyz/lf+R7Y1J9ZBvKKbbFpM91MqKdLCP+RGcVx9Hr0rOcHJiTMjDsM2OrM6PZe2JqOQCE2uq9FzriaZI9FddB0Xc1nJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167192; c=relaxed/simple;
	bh=1j0K/Zx4PNQNHZywtDLZInMTCvQIdvVoGkXhzRanPhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCQAO7Fr60qCd67GQqv/9LjiQDdV7kvOrb7F+FK6XczpwTuRLlsmLlHB72hzbLJnHSVpY9JmTqq/UcPv4piF0ouyKv7zGR4oMv/dpNT6lE+e6vE3tXHz2zpw/CeTcRvDRU3bdORRd6JZhllQb41xgxRnF9hmH9AqgbeJRRSzz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e41Am+6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391A3C433C7;
	Thu, 29 Feb 2024 00:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709167192;
	bh=1j0K/Zx4PNQNHZywtDLZInMTCvQIdvVoGkXhzRanPhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e41Am+6eaYW48DN3nao8BgGRnUi/1gXDPkRuJXNHa7CPKIVzkmeEx/0JFxx6/yID+
	 /Lrp4OKGE7sb2uSqa17GbG5Ypms41v96ktLdbTZeQmS2pm7nxzEh7qRM2GzTTbXF2V
	 /pmggxAIStBUZmCvyn6uux1a2Wh93ek1TWobihHpgsDEpHDViTdCK/IGwGOL9Cwa9o
	 O2isaYKsqo198B0P2C5f99vbCR7cS90LN2OETggbAQw9cmmhoKg10KrpQ+y21VW/kG
	 aiY+cvQiwOJb95qyaLuQeXSa2Nlkgk6gecdU4cruClFa8GNvhUp9aJLuKEGSQnQAod
	 Nv/ehDcCJPFLA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so3803421fa.3;
        Wed, 28 Feb 2024 16:39:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVawY1UmEhqOEJxQs22WiTSCCbbsWSt2htqyHLca78MZUGPEjYFvqcKAARYxFe7bbA5JEbogewFoAYjOWAXPnsKuuQ7s2SAtAUP7qg3coYzatZCZSBoJnH/XtpKFHGA9PSpvlnoacDRPYbZnOciJzsSREnxsCGmYs6glbQVIit/f+u+Fg==
X-Gm-Message-State: AOJu0Yxw6KWuXobjUig7H1Il+tEIT1GLM9X+0aw6OAZvMk1tXKvdkgkY
	YKo3kcQGMU6i9drCcuaQapzyn32KkUTD2vvVd8AtXuUcu/x2hXmkd+e1koD2Xsd8ufbTiaIjg53
	UZ/YlhaQ5EYGxxk7jhN/MsMHrPg==
X-Google-Smtp-Source: AGHT+IFiZ1qd17iU1lXRijPOr0QJE6BZ1k6Q06/JUYxf3nvzB8dSBKBKYde9jE84j82q7/JqUHFp/rzzb3JSUR1WYCc=
X-Received: by 2002:a2e:3009:0:b0:2d2:adc4:61f6 with SMTP id
 w9-20020a2e3009000000b002d2adc461f6mr218879ljw.16.1709167190387; Wed, 28 Feb
 2024 16:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com> <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org> <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810> <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810> <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad> <20240228160346.GA4069607-robh@kernel.org> <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
In-Reply-To: <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Feb 2024 18:39:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
Message-ID: <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Serge Semin <fancer.lancer@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	imx@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:23=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Feb 28, 2024 at 10:03:46AM -0600, Rob Herring wrote:
> > On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > > > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote=
:
> > > > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wro=
te:
> > > > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrot=
e:
> > > > > > > > > > > Add an outbound iATU-capable memory-region which will=
 be used to send PCIe
> > > > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all =
platforms can use
> > > > > > > > > > > common method to send out PME_Turn_Off message by usi=
ng one outbound iATU.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.y=
aml | 4 ++++
> > > > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/sn=
ps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-p=
cie.yaml
> > > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-p=
cie.yaml
> > > > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > > >
> > > > > > > > > > >              Outbound iATU-capable memory-region whic=
h will be used to access
> > > > > > > > > > >              the peripheral PCIe devices configuratio=
n space.
> > > > > > > > > > >            const: config
> > > > > > > > > > > +        - description:
> > > > > > > > > > > +            Outbound iATU-capable memory-region whic=
h will be used to send
> > > > > > > > > > > +            PCIe message (such as PME_Turn_Off) to p=
eripheral.
> > > > > > > > > > > +          const: msg
> > > > > > > > > >
> > > > > > > > > > Note there is a good chance Rob won't like this change.=
 AFAIR he
> > > > > > > > > > already expressed a concern regarding having the "confi=
g" reg-name
> > > > > > > > > > describing a memory space within the outbound iATU memo=
ry which is
> > > > > > > > > > normally defined by the "ranges" property. Adding a new=
 reg-entry with
> > > > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > > >
> > > > > > > > > I do think it is a bit questionable. Ideally, the driver =
could
> > > > > > > > > just configure this on its own. However, since we don't d=
escribe all of
> > > > > > > > > the CPU address space (that's input to the iATU) already,=
 that's not
> > > > > > > > > going to be possible. I suppose we could fix that, but th=
en config space
> > > > > > > > > would have to be handled differently too.
> > > > > > > >
> > > > > > > > Sorry, I have not understand what your means. Do you means,=
 you want
> > > > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all A=
TU.
> > > > > > > >
> > > > > > > > Then allocated some space to 'config', 'io', 'memory' and t=
his 'msg'.
> > > > > > >
> > > > > > > @rob:
> > > > > > >
> > > > > > >     So far, I think "msg" is feasilbe solution. Or give me so=
me little
> > > > > > > detail direction?
> > > > > >
> > > > > > Found the Rob' note about the iATU-space chunks utilized in the=
 reg
> > > > > > property:
> > > > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=3Dz38iB7S=
V5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > > >
> > > > > > So basically Rob meant back then that
> > > > > > either originally we should have defined a new reg-name like "a=
tu-out"
> > > > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > > > or, well, stick to the chunking further. The later path was cho=
sen
> > > > > > after the patch with the "ecam" reg-name was accepted (see the =
link
> > > > > > above).
> > > > > >
> > > > > > Really ECAM/config space access, custom TLP messages, legacy in=
terrupt
> > > > > > TLPs, etc are all application-specific features. Each of them i=
s
> > > > > > implemented based on a bit specific but basically the same outb=
ound
> > > > > > iATU engine setup. Thus from the "DT is a hardware description"=
 point
> > > > > > of view it would have been enough to describe the entire outbou=
nd iATU
> > > > > > CPU address space and then let the software do the space
> > > > > > reconfiguration in runtime based on it' application needs.
> > > > >
> > > > > There are "addr_space" in EP mode, which useful map out outbound =
iatu
> > > > > region. We can reuse this name.
> > > > >
> > > > > To keep compatiblity, cut hole from 'config' and 'ranges'. If the=
re are
> > > > > not 'config', we can alloc a 1M(default) from top for 'config', t=
hen, 4K
> > > > > (default) for msg, 64K( for IO if not IO region in 'ranges'), lef=
t is
> > > > > mem region. We can config each region size by module parameter or=
 drvdata.
> > > > >
> > > > > So we can deprecate 'config', even 'ranges'
> > > >
> > > > Not sure I fully understand what you mean. In anyway the "config" r=
eg
> > > > name is highly utilized by the DW PCIe IP-core instances. We can't
> > > > deprecate it that easily. At least the backwards compatibility must=
 be
> > > > preserved. Moreover "addr_space" is also just a single value reg wh=
ich
> > > > won't solve a problem with the disjoint DW PCIe outbound iATU memor=
y
> > > > regions.
> > > >
> > > > The "ranges" property is a part of the DT specification.  The
> > > > PCI-specific way of the property-based mapping is de-facto a standa=
rd
> > > > too. So this can't be deprecated.
> > > >
> > > > >
> > > > > >
> > > > > > * Rob, correct me if am wrong.
> > > > > >
> > > > > > On the other hand it's possible to have more than one disjoint =
CPU
> > > > > > address region handled by the outbound iATU (especially if ther=
e is no
> > > > > > AXI-bridge enabled, see XALI - application transmit client inte=
rfaces
> > > > > > in HW manual). Thus having a single reg-property might get to b=
e
> > > > > > inapplicable in some cases. Thinking about that got me to an id=
ea.
> > > > > > What about just extending the PCIe "ranges" property flags
> > > > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicatin=
g the
> > > > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-na=
mes and
> > > > > > use the flag to define a custom memory range for the TLP messag=
es
> > > > > > generation. At some point it can be also utilized for the confi=
g-space
> > > > > > mapping. What do you think?
> > > > >
> > > >
> > > > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_=
BITS,
> > > > > all IORESOURCE_* bit need move. And it is actual MEMORY regain.
> > > >
> > > > No. The lowest four bits aren't flags but the actual value. They ar=
e
> > > > retrieved from the PCI-specific memory ranges mapping:
> > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of=
_device_64.c#L141
> > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of=
_device_32.c#L78
> > > > Currently only first four out of _sixteen_ values have been defined=
 so
> > > > far. So we can freely use some of the free values for custom TLPs,
> > > > etc. Note the config-space is already defined by the ranges propert=
y
> > > > having the 0x0 space code (see the first link above), but it isn't
> > > > currently supported by the PCI subsystem. So at least that option c=
an
> > > > be considered as a ready-to-implement replacement for the "config"
> > > > reg-name.
> > > >
> > >
> > > Agree. But still, the driver has to support both options: "config" re=
g name and
> > > "ranges", since ammending the binding would be an ABI break.
> > >
> > > > >
> > > > > Or we can use IORESOURCE_BITS (0xff)
> > > > >
> > > > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > > > #define IORESOURCE_ROM_ENABLE           (1<<0)  /* ROM is enabled=
, same as PCI_ROM_ADDRESS_ENABLE */
> > > > > #define IORESOURCE_ROM_SHADOW           (1<<1)  /* Use RAM image,=
 not ROM BAR */
> > > > >
> > > > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM. =
 */
> > > > > #define IORESOURCE_PCI_FIXED            (1<<4)  /* Do not move re=
source */
> > > > > #define IORESOURCE_PCI_EA_BEI           (1<<5)  /* BAR Equivalent=
 Indicator */
> > > > >
> > > > > we can add
> > > > >
> > > > > IORESOURCE_PRIV_WINDOWS                 (1<<6)
> > > > >
> > > > > I think previous method was more extendable. How do you think?
> > > >
> > > > IMO extending the PCIe "ranges" property semantics looks more
> > > > promising, more flexible and more portable across various PCIe
> > > > controllers. But the most importantly is what Rob and Bjorn think
> > > > about that, not me.
> > > >
> > >
> > > IMO, using the "ranges" property to allocate arbitrary memory region =
should be
> > > the way forward, since it has almost all the info needed by the drive=
rs to
> > > allocate the memory regions.
> > >
> > > But for the sake of DT backwards compatiblity, we have to keep suppor=
ting the
> > > existing reg entries (addr_space, et al.), because "ranges" is not a =
required
> > > property for EP controllers.
> >
> > I don't know that its worth the effort to carry both. Maybe if it is
> > useful on more than just DW host.
> >
> > I believe we had config space in ranges at some point on some
> > binding and moved away from that. I forget the reasoning.
>
> I can alloc a 64k windows from IORESOURCE_MEM windows to do 'msg' windows
> in dwc host driver in v4.
>
> But I think it is wonthful to discuss if we can extend of_map bits, add
> more type beside CONFIG/IO/MEM/MEM64.
>
> https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
>
> phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
>
> There are '000' before 'ss'.  If we use it as dwc private resource.

DWC (or any host controller) specific things? No!

Rob


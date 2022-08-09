Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27B58DCCA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 19:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245270AbiHIRGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245421AbiHIRGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 13:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D9165AC;
        Tue,  9 Aug 2022 10:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F64C60B31;
        Tue,  9 Aug 2022 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDC6C433D7;
        Tue,  9 Aug 2022 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064791;
        bh=boObx/S+hUKAuI6RxK7dbD5ink84aDBG55gazSfDjlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eItAVPvMltrfz+7J0fYWDlaXPhDXAS7NkqhZ3d7zsm3CiLPdw0U4I7sfdLIsQP5GK
         s2kIvh0belTO5T+cvfYlGkEEZWb76w2TFN6oPmWyRIquYqc+oPHlJVX/XFqEZlJDbM
         33BGESeWSjvqXfxIkfG7EzspKApWJyAVHcFrrxPY3j2MA59+ODVd0oEHU1YzwtEGyK
         1UYEUOJR2rnvxOXGJmo5BO0v37EsP8RRs6+7F2YJoL0YwAr/E65uONx78TxqcgPCNi
         SFkSHVRgLpUTqJghNKT/dmQBXUGxiSWBAqlwIebSrQfDfKOG7DhhdFrZFEORj5297r
         XhmP+iV9Dtvrg==
Received: by mail-vk1-f176.google.com with SMTP id q14so6148860vke.9;
        Tue, 09 Aug 2022 10:06:30 -0700 (PDT)
X-Gm-Message-State: ACgBeo39sZHG15nkQyDgVaGG9UQkAWHhxNO6yg7UixcDW2ytxWTsP4AP
        ILXxzSB7lxD/GWxB8gaO1VUlMVE6VLS/WcPmLQ==
X-Google-Smtp-Source: AA6agR6uOnMAs0YW+n7El/2jtUUdekrjlaeDZcvM532gRjhtD/Ly0sW+0Nz0Y+LwNLsTJd14ChlCgx9GAURNQuohCN4=
X-Received: by 2002:a05:6122:4f9:b0:377:f03a:23df with SMTP id
 s25-20020a05612204f900b00377f03a23dfmr9996101vkf.19.1660064789811; Tue, 09
 Aug 2022 10:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220710225108.bgedria6igtqpz5l@pali> <20220806110613.GB4516@thinkpad>
 <20220806111702.ezzknr76a4imej4u@pali> <CAL_JsqL9dNtEtAvfRBPBRqgatheoyrEF+wx_kQiTbASxOPAQTA@mail.gmail.com>
 <20220809162939.vemxmk2qxjnmnagh@pali>
In-Reply-To: <20220809162939.vemxmk2qxjnmnagh@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Aug 2022 11:06:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKs9PidpikBBVjvK9T+8i96JT+hydjgNs2nLpazuYes6A@mail.gmail.com>
Message-ID: <CAL_JsqKs9PidpikBBVjvK9T+8i96JT+hydjgNs2nLpazuYes6A@mail.gmail.com>
Subject: Re: How to correctly define memory range of PCIe config space
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 9, 2022 at 10:29 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> On Tuesday 09 August 2022 09:59:49 Rob Herring wrote:
> > On Sat, Aug 6, 2022 at 5:17 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > On Saturday 06 August 2022 16:36:13 Manivannan Sadhasivam wrote:
> > > > Hi Pali,
> > > >
> > > > On Mon, Jul 11, 2022 at 12:51:08AM +0200, Pali Roh=C3=A1r wrote:
> > > > > Hello!
> > > > >
> > > > > Together with Mauri we are working on extending pci-mvebu.c drive=
r to
> > > > > support Orion PCIe controllers as these controllers are same as m=
vebu
> > > > > controller.
> > > > >
> > > > > There is just one big difference: Config space access on Orion is
> > > > > different. mvebu uses classic Intel CFC/CF8 registers for indirec=
t
> > > > > config space access but Orion has direct memory mapped config spa=
ce.
> > > > > So Orion DTS files need to have this memory range for config spac=
e and
> > > > > pci-mvebu.c driver have to read this range from DTS and properly =
map it.
> > > > >
> > > > > So my question is: How to properly define config space range in d=
evice
> > > > > tree file? In which device tree property and in which format? Ple=
ase
> > > > > note that this memory range of config space is PCIe root port spe=
cific
> > > > > and it requires its own MBUS_ID() like memory range of PCIe MEM a=
nd PCIe
> > > > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID()=
 used:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/arm/boot/dts/armada-385.dtsi
> > > > >
> > > >
> > > > On most of the platforms, the standard "reg" property is used to sp=
ecify the
> > > > config space together with other device specific memory regions. Fo=
r instance,
> > > > on the Qcom platforms based on Designware IP, we have below regions=
:
> > > >
> > > >       reg =3D <0xfc520000 0x2000>,
> > > >             <0xff000000 0x1000>,
> > > >             <0xff001000 0x1000>,
> > > >             <0xff002000 0x2000>;
> > > >       reg-names =3D "parf", "dbi", "elbi", "config";
> > > >
> > > > Where "parf" and "elbi" are Qcom controller specific regions, while=
 "dbi" and
> > > > "config" (config space) are common to all Designware IPs.
> > > >
> > > > These properties are documented in: Documentation/devicetree/bindin=
gs/pci/qcom,pcie.yaml
> > > >
> > > > Hope this helps!
> > >
> > > Hello! I have already looked at this. But as I pointed in above
> > > armada-385.dtsi file, mvebu is quite complicated. First it does not u=
se
> > > explicit address ranges, but rather macros MBUS_ID() which assign
> > > addresses at kernel runtime by mbus driver. Second issue is that conf=
ig
> > > space range (like any other resources) are pcie root port specific. S=
o
> > > it cannot be in pcie controller node and in pcie devices is "reg"
> > > property reserved for pci bdf address.
> > >
> > > In last few days, I spent some time on this issue and after reading l=
ot
> > > of pcie dts files, including bindings and other documents (including
> > > open firmware pci2_1.pdf) and I'm proposing following definition:
> > >
> > > soc {
> > >   pcie-mem-aperture =3D <0xe0000000 0x08000000>; /* 128 MiB memory sp=
ace */
> > >   pcie-cfg-aperture =3D <0xf0000000 0x01000000>; /*  16 MiB config sp=
ace */
> > >   pcie-io-aperture  =3D <0xf2000000 0x00100000>; /*   1 MiB I/O space=
 */
> > >
> > >   pcie {
> > >     ranges =3D <0x82000000 0 0x40000     MBUS_ID(0xf0, 0x01) 0x40000 =
 0x0 0x2000>,    /* Port 0.0 Internal registers */
> > >              <0x82000000 0 0xf0000000  MBUS_ID(0x04, 0x79) 0        0=
x0 0x1000000>, /* Port 0.0 Config space */
> >
> > IMO, this should be 0 for first cell as this is config space. What is
> > 0xf0000000 as that's supposed to be an address in PCI address space.
>
> Which value should be 0? I did not catch it here.

s/0x82000000/0/

But really that's 0 for the hi byte and BDF for the lower bytes.


> 0xf0000000 is just start offset for the child address range. I chose it
> "randomly" to not conflict with 0x40000 offset for child address range
> which describe internal PCIe controller registers.
>
> > >              <0x82000000 1 0x0         MBUS_ID(0x04, 0x59) 0        0=
x1 0x0>,       /* Port 0.0 Mem */
> > >              <0x81000000 1 0x0         MBUS_ID(0x04, 0x51) 0        0=
x1 0x0>,       /* Port 0.0 I/O */
> >
> > I/O space at 4GB? It's only 32-bits. I guess this is already there
> > from the mvebu binding, but it seems kind of broken...
>
> You have not looked how it works. mvebu is 32-bit CPU and this describe
> whole address range which could possibly used for IO or MEM for any
> (unspecified) PCIe controller.

I did look. It's just an intermediate virtual/random/made-up address
space. It kind of follows PCI bus addressing, but then not really.

> Every PCIe controller has its own PCIe MEM and PCIe IO address range
> which are not shared with other PCIe controllers. (non-mvebu platforms
> use for this different PCI domains; mvebu not)

Except there's this shared 'PCI like' bus each port is on.

> These "shared" ranges are then dynamically split into PCIe controllers
> like their drivers ask. So at the end all 10 PCIe controllers which are
> on AXP ask for maximum (64 kB) of PCIe IO and allocator then choose 10
> 64kB non-interleaving ranges from this "big" master range. Same for PCIe
> MEM.
>
> So basically those two lines (one for MEM and one for IO) just says that
> "unspecified" amount of PCIe MEM is mapped to MBUS_ID(0x04, 0x59) and
> another "unspecified" amount of PCIe IO is mapped to MBUS_ID(0x04, 0x51)
> mbus and pci-mvebu.c drivers than takes care for proper allocation of
> required memory from dynamic pool defined in pcie-mem-aperture and
> pcie-io-aperture properties.

That sounds shared to me...

>
> Note that this is not something which I invented, this is used for a
> long time by mvebu drivers and device tree files.
>
> > >
> > >     pcie@1,0 {
> > >       reg =3D <0x0800 0 0 0 0>; /* BDF 0:1.0 */
> > >       assigned-addresses =3D     <0x82000800 0 0x40000     0x0 0x2000=
>,     /* Port 0.0 Internal registers */
> > >                                <0x82000800 0 0xf0000000  0x0 0x100000=
0>;  /* Port 0.0 Config space */
> >
> > This says it is memory space, not config space.
>
> "config space" for Orion (in from driver point of view) is just ordinary
> "memory space".

"memory space" means PCI memory space which it is not. Almost every
Arm platform has config space in ordinary host/cpu address space.

> "memory space" is accessed by load/store instructions. I/O space is
> accessed by inb/outb (IO instructions or what architecture has) and
> "config space" is accessed by kernel drivers by its own drivers.
>
> So I think it is correct to declare this range of address space as
> "memory".

It is not if we are talking PCI addresses. If this is Marvell pseudo
virtual PCI addresses, then you can declare it whatever you want.

>
> > But the PCI binding
> > says config space is not allowed in assigned-addresses.
>
> Exactly. And this is because it does not make sense to assign "config
> space" into "assigned-addresses" as described in:
> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
>
> My understanding of above document is that "reg" property in following
> code describes "config space".
>
>   pcie@1,0 {
>     reg =3D <0x0800 0 0 0 0>; /* BDF 0:1.0 */
>   }
>
> And reason is that because above document use "config space" terminology
> for describing specific PCI device on the bus.
>
> Address part after the at-char (@1,0) in device tree should match "reg"
> property and by all above definitions from pci2_1.pdf this pass because:
>
> 1) that document describes @1,0 format that is "config space" for PCI
>    device with BDF X:1.0 where X is the parent bus
>
> 2) 0x0800 is really describes BDF X:1.0
>
> And then the "config space is not allowed in assigned-addresses" makes
> sense as there is absolutely no need to put "pointer" to PCI device
> (with BDF address) into "assigned-addresses" property. In this property
> should be some memory range and not reference to some PCI device.
>
> > I think the parent ranges needs a config space entry with the BDF for
> > each root port and then this entry should be dropped. It really looks
> > to me like the mvebu binding created these fake PCI addresses to map
> > root ports back to MBUS addresses when BDF could have been used
> > instead.
> >
> > Rob
>
> The reason is that in mvebu there are X independent single-root-port
> PCIe controllers (PCIe host bridges; PCI domains; ...) and device tree
> binding was defined that all root ports (with their host bridges) would
> be put into one "virtual" DT node which would act as one PCI domain.

If they are independent, why is there 1 mem and i/o aperture?

I don't know how a virtual DT node for purposes of creating a single
PCI domain ever passed review. Must have been explained differently at
the time.

> And this leads to the fact that all controller specific settings must be
> defined in pci root ports.

Not necessarily. There's no reason settings can't be in the parent node.

Rob

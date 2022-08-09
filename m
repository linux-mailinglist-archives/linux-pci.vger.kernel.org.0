Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350C58DBB1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiHIQNr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244867AbiHIQNp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 12:13:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1CB1FCE1;
        Tue,  9 Aug 2022 09:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62BD2B8136A;
        Tue,  9 Aug 2022 16:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B1C433C1;
        Tue,  9 Aug 2022 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660061622;
        bh=NAC8AtGkq3fU8h8l/0krI9JaS/lgJDLtj0tBI7zOsPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GbRYGHDyfk1nO6j7u/bOUvXc/zIiyD+Jf55gn1KW13u9qtH5ahFytotBvV/bwTzHI
         a5JOdOE1cPJgDmPs86+lIYjnMx1CkoBC0Fi9X7clohbzFOeDCAsPes7hVgTOqIQ5U6
         r8ppC6x3mxLJlewVDVm42U9cgILviKOqmH2pCutphw31I3iPvpi9F1AOXZHTXTuFSf
         IxE+E1lqjXDAqxqsdhzaOjeN+qaCAFj31kfb2raztZSgp92KNZKxhukRKsSxqXYhvA
         CQLEOrEsJZWxqwxE0SI01qKhAL2ox8gNyQ+kVqJD6T3cfjcIBU5fissEXv7hn5/dNX
         KY+LYN9AMrFRQ==
Received: by mail-pj1-f51.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so5025492pjo.0;
        Tue, 09 Aug 2022 09:13:42 -0700 (PDT)
X-Gm-Message-State: ACgBeo1h3BC2ZSgFeELXLfHbI6opYcBm9dYAcFJGwrqbtrV+E8dnDKld
        fV0IpgHJsPj/IOqBJCewW2w++nz78bMFgGUe/A==
X-Google-Smtp-Source: AA6agR6b543ElzI0thY0XvxXj/HWC1v4DxgpEHDigDBJxlcuodceKgqOQYYHz7B3JX30JjxLRY38O5Zb47jCz4XpSjs=
X-Received: by 2002:a17:90b:3c4c:b0:1f3:3d62:39e2 with SMTP id
 pm12-20020a17090b3c4c00b001f33d6239e2mr34726091pjb.88.1660061621655; Tue, 09
 Aug 2022 09:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220710225108.bgedria6igtqpz5l@pali> <20220806110613.GB4516@thinkpad>
 <20220806111702.ezzknr76a4imej4u@pali> <20220806121614.GA11359@thinkpad> <20220806122330.aqn7zu2qgq23g3iz@pali>
In-Reply-To: <20220806122330.aqn7zu2qgq23g3iz@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Aug 2022 10:13:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCWn88Qz0P93fiJZD0qP0+-z3UaKmsZKW1AGn0r7jnwQ@mail.gmail.com>
Message-ID: <CAL_JsqJCWn88Qz0P93fiJZD0qP0+-z3UaKmsZKW1AGn0r7jnwQ@mail.gmail.com>
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

On Sat, Aug 6, 2022 at 6:23 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Saturday 06 August 2022 17:46:14 Manivannan Sadhasivam wrote:
> > On Sat, Aug 06, 2022 at 01:17:02PM +0200, Pali Roh=C3=A1r wrote:
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
> > >              <0x82000000 1 0x0         MBUS_ID(0x04, 0x59) 0        0=
x1 0x0>,       /* Port 0.0 Mem */
> > >              <0x81000000 1 0x0         MBUS_ID(0x04, 0x51) 0        0=
x1 0x0>,       /* Port 0.0 I/O */
> > >
> > >     pcie@1,0 {
> > >       reg =3D <0x0800 0 0 0 0>; /* BDF 0:1.0 */
> > >       assigned-addresses =3D     <0x82000800 0 0x40000     0x0 0x2000=
>,     /* Port 0.0 Internal registers */
> > >                                <0x82000800 0 0xf0000000  0x0 0x100000=
0>;  /* Port 0.0 Config space */
> > >       ranges =3D <0x82000000 0 0  0x82000000 1 0           0x1 0x0>, =
       /* Port 0.0 Mem */
> > >                 0x81000000 0 0  0x81000000 1 0           0x1 0x0>;   =
     /* Port 0.0 I/O */
> > >     };
> > >   };
> > > };
> > >
> > > So the pci config space address range would be defined in
> > > "assigned-addresses" property as the _second_ value. First value is
> > > already used for specifying internal registers (similar what is "parf=
"
> > > for qcom).
> > >
> >
> > Sounds reasonable to me. Another option would be to introduce a mvebu s=
pecific
> > property but that would be the least preferred option I guess.
> >
> > But the fact that "assigned-addresses" property is described as "MMIO r=
egisters"
> > also adds up to the justification IMO.
> >
> > Rob/Krzysztof could always correct that during binding review.
>
> Ok!
>
> > > config space is currently limited to 16 MB (without extended PCIe), b=
ut
> > > after we find free continuous physical address window of size 256MB w=
e
> > > can extend it to full PCIe config space range.
> > >
> > > Any objections to above device tree definition?
> > >
> >
> > Are you also converting the binding to YAML for validation?
>
> I still have an issue to understand YAML scheme declaration and do not
> know how to express all those properties in this scheme language
> correctly. Also I was not able to setup infrastructure for running
> scheme binding tests. So I'm currently not planning to do this.

What's the issue exactly with installing? 'pip install dtschema'
doesn't work for you?

> It would be really a good idea to provide some web service where people
> could upload their work-in-progress DTS files and YAML schemes for
> automatic validation.

You can send patches and they get tested. That works until I get
annoyed that you aren't testing your patches as I review the results
and testing runs on my h/w (each patch is 5-15mins). If someone wants
to donate h/w for testing, I'd be happy to provide un-reviewed, fully
automated results. I just need a gitlab runner(s) with docker to point
the CI job to.

There's already several json-schema validator websites. Standing one
up for our specific needs probably wouldn't be too hard.

Rob

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866D958DB80
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiHIQAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiHIQAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 12:00:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2DA18352;
        Tue,  9 Aug 2022 09:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6B08CE1736;
        Tue,  9 Aug 2022 16:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C291DC433B5;
        Tue,  9 Aug 2022 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660060802;
        bh=vUQxxm09Cy2y0lT8j2ven9S2lRWX3x20/Uu7RtmRM4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sQgK1/Q8PG3WnCUF1Fo/AO6etxZuc7IDdtLTh4OlBHWP0vjTgybt2vPHpv9E+diZK
         2oHRI4Dw7lb2YORAwWIuid3Zk/uNFN6kYMu93UraxskBXDCM12PpiYWpDvNP7TIa8+
         Q4RrlaRo3cfwQX9oA7wBjaD3OqMdRTgAz0X26Zqt94WKsAo8RCq1KkkiDRTGPHQiZP
         LO9CQLBJFnbGTUpMnYIFWE5JXNsLuTj60Fge4R5LOondVf2KEN2Nzkp53Y/ef+ul3n
         a+WOMrw5lmIb1lPyIFKaKoeil386LJ9qhF4kUJXWlwVNADlkBbz5DGtkYu1L+wZmcb
         DHkqDwtq2wuqw==
Received: by mail-pg1-f171.google.com with SMTP id 202so4959915pgc.8;
        Tue, 09 Aug 2022 09:00:02 -0700 (PDT)
X-Gm-Message-State: ACgBeo0kubc0V8lvwsIshS9PYe4oHCrvUeARP9PHfVRSYzBViVphYtJi
        iLR+ZAy9bBySWe03dD7SyfPYXolvRxwzBeNFrA==
X-Google-Smtp-Source: AA6agR79RoH2/rjd+qErbwNi3isdzy8Cp7VWQV9mireGnUbAdCJqkOop5d49/Ppg88ypWj043zKieLlQfjhvKYenTYw=
X-Received: by 2002:a63:8441:0:b0:41d:43a:3043 with SMTP id
 k62-20020a638441000000b0041d043a3043mr16518578pgd.109.1660060802225; Tue, 09
 Aug 2022 09:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220710225108.bgedria6igtqpz5l@pali> <20220806110613.GB4516@thinkpad>
 <20220806111702.ezzknr76a4imej4u@pali>
In-Reply-To: <20220806111702.ezzknr76a4imej4u@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Aug 2022 09:59:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9dNtEtAvfRBPBRqgatheoyrEF+wx_kQiTbASxOPAQTA@mail.gmail.com>
Message-ID: <CAL_JsqL9dNtEtAvfRBPBRqgatheoyrEF+wx_kQiTbASxOPAQTA@mail.gmail.com>
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

On Sat, Aug 6, 2022 at 5:17 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Saturday 06 August 2022 16:36:13 Manivannan Sadhasivam wrote:
> > Hi Pali,
> >
> > On Mon, Jul 11, 2022 at 12:51:08AM +0200, Pali Roh=C3=A1r wrote:
> > > Hello!
> > >
> > > Together with Mauri we are working on extending pci-mvebu.c driver to
> > > support Orion PCIe controllers as these controllers are same as mvebu
> > > controller.
> > >
> > > There is just one big difference: Config space access on Orion is
> > > different. mvebu uses classic Intel CFC/CF8 registers for indirect
> > > config space access but Orion has direct memory mapped config space.
> > > So Orion DTS files need to have this memory range for config space an=
d
> > > pci-mvebu.c driver have to read this range from DTS and properly map =
it.
> > >
> > > So my question is: How to properly define config space range in devic=
e
> > > tree file? In which device tree property and in which format? Please
> > > note that this memory range of config space is PCIe root port specifi=
c
> > > and it requires its own MBUS_ID() like memory range of PCIe MEM and P=
CIe
> > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() use=
d:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm/boot/dts/armada-385.dtsi
> > >
> >
> > On most of the platforms, the standard "reg" property is used to specif=
y the
> > config space together with other device specific memory regions. For in=
stance,
> > on the Qcom platforms based on Designware IP, we have below regions:
> >
> >       reg =3D <0xfc520000 0x2000>,
> >             <0xff000000 0x1000>,
> >             <0xff001000 0x1000>,
> >             <0xff002000 0x2000>;
> >       reg-names =3D "parf", "dbi", "elbi", "config";
> >
> > Where "parf" and "elbi" are Qcom controller specific regions, while "db=
i" and
> > "config" (config space) are common to all Designware IPs.
> >
> > These properties are documented in: Documentation/devicetree/bindings/p=
ci/qcom,pcie.yaml
> >
> > Hope this helps!
>
> Hello! I have already looked at this. But as I pointed in above
> armada-385.dtsi file, mvebu is quite complicated. First it does not use
> explicit address ranges, but rather macros MBUS_ID() which assign
> addresses at kernel runtime by mbus driver. Second issue is that config
> space range (like any other resources) are pcie root port specific. So
> it cannot be in pcie controller node and in pcie devices is "reg"
> property reserved for pci bdf address.
>
> In last few days, I spent some time on this issue and after reading lot
> of pcie dts files, including bindings and other documents (including
> open firmware pci2_1.pdf) and I'm proposing following definition:
>
> soc {
>   pcie-mem-aperture =3D <0xe0000000 0x08000000>; /* 128 MiB memory space =
*/
>   pcie-cfg-aperture =3D <0xf0000000 0x01000000>; /*  16 MiB config space =
*/
>   pcie-io-aperture  =3D <0xf2000000 0x00100000>; /*   1 MiB I/O space */
>
>   pcie {
>     ranges =3D <0x82000000 0 0x40000     MBUS_ID(0xf0, 0x01) 0x40000  0x0=
 0x2000>,    /* Port 0.0 Internal registers */
>              <0x82000000 0 0xf0000000  MBUS_ID(0x04, 0x79) 0        0x0 0=
x1000000>, /* Port 0.0 Config space */

IMO, this should be 0 for first cell as this is config space. What is
0xf0000000 as that's supposed to be an address in PCI address space.

>              <0x82000000 1 0x0         MBUS_ID(0x04, 0x59) 0        0x1 0=
x0>,       /* Port 0.0 Mem */
>              <0x81000000 1 0x0         MBUS_ID(0x04, 0x51) 0        0x1 0=
x0>,       /* Port 0.0 I/O */

I/O space at 4GB? It's only 32-bits. I guess this is already there
from the mvebu binding, but it seems kind of broken...

>
>     pcie@1,0 {
>       reg =3D <0x0800 0 0 0 0>; /* BDF 0:1.0 */
>       assigned-addresses =3D     <0x82000800 0 0x40000     0x0 0x2000>,  =
   /* Port 0.0 Internal registers */
>                                <0x82000800 0 0xf0000000  0x0 0x1000000>; =
 /* Port 0.0 Config space */

This says it is memory space, not config space. But the PCI binding
says config space is not allowed in assigned-addresses.

I think the parent ranges needs a config space entry with the BDF for
each root port and then this entry should be dropped. It really looks
to me like the mvebu binding created these fake PCI addresses to map
root ports back to MBUS addresses when BDF could have been used
instead.

Rob

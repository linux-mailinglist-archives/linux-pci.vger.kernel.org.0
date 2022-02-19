Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC374BC8B2
	for <lists+linux-pci@lfdr.de>; Sat, 19 Feb 2022 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiBSNgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Feb 2022 08:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiBSNgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Feb 2022 08:36:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB6D9EB96;
        Sat, 19 Feb 2022 05:36:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C70AFB80122;
        Sat, 19 Feb 2022 13:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A678C004E1;
        Sat, 19 Feb 2022 13:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645277778;
        bh=Hw+rU+eWSztrE697erPFap9SOm9xA8A7/BpV7Appw20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7iLf+S9TwauofZNsHVZju7vU9Ny47oTJBOK8/B7beySUn1fmaI2a6kVS7dFdRIka
         yGgzhuYGq9y610YAvRzC2u7Ijgmw0xUfyHB6p+H+b+yPEh9xw5o0MBlcETY8i/APHo
         6qJpBH9o6INA5bg7LjsLNEITVeiheAWSeqqbE6tEIYass1sMGQ7VYqcTqSLPMLXUgE
         AVu0325bPmfeQIsyFoXn7VD++yKhsjY8q/oO817k5q9qpS0UefoVqjiwW2pfUvrcXx
         eQBKxko5IttdC13UXC1lhaVqO49pYllB2L+AzBl13rm3H1F4691KYpLsPsH1sVMwa3
         y+eoQ52DB+s/w==
Received: by pali.im (Postfix)
        id B827E2B70; Sat, 19 Feb 2022 14:36:15 +0100 (CET)
Date:   Sat, 19 Feb 2022 14:36:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     =?utf-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for
 PCIe legacy INTx interrupts
Message-ID: <20220219133615.es6vu5np26mdg6px@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-12-pali@kernel.org>
 <87wnhxjxlq.fsf@BL-laptop>
 <20220214150923.a5ttxoh426cfxn4v@pali>
 <87tud1jwpr.fsf@BL-laptop>
 <CAEzXK1qYKVk7QiSY_DwqkZ7WV6WU06WBtiqZx0JJCc+mOP-7Kg@mail.gmail.com>
 <CAEzXK1rj7pOvJgAMd11TJVqzgWD2GSJ-25_BWL7X9wiZWOhieQ@mail.gmail.com>
 <20220215105214.f5biuptsruoredqi@pali>
 <CAEzXK1qbv+cuRqoNh9_JQK=ViDtO9a+2S9sRMr-o4dUvRnn4Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1qbv+cuRqoNh9_JQK=ViDtO9a+2S9sRMr-o4dUvRnn4Uw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Perfect, thanks!

On Friday 18 February 2022 21:53:43 Luís Mendes wrote:
> Successfully tested on my custom A388 system with two PCI express slots.
> 
> If you wish you can add a:
> Tested-by: Luis Mendes <luis.p.mendes@gmail.com>
> 
> On Tue, Feb 15, 2022 at 10:52 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello! armada-388.dtsi file has #include "armada-385.dtsi" line and
> > therefore is already covered by this my patch.
> >
> > Gregory's question was about A380.
> >
> > But if you want, you can test this patch series (which already covers
> > A388) on your A388 HW. It is still better to do tests on more HW.
> >
> > On Tuesday 15 February 2022 10:48:17 Luís Mendes wrote:
> > > Hello,
> > >
> > > Sorry for jumping in the conversation, but I read this thread and I
> > > have an Armada A388 HW so I can test it, if desired.
> > >
> > > Luís
> > >
> > >
> > > On Tue, Feb 15, 2022 at 10:47 AM Luís Mendes <luis.p.mendes@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Sorry for jumping in the conversation, but I read this thread and I have an Armada A388 HW so I can test it, if desired.
> > > >
> > > > Luís
> > > >
> > > > On Mon, Feb 14, 2022 at 7:57 PM Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> > > >>
> > > >> Hello,
> > > >>
> > > >> > On Monday 14 February 2022 16:07:13 Gregory CLEMENT wrote:
> > > >> >> Hello Pali,
> > > >> >>
> > > >> >> > With this change legacy INTA, INTB, INTC and INTD interrupts are reported
> > > >> >> > separately and not mixed into one Linux virq source anymore.
> > > >> >> >
> > > >> >> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > >> >> > ---
> > > >> >> >  arch/arm/boot/dts/armada-385.dtsi | 52 ++++++++++++++++++++++++++-----
> > > >> >>
> > > >> >> Is there any reason for not doing the same change in armada-380.dtsi ?
> > > >> >
> > > >> > I do not have A380 HW, so I did this change only for A385 which I have
> > > >> > tested.
> > > >>
> > > >> OK fair enough.
> > > >>
> > > >> So you can add my
> > > >> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > > >>
> > > >> Moreover to keep biscetability  this patch should be merged after the
> > > >> support in the driver. So the easier is to let merge it through the PCI
> > > >> subsystem with the other patches from this series. I do not think there
> > > >> will be any other changes in this file so there won't be any merge
> > > >> conflicts.
> > > >>
> > > >> Thanks,
> > > >>
> > > >> Grégory
> > > >>
> > > >>
> > > >> >
> > > >> >> Grégory
> > > >> >>
> > > >> >> >  1 file changed, 44 insertions(+), 8 deletions(-)
> > > >> >> >
> > > >> >> > diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
> > > >> >> > index f0022d10c715..83392b92dae2 100644
> > > >> >> > --- a/arch/arm/boot/dts/armada-385.dtsi
> > > >> >> > +++ b/arch/arm/boot/dts/armada-385.dtsi
> > > >> >> > @@ -69,16 +69,25 @@
> > > >> >> >                            reg = <0x0800 0 0 0 0>;
> > > >> >> >                            #address-cells = <3>;
> > > >> >> >                            #size-cells = <2>;
> > > >> >> > +                          interrupt-names = "intx";
> > > >> >> > +                          interrupts-extended = <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> >                            #interrupt-cells = <1>;
> > > >> >> >                            ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> > > >> >> >                                      0x81000000 0 0 0x81000000 0x1 0 1 0>;
> > > >> >> >                            bus-range = <0x00 0xff>;
> > > >> >> > -                          interrupt-map-mask = <0 0 0 0>;
> > > >> >> > -                          interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> > +                          interrupt-map-mask = <0 0 0 7>;
> > > >> >> > +                          interrupt-map = <0 0 0 1 &pcie1_intc 0>,
> > > >> >> > +                                          <0 0 0 2 &pcie1_intc 1>,
> > > >> >> > +                                          <0 0 0 3 &pcie1_intc 2>,
> > > >> >> > +                                          <0 0 0 4 &pcie1_intc 3>;
> > > >> >> >                            marvell,pcie-port = <0>;
> > > >> >> >                            marvell,pcie-lane = <0>;
> > > >> >> >                            clocks = <&gateclk 8>;
> > > >> >> >                            status = "disabled";
> > > >> >> > +                          pcie1_intc: interrupt-controller {
> > > >> >> > +                                  interrupt-controller;
> > > >> >> > +                                  #interrupt-cells = <1>;
> > > >> >> > +                          };
> > > >> >> >                    };
> > > >> >> >
> > > >> >> >                    /* x1 port */
> > > >> >> > @@ -88,16 +97,25 @@
> > > >> >> >                            reg = <0x1000 0 0 0 0>;
> > > >> >> >                            #address-cells = <3>;
> > > >> >> >                            #size-cells = <2>;
> > > >> >> > +                          interrupt-names = "intx";
> > > >> >> > +                          interrupts-extended = <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> >                            #interrupt-cells = <1>;
> > > >> >> >                            ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> > > >> >> >                                      0x81000000 0 0 0x81000000 0x2 0 1 0>;
> > > >> >> >                            bus-range = <0x00 0xff>;
> > > >> >> > -                          interrupt-map-mask = <0 0 0 0>;
> > > >> >> > -                          interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> > +                          interrupt-map-mask = <0 0 0 7>;
> > > >> >> > +                          interrupt-map = <0 0 0 1 &pcie2_intc 0>,
> > > >> >> > +                                          <0 0 0 2 &pcie2_intc 1>,
> > > >> >> > +                                          <0 0 0 3 &pcie2_intc 2>,
> > > >> >> > +                                          <0 0 0 4 &pcie2_intc 3>;
> > > >> >> >                            marvell,pcie-port = <1>;
> > > >> >> >                            marvell,pcie-lane = <0>;
> > > >> >> >                            clocks = <&gateclk 5>;
> > > >> >> >                            status = "disabled";
> > > >> >> > +                          pcie2_intc: interrupt-controller {
> > > >> >> > +                                  interrupt-controller;
> > > >> >> > +                                  #interrupt-cells = <1>;
> > > >> >> > +                          };
> > > >> >> >                    };
> > > >> >> >
> > > >> >> >                    /* x1 port */
> > > >> >> > @@ -107,16 +125,25 @@
> > > >> >> >                            reg = <0x1800 0 0 0 0>;
> > > >> >> >                            #address-cells = <3>;
> > > >> >> >                            #size-cells = <2>;
> > > >> >> > +                          interrupt-names = "intx";
> > > >> >> > +                          interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> >                            #interrupt-cells = <1>;
> > > >> >> >                            ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
> > > >> >> >                                      0x81000000 0 0 0x81000000 0x3 0 1 0>;
> > > >> >> >                            bus-range = <0x00 0xff>;
> > > >> >> > -                          interrupt-map-mask = <0 0 0 0>;
> > > >> >> > -                          interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> > +                          interrupt-map-mask = <0 0 0 7>;
> > > >> >> > +                          interrupt-map = <0 0 0 1 &pcie3_intc 0>,
> > > >> >> > +                                          <0 0 0 2 &pcie3_intc 1>,
> > > >> >> > +                                          <0 0 0 3 &pcie3_intc 2>,
> > > >> >> > +                                          <0 0 0 4 &pcie3_intc 3>;
> > > >> >> >                            marvell,pcie-port = <2>;
> > > >> >> >                            marvell,pcie-lane = <0>;
> > > >> >> >                            clocks = <&gateclk 6>;
> > > >> >> >                            status = "disabled";
> > > >> >> > +                          pcie3_intc: interrupt-controller {
> > > >> >> > +                                  interrupt-controller;
> > > >> >> > +                                  #interrupt-cells = <1>;
> > > >> >> > +                          };
> > > >> >> >                    };
> > > >> >> >
> > > >> >> >                    /*
> > > >> >> > @@ -129,16 +156,25 @@
> > > >> >> >                            reg = <0x2000 0 0 0 0>;
> > > >> >> >                            #address-cells = <3>;
> > > >> >> >                            #size-cells = <2>;
> > > >> >> > +                          interrupt-names = "intx";
> > > >> >> > +                          interrupts-extended = <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> >                            #interrupt-cells = <1>;
> > > >> >> >                            ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
> > > >> >> >                                      0x81000000 0 0 0x81000000 0x4 0 1 0>;
> > > >> >> >                            bus-range = <0x00 0xff>;
> > > >> >> > -                          interrupt-map-mask = <0 0 0 0>;
> > > >> >> > -                          interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > > >> >> > +                          interrupt-map-mask = <0 0 0 7>;
> > > >> >> > +                          interrupt-map = <0 0 0 1 &pcie4_intc 0>,
> > > >> >> > +                                          <0 0 0 2 &pcie4_intc 1>,
> > > >> >> > +                                          <0 0 0 3 &pcie4_intc 2>,
> > > >> >> > +                                          <0 0 0 4 &pcie4_intc 3>;
> > > >> >> >                            marvell,pcie-port = <3>;
> > > >> >> >                            marvell,pcie-lane = <0>;
> > > >> >> >                            clocks = <&gateclk 7>;
> > > >> >> >                            status = "disabled";
> > > >> >> > +                          pcie4_intc: interrupt-controller {
> > > >> >> > +                                  interrupt-controller;
> > > >> >> > +                                  #interrupt-cells = <1>;
> > > >> >> > +                          };
> > > >> >> >                    };
> > > >> >> >            };
> > > >> >> >    };
> > > >> >> > --
> > > >> >> > 2.20.1
> > > >> >> >
> > > >> >>
> > > >> >> --
> > > >> >> Gregory Clement, Bootlin
> > > >> >> Embedded Linux and Kernel engineering
> > > >> >> http://bootlin.com
> > > >>
> > > >> --
> > > >> Gregory Clement, Bootlin
> > > >> Embedded Linux and Kernel engineering
> > > >> http://bootlin.com

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161524B5433
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355625AbiBNPJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:09:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiBNPJh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:09:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D7249F9D;
        Mon, 14 Feb 2022 07:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0402B810D5;
        Mon, 14 Feb 2022 15:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E123C340EE;
        Mon, 14 Feb 2022 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644851366;
        bh=vWuN80VnIBztWgeDcbeMKNKCUZn+QCttNnaHfSaAfAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tj18vLnywNyMG997rkbOL01uMlg5EitPEjGNsuHfyXI+RpsMB4hDPeyT9xBRq22ZD
         Rcmj9as0roKC6x/0an4ackTFBVEBSvJwWC8lmLE5Oz1GX2XsjtJxh2vxUPjog3O4Bt
         znq6Q/EFfrmCNVeDH5uiVp0Qvcp/O1nPhw5eqSe+1Ys6vnJMKx9DcWC+qGIvJN/0sy
         O2v3en+YFl8hNyJDkBY44ponNICcWZneLoudOBrLyxeV/NNCqoZx1ezn7YrhCx7Gor
         Qr+F2HTSEwALSm/Doyf6cvz0aDpg3+LyUi+hwpx7rYKtFMyzpQbia+v8/3CAplRrwl
         hDnYmwGdSeuFg==
Received: by pali.im (Postfix)
        id A4EADCAA; Mon, 14 Feb 2022 16:09:23 +0100 (CET)
Date:   Mon, 14 Feb 2022 16:09:23 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for
 PCIe legacy INTx interrupts
Message-ID: <20220214150923.a5ttxoh426cfxn4v@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-12-pali@kernel.org>
 <87wnhxjxlq.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnhxjxlq.fsf@BL-laptop>
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

On Monday 14 February 2022 16:07:13 Gregory CLEMENT wrote:
> Hello Pali,
> 
> > With this change legacy INTA, INTB, INTC and INTD interrupts are reported
> > separately and not mixed into one Linux virq source anymore.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm/boot/dts/armada-385.dtsi | 52 ++++++++++++++++++++++++++-----
> 
> Is there any reason for not doing the same change in armada-380.dtsi ?

I do not have A380 HW, so I did this change only for A385 which I have tested.

> Grégory
> 
> >  1 file changed, 44 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
> > index f0022d10c715..83392b92dae2 100644
> > --- a/arch/arm/boot/dts/armada-385.dtsi
> > +++ b/arch/arm/boot/dts/armada-385.dtsi
> > @@ -69,16 +69,25 @@
> >  				reg = <0x0800 0 0 0 0>;
> >  				#address-cells = <3>;
> >  				#size-cells = <2>;
> > +				interrupt-names = "intx";
> > +				interrupts-extended = <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> >  				#interrupt-cells = <1>;
> >  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> >  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> >  				bus-range = <0x00 0xff>;
> > -				interrupt-map-mask = <0 0 0 0>;
> > -				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-map-mask = <0 0 0 7>;
> > +				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
> > +						<0 0 0 2 &pcie1_intc 1>,
> > +						<0 0 0 3 &pcie1_intc 2>,
> > +						<0 0 0 4 &pcie1_intc 3>;
> >  				marvell,pcie-port = <0>;
> >  				marvell,pcie-lane = <0>;
> >  				clocks = <&gateclk 8>;
> >  				status = "disabled";
> > +				pcie1_intc: interrupt-controller {
> > +					interrupt-controller;
> > +					#interrupt-cells = <1>;
> > +				};
> >  			};
> >  
> >  			/* x1 port */
> > @@ -88,16 +97,25 @@
> >  				reg = <0x1000 0 0 0 0>;
> >  				#address-cells = <3>;
> >  				#size-cells = <2>;
> > +				interrupt-names = "intx";
> > +				interrupts-extended = <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> >  				#interrupt-cells = <1>;
> >  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> >  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> >  				bus-range = <0x00 0xff>;
> > -				interrupt-map-mask = <0 0 0 0>;
> > -				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-map-mask = <0 0 0 7>;
> > +				interrupt-map = <0 0 0 1 &pcie2_intc 0>,
> > +						<0 0 0 2 &pcie2_intc 1>,
> > +						<0 0 0 3 &pcie2_intc 2>,
> > +						<0 0 0 4 &pcie2_intc 3>;
> >  				marvell,pcie-port = <1>;
> >  				marvell,pcie-lane = <0>;
> >  				clocks = <&gateclk 5>;
> >  				status = "disabled";
> > +				pcie2_intc: interrupt-controller {
> > +					interrupt-controller;
> > +					#interrupt-cells = <1>;
> > +				};
> >  			};
> >  
> >  			/* x1 port */
> > @@ -107,16 +125,25 @@
> >  				reg = <0x1800 0 0 0 0>;
> >  				#address-cells = <3>;
> >  				#size-cells = <2>;
> > +				interrupt-names = "intx";
> > +				interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> >  				#interrupt-cells = <1>;
> >  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
> >  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
> >  				bus-range = <0x00 0xff>;
> > -				interrupt-map-mask = <0 0 0 0>;
> > -				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-map-mask = <0 0 0 7>;
> > +				interrupt-map = <0 0 0 1 &pcie3_intc 0>,
> > +						<0 0 0 2 &pcie3_intc 1>,
> > +						<0 0 0 3 &pcie3_intc 2>,
> > +						<0 0 0 4 &pcie3_intc 3>;
> >  				marvell,pcie-port = <2>;
> >  				marvell,pcie-lane = <0>;
> >  				clocks = <&gateclk 6>;
> >  				status = "disabled";
> > +				pcie3_intc: interrupt-controller {
> > +					interrupt-controller;
> > +					#interrupt-cells = <1>;
> > +				};
> >  			};
> >  
> >  			/*
> > @@ -129,16 +156,25 @@
> >  				reg = <0x2000 0 0 0 0>;
> >  				#address-cells = <3>;
> >  				#size-cells = <2>;
> > +				interrupt-names = "intx";
> > +				interrupts-extended = <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> >  				#interrupt-cells = <1>;
> >  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
> >  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
> >  				bus-range = <0x00 0xff>;
> > -				interrupt-map-mask = <0 0 0 0>;
> > -				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-map-mask = <0 0 0 7>;
> > +				interrupt-map = <0 0 0 1 &pcie4_intc 0>,
> > +						<0 0 0 2 &pcie4_intc 1>,
> > +						<0 0 0 3 &pcie4_intc 2>,
> > +						<0 0 0 4 &pcie4_intc 3>;
> >  				marvell,pcie-port = <3>;
> >  				marvell,pcie-lane = <0>;
> >  				clocks = <&gateclk 7>;
> >  				status = "disabled";
> > +				pcie4_intc: interrupt-controller {
> > +					interrupt-controller;
> > +					#interrupt-cells = <1>;
> > +				};
> >  			};
> >  		};
> >  	};
> > -- 
> > 2.20.1
> >
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com

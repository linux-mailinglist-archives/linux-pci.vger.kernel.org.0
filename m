Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456DF409C59
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbhIMSgo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:36:44 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:51929 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbhIMSgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 14:36:43 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 452b42da;
        Mon, 13 Sep 2021 20:35:23 +0200 (CEST)
Date:   Mon, 13 Sep 2021 20:35:23 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, robh+dt@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, nsaenz@kernel.org,
        jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
In-Reply-To: <871r5tcwhp.wl-maz@kernel.org> (message from Marc Zyngier on Sun,
        12 Sep 2021 22:30:42 +0100)
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
        <20210827171534.62380-5-mark.kettenis@xs4all.nl> <871r5tcwhp.wl-maz@kernel.org>
Message-ID: <5614581066cc67fa@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Sun, 12 Sep 2021 22:30:42 +0100
> From: Marc Zyngier <maz@kernel.org>

Hi Marc,

> On Fri, 27 Aug 2021 18:15:29 +0100,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > 
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > Add node corresponding to the apcie,t8103 node in the
> > Apple device tree for the Mac mini (M1, 2020).
> > 
> > Clock references and DART (IOMMU) references are left out at the
> > moment and will be added once the appropriate bindings have been
> > settled upon.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  arch/arm64/boot/dts/apple/t8103.dtsi | 63 ++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> > index 503a76fc30e6..6e4677bdef44 100644
> > --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> > +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> > @@ -214,5 +214,68 @@ pinctrl_smc: pinctrl@23e820000 {
> >  				     <AIC_IRQ 396 IRQ_TYPE_LEVEL_HIGH>,
> >  				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> > +
> > +		pcie0: pcie@690000000 {
> > +			compatible = "apple,t8103-pcie", "apple,pcie";
> > +			device_type = "pci";
> > +
> > +			reg = <0x6 0x90000000 0x0 0x1000000>,
> > +			      <0x6 0x80000000 0x0 0x4000>,
> 
> Only exposing 16kB for the 'rc' crashes the Linux driver as it tries
> to configure the port ref-clock configurations, which live much
> higher:
> 
> #define CORE_LANE_CFG(port)		(0x84000 + 0x4000 * (port))
> 
> Previous versions of the binding had this region as 1MB, which made
> things work.

Oops.  When I formalized the binding, I looked at the Apple DT and
used the sizes from there.  And didn't notice that this wasn't
sufficient since U-Boot doesn't actually use the size of the region to
create a mapping like an actual OS would do.  It is somewhat unclear
how big the regions really are, but as marcan noted at some point in
the past the sizes in the Apple DT seem to be somewhat inconsistent so
religiously following what is done there may not make sense.  So I'll
fix this in v5 (also in the example in the DT binding).

Corellium uses 1MB, which makes more sense unless we break up the
block into multiple ranges.

> > +			      <0x6 0x81000000 0x0 0x8000>,
> > +			      <0x6 0x82000000 0x0 0x8000>,
> > +			      <0x6 0x83000000 0x0 0x8000>;
> 
> These used to be 16kB, and are now twice as much. Didn't cause any
> issue with the Linux driver, but I wonder what trigger either change.

0x8000 is what the Apple DT uses.

Since we don't have authorative documentation for the chip we have to
make some guesses here.  I suspect we should try to keep the sizes as
small as possible while sticking to sizes of 2^n?  Then it probably
makes sense to use 0x4000 for these ranges.

Cheers,

Mark

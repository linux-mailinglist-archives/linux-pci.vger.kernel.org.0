Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29858B55B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Aug 2022 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiHFMXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Aug 2022 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiHFMXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Aug 2022 08:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4BDE8B;
        Sat,  6 Aug 2022 05:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1111460F62;
        Sat,  6 Aug 2022 12:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B618C433D6;
        Sat,  6 Aug 2022 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659788613;
        bh=BQ6PrlQqfE4zeaOkRkX5AW01dQjq9BDG12LIxUjMKek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcp7AqYMvjJmqey3IVROnNa/RRS4MtFG8Rylva65I742YSTDDER+KXMPbZBVddTqK
         b6JfD0c3YejvCSnLZTg/kY38GNs/c3eMM7dzSpWiWiYSvQubYzC/KH8jXRBEFakzHR
         mPXryT3/K2iGdrZDAC9az6mIzSwEfPOyfpKCYBtngIizzrM67U4iLLnThXTeMv1CC/
         PlEYAtHZnfmjHmmyL/IsrDG3BHosYKMLQj9uORNWNxltsxP1R1QaWTehZqrcesVPOk
         qhGQcEmYmCNsp56h/NrNJt5YuNzv1+usoSvPu7ydvf1sQgSgfSoD9SILCHCLGni2rq
         2aQxn/0Ga3UzA==
Received: by pali.im (Postfix)
        id 323436FE; Sat,  6 Aug 2022 14:23:30 +0200 (CEST)
Date:   Sat, 6 Aug 2022 14:23:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: How to correctly define memory range of PCIe config space
Message-ID: <20220806122330.aqn7zu2qgq23g3iz@pali>
References: <20220710225108.bgedria6igtqpz5l@pali>
 <20220806110613.GB4516@thinkpad>
 <20220806111702.ezzknr76a4imej4u@pali>
 <20220806121614.GA11359@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220806121614.GA11359@thinkpad>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 06 August 2022 17:46:14 Manivannan Sadhasivam wrote:
> On Sat, Aug 06, 2022 at 01:17:02PM +0200, Pali Rohár wrote:
> > On Saturday 06 August 2022 16:36:13 Manivannan Sadhasivam wrote:
> > > Hi Pali,
> > > 
> > > On Mon, Jul 11, 2022 at 12:51:08AM +0200, Pali Rohár wrote:
> > > > Hello!
> > > > 
> > > > Together with Mauri we are working on extending pci-mvebu.c driver to
> > > > support Orion PCIe controllers as these controllers are same as mvebu
> > > > controller.
> > > > 
> > > > There is just one big difference: Config space access on Orion is
> > > > different. mvebu uses classic Intel CFC/CF8 registers for indirect
> > > > config space access but Orion has direct memory mapped config space.
> > > > So Orion DTS files need to have this memory range for config space and
> > > > pci-mvebu.c driver have to read this range from DTS and properly map it.
> > > > 
> > > > So my question is: How to properly define config space range in device
> > > > tree file? In which device tree property and in which format? Please
> > > > note that this memory range of config space is PCIe root port specific
> > > > and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> > > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> > > > 
> > > 
> > > On most of the platforms, the standard "reg" property is used to specify the
> > > config space together with other device specific memory regions. For instance,
> > > on the Qcom platforms based on Designware IP, we have below regions:
> > > 
> > >       reg = <0xfc520000 0x2000>,
> > >             <0xff000000 0x1000>,
> > >             <0xff001000 0x1000>,
> > >             <0xff002000 0x2000>;
> > >       reg-names = "parf", "dbi", "elbi", "config";
> > > 
> > > Where "parf" and "elbi" are Qcom controller specific regions, while "dbi" and
> > > "config" (config space) are common to all Designware IPs.
> > > 
> > > These properties are documented in: Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > 
> > > Hope this helps!
> > 
> > Hello! I have already looked at this. But as I pointed in above
> > armada-385.dtsi file, mvebu is quite complicated. First it does not use
> > explicit address ranges, but rather macros MBUS_ID() which assign
> > addresses at kernel runtime by mbus driver. Second issue is that config
> > space range (like any other resources) are pcie root port specific. So
> > it cannot be in pcie controller node and in pcie devices is "reg"
> > property reserved for pci bdf address.
> > 
> > In last few days, I spent some time on this issue and after reading lot
> > of pcie dts files, including bindings and other documents (including
> > open firmware pci2_1.pdf) and I'm proposing following definition:
> > 
> > soc {
> >   pcie-mem-aperture = <0xe0000000 0x08000000>; /* 128 MiB memory space */
> >   pcie-cfg-aperture = <0xf0000000 0x01000000>; /*  16 MiB config space */
> >   pcie-io-aperture  = <0xf2000000 0x00100000>; /*   1 MiB I/O space */
> > 
> >   pcie {
> >     ranges = <0x82000000 0 0x40000     MBUS_ID(0xf0, 0x01) 0x40000  0x0 0x2000>,    /* Port 0.0 Internal registers */
> >              <0x82000000 0 0xf0000000  MBUS_ID(0x04, 0x79) 0        0x0 0x1000000>, /* Port 0.0 Config space */
> >              <0x82000000 1 0x0         MBUS_ID(0x04, 0x59) 0        0x1 0x0>,       /* Port 0.0 Mem */
> >              <0x81000000 1 0x0         MBUS_ID(0x04, 0x51) 0        0x1 0x0>,       /* Port 0.0 I/O */
> > 
> >     pcie@1,0 {
> >       reg = <0x0800 0 0 0 0>; /* BDF 0:1.0 */
> >       assigned-addresses =     <0x82000800 0 0x40000     0x0 0x2000>,     /* Port 0.0 Internal registers */
> >                                <0x82000800 0 0xf0000000  0x0 0x1000000>;  /* Port 0.0 Config space */
> >       ranges = <0x82000000 0 0  0x82000000 1 0           0x1 0x0>,        /* Port 0.0 Mem */
> >                 0x81000000 0 0  0x81000000 1 0           0x1 0x0>;        /* Port 0.0 I/O */
> >     };
> >   };
> > };
> > 
> > So the pci config space address range would be defined in
> > "assigned-addresses" property as the _second_ value. First value is
> > already used for specifying internal registers (similar what is "parf"
> > for qcom).
> > 
> 
> Sounds reasonable to me. Another option would be to introduce a mvebu specific
> property but that would be the least preferred option I guess.
> 
> But the fact that "assigned-addresses" property is described as "MMIO registers"
> also adds up to the justification IMO.
> 
> Rob/Krzysztof could always correct that during binding review.

Ok!

> > config space is currently limited to 16 MB (without extended PCIe), but
> > after we find free continuous physical address window of size 256MB we
> > can extend it to full PCIe config space range.
> > 
> > Any objections to above device tree definition?
> > 
> 
> Are you also converting the binding to YAML for validation?

I still have an issue to understand YAML scheme declaration and do not
know how to express all those properties in this scheme language
correctly. Also I was not able to setup infrastructure for running
scheme binding tests. So I'm currently not planning to do this.

It would be really a good idea to provide some web service where people
could upload their work-in-progress DTS files and YAML schemes for
automatic validation.

> Thanks,
> Mani
> 
> > > Thanks,
> > > Mani
> > > 
> > > > Krzysztof, would you be able to help with proper definition of this
> > > > property, so it would be fine also for schema checkers or other
> > > > automatic testing tools?
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

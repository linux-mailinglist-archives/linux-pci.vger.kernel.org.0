Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE158B559
	for <lists+linux-pci@lfdr.de>; Sat,  6 Aug 2022 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiHFMRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Aug 2022 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiHFMQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Aug 2022 08:16:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791862635
        for <linux-pci@vger.kernel.org>; Sat,  6 Aug 2022 05:16:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so5198970pjk.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Aug 2022 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fvZ1gSD4IexYnMpshzD56bFQ2RImKC8UwmCBJy/56WI=;
        b=JdmiFTeBVJCp4FJzeVo4WD/8bS5P8AvjqoODOw5nuPV3ysbPemfSkpamomnqnwFdiS
         Jr6Y445TMWmEB7k2F8dY9gfG6wuL7XCOrw3xsLhKThzzQ8nWIuU/R+x0IgdS5tKlz9Xt
         R1Aid0OMlNEGiT+miGiu7v1Dv8brfDAqoxyNYLLGR/4tGE2EMjCES5Qm9AZnP4ixAcPn
         nP/YgoMmzK3lsvbJTxvdSato2rRhtJB3ghSIqNutNoYq6+/t+akyfk1qn6xBSQdK9S5e
         yK5IDjpzV2FCfwFKNA8roa3pGyA6uEBbS/8hrPASVqfMXe38sUH875N/tnIqejsrTpdu
         x15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fvZ1gSD4IexYnMpshzD56bFQ2RImKC8UwmCBJy/56WI=;
        b=UVZE6FXSz1j0Y84mDGD8gHPtCEMUX1rNBUyad4HmX0JETFSInif28onBujHmpqC5U1
         kBx3EnGBfbr1c5I+cravdUACebT5W3quDCbpyg6BgQ2y3Z0bQ5nfcesGd5Sx7a23KHps
         9E2f1Ia5v4BPHYKZ0sJBqv5g6ll+5TmamO31t9BXdcD+6dqPLJelouoOyn0GnwK1/yi7
         t94ozie06lRtgh9FOz9gwL0+PajcIjjF2DE1pSqfOocOBi3YZq8tHVfI+KHAV3D3fZZw
         624cgcgCYFKR9W97zaw8P95v99mFUZaYZ3j4oen3AIRqmFXeW58qaDZWWF3rCPDS7pD+
         MQ+A==
X-Gm-Message-State: ACgBeo3Wfx73hYWIp+lyhIgcfGeekM/GjgGnjM66KJUZp53/eU2u27Fa
        vF3/wU/R+GJkdIobZ81nuv1JcKL4X2ki
X-Google-Smtp-Source: AA6agR4ymkkCwIsHh4APISh7UVQAFidVJrEGZ+phlaNfxsMAVCIqn7hubi3XSs6fgMIH4+b45wdlwA==
X-Received: by 2002:a17:902:7e89:b0:170:94d6:be73 with SMTP id z9-20020a1709027e8900b0017094d6be73mr1062634pla.52.1659788179877;
        Sat, 06 Aug 2022 05:16:19 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a16d000b001ef87123615sm4613055pje.37.2022.08.06.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 05:16:19 -0700 (PDT)
Date:   Sat, 6 Aug 2022 17:46:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: How to correctly define memory range of PCIe config space
Message-ID: <20220806121614.GA11359@thinkpad>
References: <20220710225108.bgedria6igtqpz5l@pali>
 <20220806110613.GB4516@thinkpad>
 <20220806111702.ezzknr76a4imej4u@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220806111702.ezzknr76a4imej4u@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 06, 2022 at 01:17:02PM +0200, Pali Rohár wrote:
> On Saturday 06 August 2022 16:36:13 Manivannan Sadhasivam wrote:
> > Hi Pali,
> > 
> > On Mon, Jul 11, 2022 at 12:51:08AM +0200, Pali Rohár wrote:
> > > Hello!
> > > 
> > > Together with Mauri we are working on extending pci-mvebu.c driver to
> > > support Orion PCIe controllers as these controllers are same as mvebu
> > > controller.
> > > 
> > > There is just one big difference: Config space access on Orion is
> > > different. mvebu uses classic Intel CFC/CF8 registers for indirect
> > > config space access but Orion has direct memory mapped config space.
> > > So Orion DTS files need to have this memory range for config space and
> > > pci-mvebu.c driver have to read this range from DTS and properly map it.
> > > 
> > > So my question is: How to properly define config space range in device
> > > tree file? In which device tree property and in which format? Please
> > > note that this memory range of config space is PCIe root port specific
> > > and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> > > 
> > 
> > On most of the platforms, the standard "reg" property is used to specify the
> > config space together with other device specific memory regions. For instance,
> > on the Qcom platforms based on Designware IP, we have below regions:
> > 
> >       reg = <0xfc520000 0x2000>,
> >             <0xff000000 0x1000>,
> >             <0xff001000 0x1000>,
> >             <0xff002000 0x2000>;
> >       reg-names = "parf", "dbi", "elbi", "config";
> > 
> > Where "parf" and "elbi" are Qcom controller specific regions, while "dbi" and
> > "config" (config space) are common to all Designware IPs.
> > 
> > These properties are documented in: Documentation/devicetree/bindings/pci/qcom,pcie.yaml
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
>   pcie-mem-aperture = <0xe0000000 0x08000000>; /* 128 MiB memory space */
>   pcie-cfg-aperture = <0xf0000000 0x01000000>; /*  16 MiB config space */
>   pcie-io-aperture  = <0xf2000000 0x00100000>; /*   1 MiB I/O space */
> 
>   pcie {
>     ranges = <0x82000000 0 0x40000     MBUS_ID(0xf0, 0x01) 0x40000  0x0 0x2000>,    /* Port 0.0 Internal registers */
>              <0x82000000 0 0xf0000000  MBUS_ID(0x04, 0x79) 0        0x0 0x1000000>, /* Port 0.0 Config space */
>              <0x82000000 1 0x0         MBUS_ID(0x04, 0x59) 0        0x1 0x0>,       /* Port 0.0 Mem */
>              <0x81000000 1 0x0         MBUS_ID(0x04, 0x51) 0        0x1 0x0>,       /* Port 0.0 I/O */
> 
>     pcie@1,0 {
>       reg = <0x0800 0 0 0 0>; /* BDF 0:1.0 */
>       assigned-addresses =     <0x82000800 0 0x40000     0x0 0x2000>,     /* Port 0.0 Internal registers */
>                                <0x82000800 0 0xf0000000  0x0 0x1000000>;  /* Port 0.0 Config space */
>       ranges = <0x82000000 0 0  0x82000000 1 0           0x1 0x0>,        /* Port 0.0 Mem */
>                 0x81000000 0 0  0x81000000 1 0           0x1 0x0>;        /* Port 0.0 I/O */
>     };
>   };
> };
> 
> So the pci config space address range would be defined in
> "assigned-addresses" property as the _second_ value. First value is
> already used for specifying internal registers (similar what is "parf"
> for qcom).
> 

Sounds reasonable to me. Another option would be to introduce a mvebu specific
property but that would be the least preferred option I guess.

But the fact that "assigned-addresses" property is described as "MMIO registers"
also adds up to the justification IMO.

Rob/Krzysztof could always correct that during binding review.

> config space is currently limited to 16 MB (without extended PCIe), but
> after we find free continuous physical address window of size 256MB we
> can extend it to full PCIe config space range.
> 
> Any objections to above device tree definition?
> 

Are you also converting the binding to YAML for validation?

Thanks,
Mani

> > Thanks,
> > Mani
> > 
> > > Krzysztof, would you be able to help with proper definition of this
> > > property, so it would be fine also for schema checkers or other
> > > automatic testing tools?
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60506F65F0
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEDHkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 03:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjEDHkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 03:40:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C0CE54
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 00:40:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab05018381so913855ad.2
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683186018; x=1685778018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NS2xyi1K/xIQXV/MtOd9V6Q+UyexdGSAq4agAp5XonY=;
        b=AAgdJOt/eH6vZKo2I9MGQ0WP3CWbmnT84ckG7hO8sO19fuxqUJ9p23g4dL/eVUwhuv
         kbhaZwqQJPhNENytJr52lcDE5cPggIjS9y+nVnsaAta+1L7tAzeT3O6/QfXBvSkhDAaV
         iR1gqW9NcnwAETwZEYMORXGe73yMMzlbOqPSaEOcK9v3kVldYGugMb++9lKG3ZNIrPcI
         fytfWdvPxkqTwh3asQC+SzHYKF5jVFKDFrgsHkfDERDsEW5mbC+EmiJ67Y0UganyB/Vk
         lY/7YwvRqdW2oIJdT+dvwKUrem3rMmc2Kso4S4m6W6MOpxq4McVp+BMJWjAXnlgYzmty
         hVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683186018; x=1685778018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS2xyi1K/xIQXV/MtOd9V6Q+UyexdGSAq4agAp5XonY=;
        b=le+GUKHei1KBxDIOgLJVZlEEEoNnLR8PNQe377tlwLe17JF6CZ6DtJHSGvXps73wuH
         6El5VYF+7zuo0dOyyCpODkIqVMh96xr8XCC6KdH/Ea4AarbnQ2/rToPSkaidUczAyUFT
         p6FvehmNniXHA3JpMXdCd1khp8ZZfc11TdCKmru9InBG7HQdIM6PQi9971HJ9xn1wC5+
         HxH94X52c8gRv0i0UO1yzUEIkVcpg4V/yAWjW+e2FtTBwNDD4J6l7XqOVN22clgl/wNh
         Z8vo5ziE8Pge2yBXR+ZYoBJwUlJQkIPILRINl6rdgO7PpMb1aVcIldsgt0cvKQI9RH6y
         e2sA==
X-Gm-Message-State: AC+VfDxUpTgmzMbAU5i8bIQn6GyeIYjuiocvipzQ+PWZEpydemFQfDXr
        gTKbLb64IbxJdmuHSvqkSDTS
X-Google-Smtp-Source: ACHHUZ4YY9uvlLkLChjXVMSyElLac77b8G37lyh0f3kT3dipOGMOwCavcWJS9y+TLl4aj6wRMFNnZQ==
X-Received: by 2002:a17:902:6b8b:b0:1ac:2d81:3cf2 with SMTP id p11-20020a1709026b8b00b001ac2d813cf2mr877710plk.58.1683186017786;
        Thu, 04 May 2023 00:40:17 -0700 (PDT)
Received: from thinkpad ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm7632475plb.289.2023.05.04.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:40:17 -0700 (PDT)
Date:   Thu, 4 May 2023 13:10:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] arm64: dts: renesas: Add IOMMU related properties
 into PCIe host nodes
Message-ID: <20230504074012.GA4162@thinkpad>
References: <20230426082812.3621678-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXBq0XZwgSUTQSrdYiQ0C0WBaHETqNLfF766TiXoCkKhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXBq0XZwgSUTQSrdYiQ0C0WBaHETqNLfF766TiXoCkKhg@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 03, 2023 at 02:38:49PM +0200, Geert Uytterhoeven wrote:
> Hi Shimoda-san,
> 
> CC linux-pci
> 
> On Wed, Apr 26, 2023 at 10:28 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Add iommu-map and iommu-map-mask properties into PCIe host nodes.
> > Note that iommu-map-mask should be zero because the IPMMU assigns
> > one micro TLB ID only to the PCIe host.
> >

What do you mean by "only to the PCIe host"? Are you referring to the host
bridge in the SoC?

> > Also change dma-ranges arguments for IOMMU. Notes that the dma-ranges
> > can be used if IOMMU is disabled.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thanks for your patch!
> 
> This is not really my area of expertise, but you can still find some
> questions and comments below...
> 
> > ---
> >  Changes from v1:
> > https://lore.kernel.org/all/20230421122608.3389397-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Drop iommus property.
> >  - Add iommu-map-mask property.
> >  - Revise the commit description.
> >
> >  arch/arm64/boot/dts/renesas/r8a77951.dtsi | 12 ++++++++----
> >  arch/arm64/boot/dts/renesas/r8a77960.dtsi | 12 ++++++++----
> >  arch/arm64/boot/dts/renesas/r8a77961.dtsi | 12 ++++++++----
> >  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 12 ++++++++----
> >  arch/arm64/boot/dts/renesas/r8a77990.dtsi |  6 ++++--
> >  5 files changed, 36 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > index 10b91e9733bf..2adec8b6c93f 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > @@ -2778,8 +2778,8 @@ pciec0: pcie@fe000000 {
> >                                  <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
> >                                  <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
> >                                  <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> > -                       /* Map all possible DDR as inbound ranges */
> > -                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> > +                       /* Map all possible DDR/IOMMU as inbound ranges */
> > +                       dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
> 
> So this is limited to the first 4 GiB of DDR (DDR0), i.e. to 32-bit
> address space? Shouldn't this include DDR1/2/3?
> 
> >                         interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> >                                 <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> >                                 <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> > @@ -2790,6 +2790,8 @@ pciec0: pcie@fe000000 {
> >                         clock-names = "pcie", "pcie_bus";
> >                         power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> >                         resets = <&cpg 319>;
> > +                       iommu-map = <0 &ipmmu_hc 0 0x10000>;
> 
> Reading
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pci/pci-iommu.txt#L35
> the above means you map 65536 RIDs n in the range 0..65535
> to  <&ipmmu_hc n>, while only micro-TLBs 0 and 1 are assigned to PCIe?
> 
> Hence I think this should be:
> 
>     iommu-map = <0 &ipmmu_hc 0 1>;
> 

If there are no PCI-PCI bridges in the SoC, then the devices connected to the
host bridge should share the same bus number i.e., 00:00.0 to 00.1f.8. In that
case, you should have the iommu-map as per Geert's suggestion. Paired with
iommu-map-mask of 0, this implies that all the devices and functions of bus 0
will share the same RID.

This holds true for other instance as well.

- Mani

> > +                       iommu-map-mask = <0>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -2805,8 +2807,8 @@ pciec1: pcie@ee800000 {
> >                                  <0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000>,
> >                                  <0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000>,
> >                                  <0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
> > -                       /* Map all possible DDR as inbound ranges */
> > -                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> > +                       /* Map all possible DDR/IOMMU as inbound ranges */
> > +                       dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
> 
> Likewise.
> 
> >                         interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> >                                 <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> >                                 <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> > @@ -2817,6 +2819,8 @@ pciec1: pcie@ee800000 {
> >                         clock-names = "pcie", "pcie_bus";
> >                         power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> >                         resets = <&cpg 318>;
> > +                       iommu-map = <0 &ipmmu_hc 1 0x10000>;
> 
> Likewise, the above means you map 65536 RIDs n in the range 0..65535
> to  <&ipmmu_hc (1 + n)>?
> 
> Hence I think this should be:
> 
>     iommu-map = <0 &ipmmu_hc 1 1>;
> 
> > +                       iommu-map-mask = <0>;
> >                         status = "disabled";
> >                 };
> 
> Same comment for all other changes.
> 
> In addition, we need similar changes to r8a774{a1,b1,c0,e1}.dtsi,
> and slightly different changes (using ipmmu_vi0 uTLB 5) to r8a77980.dtsi.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
மணிவண்ணன் சதாசிவம்

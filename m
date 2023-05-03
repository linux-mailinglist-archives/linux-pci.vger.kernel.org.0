Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0EE6F580C
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjECMjM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 3 May 2023 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjECMjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 08:39:11 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5B40CF;
        Wed,  3 May 2023 05:39:10 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso7427553276.2;
        Wed, 03 May 2023 05:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683117541; x=1685709541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5SF73OS+Gxw2tBpVILx6RhASW56/OHsn/jHnRPG3sM=;
        b=c3NWeKwyqT2oMxBl85iWQo6I57G6FX0o9N3LL2WlmIkTLsizwgjVdQAjR1N/+9u2m1
         Z+sEwVsmP68gdc56/Z0UMvZ5QIrZ16BvI7VJxZxdMkCvx0U7+YPPDT46xQP4udVOHvEu
         4owyibFGiCaxaLRJDAk89TJzQ23c5kZQhUIe8ukhL8nqCggAu/75cYl3uPkvvxbV8Nqs
         +hju4ON94IudO3uPiEmDbgvEIVzgvRa/IjFDQxkZqTNjDZOgsLFKM8h1JMcEEv4xaiQC
         tEPblDA0CMi1hxBrKW3nGJF9+ZMwZiGK8YUamOlXbnvIJ3Q4AADeuAoKiSx/yaTkgUab
         VLVA==
X-Gm-Message-State: AC+VfDwM4GZ5X/pzf91FV+mD9H+xWNqOc5wBPzKSUFa5yzVsr8mallcO
        5GH3dMTVS+mWnCPVwl/8HoLspIeDKDM5YQ==
X-Google-Smtp-Source: ACHHUZ6K72I2TOB/AMej+zHiDkug56msKU5sjGhDzxeWA9AV9c9GAt7l5DCip1QW/AANX6nlC+nEZw==
X-Received: by 2002:a25:6f56:0:b0:b92:4a97:56f with SMTP id k83-20020a256f56000000b00b924a97056fmr18486807ybc.14.1683117541454;
        Wed, 03 May 2023 05:39:01 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 123-20020a250b81000000b00b9da0df3beasm2540887ybl.35.2023.05.03.05.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:39:01 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso7427525276.2;
        Wed, 03 May 2023 05:39:01 -0700 (PDT)
X-Received: by 2002:a25:b31c:0:b0:b9d:a328:1128 with SMTP id
 l28-20020a25b31c000000b00b9da3281128mr15780563ybj.13.1683117540743; Wed, 03
 May 2023 05:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230426082812.3621678-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230426082812.3621678-1-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 14:38:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBq0XZwgSUTQSrdYiQ0C0WBaHETqNLfF766TiXoCkKhg@mail.gmail.com>
Message-ID: <CAMuHMdXBq0XZwgSUTQSrdYiQ0C0WBaHETqNLfF766TiXoCkKhg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: Add IOMMU related properties into
 PCIe host nodes
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

CC linux-pci

On Wed, Apr 26, 2023 at 10:28 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add iommu-map and iommu-map-mask properties into PCIe host nodes.
> Note that iommu-map-mask should be zero because the IPMMU assigns
> one micro TLB ID only to the PCIe host.
>
> Also change dma-ranges arguments for IOMMU. Notes that the dma-ranges
> can be used if IOMMU is disabled.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

This is not really my area of expertise, but you can still find some
questions and comments below...

> ---
>  Changes from v1:
> https://lore.kernel.org/all/20230421122608.3389397-1-yoshihiro.shimoda.uh@renesas.com/
>  - Drop iommus property.
>  - Add iommu-map-mask property.
>  - Revise the commit description.
>
>  arch/arm64/boot/dts/renesas/r8a77951.dtsi | 12 ++++++++----
>  arch/arm64/boot/dts/renesas/r8a77960.dtsi | 12 ++++++++----
>  arch/arm64/boot/dts/renesas/r8a77961.dtsi | 12 ++++++++----
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 12 ++++++++----
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi |  6 ++++--
>  5 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> index 10b91e9733bf..2adec8b6c93f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> @@ -2778,8 +2778,8 @@ pciec0: pcie@fe000000 {
>                                  <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
>                                  <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
>                                  <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> -                       /* Map all possible DDR as inbound ranges */
> -                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +                       /* Map all possible DDR/IOMMU as inbound ranges */
> +                       dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;

So this is limited to the first 4 GiB of DDR (DDR0), i.e. to 32-bit
address space? Shouldn't this include DDR1/2/3?

>                         interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2790,6 +2790,8 @@ pciec0: pcie@fe000000 {
>                         clock-names = "pcie", "pcie_bus";
>                         power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
>                         resets = <&cpg 319>;
> +                       iommu-map = <0 &ipmmu_hc 0 0x10000>;

Reading
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pci/pci-iommu.txt#L35
the above means you map 65536 RIDs n in the range 0..65535
to  <&ipmmu_hc n>, while only micro-TLBs 0 and 1 are assigned to PCIe?

Hence I think this should be:

    iommu-map = <0 &ipmmu_hc 0 1>;

> +                       iommu-map-mask = <0>;
>                         status = "disabled";
>                 };
>
> @@ -2805,8 +2807,8 @@ pciec1: pcie@ee800000 {
>                                  <0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000>,
>                                  <0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000>,
>                                  <0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
> -                       /* Map all possible DDR as inbound ranges */
> -                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +                       /* Map all possible DDR/IOMMU as inbound ranges */
> +                       dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;

Likewise.

>                         interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2817,6 +2819,8 @@ pciec1: pcie@ee800000 {
>                         clock-names = "pcie", "pcie_bus";
>                         power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
>                         resets = <&cpg 318>;
> +                       iommu-map = <0 &ipmmu_hc 1 0x10000>;

Likewise, the above means you map 65536 RIDs n in the range 0..65535
to  <&ipmmu_hc (1 + n)>?

Hence I think this should be:

    iommu-map = <0 &ipmmu_hc 1 1>;

> +                       iommu-map-mask = <0>;
>                         status = "disabled";
>                 };

Same comment for all other changes.

In addition, we need similar changes to r8a774{a1,b1,c0,e1}.dtsi,
and slightly different changes (using ipmmu_vi0 uTLB 5) to r8a77980.dtsi.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

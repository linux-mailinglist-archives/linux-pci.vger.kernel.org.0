Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979AC2C8193
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgK3KBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 05:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgK3KBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 05:01:38 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873DC0613CF;
        Mon, 30 Nov 2020 02:00:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k65so10837645ybk.5;
        Mon, 30 Nov 2020 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrQ+mZLjBbK5DfqffZ8lKAuOuSmxsWOhRa4QsJYuQNQ=;
        b=KOmbDFxv6rRfxOSmRwVz8ObJsjew+jHH+QNOlpQ1EcRNTsU3er994tuWTiKuxWOovG
         OvMc35By63krOaFSQ03CG/UgbL4TrRHnuK/5+3ylFKnj+HSHKA31aVt6B2Ri3uMxiYj3
         ofe46GQS80MDXiZvNuOzlbcChBMqPX40yMCZydEN6Mmb5wX7a/TFO0y6UJ4wNWPenjaE
         LNvDMM708mc1xbcVmLTh1QHu+XUI34WF4R8LmkqwpJiL5uLnkjtKB5CYIv1hgOI/GoII
         Z2b+92YNNvJ29u67E69/232EwU5IG6LsyLZtqa8IIcXJdWa4L+pSqKyTpEP9UUbYZQB+
         +lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrQ+mZLjBbK5DfqffZ8lKAuOuSmxsWOhRa4QsJYuQNQ=;
        b=UAk7h7UaRtAI1jcHPn10z33pqx4L/AgCuC8p0ohCcBdh2PJAUubT3MFudkBV7La7GS
         0zdchPCMg5+PVZnOe9Mg1IYKL+y8xQYfN6/s/YGCP3jmHeGvb/SG9d4DF+9xnbn3qqP1
         H5TU4hpjcikP5STyvcaZxtTJFMKtqaLPI92UjRqMlcqIjOe51UKsHr4V2NqwmpGrl8CH
         OOvo6JKEfZTFZrxRKYfUT39pFKeeXcGG01jBcWnHipQU78bLDqPX7RJKnpvjJxfU3Tv7
         7nLVcnPJBPZw08NihqvxCllKXwC0APItn4hrAX1kYvhU/XZGsTlu4CruXFVn+sQdDhex
         8gig==
X-Gm-Message-State: AOAM5317btFsr/T4ULzDrvMal6SBt6FdQ6FmWgbqv6dYK87BADCxH3A2
        JWmE7u/KnKb/X9zu2euJ2qZNZb91I5baR6uDaKw=
X-Google-Smtp-Source: ABdhPJzj3MnM0GKPLy4q4iqWz5vK7pyJFNmvkJLesQMwqvRlzzUtCsTe+MOQ66HUn776TgiZ/mMEeQsco9q5POQL5PI=
X-Received: by 2002:a25:e00b:: with SMTP id x11mr26929848ybg.518.1606730451965;
 Mon, 30 Nov 2020 02:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20201126115927.4089838-1-geert@linux-m68k.org>
In-Reply-To: <20201126115927.4089838-1-geert@linux-m68k.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 30 Nov 2020 10:00:26 +0000
Message-ID: <CA+V-a8tAdsQG+RRUT6S4k_BzpLp6fvo2HX93-98KbAz4HpMDuw@mail.gmail.com>
Subject: Re: [PATCH/RFC] dt-bindings: pci: rcar-pci-ep: Document missing
 interrupts property
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thu, Nov 26, 2020 at 2:21 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The R-Car PCIe controller does not use interrupts when configured
> for endpoint mode, hence the bindings do not document the interrupt
> property.  However, all DTS files provide interrupts properties, and
> thus fail to validate.
>
> Fix this by documenting the interrupts property.
>
> Fixes: 5be478f9c24fbdf8 ("dt-bindings: Another round of adding missing 'additionalProperties'")
> Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Alternatively, the interrupts properties should be removed from the
> corresponding device nodes in the DTS files.  Obviously they should be
> retained in the device nodes representing PCIe controllers configured in
> host mode, which describe the same hardware...
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> index fb97f4ea0e63682b..32a3b7665ff5473c 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -33,6 +33,10 @@ properties:
>        - const: memory2
>        - const: memory3
>
> +  interrupts:
> +    minItems: 3
> +    maxItems: 3
> +
>    power-domains:
>      maxItems: 1
>
> @@ -54,6 +58,7 @@ required:
>    - compatible
>    - reg
>    - reg-names
> +  - interrupts
>    - resets
>    - power-domains
>    - clocks
> @@ -65,6 +70,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/power/r8a774c0-sysc.h>
>
>       pcie0_ep: pcie-ep@fe000000 {
> @@ -76,6 +82,9 @@ examples:
>                    <0x30000000 0x8000000>,
>                    <0x38000000 0x8000000>;
>              reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> +            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>              resets = <&cpg 319>;
>              power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
>              clocks = <&cpg CPG_MOD 319>;
> --
> 2.25.1
>

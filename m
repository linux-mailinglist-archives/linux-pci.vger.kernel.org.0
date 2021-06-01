Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4550D396BF7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 05:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFADzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 23:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhFADzo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 23:55:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403EC061574
        for <linux-pci@vger.kernel.org>; Mon, 31 May 2021 20:54:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v5so17310954ljg.12
        for <linux-pci@vger.kernel.org>; Mon, 31 May 2021 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2R7KcQTWK76MBD5e+3ASeCsQ2a/MyPuSvQ02swCwiLI=;
        b=lgAn6J222My+JXRfCSrHMFMYYKcQX6jWmUYmHaxzNLdcbKTOwVjaUPSNMh6fHQ892C
         1jWf83FA/Zw0Q37nKhftZIAxSrcXo/5ooZcjrQRVVzt8O6J0EXbWL4EVCg3ZrzRd4MyG
         +/aZCQ6KcWAcvpnDMRcSLlpZnY+wYfyuSdtkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2R7KcQTWK76MBD5e+3ASeCsQ2a/MyPuSvQ02swCwiLI=;
        b=XYCTJn6Wn2YQysmczFPLNpO8d2aZH25DwCmnwAYjSSDCOiXqvSKXHPBXvV36lPKRh9
         HuuGN4otuZK+52EdQdLyuVjAuqMS9e/MeMmVJtk/nEXdRi5WYxdGvsaq1lIpF1FxCZuf
         qf5ERhHPVCF6C5v4gdEGH1P1efJGQ2HcZLmT5UtI3Z8Nff/wXEMyccpLMA5/w+FVfeHT
         AexmirtWH96omoxdnyPWRxWwd1vet85sjqiwp6X36NCZQVH8KnYvSXpwory2sxsNAe93
         nSVmyT/mwi5rRBGyYxfy5LZkiRTqavNrL4fdOcq01d01YVALUMwZbw1bmauwMATW1ucp
         6ZTQ==
X-Gm-Message-State: AOAM531/N5TirNJvJ8CQO/4PpvOSbbf5p+8bG6dj8/RyAF5KDkUecrHf
        rGOycRwgnA3oOhPE3OtuicAZzX5ITk+ZAy5ex96PcQ==
X-Google-Smtp-Source: ABdhPJyc5vZKRpWrASEV5Wynl7RGJwkd241oFVhSRgDJIJDqhECLAw5xVtnD/L4UwTCO000b6QHVXgYAQdDpx9bN2CA=
X-Received: by 2002:a2e:9e90:: with SMTP id f16mr19160824ljk.437.1622519641386;
 Mon, 31 May 2021 20:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210601024408.24485-1-jianjun.wang@mediatek.com> <20210601024408.24485-2-jianjun.wang@mediatek.com>
In-Reply-To: <20210601024408.24485-2-jianjun.wang@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 1 Jun 2021 11:53:50 +0800
Message-ID: <CAGXv+5G-8+ppafiUnqWm2UeiL+edHJ2zYZvU-S7mz_NdrM3YsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Randy Wu <Randy.Wu@mediatek.com>, youlin.pei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Jun 1, 2021 at 10:50 AM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.

Based on what I'm seeing internally, there seems to be some inconsistency
across the MediaTek platform on whether new compatible strings should be
introduced for "fully compatible" IP blocks.

If this hardware block in MT8195 is "the same" as the one in MT8192, do we
really need the new compatible string? Are there any concerns?


Thanks
ChenYu


> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index e7b1f9892da4..d5e4a3e63d97 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,7 +48,9 @@ allOf:
>
>  properties:
>    compatible:
> -    const: mediatek,mt8192-pcie
> +    oneOf:
> +      - const: mediatek,mt8192-pcie
> +      - const: mediatek,mt8195-pcie
>
>    reg:
>      maxItems: 1
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

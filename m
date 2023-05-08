Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27F6FB1D5
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEHNlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 8 May 2023 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHNlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 09:41:11 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FF2CD23;
        Mon,  8 May 2023 06:41:10 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-55a6efe95c9so66296967b3.1;
        Mon, 08 May 2023 06:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553270; x=1686145270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHDxuNfTo4R9AHTimDxxB6DeeQKHVQC82igHr1lClPc=;
        b=GWE6XrhWERdxGacrg1uG4Y/z4w9xfLsW8jdP3AOGpjWUhfk7rXHCfNZgB1WR7SIZFu
         bNn5hzeMXV9K9soVkCZ2X+LIEjLKoKmlGZ4mgJiUr4m0IbcWx4fLczyq775lB72H7s54
         fklvLEoUmoPQpFDJOM44uoioQLCIYtR6jdYNup4mGYTVIcI/oZay5vTGKRBhV0QE8jhD
         W9zu+ItXgYgm/svCRY9dMojziEndsRwXJEVnz8eZALL7C+hMBc+t/eln8z/gt72YX96O
         FkX3H/fRejtM7mDmaKUmxM2C8TDXxvN078a+mVid97sjrdeeUHKGnqgtYlmDF+Xq/v1P
         rnVg==
X-Gm-Message-State: AC+VfDw9i0htujxKNj+UN8S3gOauXW71P79esca+k8kAouo6S3hHdLxB
        EKC2gZUd/K1M+zT+lGwXKgr9OLboIVw7Mw==
X-Google-Smtp-Source: ACHHUZ7yd+AlhN83OylSLZrUuIScApde5FXnt4/h1SNGMKjAiG7es/KsaFWJX7HABjObw/5seLNLcQ==
X-Received: by 2002:a0d:df94:0:b0:55a:5616:ba35 with SMTP id i142-20020a0ddf94000000b0055a5616ba35mr10025827ywe.37.1683553269813;
        Mon, 08 May 2023 06:41:09 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x186-20020a81a0c3000000b0054eff15530asm2509848ywg.90.2023.05.08.06.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:41:09 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b99efd7c335so5989131276.0;
        Mon, 08 May 2023 06:41:08 -0700 (PDT)
X-Received: by 2002:a25:d141:0:b0:b9e:72b0:da22 with SMTP id
 i62-20020a25d141000000b00b9e72b0da22mr9683626ybg.64.1683553268612; Mon, 08
 May 2023 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com> <20230508104557.47889-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230508104557.47889-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 15:40:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGaDT_XGpeVm-915hbxa8-w5303QWg0a0iCjqk998unQ@mail.gmail.com>
Message-ID: <CAMuHMdWGaDT_XGpeVm-915hbxa8-w5303QWg0a0iCjqk998unQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: PCI: rcar-pci-host: add optional regulators
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wolfram,

On Mon, May 8, 2023 at 12:46 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Support regulators found on the e.g. KingFisher board.

... for the mini-PCIe slot.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> @@ -68,6 +68,12 @@ properties:
>    phy-names:
>      const: pcie
>
> +  vpcie1v5-supply:
> +    description: The 1.5v regulator to use for PCIe.

+1.5V is only present on mini-PCIe slots...

> +
> +  vpcie3v3-supply:
> +    description: The 3.3v regulator to use for PCIe.

... while +3.3V is present on PCIe, mini-PCIe, and M2 PCIe slots.

In addition, normal PCIe slots also have +12V.
So I think it would be prudent to add a vpcie12v0-supply property, too.

W.r.t. to the actual naming, I don't know if there's already a (de facto)
standard for that?

> +
>  required:
>    - compatible
>    - reg
> @@ -121,5 +127,7 @@ examples:
>               clock-names = "pcie", "pcie_bus";
>               power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
>               resets = <&cpg 319>;
> +             vpcie1v5-supply = <&pcie_1v5>;
> +             vpcie3v3-supply = <&pcie_3v3>;
>           };
>      };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

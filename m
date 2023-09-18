Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C627A4D49
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjIRPsG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 18 Sep 2023 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjIRPsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:48:02 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05710DE;
        Mon, 18 Sep 2023 08:45:06 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59bfb0825efso40025527b3.3;
        Mon, 18 Sep 2023 08:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051730; x=1695656530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+5V/p0RnqTnQDaOQcXpPM/b/+ioYkgQSZlIueT0vYQ=;
        b=h3uFNFZSRZ79griQi4Oo3PD2ZW13S6Fc/srDus0Fp9O6ErfoCkepDQdcH4MNjedg0c
         +Q2AQ0Pw2YMCplLCezpK0v/IiLEmbZEmEoxZ9EScko3uDfibj6A7krz3gKxpMQmqmauF
         V6HoWScOXmrsEDdShSKvnioWy6hL84wN0t1ZGNyOSo9U/lcqz2mQIKwKvWpE/Rs+oV1e
         J+Fsk1j/cdQE146jLcWBoV27NmoujN7uFsJiVS2ViGjbZ4uA9HC9nUeFmU3gq/rXTNss
         AjlnHgJVn35JYj4t3KgWQKCmhipMJ3asvhK2bj4ScoX2NnmN7JZAilsMBH3K6Tk5LYlF
         YMOQ==
X-Gm-Message-State: AOJu0YyWHhzIeMcNtbTlmNj2ro5Wueoii0axN3Ph3HfdHm+pfski4QAL
        HZjCPn8ovxyh2dTsW6bTutZk7oFrsnjBHg==
X-Google-Smtp-Source: AGHT+IH4LxYttot7BaoGgMHEuQ/6w3CQ6r6Ze5e6ndPI5jLKaRvqLpS0OXqnV26zbkiksvcQRJR3Qg==
X-Received: by 2002:a81:4f81:0:b0:589:e7ab:d4e5 with SMTP id d123-20020a814f81000000b00589e7abd4e5mr10230888ywb.0.1695051730677;
        Mon, 18 Sep 2023 08:42:10 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id h125-20020a816c83000000b005772abf6234sm2648718ywc.11.2023.09.18.08.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:42:10 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59e77e4f707so18770817b3.0;
        Mon, 18 Sep 2023 08:42:10 -0700 (PDT)
X-Received: by 2002:a0d:d491:0:b0:579:ec06:eb3d with SMTP id
 w139-20020a0dd491000000b00579ec06eb3dmr10848131ywd.21.1695051730200; Mon, 18
 Sep 2023 08:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <701db4418652fc2ed36570ac20d57117ec6941c5.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <701db4418652fc2ed36570ac20d57117ec6941c5.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:41:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoSYzvtTK7h+vEaGvkdL+3=zccHy9au6On9bOadT=JRg@mail.gmail.com>
Message-ID: <CAMuHMdVoSYzvtTK7h+vEaGvkdL+3=zccHy9au6On9bOadT=JRg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/30] Documentation/devicetree: Add
 renesas,sh7751-pci binding document.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,sh7751-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 PCI Host controller
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +properties:
> +  compatible:
> +      - items:

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml:

    Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml:14:7:
[warning] wrong indentation: expected 4 but found 6 (indentation)

> +          - enum:
> +              - renesas,r2d-pci                 # Renesas RTS7751R2D board

    Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml:16:32:
[error] syntax error: found character '\t' that cannot start any token
(syntax)

> +              - iodata,julian-pci        # IO DATA DEVICE Julian board

Please drop the two board-specific compatible values, they do not
represent different implementations of the PCI core in the SH7751 SoC.

> +          - const: renesas,sh7751-pci
> +
> +  reg:
> +    minItems: 3
> +
> +  interrupt-cells:
> +    const: 1
> +
> +  address-cells:
> +    const: 3
> +
> +  size-cells:
> +    const: 2;
> +
> +  range:
> +    description: |
> +      The PCI bus memory area and I/O area.
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-cells
> +  - address-cells
> +  - size-cells
> +  - range
> +
> +examples:
> +  - |
> +        pci@fe200000 {

Please align "pci" with the "|" above

> +                compatible = "renesas,sh7751-pci";

Please indent by 4 spaces

> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
> +                         <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
> +                reg = <0xfe200000 0x0400>,
> +                      <0x0c000000 0x04000000>,
> +                      <0xff800000 0x0030>;
> +                #interrupt-cells = <1>;

    Documentation/devicetree/bindings/pci/renesas,sh7751-pci.example.dtb:
pci@fe200000: 'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#

> +        };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

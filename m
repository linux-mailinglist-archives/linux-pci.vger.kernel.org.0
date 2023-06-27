Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474673FC3F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjF0MzH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjF0My4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 08:54:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936F2715;
        Tue, 27 Jun 2023 05:54:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b5c231f842so42985711fa.2;
        Tue, 27 Jun 2023 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687870493; x=1690462493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YE7wSDf9+kixNjK3SC5HyvOe27Psh650QQ7iYwckpg=;
        b=cjChsABwaIiGiXFxDFxskK6sd1HRgZdRbC2eVH6wCVvr1AQrgInU+xKmVehbzpUzCc
         Ikpsh4LS5zq2zS3tYFKlFcY2TqDY0RTPND2efixaWg5ilaALZ06VJeA9KR9EvBgIs/EH
         k+4y3YgEIdJ7wMCGOmrLLOLXprttiBkx4N7vby4VzOg9mg1wvN9j+tCPuXxAggVk2f8I
         vtSeSDVDPP9GWwRwBA06A6OR+T2BEoRiiLnUiVSfUKh1+tgeWdpuFxnsYC5jFKx9kEec
         U+mvIorg2MMU2p14fPMWPuI1d8qRtYzdaOB5lT9aVav8LRJyKFbcbc/8mBYtYiZJoclX
         KGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870493; x=1690462493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YE7wSDf9+kixNjK3SC5HyvOe27Psh650QQ7iYwckpg=;
        b=HpZiIdB0OoPTtFfpXqsu6Yv+bCA803HOR5N3wVqTfMwCJ5USHG8U/od4Wby6LVuE8Y
         P37zo2W8cwjHC+liWwnAGzhrh25kecJracXTgZqTSOJzZEDB8thS7CDl4icJBvQznzKN
         vIoG/l1jgQKGI2Qt6XVqlgwT/2b41Y3V6veCTt+UFAv1EN5TnK9QwpwQ5nkCw8KdLT9E
         4qYrSPtMO5VjmKK1mQWOYXOAlCBgmunV5qJrorCAdagIMvepyhcTtguTQaaTLWIfA3LN
         YDY8du9PRGyZmz+1506oyZQDgNtuzLi/Tm04uMNn65LKGlhOZO/8CW727LXQudVWmgiq
         GUew==
X-Gm-Message-State: AC+VfDyHh1083B8gQgAvtIxWaTYJvW4SeulsrSMyYOyKLEuon/dxWSNn
        NolqUMIvLWZUoeS/O6rUtDb3m0Ro4R8=
X-Google-Smtp-Source: ACHHUZ5gkQTil60/IJCpxMy96qfRyWmGyiGxmtKV0FFui1C5evBEIgoYE3C3DgSY38t9mhHAHX1Ipg==
X-Received: by 2002:a2e:9e4f:0:b0:2b1:b4e9:4c3 with SMTP id g15-20020a2e9e4f000000b002b1b4e904c3mr21755792ljk.2.1687870492431;
        Tue, 27 Jun 2023 05:54:52 -0700 (PDT)
Received: from mobilestation ([109.194.233.142])
        by smtp.gmail.com with ESMTPSA id o10-20020a2e730a000000b002b217532064sm1737956ljc.33.2023.06.27.05.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:54:51 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:54:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: dwc: rockchip: Add missing
 legacy-interrupt-controller
Message-ID: <6ewtsaw72474pwvdohpapwnmbevivlkmagwnv7r7ggixhhmo6e@fcl74rn2rlqz>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 07:00:20PM +0200, Sebastian Reichel wrote:
> Rockchip RK356x and RK3588 handle legacy interrupts via a ganged
> interrupts. The RK356x DT implements this via a sub-node named
> "legacy-interrupt-controller", just like a couple of other PCIe
> implementations. This adds proper documentation for this and updates
> the example to avoid regressions.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 98e45d2d8dfe..bf81d306cc80 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -67,6 +67,22 @@ properties:
>        - const: legacy
>        - const: err
>  
> +  legacy-interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +

> +      "interrupt-controller": true

redundant quotes.

> +
> +      interrupts:
> +        items:
> +          - description: combined legacy interrupt

Missing the "additionalProperties" qualifier and the "required"
property.

-Serge(y)

> +
>    msi-map: true
>  
>    num-lanes: true
> @@ -148,6 +164,14 @@ examples:
>              reset-names = "pipe";
>              #address-cells = <3>;
>              #size-cells = <2>;
> +
> +            legacy-interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +                interrupt-parent = <&gic>;
> +                interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
> +            };
>          };
>      };
>  ...
> -- 
> 2.39.2
> 

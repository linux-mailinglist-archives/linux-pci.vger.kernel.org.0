Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5482A375C27
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 22:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEFUZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 16:25:31 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45026 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEFUZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 16:25:31 -0400
Received: by mail-ot1-f51.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so6021065otp.11;
        Thu, 06 May 2021 13:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRSy5HJ4wKKzzcIAmm8bwn1eA/q239E4iV9NKspBMgQ=;
        b=KGv0/h/tAE1w1C9kdX+EgFdBtj2LMGMmww1ZtOhUEn+MI2xw5B+zRcZFdtbxZnlZNr
         A1AjdIxtAtyM5b0jwCRLgop3kc2rHDSPtynk/RqxfvZEo2hN/nc1xohw5ajWOvBmDVHL
         U+DJcKFETNh3cTsBDWdstyWVyLrgEKOgu9hLXBM2mpQ0ujIVnnOwXANXAayrcJF0BbIz
         C6HGnrkLsJh33F3iIzn0nVLewXBIQjMB16AugQMdg6rPBLXcpr8yLoQaXCldoBFwu8is
         0zh0ajE4rNSDXW4jugDKxWRG4sl5Is6TX67SCIxHaGMsbq1xVWchCszb8IIdkPEKn0lS
         6iwg==
X-Gm-Message-State: AOAM532cUhnKvgroiRJHhXl+iDSnLO5vgY0lokHOJoop/D0XunVVt8ml
        CWSViqVoJOVVAa7z99mwJux4mxX+oA==
X-Google-Smtp-Source: ABdhPJyHdQpgdWvIqGzC91XpsF2u/FFaWKm8P8CKZ+v8DqkKxTmKAuIl8NvguPGgI4RlIbsfQXJRcg==
X-Received: by 2002:a9d:5a5:: with SMTP id 34mr5303714otd.353.1620332672219;
        Thu, 06 May 2021 13:24:32 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y11sm700130ooq.2.2021.05.06.13.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:24:30 -0700 (PDT)
Received: (nullmailer pid 744662 invoked by uid 1000);
        Thu, 06 May 2021 20:24:29 -0000
Date:   Thu, 6 May 2021 15:24:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: ixp4xx: Add device tree bindings for IXP4xx
Message-ID: <20210506202429.GA740891@robh.at.kernel.org>
References: <20210503211649.4109334-1-linus.walleij@linaro.org>
 <20210503211649.4109334-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503211649.4109334-4-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 03, 2021 at 11:16:48PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Intel IXP4xx
> PCI controller which can be used as both host and
> option.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Zoltan HERPAI <wigyori@uid0.hu>
> Cc: Raylynn Knight <rayknight@me.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> PCI maintainers: mainly looking for a review and ACK (if
> you care about DT bindings) the patch will be merged
> through ARM SoC.
> ---
>  .../bindings/pci/intel,ixp4xx-pci.yaml        | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
> new file mode 100644
> index 000000000000..5b6af2f5c2a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/intel,ixp4xx-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel IXP4xx PCI controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: PCI host controller found in the Intel IXP4xx SoC series.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - intel,ixp42x-pci
> +          - intel,ixp43x-pci
> +    description: The two supported variants are ixp42x and ixp43x,
> +      though more variants may exist.
> +
> +  reg:
> +    items:
> +      - description: IXP4xx-specific registers
> +
> +  ranges:
> +    maxItems: 2
> +    description: Typically one memory range of 64MB and one IO
> +      space range of 64KB.
> +
> +  dma-ranges:
> +    maxItems: 1
> +    description: The DMA range tells the PCI host which addresses
> +      the RAM is at. It can map only 64MB so if the RAM is bigger
> +      than 64MB the DMA access has to be restricted to these
> +      addresses.
> +
> +  "#interrupt-cells": true
> +
> +  interrupt-map: true
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0xf800
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges

Already required by pci-bus.yaml I think.

> +  - dma-ranges
> +  - "#interrupt-cells"
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pci@c0000000 {
> +      compatible = "intel,ixp43x-pci";
> +      reg = <0xc0000000 0x1000>;
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      device_type = "pci";
> +      bus-range = <0x00 0xff>;
> +      status = "disabled";

Don't show status in examples. 

I've really got to come up with an examples only schema to check this.

Rob

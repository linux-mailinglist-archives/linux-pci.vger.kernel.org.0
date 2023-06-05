Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01637229C4
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjFEOuw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjFEOuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 10:50:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692D39C;
        Mon,  5 Jun 2023 07:50:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso30054381fa.1;
        Mon, 05 Jun 2023 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685976647; x=1688568647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CvTsv6StQarzaCUb6Y3BI6iMSkyWjI1J6gI1OxaRWA=;
        b=H9a336dtHX3VxKvBid71xSouHafDszmeHRK+xa5/+RJSaUoFkqGQprpwjVBxNBHcXH
         MmfVD2zOSUe6benKcghlTIEIXibrQIpghyuSiHz8vAZsKUeoPlXYlSaetZ3jtby6yq7o
         ryAF8PGTIhNpEVWOHjP5yTtNlk5uR4Cm3fyO02vUm9YQHdGgcrjoSu3rapnWAlUzTmjU
         1FjGiXAHCdfVsMnlToTo5N+1CnuHje81xGDloLhW9ahvHs6douOfrt7oVSCiP7KY58Jg
         d6lTbtVYBgAeUH3HEE8p86rlk5jeQelx6wguQv/II3aYNGEbnFw+JEpwzJ1V37saWogS
         41lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685976647; x=1688568647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CvTsv6StQarzaCUb6Y3BI6iMSkyWjI1J6gI1OxaRWA=;
        b=d5NTp6xNHNx2DfOzxXSYNFn0ZyUB3TuI7Wcb5Llz4g9UBSE0TvkPQAHagac70yWoOI
         ZazkPd9UXicJ0hA04PWwDfWPU5iWNbGihfi18l/wfcyyyBfh8LMNSTS3QKDZiqMPN37u
         9St61bS4XneeDCiN8LYSo4bMJsus/TJUfVZqf17Xj2gs8EuklVQ30yDFMY/GTap7jdBs
         D6DDwB6ywVQ7QB/dk6Kk8I8cHwoX2tFncuqJH5ePQppfDYZ+6nSFR7EmYN+Mn8c38m8x
         F8FyRqJ5wQ7dzeqRUO8tqQ1R0JwnZfltQoz7I5vip02Ap8/XWZRZe9/ZHURXAGkfEPwy
         BwAA==
X-Gm-Message-State: AC+VfDwdkqcB1zwP7CI2/tUwMNhJw7oUnTb2aQ/AlJjGq5RVckvNB8mN
        QpA6JvEq/nJs+4j4Mymhdgk=
X-Google-Smtp-Source: ACHHUZ4HTdpf+yofswzjxoOCexCZ6E6G4jU7bfHc/HGMJR5Pn4Jy6KbE0v70YILNlbgjsXyAEx1L3w==
X-Received: by 2002:a2e:7e0f:0:b0:2b1:afe6:896b with SMTP id z15-20020a2e7e0f000000b002b1afe6896bmr4234871ljc.32.1685976647362;
        Mon, 05 Jun 2023 07:50:47 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o16-20020a2e7310000000b002ac871d0207sm1485831ljc.88.2023.06.05.07.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:50:46 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:50:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v16 18/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <20230605145044.7ritbyfgyacklniz@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-19-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-19-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:30PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> new file mode 100644
> index 000000000000..0453bdcf9645
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022-2023 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen4 PCIe Endpoint
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +allOf:
> +  - $ref: snps,dw-pcie-ep.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
> +      - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
> +
> +  reg:
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: app
> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: dma
> +      - const: sft_ce
> +      - const: app
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  max-functions:
> +    maximum: 2
> +
> +  max-link-speed:
> +    maximum: 4
> +
> +  num-lanes:
> +    maximum: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - resets
> +  - power-domains
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779f0-sysc.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0_ep: pcie-ep@e65d0000 {
> +            compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep";

> +            reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2800 0 0x0800>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "addr_space";

Just figured this out. I see you defining the dbi2 as <0 0xe65d2800 0
0x0800>. But sometime before you mentioned that your device has the
next CSRs layout:
! +0x0000 : Function 0 (common address in Root complex and Endpoint mode)
  +0x1000 : Function 1 (Endpoint mode only)
  +0x2000 : Shadow register for Function 0
! +0x2800 : Shadow register for Function 1
it means you have the dbi space defined for both functions meanwhile
the dbi2 space defined for _function #1_ only. Moreover
your DW PCIe End-point driver disables the multi-function feature
support. So AFAICS either you have wrong DW PCIe EP example node or
the node is wrong in your platform DTS too and you have a malfunction
end-point mode. Am I missing something? In any case based on the your
End-point driver implementation dbi2 is supposed to be defined at the
0xe65d2000 base address.

-Serge(y)

> +            interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "dma", "sft_ce", "app";
> +            clocks = <&cpg CPG_MOD 624>;
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            num-lanes = <2>;
> +            max-link-speed = <4>;
> +        };
> +    };
> -- 
> 2.25.1
> 

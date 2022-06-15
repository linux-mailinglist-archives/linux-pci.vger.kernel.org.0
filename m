Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8E54CBF4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbiFOOzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiFOOzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 10:55:53 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFB34B97;
        Wed, 15 Jun 2022 07:55:53 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id u2so8956898iln.2;
        Wed, 15 Jun 2022 07:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6pQnGfDjQoVp1rvU8e66nOIjBm74uZi19jZ+eXE+30s=;
        b=hx0f080zKcMVwRqLouxWGSBra8ogU2IRzWSq2FiGKaQcfKt2n3ojnEV7piiUY6F2e5
         dm3cmLr/GoBRkaWiFbY7+OS1uF+wYPPZcMum3pYnN+jf/WgBonp8Cjj3V5HIAfq39I+h
         gNE+tLiaNNohHSxfyusl0hDXnHXP2BPUynpWF5owhBq8GWJoT788Ij++Q4wwzC90Tyus
         mVrSMYS3LOAcPqhO95c6s0e+EssVIZCxokrPCNWgCiBtd0KUSrHFNLpkOMAgCFcn5xo/
         CXxiph8ybZU4r6YPdX+QlyiPDyPmTs36FprFRqBYV9dz3pNLdRgA+uE0adnNcqa8oxWf
         SJ4Q==
X-Gm-Message-State: AJIora8qzWTbJkc0k7NNtdR0mT2siblX85F2V6d6gvry88hNnTjXFFs2
        Ngt3I30QHg64YPn+YZGd3ps5kvL2Sw==
X-Google-Smtp-Source: AGRyM1v9D2xwxPLO3fWw6MLNBK1h8w8DrYTqErV5QnXKIatPBOp5wzKqusY55yPT3X8yHzscU6+Q/A==
X-Received: by 2002:a92:c54a:0:b0:2d3:b2ac:eb with SMTP id a10-20020a92c54a000000b002d3b2ac00ebmr113927ilj.323.1655304952460;
        Wed, 15 Jun 2022 07:55:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 126-20020a6b1484000000b00665714766a2sm6882497iou.47.2022.06.15.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:55:52 -0700 (PDT)
Received: (nullmailer pid 1139633 invoked by uid 1000);
        Wed, 15 Jun 2022 14:55:50 -0000
Date:   Wed, 15 Jun 2022 08:55:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/17] dt-bindings: PCI: dwc: Add max-link-speed
 common property
Message-ID: <20220615145550.GA1069883-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:56:52AM +0300, Serge Semin wrote:
> In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
> Let's add the max-link-speed property upper bound to 5 then. The DT
> bindings of the particular devices are expected to setup more strict
> constraint on that parameter.
> 
> [1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
> 5.40a, March 2019, p. 27
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 627a5d6625ba..b2fbe886981b 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -45,6 +45,9 @@ properties:
>        the peripheral devices available on the PCIe bus.
>      maxItems: 1
>  
> +  max-link-speed:
> +    maximum: 5

Unless the default is less than the max, shouldn't the max here be 1 
less than the h/w max?

> +
>    num-lanes:
>      description:
>        Number of PCIe link lanes to use. Can be omitted should the already
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> index dcd521aed213..fc3b5d4ac245 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -55,4 +55,6 @@ examples:
>  
>        phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
>        phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
> +
> +      max-link-speed = <3>;
>      };
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 4a5c8b933b52..01cedf51e0f8 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -74,4 +74,5 @@ examples:
>        phy-names = "pcie";
>  
>        num-lanes = <1>;
> +      max-link-speed = <3>;

This should give you an error because pci-bus.yaml only goes up to 4. 

I'm not really sure that limiting it in the common schema is too useful. 
We're going to be updating it one step at a time. Limiting it is really 
only helpful for specific implementations.

Patch 1 didn't apply for me, so none of the checks ran.

Rob

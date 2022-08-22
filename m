Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4B59C5C0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiHVSHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiHVSHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:07:16 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF246D84;
        Mon, 22 Aug 2022 11:07:15 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-11d08d7ece2so7134193fac.0;
        Mon, 22 Aug 2022 11:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4st3FM1bb6ia+hAlavpEGAbxXV7xofi5zmV7yc9Sy/E=;
        b=4V1HWE/RTu9erDGsb8/3rfdWHnsryf7i1860GC/YjWR+F/5qpm5DMOP56Wh+e4iIUG
         CXzOyq1jzPsP9K59OzOZMMTrutfxpXA4rg4FAYLs3+BxnmNeaWFEhtNpPFP0m78u99AZ
         rhP1Kajq5Vpv2stB23pL4uKFnO4/CdHAY+vKQgo93rSTJxJmoeuOTofZ4Jcshpwk4Fe2
         YSINYaMhAVd9WP65AgRgYt3lvigJU/311Ntgcoc9qkKGAGG9Rse9XoQl9Fbili7rLPRA
         Ys70WrI5il4R6tD8VkgbsFfsKGhT7TXksSZilzfy0cVC7r1FgW5cy9ryUVv85PcUcwsz
         j1cQ==
X-Gm-Message-State: ACgBeo0esAAHqaiIZBZDkBW/LHUzXDUzrDtgGp+7/M7T+FLWh/I19HDA
        kfBQvUjCMyyQP/3Un4dc+A==
X-Google-Smtp-Source: AA6agR7XnzRL6Jn/3yMP/dI6TmfBLdDYyqWeS2JSRz9HOciSHoo08QZzFiSxHw3wKjI+/ntOSIyv3A==
X-Received: by 2002:a05:6870:41c6:b0:11c:6053:2fed with SMTP id z6-20020a05687041c600b0011c60532fedmr9777964oac.114.1661191634964;
        Mon, 22 Aug 2022 11:07:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p39-20020a05687056a700b0010d5d5c3fc3sm3104887oao.8.2022.08.22.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:07:14 -0700 (PDT)
Received: (nullmailer pid 80167 invoked by uid 1000);
        Mon, 22 Aug 2022 18:07:13 -0000
Date:   Mon, 22 Aug 2022 13:07:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
Message-ID: <20220822180713.GA75195-robh@kernel.org>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <1660806153-29001-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660806153-29001-3-git-send-email-hongxing.zhu@nxp.com>
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

On Thu, Aug 18, 2022 at 03:02:29PM +0800, Richard Zhu wrote:
> Add i.MX8MP PCIe PHY binding.

Explain the differences in h/w. The phy is connected to PERST#?

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml          | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> index b6421eedece3..692783c7fd69 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - fsl,imx8mm-pcie-phy
> +      - fsl,imx8mp-pcie-phy
>  
>    reg:
>      maxItems: 1
> @@ -28,11 +29,16 @@ properties:
>        - const: ref
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    reset-names:
> -    items:
> -      - const: pciephy
> +    oneOf:
> +      - items:          # for iMX8MM
> +          - const: pciephy
> +      - items:          # for IMX8MP
> +          - const: pciephy
> +          - const: perst

This does the same thing:

minItems: 1
items:
  - const: pciephy
  - const: perst


>  
>    fsl,refclk-pad-mode:
>      description: |
> @@ -60,6 +66,10 @@ properties:
>      description: A boolean property indicating the CLKREQ# signal is
>        not supported in the board design (optional)
>  
> +  power-domains:
> +    description: PCIe PHY  power domain (optional).
> +    maxItems: 1
> +
>  required:
>    - "#phy-cells"
>    - compatible
> -- 
> 2.25.1
> 
> 

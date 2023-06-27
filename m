Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2673FC9B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0NP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjF0NPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 09:15:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFA26BA;
        Tue, 27 Jun 2023 06:15:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f86dbce369so6074010e87.0;
        Tue, 27 Jun 2023 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687871720; x=1690463720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMNoJT8hPvOgickLb3tIrjnQjsjqpdNLJafYlSM3WJ0=;
        b=ZIMXw14K7xllAD+oUnVq1yykhWL0q5zGOzs4VkC4Miq8z4QBlOIeoaIm7ti062ThTW
         bH1CaNACe+KaqFdnP1d0+YGDgfP3OjlabEqH8lkBpKK1b4igcHPKWCAG0x65EUzdlbwH
         cPSAL+ns/a82HQe7qbDuiSJfnHbheEFA104OFFZhjX0yWUs32Nq0W/B0f9gyzPIFzDPz
         N5t59nCm08mt2QpUDBZnA1JjayMPE06gDaaQ2L7EK0HLv3qoor6kARN4qhL+rq/rSM2S
         FgDjuLlBAfAl+LixmZfAgK5jYRI4qWpgHSsmBVU4/SkNU0kXjLCvbACVvBEDLXzAMU4p
         qqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871720; x=1690463720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMNoJT8hPvOgickLb3tIrjnQjsjqpdNLJafYlSM3WJ0=;
        b=GsyDSY9ZO0yujla+XVR6lKYswWTYT4ZjSJN2uSlNfjEHbmE+MgcxWJBC1PcjcOefGw
         wblODzK2TypaVn+XQkV5VaVHIYad24KfPmpKiqrVIBy09PRtUzAF8nFh9PwLxFQ9vvSz
         s51B4BfZUvEm2MS2hLlzPV9oLxZhSkFlt9QRJbdqIwURV4BX8E2zJL98bQS4vORaM9Z1
         +YSNMhP6ifTFySjAibQsuyG5cVdDtzMyoCtXFthnKE+a/GbeyCHo5JQeLi+UD60BcC5I
         h/lkci06EoPsNLMRlUgy67yfgLwLoG4q24nA1vU4RFmpbIFw5Ka8Uj+yagY07Tfev8pm
         NwXg==
X-Gm-Message-State: AC+VfDxS6V6wllBV0ZQbh6vQqRZltNCf5kaR1GcRBj8Ohhoq7o1nrI50
        ihM6iOaCh+N3aQSQBaz3M37W5KV73S4=
X-Google-Smtp-Source: ACHHUZ5icUHSPxZrlGwMtUuxnOzym9Z9UIWELwuRvJ5tht9IILNV7rwhC+H4HuHjIPp9l83Vv+wsJg==
X-Received: by 2002:a19:5053:0:b0:4f9:5519:78b8 with SMTP id z19-20020a195053000000b004f9551978b8mr12643966lfj.63.1687871720124;
        Tue, 27 Jun 2023 06:15:20 -0700 (PDT)
Received: from mobilestation ([109.194.233.142])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b004fb881e5c23sm147435lfp.47.2023.06.27.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:15:19 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:15:12 +0300
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
Subject: Re: [PATCH v1 3/4] dt-bindings: PCI: dwc: rockchip: Update for RK3588
Message-ID: <tcwgwwyx5lvoowp2bxkaemfp7eefbvmfzwprcml7wmtrwadxtm@et2ofo64cru2>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-4-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 07:00:21PM +0200, Sebastian Reichel wrote:
> The PCIe 2.0 controllers on RK3588 need one additional clock,
> one additional reset line and one for ranges entry.

Just a nitpick: it would be perfect to have these new items evaluated
compatible-string conditionally. Anyway:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml           | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index bf81d306cc80..7897af0ec297 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -41,20 +41,24 @@ properties:
>        - const: config
>  
>    clocks:
> +    minItems: 5
>      items:
>        - description: AHB clock for PCIe master
>        - description: AHB clock for PCIe slave
>        - description: AHB clock for PCIe dbi
>        - description: APB clock for PCIe
>        - description: Auxiliary clock for PCIe
> +      - description: PIPE clock
>  
>    clock-names:
> +    minItems: 5
>      items:
>        - const: aclk_mst
>        - const: aclk_slv
>        - const: aclk_dbi
>        - const: pclk
>        - const: aux
> +      - const: pipe
>  
>    interrupts:
>      maxItems: 5
> @@ -97,13 +101,19 @@ properties:
>      maxItems: 1
>  
>    ranges:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    reset-names:
> -    const: pipe
> +    oneOf:
> +      - const: pipe
> +      - items:
> +          - const: pwr
> +          - const: pipe
>  
>    vpcie3v3-supply: true
>  
> -- 
> 2.39.2
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2B6BF0B8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCQSan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 14:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCQSam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 14:30:42 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F34D602;
        Fri, 17 Mar 2023 11:30:40 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id b5so2716176iow.0;
        Fri, 17 Mar 2023 11:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgkvJWHBERZyI9ZrvVnjcfVqSbigpZwA/hgWkyiT5z8=;
        b=CY7MDKi0csnPLPD2xX+r0VLmlTsM/g0Sa0IGiS6peyxGR1A2eALLujCulYCrBo7Mnq
         Uo+KPKGioQLq80QyAN80Xhh9P08flTTPMc5EBKWJmNwn5LTO0CeqN5TnQEsI6i8wuqnc
         w7j10O5gxphkBNIpVZ5IfUsLZDK7+c7dRy0Jl9vLaHb6mbgS9tD9AY3xzySr1InIaQD9
         8TAPGzMG0zg7Kp+3xzRdmm1447ZbA84n6UGTXwHNW7vTWpjMv48PAXUd4fCdmMe6/YS6
         2+KI0rxujk38mbNIAhiSVphvOeip89z8sfjbUiUpltnG3wJttLt7W7ILMs+qyANm/1Yk
         TUbQ==
X-Gm-Message-State: AO0yUKUnuJuFi6eAiBEFd3pB7iG6FY3FTWUDzhMgfffLCU4/E9JKlDX+
        rObt3BpjmXk9wI2AswxxnQ==
X-Google-Smtp-Source: AK7set888W8VrYdXLwryZbq2QFnCkjzeBscyk2PT/WSfT3V/hKTItdj690f1fK1WTP+4BIuCO0yLnw==
X-Received: by 2002:a5e:a90f:0:b0:752:e9a2:1c5b with SMTP id c15-20020a5ea90f000000b00752e9a21c5bmr260158iod.14.1679077839913;
        Fri, 17 Mar 2023 11:30:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 6-20020a056e020ca600b00322f16e8906sm796106ilg.29.2023.03.17.11.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:30:39 -0700 (PDT)
Received: (nullmailer pid 2585626 invoked by uid 1000);
        Fri, 17 Mar 2023 18:30:37 -0000
Date:   Fri, 17 Mar 2023 13:30:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: PCI: dwc: Add dma-ranges, region mask
Message-ID: <20230317183037.GB2445959-robh@kernel.org>
References: <20230313124016.17102-1-enachman@marvell.com>
 <20230313124016.17102-5-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-5-enachman@marvell.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:40:12PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add properties to support configurable DMA mask bits and region mask bits:
> 
>  1. configurable dma-ranges is needed for Marvell AC5/AC5X SOCs which
>     have their physical DDR memory start at address 0x2_0000_0000.
> 
>  2. Configurable region mask bits is needed for the Marvell Armada
>     7020/7040/8040 SOCs when the DT file places the PCIe window above the 4GB region.
>     The Synopsis Designware PCIe IP in these SOCs is too old to specify the
>     highest memory location supported by the PCIe, but practically supports
>     such locations. Allow these locations to be specified in the DT file.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
> v4:
>    1) Fix commit message and its formatting
> 
>    2) Replace num-dmamask with dma-ranges
> 
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 5 +++++
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml     | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index d87e13496834..3cb9af1aefeb 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -261,6 +261,11 @@ properties:
>  
>    dma-coherent: true
>  
> +  num-regionmask:
> +    description: |
> +      number of region limit mask bits to use, if different than default 32
> +    maximum: 64

This should be implied from the compatible string.

> +
>  additionalProperties: true
>  
>  ...
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 1a83f0f65f19..ed7ae2a14804 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -197,6 +197,12 @@ properties:
>        - contains:
>            const: msi
>  
> +  dma-ranges:
> +    description:
> +      Defines the DMA mask for devices which due to non-standard HW address
> +      assignment have their RAM starting address above the lower 32-bit region.
> +      Since this is a mask, only the size attribute of the dma-ranges is used.
> +

No need for this, it is already defined in pci-bus.yaml.

The description is wrong here anyways. The purpose is to translate 
inbound PCI addresses to parent bus addresses (and eventually CPU 
addresses).

Rob

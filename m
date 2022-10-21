Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1930B606DBC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 04:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJUC0t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 22:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJUC0s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 22:26:48 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200B2A425;
        Thu, 20 Oct 2022 19:26:47 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so998078otp.10;
        Thu, 20 Oct 2022 19:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDqNridPu4b3DWNOWE26l4CoQc8TEaUuVi755eJfbfM=;
        b=IRTocwp/mttHVqL5sFfWq95c+C28h9pB4EW/h3eEZTtUGoAbQ7b8mBw/8PN5N63LFT
         8+LG+H5wkW2lnJH/4KDaAxYyNfhP1WpYjuxoRw8Tn1otiO+W5bwDRQIEIkfYLGk1+7Qk
         4vuAESCE4iBp4ZBncRFF9EQ5DpOnZNmnBW268279hqLcGaZxOQ/KyZFH5KplOXUJZoA1
         vWMv6nf4PBJ6IJ5f6/PX1I6/kDk3KcN3aP/WajQtXLYhsXXEFJ7BNdZbyToVmdbSZGgt
         OIQ0/YR5QlayYBvxP2zPIyb8o9ZaYuBYrU6e2dRxGlB2TVF+h0J7UcuoVBY+Y7tuhp89
         MjFA==
X-Gm-Message-State: ACrzQf1TrKvVYskStQGsY7fSWIYExCJAVFj5nONFEd1hUWVx/iI4Yq/f
        jnaYFuelhgOk+syPOBRhKg==
X-Google-Smtp-Source: AMsMyM5OG4SV586ygEDXiK/8qNiWP4nSMoSliVuOWl6DkOZEHBeJLUj3wFt/tL+Svde26yJzL0U3aw==
X-Received: by 2002:a05:6830:6611:b0:662:2725:d309 with SMTP id cp17-20020a056830661100b006622725d309mr136812otb.293.1666319206599;
        Thu, 20 Oct 2022 19:26:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x7-20020a056870e38700b0013297705e5dsm9487908oad.28.2022.10.20.19.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:26:46 -0700 (PDT)
Received: (nullmailer pid 2198615 invoked by uid 1000);
        Fri, 21 Oct 2022 02:26:47 -0000
Date:   Thu, 20 Oct 2022 21:26:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Message-ID: <20221021022647.GA2195154-robh@kernel.org>
References: <20221020111925.30002-1-tinghan.shen@mediatek.com>
 <20221020111925.30002-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020111925.30002-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 07:19:23PM +0800, Tinghan Shen wrote:
> From: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> In order to support mt8195 pcie node, update the yaml to support new
> properties of iommu and power-domain, and update the reset-names
> property to allow only one 'mac' name.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml         | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index c00be39af64e..af271018b134 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -70,14 +70,21 @@ properties:
>      minItems: 1
>      maxItems: 8
>  
> +  iommu-map:
> +    maxItems: 1
> +
> +  iommu-map-mask:
> +    maxItems: 1

This is not a array. It needs a value. Must be 0 if iommu-map only has 1 
entry? Or you only support 1 downstream device?

> +
>    resets:
>      minItems: 1
>      maxItems: 2
>  
>    reset-names:
> -    minItems: 1
> -    items:
> -      - const: phy
> +    oneOf:
> +      - items:
> +          - const: phy
> +          - const: mac
>        - const: mac
>  
>    clocks:
> @@ -107,6 +114,9 @@ properties:
>      items:
>        - const: pcie-phy
>  
> +  power-domains:
> +    maxItems: 1
> +
>    '#interrupt-cells':
>      const: 1
>  
> -- 
> 2.18.0
> 
> 

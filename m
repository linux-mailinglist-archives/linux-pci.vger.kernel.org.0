Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D1628FA7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 03:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiKOCBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 21:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKOCBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 21:01:36 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30F3BC8C;
        Mon, 14 Nov 2022 18:01:35 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so4719997otl.7;
        Mon, 14 Nov 2022 18:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uVoJ4OLVHwTzLXSP9dYjKjlbvNqf1vT60U41Z0zdRw=;
        b=wfkJTTk8tzthI+wpDfbUFDSwD0BQKd7KCamuUfRhrPVtLrZELliNXtDHtD/MThShLf
         ujyvdtKk8rf2wO9OLJpDJxKRrQHJzj0t3tXTB+rxtg5qZmE6iiXSpIc70bhFw7ST2j1w
         GO/bNT3AgHZ/72PpNum4obL9VLh3DCX9a8O1qE3HS7qFqEKF0oJv0SpDYAUoC3CcDx/z
         EHBUSR1CNU0qMTB/vCZJBjwxDiDuknwCgc5i0u8fpQATlPahZ8SOMt/yLr8tkGYxash3
         Z45OfUlkLdzfiDlc9qyOjVx9Ldiv2TF7l8+z3CGCGCl6b/cvzl+Z784h+hGuv6ZZWecp
         +Z2g==
X-Gm-Message-State: ANoB5pnb9niTKPrquSAyLLtEVazMHQivRscX1G5YIi87zO+8Ec9lbwo3
        /wjx0mOMxFLpW+l0LFzteQ==
X-Google-Smtp-Source: AA0mqf6JzA4dLgXt4SaqIGaCg5RTVbpGiafLQHD3jZNJd5s9ZeAeVvF3TSwZy9klORv6Gfe4nMQ+1g==
X-Received: by 2002:a05:6830:4ce:b0:660:ca92:f787 with SMTP id s14-20020a05683004ce00b00660ca92f787mr7710169otd.118.1668477694845;
        Mon, 14 Nov 2022 18:01:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh39-20020a056808182700b0035ab03d9153sm4366253oib.47.2022.11.14.18.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:01:34 -0800 (PST)
Received: (nullmailer pid 3982179 invoked by uid 1000);
        Tue, 15 Nov 2022 02:01:36 -0000
Date:   Mon, 14 Nov 2022 20:01:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <20221115020136.GA3973578-robh@kernel.org>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114155333.234496-2-jonathanh@nvidia.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Add support for ECAM aperture that is only supported for Tegra234
> devices.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V2:
> - Avoid duplication of reg items and reg-names
> Changes since V1:
> - Restricted the ECAM aperture to only Tegra234 devices that support it.
> 
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> index 75da3e8eecb9..fe81d52c7277 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> @@ -27,6 +27,7 @@ properties:
>        - nvidia,tegra234-pcie
>  
>    reg:
> +    minItems: 4
>      items:
>        - description: controller's application logic registers
>        - description: configuration registers
> @@ -35,13 +36,16 @@ properties:
>            available for software access.
>        - description: aperture where the Root Port's own configuration
>            registers are available.
> +      - description: aperture to access the configuration space through ECAM.
>  
>    reg-names:
> +    minItems: 4
>      items:
>        - const: appl
>        - const: config
>        - const: atu_dma
>        - const: dbi
> +      - const: ecam

Wouldn't this be mutually exclusive with 'config'? 'config' is not 
really h/w, but an just an iATU window typically.

Where's the driver change to use this?

Rob

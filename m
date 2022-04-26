Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4450EDBD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 02:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiDZAsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 20:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbiDZAsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 20:48:36 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F981A385;
        Mon, 25 Apr 2022 17:45:30 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id c17-20020a056830349100b00605ca7d1deeso454082otu.3;
        Mon, 25 Apr 2022 17:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHFXXUvQ61ZGJvron/eUkUKUWWuApkj5E+Lgv3f9owg=;
        b=o3Kmh2wNdhoOLr+U4qOeS1fFajQHJ6pPHWfUyxG64lGqZV5zj8gazlGAJXEc7nQ4gJ
         zRyKefnB16bKHJpXx4L6EPm7uZ6Bkq1gAXx2GL2yuoJwtN11EbEmZlK8zFojlxXezW2i
         swHbzhec7dDsL7eAE5p4kpCyhFtvM0bqLGeUAFnXHPRkiePs7XDSlglbcwIolElcPYgh
         krws6OF3lVIdH7AV/Nm3uyP49KyRhInhaYgDdn7c5ToewDFUmEnx/Ym1MwL3p+5sFAM3
         tOnLmd6mK0syBvKXXVHyQAQXB0aY6IIA10gS9MFrUqoAO/8QYal9eJ+PYdm6J9auE7+S
         PyNg==
X-Gm-Message-State: AOAM531CCSXSuueBYgsQxPDE7an8OygkPM96yry00cOOA83RVBkpfrlz
        ftLb7PonRkPl6M4YeImnM09BcJCbqw==
X-Google-Smtp-Source: ABdhPJxkeIGYtkLICo4XEu52cfsboSYKqPaOFWtktY9Kowc6nc8O0Zn/pezr2ZwvE0LOVYJ6H9Tkxw==
X-Received: by 2002:a05:6830:4:b0:604:fbdd:deaf with SMTP id c4-20020a056830000400b00604fbdddeafmr7323688otp.84.1650933929928;
        Mon, 25 Apr 2022 17:45:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o3-20020a056870a50300b000e686d13891sm285290oal.43.2022.04.25.17.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:45:29 -0700 (PDT)
Received: (nullmailer pid 641823 invoked by uid 1000);
        Tue, 26 Apr 2022 00:45:28 -0000
Date:   Mon, 25 Apr 2022 19:45:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: PCI: pci-rcar-gen2: Convert bindings
 to json-schema
Message-ID: <YmdAqGyl5pyjvwX+@robh.at.kernel.org>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
 <20220422120850.769480-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422120850.769480-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 02:08:43PM +0200, Herve Codina wrote:
> Convert Renesas PCI bridge bindings documentation to json-schema.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 ----------
>  .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 156 ++++++++++++++++++
>  2 files changed, 156 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml

> diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> new file mode 100644
> index 000000000000..494eb975c146
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,pci-rcar-gen2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas AHB to PCI bridge
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +description: |
> +  This is the bridge used internally to connect the USB controllers to the
> +  AHB. There is one bridge instance per USB port connected to the internal
> +  OHCI and EHCI controllers.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Don't need oneOf with only 1 entry. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +          - enum:
> +              - renesas,pci-r8a7742      # RZ/G1H
> +              - renesas,pci-r8a7743      # RZ/G1M
> +              - renesas,pci-r8a7744      # RZ/G1N
> +              - renesas,pci-r8a7745      # RZ/G1E
> +              - renesas,pci-r8a7790      # R-Car H2
> +              - renesas,pci-r8a7791      # R-Car M2-W
> +              - renesas,pci-r8a7793      # R-Car M2-N
> +              - renesas,pci-r8a7794      # R-Car E2
> +          - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
> +

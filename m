Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A13624C4D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiKJVBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKJVBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:01:05 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B155610E4;
        Thu, 10 Nov 2022 13:01:04 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id l127so3123793oia.8;
        Thu, 10 Nov 2022 13:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDqn8BDU2tLIVGpP/7JbZcQ8NuPGFYgE6/tTyJvpJB8=;
        b=CCWjmICdl7mpNZ4sAYxuhzGImSJXo86/z7jNU8gXJ1yoaG8maQYNI6pajt+yADZUlE
         z30NhFGt/lO1AAVdSBusR/3BgPCVAkjY6mznrL0cgXVGUAgzhPc6p89w86ezc0WupJuK
         vdHTsvSep+laQZkkfQQyBt50ijJXe/jAeEjmn3OS002hgJY3rytRf2C2cC7zGILNUxZq
         Y81vQDdGa7NIjVRVNrW+6InhE8SuUjmjQ8TD0IFnslqyyBX/RN80avW5W6JO1Xha+Ag8
         dQ+gwr45gMtRg0dbZC3YIyHRWeyG3BYpLyzzOiI/B6ko/ht4u+GLlcfHUbnMUAb8aHqZ
         HarQ==
X-Gm-Message-State: ACrzQf3HfDGCrLoP9XQKaKxd5WtEcl6ARMOd4/mtB5z8YzXXPUTK51qv
        ExJQR57CCteEP6x+kf2Mmw==
X-Google-Smtp-Source: AMsMyM5YKvFMdUbdZPYOAHkKC93jpUw2ItMlN+pxG+7jwvZl9DyN0X7pMLBe9clIzRPUHibvryVqZw==
X-Received: by 2002:aca:2105:0:b0:359:e9f6:e37d with SMTP id 5-20020aca2105000000b00359e9f6e37dmr2191361oiz.76.1668114063885;
        Thu, 10 Nov 2022 13:01:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j18-20020a9d7392000000b0066c34486aa7sm243697otk.73.2022.11.10.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:01:03 -0800 (PST)
Received: (nullmailer pid 975802 invoked by uid 1000);
        Thu, 10 Nov 2022 21:01:04 -0000
Date:   Thu, 10 Nov 2022 15:01:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Message-ID: <20221110210104.GA963064-robh@kernel.org>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107204934.32655-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 07, 2022 at 11:49:15PM +0300, Serge Semin wrote:
> Originally as it was defined the legacy bindings the pcie_inbound_axi and
> pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> Let's fix that by conditionally apply the clock-names constraints based on
> the compatible string content.
> 
> Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> ---
> 
> Changelog v5:
> - This is a new patch added on the v5 release of the patchset.
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 376e739bcad4..ebfe75f1576e 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -16,6 +16,47 @@ description: |+
>  
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx6sx-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +            - const: pcie_inbound_axi
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mq-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +            - const: pcie_aux
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - fsl,imx6sx-pcie
> +                - fsl,imx8mq-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
>  
>  properties:
>    compatible:
> @@ -57,11 +98,7 @@ properties:
>  
>    clock-names:
>      minItems: 3
> -    items:
> -      - const: pcie
> -      - const: pcie_bus
> -      - const: pcie_phy
> -      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie

This should have been just 'enum: [ pcie_inbound_axi, pcie_aux ]'

And then do:

  - if:
      properties:
        compatible:
          contains:
            const: fsl,imx8mq-pcie
    then:
      properties:
        clock-names:
          items:
            - {}
            - {}
            - {}
            - const: pcie_aux


And then another if/then with 'maxItems: 3'

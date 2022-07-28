Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBE584855
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiG1WhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiG1WhX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 18:37:23 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6C3190B;
        Thu, 28 Jul 2022 15:37:22 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id w16so1669004ilh.0;
        Thu, 28 Jul 2022 15:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=dYYAr8co2bcY4aoh9KM7tdmdrbq0srMDfWvjozC6xYU=;
        b=f3QmZKZp9YgTX8dBap6eZTqiKkMQ0VxceiKY3dLuWX5oa01UutF0886iklgVzu2LNm
         F2XRq7d0U1dwaJ5vlr679huotNOCHv+L9uYdpyw4Z8PY+mJbHFGje3qZhD0TOBUWicDP
         9ZUdFmMzcgiwxZCzYZ2slrSSEh5li0cw66aN8ys7Yusgdacaj9vXHn/ekZjIKBIn0WlU
         NDdWqiOarTKs13ogG2FmxbPsZU45jR2tP6xOh5DAp+fmNDCcdCH9DXbtNY0TLFNB9jGX
         uaX5kRiX8dbHNRjO+4+OB1HRLYnMHowK6x0r+12wM+TkTBoq6MBR/xfW19pec4EcuX47
         /tPg==
X-Gm-Message-State: AJIora89lgrB/6FY0PAezZgwWBdKOGe9U4/RLC4mZwqSPjFkhuXb0A14
        afoGqRW16RyIqi01sTz5hQ==
X-Google-Smtp-Source: AGRyM1t8gPtr0jfiLGqpqBeVgPBWp5Jvaj+VqsYRj5EBlOfRnZku+XX3U8Phe8/Vi4cysn8vqzid8A==
X-Received: by 2002:a05:6e02:1aa5:b0:2dd:384:f3ba with SMTP id l5-20020a056e021aa500b002dd0384f3bamr295123ilv.45.1659047841615;
        Thu, 28 Jul 2022 15:37:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y8-20020a027308000000b00339c4e447e2sm897117jab.151.2022.07.28.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:37:21 -0700 (PDT)
Received: (nullmailer pid 1710887 invoked by uid 1000);
        Thu, 28 Jul 2022 22:37:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Frank Li <Frank.Li@nxp.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pci@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20220728143427.13617-6-Sergey.Semin@baikalelectronics.ru>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru> <20220728143427.13617-6-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 05/17] dt-bindings: PCI: dwc: Stop selecting generic bindings by default
Date:   Thu, 28 Jul 2022 16:37:18 -0600
Message-Id: <1659047838.052652.1710886.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Jul 2022 17:34:15 +0300, Serge Semin wrote:
> It's highly encouraged to have the separate DT schema for each available
> particular device, while the generic schema should be left untouched
> representing just a set of the common device properties (mainly advertised
> by the IP-core reference manual). Seeing there is no currently DW PCIe
> RP/EP dts nodes with only generic compatible string and since there isn't
> any vendor-specific compatible string added to the generic DT schema,
> before it's too late let's mark the snps,dw-pcie.yaml and
> snps,dw-pcie-ep.yaml schemas not selected for checking by default and add
> the explicit requirement to have the compatible string containing the
> generic device name.
> 
> Note due to this modification we need to switch some of the DW PCIe-based
> DT-bindings to referring to the common DT-schema instead of evaluating
> against the generic DW PCIe DT-bindings. They are already defined as
> having the vendor-specific compatible string only. So we can't change that
> semantic.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> - Fix compatible property schema so one would work as expected: string
>   must contain either generic DW PCIe IP-core name or both generic and
>   equipped with IP-core version names.
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          |  3 ++-
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    |  3 ++-
>  .../bindings/pci/sifive,fu740-pcie.yaml       |  3 ++-
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 24 +++++++++++++++----
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 24 +++++++++++++++----
>  .../pci/socionext,uniphier-pcie-ep.yaml       |  9 +++----
>  .../bindings/pci/toshiba,visconti-pcie.yaml   |  3 ++-
>  7 files changed, 53 insertions(+), 16 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dtb: pcie@e00000000: Unevaluated properties are not allowed ('clocks', 'interrupts' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.example.dtb: pcie@28400000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb:0:0: /example-0/pcie-ep@dfd00000: failed to match any schema with compatible: ['vendor,soc-pcie', 'snps,dw-pcie-ep']
Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb:0:0: /example-0/pcie@dfc00000: failed to match any schema with compatible: ['vendor,soc-pcie', 'snps,dw-pcie']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dtb: pcie@15700000: compatible: 'anyOf' conditional failed, one must be fixed:
	['samsung,exynos5433-pcie'] does not contain items matching the given schema
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dtb: pcie@15700000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'ranges' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.example.dtb: pcie@66000000: compatible: 'anyOf' conditional failed, one must be fixed:
	['socionext,uniphier-pcie'] does not contain items matching the given schema
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.example.dtb: pcie@66000000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'interrupt-names', 'interrupts', 'ranges' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dtb: pcie@f4000000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dtb: pcie@f5000000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


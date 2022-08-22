Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145A559CB2E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 23:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiHVV53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHVV51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 17:57:27 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B150564D7;
        Mon, 22 Aug 2022 14:57:26 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so8609555otd.12;
        Mon, 22 Aug 2022 14:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=PdkIZjhOP4TvDPaY2zDpfYtQ/nCjxN0inguu0eaL+7k=;
        b=SDmI+fY5BG+lz/3qa7JBYVdSRWCydsPcpn+oKq5ZVE2E0usbnQtNh5xLAc2ZWF+oyV
         vpxkAAsTVX1RGN3QoO8JRVRiRNTNXQ+RwQGbTT7MpPL8BUP/BawF+deqgMT3zvof7/s3
         cN2JT1nPlQ4fGa9tJJ3lxPDrpK9xxXj8bEMm/U/OyZMpqLUzZ1dzFqYZ/Q7kQdj2d0n+
         U8ZPndSMa4Hi3Y0maUFjZ7XP5dA/zjlF+Peoj7zri16pU4GxusNt6URcuvuFq0JlDfzA
         R26kVysF1AbdoX/F8E0WxSqW5R0uLqHhkhVHJxZ8eOr0bF7gOITb7fs8jw4rtJw4QhMO
         49zg==
X-Gm-Message-State: ACgBeo182/UqY2ID0UnzS37y88WU7Nf35z2a1PMu6/1eG+0zWKYQ0bpN
        F+B3qaESz4/tneTiDT0cmg==
X-Google-Smtp-Source: AA6agR52en3TcgQx4Fip4edqZpW5gFrLNHJzUDABegYmD68NdwLiTxNk0/hdM4PuOU8NYhoOxWR33Q==
X-Received: by 2002:a05:6830:1017:b0:637:163a:38db with SMTP id a23-20020a056830101700b00637163a38dbmr8148680otp.89.1661205445272;
        Mon, 22 Aug 2022 14:57:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y6-20020a056871010600b00118687c3907sm3176119oab.24.2022.08.22.14.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:57:24 -0700 (PDT)
Received: (nullmailer pid 931362 invoked by uid 1000);
        Mon, 22 Aug 2022 21:57:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-6-Sergey.Semin@baikalelectronics.ru>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru> <20220822184701.25246-6-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v5 05/20] dt-bindings: PCI: dwc: Add phys/phy-names common properties
Date:   Mon, 22 Aug 2022 16:57:24 -0500
Message-Id: <1661205444.106003.931361.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Aug 2022 21:46:46 +0300, Serge Semin wrote:
> It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
> PHY phandle references. There can be up to 16 PHYs attach in accordance
> with the maximum number of supported PCIe lanes. Let's extend the common
> DW PCIe controller schema with the 'phys' and 'phy-names' properties
> definition. The PHY names are defined with the regexp pattern
> '^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
> the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
> "pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
> keystone, dra7xx; "pcie": histb, etc). Though the "pcie%d" format would
> the most preferable in this case.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> 
> Changelog v5:
> - Add a note about having line-based PHY phandles order. (@Rob)
> - Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 19 +++++++++++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |  3 +++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  3 +++
>  3 files changed, 25 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14180000: phy-names: 'oneOf' conditional failed, one must be fixed:
	'p2u-0' does not match '^pcie[0-9]+$'
	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-1' does not match '^pcie[0-9]+$'
	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-2' does not match '^pcie[0-9]+$'
	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-3' does not match '^pcie[0-9]+$'
	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14180000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'linux,pci-domain', 'num-lanes', 'ranges', 'supports-clkreq' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14160000: phy-names: 'oneOf' conditional failed, one must be fixed:
	'p2u-0' does not match '^pcie[0-9]+$'
	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-1' does not match '^pcie[0-9]+$'
	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-2' does not match '^pcie[0-9]+$'
	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-3' does not match '^pcie[0-9]+$'
	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14160000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'linux,pci-domain', 'num-lanes', 'num-viewport', 'ranges' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: phy-names: 'oneOf' conditional failed, one must be fixed:
	'p2u-0' does not match '^pcie[0-9]+$'
	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-1' does not match '^pcie[0-9]+$'
	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-2' does not match '^pcie[0-9]+$'
	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-3' does not match '^pcie[0-9]+$'
	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-4' does not match '^pcie[0-9]+$'
	'p2u-4' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-5' does not match '^pcie[0-9]+$'
	'p2u-5' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-6' does not match '^pcie[0-9]+$'
	'p2u-6' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-7' does not match '^pcie[0-9]+$'
	'p2u-7' does not match '^pcie(-?phy[0-9]*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('num-lanes' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: phy-names: 'oneOf' conditional failed, one must be fixed:
	'p2u-0' does not match '^pcie[0-9]+$'
	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-1' does not match '^pcie[0-9]+$'
	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-2' does not match '^pcie[0-9]+$'
	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-3' does not match '^pcie[0-9]+$'
	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-4' does not match '^pcie[0-9]+$'
	'p2u-4' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-5' does not match '^pcie[0-9]+$'
	'p2u-5' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-6' does not match '^pcie[0-9]+$'
	'p2u-6' does not match '^pcie(-?phy[0-9]*)?$'
	'p2u-7' does not match '^pcie[0-9]+$'
	'p2u-7' does not match '^pcie(-?phy[0-9]*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('num-lanes' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


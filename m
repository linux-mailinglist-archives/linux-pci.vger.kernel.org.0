Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2137B1FFF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjI1OrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjI1OrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 10:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2000A1A4;
        Thu, 28 Sep 2023 07:47:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54797C433C9;
        Thu, 28 Sep 2023 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912435;
        bh=jkl0eNZxunoiBQRh8rBnK1U/95JO9xlXay+2bUDxxm0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=scHqdd0ftYybYJA5yUlRWBDfw+URZu54CG0ax1Mwni64teM/409C/VM5xSw+CZivs
         pgWKnw9nV72i3LegMkkwFV2V1La8v4r4c6O93iIni69IDoBnTYhjmjhq4fViMzJtP/
         TKp10PeRBQWcjwdhedexqRvSa63H5zFbmXHH/76wkGcAmo7tmpA8F3sCzc5fUPnWvO
         frTznp+WODxvnwj2rUT9J/8K23kWdxHKkfWDcsnhYYvYCMNhpWdodd6a+Pcb665Ads
         1jy4w+hEEXVkJ7vosrIP3irSheepa+iOxeJ3ITWVLmrLFhgyfhDa77JFYZ2dIrsVQC
         sctSZQ0R2wGpA==
Received: (nullmailer pid 408736 invoked by uid 1000);
        Thu, 28 Sep 2023 14:47:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jian Yang <jian.yang@mediatek.com>
Cc:     Chuanjia.Liu@mediatek.com, Jieyy.Yang@mediatek.com,
        Jian.Yang@mediatek.com, Qizhong.Cheng@mediatek.com,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Jianjun Wang <jianjun.wang@mediatek.com>
In-Reply-To: <20230928105819.5161-2-jian.yang@mediatek.com>
References: <20230928105819.5161-1-jian.yang@mediatek.com>
 <20230928105819.5161-2-jian.yang@mediatek.com>
Message-Id: <169591240857.408275.15934417880074506796.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support
 for controlling power and reset
Date:   Thu, 28 Sep 2023 09:47:11 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu, 28 Sep 2023 18:58:20 +0800, Jian Yang wrote:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Add new properties to support control power supplies and reset pin of
> a downstream component.
> 
> Signed-off-by: jian.yang <jian.yang@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dts:72.24-75.19: Warning (unit_address_vs_reg): /example-0/bus/pcie@11230000/pcie@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dts:72.24-75.19: Warning (pci_bridge): /example-0/bus/pcie@11230000/pcie@0: missing ranges for PCI bridge (or not a bridge)
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dts:72.24-75.19: Warning (pci_bridge): /example-0/bus/pcie@11230000/pcie@0: incorrect #address-cells for PCI bridge
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dts:72.24-75.19: Warning (pci_bridge): /example-0/bus/pcie@11230000/pcie@0: incorrect #size-cells for PCI bridge
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@11230000: pcie@0: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/mediatek-pcie-gen3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@11230000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'pcie@0' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/mediatek-pcie-gen3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@11230000: pcie@0: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@0: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@0: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@0: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dtb: pcie@0: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230928105819.5161-2-jian.yang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


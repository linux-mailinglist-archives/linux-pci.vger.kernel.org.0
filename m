Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFBC584859
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 00:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiG1Wh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiG1WhZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 18:37:25 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED43190B;
        Thu, 28 Jul 2022 15:37:24 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id h16so1656698ila.2;
        Thu, 28 Jul 2022 15:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=I3vEeMiDJCjGWEDJLfzHyBotayrkz42xF0yEiFQyelw=;
        b=NF2+ZdKEOQxw5SrR9ud3Ww7pViD8Nuv54mMGY6PGC242CTogptuHXgdurTSO9szFwJ
         eDqvAj3Hs/ywYkDCiFhNoMvF52YuOElHFNC9rpl6eufY3jrliH+Eh6mBs2DuEMFNeVQ0
         qvY6637d9zUNfJpix14pKR3kfXACFresdxfZlXwdvLvuBjCW/vW5y3difa8gBUrAKJU3
         nSiEuIrYFPCx4Gij+QWMBgHJXQGAc7Xh0iG0kfEJbkYulcLg+TlllS5h21xcbE0vgGlF
         1LfxA36OhIDgJeh0xyQeWOiEKgisrqv2cUsvIHwwehm12IJqKzGP6Gksl+kvi2VLQh+s
         DbUg==
X-Gm-Message-State: AJIora9xndpXsJVCNCYn0aVIIvZZtU7CEq46gciOo/XEIrVRqqqYM24l
        QtHutPrbdoWm1lxIPPFwoQ==
X-Google-Smtp-Source: AGRyM1tXEvNHVsuWYfcBbpLRfuPajccl51f0Q5BP6aS+ie1v/TyeduYIT450S4eOIgWM5efIgTSX+Q==
X-Received: by 2002:a05:6e02:1bad:b0:2dd:bc59:5078 with SMTP id n13-20020a056e021bad00b002ddbc595078mr294248ili.19.1659047844102;
        Thu, 28 Jul 2022 15:37:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h16-20020a05660208d000b0067b4d6cecc8sm834748ioz.45.2022.07.28.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:37:23 -0700 (PDT)
Received: (nullmailer pid 1710890 invoked by uid 1000);
        Thu, 28 Jul 2022 22:37:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Li <Frank.Li@nxp.com>, Simon Xue <xxm@rock-chips.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220728143427.13617-12-Sergey.Semin@baikalelectronics.ru>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru> <20220728143427.13617-12-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 11/17] dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
Date:   Thu, 28 Jul 2022 16:37:18 -0600
Message-Id: <1659047838.065764.1710889.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Jul 2022 17:34:21 +0300, Serge Semin wrote:
> As the DT-bindings description states the Rockchip PCIe controller is
> based on the DW PCIe RP IP-core thus its DT-nodes are supposed to be
> compatible with the common DW PCIe controller schema. Let's make sure they
> evaluated against it by referring to the snps,dw-pcie-common.yaml schema
> in the allOf sub-schemas composition.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/pci/snps,dw-pcie-common.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dtb: pcie@fe280000: False schema does not allow {'compatible': ['rockchip,rk3568-pcie'], 'reg': [[3, 3229614080, 0, 3735552], [0, 4264034304, 0, 65536], [3, 2147483648, 0, 1048576]], 'reg-names': ['dbi', 'apb', 'config'], 'bus-range': [[32, 47]], 'clocks': [[4294967295, 143], [4294967295, 144], [4294967295, 145], [4294967295, 146], [4294967295, 147]], 'clock-names': ['aclk_mst', 'aclk_slv', 'aclk_dbi', 'pclk', 'aux'], 'device_type': ['pci'], 'linux,pci-domain': [[2]], 'max-link-speed': [[2]], 'msi-map': [[8192, 4294967295, 8192, 4096]], 'num-lanes': [[2]], 'phys': [[4294967295]], 'phy-names': ['pcie-phy'], 'power-domains': [[4294967295, 15]], 'ranges': [[2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [2197815296, 0, 2156920832, 3, 2156920832, 0, 1064304640]], 'resets': [[4294967295, 193]], 'reset-names': ['pipe'], '#address-cells': [[3]], '#size-cells': [[2]], '$nodename': ['pcie
 @fe280000']}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


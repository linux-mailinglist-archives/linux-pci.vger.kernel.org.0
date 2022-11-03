Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D666174E5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 04:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKCDYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 23:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCDYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 23:24:30 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F95E25EF;
        Wed,  2 Nov 2022 20:24:27 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13bef14ea06so851072fac.3;
        Wed, 02 Nov 2022 20:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eTnOXbcMOTrQzDWB8/QZnOj/mMlua+JokHZ5Z76nOl4=;
        b=gdVLNMKaOj4bTrn9XY6m61BvV7R29b+5xicbr158UYjWZBaYYIJ8LkW6JJ38AIHain
         wQnVYub4GAhQdgY0vUc1g6krzMxsz36VJh2rkZtyswo1MHmRRq3a8b5JvOfZPhIXwnSF
         0iAJvXL2qP/xv+ADIAizMrU8wUEm34BeUne4QiPsj/n/aIV3WSXRAtTEM/OeUBaNBCur
         ApmpFRDmnH6IBt2HU6jokDgsaWmekcIevk0i0SPOKqf+kVtCO3nMReBrOX6k+5A6pecL
         2VWI6KxuiGsYa1zBB003jVfKs3SBPYGxTzVA6dEOaGDrrCLbwZ2t89+rmwSEX6wW93mq
         A1SA==
X-Gm-Message-State: ACrzQf2qfFCuvPLZFLVPlZtl2QO6N5TtoK3zCgM8+rgsbroDORgWZFI/
        +pgAh6aCWCfdoTYiBhq8Pw==
X-Google-Smtp-Source: AMsMyM48Ww/swt3apSvSC3vcYKEFCYKpCYY2kSaQs46siC9E4xUpNFQNAeChZWXhMIwhkbkzNV3tFw==
X-Received: by 2002:a05:6870:470e:b0:13c:ed73:f191 with SMTP id b14-20020a056870470e00b0013ced73f191mr12340280oaq.210.1667445866754;
        Wed, 02 Nov 2022 20:24:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a18-20020a056870d19200b001375188dae9sm6876898oac.16.2022.11.02.20.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:24:26 -0700 (PDT)
Received: (nullmailer pid 1062666 invoked by uid 1000);
        Thu, 03 Nov 2022 03:24:28 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
In-Reply-To: <20221102215729.147335-1-marex@denx.de>
References: <20221102215729.147335-1-marex@denx.de>
Message-Id: <166744542553.1047593.11633766224075181622.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: Handle various clock configurations
Date:   Wed, 02 Nov 2022 22:24:28 -0500
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


On Wed, 02 Nov 2022 22:57:27 +0100, Marek Vasut wrote:
> The i.MX SoCs have various clock configurations routed into the PCIe IP,
> the list of clock is below. Document all those configurations in the DT
> binding document.
> 
> All SoCs: pcie, pcie_bus
> 6QDL, 7D: + pcie_phy
> 6SX:      + pcie_phy          pcie_inbound_axi
> 8MQ:      + pcie_phy pcie_aux
> 8MM, 8MP: +          pcie_aux
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: NXP Linux Team <linux-imx@nxp.com>
> To: devicetree@vger.kernel.org
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 74 +++++++++++++++++--
>  1 file changed, 69 insertions(+), 5 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pcie@1ffc000: Unevaluated properties are not allowed ('disable-gpio' was unexpected)
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6q-emcon-avari.dtb

pcie@33800000: clock-names:1: 'pcie_bus' was expected
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: clock-names:2: 'pcie_aux' was expected
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb

pcie@33800000: clock-names:2: 'pcie_bus' is not one of ['pcie_phy', 'pcie_aux']
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb

pcie@33800000: clock-names:3: 'pcie_aux' was expected
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: clock-names:3: 'pcie_bus' is not one of ['pcie_inbound_axi', 'pcie_aux']
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: power-domains: [[102, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

pcie@33800000: power-domains: [[102]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb

pcie@33800000: power-domains: [[103]] is too short
	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-iris.dtb

pcie@33800000: power-domains: [[104]] is too short
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb

pcie@33800000: power-domains: [[106]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb

pcie@33800000: power-domains: [[107]] is too short
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb

pcie@33800000: power-domains: [[108]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: power-domains: [[125]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb

pcie@33800000: power-domains: [[126]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb

pcie@33800000: power-domains: [[49, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb

pcie@33800000: power-domains: [[55]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb

pcie@33800000: power-domains: [[59]] is too short
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb

pcie@33800000: power-domains: [[60, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb

pcie@33800000: power-domains: [[61]] is too short
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb

pcie@33800000: power-domains: [[63]] is too short
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb

pcie@33800000: power-domains: [[64, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb

pcie@33800000: power-domains: [[64]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb

pcie@33800000: power-domains: [[67]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb

pcie@33800000: power-domains: [[68]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb

pcie@33800000: power-domains: [[70, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb

pcie@33800000: power-domains: [[70]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb

pcie@33800000: power-domains: [[72]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb

pcie@33800000: power-domains: [[73]] is too short
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb

pcie@33800000: power-domains: [[75]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb

pcie@33800000: power-domains: [[76, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb

pcie@33800000: power-domains: [[76]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb

pcie@33800000: power-domains: [[77]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb

pcie@33800000: power-domains: [[78]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb

pcie@33800000: power-domains: [[79]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb

pcie@33800000: power-domains: [[80]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb

pcie@33800000: power-domains: [[81]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb

pcie@33800000: power-domains: [[82]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb

pcie@33800000: power-domains: [[83, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb

pcie@33800000: power-domains: [[84]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb

pcie@33800000: power-domains: [[86, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb

pcie@33800000: power-domains: [[86]] is too short
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb

pcie@33800000: power-domains: [[87]] is too short
	arch/arm/boot/dts/imx7d-sdb-reva.dtb

pcie@33800000: power-domains: [[88]] is too short
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb

pcie@33800000: power-domains: [[89]] is too short
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb

pcie@33800000: power-domains: [[92]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33800000: power-domains: [[96]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb

pcie@33800000: power-domains: [[97, 3]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb

pcie@33800000: power-domains: [[97]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb

pcie@33800000: power-domains: [[98]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: reset-names:0: 'pciephy' was expected
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

pcie@33800000: reset-names:1: 'apps' was expected
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

pcie@33800000: reset-names: ['apps', 'turnoff'] is too short
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

pcie@33800000: resets: [[101, 26], [101, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

pcie@33800000: resets: [[25, 28], [25, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb

pcie@33800000: resets: [[26, 28], [26, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb

pcie@33800000: resets: [[27, 28], [27, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb

pcie@33800000: resets: [[28, 28], [28, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb

pcie@33800000: resets: [[29, 28], [29, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb

pcie@33800000: resets: [[31, 28], [31, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb

pcie@33800000: resets: [[34, 28], [34, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb

pcie@33800000: resets: [[40, 28], [40, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: resets: [[48, 26], [48, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb

pcie@33800000: resets: [[59, 26], [59, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb

pcie@33800000: resets: [[63, 26], [63, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb

pcie@33800000: resets: [[69, 26], [69, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb

pcie@33800000: resets: [[75, 26], [75, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb

pcie@33800000: resets: [[82, 26], [82, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb

pcie@33800000: resets: [[85, 26], [85, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb

pcie@33800000: resets: [[96, 26], [96, 27]] is too short
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb

pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'power-domains', 'reset-names', 'resets' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb

pcie@33800000: Unevaluated properties are not allowed ('epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33800000: Unevaluated properties are not allowed ('power-domains', 'reset-names', 'resets' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

pcie@33800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb

pcie@33c00000: 'bus-range' is a required property
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: clock-names:1: 'pcie_bus' was expected
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: clock-names:3: 'pcie_aux' was expected
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: clock-names:3: 'pcie_bus' is not one of ['pcie_inbound_axi', 'pcie_aux']
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: power-domains: [[102]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb

pcie@33c00000: power-domains: [[125]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb

pcie@33c00000: power-domains: [[126]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb

pcie@33c00000: power-domains: [[70]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb

pcie@33c00000: power-domains: [[78]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb

pcie@33c00000: power-domains: [[79]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb

pcie@33c00000: power-domains: [[80]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb

pcie@33c00000: power-domains: [[81]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb

pcie@33c00000: power-domains: [[82]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb

pcie@33c00000: power-domains: [[92]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33c00000: power-domains: [[97]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb

pcie@33c00000: power-domains: [[98]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: Unevaluated properties are not allowed ('epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33c00000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb


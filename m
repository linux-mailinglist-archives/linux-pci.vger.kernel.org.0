Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE666273B6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 01:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKNAGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiKNAGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 19:06:31 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E4FAFC;
        Sun, 13 Nov 2022 16:06:28 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13bd2aea61bso11048553fac.0;
        Sun, 13 Nov 2022 16:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wvQV1Z09sgZ45z9IVxy+Iga6Scz8LqadYJlyaImVnBI=;
        b=NmkXagWCNGjmFOTQJyOC2VSrErbdMY0q90AZEVn2Kg8InHKN3ev+Hz3itY1KEkRdas
         6YCEdAzz1qvCRljI3uJTkjXjwLkw2XNcHp0W0mL0DtfxG0iPofs8h0+jpUy+0Cb0EW5x
         YQZeSafPwF1NKCoXfy4Uq/S9QLbRo2nEt7ONPqEJuci0OKmY6FGmsgQz+5ahgLEzmPze
         Io1YNfBzQ3oJfogKD6QNSxEGZFR+fnGXL9m1CBp5fB1L230eho3tTlKwFbnxMmyVFzP4
         5oHtCHh7F0nPxHLRUABhhS9IbGYSyFx858yCJnS8mPQEf3SlZCdOg5Xc24/arW5d+lKt
         KtcQ==
X-Gm-Message-State: ANoB5pnsMInwrluTgM/7mvv2HwrsLYBu9ccwf2cFthVm+wdgQBRQ3jYH
        Vrb8HycufmpjvFoAGRu6dA==
X-Google-Smtp-Source: AA0mqf7jcVxysSXQyJCEYTTP8wXuF4KMsPdrwWbG2Sf6C3xfHSToUtR0MW+OoalLZVA+LMU6YLcnQQ==
X-Received: by 2002:a05:6870:17a6:b0:136:c9c1:6737 with SMTP id r38-20020a05687017a600b00136c9c16737mr5663842oae.146.1668384387926;
        Sun, 13 Nov 2022 16:06:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l37-20020a05687106a500b00131c3d4d38fsm4268148oao.39.2022.11.13.16.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 16:06:27 -0800 (PST)
Received: (nullmailer pid 766004 invoked by uid 1000);
        Mon, 14 Nov 2022 00:06:28 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, linux-pci@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Li <Frank.Li@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
Message-Id: <166838426542.761880.18100306515069604405.robh@kernel.org>
Subject: Re: [PATCH v7 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Date:   Sun, 13 Nov 2022 18:06:28 -0600
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


On Sun, 13 Nov 2022 22:12:42 +0300, Serge Semin wrote:
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
> 
> Changelog v7:
> - Move the allOf clause to the bottom of the bindings. (@Krzysztof)
> - Get back the names to the clock-names property and make sure the
>   platform-specific name constraint is applied in the allOf clause.
>   (@Rob)
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 46 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)
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
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: clock-names:2: 'pcie_phy' was expected
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

pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: Unevaluated properties are not allowed ('power-domains', 'reset-names', 'resets' were unexpected)
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

pcie@33800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
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
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
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

pcie@33c00000: Unevaluated properties are not allowed ('clock-names', 'epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33c00000: Unevaluated properties are not allowed ('clock-names', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb


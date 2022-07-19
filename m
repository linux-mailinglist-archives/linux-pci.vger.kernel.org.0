Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A457A168
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiGSO0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiGSO0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 10:26:05 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE0638E;
        Tue, 19 Jul 2022 07:11:05 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r70so10719692iod.10;
        Tue, 19 Jul 2022 07:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=pKy/R5KX6sCJNbKzy3wq4JWIbR/nHdBCv+veD6KOwdM=;
        b=unW0Jbkk1Rl0lNzcA9JSS4hpBpsUIdytVUROg0M6OwiPtfax6dygFACr8ZiOm4uo+U
         L7Jfak65rr+HiTyrYZZYtLYzovmwv2U2Ie2RezKnuYr69QAEC7RNkHcnt31MxJwfvr/P
         D/tklSkUZZouxyzs92/pqK74H0gMXEk+BzZLCqCjFYUkbrsu6t2wLLvytBzLMLTGW65I
         6LI7gzG7bU4y7xlv7dQq8AjAtm1lGQPPa+qH7PdZSqes40ju/PJYe47UEZiA4IvxkWz4
         dTh3amoS5jNnEqIoWjSbCkWAHMu7FXt/4xqyNdM8skIXwCOxNR8hhfo0PGBWrEbNZYb2
         XbSw==
X-Gm-Message-State: AJIora/UhQlkIWhAIXVimxNNYlvg1XOWwaAfj37JvctJrRx02Fvl05pM
        RmZ/CF3wT9MLUvgm0G7IqA==
X-Google-Smtp-Source: AGRyM1v2k5zcleTp/PdHRF2FCPOoujIZ/b0Y3udaUA47m0tQb/SlWPxYzTi0Olr3WDj4v/gNgR8Cxg==
X-Received: by 2002:a05:6602:27c6:b0:657:7e7a:11f3 with SMTP id l6-20020a05660227c600b006577e7a11f3mr15477902ios.40.1658239864590;
        Tue, 19 Jul 2022 07:11:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e44-20020a02212c000000b0033f25da5228sm6771991jaa.93.2022.07.19.07.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:11:04 -0700 (PDT)
Received: (nullmailer pid 1153348 invoked by uid 1000);
        Tue, 19 Jul 2022 14:11:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, lorenzo.pieralisi@arm.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kw@linux.com, robh+dt@kernel.org,
        bhelgaas@google.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        frank.li@nxp.com, linux-pci@vger.kernel.org
In-Reply-To: <1658223939-25478-2-git-send-email-hongxing.zhu@nxp.com>
References: <1658223939-25478-1-git-send-email-hongxing.zhu@nxp.com> <1658223939-25478-2-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: imx6q-pcie: Add iMX8MM PCIe EP mode compatible string
Date:   Tue, 19 Jul 2022 08:11:00 -0600
Message-Id: <1658239860.449467.1153347.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Jul 2022 17:45:30 +0800, Richard Zhu wrote:
> Add i.MX8MM PCIe endpoint mode compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
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
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
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
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: clock-names:3: 'pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie' was expected
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: power-domains: [[100]] is too short
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb

pcie@33800000: power-domains: [[102]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb

pcie@33800000: power-domains: [[103]] is too short
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb

pcie@33800000: power-domains: [[106]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb

pcie@33800000: power-domains: [[108]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: power-domains: [[124]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb

pcie@33800000: power-domains: [[125]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb

pcie@33800000: power-domains: [[55]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb

pcie@33800000: power-domains: [[59]] is too short
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb

pcie@33800000: power-domains: [[61]] is too short
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb

pcie@33800000: power-domains: [[63]] is too short
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb

pcie@33800000: power-domains: [[64]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb

pcie@33800000: power-domains: [[66]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb

pcie@33800000: power-domains: [[68]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb

pcie@33800000: power-domains: [[69]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb

pcie@33800000: power-domains: [[70]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb

pcie@33800000: power-domains: [[72]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb

pcie@33800000: power-domains: [[73]] is too short
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb

pcie@33800000: power-domains: [[76]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb

pcie@33800000: power-domains: [[78]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb

pcie@33800000: power-domains: [[79]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb

pcie@33800000: power-domains: [[80]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb

pcie@33800000: power-domains: [[81]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb

pcie@33800000: power-domains: [[82]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb

pcie@33800000: power-domains: [[84]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb

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
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: reset-names:1: 'apps' was expected
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: reset-names: ['apps', 'turnoff'] is too short
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: resets: [[25, 28], [25, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb

pcie@33800000: resets: [[26, 28], [26, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb

pcie@33800000: resets: [[27, 28], [27, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb

pcie@33800000: resets: [[28, 28], [28, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb

pcie@33800000: resets: [[29, 28], [29, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb

pcie@33800000: resets: [[31, 28], [31, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb

pcie@33800000: resets: [[33, 28], [33, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb

pcie@33800000: resets: [[39, 28], [39, 29]] is too short
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'power-domains', 'reset-names', 'resets' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'power-domains' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33800000: Unevaluated properties are not allowed ('power-domains', 'reset-names', 'resets' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb

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
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
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

pcie@33c00000: clock-names:3: 'pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie' was expected
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

pcie@33c00000: power-domains: [[102]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb

pcie@33c00000: power-domains: [[124]] is too short
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb

pcie@33c00000: power-domains: [[125]] is too short
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
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb

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

pcie@8ffc000: clock-names:3: 'pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie' was expected
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb

pcie@8ffc000: Unevaluated properties are not allowed ('clock-names' was unexpected)
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb


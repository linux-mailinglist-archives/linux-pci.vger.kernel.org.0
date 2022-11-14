Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E395627D1D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiKNL4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiKNL4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:56:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98F27CE7;
        Mon, 14 Nov 2022 03:51:45 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l8so12797641ljh.13;
        Mon, 14 Nov 2022 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+wUcR8SQAo9yGWMgGDtHI0XK+Z7U+Q3WqvYsXJZ8DY=;
        b=PG/ET9KKxy+Pm96eUrEIwREZymRq9rXxtNwqCqcimoUfytE4sV3Li8IeYltOotxXnR
         TJLgInxt8RoE+WxqacXyf2C6Jouo7g9yUhAxIYj9bH1NuAdfRwb3QuAwmEAb2uIsBqSd
         hFr1X+Q5w3OGkcv6k5GEWIne85SCi64ENLYaQvOtngwIoYXGwg2OuMmph0rAbFmg3WGP
         1aOw+MY2ey3AZHYsRd7u3cdctylAk9U9SAD4rdTdiPUL9PbOKkg7eKdijpQqh3D786yO
         9SJW1c1JuV9uUZWUIywHnHLnvZEp3oWMfOE/HNYcJY3cHJrYgvlyR3KsQp2YI/SUmNZ/
         BocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+wUcR8SQAo9yGWMgGDtHI0XK+Z7U+Q3WqvYsXJZ8DY=;
        b=qCAUKBbH3qriLOXYW19h2kDc2canDlLNhJvjFge+VO62TNBOkZVYl3WMy4tXfM/OP0
         BPoqN9CTzdGuK7dD4bHunkZIoIgCGd8c0veEzOXsS3GjDjS9ERpZvQGF551khA2udpU6
         dSLJyIk57sioT4fainU/vlUT+YhPvhMzTaRUf850augkiYWGI9OftpxuBfeS9KWK3aMT
         CDhlEm19UuInrsFCAkE4Be4VyKe2SdtJBL6bQvOZh/GvZSmUQliMaHi/18fnV2FRlDcz
         2IUmZWT3+uefyciYXdNsODaEl6cRoFeH3yll8p1QxsETL3qqA2NZGuTNbFsM7n0LWqQw
         m6Tw==
X-Gm-Message-State: ANoB5pmSAFv0PfD08VdwjQlxi9GdnJMFRZ9ltS0tXsUA4SYIKS4OSnno
        Ak5GBFqJcxpfIL/CzVFZC9Q=
X-Google-Smtp-Source: AA0mqf4O3+X0bFCRqPb8m8NWJjRpnTjod97EQj2rkCeos7jw90/hD2+Tr76CzzNvwbdlpQyaiLmUiw==
X-Received: by 2002:a05:651c:2203:b0:277:63f7:492c with SMTP id y3-20020a05651c220300b0027763f7492cmr3987389ljq.259.1668426703388;
        Mon, 14 Nov 2022 03:51:43 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004948b667d95sm1795612lfg.265.2022.11.14.03.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:51:42 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:51:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, linux-pci@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
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
Subject: Re: [PATCH v7 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Message-ID: <20221114115140.ixd54hcjdxc5ei2a@mobilestation>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
 <166838426542.761880.18100306515069604405.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166838426542.761880.18100306515069604405.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 06:06:28PM -0600, Rob Herring wrote:
> 
> On Sun, 13 Nov 2022 22:12:42 +0300, Serge Semin wrote:
> > Originally as it was defined the legacy bindings the pcie_inbound_axi and
> > pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> > fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> > incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> > for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> > Let's fix that by conditionally apply the clock-names constraints based on
> > the compatible string content.
> > 
> > Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > 
> > ---
> > 
> > Changelog v5:
> > - This is a new patch added on the v5 release of the patchset.
> > 
> > Changelog v7:
> > - Move the allOf clause to the bottom of the bindings. (@Krzysztof)
> > - Get back the names to the clock-names property and make sure the
> >   platform-specific name constraint is applied in the allOf clause.
> >   (@Rob)
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 46 +++++++++++++++++--
> >  1 file changed, 42 insertions(+), 4 deletions(-)
> > 
> 

> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.

Yeah, these are the old warnings. No semantic change causing them
provided in this patch. 

-Sergey

> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> pcie@1ffc000: Unevaluated properties are not allowed ('disable-gpio' was unexpected)
> 	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
> 	arch/arm/boot/dts/imx6q-emcon-avari.dtb
> 
> pcie@33800000: clock-names:1: 'pcie_bus' was expected
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33800000: clock-names:2: 'pcie_phy' was expected
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 
> pcie@33800000: clock-names:3: 'pcie_aux' was expected
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33800000: clock-names:3: 'pcie_bus' is not one of ['pcie_inbound_axi', 'pcie_aux']
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33800000: power-domains: [[102, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> pcie@33800000: power-domains: [[102]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 
> pcie@33800000: power-domains: [[103]] is too short
> 	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
> 	arch/arm/boot/dts/imx7d-colibri-iris.dtb
> 
> pcie@33800000: power-domains: [[104]] is too short
> 	arch/arm/boot/dts/imx7d-colibri-aster.dtb
> 	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
> 	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
> 	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
> 
> pcie@33800000: power-domains: [[106]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 
> pcie@33800000: power-domains: [[107]] is too short
> 	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
> 	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
> 
> pcie@33800000: power-domains: [[108]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 
> pcie@33800000: power-domains: [[125]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 
> pcie@33800000: power-domains: [[126]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 
> pcie@33800000: power-domains: [[49, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 
> pcie@33800000: power-domains: [[55]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 
> pcie@33800000: power-domains: [[59]] is too short
> 	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
> 
> pcie@33800000: power-domains: [[60, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 
> pcie@33800000: power-domains: [[61]] is too short
> 	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
> 
> pcie@33800000: power-domains: [[63]] is too short
> 	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
> 
> pcie@33800000: power-domains: [[64, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 
> pcie@33800000: power-domains: [[64]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm/boot/dts/imx7d-remarkable2.dtb
> 
> pcie@33800000: power-domains: [[67]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 
> pcie@33800000: power-domains: [[68]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm/boot/dts/imx7d-meerkat96.dtb
> 
> pcie@33800000: power-domains: [[70, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 
> pcie@33800000: power-domains: [[70]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 
> pcie@33800000: power-domains: [[72]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 
> pcie@33800000: power-domains: [[73]] is too short
> 	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
> 	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
> 	arch/arm/boot/dts/imx7d-smegw01.dtb
> 
> pcie@33800000: power-domains: [[75]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> 
> pcie@33800000: power-domains: [[76, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 
> pcie@33800000: power-domains: [[76]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 
> pcie@33800000: power-domains: [[77]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 
> pcie@33800000: power-domains: [[78]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 
> pcie@33800000: power-domains: [[79]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 
> pcie@33800000: power-domains: [[80]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 
> pcie@33800000: power-domains: [[81]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 
> pcie@33800000: power-domains: [[82]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 
> pcie@33800000: power-domains: [[83, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 
> pcie@33800000: power-domains: [[84]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 
> pcie@33800000: power-domains: [[86, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 
> pcie@33800000: power-domains: [[86]] is too short
> 	arch/arm/boot/dts/imx7d-nitrogen7.dtb
> 	arch/arm/boot/dts/imx7d-pico-nymph.dtb
> 
> pcie@33800000: power-domains: [[87]] is too short
> 	arch/arm/boot/dts/imx7d-sdb-reva.dtb
> 
> pcie@33800000: power-domains: [[88]] is too short
> 	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
> 	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
> 	arch/arm/boot/dts/imx7d-sdb.dtb
> 	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
> 
> pcie@33800000: power-domains: [[89]] is too short
> 	arch/arm/boot/dts/imx7d-pico-pi.dtb
> 	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
> 
> pcie@33800000: power-domains: [[92]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 
> pcie@33800000: power-domains: [[96]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm/boot/dts/imx7d-mba7.dtb
> 
> pcie@33800000: power-domains: [[97, 3]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 
> pcie@33800000: power-domains: [[97]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 
> pcie@33800000: power-domains: [[98]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33800000: reset-names:0: 'pciephy' was expected
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> pcie@33800000: reset-names:1: 'apps' was expected
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> pcie@33800000: reset-names: ['apps', 'turnoff'] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> pcie@33800000: resets: [[101, 26], [101, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> pcie@33800000: resets: [[25, 28], [25, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 
> pcie@33800000: resets: [[26, 28], [26, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 
> pcie@33800000: resets: [[27, 28], [27, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 
> pcie@33800000: resets: [[28, 28], [28, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 
> pcie@33800000: resets: [[29, 28], [29, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 
> pcie@33800000: resets: [[31, 28], [31, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 
> pcie@33800000: resets: [[34, 28], [34, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 
> pcie@33800000: resets: [[40, 28], [40, 29]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 
> pcie@33800000: resets: [[48, 26], [48, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 
> pcie@33800000: resets: [[59, 26], [59, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 
> pcie@33800000: resets: [[63, 26], [63, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 
> pcie@33800000: resets: [[69, 26], [69, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 
> pcie@33800000: resets: [[75, 26], [75, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 
> pcie@33800000: resets: [[82, 26], [82, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 
> pcie@33800000: resets: [[85, 26], [85, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 
> pcie@33800000: resets: [[96, 26], [96, 27]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 
> pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 
> pcie@33800000: Unevaluated properties are not allowed ('clock-names', 'power-domains' were unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33800000: Unevaluated properties are not allowed ('power-domains', 'reset-names', 'resets' were unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> pcie@33800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
> 	arch/arm/boot/dts/imx7d-colibri-aster.dtb
> 	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
> 	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
> 	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
> 	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
> 	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
> 	arch/arm/boot/dts/imx7d-colibri-iris.dtb
> 	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
> 	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
> 	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
> 	arch/arm/boot/dts/imx7d-mba7.dtb
> 	arch/arm/boot/dts/imx7d-meerkat96.dtb
> 	arch/arm/boot/dts/imx7d-nitrogen7.dtb
> 	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
> 	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
> 	arch/arm/boot/dts/imx7d-pico-nymph.dtb
> 	arch/arm/boot/dts/imx7d-pico-pi.dtb
> 	arch/arm/boot/dts/imx7d-remarkable2.dtb
> 	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
> 	arch/arm/boot/dts/imx7d-sdb.dtb
> 	arch/arm/boot/dts/imx7d-sdb-reva.dtb
> 	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
> 	arch/arm/boot/dts/imx7d-smegw01.dtb
> 	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
> 	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
> 
> pcie@33c00000: 'bus-range' is a required property
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33c00000: clock-names:1: 'pcie_bus' was expected
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33c00000: clock-names:3: 'pcie_aux' was expected
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33c00000: clock-names:3: 'pcie_bus' is not one of ['pcie_inbound_axi', 'pcie_aux']
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33c00000: power-domains: [[102]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 
> pcie@33c00000: power-domains: [[125]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 
> pcie@33c00000: power-domains: [[126]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 
> pcie@33c00000: power-domains: [[70]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 
> pcie@33c00000: power-domains: [[78]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 
> pcie@33c00000: power-domains: [[79]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 
> pcie@33c00000: power-domains: [[80]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 
> pcie@33c00000: power-domains: [[81]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 
> pcie@33c00000: power-domains: [[82]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 
> pcie@33c00000: power-domains: [[92]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 
> pcie@33c00000: power-domains: [[97]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 
> pcie@33c00000: power-domains: [[98]] is too short
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33c00000: Unevaluated properties are not allowed ('clock-names', 'epdev_on-supply', 'hard-wired', 'power-domains' were unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 
> pcie@33c00000: Unevaluated properties are not allowed ('clock-names', 'power-domains' were unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> pcie@33c00000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 

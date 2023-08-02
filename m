Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D276C5BC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 08:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjHBGwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHBGwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 02:52:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE293582
        for <linux-pci@vger.kernel.org>; Tue,  1 Aug 2023 23:51:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qR5hq-0008Kt-SF; Wed, 02 Aug 2023 08:51:38 +0200
Message-ID: <7f98d5f3-eb5b-d98b-a5ab-a7f54319c99a@pengutronix.de>
Date:   Wed, 2 Aug 2023 08:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/9] Add legacy i.MX PCIe EP mode supports
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        shawnguo@kernel.org, lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

On 02.08.23 08:06, Richard Zhu wrote:
> Add legacy 32bit i.MX PCIe EP mode support
> 
> The PCI controller contained in i.MX6/7 legacy SOCs is one dual mode
> PCIe controller, and can work either as RC or EP.
> 
> This series add i.MX6/7 PCIe EP mode supports. And had been verified
> on i.MX6 sabresd and i.MX7 SDB boards.
> 
> In the verification, one board PCIe is used as RC, the other one is used
> as EP.
> Use the cross TX/RX differential cable connect the two PCIe ports of
> these two boards.
> 
> +-----------+                +------------+
> |   PCIe TX |<-------------->|PCIe RX     |
> |           |                |            |
> |    Board  |                |    Board   |
> |           |                |            |
> |   PCIe RX |<-------------->|PCIe TX     |
> +-----------+                +------------+

I am curious what software you are running on both sides to test?
Do you use CONFIG_PCI_EPF_TEST? What do you run on RC side?

Thanks,
Ahmad

> 
> [PATCH 1/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6Q and i.MX6QP PCIe
> [PATCH 2/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6SX PCIe EP
> [PATCH 3/9] dt-bindings: PCI: fsl,imx6q: Add i.MX7D PCIe EP
> [PATCH 4/9] arm: dts: nxp: Add i.MX6QDL and i.MX6QP PCIe EP supports
> [PATCH 5/9] arm: dts: nxp: Add i.MX6SX PCIe EP support
> [PATCH 6/9] arm: dts: nxp: Add i.MX7D PCIe EP support
> [PATCH 7/9] PCI: imx6: Add i.MX6Q and i.MX6QP PCIe EP supports
> [PATCH 8/9] PCI: imx6: Add i.MX6SX PCIe EP support
> [PATCH 9/9] PCI: imx6: Add i.MX7D PCIe EP support
> 
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 50 +++++++++++++++++++++++++++++++++++++++++----
> arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                       | 14 +++++++++++++
> arch/arm/boot/dts/nxp/imx/imx6qp.dtsi                        |  4 ++++
> arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                        | 17 +++++++++++++++
> arch/arm/boot/dts/nxp/imx/imx7d.dtsi                         | 27 ++++++++++++++++++++++++
> drivers/pci/controller/dwc/pci-imx6.c                        | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 6 files changed, 200 insertions(+), 5 deletions(-)
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


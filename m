Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A943DA6A8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhG2OkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhG2OkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 10:40:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E5C061765
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 07:39:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m97CR-0000QI-G5; Thu, 29 Jul 2021 16:39:51 +0200
Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
To:     Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
Date:   Thu, 29 Jul 2021 16:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723204958.7186-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Tim,

On 23.07.21 22:49, Tim Harvey wrote:
> The IMX8M Mini PCI controller shares much in common with the existing
> SoC's supported by the pci-imx6 driver.
> 
> This series adds support for it. Driver changes came from the NXP
> downstream vendor kernel [1]
> 
> This series depends on Lucas Stach's i.MX8MM GPC improvements and
> BLK_CTRL driver and is based on top of his v2 submission [2]

Are you aware of Lucas' patch series and Rob's remarks there?
https://lore.kernel.org/linux-pci/20210510141509.929120-7-l.stach@pengutronix.de/

Cheers,
Ahmad

> 
> The final patch adds PCIe support to the
> Tim
> [1] https://source.codeaurora.org/external/imx/linux-imx/
> [2]
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=519251
> 
> Tim Harvey (6):
>   dt-bindings: imx6q-pcie: add compatible for IMX8MM support
>   dt-bindings: reset: imx8mq: add pcie reset
>   PCI: imx6: add IMX8MM support
>   reset: imx7: add resets for PCIe
>   arm64: dts: imx8mm: add PCIe support
>   arm64: dts: imx8mm: add gpc iomux compatible
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   4 +-
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  38 ++++++-
>  drivers/pci/controller/dwc/pci-imx6.c         | 103 +++++++++++++++++-
>  drivers/reset/reset-imx7.c                    |   3 +
>  include/dt-bindings/reset/imx8mq-reset.h      |   3 +-
>  5 files changed, 147 insertions(+), 4 deletions(-)
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

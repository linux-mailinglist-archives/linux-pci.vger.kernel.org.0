Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737763D41ED
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGWU0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 16:26:21 -0400
Received: from finn.gateworks.com ([108.161.129.64]:57816 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229461AbhGWU0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 16:26:20 -0400
X-Greylist: delayed 1005 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 16:26:20 EDT
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1m727M-0057Vc-FI; Fri, 23 Jul 2021 20:50:00 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
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
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 0/6] Add IMX8M Mini PCI support
Date:   Fri, 23 Jul 2021 13:49:52 -0700
Message-Id: <20210723204958.7186-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IMX8M Mini PCI controller shares much in common with the existing
SoC's supported by the pci-imx6 driver.

This series adds support for it. Driver changes came from the NXP
downstream vendor kernel [1]

This series depends on Lucas Stach's i.MX8MM GPC improvements and
BLK_CTRL driver and is based on top of his v2 submission [2]

The final patch adds PCIe support to the
Tim
[1] https://source.codeaurora.org/external/imx/linux-imx/
[2]
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=519251

Tim Harvey (6):
  dt-bindings: imx6q-pcie: add compatible for IMX8MM support
  dt-bindings: reset: imx8mq: add pcie reset
  PCI: imx6: add IMX8MM support
  reset: imx7: add resets for PCIe
  arm64: dts: imx8mm: add PCIe support
  arm64: dts: imx8mm: add gpc iomux compatible

 .../bindings/pci/fsl,imx6q-pcie.txt           |   4 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  38 ++++++-
 drivers/pci/controller/dwc/pci-imx6.c         | 103 +++++++++++++++++-
 drivers/reset/reset-imx7.c                    |   3 +
 include/dt-bindings/reset/imx8mq-reset.h      |   3 +-
 5 files changed, 147 insertions(+), 4 deletions(-)

-- 
2.17.1


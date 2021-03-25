Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0864348BFD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 09:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYI66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 04:58:58 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56868 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCYI6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 04:58:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D50CD1A313F;
        Thu, 25 Mar 2021 09:58:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AD801A133E;
        Thu, 25 Mar 2021 09:58:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 18783402AE;
        Thu, 25 Mar 2021 09:58:18 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v3 0/3] add one regulator used to power up pcie phy
Date:   Thu, 25 Mar 2021 16:44:39 +0800
Message-Id: <1616661882-26487-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes:
v2 -> v3:
Refine the DT binding descriptions, and the condition adjustment in the codes.

v1 -> v2:
Don't use the boolean property to specify the different power supply of PCIe PHY.
Use one regulator as a supply to the PCIe controller node, and the regulator APIs
to get the voltage of it.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  3 +++
arch/arm64/boot/dts/freescale/imx8mq-evk.dts             |  1 +
drivers/pci/controller/dwc/pci-imx6.c                    | 20 ++++++++++++++++++++
3 files changed, 24 insertions(+)

[PATCH v3 1/3] dt-bindings: imx6q-pcie: add one regulator used to
[PATCH v3 2/3] arm64: dts: imx8mq-evk: add one regulator used to
[PATCH v3 3/3] PCI: imx: clear vreg bypass when pcie vph voltage is

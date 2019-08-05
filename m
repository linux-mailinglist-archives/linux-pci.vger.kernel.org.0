Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A11810AF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 06:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHEEOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 00:14:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51770 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfHEEOv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 00:14:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBC3F1A0084;
        Mon,  5 Aug 2019 06:14:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B71521A00A9;
        Mon,  5 Aug 2019 06:14:38 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 923CE402DD;
        Mon,  5 Aug 2019 12:14:25 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, zhiqiang.hou@nxp.com, roy.zang@nxp.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCHv2 3/3] PCI: layerscape: Add LS1028a support
Date:   Mon,  5 Aug 2019 12:04:53 +0800
Message-Id: <20190805040453.48009-3-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190805040453.48009-1-xiaowei.bao@nxp.com>
References: <20190805040453.48009-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the LS1028a PCIe controller.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - no change.

 drivers/pci/controller/dwc/pci-layerscape.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 3a5fa26..8c556e1 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -236,6 +236,14 @@ static const struct ls_pcie_drvdata ls1043_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
+static const struct ls_pcie_drvdata ls1028a_drvdata = {
+	.lut_offset = 0x80000,
+	.ltssm_shift = 0,
+	.lut_dbg = 0x407fc,
+	.ops = &ls_pcie_host_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ops,
+};
+
 static const struct ls_pcie_drvdata ls1046_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 24,
@@ -263,6 +271,7 @@ static const struct ls_pcie_drvdata ls2088_drvdata = {
 static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
 	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &ls1028a_drvdata },
 	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
 	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
-- 
2.9.5


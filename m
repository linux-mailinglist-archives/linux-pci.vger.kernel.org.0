Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC88ACEB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 05:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHMDDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 23:03:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37084 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfHMDDO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 23:03:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D4D21A00B4;
        Tue, 13 Aug 2019 05:03:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA6B91A0048;
        Tue, 13 Aug 2019 05:03:04 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 65CF9402A2;
        Tue, 13 Aug 2019 11:02:54 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        l.stach@pengutronix.de, kishon@ti.com, tpiepho@impinj.com,
        leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        yue.wang@amlogic.com, hayashi.kunihiko@socionext.com,
        dwmw@amazon.co.uk, jonnyc@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCHv4 1/2] PCI: layerscape: Add the bar_fixed_64bit property in EP driver.
Date:   Tue, 13 Aug 2019 10:53:16 +0800
Message-Id: <20190813025317.48290-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1
is 32bit, BAR3 and BAR4 is 64bit, this is determined by hardware,
so set the bar_fixed_64bit with 0x14.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - Replace value 0x14 with a macro.
v3:
 - No change.
v4:
 - send the patch again with '--to'.

 drivers/pci/controller/dwc/pci-layerscape-ep.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index be61d96..227c33b 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -44,6 +44,7 @@ static int ls_pcie_establish_link(struct dw_pcie *pci)
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
 };
 
 static const struct pci_epc_features*
-- 
1.7.1


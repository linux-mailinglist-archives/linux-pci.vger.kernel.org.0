Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83D8AFFF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 08:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfHMGio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 02:38:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52700 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfHMGio (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 02:38:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B561D20074D;
        Tue, 13 Aug 2019 08:38:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CDF220075A;
        Tue, 13 Aug 2019 08:38:33 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 16C55402EC;
        Tue, 13 Aug 2019 14:38:23 +0800 (SGT)
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
Subject: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit property in EP driver.
Date:   Tue, 13 Aug 2019 14:28:39 +0800
Message-Id: <20190813062840.2733-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1
is 32bit, BAR2 and BAR4 is 64bit, this is determined by hardware,
so set the bar_fixed_64bit with 0x14.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - Replace value 0x14 with a macro.
v3:
 - No change.
v4:
 - send the patch again with '--to'.
v5:
 - fix the commit message.

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index be61d96..ca9aa45 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -44,6 +44,7 @@ static const struct pci_epc_features ls_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
 };
 
 static const struct pci_epc_features*
-- 
2.9.5


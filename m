Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E82DDB3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfD2I1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 04:27:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45658 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfD2I1u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 04:27:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AE76200241;
        Mon, 29 Apr 2019 10:27:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 99459200166;
        Mon, 29 Apr 2019 10:27:39 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9991D402F0;
        Mon, 29 Apr 2019 16:27:28 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, shawn.lin@rock-chips.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 1/2] PCI: layerscape: Add the bar_fixed_64bit property in EP driver.
Date:   Mon, 29 Apr 2019 16:19:56 +0800
Message-Id: <20190429081957.47945-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
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
 drivers/pci/controller/dwc/pci-layerscape-ep.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index be61d96..e2fbdff 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -44,6 +44,7 @@ static int ls_pcie_establish_link(struct dw_pcie *pci)
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.bar_fixed_64bit = 0x14,
 };
 
 static const struct pci_epc_features*
-- 
1.7.1


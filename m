Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5474241944
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHKKCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 06:02:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42446 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgHKKCW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Aug 2020 06:02:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64A00201F46;
        Tue, 11 Aug 2020 12:02:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83AA4201EEF;
        Tue, 11 Aug 2020 12:02:13 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B45DD40243;
        Tue, 11 Aug 2020 12:02:04 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com
Cc:     mingkai.hu@nxp.com, minghuan.Lian@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv7 12/12] misc: pci_endpoint_test: Add driver data for Layerscape PCIe controllers
Date:   Tue, 11 Aug 2020 17:54:41 +0800
Message-Id: <20200811095441.7636-13-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The commit 0a121f9bc3f5 ("misc: pci_endpoint_test: Use streaming DMA
APIs for buffer allocation") changed to use streaming DMA APIs, however,
dma_map_single() might not return a 4KB aligned address, so add the
default_data as driver data for Layerscape PCIe controllers to make it
4KB aligned.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V7:
 - New patch.

 drivers/misc/pci_endpoint_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 4a17f08de60f..70a790cd14c5 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -946,8 +946,12 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
-- 
2.17.1


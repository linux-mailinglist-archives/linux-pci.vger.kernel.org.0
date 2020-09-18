Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5453B26F7F5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIRISx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 04:18:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56934 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgIRISx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 04:18:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2574E1A02E0;
        Fri, 18 Sep 2020 10:09:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0BDD1A0031;
        Fri, 18 Sep 2020 10:08:56 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DD5FE402C3;
        Fri, 18 Sep 2020 10:08:47 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        shawnguo@kernel.org, kishon@ti.com, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andrew.murray@arm.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv8 11/12] misc: pci_endpoint_test: Add LS1088a in pci_device_id table
Date:   Fri, 18 Sep 2020 16:00:23 +0800
Message-Id: <20200918080024.13639-12-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
References: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add LS1088a in pci_device_id table so that pci-epf-test can be used
for testing PCIe EP in LS1088a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V8:
 - No change.

 drivers/misc/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e060796f9caa..4a17f08de60f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -70,6 +70,7 @@
 
 #define PCI_DEVICE_ID_TI_J721E			0xb00d
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
+#define PCI_DEVICE_ID_LS1088A			0x80c0
 
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
@@ -946,6 +947,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A) },
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
-- 
2.17.1


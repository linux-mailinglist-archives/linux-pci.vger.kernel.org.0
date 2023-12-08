Return-Path: <linux-pci+bounces-645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF6A8099F5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 03:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831AE2822A1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19954210F;
	Fri,  8 Dec 2023 02:57:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17230D7;
	Thu,  7 Dec 2023 18:57:06 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vy1bwvd_1702004222;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vy1bwvd_1702004222)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 10:57:04 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: ilkka@os.amperecomputing.com,
	kaishen@linux.alibaba.com,
	helgaas@kernel.org,
	yangyicong@huawei.com,
	will@kernel.org,
	Jonathan.Cameron@huawei.com,
	baolin.wang@linux.alibaba.com,
	robin.murphy@arm.com
Cc: chengyou@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	rdunlap@infradead.org,
	mark.rutland@arm.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com
Subject: [PATCH v12 2/5] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Date: Fri,  8 Dec 2023 10:56:49 +0800
Message-Id: <20231208025652.87192-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
Vendor ID to linux/pci_ids.h so that it can shared by several drivers
later.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h | 2 --
 include/linux/pci_ids.h                | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 9d316fdc6f9a..a155519a862f 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -11,8 +11,6 @@
 #include <linux/types.h>
 
 /* PCIe device related definition. */
-#define PCI_VENDOR_ID_ALIBABA 0x1ded
-
 #define ERDMA_PCI_WIDTH 64
 #define ERDMA_FUNC_BAR 0
 #define ERDMA_MISX_BAR 2
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..d8760daf9e5a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2601,6 +2601,8 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_ALIBABA		0x1ded
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.39.3



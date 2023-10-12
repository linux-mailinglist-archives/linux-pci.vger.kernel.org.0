Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912767C634A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 05:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjJLD3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376862AbjJLD3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 23:29:15 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2122A9;
        Wed, 11 Oct 2023 20:29:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vtyvp3x_1697081347;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vtyvp3x_1697081347)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 11:29:09 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: [PATCH v7 2/4] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Date:   Thu, 12 Oct 2023 11:28:54 +0800
Message-Id: <20231012032856.2640-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012032856.2640-1-xueshuai@linux.alibaba.com>
References: <20231012032856.2640-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
Vendor ID to linux/pci_ids.h so that it can shared by several drivers
later.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
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


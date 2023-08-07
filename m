Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99F7718AF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 05:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHGDGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Aug 2023 23:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGDGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Aug 2023 23:06:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F3BA
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 20:06:35 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK1Ny1nMdz1Z1V3;
        Mon,  7 Aug 2023 11:03:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 11:06:33 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <fbarrat@linux.ibm.com>,
        <ajd@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <ben.widawsky@intel.com>,
        <wangxiongfeng2@huawei.com>
CC:     <jonathan.cameron@huawei.com>, <linux-pci@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <yangyingliang@huawei.com>
Subject: [PATCH 2/2] ocxl: use pci_find_next_dvsec_capability() to simplify the code
Date:   Mon, 7 Aug 2023 11:18:46 +0800
Message-ID: <20230807031846.77348-3-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230807031846.77348-1-wangxiongfeng2@huawei.com>
References: <20230807031846.77348-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core add pci_find_next_dvsec_capability() to query the next DVSEC.
We can use that core API to simplify the code. Also remove the unused
macros.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/powerpc/platforms/powernv/ocxl.c | 20 ++------------------
 drivers/misc/ocxl/config.c            | 21 ++++++---------------
 include/misc/ocxl-config.h            |  4 ----
 3 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 629067781cec..8dbc1a9535fc 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -71,29 +71,13 @@ static DEFINE_MUTEX(links_list_lock);
  * the AFUs, by pro-rating if needed.
  */
 
-static int find_dvsec_from_pos(struct pci_dev *dev, int dvsec_id, int pos)
-{
-	int vsec = pos;
-	u16 vendor, id;
-
-	while ((vsec = pci_find_next_ext_capability(dev, vsec,
-						    OCXL_EXT_CAP_ID_DVSEC))) {
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
-				&vendor);
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
-		if (vendor == PCI_VENDOR_ID_IBM && id == dvsec_id)
-			return vsec;
-	}
-	return 0;
-}
-
 static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
 {
 	int vsec = 0;
 	u8 idx;
 
-	while ((vsec = find_dvsec_from_pos(dev, OCXL_DVSEC_AFU_CTRL_ID,
-					   vsec))) {
+	while ((vsec = pci_find_next_dvsec_capability(dev, vsec,
+				PCI_VENDOR_ID_IBM, OCXL_DVSEC_AFU_CTRL_ID))) {
 		pci_read_config_byte(dev, vsec + OCXL_DVSEC_AFU_CTRL_AFU_IDX,
 				&idx);
 		if (idx == afu_idx)
diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 92ab49705f64..6c0fca32e6db 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -39,23 +39,14 @@ static int find_dvsec(struct pci_dev *dev, int dvsec_id)
 static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
 {
 	int vsec = 0;
-	u16 vendor, id;
 	u8 idx;
 
-	while ((vsec = pci_find_next_ext_capability(dev, vsec,
-						    OCXL_EXT_CAP_ID_DVSEC))) {
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
-				&vendor);
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
-
-		if (vendor == PCI_VENDOR_ID_IBM &&
-			id == OCXL_DVSEC_AFU_CTRL_ID) {
-			pci_read_config_byte(dev,
-					vsec + OCXL_DVSEC_AFU_CTRL_AFU_IDX,
-					&idx);
-			if (idx == afu_idx)
-				return vsec;
-		}
+	while ((vsec = pci_find_next_dvsec_capability(dev, vsec,
+				PCI_VENDOR_ID_IBM, OCXL_DVSEC_AFU_CTRL_ID))) {
+		pci_read_config_byte(dev, vsec + OCXL_DVSEC_AFU_CTRL_AFU_IDX,
+				     &idx);
+		if (idx == afu_idx)
+			return vsec;
 	}
 	return 0;
 }
diff --git a/include/misc/ocxl-config.h b/include/misc/ocxl-config.h
index ccfd3b463517..40cf1b143170 100644
--- a/include/misc/ocxl-config.h
+++ b/include/misc/ocxl-config.h
@@ -10,10 +10,6 @@
  * It follows the specification for opencapi 3.0
  */
 
-#define OCXL_EXT_CAP_ID_DVSEC                 0x23
-
-#define OCXL_DVSEC_VENDOR_OFFSET              0x4
-#define OCXL_DVSEC_ID_OFFSET                  0x8
 #define OCXL_DVSEC_TL_ID                      0xF000
 #define   OCXL_DVSEC_TL_BACKOFF_TIMERS          0x10
 #define   OCXL_DVSEC_TL_RECV_CAP                0x18
-- 
2.20.1


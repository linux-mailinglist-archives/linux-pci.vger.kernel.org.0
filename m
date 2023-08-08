Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB08977492F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjHHTtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjHHTt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:49:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EE4504C8
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:54:32 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKfRj2C9cztRsG;
        Tue,  8 Aug 2023 11:53:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:56:48 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <fbarrat@linux.ibm.com>,
        <ajd@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <ben.widawsky@intel.com>
CC:     <linux-pci@vger.kernel.org>, <yangyingliang@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <jonathan.cameron@huawei.com>,
        <david.e.box@linux.intel.com>, <helgaas@kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v2 1/2] PCI: Add pci_find_next_dvsec_capability to find next Designated VSEC
Date:   Tue, 8 Aug 2023 12:08:57 +0800
Message-ID: <20230808040858.183568-2-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230808040858.183568-1-wangxiongfeng2@huawei.com>
References: <20230808040858.183568-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices may have several DVSEC (Designated Vendor-Specific Extended
Capability) entries with the same DVSEC ID. Add
pci_find_next_dvsec_capability() to find them all.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   | 39 ++++++++++++++++++++++++++-------------
 include/linux/pci.h |  2 ++
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..2ff5b1ce0eec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -749,35 +749,48 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
 EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
 
 /**
- * pci_find_dvsec_capability - Find DVSEC for vendor
+ * pci_find_next_dvsec_capability - Find next DVSEC for vendor
  * @dev: PCI device to query
+ * @start: Address at which to start looking (0 to start at beginning of list)
  * @vendor: Vendor ID to match for the DVSEC
- * @dvsec: Designated Vendor-specific capability ID
+ * @dvsec: Vendor-defined DVSEC ID
  *
- * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
- * offset in config space; otherwise return 0.
+ * Returns the address of the next DVSEC if the DVSEC has Vendor ID @vendor and
+ * DVSEC ID @dvsec; otherwise return 0. DVSEC can occur several times with the
+ * same DVSEC ID for some devices, and this provides a way to find them all.
  */
-u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
+u16 pci_find_next_dvsec_capability(struct pci_dev *dev, u16 start, u16 vendor,
+				   u16 dvsec)
 {
-	int pos;
+	u16 pos = start;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
-	if (!pos)
-		return 0;
-
-	while (pos) {
+	while ((pos = pci_find_next_ext_capability(dev, pos,
+						  PCI_EXT_CAP_ID_DVSEC))) {
 		u16 v, id;
 
 		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
 		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
 		if (vendor == v && dvsec == id)
 			return pos;
-
-		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_find_next_dvsec_capability);
+
+/**
+ * pci_find_dvsec_capability - Find DVSEC for vendor
+ * @dev: PCI device to query
+ * @vendor: Vendor ID to match for the DVSEC
+ * @dvsec: Vendor-defined DVSEC ID
+ *
+ * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
+ * offset in config space; otherwise return 0.
+ */
+u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
+{
+	return pci_find_next_dvsec_capability(dev, 0, vendor, dvsec);
+}
 EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c69a2cc1f412..82bb905daf72 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1168,6 +1168,8 @@ u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
 u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
+u16 pci_find_next_dvsec_capability(struct pci_dev *dev, u16 start, u16 vendor,
+				   u16 dvsec);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
-- 
2.20.1


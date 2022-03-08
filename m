Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC64D2094
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 19:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiCHSvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 13:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349737AbiCHSvT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 13:51:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94978532E5;
        Tue,  8 Mar 2022 10:50:16 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KCks9117hz67KPR;
        Wed,  9 Mar 2022 02:49:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:50:14 +0100
Received: from A2006125610.china.huawei.com (10.47.82.254) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 18:50:06 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        <jgg@nvidia.com>, <cohuck@redhat.com>, <mgurtovoy@nvidia.com>,
        <yishaih@nvidia.com>, <kevin.tian@intel.com>,
        <linuxarm@huawei.com>, <liulongfang@huawei.com>,
        <prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 3/9] hisi_acc_qm: Move VF PCI device IDs to common header
Date:   Tue, 8 Mar 2022 18:48:56 +0000
Message-ID: <20220308184902.2242-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220308184902.2242-1-shameerali.kolothum.thodi@huawei.com>
References: <20220308184902.2242-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.82.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the PCI Device IDs of HiSilicon ACC VF devices to a common header
and also use a uniform naming convention.

This will be useful when we introduce the vfio PCI HiSilicon ACC live
migration driver in subsequent patches.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
Acked-by: Longfang Liu <liulongfang@huawei.com>
Acked-by: Kai Ye <yekai13@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 13 ++++++-------
 drivers/crypto/hisilicon/sec2/sec_main.c  | 15 +++++++--------
 drivers/crypto/hisilicon/zip/zip_main.c   | 11 +++++------
 include/linux/pci_ids.h                   |  3 +++
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index ebfab3e14499..3589d8879b5e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -68,8 +68,7 @@
 #define HPRE_REG_RD_INTVRL_US		10
 #define HPRE_REG_RD_TMOUT_US		1000
 #define HPRE_DBGFS_VAL_MAX_LEN		20
-#define HPRE_PCI_DEVICE_ID		0xa258
-#define HPRE_PCI_VF_DEVICE_ID		0xa259
+#define PCI_DEVICE_ID_HUAWEI_HPRE_PF	0xa258
 #define HPRE_QM_USR_CFG_MASK		GENMASK(31, 1)
 #define HPRE_QM_AXI_CFG_MASK		GENMASK(15, 0)
 #define HPRE_QM_VFG_AX_MASK		GENMASK(7, 0)
@@ -111,8 +110,8 @@
 static const char hpre_name[] = "hisi_hpre";
 static struct dentry *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_DEVICE_ID) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_VF_DEVICE_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_PF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF) },
 	{ 0, }
 };
 
@@ -242,7 +241,7 @@ MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
-	return q_num_set(val, kp, HPRE_PCI_DEVICE_ID);
+	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_HPRE_PF);
 }
 
 static const struct kernel_param_ops hpre_pf_q_num_ops = {
@@ -921,7 +920,7 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 	qm->debug.sqe_mask_len = HPRE_SQE_MASK_LEN;
 	hisi_qm_debug_init(qm);
 
-	if (qm->pdev->device == HPRE_PCI_DEVICE_ID) {
+	if (qm->pdev->device == PCI_DEVICE_ID_HUAWEI_HPRE_PF) {
 		ret = hpre_ctrl_debug_init(qm);
 		if (ret)
 			goto failed_to_create;
@@ -958,7 +957,7 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	qm->sqe_size = HPRE_SQE_SIZE;
 	qm->dev_name = hpre_name;
 
-	qm->fun_type = (pdev->device == HPRE_PCI_DEVICE_ID) ?
+	qm->fun_type = (pdev->device == PCI_DEVICE_ID_HUAWEI_HPRE_PF) ?
 			QM_HW_PF : QM_HW_VF;
 	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = HPRE_PF_DEF_Q_BASE;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 26d3ab1d308b..311a8747b5bf 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -20,8 +20,7 @@
 
 #define SEC_VF_NUM			63
 #define SEC_QUEUE_NUM_V1		4096
-#define SEC_PF_PCI_DEVICE_ID		0xa255
-#define SEC_VF_PCI_DEVICE_ID		0xa256
+#define PCI_DEVICE_ID_HUAWEI_SEC_PF	0xa255
 
 #define SEC_BD_ERR_CHK_EN0		0xEFFFFFFF
 #define SEC_BD_ERR_CHK_EN1		0x7ffff7fd
@@ -225,7 +224,7 @@ static const struct debugfs_reg32 sec_dfx_regs[] = {
 
 static int sec_pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
-	return q_num_set(val, kp, SEC_PF_PCI_DEVICE_ID);
+	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_SEC_PF);
 }
 
 static const struct kernel_param_ops sec_pf_q_num_ops = {
@@ -313,8 +312,8 @@ module_param_cb(uacce_mode, &sec_uacce_mode_ops, &uacce_mode, 0444);
 MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
 static const struct pci_device_id sec_dev_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, SEC_PF_PCI_DEVICE_ID) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, SEC_VF_PCI_DEVICE_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_PF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_VF) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sec_dev_ids);
@@ -717,7 +716,7 @@ static int sec_core_debug_init(struct hisi_qm *qm)
 	regset->base = qm->io_base;
 	regset->dev = dev;
 
-	if (qm->pdev->device == SEC_PF_PCI_DEVICE_ID)
+	if (qm->pdev->device == PCI_DEVICE_ID_HUAWEI_SEC_PF)
 		debugfs_create_file("regs", 0444, tmp_d, regset, &sec_regs_fops);
 
 	for (i = 0; i < ARRAY_SIZE(sec_dfx_labels); i++) {
@@ -735,7 +734,7 @@ static int sec_debug_init(struct hisi_qm *qm)
 	struct sec_dev *sec = container_of(qm, struct sec_dev, qm);
 	int i;
 
-	if (qm->pdev->device == SEC_PF_PCI_DEVICE_ID) {
+	if (qm->pdev->device == PCI_DEVICE_ID_HUAWEI_SEC_PF) {
 		for (i = SEC_CLEAR_ENABLE; i < SEC_DEBUG_FILE_NUM; i++) {
 			spin_lock_init(&sec->debug.files[i].lock);
 			sec->debug.files[i].index = i;
@@ -877,7 +876,7 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	qm->sqe_size = SEC_SQE_SIZE;
 	qm->dev_name = sec_name;
 
-	qm->fun_type = (pdev->device == SEC_PF_PCI_DEVICE_ID) ?
+	qm->fun_type = (pdev->device == PCI_DEVICE_ID_HUAWEI_SEC_PF) ?
 			QM_HW_PF : QM_HW_VF;
 	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = SEC_PF_DEF_Q_BASE;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 678f8b58ec42..66decfe07282 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -15,8 +15,7 @@
 #include <linux/uacce.h>
 #include "zip.h"
 
-#define PCI_DEVICE_ID_ZIP_PF		0xa250
-#define PCI_DEVICE_ID_ZIP_VF		0xa251
+#define PCI_DEVICE_ID_HUAWEI_ZIP_PF	0xa250
 
 #define HZIP_QUEUE_NUM_V1		4096
 
@@ -246,7 +245,7 @@ MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
-	return q_num_set(val, kp, PCI_DEVICE_ID_ZIP_PF);
+	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_ZIP_PF);
 }
 
 static const struct kernel_param_ops pf_q_num_ops = {
@@ -268,8 +267,8 @@ module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63), 0(default)");
 
 static const struct pci_device_id hisi_zip_dev_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_PF) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_VF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_PF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, hisi_zip_dev_ids);
@@ -838,7 +837,7 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	qm->sqe_size = HZIP_SQE_SIZE;
 	qm->dev_name = hisi_zip_name;
 
-	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ?
+	qm->fun_type = (pdev->device == PCI_DEVICE_ID_HUAWEI_ZIP_PF) ?
 			QM_HW_PF : QM_HW_VF;
 	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = HZIP_PF_DEF_Q_BASE;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index aad54c666407..31dee2b65a62 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2529,6 +2529,9 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
 
 #define PCI_VENDOR_ID_HUAWEI		0x19e5
+#define PCI_DEVICE_ID_HUAWEI_ZIP_VF	0xa251
+#define PCI_DEVICE_ID_HUAWEI_SEC_VF	0xa256
+#define PCI_DEVICE_ID_HUAWEI_HPRE_VF	0xa259
 
 #define PCI_VENDOR_ID_NETRONOME		0x19ee
 #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
-- 
2.25.1


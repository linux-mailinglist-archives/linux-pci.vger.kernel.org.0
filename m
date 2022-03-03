Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E34CC9B7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 00:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiCCXDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 18:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiCCXDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 18:03:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2C10E042;
        Thu,  3 Mar 2022 15:02:43 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8mj12hQTz67fK4;
        Fri,  4 Mar 2022 07:02:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 4 Mar 2022 00:02:41 +0100
Received: from A2006125610.china.huawei.com (10.47.82.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 23:02:34 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        <jgg@nvidia.com>, <cohuck@redhat.com>, <mgurtovoy@nvidia.com>,
        <yishaih@nvidia.com>, <linuxarm@huawei.com>,
        <liulongfang@huawei.com>, <prime.zeng@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v8 6/9] hisi_acc_vfio_pci: Add helper to retrieve the struct pci_driver
Date:   Thu, 3 Mar 2022 23:01:28 +0000
Message-ID: <20220303230131.2103-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220303230131.2103-1-shameerali.kolothum.thodi@huawei.com>
References: <20220303230131.2103-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.82.4]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

struct pci_driver pointer is an input into the pci_iov_get_pf_drvdata().
Introduce helpers to retrieve the ACC PF dev struct pci_driver pointers
as we use this in ACC vfio migration driver.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 6 ++++++
 drivers/crypto/hisilicon/sec2/sec_main.c  | 6 ++++++
 drivers/crypto/hisilicon/zip/zip_main.c   | 6 ++++++
 include/linux/hisi_acc_qm.h               | 5 +++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 3589d8879b5e..36ab30e9e654 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -1190,6 +1190,12 @@ static struct pci_driver hpre_pci_driver = {
 	.driver.pm		= &hpre_pm_ops,
 };
 
+struct pci_driver *hisi_hpre_get_pf_driver(void)
+{
+	return &hpre_pci_driver;
+}
+EXPORT_SYMBOL_GPL(hisi_hpre_get_pf_driver);
+
 static void hpre_register_debugfs(void)
 {
 	if (!debugfs_initialized())
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 311a8747b5bf..421a405ca337 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1088,6 +1088,12 @@ static struct pci_driver sec_pci_driver = {
 	.driver.pm = &sec_pm_ops,
 };
 
+struct pci_driver *hisi_sec_get_pf_driver(void)
+{
+	return &sec_pci_driver;
+}
+EXPORT_SYMBOL_GPL(hisi_sec_get_pf_driver);
+
 static void sec_register_debugfs(void)
 {
 	if (!debugfs_initialized())
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 66decfe07282..4534e1e107d1 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -1012,6 +1012,12 @@ static struct pci_driver hisi_zip_pci_driver = {
 	.driver.pm		= &hisi_zip_pm_ops,
 };
 
+struct pci_driver *hisi_zip_get_pf_driver(void)
+{
+	return &hisi_zip_pci_driver;
+}
+EXPORT_SYMBOL_GPL(hisi_zip_get_pf_driver);
+
 static void hisi_zip_register_debugfs(void)
 {
 	if (!debugfs_initialized())
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 6a6477c34666..00f2a4db8723 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -476,4 +476,9 @@ void hisi_qm_pm_init(struct hisi_qm *qm);
 int hisi_qm_get_dfx_access(struct hisi_qm *qm);
 void hisi_qm_put_dfx_access(struct hisi_qm *qm);
 void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset);
+
+/* Used by VFIO ACC live migration driver */
+struct pci_driver *hisi_sec_get_pf_driver(void);
+struct pci_driver *hisi_hpre_get_pf_driver(void);
+struct pci_driver *hisi_zip_get_pf_driver(void);
 #endif
-- 
2.25.1


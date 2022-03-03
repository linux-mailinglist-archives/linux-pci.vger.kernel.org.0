Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6A4CC9A2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 00:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiCCXCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 18:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiCCXCq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 18:02:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40793F11B3;
        Thu,  3 Mar 2022 15:01:59 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8mg036vtz67btc;
        Fri,  4 Mar 2022 07:00:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 00:01:57 +0100
Received: from A2006125610.china.huawei.com (10.47.82.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 23:01:50 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        <jgg@nvidia.com>, <cohuck@redhat.com>, <mgurtovoy@nvidia.com>,
        <yishaih@nvidia.com>, <linuxarm@huawei.com>,
        <liulongfang@huawei.com>, <prime.zeng@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v8 1/9] crypto: hisilicon/qm: Move the QM header to include/linux
Date:   Thu, 3 Mar 2022 23:01:23 +0000
Message-ID: <20220303230131.2103-2-shameerali.kolothum.thodi@huawei.com>
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

Since we are going to introduce VFIO PCI HiSilicon ACC driver for live
migration in subsequent patches, move the ACC QM header file to a
common include dir.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h                         | 2 +-
 drivers/crypto/hisilicon/qm.c                                | 2 +-
 drivers/crypto/hisilicon/sec2/sec.h                          | 2 +-
 drivers/crypto/hisilicon/sgl.c                               | 2 +-
 drivers/crypto/hisilicon/zip/zip.h                           | 2 +-
 drivers/crypto/hisilicon/qm.h => include/linux/hisi_acc_qm.h | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/crypto/hisilicon/qm.h => include/linux/hisi_acc_qm.h (100%)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index e0b4a1982ee9..9a0558ed82f9 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -4,7 +4,7 @@
 #define __HISI_HPRE_H
 
 #include <linux/list.h>
-#include "../qm.h"
+#include <linux/hisi_acc_qm.h>
 
 #define HPRE_SQE_SIZE			sizeof(struct hpre_sqe)
 #define HPRE_PF_DEF_Q_NUM		64
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c5b84a5ea350..ed23e1d3fa27 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -15,7 +15,7 @@
 #include <linux/uacce.h>
 #include <linux/uaccess.h>
 #include <uapi/misc/uacce/hisi_qm.h>
-#include "qm.h"
+#include <linux/hisi_acc_qm.h>
 
 /* eq/aeq irq enable */
 #define QM_VF_AEQ_INT_SOURCE		0x0
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index d97cf02b1df7..c2e9b01187a7 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -4,7 +4,7 @@
 #ifndef __HISI_SEC_V2_H
 #define __HISI_SEC_V2_H
 
-#include "../qm.h"
+#include <linux/hisi_acc_qm.h>
 #include "sec_crypto.h"
 
 /* Algorithm resource per hardware SEC queue */
diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 057273769f26..f7efc02b065f 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <linux/dma-mapping.h>
+#include <linux/hisi_acc_qm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include "qm.h"
 
 #define HISI_ACC_SGL_SGE_NR_MIN		1
 #define HISI_ACC_SGL_NR_MAX		256
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 517fdbdff3ea..3dfd3bac5a33 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -7,7 +7,7 @@
 #define pr_fmt(fmt)	"hisi_zip: " fmt
 
 #include <linux/list.h>
-#include "../qm.h"
+#include <linux/hisi_acc_qm.h>
 
 enum hisi_zip_error_type {
 	/* negative compression */
diff --git a/drivers/crypto/hisilicon/qm.h b/include/linux/hisi_acc_qm.h
similarity index 100%
rename from drivers/crypto/hisilicon/qm.h
rename to include/linux/hisi_acc_qm.h
-- 
2.25.1


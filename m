Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCDE496A52
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 06:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiAVF0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jan 2022 00:26:41 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50342 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232255AbiAVF0i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jan 2022 00:26:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V2UlMIm_1642829192;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2UlMIm_1642829192)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Jan 2022 13:26:33 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     helgaas@kernel.org, rafael@kernel.org
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 2/2] ACPI: APEI: rename ghes_init with an "acpi_" prefix
Date:   Sat, 22 Jan 2022 13:26:18 +0800
Message-Id: <20220122052618.1074-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 drivers/acpi/bus.c       | 2 +-
 include/acpi/apei.h      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index aadc0a972f18..d91ad378c00d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1457,7 +1457,7 @@ static struct platform_driver ghes_platform_driver = {
 	.remove		= ghes_remove,
 };
 
-void __init ghes_init(void)
+void __init acpi_ghes_init(void)
 {
 	int rc;
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3f403db20f69..cd374210fb9f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1332,7 +1332,7 @@ static int __init acpi_init(void)
 	pci_mmcfg_late_init();
 	acpi_iort_init();
 	acpi_hest_init();
-	ghes_init();
+	acpi_ghes_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 4e60dd73c3bb..afaca3a075e8 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -27,10 +27,10 @@ extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
 extern bool ghes_disable;
-void __init ghes_init(void);
+void __init acpi_ghes_init(void);
 #else
 #define ghes_disable 1
-static inline void ghes_init(void) { }
+static inline void acpi_ghes_init(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_APEI
-- 
2.20.1.12.g72788fdb


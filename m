Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864BA4C5B09
	for <lists+linux-pci@lfdr.de>; Sun, 27 Feb 2022 13:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiB0M0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Feb 2022 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiB0M0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Feb 2022 07:26:33 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A765C878;
        Sun, 27 Feb 2022 04:25:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V5b5SAC_1645964751;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V5b5SAC_1645964751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 27 Feb 2022 20:25:52 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     helgaas@kernel.org, rafael@kernel.org, nathan@kernel.org
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v8 2/2] ACPI: APEI: rename ghes_init with an "acpi_" prefix
Date:   Sun, 27 Feb 2022 20:25:46 +0800
Message-Id: <20220227122546.43307-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ghes_init() sticks out in acpi_init() because it is the only functions
without an "acpi_" prefix.

Rename ghes_init with an "acpi_" prefix, then all looks fine.

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


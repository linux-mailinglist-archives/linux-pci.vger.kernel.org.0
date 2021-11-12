Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41A44E7F9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 14:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhKLN5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 08:57:02 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42164 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhKLN5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 08:57:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UwCALcf_1636725247;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UwCALcf_1636725247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Nov 2021 21:54:08 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [RFC PATCH] ACPI: Move sdei_init and ghes_init ahead
Date:   Fri, 12 Nov 2021 21:54:05 +0800
Message-Id: <20211112135405.19318-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On an ACPI system, ACPI is initialised very early from a
subsys_initcall(), while SDEI is not ready until a subsys_initcall().
More seriously, the kernel is able to handle and report errors until the
GHES is initialised by device_initcall().

Consequently, when an error occurs during the kernel booting, the
phyiscal sdei dispatcher in firmware fails to dispatch error events. All
errors that occurred before GHES initialization are missed and there is
no chance to report and find them again.

In this patch, move sdei_init and ghes_init as far ahead as possible,
right after acpi_hest_init().

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c    | 3 +--
 drivers/acpi/pci_root.c     | 2 ++
 drivers/firmware/arm_sdei.c | 9 +--------
 include/acpi/apei.h         | 2 ++
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index c60961d31213..bf0177f44dfd 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1452,7 +1452,7 @@ static struct platform_driver ghes_platform_driver = {
 	.remove		= ghes_remove,
 };
 
-static int __init ghes_init(void)
+int __init ghes_init(void)
 {
 	int rc;
 
@@ -1494,4 +1494,3 @@ static int __init ghes_init(void)
 err:
 	return rc;
 }
-device_initcall(ghes_init);
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 81cc18f39cc8..d9bbb6b8340e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -977,6 +977,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 void __init acpi_pci_root_init(void)
 {
 	acpi_hest_init();
+	sdei_init();
+	ghes_init();
 	if (acpi_pci_disabled)
 		return;
 
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 198151ca471d..604063d6f542 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1089,7 +1089,7 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
-static int __init sdei_init(void)
+int __init sdei_init(void)
 {
 	struct platform_device *pdev;
 	int ret;
@@ -1110,13 +1110,6 @@ static int __init sdei_init(void)
 	return ret;
 }
 
-/*
- * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
- * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
- * by device_initcall(). We want to be called in the middle.
- */
-subsys_initcall_sync(sdei_init);
-
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 680f80960c3d..5e6187ca5621 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -33,6 +33,8 @@ extern bool ghes_disable;
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int __init sdei_init(void);
+int __init ghes_init(void);
 #else
 static inline void acpi_hest_init(void) { return; }
 #endif
-- 
2.20.1.9.gb50a0d7


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1F34B4C6
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 07:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhC0GoX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 02:44:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15335 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhC0GoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 02:44:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6q4m1bPDz93nW;
        Sat, 27 Mar 2021 14:41:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 14:43:35 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH 03/15] ACPI: acpi_dbg: fix some coding style issues
Date:   Sat, 27 Mar 2021 14:40:44 +0800
Message-ID: <1616827256-51840-4-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
References: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: space prohibited between function name and open parenthesis
WARNING: else is not generally useful after a break or return

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_dbg.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index d50261d..e641bc1 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -21,7 +21,7 @@
 #include <linux/acpi.h>
 #include "internal.h"
 
-#define ACPI_AML_BUF_ALIGN	(sizeof (acpi_size))
+#define ACPI_AML_BUF_ALIGN	(sizeof(acpi_size))
 #define ACPI_AML_BUF_SIZE	PAGE_SIZE
 
 #define circ_count(circ) \
@@ -613,16 +613,15 @@ static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 		if (ret == -EAGAIN) {
 			if (file->f_flags & O_NONBLOCK)
 				break;
-			else {
-				ret = wait_event_interruptible(acpi_aml_io.wait,
-					acpi_aml_user_readable());
-				/*
-				 * We need to retry when the condition
-				 * becomes true.
-				 */
-				if (ret == 0)
-					goto again;
-			}
+
+			ret = wait_event_interruptible(acpi_aml_io.wait,
+				acpi_aml_user_readable());
+			/*
+			 * We need to retry when the condition
+			 * becomes true.
+			 */
+			if (ret == 0)
+				goto again;
 		}
 		if (ret < 0) {
 			if (!acpi_aml_running())
@@ -683,16 +682,15 @@ static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
 		if (ret == -EAGAIN) {
 			if (file->f_flags & O_NONBLOCK)
 				break;
-			else {
-				ret = wait_event_interruptible(acpi_aml_io.wait,
-					acpi_aml_user_writable());
-				/*
-				 * We need to retry when the condition
-				 * becomes true.
-				 */
-				if (ret == 0)
-					goto again;
-			}
+
+			ret = wait_event_interruptible(acpi_aml_io.wait,
+				acpi_aml_user_writable());
+			/*
+			 * We need to retry when the condition
+			 * becomes true.
+			 */
+			if (ret == 0)
+				goto again;
 		}
 		if (ret < 0) {
 			if (!acpi_aml_running())
-- 
2.8.1


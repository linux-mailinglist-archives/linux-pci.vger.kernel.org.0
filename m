Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2925D34B706
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhC0MLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 08:11:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15013 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhC0MLL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKv0bG6zPsyJ;
        Sat, 27 Mar 2021 20:08:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:01 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 07/12] ACPI: button: fix some coding style issues
Date:   Sat, 27 Mar 2021 20:08:19 +0800
Message-ID: <1616846904-25719-8-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
ERROR: code indent should use tabs where possible

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/button.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 85e5e03..f25bd33 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -156,10 +156,7 @@ static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
 
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
+/* FS Interface (/proc) */
 static struct proc_dir_entry *acpi_button_dir;
 static struct proc_dir_entry *acpi_lid_dir;
 
@@ -348,9 +345,7 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
-/* --------------------------------------------------------------------------
-                                Driver Interface
-   -------------------------------------------------------------------------- */
+/* Driver Interface */
 int acpi_lid_open(void)
 {
 	if (!lid_device)
-- 
2.8.1


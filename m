Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87A434B528
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 08:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhC0Htn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 03:49:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15346 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhC0HtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 03:49:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6rXK5Xyyz93yl;
        Sat, 27 Mar 2021 15:47:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:06 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 12/15] ACPI: custom_method: fix a coding style issue
Date:   Sat, 27 Mar 2021 15:46:30 +0800
Message-ID: <1616831193-17920-13-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following coding style issue reported by checkpatch.pl

ERROR: "foo * bar" should be "foo *bar"
FILE: drivers/acpi/custom_method.c:22:
+static ssize_t cm_write(struct file *file, const char __user * user_buf,

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/custom_method.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 7b54dc9..443fdf62 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -19,7 +19,7 @@ static struct dentry *cm_dentry;
 
 /* /sys/kernel/debug/acpi/custom_method */
 
-static ssize_t cm_write(struct file *file, const char __user * user_buf,
+static ssize_t cm_write(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
 	static char *buf;
-- 
2.8.1


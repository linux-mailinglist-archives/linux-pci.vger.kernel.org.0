Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B424234B4B9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 07:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhC0GoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 02:44:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15332 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhC0GoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 02:44:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6q4m0j9Yz93nS;
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
Subject: [PATCH 04/15] ACPI: acpi_fpdt: replace __attribute__((packed)) by __packed
Date:   Sat, 27 Mar 2021 14:40:45 +0800
Message-ID: <1616827256-51840-5-git-send-email-tanxiaofei@huawei.com>
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

Replace __attribute__((packed)) by __packed following the
advice of checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_fpdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index a89a806..690a88a 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -53,7 +53,7 @@ struct resume_performance_record {
 	u32 resume_count;
 	u64 resume_prev;
 	u64 resume_avg;
-} __attribute__((packed));
+} __packed;
 
 struct boot_performance_record {
 	struct fpdt_record_header header;
@@ -63,13 +63,13 @@ struct boot_performance_record {
 	u64 bootloader_launch;
 	u64 exitbootservice_start;
 	u64 exitbootservice_end;
-} __attribute__((packed));
+} __packed;
 
 struct suspend_performance_record {
 	struct fpdt_record_header header;
 	u64 suspend_start;
 	u64 suspend_end;
-} __attribute__((packed));
+} __packed;
 
 
 static struct resume_performance_record *record_resume;
-- 
2.8.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B134B521
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhC0Htm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 03:49:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15344 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC0HtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 03:49:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6rXK4p77z93yj;
        Sat, 27 Mar 2021 15:47:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:07 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 15/15] ACPI: dock: fix some coding style issues
Date:   Sat, 27 Mar 2021 15:46:33 +0800
Message-ID: <1616831193-17920-16-git-send-email-tanxiaofei@huawei.com>
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

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: Missing a blank line after declarations
ERROR: spaces required around that ':'
WARNING: Statements should start on a tabstop

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/dock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 0937cea..7cf9215 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -271,6 +271,7 @@ static void hotplug_dock_devices(struct dock_station *ds, u32 event)
 
 		if (!acpi_device_enumerated(adev)) {
 			int ret = acpi_bus_scan(adev->handle);
+
 			if (ret)
 				dev_dbg(&adev->dev, "scan error %d\n", -ret);
 		}
@@ -502,6 +503,7 @@ static ssize_t flags_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct dock_station *dock_station = dev->platform_data;
+
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
 
 }
@@ -523,7 +525,7 @@ static ssize_t undock_store(struct device *dev, struct device_attribute *attr,
 	begin_undock(dock_station);
 	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
 	acpi_scan_lock_release();
-	return ret ? ret: count;
+	return ret ? ret : count;
 }
 static DEVICE_ATTR_WO(undock);
 
@@ -535,10 +537,11 @@ static ssize_t uid_show(struct device *dev,
 {
 	unsigned long long lbuf;
 	struct dock_station *dock_station = dev->platform_data;
+
 	acpi_status status = acpi_evaluate_integer(dock_station->handle,
 					"_UID", NULL, &lbuf);
 	if (ACPI_FAILURE(status))
-	    return 0;
+		return 0;
 
 	return snprintf(buf, PAGE_SIZE, "%llx\n", lbuf);
 }
-- 
2.8.1


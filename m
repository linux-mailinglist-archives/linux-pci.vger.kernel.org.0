Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98FA34B721
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhC0MLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 08:11:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC0MLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKt6QgSzPrSW;
        Sat, 27 Mar 2021 20:08:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:00 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 04/12] ACPI: LPSS: add a missed blank line after declarations
Date:   Sat, 27 Mar 2021 20:08:16 +0800
Message-ID: <1616846904-25719-5-git-send-email-tanxiaofei@huawei.com>
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

Add a missed blank line after declarations, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index be73974..ca742f1 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -377,6 +377,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 static int is_memory(struct acpi_resource *res, void *not_used)
 {
 	struct resource r;
+
 	return !acpi_dev_resource_memory(res, &r);
 }
 
@@ -1200,6 +1201,7 @@ static int acpi_lpss_poweroff_noirq(struct device *dev)
 	if (pdata->dev_desc->resume_from_noirq) {
 		/* This is analogous to the acpi_lpss_suspend_noirq() case. */
 		int ret = acpi_lpss_do_poweroff_late(dev);
+
 		if (ret)
 			return ret;
 	}
-- 
2.8.1


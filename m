Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A064B34B71B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 13:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhC0MLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 08:11:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15018 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhC0MLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:13 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKv1VRbzPt2p;
        Sat, 27 Mar 2021 20:08:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:02 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 10/12] ACPI: PM: add a missed blank line after declarations
Date:   Sat, 27 Mar 2021 20:08:22 +0800
Message-ID: <1616846904-25719-11-git-send-email-tanxiaofei@huawei.com>
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
 drivers/acpi/device_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 0961537..16c0fe8 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -966,6 +966,7 @@ EXPORT_SYMBOL_GPL(acpi_dev_resume);
 int acpi_subsys_runtime_suspend(struct device *dev)
 {
 	int ret = pm_generic_runtime_suspend(dev);
+
 	return ret ? ret : acpi_dev_suspend(dev, true);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
@@ -980,6 +981,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
 int acpi_subsys_runtime_resume(struct device *dev)
 {
 	int ret = acpi_dev_resume(dev);
+
 	return ret ? ret : pm_generic_runtime_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
@@ -1171,6 +1173,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
 int acpi_subsys_restore_early(struct device *dev)
 {
 	int ret = acpi_dev_resume(dev);
+
 	return ret ? ret : pm_generic_restore_early(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
-- 
2.8.1


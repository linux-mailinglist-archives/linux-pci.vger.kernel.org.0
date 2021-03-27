Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1A34B530
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhC0Hto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 03:49:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14926 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhC0HtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 03:49:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6rXg5sryzkjVg;
        Sat, 27 Mar 2021 15:47:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:04 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 07/15] ACPI: memhotplug: fix a coding style issue
Date:   Sat, 27 Mar 2021 15:46:25 +0800
Message-ID: <1616831193-17920-8-git-send-email-tanxiaofei@huawei.com>
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

WARNING: __initdata should be placed after acpi_no_memhotplug
FILE: drivers/acpi/acpi_memhotplug.c:326:
+static bool __initdata acpi_no_memhotplug;

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_memhotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 8cc195c..5c5ed22 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -323,7 +323,7 @@ static void acpi_memory_device_remove(struct acpi_device *device)
 	acpi_memory_device_free(mem_device);
 }
 
-static bool __initdata acpi_no_memhotplug;
+static bool acpi_no_memhotplug __initdata;
 
 void __init acpi_memory_hotplug_init(void)
 {
-- 
2.8.1


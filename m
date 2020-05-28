Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3681E5AFF
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE1IjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 04:39:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbgE1IjY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 04:39:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A96BCBD57AF03F838065;
        Thu, 28 May 2020 16:39:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 16:39:01 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <rjw@rjwysocki.net>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
Date:   Thu, 28 May 2020 16:38:45 +0800
Message-ID: <1590655125-23949-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously we'll print wrong ASPM status if _OSC method return
failed. For example, if ASPM is enabled by setting pcie_aspm=force,
we get message below:

    acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND); disabling ASPM

Fix it and print correct ASPM status when _OSC failed.

Fixes: 1ad61b612b95 ("PCI/ACPI: Correct error message for ASPM disabling")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ac8ad6c..5140b26 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -456,7 +456,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 
 		dev_info(&device->dev, "_OSC failed (%s)%s\n",
 			 acpi_format_exception(status),
-			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
+			 pcie_aspm_support_enabled() ? "" : "; disabling ASPM");
 		return;
 	}
 
-- 
2.8.1


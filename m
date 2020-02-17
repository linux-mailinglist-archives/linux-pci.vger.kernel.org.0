Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBA1610E8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 12:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgBQLRW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 06:17:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728788AbgBQLRW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Feb 2020 06:17:22 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D15B4D1736616397B7D8;
        Mon, 17 Feb 2020 19:17:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Feb 2020 19:17:06 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v4 07/10] PCI: Refactor bus_speed_read() with PCI_SPEED2STR macro
Date:   Mon, 17 Feb 2020 19:13:01 +0800
Message-ID: <1581937984-40353-8-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1581937984-40353-1-git-send-email-yangyicong@hisilicon.com>
References: <1581937984-40353-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI_SPEED2STR macro to replace judgement statment in
bus_speed_read() function.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/slot.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index fb7c172..1c7e83f2 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -51,14 +51,7 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
-	const char *speed_string;
-
-	if (speed < pci_bus_speed_strings_size)
-		speed_string = pci_bus_speed_strings[speed];
-	else
-		speed_string = "Unknown";
-
-	return sprintf(buf, "%s\n", speed_string);
+	return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
 }
 
 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
-- 
2.8.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCFB30F259
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 12:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhBDLf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 06:35:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12127 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhBDLdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 06:33:22 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWbwR5Npzz162m1;
        Thu,  4 Feb 2021 19:31:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 19:32:28 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <linuxarm@openeuler.org>
Subject: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
Date:   Thu, 4 Feb 2021 19:30:15 +0800
Message-ID: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Use subdir-ccflags-* instead of ccflags-* to inherit the debug
settings from Kconfig when traversing subdirectories.

Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 11cc794..d62c4ac 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 obj-y				+= controller/
 obj-y				+= switch/
 
-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
+subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
-- 
2.8.1


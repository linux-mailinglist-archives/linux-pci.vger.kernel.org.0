Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435EF310DE
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEaPJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 11:09:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaPJx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 11:09:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8575913112EC03796CDD;
        Fri, 31 May 2019 23:09:48 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 23:09:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bhelgaas@google.com>, <sthemmin@microsoft.com>,
        <sashal@kernel.org>, <decui@microsoft.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] PCI: hv: Fix build error without CONFIG_SYSFS
Date:   Fri, 31 May 2019 23:09:23 +0800
Message-ID: <20190531150923.12376-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

while building without CONFIG_SYSFS, fails as below:

drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_assign_slots':
pci-hyperv.c:(.text+0x40a): undefined reference to 'pci_create_slot'
drivers/pci/controller/pci-hyperv.o: In function 'pci_devices_present_work':
pci-hyperv.c:(.text+0xc02): undefined reference to 'pci_destroy_slot'
drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_remove':
pci-hyperv.c:(.text+0xe50): undefined reference to 'pci_destroy_slot'
drivers/pci/controller/pci-hyperv.o: In function 'hv_eject_device_work':
pci-hyperv.c:(.text+0x11f9): undefined reference to 'pci_destroy_slot'

Select SYSFS while PCI_HYPERV is set to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab9240..6722952 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -182,6 +182,7 @@ config PCI_LABEL
 config PCI_HYPERV
         tristate "Hyper-V PCI Frontend"
         depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	select SYSFS
         help
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.
-- 
2.7.4



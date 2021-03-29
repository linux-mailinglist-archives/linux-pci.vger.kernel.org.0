Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96E34CE73
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 13:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhC2LFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 07:05:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15375 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhC2LEl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 07:04:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F88mq2shJz90JY;
        Mon, 29 Mar 2021 19:02:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 19:04:29 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <kw@linux.com>, <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v2] PCI/AER: Use consistent format when printing PCI device
Date:   Mon, 29 Mar 2021 19:02:01 +0800
Message-ID: <1617015721-51701-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We use format domain:bus:slot.function when printing
PCI device. Use consistent format in AER messages.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- address comments from Krzysztof
Link: https://lore.kernel.org/linux-pci/1616752057-9720-1-git-send-email-yangyicong@hisilicon.com/

 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ba22388..f7f0ca5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -983,7 +983,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
 		if (!pdev) {
-			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x:%x\n",
+			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x.%x\n",
 			       entry.domain, entry.bus,
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
@@ -1022,7 +1022,7 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 				 &aer_recover_ring_lock))
 		schedule_work(&aer_recover_work);
 	else
-		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x:%x\n",
+		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
--
2.8.1


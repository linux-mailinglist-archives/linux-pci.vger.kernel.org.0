Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D57348A20
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 08:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCYH0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 03:26:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14469 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCYH0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 03:26:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5c6h2qlfzrZjK;
        Thu, 25 Mar 2021 15:24:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 15:26:01 +0800
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <bhelgaas@google.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH v2] ACPI / hotplug / PCI: fix memory leak in enable_slot()
Message-ID: <b411af88-5049-a1c6-83ac-d104a1f429be@huawei.com>
Date:   Thu, 25 Mar 2021 15:26:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Feilong Lin <linfeilong@huawei.com>

In enable_slot() in drivers/pci/hotplug/acpiphp_glue.c, if pci_get_slot()
will return NULL, we will do not set SLOT_ENABLED flag of slot. if one
device is found by calling pci_get_slot(), its reference count will be
increased. In this case, we did not call pci_dev_put() to decrement the
its reference count, the memory of the device (struct pci_dev type) will
leak.

Fix it by calling pci_dev_put() to decrement its reference count after that
pci_get_slot() returns a PCI device.

Signed-off-by: Feilong Lin <linfeilong@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
--
v2: rewrite subject and commit log as suggested by Bjorn Helgaas.
---
 drivers/pci/hotplug/acpiphp_glue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 3365c93abf0e..f031302ad401 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 			slot->flags &= ~SLOT_ENABLED;
 			continue;
 		}
+		pci_dev_put(dev);
 	}
 }

-- 
2.19.1


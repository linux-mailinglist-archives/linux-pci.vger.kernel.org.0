Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A0343329
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCUPaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 11:30:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13998 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCUP3k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Mar 2021 11:29:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F3M2P1TmhzrZNw;
        Sun, 21 Mar 2021 23:27:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Sun, 21 Mar 2021
 23:29:30 +0800
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <bhelgaas@google.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, "wubo (T)" <wubo40@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] pci: fix memory leak when virtio pci hotplug
Message-ID: <c48998b7-5308-e196-66b5-905fc8c4edc4@huawei.com>
Date:   Sun, 21 Mar 2021 23:29:30 +0800
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

Repeated hot-plugging of pci devices for a virtual
machine driven by virtio, we found that there is a
leak in kmalloc-4k, which was confirmed as the memory
of the pci_device structure. Then we found out that
it was missing pci_dev_put() after pci_get_slot() in
enable_slot() of acpiphp_glue.c.

Signed-off-by: Feilong Lin <linfeilong@huawei.com>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
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



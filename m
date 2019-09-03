Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C6A63C2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfICIXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 04:23:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfICIXM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 04:23:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 709F1B0D7378A76946CA;
        Tue,  3 Sep 2019 16:23:10 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 16:23:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bhelgaas@google.com>, <hch@infradead.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] PCI: Don't use GFP_KERNEL for kstrbdup in resource_alignment_store
Date:   Tue, 3 Sep 2019 16:22:29 +0800
Message-ID: <20190903082229.21488-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190831124932.18759-1-yuehaibing@huawei.com>
References: <20190831124932.18759-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When allocating memory, the GFP_KERNEL cannot be used during the
spin_lock period. It may cause scheduling when holding spin_lock.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Fixes: f13755318675 ("PCI: Move pci_[get|set]_resource_alignment_param() into their callers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: move alloc out of spinlock
---
 drivers/pci/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 484e353..a3d5920 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6145,14 +6145,17 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
-	spin_lock(&resource_alignment_lock);
+	char *param = kstrndup(buf, count, GFP_KERNEL);
 
-	kfree(resource_alignment_param);
-	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
 
+	spin_lock(&resource_alignment_lock);
+	kfree(resource_alignment_param);
+	resource_alignment_param = param;
 	spin_unlock(&resource_alignment_lock);
 
-	return resource_alignment_param ? count : -ENOMEM;
+	return count;
 }
 
 static BUS_ATTR_RW(resource_alignment);
-- 
2.7.4



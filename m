Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96274A447E
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfHaMq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 08:46:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727672AbfHaMq0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 31 Aug 2019 08:46:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 87588B85DC32BEBC8C29;
        Sat, 31 Aug 2019 20:46:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Sat, 31 Aug 2019 20:46:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: Use GFP_ATOMIC in resource_alignment_store()
Date:   Sat, 31 Aug 2019 12:49:32 +0000
Message-ID: <20190831124932.18759-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When allocating memory, the GFP_KERNEL cannot be used during the
spin_lock period. It may cause scheduling when holding spin_lock.

Fixes: f13755318675 ("PCI: Move pci_[get|set]_resource_alignment_param() into their callers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 484e35349565..0b5fc6736f3f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6148,7 +6148,7 @@ static ssize_t resource_alignment_store(struct bus_type *bus,
 	spin_lock(&resource_alignment_lock);
 
 	kfree(resource_alignment_param);
-	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
+	resource_alignment_param = kstrndup(buf, count, GFP_ATOMIC);
 
 	spin_unlock(&resource_alignment_lock);




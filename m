Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1008A42F3
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfHaG6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 02:58:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfHaG6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 31 Aug 2019 02:58:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 43B8B21F62B63874339A;
        Sat, 31 Aug 2019 14:58:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 31 Aug 2019 14:58:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pci@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: Use GFP_ATOMIC under spin lock
Date:   Sat, 31 Aug 2019 07:01:47 +0000
Message-ID: <20190831070147.25607-1-weiyongjun1@huawei.com>
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

A spin lock is taken here so we should use GFP_ATOMIC.

Fixes: 41b5ef225daa ("PCI: Clean up resource_alignment parameter to not require static buffer")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
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




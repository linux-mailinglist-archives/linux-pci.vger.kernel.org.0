Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634B1313006
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 12:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhBHLCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 06:02:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12869 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhBHLAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 06:00:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZ3011pt1z7hkj;
        Mon,  8 Feb 2021 18:57:53 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 18:59:11 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v1 2/2] genirq/msi: add an error print when __irq_domain_alloc_irqs() failed
Date:   Mon, 8 Feb 2021 18:58:46 +0800
Message-ID: <1612781926-56206-3-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
References: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During debug, we found that the return value of __irq_domain_alloc_irqs()
will be overwritten by the return value of subsequent function. As a
result, the locating clue will be lost.

To improve debug efficiency, an error message is added to print the
return value of __irq_domain_alloc_irqs().

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 kernel/irq/msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b338d62..f8729b0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -418,6 +418,7 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 					       desc->affinity);
 		if (virq < 0) {
 			ret = -ENOSPC;
+			dev_err(dev, "failed to allocate irq, virq=%d\n", virq);
 			if (ops->handle_error)
 				ret = ops->handle_error(domain, desc, ret);
 			if (ops->msi_finish)
-- 
2.7.4


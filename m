Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6759C313019
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhBHLGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 06:06:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12870 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhBHLAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 06:00:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZ3012Flwz7hqv;
        Mon,  8 Feb 2021 18:57:53 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 18:59:11 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v1 1/2] irqchip/gic-v3-its: don't set bitmap for LPI which user didn't allocate
Date:   Mon, 8 Feb 2021 18:58:45 +0800
Message-ID: <1612781926-56206-2-git-send-email-luojiaxing@huawei.com>
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

The driver sets the LPI bitmap of device based on get_count_order(nvecs).
This means that when the number of LPI interrupts does not meet the power
of two, redundant bits are set in the LPI bitmap. However, when free
interrupt, these redundant bits is not cleared. As a result, device will
fails to allocate the same numbers of interrupts next time.

Therefore, clear the redundant bits set in LPI bitmap.

Fixes: 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt that has no mapping")

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ed46e60..027f7ef 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3435,6 +3435,10 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 
 	*hwirq = dev->event_map.lpi_base + idx;
 
+	bitmap_clear(dev->event_map.lpi_map,
+		     idx + nvecs,
+		     roundup_pow_of_two(nvecs) - nvecs);
+
 	return 0;
 }
 
-- 
2.7.4


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39AB5CE63
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfGBL2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 07:28:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfGBL2Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 07:28:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 544329EB6D970CEBF76A;
        Tue,  2 Jul 2019 19:28:09 +0800 (CST)
Received: from huawei.com (10.175.100.202) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 19:28:00 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <bhelgaas@google.com>, <andy.shevchenko@gmail.com>,
        <sebott@linux.ibm.com>, <lukas@wunner.de>,
        <gustavo@embeddedor.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linmiaohe@huawei.com>, <mingfangsen@huawei.com>
Subject: [PATCH] net: pci: Fix hotplug event timeout with shpchp
Date:   Tue, 2 Jul 2019 13:35:19 +0000
Message-ID: <1562074519-205047-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.100.202]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hotplug a network card would take more than 5 seconds
in qemu + shpchp scene. It’s because 5 seconds
delayed_work in func handle_button_press_event with
case STATIC_STATE. And this will break some
protocols with timeout within 5 seconds.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/pci/hotplug/shpchp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 078003dcde5b..cbb00acaba0d 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -478,7 +478,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		p_slot->hpc_ops->green_led_blink(p_slot);
 		p_slot->hpc_ops->set_attention_status(p_slot, 0);
 
-		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
+		queue_delayed_work(p_slot->wq, &p_slot->work, 0);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
-- 
2.21.GIT


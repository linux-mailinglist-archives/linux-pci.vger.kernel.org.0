Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51986EA20F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjDUC6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjDUC6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 22:58:55 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71CCA7AA5
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EUyY2
        sIlajTXj7j1Siih+C/A87NtF5xo0yxTLcIy4Tc=; b=HVJ+k6Pc/W1QwSOWqZQMZ
        ZSmtU30qgtjDRIGAmgyhsV59cECVE2QZ89eAzAMYDX8rkJVtyJFHi6reHNniQNRg
        freV/XjIH9TScrj4vcxElucOKXzuhbU+r9vRovgfTsck+NuLAuTmDrHWY8jJR6vf
        jolzwidMzLAU5EH6NdYX74=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wBnlzd1+0Fk2m0_CA--.3189S2;
        Fri, 21 Apr 2023 10:56:53 +0800 (CST)
From:   Rongguang Wei <clementwei90@163.com>
To:     lukas@wunner.de
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v3] PCI: pciehp: Fix the slot in BLINKINGON_STATE when Presence Detect Changed event occurred
Date:   Fri, 21 Apr 2023 10:56:41 +0800
Message-Id: <20230421025641.655991-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnlzd1+0Fk2m0_CA--.3189S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfWrW8Jr4UKFW5Gr1Dtrb_yoW8KF15pa
        yDGa1agry0gayUXws3XF48Ww1Yy3savrWUCF1DCw17ua1fCr4xJasY9ryYqrZI9FWkXaya
        93WDKFyDW3WUAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Utl1PUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiXRpYa1WBpTy8kQAAsU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rongguang Wei <weirongguang@kylinos.cn>

pciehp's behavior is incorrect if the Attention Button is pressed
on an unoccupied slot.

When a Presence Detect Changed event has occurred, the slot status
in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.
But if the slot status is in BLINKINGON_STATE and the slot is currently
empty, the slot status was staying in BLINKINGON_STATE.

The message print like this:
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
    pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Button cancel
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Action canceled due to button press

It cause the next Attention Button Pressed event become Button cancel
and missing the Presence Detect Changed event with this button press
though this button presses event is occurred after 5s.

According to the Commit d331710ea78f ("PCI: pciehp: Become resilient
to missed events"), if the slot is currently occupied, turn it on and
if the slot is empty, it need to set in OFF_STATE rather than stay in
current status when pciehp_handle_presence_or_link_change() bails out.

V2: Update to simple code and avoid gratuitous message.
V3: Add Suggested-by.

Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
Link: https://lore.kernel.org/linux-pci/20230403054619.19163-1-clementwei90@163.com/
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..1f78e401e9b6 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -256,6 +256,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
+		ctrl->state = OFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


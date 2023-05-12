Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B286FFED3
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 04:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjELCQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjELCQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 22:16:42 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F8785583
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=X9AJ+
        wDj5xYSYZkr2/fZIUUlhkzYe2xG8HftnZjfOGI=; b=FDROzbrHg1L3uXx+9FeE1
        VBEs0z/06ge1ssez0yifuUmS6EP0WVqXrm5PUyhHbJQUzqFfTsjZ+VeNiUcH45ZY
        rmjZVfX0XNkIj/hH1H+6IVIR25VqMngw6/PDsVkOqjzSqi8wwhwPMEV5bbF5goNx
        bJJP6RgAc4f+xU5fRGK3SE=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wDn9yM7oV1kAjvuAA--.46898S2;
        Fri, 12 May 2023 10:15:24 +0800 (CST)
From:   Rongguang Wei <clementwei90@163.com>
To:     lukas@wunner.de
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when Presence Detect Changed event occurred
Date:   Fri, 12 May 2023 10:15:18 +0800
Message-Id: <20230512021518.336460-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn9yM7oV1kAjvuAA--.46898S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry7Ar45ZF4UWw1rZF18Zrb_yoW5Xw13pa
        yDG3yagry8W34UXws3XF48Wr1YkwnavrWUCF1DCw17uayfCr4xA3sa9ryYgrWq9FWDXa4j
        van8KFyDu3WUZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_uciUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiQgdta1aEFS5+jQACsb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
V4: Add state change conditional and message.

Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
Link: https://lore.kernel.org/linux-pci/20230403054619.19163-1-clementwei90@163.com/
Link: https://lore.kernel.org/linux-pci/20230421025641.655991-1-clementwei90@163.com/
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..32baba1b7f13 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -256,6 +256,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
+		if (ctrl->state == BLINKINGON_STATE) {
+			ctrl->state = OFF_STATE;
+			cancel_delayed_work(&ctrl->button_work);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      INDICATOR_NOOP);
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(ctrl));
+		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


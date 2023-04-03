Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A256D3CFD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 07:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDCFrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 01:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDCFrE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 01:47:04 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C11CC5BB8
        for <linux-pci@vger.kernel.org>; Sun,  2 Apr 2023 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6lTUs
        9DNXZTTC6YdpUUmT7Dq2IwKirj8foOuTjWF4o8=; b=JQAy/Uhca7BlgkBDp72xv
        qrDi/1194+Iick5qLgblZ67uR3n0du+Fd817zAiAbcqEShp+wxjkRaU3YT7aBsXI
        cPtXdHgbxMSa2uqTrZLmFa18GXl8QZLPdEs85SM71oBA/yzqOzWqL3qWGpvP9Dli
        Okbr2OlbsTbcEJ4TbFcfrg=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wAXLTIyaCpkuxK0AQ--.14346S2;
        Mon, 03 Apr 2023 13:46:26 +0800 (CST)
From:   Rongguang Wei <clementwei90@163.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lukas@wunner.de,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when Presence Detect Changed event occurred
Date:   Mon,  3 Apr 2023 13:46:19 +0800
Message-Id: <20230403054619.19163-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXLTIyaCpkuxK0AQ--.14346S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry7Ar45ZF4UWw1rZF18Zrb_yoW5Zr17pF
        ykG3yIgry09ayUXws7XF18Wa4YkrnxZFW5CF1DAr17X3WfCr4fJasYvryjqrZrWFWDXFZI
        9a1DKF1qqF4UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQ4S7UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbBzhU+a2I0XwX65wADsc
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rongguang Wei <weirongguang@kylinos.cn>

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
current status. So the slot which status in BLINKINGON_STATE is also
turn off unconditionally.

The message print like this after the patch:
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
    pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Card not present
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Already disabled
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
    pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Card not present
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Already disabled
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Card present
    pcieport 0000:00:01.5: pciehp: Slot(0-5): Link Up

After that, the next Attention Button Pressed event would power on
the slot normally.

Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..86fc9342be68 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -232,6 +232,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	 */
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
+	case BLINKINGON_STATE:
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&ctrl->button_work);
 		fallthrough;
@@ -261,9 +262,6 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	}
 
 	switch (ctrl->state) {
-	case BLINKINGON_STATE:
-		cancel_delayed_work(&ctrl->button_work);
-		fallthrough;
 	case OFF_STATE:
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


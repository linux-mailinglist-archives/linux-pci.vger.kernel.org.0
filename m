Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591A970CCA9
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjEVVlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 17:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjEVVlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 17:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DA100
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 14:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77D9C62B98
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 21:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874E2C433EF;
        Mon, 22 May 2023 21:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684791657;
        bh=OAR7MHw7lFBKzh7BUE7edKGwGpW4DGrZ8uo+sDeMnJU=;
        h=From:To:Cc:Subject:Date:From;
        b=Izt2ZXqDtryPad1f+UOsGKDk6YgNoBzLOjgU6vgKnXgdr/k2zkkurbdkg+UgUw1g5
         xwzVybG4YXguxTwdqYceKEPM/P75fR3KN5wv2FxNBjtAKpFjveSQzUkBD7dOgIxjYS
         DrgJj91Xw1Qi4Wf6N/w/xe2DP5n2BD4d8BSybQs6u4pHI17lIoZ4TKpSTxL2PxCbuv
         Vht312Mb+qD/bGsK/t5XrOv/kVctCnsE6kGnLFwPN5HvIp3m58mJvzqLpAlZjos0Gw
         9t51T1YFheuXqlwv6KwALmGwuLPw0UlyZSaIy+pMxhYC2Peg648QffDLtcfwc0oV4m
         VGxvD9k/vbxKA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rongguang Wei <clementwei90@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: pciehp: Simplify Attention Button logging
Date:   Mon, 22 May 2023 16:40:51 -0500
Message-Id: <20230522214051.619337-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, pressing the Attention Button always logged two lines, the
first from pciehp_ist() and the second from pciehp_handle_button_press():

  Attention button pressed
  Powering on due to button press

Since pciehp_handle_button_press() always logs the more detailed message,
remove the generic "Attention button pressed" message.  Reword the
pciehp_handle_button_press() to be of the form:

  Button press: powering on
  Button press: powering off
  Button press: canceling poweron
  Button press: canceling poweroff
  Button press: ignoring invalid state %#x

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 20 +++++++++-----------
 drivers/pci/hotplug/pciehp_hpc.c  |  5 +----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 32baba1b7f13..ff725104bf2b 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -164,15 +164,13 @@ void pciehp_handle_button_press(struct controller *ctrl)
 	switch (ctrl->state) {
 	case OFF_STATE:
 	case ON_STATE:
-		if (ctrl->state == ON_STATE) {
+		if (ctrl->state == ON_STATE)
 			ctrl->state = BLINKINGOFF_STATE;
-			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
-				  slot_name(ctrl));
-		} else {
+		else
 			ctrl->state = BLINKINGON_STATE;
-			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
-				  slot_name(ctrl));
-		}
+		ctrl_info(ctrl, "Slot(%s): Button press: powering %s\n",
+			  slot_name(ctrl),
+			  ctrl->state == BLINKINGON_STATE ? "on" : "off");
 		/* blink power indicator and turn off attention */
 		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
 				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
@@ -185,7 +183,6 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		 * press the attention again before the 5 sec. limit
 		 * expires to cancel hot-add or hot-remove
 		 */
-		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
@@ -196,11 +193,12 @@ void pciehp_handle_button_press(struct controller *ctrl)
 			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
 					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		}
-		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Slot(%s): Button press: canceling power%s\n",
+			  slot_name(ctrl),
+			  ctrl->state == ON_STATE ? "off" : "on");
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
+		ctrl_err(ctrl, "Slot(%s): Button press: ignoring invalid state %#x\n",
 			 slot_name(ctrl), ctrl->state);
 		break;
 	}
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f8c70115b691..379d2af5c51d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -722,11 +722,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	}
 
 	/* Check Attention Button Pressed */
-	if (events & PCI_EXP_SLTSTA_ABP) {
-		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
-			  slot_name(ctrl));
+	if (events & PCI_EXP_SLTSTA_ABP)
 		pciehp_handle_button_press(ctrl);
-	}
 
 	/* Check Power Fault Detected */
 	if (events & PCI_EXP_SLTSTA_PFD) {
-- 
2.34.1


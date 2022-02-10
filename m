Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF84B199E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 00:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbiBJXiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 18:38:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbiBJXiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 18:38:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5DD5F6B
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 15:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DFB61DAD
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 23:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C03BC004E1;
        Thu, 10 Feb 2022 23:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644536294;
        bh=dWi75G+AT/VEKiWoEqSi5fAaVGUqeCvcnk24/FxGcwk=;
        h=From:To:Cc:Subject:Date:From;
        b=jjj53xYLwRMTQkTMhlX/LqxzBsN/9zsfwdmw8CXqpZ6C6OkANIQfxngKztNYHbmYg
         hSq+9iHWKvjpl9OWimuw3XntlZfNtaFEVUC1XcyzEvx5eBu/Qq6FcVn5MtvwZA0nMd
         68+WQNCk26Hi3G9+XGubnD1NSxbiPkeRF4bubur2aWU9iIDJOfp3aUOtVHVkgYLG2r
         6uOd8BQqp2l/s1rSLkJZMCh2rm/YHPjZcAtNuSVFf83CFf845P8wqbLX+z5F3WeV/2
         Z9nfKKR+yVZmN48BQCpCp7/ofhVU2XiaxzeGHjU2QW5C/0ODAf5B3bez3i8k0d3GQ5
         +LKAAjOsxtmHQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: pciehp: Simplify Command Completion checking
Date:   Thu, 10 Feb 2022 17:38:06 -0600
Message-Id: <20220210233806.663609-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

If a device sets the No Command Completed Support bit in the Slot
Capabilities register (PCIe r6.0, sec 7.5.3.9), it does not generate
software notifications when a command is completed, and software can
write all fields of the Slot Control register without any delays.

Since we only need to wait for command completion on devices that do *not*
set the No Command Completed Support bit, there's no need to even set the
ctrl->cmd_busy bit that tracks when the device is busy handling a command.

Set the ctrl->cmd_busy bit only when we need to wait for a command to
complete.  This shouldn't make much functional difference, but does avoid
an smp_mb() for controllers that set PCI_EXP_SLTCAP_NCCS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1c1ebf3dad43..0ff928693a13 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -114,13 +114,6 @@ static void pcie_wait_cmd(struct controller *ctrl)
 	unsigned long now, timeout;
 	int rc;
 
-	/*
-	 * If the controller does not generate notifications for command
-	 * completions, we never need to wait between writes.
-	 */
-	if (NO_CMD_CMPL(ctrl))
-		return;
-
 	if (!ctrl->cmd_busy)
 		return;
 
@@ -173,8 +166,17 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	slot_ctrl_orig = slot_ctrl;
 	slot_ctrl &= ~mask;
 	slot_ctrl |= (cmd & mask);
-	ctrl->cmd_busy = 1;
-	smp_mb();
+
+	/*
+	 * If controller generates Command Completed events, we must wait
+	 * for it to finish one command before sending another, so we need
+	 * to keep track of when the controller is busy.
+	 */
+	if (!NO_CMD_CMPL(ctrl)) {
+		ctrl->cmd_busy = 1;
+		smp_mb();
+	}
+
 	ctrl->slot_ctrl = slot_ctrl;
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->cmd_started = jiffies;
-- 
2.25.1


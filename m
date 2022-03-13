Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1564D77F5
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiCMTbB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiCMTa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:30:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDD4D626
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 12:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A43EB80BED
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 19:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423BC340E8;
        Sun, 13 Mar 2022 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647199789;
        bh=5O3KYXzBX60H7cr3Po+lUhRk3wfXoGOfIHsQXf/OTnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rr5cRBKvnXRc3qfpcRUq0y9FHpBGhxyQX0bF/e9WCs6nWztOW+rzZDAs+lrSYsysx
         k+IEeXdt/yoFDBgLdTv5GH3y6H8mvN5iTN4QvhUV10P8nxPKTxsw3EMsa7CERnwVt5
         DXu9zQHB+Eoucyg+vfm3gvE/sMT5Invr2MnQcWkMQSp7ksu2YDrgPYk6GC0BQuFQLA
         zJW3qDl5NpIJoOJCIkpcJ+Zx7/SFH9Gs3cYHWZcnxSB/Z1T8kHVV8mIcSETfpP1eX7
         l93Vd347kCtnAIrQ2OgD1H0a98g7cInvnzj6uDnK2SBEkTwZlzxmsEyDYhwJVWDD8e
         Z0Bif0Br8jBMA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/5] PCI: cpqphp: Remove unused assignments
Date:   Sun, 13 Mar 2022 14:29:32 -0500
Message-Id: <20220313192933.434746-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313192933.434746-1-helgaas@kernel.org>
References: <20220313192933.434746-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove variables and assignments that are never used.

Found by Krzysztof Wilczyński <kw@linux.com> using cppcheck, e.g.:

  $ cppcheck --enable=all --force
  unreadVariable drivers/pci/hotplug/cpqphp_core.c:1257 Variable 'rc' is assigned a value that is never used.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/cpqphp_core.c |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c | 22 +++++-----------------
 drivers/pci/hotplug/cpqphp_pci.c  |  2 +-
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index f99a7927e5a8..c94b40e64baf 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -1254,7 +1254,7 @@ static void __exit unload_cpqphpd(void)
 	struct pci_resource *res;
 	struct pci_resource *tres;
 
-	rc = compaq_nvram_store(cpqhp_rom_start);
+	compaq_nvram_store(cpqhp_rom_start);
 
 	ctrl = cpqhp_ctrl_list;
 
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 93fd2a621822..e429ecddc8fe 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -881,7 +881,6 @@ irqreturn_t cpqhp_ctrl_intr(int IRQ, void *data)
 	u8 reset;
 	u16 misc;
 	u32 Diff;
-	u32 temp_dword;
 
 
 	misc = readw(ctrl->hpc_reg + MISC);
@@ -917,7 +916,7 @@ irqreturn_t cpqhp_ctrl_intr(int IRQ, void *data)
 		writel(Diff, ctrl->hpc_reg + INT_INPUT_CLEAR);
 
 		/* Read it back to clear any posted writes */
-		temp_dword = readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
+		readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
 
 		if (!Diff)
 			/* Clear all interrupts */
@@ -1412,7 +1411,6 @@ static u32 board_added(struct pci_func *func, struct controller *ctrl)
 	u32 rc = 0;
 	struct pci_func *new_slot = NULL;
 	struct pci_bus *bus = ctrl->pci_bus;
-	struct slot *p_slot;
 	struct resource_lists res_lists;
 
 	hp_slot = func->device - ctrl->slot_device_offset;
@@ -1459,7 +1457,7 @@ static u32 board_added(struct pci_func *func, struct controller *ctrl)
 	if (rc)
 		return rc;
 
-	p_slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+	cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
 
 	/* turn on board and blink green LED */
 
@@ -1614,7 +1612,6 @@ static u32 remove_board(struct pci_func *func, u32 replace_flag, struct controll
 	u8 device;
 	u8 hp_slot;
 	u8 temp_byte;
-	u32 rc;
 	struct resource_lists res_lists;
 	struct pci_func *temp_func;
 
@@ -1629,7 +1626,7 @@ static u32 remove_board(struct pci_func *func, u32 replace_flag, struct controll
 	/* When we get here, it is safe to change base address registers.
 	 * We will attempt to save the base address register lengths */
 	if (replace_flag || !ctrl->add_support)
-		rc = cpqhp_save_base_addr_length(ctrl, func);
+		cpqhp_save_base_addr_length(ctrl, func);
 	else if (!func->bus_head && !func->mem_head &&
 		 !func->p_mem_head && !func->io_head) {
 		/* Here we check to see if we've saved any of the board's
@@ -1647,7 +1644,7 @@ static u32 remove_board(struct pci_func *func, u32 replace_flag, struct controll
 		}
 
 		if (!skip)
-			rc = cpqhp_save_used_resources(ctrl, func);
+			cpqhp_save_used_resources(ctrl, func);
 	}
 	/* Change status to shutdown */
 	if (func->is_a_board)
@@ -1767,7 +1764,7 @@ void cpqhp_event_stop_thread(void)
 
 static void interrupt_event_handler(struct controller *ctrl)
 {
-	int loop = 0;
+	int loop;
 	int change = 1;
 	struct pci_func *func;
 	u8 hp_slot;
@@ -1885,7 +1882,6 @@ static void interrupt_event_handler(struct controller *ctrl)
 void cpqhp_pushbutton_thread(struct timer_list *t)
 {
 	u8 hp_slot;
-	u8 device;
 	struct pci_func *func;
 	struct slot *p_slot = from_timer(p_slot, t, task_event);
 	struct controller *ctrl = (struct controller *) p_slot->ctrl;
@@ -1893,8 +1889,6 @@ void cpqhp_pushbutton_thread(struct timer_list *t)
 	pushbutton_pending = NULL;
 	hp_slot = p_slot->hp_slot;
 
-	device = p_slot->device;
-
 	if (is_slot_enabled(ctrl, hp_slot)) {
 		p_slot->state = POWEROFF_STATE;
 		/* power Down board */
@@ -1951,15 +1945,12 @@ int cpqhp_process_SI(struct controller *ctrl, struct pci_func *func)
 	u32 tempdword;
 	int rc;
 	struct slot *p_slot;
-	int physical_slot = 0;
 
 	tempdword = 0;
 
 	device = func->device;
 	hp_slot = device - ctrl->slot_device_offset;
 	p_slot = cpqhp_find_slot(ctrl, device);
-	if (p_slot)
-		physical_slot = p_slot->number;
 
 	/* Check to see if the interlock is closed */
 	tempdword = readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
@@ -2043,13 +2034,10 @@ int cpqhp_process_SS(struct controller *ctrl, struct pci_func *func)
 	unsigned int devfn;
 	struct slot *p_slot;
 	struct pci_bus *pci_bus = ctrl->pci_bus;
-	int physical_slot = 0;
 
 	device = func->device;
 	func = cpqhp_slot_find(ctrl->bus, device, index++);
 	p_slot = cpqhp_find_slot(ctrl, device);
-	if (p_slot)
-		physical_slot = p_slot->number;
 
 	/* Make sure there are no video controllers here */
 	while (func && !rc) {
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 9038039ad6db..3b248426a9f4 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -473,7 +473,7 @@ int cpqhp_save_slot_config(struct controller *ctrl, struct pci_func *new_slot)
 	int sub_bus;
 	int max_functions;
 	int function = 0;
-	int cloop = 0;
+	int cloop;
 	int stop_it;
 
 	ID = 0xFFFFFFFF;
-- 
2.25.1


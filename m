Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE884692888
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjBJUkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjBJUks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:40:48 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3E7CC85;
        Fri, 10 Feb 2023 12:40:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 2F9101019263E;
        Fri, 10 Feb 2023 21:40:21 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id F3B32600CA83;
        Fri, 10 Feb 2023 21:40:20 +0100 (CET)
X-Mailbox-Line: From b41dc8c516fbf7216d4593de918f88a503e9b2c5 Mon Sep 17 00:00:00 2001
Message-Id: <b41dc8c516fbf7216d4593de918f88a503e9b2c5.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:05 +0100
Subject: [PATCH v3 05/16] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
probing because pci_doe_submit_task() invokes INIT_WORK() instead of
INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.

All callers of pci_doe_submit_task() allocate the work_struct on the
stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
short-term fix.

The long-term fix implemented by a subsequent commit is to move to a
synchronous API which allocates the work_struct internally in the DOE
library.

Stacktrace for posterity:

WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 pci_doe_submit_task+0x5d/0xd0
 pci_doe_discovery+0xb4/0x100
 pcim_doe_create_mb+0x219/0x290
 cxl_pci_probe+0x192/0x430
 local_pci_probe+0x41/0x80
 pci_device_probe+0xb3/0x220
 really_probe+0xde/0x380
 __driver_probe_device+0x78/0x170
 driver_probe_device+0x1f/0x90
 __driver_attach_async_helper+0x5c/0xe0
 async_run_entry_fn+0x30/0x130
 process_one_work+0x294/0x5b0

Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
Reported-by: Gregory Price <gregory.price@memverge.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
Cc: stable@vger.kernel.org # v6.0+
---
 Changes v2 -> v3:
 * Explain in commit message what the long-term fix implemented by
   a subsequent commit is (Jonathan)

 drivers/pci/doe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 69efa9a250b9..c20ca62a8c9d 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -523,6 +523,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
  * task->complete will be called when the state machine is done processing this
  * task.
  *
+ * @task must be allocated on the stack.
+ *
  * Excess data will be discarded.
  *
  * RETURNS: 0 when task has been successfully queued, -ERRNO on error
@@ -544,7 +546,7 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 		return -EIO;
 
 	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
+	INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);
 	queue_work(doe_mb->work_queue, &task->work);
 	return 0;
 }
-- 
2.39.1


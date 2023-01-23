Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110E7677926
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAWK17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAWK17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:27:59 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 02:27:57 PST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6B126E8;
        Mon, 23 Jan 2023 02:27:56 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 64FF8101E6B03;
        Mon, 23 Jan 2023 11:21:31 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 27548600D2E1;
        Mon, 23 Jan 2023 11:21:31 +0100 (CET)
X-Mailbox-Line: From cc4b61809e2520d835cf3d4f62e7d5ed00a9d031 Mon Sep 17 00:00:00 2001
Message-Id: <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
In-Reply-To: <cover.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 23 Jan 2023 11:11:00 +0100
Subject: [PATCH v2 01/10] PCI/DOE: Silence WARN splat with
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
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.0+
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Changes v1 -> v2:
  * Add note in kernel-doc of pci_doe_submit_task() that pci_doe_task must
    be allocated on the stack (Jonathan)

 drivers/pci/doe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 66d9ab288646..12a6752351bf 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -520,6 +520,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
  * task->complete will be called when the state machine is done processing this
  * task.
  *
+ * @task must be allocated on the stack.
+ *
  * Excess data will be discarded.
  *
  * RETURNS: 0 when task has been successfully queued, -ERRNO on error
@@ -541,7 +543,7 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 		return -EIO;
 
 	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
+	INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);
 	queue_work(doe_mb->work_queue, &task->work);
 	return 0;
 }
-- 
2.39.1


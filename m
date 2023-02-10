Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF246928C0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjBJUwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjBJUwA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:52:00 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2012FCCD;
        Fri, 10 Feb 2023 12:51:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 7489C1019263E;
        Fri, 10 Feb 2023 21:51:57 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 44BB1600CA83;
        Fri, 10 Feb 2023 21:51:57 +0100 (CET)
X-Mailbox-Line: From 7b5cf1e007ba1638ff2512f221e8a7fd72ed8245 Mon Sep 17 00:00:00 2001
Message-Id: <7b5cf1e007ba1638ff2512f221e8a7fd72ed8245.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:10 +0100
Subject: [PATCH v3 10/16] PCI/DOE: Deduplicate mailbox flushing
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

When a DOE mailbox is torn down, its workqueue is flushed once in
pci_doe_flush_mb() through a call to flush_workqueue() and subsequently
flushed once more in pci_doe_destroy_workqueue() through a call to
destroy_workqueue().

Deduplicate by dropping flush_workqueue() from pci_doe_flush_mb().

Rename pci_doe_flush_mb() to pci_doe_cancel_tasks() to more aptly
describe what it now does.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Changes v2 -> v3:
 * Newly added patch in v3

 drivers/pci/doe.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index afb53bc1b4aa..291cd7a46a39 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -429,7 +429,7 @@ static void pci_doe_destroy_workqueue(void *mb)
 	destroy_workqueue(doe_mb->work_queue);
 }
 
-static void pci_doe_flush_mb(void *mb)
+static void pci_doe_cancel_tasks(void *mb)
 {
 	struct pci_doe_mb *doe_mb = mb;
 
@@ -439,9 +439,6 @@ static void pci_doe_flush_mb(void *mb)
 	/* Cancel an in progress work item, if necessary */
 	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
 	wake_up(&doe_mb->wq);
-
-	/* Flush all work items */
-	flush_workqueue(doe_mb->work_queue);
 }
 
 /**
@@ -498,9 +495,9 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
 
 	/*
 	 * The state machine and the mailbox should be in sync now;
-	 * Set up mailbox flush prior to using the mailbox to query protocols.
+	 * Set up cancel tasks prior to using the mailbox to query protocols.
 	 */
-	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
+	rc = devm_add_action_or_reset(dev, pci_doe_cancel_tasks, doe_mb);
 	if (rc)
 		return ERR_PTR(rc);
 
-- 
2.39.1


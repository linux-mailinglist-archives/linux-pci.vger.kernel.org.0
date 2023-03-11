Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3F6B5D2F
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCKPIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCKPI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:08:29 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F97222E0;
        Sat, 11 Mar 2023 07:08:23 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 80CB310189ADD;
        Sat, 11 Mar 2023 16:08:22 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 570FB600C543;
        Sat, 11 Mar 2023 16:08:22 +0100 (CET)
X-Mailbox-Line: From 1f009f60b326d1c6d776641d4b20aff27de0c234 Mon Sep 17 00:00:00 2001
Message-Id: <1f009f60b326d1c6d776641d4b20aff27de0c234.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:10 +0100
Subject: [PATCH v4 10/17] PCI/DOE: Deduplicate mailbox flushing
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
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
Reviewed-by: Ming Li <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/doe.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index dfdec73f6abc..d9f3676bce29 100644
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410767792B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjAWK3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjAWK3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:29:37 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED91EFF8;
        Mon, 23 Jan 2023 02:29:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 932B310189E10;
        Mon, 23 Jan 2023 11:29:33 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 6CAA4600D2E1;
        Mon, 23 Jan 2023 11:29:33 +0100 (CET)
X-Mailbox-Line: From 4b510b0979704c587e531cd7d814c1e5361ecbea Mon Sep 17 00:00:00 2001
Message-Id: <4b510b0979704c587e531cd7d814c1e5361ecbea.1674468099.git.lukas@wunner.de>
In-Reply-To: <cover.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 23 Jan 2023 11:12:00 +0100
Subject: [PATCH v2 02/10] PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After a pci_doe_task completes, its work_struct needs to be destroyed
to avoid a memory leak with CONFIG_DEBUG_OBJECTS=y.

Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.0+
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/doe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 12a6752351bf..7451b5732044 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -224,6 +224,7 @@ static void signal_task_complete(struct pci_doe_task *task, int rv)
 {
 	task->rv = rv;
 	task->complete(task);
+	destroy_work_on_stack(&task->work);
 }
 
 static void signal_task_abort(struct pci_doe_task *task, int rv)
-- 
2.39.1


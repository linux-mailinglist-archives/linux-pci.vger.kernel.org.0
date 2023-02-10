Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAF69288A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjBJUml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjBJUmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:42:40 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39337070A;
        Fri, 10 Feb 2023 12:42:39 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 27C69102F587E;
        Fri, 10 Feb 2023 21:42:38 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id CE9AA600CA83;
        Fri, 10 Feb 2023 21:42:37 +0100 (CET)
X-Mailbox-Line: From 53bd8006bae1385905eec702c97f66695363c527 Mon Sep 17 00:00:00 2001
Message-Id: <53bd8006bae1385905eec702c97f66695363c527.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:06 +0100
Subject: [PATCH v3 06/16] PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: stable@vger.kernel.org # v6.0+
---
 drivers/pci/doe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index c20ca62a8c9d..6cf0600a38aa 100644
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1AB4F005E
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiDBKOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Apr 2022 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354251AbiDBKOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Apr 2022 06:14:06 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9513A1E9;
        Sat,  2 Apr 2022 03:12:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KVtBP5PWTz9sSZ;
        Sat,  2 Apr 2022 12:12:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oBVEswwalOhr; Sat,  2 Apr 2022 12:12:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KVtBP4Yxhz9sSY;
        Sat,  2 Apr 2022 12:12:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AA768B76D;
        Sat,  2 Apr 2022 12:12:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y39pw8naxh-1; Sat,  2 Apr 2022 12:12:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.136])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4008E8B768;
        Sat,  2 Apr 2022 12:12:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 232AC21k684504
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 2 Apr 2022 12:12:02 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 232AC1vb684503;
        Sat, 2 Apr 2022 12:12:01 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] pci: hotplug: Prepare cleanup of powerpc's asm/prom.h
Date:   Sat,  2 Apr 2022 12:11:56 +0200
Message-Id: <79201f5fae8d003164ac36ed3be7789db1bc5ab4.1648833421.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648894316; l=2747; s=20211009; h=from:subject:message-id; bh=riyiPWE4HTVvKGtVKlLpPUMpYnTwPNAnyQF6g59mDYM=; b=rQ2g85F150Av16A7yWWJ//JEv+Wvgu4E5UOvoFCjbONcbjOGHDdnXryAiFyQiyfcVJDjWnhRGzvL s5el7hyjBJWTa3+/9RLXTojkDcHbdTvkk6BPDdoXD5kh8F8EAIJm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

powerpc's asm/prom.h brings some headers that it doesn't
need itself.

In order to clean it up, first add missing headers in
users of asm/prom.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/pci/hotplug/pnv_php.c       | 1 +
 drivers/pci/hotplug/rpadlpar_core.c | 1 +
 drivers/pci/hotplug/rpaphp_core.c   | 2 ++
 drivers/pci/hotplug/rpaphp_pci.c    | 1 +
 drivers/pci/hotplug/rpaphp_slot.c   | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index f4c2e6e01be0..881d420637bf 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/of_fdt.h>
 
 #include <asm/opal.h>
 #include <asm/pnv-pci.h>
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e6991ff67526..980bb3afd092 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -15,6 +15,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 9887c9de08c3..491986197c47 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/smp.h>
@@ -20,6 +21,7 @@
 #include <asm/eeh.h>       /* for eeh_add_device() */
 #include <asm/rtas.h>		/* rtas_call */
 #include <asm/pci-bridge.h>	/* for pci_controller */
+#include <asm/prom.h>
 #include "../pci.h"		/* for pci_add_new_bus */
 				/* and pci_do_scan_bus */
 #include "rpaphp.h"
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index c380bdacd146..630f77057c23 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -8,6 +8,7 @@
  * Send feedback to <lxie@us.ibm.com>
  *
  */
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 93b4a945c55d..779eab12e981 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sysfs.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-- 
2.35.1


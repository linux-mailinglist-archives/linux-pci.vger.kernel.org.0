Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC57318B7A
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEIOPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfEIOPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:15 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7667E2173B;
        Thu,  9 May 2019 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411314;
        bh=bo7d7nw9IyqAsNFvZFQhFiqb7L+HG9kdqi7oAcH8DbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3hl8UUlKpePDFEhho1NWoIHP8WAW4g5/qHHQ2vtI5WCI1WcgR31fZcf9drkG1teL
         3gx+GLUE75oeJ+tlN08qUNmbuXoMWw5b9EAyk5LfD1YIItVmD6navhnsrVsEgBrnoK
         eRppsvP4hVO7SiJMyGRfukd0c2wIrRaVT1g6fpjs=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 06/10] PCI: pciehp: Replace pciehp_debug module param with dyndbg
Date:   Thu,  9 May 2019 09:14:52 -0500
Message-Id: <20190509141456.223614-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Previously pciehp debug messages were enabled by the pciehp_debug module
parameter, e.g., by booting with this kernel command line option:

  pciehp.pciehp_debug=1

Convert this mechanism to use the generic dynamic debug (dyndbg) feature.
After this commit, pciehp debug messages are enabled by building the kernel
with CONFIG_DYNAMIC_DEBUG=y and booting with this command line option:

  dyndbg="file pciehp* +p"

The dyndbg facility is much more flexible: messages can be enabled at boot-
or run-time based on the file name, function name, line number, message
test, etc.  See Documentation/admin-guide/dynamic-debug-howto.rst for more
details.

Link: https://lore.kernel.org/lkml/20190503035946.23608-8-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
[bhelgaas: commit log, comment, remove pciehp_debug parameter]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      | 16 ++++++----------
 drivers/pci/hotplug/pciehp_core.c |  3 ---
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 506e1d923a1f..af5d9f92e6d5 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -29,13 +29,13 @@
 
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
-extern bool pciehp_debug;
 
+/*
+ * Set CONFIG_DYNAMIC_DEBUG=y and boot with 'dyndbg="file pciehp* +p"' to
+ * enable debug messages.
+ */
 #define dbg(format, arg...)						\
-do {									\
-	if (pciehp_debug)						\
-		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
-} while (0)
+	pr_debug("%s: " format, MY_NAME, ## arg);
 #define err(format, arg...)						\
 	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
 #define info(format, arg...)						\
@@ -44,11 +44,7 @@ do {									\
 	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
 
 #define ctrl_dbg(ctrl, format, arg...)					\
-	do {								\
-		if (pciehp_debug)					\
-			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
-					format, ## arg);		\
-	} while (0)
+	dev_dbg(&ctrl->pcie->device, format, ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
 	dev_err(&ctrl->pcie->device, format, ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index fc5366b50e95..6ff204c435bf 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -27,7 +27,6 @@
 #include "../pci.h"
 
 /* Global variables */
-bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
 
@@ -35,10 +34,8 @@ int pciehp_poll_time;
  * not really modular, but the easiest way to keep compat with existing
  * bootargs behaviour is to continue using module_param here.
  */
-module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
-MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
 
-- 
2.21.0.1020.gf2820cf01a-goog


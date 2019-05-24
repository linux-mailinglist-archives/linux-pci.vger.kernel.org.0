Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D698C29FA0
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391826AbfEXUQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 16:16:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33756 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391817AbfEXUQQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 16:16:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hUGbu-00032O-CE; Fri, 24 May 2019 14:16:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hUGbu-00026S-7R; Fri, 24 May 2019 14:16:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 24 May 2019 14:16:08 -0600
Message-Id: <20190524201610.8039-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524201610.8039-1-logang@deltatee.com>
References: <20190524201610.8039-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH 1/3] PCI: Clean up resource_alignment parameter to not require static buffer
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clean up the 'resource_alignment' parameter code to use kstrdup
in the initcall routine instead of a static buffer that wastes memory
regardless of whether the feature is used.  This allows us to drop
'COMMAND_LINE_SIZE' bytes (typically 256-4096 depending on architecture)
of static data.

This is similar to what has been done for the 'disable_acs_redir'
parameter.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 766f5779db92..bd7cdcfeb094 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5896,8 +5896,7 @@ resource_size_t __weak pcibios_default_alignment(void)
 	return 0;
 }
 
-#define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
-static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
+static char *resource_alignment_param;
 static DEFINE_SPINLOCK(resource_alignment_lock);
 
 /**
@@ -5918,7 +5917,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
-	if (!*p && !align)
+	if (!p || !*p)
 		goto out;
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
 		align = 0;
@@ -6084,21 +6083,25 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 static ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
 {
-	if (count > RESOURCE_ALIGNMENT_PARAM_SIZE - 1)
-		count = RESOURCE_ALIGNMENT_PARAM_SIZE - 1;
 	spin_lock(&resource_alignment_lock);
-	strncpy(resource_alignment_param, buf, count);
-	resource_alignment_param[count] = '\0';
+
+	kfree(resource_alignment_param);
+	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
+
 	spin_unlock(&resource_alignment_lock);
-	return count;
+
+	return resource_alignment_param ? count : -ENOMEM;
 }
 
 static ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
 {
-	size_t count;
+	size_t count = 0;
+
 	spin_lock(&resource_alignment_lock);
-	count = snprintf(buf, size, "%s", resource_alignment_param);
+	if (resource_alignment_param)
+		count = snprintf(buf, size, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
+
 	return count;
 }
 
@@ -6238,8 +6241,7 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
 				pci_cardbus_mem_size = memparse(str + 10, &str);
 			} else if (!strncmp(str, "resource_alignment=", 19)) {
-				pci_set_resource_alignment_param(str + 19,
-							strlen(str + 19));
+				resource_alignment_param = str + 19;
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
@@ -6275,15 +6277,18 @@ static int __init pci_setup(char *str)
 early_param("pci", pci_setup);
 
 /*
- * 'disable_acs_redir_param' is initialized in pci_setup(), above, to point
- * to data in the __initdata section which will be freed after the init
- * sequence is complete. We can't allocate memory in pci_setup() because some
- * architectures do not have any memory allocation service available during
- * an early_param() call. So we allocate memory and copy the variable here
- * before the init section is freed.
+ * 'resource_alignment_param' and 'disable_acs_redir_param' are initialized
+ * in pci_setup(), above, to point to data in the __initdata section which
+ * will be freed after the init sequence is complete. We can't allocate memory
+ * in pci_setup() because some architectures do not have any memory allocation
+ * service available during an early_param() call. So we allocate memory and
+ * copy the variable here before the init section is freed.
+ *
  */
 static int __init pci_realloc_setup_params(void)
 {
+	resource_alignment_param = kstrdup(resource_alignment_param,
+					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
 
 	return 0;
-- 
2.20.1


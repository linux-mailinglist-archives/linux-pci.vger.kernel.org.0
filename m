Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A56F075D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244070AbjD0O3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbjD0O3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 10:29:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E521FE6;
        Thu, 27 Apr 2023 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605754; x=1714141754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJflgAPzg8RDVjQuBtT2lckjqglKouKkXFWqrky4874=;
  b=lNSX9/k5JwXMkTeJ69tJQheMy9gG3OAvcpf6TySB/PAWGke1awr9fIBG
   MSmS6JcNiyCxaL6eHBxyZIAkkoLU1Ifws2yhX2X/ji7LVWLluDgD9SQGV
   5DLldgAc6jeM7mOM2I8BsC1uJcjnwj3CN+/oxbe/ZyAWXedtrFUY+irjM
   4BN4Ui4EcmTWdpXMJZ/wCwpX7NklNt944XyEagOCIJxBcXPI9gahPZWgM
   74rDtdyxTJ0oMObAJh2XaYBmM375EIxvSAMI8faUuWJvf2bh+EfGByhyu
   M0xNl7kJe2fRUrX7KUEe/ULNkqnt0qAl0WPNmmPe2kSk4dlDTBqet//70
   A==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607878"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Apr 2023 16:29:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Apr 2023 16:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605748; x=1714141748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJflgAPzg8RDVjQuBtT2lckjqglKouKkXFWqrky4874=;
  b=az0+pLIQtDltHklgOlpPW/vYzuzilM5OvJaA8lhubHdk2XIDm7hSfLFR
   YEYFOifqAoVpR44WpCzIuduLURIqSqMqVsaZq8WmngcguuhkSqW1shGUK
   bVrUNq91XnGGtFZY800VnNbee+JYG7nVwKsgNd7XnBMnKlEfHgZrH9njk
   yGp7q56irFhF3R3TxGiKBv2RnqqNXAnRbKAMa3XbL2n8Q0dC7a8uNTaC8
   XWE1AJkISc2mZZZsrCWJhSx/7/zAFzFUtfeN74RCfkfJoUErwm0s81RmU
   wd9xIvhD0yiIvWo1T14QsWCMz5gKZpk1ImAtPUi6Y/esyqKi8LIIgF/0z
   A==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607877"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 67CE1280073;
        Thu, 27 Apr 2023 16:29:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/3] PCI/sysfs: create private functions for pci_create_legacy_files/pci_create_sysfs_dev_files
Date:   Thu, 27 Apr 2023 16:29:00 +0200
Message-Id: <20230427142901.3570536-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427142901.3570536-1-alexander.stein@ew.tq-group.com>
References: <20230427142901.3570536-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The only difference is they don't have the check against sysfs_initialized.
This is a preparation for the sysfs init race condition fix.
No functional change intended.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/pci-sysfs.c | 44 ++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 289c1c17b41f..7d4733773633 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -938,24 +938,10 @@ void __weak pci_adjust_legacy_attr(struct pci_bus *b,
 {
 }
 
-/**
- * pci_create_legacy_files - create legacy I/O port and memory files
- * @b: bus to create files under
- *
- * Some platforms allow access to legacy I/O port and ISA memory space on
- * a per-bus basis.  This routine creates the files and ties them into
- * their associated read, write and mmap files from pci-sysfs.c
- *
- * On error unwind, but don't propagate the error to the caller
- * as it is ok to set up the PCI bus without these files.
- */
-void pci_create_legacy_files(struct pci_bus *b)
+static void __pci_create_legacy_files(struct pci_bus *b)
 {
 	int error;
 
-	if (!sysfs_initialized)
-		return;
-
 	b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
 			       GFP_ATOMIC);
 	if (!b->legacy_io)
@@ -998,6 +984,25 @@ void pci_create_legacy_files(struct pci_bus *b)
 	dev_warn(&b->dev, "could not create legacy I/O port and ISA memory resources in sysfs\n");
 }
 
+/**
+ * pci_create_legacy_files - create legacy I/O port and memory files
+ * @b: bus to create files under
+ *
+ * Some platforms allow access to legacy I/O port and ISA memory space on
+ * a per-bus basis.  This routine creates the files and ties them into
+ * their associated read, write and mmap files from pci-sysfs.c
+ *
+ * On error unwind, but don't propagate the error to the caller
+ * as it is ok to set up the PCI bus without these files.
+ */
+void pci_create_legacy_files(struct pci_bus *b)
+{
+	if (!sysfs_initialized)
+		return;
+
+	__pci_create_legacy_files(b);
+}
+
 void pci_remove_legacy_files(struct pci_bus *b)
 {
 	if (b->legacy_io) {
@@ -1006,6 +1011,8 @@ void pci_remove_legacy_files(struct pci_bus *b)
 		kfree(b->legacy_io); /* both are allocated here */
 	}
 }
+#else
+static void __pci_create_legacy_files(struct pci_bus *b) {}
 #endif /* HAVE_PCI_LEGACY */
 
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
@@ -1492,12 +1499,17 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
+int __must_check __pci_create_sysfs_dev_files(struct pci_dev *pdev)
+{
+	return pci_create_resource_files(pdev);
+}
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	return pci_create_resource_files(pdev);
+	return __pci_create_sysfs_dev_files(pdev);
 }
 
 /**
-- 
2.34.1


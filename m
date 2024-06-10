Return-Path: <linux-pci+bounces-8511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFF901CD4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9E81C20E9B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F158210;
	Mon, 10 Jun 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DR36WAKj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9B57CA2;
	Mon, 10 Jun 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007658; cv=none; b=gTpXkPwu5cf9rScKmrNG0KpwdmSVMENlby9V+yImG5oh9TXcBIPsHHS1JBTaVQmSRCxsSudTUIs3ULbW8bgBqanjXpEntdooivJnwE9Yne8GzPGn4qP2K3wwCE6QIgT1tcK8Vkg/shNHvjANL1QcTiEetxHAHNVvwoBHEeNpdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007658; c=relaxed/simple;
	bh=CAiZ3SVovdoincgpGx3yjmnj9eAa3sknXt7flqN/34E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r32Te9YyBNpWFKv4lVQK5vCZsCFZRYLbMEzSe2V9UWvnH0PvYRh+dhMPVWL9e3gIpHqEts+Ny48botQgTsRvTGHynlZzlYmCZE6TIFUbeUrVwPr6FugHnsFbQv7q0Di3AszQffQKvQhI7xGaG271wa0L08VLXYkmmebVoWgWN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DR36WAKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB34C4AF1C;
	Mon, 10 Jun 2024 08:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718007657;
	bh=CAiZ3SVovdoincgpGx3yjmnj9eAa3sknXt7flqN/34E=;
	h=From:To:Cc:Subject:Date:From;
	b=DR36WAKj0OoO6zEjepBa0BCBBBnZa9iPb1PzgKYmT/DIDimlQqYNgiUkMox0KCWe7
	 /TfRZFyLj7mX+lq/kT8LlBIeavN+C9q5v0qjAxKhN3mUBJn61PbXBDcryrpkVbVD/B
	 +ONZ22+sYH9qZG6wQTk2sqjukqF1n1AnEd/lU5QM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev
Subject: [PATCH] PCI: switchtec: make switchtec_class constant
Date: Mon, 10 Jun 2024 10:20:53 +0200
Message-ID: <2024061053-online-unwound-b173@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 103
X-Developer-Signature: v=1; a=openpgp-sha256; l=3586; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=CAiZ3SVovdoincgpGx3yjmnj9eAa3sknXt7flqN/34E=; b=owGbwMvMwCRo6H6F97bub03G02pJDGlp21P5bQ5tWScq+3jdjYSCa743+6ZJTljT0FOq3MI34 dPvhBM8HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRsByGBcdMJ5r9NunUs9Zm WnDUfq8Wg3pdIsOCjVdkZ1rY380Oqso4+/bQmy+vUjxuAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: ntb@lists.linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  2 +-
 drivers/pci/switch/switchtec.c         | 16 ++++++++--------
 include/linux/switchtec.h              |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d6bbcc7b5b90..31946387badf 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1565,7 +1565,7 @@ static struct class_interface switchtec_interface  = {
 
 static int __init switchtec_ntb_init(void)
 {
-	switchtec_interface.class = switchtec_class;
+	switchtec_interface.class = &switchtec_class;
 	return class_interface_register(&switchtec_interface);
 }
 module_init(switchtec_ntb_init);
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5a4adf6c04cf..c7e1089ffdaf 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -37,7 +37,9 @@ MODULE_PARM_DESC(nirqs, "number of interrupts to allocate (more may be useful fo
 static dev_t switchtec_devt;
 static DEFINE_IDA(switchtec_minor_ida);
 
-struct class *switchtec_class;
+const struct class switchtec_class = {
+	.name = "switchtec",
+};
 EXPORT_SYMBOL_GPL(switchtec_class);
 
 enum mrpc_state {
@@ -1363,7 +1365,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 
 	dev = &stdev->dev;
 	device_initialize(dev);
-	dev->class = switchtec_class;
+	dev->class = &switchtec_class;
 	dev->parent = &pdev->dev;
 	dev->groups = switchtec_device_groups;
 	dev->release = stdev_release;
@@ -1851,11 +1853,9 @@ static int __init switchtec_init(void)
 	if (rc)
 		return rc;
 
-	switchtec_class = class_create("switchtec");
-	if (IS_ERR(switchtec_class)) {
-		rc = PTR_ERR(switchtec_class);
+	rc = class_register(&switchtec_class);
+	if (rc)
 		goto err_create_class;
-	}
 
 	rc = pci_register_driver(&switchtec_pci_driver);
 	if (rc)
@@ -1866,7 +1866,7 @@ static int __init switchtec_init(void)
 	return 0;
 
 err_pci_register:
-	class_destroy(switchtec_class);
+	class_unregister(&switchtec_class);
 
 err_create_class:
 	unregister_chrdev_region(switchtec_devt, max_devices);
@@ -1878,7 +1878,7 @@ module_init(switchtec_init);
 static void __exit switchtec_exit(void)
 {
 	pci_unregister_driver(&switchtec_pci_driver);
-	class_destroy(switchtec_class);
+	class_unregister(&switchtec_class);
 	unregister_chrdev_region(switchtec_devt, max_devices);
 	ida_destroy(&switchtec_minor_ida);
 
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 8d8fac1626bd..cdb58d61c152 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -521,6 +521,6 @@ static inline struct switchtec_dev *to_stdev(struct device *dev)
 	return container_of(dev, struct switchtec_dev, dev);
 }
 
-extern struct class *switchtec_class;
+extern const struct class switchtec_class;
 
 #endif
-- 
2.45.2



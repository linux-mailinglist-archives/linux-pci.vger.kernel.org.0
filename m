Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFD303178
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbhAZBZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 20:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731498AbhAYTnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 14:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611603708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UT03s/I31YRDKMUtBXKP7GcN0aALUMC3UXcsyLIGnNY=;
        b=jN/+Wb/y2lJkq3fcmNqFlTOvldyxPRaJM1Kq+oT9ASZLvuvVTyeTdC6n7GrAa4ELdjqvhM
        oz70nRH3+XJR3vOKBLugzRct/UC0OtusI+MV7kohwD79S5OWmyTQe6hrncO3NAVFf9ZRa9
        vMUTsXxa83Aljcym0217iCoFJSk+qeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-RgJM_Yl-MkWcrAT5tmL0ww-1; Mon, 25 Jan 2021 14:41:46 -0500
X-MC-Unique: RgJM_Yl-MkWcrAT5tmL0ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AD511015945;
        Mon, 25 Jan 2021 19:41:45 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D87EE5D9DB;
        Mon, 25 Jan 2021 19:41:44 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org
Subject: [PATCH] pci-driver: Add driver load messages
Date:   Mon, 25 Jan 2021 14:41:38 -0500
Message-Id: <20210125194138.1103155-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two situations where driver load messages are helpful.

1) Some drivers silently load on devices and debugging driver or system
failures in these cases is difficult.  While some drivers (networking
for example) may not completely initialize when the PCI driver probe() function
has returned, it is still useful to have some idea of driver completion.

2) Storage and Network device vendors have relatively short lives for
some of their hardware.  Some devices may continue to function but are
problematic due to out-of-date firmware or other issues.  Maintaining
a database of the hardware is out-of-the-question in the kernel as it would
require constant updating.  Outputting a message in the log would allow
different OSes to determine if the problem hardware was truly supported or not.

Add optional driver load messages from the PCI core that indicates which
driver was loaded, on which slot, and on which device.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Myron Stowe <mstowe@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 drivers/pci/pci-driver.c                        | 14 +++++++++++++-
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 23f209c8c19a..32ecee6a4ef0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3793,6 +3793,8 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		driver_load_messages
+				Output driver load status messages.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8b587fc97f7b..35d5b6973578 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -23,6 +23,8 @@
 #include "pci.h"
 #include "pcie/portdrv.h"
 
+bool driver_load_messages;
+
 struct pci_dynid {
 	struct list_head node;
 	struct pci_device_id id;
@@ -305,10 +307,20 @@ static long local_pci_probe(void *_ddi)
 	 */
 	pm_runtime_get_sync(dev);
 	pci_dev->driver = pci_drv;
+	if (driver_load_messages)
+		pci_info(pci_dev, "loading on device [%0x:%0x]\n",
+			 pci_dev->vendor, pci_dev->device);
 	rc = pci_drv->probe(pci_dev, ddi->id);
-	if (!rc)
+	if (!rc) {
+		if (driver_load_messages)
+			pci_info(pci_dev, "loaded on device [%0x:%0x]\n",
+				 pci_dev->vendor, pci_dev->device);
 		return rc;
+	}
 	if (rc < 0) {
+		if (driver_load_messages)
+			pci_info(pci_dev, "failed (%d) on device [%0x:%0x]\n",
+				 rc, pci_dev->vendor, pci_dev->device);
 		pci_dev->driver = NULL;
 		pm_runtime_put_sync(dev);
 		return rc;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..c64b3b6e1e8d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6547,6 +6547,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "driver_load_messages", 24)) {
+				driver_load_messages = true;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9aa1f4..db1218e188ac 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -690,4 +690,5 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 extern const struct attribute_group aspm_ctrl_attr_group;
 #endif
 
+extern bool driver_load_messages;
 #endif /* DRIVERS_PCI_H */
-- 
2.29.2


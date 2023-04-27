Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA46F075F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbjD0O3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbjD0O3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 10:29:16 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30030D6;
        Thu, 27 Apr 2023 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605754; x=1714141754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCtpg2kzjPTTO6+C2f0a+KHi0QEOneW24SbJ2emNudM=;
  b=KuRJGzx8lV/sjwNP8LiRfyjcPYIr/uzas9q7X5CR1JLofBbzBeht2++J
   dWTwnz05ekqzDhTnbBuSZjciM9HdogMDwhebauSSGYwr7CoYj/+xs+EwU
   vAmunHg151Xw19B8ekWqdWISH8fRus9yC0BBHNAZ6gWgWlawHOMh9+wou
   Zvx4kohor+ahPXXrshk4uhHqizqsvq/3LctRlS//CKqW3Yys22SQ54v0g
   X4hYcXrjtO8V/0cfEIkILvUQCe7DjWoS0zY/qDqRhGPJxLbNaAf86Q2Yq
   x8DRawIcIO4bIe0LdjRWCD5beb8JK2kUktzWXM3fqccy6/nXfCmJZTntN
   w==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607880"
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
  bh=tCtpg2kzjPTTO6+C2f0a+KHi0QEOneW24SbJ2emNudM=;
  b=L/YQ/vITar0NtqrbWXl/dzAKUrkYB78hr85SoNiuvkk2LgBeuBaxjq3O
   pHNBG/UPBA9e8J04M99Bs7W5MlpYEsSRbG8ULCnbGJzbrIGikXukmOuxn
   PP9mwMOAK42eLIvERYXunEQSUmUkyC+2zfc/WvR/34Yj1Ij6HfYNZ4WcV
   xTrRtb7ry/xPoOb1FeNX/eSKgI0yqMSUqUgphI9qUkhHzzSIhwDIXokM+
   HdH+JEHvMZ8LxjAlN/OanFNsvnEEpVUpfXEAucSY+32nZXF3BOX9kB6zW
   XyfrVpykrcgsgVXO45fycQS405a5/4PsOxne+Hem5lgcBnZjQ/h9+fGfO
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607879"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8F0A1280056;
        Thu, 27 Apr 2023 16:29:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3/3] PCI/sysfs: Fix sysfs init race condition
Date:   Thu, 27 Apr 2023 16:29:01 +0200
Message-Id: <20230427142901.3570536-4-alexander.stein@ew.tq-group.com>
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

sysfs attribute files for PCIe devices (pci_create_sysfs_dev_files) can be
created by two paths:
1. pci_sysfs_init()
2. pci_bus_add_device() (drivers/pci/bus.c)

There is a race during startup where an asynchronous PCIe host probe races
against the pci_sysfs_init() late_initcall. In this case the PCIe devices
are already added to the bus, for_each_pci_dev() will see them, but
pci_bus_add_device() has not yet finished, so both code paths try to add
the sysfs attributes.

Fix this by waiting on a workqueue until sysfs has been initialized.
pci_sysfs_init() needs the internal function without the check that
sysfs_initialized has been set to 1.
__pci_create_sysfs_dev_files still needs to remove resource files,
which might have been created during pci_sysfs_init initcall.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/pci-sysfs.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7d4733773633..3067d55f981c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -29,9 +29,11 @@
 #include <linux/stat.h>
 #include <linux/topology.h>
 #include <linux/vgaarb.h>
+#include <linux/wait.h>
 #include "pci.h"
 
 static int sysfs_initialized;	/* = 0 */
+static DECLARE_WAIT_QUEUE_HEAD(sysfs_wq);
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -997,8 +999,7 @@ static void __pci_create_legacy_files(struct pci_bus *b)
  */
 void pci_create_legacy_files(struct pci_bus *b)
 {
-	if (!sysfs_initialized)
-		return;
+	wait_event(sysfs_wq, sysfs_initialized);
 
 	__pci_create_legacy_files(b);
 }
@@ -1501,13 +1502,18 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 
 int __must_check __pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
+	/*
+	 * sysfs attributes might already be created by pci_sysfs_init(),
+	 * delete them here just in case
+	 */
+	pci_remove_resource_files(pdev);
 	return pci_create_resource_files(pdev);
 }
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
-	if (!sysfs_initialized)
-		return -EACCES;
+	/* Wait until sysfs has been initialized */
+	wait_event(sysfs_wq, sysfs_initialized);
 
 	return __pci_create_sysfs_dev_files(pdev);
 }
@@ -1520,8 +1526,8 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
-	if (!sysfs_initialized)
-		return;
+	/* Wait until sysfs has been initialized */
+	wait_event(sysfs_wq, sysfs_initialized);
 
 	pci_remove_resource_files(pdev);
 }
@@ -1532,9 +1538,8 @@ static int __init pci_sysfs_init(void)
 	struct pci_bus *pbus = NULL;
 	int retval;
 
-	sysfs_initialized = 1;
 	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
+		retval = __pci_create_sysfs_dev_files(pdev);
 		if (retval) {
 			pci_dev_put(pdev);
 			return retval;
@@ -1542,7 +1547,9 @@ static int __init pci_sysfs_init(void)
 	}
 
 	while ((pbus = pci_find_next_bus(pbus)))
-		pci_create_legacy_files(pbus);
+		__pci_create_legacy_files(pbus);
+	sysfs_initialized = 1;
+	wake_up_all(&sysfs_wq);
 
 	return 0;
 }
-- 
2.34.1


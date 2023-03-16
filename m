Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47BC6BCCCE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCPKbJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCPKbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 06:31:05 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0451C7E1;
        Thu, 16 Mar 2023 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678962660; x=1710498660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8NFJUu1stU1ofnKZ91BXooX1J2ZEc+mm94bfu/ZhJgw=;
  b=aKfOERuRuVYgJWCf8YxPIGHUf4WT2yj+O6vK3O8kI0pKk3MoPywWX2H/
   v/cTnDpD/XGAy4D8m17HEspLajfvd3ORsBIFv0O9rRRP6kZ72Mmn6zM7q
   4pHwhCxuvMdqGavsyRd7eFvQeYsOWeinS3Xp/FA0pg2RzGkUS0k3bWag5
   /aP7cHWy7rRhEG1Kcifm6+3ziJ+35MZHwIrzg2QkvUDrJU0N9bAozNeSb
   JBdvEpkk0mlUCyITwrI1WCW8BvhBAUpzoAY7hByviwMcx8Ut9DvWpuA8Z
   nVKUCtz4PW8yier+BwdbRkc3TEkVpC7r8cobOMXhSkFeskSxcSVz9g3Em
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29733904"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 11:30:57 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 11:30:57 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 11:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678962657; x=1710498657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8NFJUu1stU1ofnKZ91BXooX1J2ZEc+mm94bfu/ZhJgw=;
  b=MRbqa/bxdd8bBHYaxHygkcQktNMf9mIuAnxOrmgqfdEoIfiyn8Td3YqY
   NGYH4kGsB1X7GziRoTYn1aTqmwG8aBpSC/GDgO8/YuCuAN3PptdkzN3Nn
   DS7KhDU9qd2HKYX6GMAZ23NElXliK2Nb6ePhUglcuhpS/R73uUloSoctz
   1dsI+uZFFqLMQ+pUyoJWqTmsQEiBiKwvCwVxN+zLGHD9i/rR32wVC+FiG
   KkTVUhLwD6NNqxesO2QW/C+t7irFJ2onKGVRkj/0JM8u79tlc2ySxuAeD
   0dJF4rN7lBFrLVA22TSHnUKu9OXJIqaTo8n5tzeSPqAsH+CdpLKkqAKcY
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29733903"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 11:30:57 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B0B8D280056;
        Thu, 16 Mar 2023 11:30:57 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI/sysfs: get rid of pci_sysfs_init late_initcall
Date:   Thu, 16 Mar 2023 11:30:36 +0100
Message-Id: <20230316103036.1837869-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All this initcall does is creating sysfs file for devices already
added to the bus. But this is racing with pci_host_probe which will
add sysfs files on it's own merit.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215515
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This is a different approach to fix the race condition mentioned in the
link. From what I can see is that the functions for creating sysfs are
called during pci bus registration anyway, so there is no need to
iterate once again.

 drivers/pci/pci-sysfs.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dd0d9d9bc509..00c8cc3c40ff 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -31,8 +31,6 @@
 #include <linux/aperture.h>
 #include "pci.h"
 
-static int sysfs_initialized;	/* = 0 */
-
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -953,9 +951,6 @@ void pci_create_legacy_files(struct pci_bus *b)
 {
 	int error;
 
-	if (!sysfs_initialized)
-		return;
-
 	b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
 			       GFP_ATOMIC);
 	if (!b->legacy_io)
@@ -1494,9 +1489,6 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
-	if (!sysfs_initialized)
-		return -EACCES;
-
 	return pci_create_resource_files(pdev);
 }
 
@@ -1508,34 +1500,9 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
-	if (!sysfs_initialized)
-		return;
-
 	pci_remove_resource_files(pdev);
 }
 
-static int __init pci_sysfs_init(void)
-{
-	struct pci_dev *pdev = NULL;
-	struct pci_bus *pbus = NULL;
-	int retval;
-
-	sysfs_initialized = 1;
-	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
-		if (retval) {
-			pci_dev_put(pdev);
-			return retval;
-		}
-	}
-
-	while ((pbus = pci_find_next_bus(pbus)))
-		pci_create_legacy_files(pbus);
-
-	return 0;
-}
-late_initcall(pci_sysfs_init);
-
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
 	NULL,
-- 
2.34.1


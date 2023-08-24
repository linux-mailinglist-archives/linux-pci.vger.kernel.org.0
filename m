Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A77866D8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 06:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbjHXErm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 00:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbjHXEri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 00:47:38 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091E10F0;
        Wed, 23 Aug 2023 21:47:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 68E883F326;
        Thu, 24 Aug 2023 04:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692852454;
        bh=cwxju+w0lZghGRqmzAy7693vkTn397yDO/9OcFcmBOM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=fqyLmg3d/wvUKwdbxJ0fIfqne+U8bPsXbU4CmNNLYNj5m5av/aayyawJ4PhVCkyL6
         hOwX7pyhi/sWK5MkPRAdazD3/v2EKdoJArfxjOqssXFpWHo+4UlBSXcAnO0fwAyDa9
         KmKk6qaPW9hHXhKWGA2L0473ONEg+S2buzTUML5eve3q/lbyvQs8d4Xo/28cg3CYH6
         W9hC9ksKEjyM5SwlWQ61uahLNHWY9vLEFvC3qErpnywlpDu8/0Zz+WYtsv2Po/hSGC
         8r80BZn+hHxirjGVNc77VRUWEGQ/O43qksRXKGq+4eh26S2hX4CiMJE912Lh9uKqFn
         eLyC2WDCFAR2w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: Add helper to check if any of ancestor device support D3cold
Date:   Thu, 24 Aug 2023 12:46:43 +0800
Message-Id: <20230824044645.423378-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In addition to nearest upstream bridge, driver may want to know if the
entire hierarchy can be powered off to perform different action.

So walk higher up the hierarchy to find out if any device has valid
_PR3.

The user will be introduced in next patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci.c   | 16 ++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..79961936ed1b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6500,6 +6500,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
 		acpi_has_method(adev->handle, "_PR3");
 }
 EXPORT_SYMBOL_GPL(pci_pr3_present);
+
+bool pci_ancestor_pr3_present(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev;
+
+	if (acpi_disabled)
+		return false;
+
+	while ((parent = pci_upstream_bridge(parent))) {
+		if (pci_pr3_present(pdev))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
 #endif
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c69a2cc1f412..1f30c20753a3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2512,10 +2512,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
 bool pci_pr3_present(struct pci_dev *pdev);
+bool pci_ancestor_pr3_present(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
+static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.34.1


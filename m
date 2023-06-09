Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4672A63C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjFIWZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjFIWZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 18:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533FE35BE
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 15:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD9F616D2
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 22:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7DDC433D2;
        Fri,  9 Jun 2023 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686349511;
        bh=7XftGE3n3a5yFvjhMDe39lCqxHGJ5NPPitJQsDsWNqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKCmXu4r/cNPFvb0DLbmILu8TCt0nNhPeUJ/agFzr1Tu0gl1xqK6Dqyf11nFE8DCg
         pmUc2Vym10Qsrb4HAm6iybS2dL6iX3cEav2mOMER12FrHEF22ur1RaH4DeSrQ3O36/
         L8Nu1qZGBk4uHcKFXlmTdj1vai6UgowRfm31BabxCvFrEe2+iLq5D/Px6QKxuI9hpr
         6OPS3AcJhPgAAc9quoEB4X5LpUkd19UG2DO6KtxmtXLKEjA3bxuePSQ1GfEJZXGlAn
         yuzy4e2kPeAU7usdOpekerBLt7yxKahN9pgiovzjU/mg/aV2wW3WlvDJkzuVCjWUX9
         1LO3IVn339L4g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/4] PCI: Unexport pci_save_aer_state()
Date:   Fri,  9 Jun 2023 17:24:57 -0500
Message-Id: <20230609222500.1267795-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609222500.1267795-1-helgaas@kernel.org>
References: <20230609222500.1267795-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_save_aer_state() and pci_restore_aer_state() are only used in
drivers/pci, so don't expose them to the rest of the kernel.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   | 4 ++++
 include/linux/aer.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2475098f6518..a97a735e6623 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -686,6 +686,8 @@ extern const struct attribute_group aer_stats_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
+void pci_save_aer_state(struct pci_dev *dev);
+void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
@@ -693,6 +695,8 @@ static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
+static inline void pci_save_aer_state(struct pci_dev *dev) { }
+static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_ACPI
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 97f64ba1b34a..3a3ab05e13fd 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -45,8 +45,6 @@ struct aer_capability_regs {
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
-void pci_save_aer_state(struct pci_dev *dev);
-void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
@@ -60,8 +58,6 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-static inline void pci_save_aer_state(struct pci_dev *dev) {}
-static inline void pci_restore_aer_state(struct pci_dev *dev) {}
 #endif
 
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.34.1


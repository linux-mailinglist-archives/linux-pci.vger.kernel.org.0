Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE0F5B407E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiIIUZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiIIUZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86EB5A5F;
        Fri,  9 Sep 2022 13:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE141B8261C;
        Fri,  9 Sep 2022 20:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839F2C433D6;
        Fri,  9 Sep 2022 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755117;
        bh=Vd00o1aQKeBkXR3afJUCXrgxMnLri6zygSnmLdkhr7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWAmaoE/ZjDJORMzkXDJQcvyoqm/Hs2mJTh9tlVzFjiUUA8uUg6MuCCNjFd6SLwYX
         +ZXuFlf7cbCh79Np5edUj98eQAFCWfOFllMd8Kd1I9xhXi7G0jmOFV0viGTNO+b+Lu
         kW9AqhVvSseAP6mBMHBpoERQyDAv/Zg/PWj5qIGdf083fnhW7vX5+qB5OlNO7AGJzM
         rtm0ZQW5ES3dCYZ4debWT1/3maTg6gzY9W6PCeJ/5INz1BQDnnB6ulWxifbMIkVaUK
         19CpVtcfvsAG2Z8dcfKam+0xJmnL200+kg4f9iKRbA/MKMXR9lu7sKG2QwPYdYu7pY
         zdD1YUyutZUJQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 4/9] PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
Date:   Fri,  9 Sep 2022 15:25:00 -0500
Message-Id: <20220909202505.314195-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202505.314195-1-helgaas@kernel.org>
References: <20220909202505.314195-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We disable PTM during suspend because that allows some Root Ports to enter
lower-power PM states, which means we also need to disable PTM for all
downstream devices.  Add pci_suspend_ptm() and pci_resume_ptm() for this
purpose.

pci_enable_ptm() and pci_disable_ptm() are for drivers to use to enable or
disable PTM.  They use dev->ptm_enabled to keep track of whether PTM should
be enabled.

pci_suspend_ptm() and pci_resume_ptm() are PCI core-internal functions to
temporarily disable PTM during suspend and (depending on dev->ptm_enabled)
re-enable PTM during resume.

Enable/disable/suspend/resume all use internal __pci_enable_ptm() and
__pci_disable_ptm() functions that only update the PTM Control register.
Outline:

  pci_enable_ptm(struct pci_dev *dev)
  {
     __pci_enable_ptm(dev);
     dev->ptm_enabled = 1;
     pci_ptm_info(dev);
  }

  pci_disable_ptm(struct pci_dev *dev)
  {
     if (dev->ptm_enabled) {
       __pci_disable_ptm(dev);
       dev->ptm_enabled = 0;
     }
  }

  pci_suspend_ptm(struct pci_dev *dev)
  {
     if (dev->ptm_enabled)
       __pci_disable_ptm(dev);
  }

  pci_resume_ptm(struct pci_dev *dev)
  {
     if (dev->ptm_enabled)
       __pci_enable_ptm(dev);
  }

Nothing currently calls pci_resume_ptm(); the suspend path saves the PTM
state before disabling PTM, so the PTM state restore in the resume path
implicitly re-enables it.  A future change will use pci_resume_ptm() to fix
some problems with this approach.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c      |  4 +--
 drivers/pci/pci.h      |  6 ++--
 drivers/pci/pcie/ptm.c | 71 +++++++++++++++++++++++++++++++++---------
 include/linux/pci.h    |  2 ++
 4 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..83818f81577d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2714,7 +2714,7 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	 * lower-power idle state as a whole.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
+		pci_suspend_ptm(dev);
 
 	pci_enable_wake(dev, target_state, wakeup);
 
@@ -2772,7 +2772,7 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 	 * lower-power idle state as a whole.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
+		pci_suspend_ptm(dev);
 
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..ce4a277e3f41 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -507,11 +507,13 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #ifdef CONFIG_PCIE_PTM
 void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
-void pci_disable_ptm(struct pci_dev *dev);
+void pci_suspend_ptm(struct pci_dev *dev);
+void pci_resume_ptm(struct pci_dev *dev);
 #else
 static inline void pci_save_ptm_state(struct pci_dev *dev) { }
 static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
-static inline void pci_disable_ptm(struct pci_dev *dev) { }
+static inline void pci_suspend_ptm(struct pci_dev *dev) { }
+static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
 unsigned long pci_cardbus_resource_alignment(struct resource *);
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index ba1d50c965fa..70a28b74e721 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -29,7 +29,7 @@ static void pci_ptm_info(struct pci_dev *dev)
 		 dev->ptm_root ? " (root)" : "", clock_desc);
 }
 
-void pci_disable_ptm(struct pci_dev *dev)
+static void __pci_disable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
 	u16 ctrl;
@@ -42,6 +42,21 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
 }
 
+/**
+ * pci_disable_ptm() - Disable Precision Time Measurement
+ * @dev: PCI device
+ *
+ * Disable Precision Time Measurement for @dev.
+ */
+void pci_disable_ptm(struct pci_dev *dev)
+{
+	if (dev->ptm_enabled) {
+		__pci_disable_ptm(dev);
+		dev->ptm_enabled = 0;
+	}
+}
+EXPORT_SYMBOL(pci_disable_ptm);
+
 void pci_save_ptm_state(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
@@ -151,18 +166,8 @@ void pci_ptm_init(struct pci_dev *dev)
 		pci_enable_ptm(dev, NULL);
 }
 
-/**
- * pci_enable_ptm() - Enable Precision Time Measurement
- * @dev: PCI device
- * @granularity: pointer to return granularity
- *
- * Enable Precision Time Measurement for @dev.  If successful and
- * @granularity is non-NULL, return the Effective Granularity.
- *
- * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
- * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
- */
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+/* Enable PTM in the Control register if possible */
+static int __pci_enable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
 	struct pci_dev *ups;
@@ -191,8 +196,29 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 		ctrl |= PCI_PTM_CTRL_ROOT;
 
 	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
+	return 0;
+}
+
+/**
+ * pci_enable_ptm() - Enable Precision Time Measurement
+ * @dev: PCI device
+ * @granularity: pointer to return granularity
+ *
+ * Enable Precision Time Measurement for @dev.  If successful and
+ * @granularity is non-NULL, return the Effective Granularity.
+ *
+ * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
+ * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
+ */
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{
+	int rc;
+
+	rc = __pci_enable_ptm(dev);
+	if (rc)
+		return rc;
+
 	dev->ptm_enabled = 1;
-
 	pci_ptm_info(dev);
 
 	if (granularity)
@@ -201,6 +227,23 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 }
 EXPORT_SYMBOL(pci_enable_ptm);
 
+/*
+ * Disable PTM, but preserve dev->ptm_enabled so we silently re-enable it on
+ * resume if necessary.
+ */
+void pci_suspend_ptm(struct pci_dev *dev)
+{
+	if (dev->ptm_enabled)
+		__pci_disable_ptm(dev);
+}
+
+/* If PTM was enabled before suspend, re-enable it when resuming */
+void pci_resume_ptm(struct pci_dev *dev)
+{
+	if (dev->ptm_enabled)
+		__pci_enable_ptm(dev);
+}
+
 bool pcie_ptm_enabled(struct pci_dev *dev)
 {
 	if (!dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 54be939023a3..cb5f796e3319 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1678,10 +1678,12 @@ bool pci_ats_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
+void pci_disable_ptm(struct pci_dev *dev);
 bool pcie_ptm_enabled(struct pci_dev *dev);
 #else
 static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 { return -EINVAL; }
+static inline void pci_disable_ptm(struct pci_dev *dev) { }
 static inline bool pcie_ptm_enabled(struct pci_dev *dev)
 { return false; }
 #endif
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDEA5AF7E2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIFWYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIFWYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB26ABF0E;
        Tue,  6 Sep 2022 15:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30606616F5;
        Tue,  6 Sep 2022 22:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA26C433C1;
        Tue,  6 Sep 2022 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503048;
        bh=GZ1t3eEPe9WAKIeqnRdMruDBNlk/eilfZ8AziF6/6PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeD/nKSAZsxT6ztAhrLodFx5OfRGCevqJTbqV9M0/SXRzVpdVIJkCYT9MOMs6v5rQ
         9fgsbljrwM7837zZsdZsuYe0kfiNoZDsq1QyXojGodg+FmI7V7w1YEY5ntG4XF2HQz
         yikQXO7zGnnqozfDYCVe0YZm5Dd0pThK1+kPO40FztEjlesNUPvM+W8wD5+zabncp7
         DJuKd9X8qxaDiiemhtP6P4mdxplnjkZhjjcz0M+MlMt5SLMxw0+HuGY9go68I61/02
         kx6z22rlodkosTtmoV/p0pAvpmyfhURIgG4ZYfHbOympDprTJJ6lV4B/2Lps/aMcIG
         lHyeBSD3YLeVQ==
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
Subject: [PATCH v3 07/10] PCI/PTM: Add suspend/resume
Date:   Tue,  6 Sep 2022 17:23:48 -0500
Message-Id: <20220906222351.64760-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906222351.64760-1-helgaas@kernel.org>
References: <20220906222351.64760-1-helgaas@kernel.org>
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

---
 drivers/pci/pci.c      |  4 ++--
 drivers/pci/pci.h      |  4 ++++
 drivers/pci/pcie/ptm.c | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index 91a465460d0f..ce4a277e3f41 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -507,9 +507,13 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #ifdef CONFIG_PCIE_PTM
 void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
+void pci_suspend_ptm(struct pci_dev *dev);
+void pci_resume_ptm(struct pci_dev *dev);
 #else
 static inline void pci_save_ptm_state(struct pci_dev *dev) { }
 static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
+static inline void pci_suspend_ptm(struct pci_dev *dev) { }
+static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
 unsigned long pci_cardbus_resource_alignment(struct resource *);
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 4a9f045126ca..8ac844212436 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -198,6 +198,21 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 }
 EXPORT_SYMBOL(pci_enable_ptm);
 
+/*
+ * Disable PTM, but leave dev->ptm_enabled so we silently re-enable it on
+ * resume.
+ */
+void pci_suspend_ptm(struct pci_dev *dev)
+{
+	__pci_disable_ptm(dev);
+}
+
+void pci_resume_ptm(struct pci_dev *dev)
+{
+	if (dev->ptm_enabled)
+		__pci_enable_ptm(dev);
+}
+
 bool pcie_ptm_enabled(struct pci_dev *dev)
 {
 	if (!dev)
-- 
2.25.1


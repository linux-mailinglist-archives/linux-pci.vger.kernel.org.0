Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645F5AF7D9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIFWYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIFWYL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9BAA3E4;
        Tue,  6 Sep 2022 15:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63BF2B81AAA;
        Tue,  6 Sep 2022 22:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9A0C433D6;
        Tue,  6 Sep 2022 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503045;
        bh=cD6LaKtHHzCoaSefmit3nfjumtZ0PHa2t3oTDXVD7L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPfusRYKGLk3TY22O1v2vmVECesOBY1pyCymDRrMmhZTxwwMfxH0QL9+8jceQ4FsD
         3lVV+/x4o0Awsf4PzqYz3/b7D2BUIOYFhLpK6R1lc0QS3i03lTgPPz4+OMTwVsCHqU
         CFsj66y4Oevjj+CKseAunSovND2QHNJJxr4izQZbVX6AeIN7/+D6xaJt80fLmmcR1f
         3QD4Gflny2ftp4Rh3v1BTfXurPs1yUA5DNO5+5NpQxwg9n1rAZbKw54nhk2sx9WJBz
         tmmpzwLx6snG5lkhUwWTzSArO9FqPB691kJxHlsv5jHrVRYxjmlZzhExNuJ2h7zuc4
         4SAE+HtCYM/sw==
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
Subject: [PATCH v3 05/10] PCI/PTM: Add pci_disable_ptm() wrapper
Date:   Tue,  6 Sep 2022 17:23:46 -0500
Message-Id: <20220906222351.64760-6-helgaas@kernel.org>
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

Implement pci_disable_ptm() as a wrapper around an internal
__pci_disable_ptm() that we can use during suspend to disable PTM without
clearing dev->ptm_enabled.  A future commit will re-enable PTM during
resume when dev->ptm_enabled is set.

Export pci_disable_ptm(), which *does* clear dev->ptm_enabled, for use by
drivers that want to disable PTM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      | 2 --
 drivers/pci/pcie/ptm.c | 9 ++++++++-
 include/linux/pci.h    | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..91a465460d0f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -507,11 +507,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #ifdef CONFIG_PCIE_PTM
 void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
-void pci_disable_ptm(struct pci_dev *dev);
 #else
 static inline void pci_save_ptm_state(struct pci_dev *dev) { }
 static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
-static inline void pci_disable_ptm(struct pci_dev *dev) { }
 #endif
 
 unsigned long pci_cardbus_resource_alignment(struct resource *);
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index ac51cd84793f..762299984469 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -29,7 +29,7 @@ static void pci_ptm_info(struct pci_dev *dev)
 		 dev->ptm_root ? " (root)" : "", clock_desc);
 }
 
-void pci_disable_ptm(struct pci_dev *dev)
+static void __pci_disable_ptm(struct pci_dev *dev)
 {
 	int ptm = dev->ptm_cap;
 	u16 ctrl;
@@ -42,6 +42,13 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
 }
 
+void pci_disable_ptm(struct pci_dev *dev)
+{
+	__pci_disable_ptm(dev);
+	dev->ptm_enabled = 0;
+}
+EXPORT_SYMBOL(pci_disable_ptm);
+
 void pci_save_ptm_state(struct pci_dev *dev)
 {
 	int ptm = dev->ptm_cap;
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


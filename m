Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D95B4089
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiIIUZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiIIUZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319B6AE200;
        Fri,  9 Sep 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E5A620D8;
        Fri,  9 Sep 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D480C433C1;
        Fri,  9 Sep 2022 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755125;
        bh=JSJGA5atq3nPQq9JjZZ/q5dZdJDWU3SoTtXD+OyjCMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1KtGlekeFUVBujxKCihl0ApDbZQ/6bzZ9gDpwxt68bCilYdYmE6T8x2wI/0Hcrzu
         8ZLYQQWK+6wnAclNC6b6IRUseUgQO7jTi2yaW9PxopD4laH0Zgi+/dbJvvNXamkcGW
         Nu+WgxNgm3hBpXET2CRk6lbuErdwnGSOzJ8pOwefrV2XGvsUq7UFpt38NXec9jzDdx
         hpPmO9yP7cv1fDIm0i6yIQrVRSuKURwRbY/KPFlArLw65CMQ8YXLId2CxGIDRNmXjt
         Vtgqq+ZZUzbr4oPJE8LKH97ezC6CO64YcGDjAhPR2vbU+Av4iNLWL8CIzG6xoelHlB
         UWqXyRwQVOSAA==
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
Subject: [PATCH v4 8/9] PCI/PTM: Consolidate PTM interface declarations
Date:   Fri,  9 Sep 2022 15:25:04 -0500
Message-Id: <20220909202505.314195-9-helgaas@kernel.org>
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

Consolidate all the PTM-related declarations in drivers/pci/pci.h.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ce4a277e3f41..5cca2e58cce8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -505,11 +505,13 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #endif /* CONFIG_PCI_IOV */
 
 #ifdef CONFIG_PCIE_PTM
+void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
 void pci_suspend_ptm(struct pci_dev *dev);
 void pci_resume_ptm(struct pci_dev *dev);
 #else
+static inline void pci_ptm_init(struct pci_dev *dev) { }
 static inline void pci_save_ptm_state(struct pci_dev *dev) { }
 static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
 static inline void pci_suspend_ptm(struct pci_dev *dev) { }
@@ -577,12 +579,6 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
 static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
-#ifdef CONFIG_PCIE_PTM
-void pci_ptm_init(struct pci_dev *dev);
-#else
-static inline void pci_ptm_init(struct pci_dev *dev) { }
-#endif
-
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
-- 
2.25.1


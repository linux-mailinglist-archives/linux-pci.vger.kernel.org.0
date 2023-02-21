Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12A169D880
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 03:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjBUCdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 21:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBUCdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 21:33:51 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E414202;
        Mon, 20 Feb 2023 18:33:49 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B9137405FF;
        Tue, 21 Feb 2023 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676946828;
        bh=VxzDHiK0+rolY+k286CzRqUyRlnpqBJ10GA9uRWnSf0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ts/zeIPQLdYEfw+0jiMZ1EKekWLkJZduqIQy01JXig+4VJYPrPa09WAk8WndE2lXV
         OFxn3iKiQdFg/FfRJR64VGpTxwbrI3D75+GZeurMw8EYpZsLxVIJ07bt6zJU2IpHHr
         kGqxP5JlEMWc4Xw/aeaMg9TZxFslWZ1L4n69rs38pIaAOWHCelYBm4zr97hwNp7+Y3
         mOYbgj0Kdh0aUNtHgxoonVPmfXw17xfmKMeAtu9rBhhTW4VmmOIuhcbIZDjMWF1vXm
         CKJjdZOusRSTV27FT8HGUbVV51JYmobX0L655pETQrBXFTcoalsemM57k2kn/IvPw1
         1Zk1OUIY23GSw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     hkallweit1@gmail.com, nic_swsd@realtek.com, bhelgaas@google.com
Cc:     koba.ko@canonical.com, acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/6] PCI/ASPM: Add pcie_aspm_capable() helper
Date:   Tue, 21 Feb 2023 10:32:34 +0800
Message-Id: <20230221023237.1905536-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221023237.1905536-1-kai.heng.feng@canonical.com>
References: <20230221023237.1905536-1-kai.heng.feng@canonical.com>
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

Introduce a new helper, pcie_aspm_capable(), to report ASPM capability.

The user will be introduced by next patch.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v8:
 - No change.

v7:
 - Change subject.

v6:
 - No change.

v5:
 - No change.

v4:
 - Report aspm_capable instead.

v3:
 - This is a new patch

 drivers/pci/pcie/aspm.c | 11 +++++++++++
 include/linux/pci.h     |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 692d6953f0970..d96bf0a362aa2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1199,6 +1199,17 @@ bool pcie_aspm_enabled(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
 
+bool pcie_aspm_capable(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	if (!link)
+		return false;
+
+	return link->aspm_capable;
+}
+EXPORT_SYMBOL_GPL(pcie_aspm_capable);
+
 static ssize_t aspm_attr_show_common(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf, u8 state)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index adffd65e84b4e..fd56872883e14 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1692,6 +1692,7 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
+bool pcie_aspm_capable(struct pci_dev *pdev);
 #else
 static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
@@ -1700,6 +1701,7 @@ static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
+static inline bool pcie_aspm_capable(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER
-- 
2.34.1


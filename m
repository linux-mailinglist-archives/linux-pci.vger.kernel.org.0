Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD251F5C3
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiEIHzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiEIHm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 03:42:27 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCA419C397;
        Mon,  9 May 2022 00:38:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8B45041385;
        Mon,  9 May 2022 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652081847;
        bh=BGdQS7GDt72NyKsTP48y7ylwYoRPiomJUKtDk9kD5KI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=APTuzxakfgtwQV4qWpjpID7To9ihg0LEQfJO+iSozdAPobUQA3OmkO5dM13Z8tXIr
         uyKI8TGKfVF7ZRPaq0tL2ipecAozQlsWseqk7zYXVCpHkf/Jl+N/PyNhOExN0ghUgo
         wYWD40D3zKb3MPDSslzTiFdfTWLyH3SQW1x9e8ZaJz6AKkiWoAQI6gDK8OYECZh/Uq
         vbtFM/J8vIqJ+4C57R7qE4Qna+fUPWIoufYy9KcVzcM7LacNd8oIktY/eoK5xW9iSR
         cNv2+Pr3rHSrc7QRMihpFMBjjG/gtRW81P5QIGWGtdqgZY4PKZqVCL8msKGFINT3Ms
         /be0ReZS7CmiQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI:ASPM: Remove pcie_aspm_pm_state_change()
Date:   Mon,  9 May 2022 15:36:37 +0800
Message-Id: <20220509073639.2048236-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_aspm_pm_state_change() was introduced at the inception of PCIe
ASPM code.

However, it can cause some issues. For instance, when ASPM config is
changed via sysfs, those changes won't persist across power state change
because pcie_aspm_pm_state_change() overwrites them.

In addition to that, if the driver is to restore L1ss [1] after system
resume, the restored states will also be overwritten by
pcie_aspm_pm_state_change().

So remove pcie_aspm_pm_state_change() for now, if there's any hardware
really needs it to function, a quirk can be used instead.

[1] https://lore.kernel.org/linux-pci/20220201123536.12962-1-vidyas@nvidia.com/

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci.c       |  3 ---
 drivers/pci/pci.h       |  2 --
 drivers/pci/pcie/aspm.c | 19 -------------------
 3 files changed, 24 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f1..d09f7b60ee4dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1181,9 +1181,6 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (need_restore)
 		pci_restore_bars(dev);
 
-	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
-
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a15..86a19f293d4ad 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -560,12 +560,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
-static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b7424c9bc8..7f76a5875feb4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1012,25 +1012,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
-/* @pdev: the root port or switch downstream port */
-void pcie_aspm_pm_state_change(struct pci_dev *pdev)
-{
-	struct pcie_link_state *link = pdev->link_state;
-
-	if (aspm_disabled || !link)
-		return;
-	/*
-	 * Devices changed PM state, we should recheck if latency
-	 * meets all functions' requirement
-	 */
-	down_read(&pci_bus_sem);
-	mutex_lock(&aspm_lock);
-	pcie_update_aspm_capable(link->root);
-	pcie_config_aspm_path(link);
-	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
-}
-
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
-- 
2.34.1


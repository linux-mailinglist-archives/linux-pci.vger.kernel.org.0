Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907006FF250
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbjEKNPO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbjEKNPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:15:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF35FEB;
        Thu, 11 May 2023 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810896; x=1715346896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=meluktmb3bIWweKK7Xa29J4IH8GM2OVrJRcaLC2LBnI=;
  b=FOhmZL55e/FmJrxr1e7b/G/fkdZfE0RjSp06lT86BTyY4JVq1la3V762
   NOdvcPDs52wV3UUqzxa+LLaBNVMBnk/B8/iLLxTMpmuFN/ovQqpogdy41
   2jTRHPfQnTlQZfyTFNSG6C9IBwudfOSqcoslYAPoYUow0WxV2yV3yO8z3
   wrDSkySKtYYfHCmsWyAn0zQyawPWmS537IXQKD8x1xJ4rEAIvx2ZD/vLt
   ydG974hpWgbBxH88LhYMU7FoASoue4gZJe0POsgzZOuIBCw1RQf1mwoyK
   30UutncgYzrkIis1Xy6q/3KcvV/61+DI0YLUt0yBwrFx0YRA7QoKJsH6i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619328"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619328"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169442"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169442"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants for LNKCTL{,2}
Date:   Thu, 11 May 2023 16:14:25 +0300
Message-Id: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A few places write LNKCTL and LNKCTL2 registers without proper
concurrency control and this could result in losing the changes
one of the writers intended to make.

Add pcie_capability_clear_and_set_word_locked() and helpers to use it
with LNKCTL and LNKCTL2. The concurrency control is provided using a
spinlock in the struct pci_dev.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/access.c | 14 ++++++++++++++
 drivers/pci/probe.c  |  1 +
 include/linux/pci.h  | 17 +++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 3c230ca3de58..d92a3daadd0c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -531,6 +531,20 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 }
 EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
+int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
+					      u16 clear, u16 set)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&dev->cap_lock, flags);
+	ret = pcie_capability_clear_and_set_word(dev, pos, clear, set);
+	spin_unlock_irqrestore(&dev->cap_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);
+
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2826c4a832..0c14a283f1c7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2318,6 +2318,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 		.end = -1,
 	};
 
+	spin_lock_init(&dev->cap_lock);
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60b8772b5bd4..82faea085d95 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -467,6 +467,7 @@ struct pci_dev {
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
+	spinlock_t	cap_lock;		/* Protects RMW ops done with locked RMW capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
 	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
@@ -1221,6 +1222,8 @@ int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
 				       u16 clear, u16 set);
 int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 					u32 clear, u32 set);
+int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
+					      u16 clear, u16 set);
 
 static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
 					   u16 set)
@@ -1246,6 +1249,20 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
 }
 
+static inline int pcie_lnkctl_clear_and_set(struct pci_dev *dev, u16 clear,
+					    u16 set)
+{
+	return pcie_capability_clear_and_set_word_locked(dev, PCI_EXP_LNKCTL,
+							 clear, set);
+}
+
+static inline int pcie_lnkctl2_clear_and_set(struct pci_dev *dev, u16 clear,
+					    u16 set)
+{
+	return pcie_capability_clear_and_set_word_locked(dev, PCI_EXP_LNKCTL2,
+							 clear, set);
+}
+
 /* User-space driven config access */
 int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
-- 
2.30.2


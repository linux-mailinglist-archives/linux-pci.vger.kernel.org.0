Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376792980A9
	for <lists+linux-pci@lfdr.de>; Sun, 25 Oct 2020 08:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767739AbgJYHb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 03:31:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17666 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbgJYHb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 03:31:26 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9529d30000>; Sun, 25 Oct 2020 00:31:31 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Oct
 2020 07:31:25 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 25 Oct 2020 07:31:21 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 1/2] PCI/AER: Add pcie_is_ecrc_enabled() API
Date:   Sun, 25 Oct 2020 13:01:12 +0530
Message-ID: <20201025073113.31291-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025073113.31291-1-vidyas@nvidia.com>
References: <20201025073113.31291-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603611091; bh=pZP6TimX4Vye4vln55vE9uHmGwSh/lbC8xT45zOVWUw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=O/cbQscf6uitlONuMyJ+LATFQ7R9m+kYa8Kh034IT6EO/LqVTJ/7OfMfYmHqDYeg2
         /2rmp9Cry/1v/7slwTJPbj+PLZxy73sgnTBTe/Ake3fsT0mljAyr8FkYFeCHd/Kbtc
         oI6iwxVpAaIwBHJG4l7FrHWSLrbMofWNuP1GTuDy4SiTZMBWADN+kIzsq2RvoFF27H
         TpBhLbwkPGpTJ/Lt5wGdwpA3tq0hJORVxEgREvDXf76dM7pb1ySVDA+xujcel1uI6c
         0pjZAAuBjF4w7bzvKoub2g5QomV2h+acFuKqkkE8KaW1ZwHOhxqRfjyfkCWpEAJidT
         HLLKfuEGYCPiw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds pcie_is_ecrc_enabled() API to let other sub-systems (like DesignWare)
to query if ECRC policy is enabled and perform any configuration
required in those respective sub-systems.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..325fdbf91dde 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -575,9 +575,11 @@ static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCIE_ECRC
 void pcie_set_ecrc_checking(struct pci_dev *dev);
 void pcie_ecrc_get_policy(char *str);
+bool pcie_is_ecrc_enabled(void);
 #else
 static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
 static inline void pcie_ecrc_get_policy(char *str) { }
+static inline bool pcie_is_ecrc_enabled(void) { return false; }
 #endif
 
 #ifdef CONFIG_PCIE_PTM
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..24363c895aba 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -207,6 +207,17 @@ void pcie_ecrc_get_policy(char *str)
 
 	ecrc_policy = i;
 }
+
+/**
+ * pcie_is_ecrc_enabled - returns if ECRC is enabled in the system or not
+ *
+ * Returns 1 if ECRC policy is enabled and 0 otherwise
+ */
+bool pcie_is_ecrc_enabled(void)
+{
+	return ecrc_policy == ECRC_POLICY_ON;
+}
+EXPORT_SYMBOL(pcie_is_ecrc_enabled);
 #endif	/* CONFIG_PCIE_ECRC */
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-- 
2.17.1


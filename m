Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33BA29A61B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508712AbgJ0IET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 04:04:19 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4390 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508692AbgJ0IDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 04:03:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97d46d0001>; Tue, 27 Oct 2020 01:03:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 08:03:45 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 27 Oct 2020 08:03:42 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/2] PCI/AER: Add pcie_is_ecrc_enabled() API
Date:   Tue, 27 Oct 2020 13:33:29 +0530
Message-ID: <20201027080330.8877-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027080330.8877-1-vidyas@nvidia.com>
References: <20201027080330.8877-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603785837; bh=r0xwNq09SLVf9IAKX1jCbxlzGbnHbhH3r1mmzOeOSi8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Y/DJ1YQpJ9dWzdrAHRHxF7Ro99qwC02tqL8cdVONz8dE6v3rg/g1VGm6c7h+Q9emn
         pKW6K9Lo7Y9hLyZ7iJcHfdIf9ES0XMzH5ahEUmM5CdkOLX0MNznRqXZzA0QX84z2QC
         AKI3ZTs3cmr+b9CL1DPW5xKWJzdy8h1zozb3Oi03TAIX3MSHs5bouAJSqS3hk5PD5m
         CxOIJbNRZaDktMv++lgDIOglCfeqfgUJuurorhY74kmHChl+oZHx+IEKINGNHJSnos
         YShwDu/cUo9lRD1tM9vq4Co5iG4YyXcKHOd8xvnfHze0BvUq+C4oUzVuSpnEItl80A
         1k764zZ4F0IAA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds pcie_is_ecrc_enabled() API to let other sub-systems (like DesignWare)
to query if ECRC policy is enabled and perform any configuration
required in those respective sub-systems.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None from V1

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


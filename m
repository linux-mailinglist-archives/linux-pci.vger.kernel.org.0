Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85329E509
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 08:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgJ2Huz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 03:50:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12341 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgJ2Hus (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 03:50:48 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a55c10000>; Wed, 28 Oct 2020 22:40:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:40:11 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:40:07 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 1/2] PCI/AER: Add pcie_is_ecrc_enabled() API
Date:   Thu, 29 Oct 2020 11:09:58 +0530
Message-ID: <20201029053959.31361-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029053959.31361-1-vidyas@nvidia.com>
References: <20201029053959.31361-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603950017; bh=axZlsvt1VZvSgUjJIESWzzpptQQ8wrAREfYGAdEt2mA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=fGMytgXSgvbeIGubvyn81UOwJWWhCJQL0TSZHcRh5DT6BCPvdL1MR9hJ/O1M1l5gb
         BJJkEhkz4AcUvnZbJBFhZvkVxdJUPoQZd3uEfM/zxaG428ZmSDShPrNR65xT0rhdNT
         DWbBbFWIUn4N28M7SObqVn/GM18R+KxBvZMoQhUrcE4Mifie36h422s1WFdVgQCGQg
         ZshIFU2004VQ6801ZLUbNGjZuGA540DJxsJn16K0aSzm40j1mdUa0+g4Lmm7J5zynL
         Ux9B6nt1tFIEAMJkHqpDDt0csfcA296chqC8qbx+XF/eeKemy+ulKwXskyaOJk9TPm
         aXyyR5xVn0F1g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds pcie_is_ecrc_enabled() API to let other sub-systems (like DesignWare)
to query if ECRC policy is enabled and perform any configuration
required in those respective sub-systems.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
---
V3:
* Address Ethan Zhao's comments
* Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'

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
index 65dff5f3457a..d0f5a7043aff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -207,6 +207,17 @@ void pcie_ecrc_get_policy(char *str)
 
 	ecrc_policy = i;
 }
+
+/**
+ * pcie_is_ecrc_enabled - returns if ECRC is enabled in the system or not
+ *
+ * Returns true if ECRC policy is enabled and false otherwise
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


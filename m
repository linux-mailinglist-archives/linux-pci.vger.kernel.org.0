Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429F429A618
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 09:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508700AbgJ0ID6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 04:03:58 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4514 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508693AbgJ0IDx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 04:03:53 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97d46b0000>; Tue, 27 Oct 2020 01:03:55 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 08:03:51 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 27 Oct 2020 08:03:47 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 2/2] PCI: dwc: Add support to configure for ECRC
Date:   Tue, 27 Oct 2020 13:33:30 +0530
Message-ID: <20201027080330.8877-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027080330.8877-1-vidyas@nvidia.com>
References: <20201027080330.8877-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603785835; bh=iZRvyZ515nO9MIi9DWRVPEix4qqB7u3fq33eKTzAIQs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=WQnp5mt4NRUk4sU9gC8uKZd3M3BnrACG5SeJZl3pS0iJ6CAqetlaBZCnbgl69Qnwx
         jI4BQrKIy+zL9wDWUrVhYSgzfkbzIDbRirQE6hThWf8UPE9hmY5BRG3pf4m8q2EGTA
         QS7b/7QJIfo40tOMMC4VygtM0f9ZiHWurv1+C9aqOGkh5ev6USeoygP9Fx0XomNJWK
         xjW8PjZI+s44CdJENnTV2PsobrSE0soWjkj/gO16+OjAKnuu+OjdjGvOL5nv7dFsZz
         ueg+sApQmCfX/L+xy9cbjM552AYXsZBXq/3tkT44TBrKWbH8Wba0FqhT7nlJn2GxJM
         3RT9O+N7eM/4Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare core has a TLP digest (TD) override bit in one of the control
registers of ATU. This bit also needs to be programmed for proper ECRC
functionality. This is currently identified as an issue with DesignWare
IP version 4.90a. This patch does the required programming in ATU upon
querying the system policy for ECRC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed Jingoo's review comment
* Removed saving 'td' bit information in 'dw_pcie' structure

 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b5e438b70cd5..cbd651b219d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	if (pci->version == 0x490A)
+		val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
 	val = upper_32_bits(size - 1) ?
 		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
@@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   lower_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
-			   PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	if (pci->version == 0x490A)
+		val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 21dd06831b50..e5449b205c22 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -90,6 +90,7 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TD_SHIFT		8
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D829E68A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgJ2IjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:39:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11552 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgJ2IjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:39:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a55af0000>; Wed, 28 Oct 2020 22:39:59 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:40:16 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:40:12 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Date:   Thu, 29 Oct 2020 11:09:59 +0530
Message-ID: <20201029053959.31361-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029053959.31361-1-vidyas@nvidia.com>
References: <20201029053959.31361-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603949999; bh=OzLT6vpwwjR959ff9oUCGEtnW0TMQ/fO6AW9AajK7ew=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=k/GTzF7bCXSeSArYLqgI7gzP4JB/MwmBxL1s31un3sJMwKd7xigDBbyswS4x8lH67
         Q/BOBmA7yABnimvlSQREqoXGHNB7Bl9vCw9lOYmPPZ51y2v/BxBjVgrfF2+Tli07sh
         lioFD93X0CYd3dnn261E4VDPs1XnQMWsdMWf+39v8ZqdIAFfLhm4cXj2OUlYiQ/UHZ
         GcZcpR/29CB7jZQYKvsIrwJs8Er+vl/gYwQOHsIt9N8jvEGz4OFazYTNQyfSOADeUl
         XapNj/zx9EIQL4GViGTpzr/D8rn11mbljBsfpIJUzSc9YrnZiuwb9y+mbLRF/OSzqQ
         p3+6/JOsxTBGw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare core has a TLP digest (TD) override bit in one of the control
registers of ATU. This bit also needs to be programmed for proper ECRC
functionality. This is currently identified as an issue with DesignWare
IP version 4.90a. This patch does the required programming in ATU upon
querying the system policy for ECRC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
---
V3:
* Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'

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
index e7f441441db2..b01ef407fd52 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -89,6 +89,7 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TD_SHIFT		8
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
-- 
2.17.1


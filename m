Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3592977F2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755238AbgJWT5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 15:57:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17019 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755237AbgJWT5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 15:57:15 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9335870000>; Fri, 23 Oct 2020 12:56:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 19:57:14 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Oct 2020 19:57:09 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 2/3] PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
Date:   Sat, 24 Oct 2020 01:26:54 +0530
Message-ID: <20201023195655.11242-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023195655.11242-1-vidyas@nvidia.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603483015; bh=Lcu11GtGa94b8F15yYcftGZjf+99kinzBPZEJ0Hk4Nc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=S6afGSdJjwBWM4IYoOg6hqyhHO1q+IAH0Qmj+4FXMNQhCp87Rf8E5jKNYPautjK82
         J3fO7M6lYltynXhUkhQ5V9sl9TfStISjSnaS6MEd0fH5yW1xxxJrzKsNsibfDUozl8
         gKUxAlVHarA0u8V8UUqDgRtFL13w10JM8YzhvzKL6MxGQhfU5Oppplu4Pwapv4BrmN
         hxX0y8sxa8Nz1tEC76d4y9W03zsM38+ReY25ijlE4bD7Az7AxW0g+VEh4nLdSFmCWp
         lfaJvC6lIslRJ5RIM2/DAszdTtB2J6OvcgLxiT1O4v5k1a6OLUpCyxAnAgov7tCETn
         ExpAMNY0s30Sg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to program the ATU to enable translations for >4GB sizes of
the prefetchable memory apertures.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
 drivers/pci/controller/dwc/pcie-designware.h |  3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c2dea8fc97c8..b5e438b70cd5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -228,7 +228,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 					     int index, int type,
 					     u64 cpu_addr, u64 pci_addr,
-					     u32 size)
+					     u64 size)
 {
 	u32 retries, val;
 	u64 limit_addr = cpu_addr + size - 1;
@@ -245,8 +245,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				 type | PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = upper_32_bits(size - 1) ?
+		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 				 PCIE_ATU_ENABLE);
 
@@ -267,7 +269,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 
 static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 					int index, int type, u64 cpu_addr,
-					u64 pci_addr, u32 size)
+					u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 
@@ -311,7 +313,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u32 size)
+			       u64 cpu_addr, u64 pci_addr, u64 size)
 {
 	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
 				    cpu_addr, pci_addr, size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9d2f511f13fa..e7f441441db2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -84,6 +84,7 @@
 #define PCIE_ATU_REGION_INDEX1		0x1
 #define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
 #define PCIE_ATU_TYPE_MEM		0x0
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
@@ -295,7 +296,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
-			       u32 size);
+			       u64 size);
 void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
 				  u32 size);
-- 
2.17.1


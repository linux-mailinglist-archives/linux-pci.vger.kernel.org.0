Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB75B4A933
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfFRSDK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8845 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09275c0000>; Tue, 18 Jun 2019 11:03:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 11:03:08 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:08 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:05 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 16/27] PCI: tegra: Set target speed as Gen1 before starting LTSSM
Date:   Tue, 18 Jun 2019 23:31:55 +0530
Message-ID: <20190618180206.4908-17-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880988; bh=1vPi770/Z5fICSNm6FuPv0aDnB9kNs0p4U+8dM6StzU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=sUbBg2kOBdKvXCuymBvDujOc5kF4AHJOBuSTCEjhQj1ME0Cvjygaf84XHJBzk/akd
         hclP7DOnGlG06Nlz2wsf27e85UwuHKKYIg2jS9a0r8Dyq3jQF9nVvK9OoTTKGby2oN
         wPXCzq9kPRcm0p90xQqc5iBr+ctJ+DriqUTB6r82EYkVMxA6kUqwzRxEvWTCQVYWp8
         1W7beE0GuIgf/PG+fSAci+89j5W18y7EnhAo9HwmhVxWaUkgPE3AXFOfkAqQl6af96
         E5aP5Zl1t+u/zpzj5LhoqrIv5RmZ19fwkyBzMuxNEYdHQcTZw6bYcV6EKc5+6hP86w
         WqPw2DxWciKWg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe link up fails with few legacy endpoints if root port advertises both
Gen-1 and Gen-2 speeds in Tegra. This is because link number negotiation
fails if both Gen1 & Gen2 are advertised. Tegra doesn't retry link up by
advertising only Gen1. Hence, the strategy followed here is to initially
advertise only Gen-1 and after link is up, retrain link to Gen-2 speed.

Tegra doesn't support HW autonomous speed change. Link comes up in Gen1
even if Gen2 is advertised, so there is no downside of this change.

This behavior is observed with following two PCIe devices on Tegra,
 - Fusion HDTV 5 Express card
 - IOGear SIL - PCIE - SATA card

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: No change

V2: Updated commit log to reflect why this issue is observed on Tegra with
these particular cards

 drivers/pci/controller/pci-tegra.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 6ed406c46409..abb94595c76b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -676,6 +676,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= soc->update_fc_threshold;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	/*
+	 * PCIe link doesn't come up with few legacy PCIe endpoints if
+	 * root port advertises both Gen-1 and Gen-2 speeds in Tegra.
+	 * Hence, the strategy followed here is to initially advertise
+	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
+	 */
+	value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
+	value &= ~PCI_EXP_LNKSTA_CLS;
+	value |= PCI_EXP_LNKSTA_CLS_2_5GB;
+	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
-- 
2.17.1


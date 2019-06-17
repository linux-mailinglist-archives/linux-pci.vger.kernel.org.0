Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4F348A89
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfFQRky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:54 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10931 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRky (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0a50000>; Mon, 17 Jun 2019 10:40:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:40:53 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:52 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:52 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:40:49 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 16/27] PCI: tegra: Set target speed as Gen1 before starting LTSSM
Date:   Mon, 17 Jun 2019 23:09:41 +0530
Message-ID: <20190617173952.29363-17-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793253; bh=I++tFyhGBddMg+LKSAj1JEgGPUmTecJ3pR3zI2TwqTY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cR+11tvNbqF7yGX3ubogRVUcdix3kfg6NFNw3eftuRRVl3RsILf5bqyEgFUn7TAEa
         fA3PqXZHPCgpZuf2+o5xtao2SefBCuw5lq0HFG4tamz4EAQXxDVeHWKVI5Tf9r2WmQ
         EHdZDSLlHwOzwmmpHEsOmho8JK7VJWit/5FpQssTV7kXZ0kN6EQk+ce5qpiARFpE2U
         oaC7wki/d1sTxZOi3rd/knu/AJfV9vqmBBitNWmHRVyIQhqPy4SOm4UibdCiBOVlrn
         5xFAJYbZfZ11lmmqVUqZqtNhgaagvV8908wHTImRthBbsv57o3wUPRExj6X5FPIyNa
         Ri09PAPwnSlhg==
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


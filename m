Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2E11FF16
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEPFyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:12 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15053 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfafe0001>; Wed, 15 May 2019 22:54:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:10 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:10 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:10 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:07 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 16/28] PCI: tegra: Set target speed as Gen1 before starting LTSSM
Date:   Thu, 16 May 2019 11:22:55 +0530
Message-ID: <20190516055307.25737-17-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986046; bh=y6xpspClfu4S7huCzXVZ+WfVA1j4hmWj2UDwv3hA+7o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Og0hEx4edKmL/yCvjVdvLyYiqELTte0cwYJlEYr/mGvgaP+/rprpFCbjLoV4AfwCq
         pvyl+xnhMPoS1DDlL/UMJzrNOYv0VRV70jpIRdz5+XQjNkEQ3p2/3ERuMqpNK1vMv1
         r3nZcBE4aXvRUO8a/FjDdpKdvSH8QvZSYuC6bhoeITPYEDpSykNQ7MSqyeNs5usgT6
         4Bd8MWspWwxiJ/xO8EP3i1nh7vKR61Q+OFK1tTZbkybSR+khO3/jq32mcY7CsR+uJs
         3JmmMtaOrOcRbvWLsEH73+BkNOgBOz63Um2X11Yy9MPGWejBUjlnrO07uc4jtpUosN
         iy9boSvJrCVJg==
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
V4: No change

V3: No change

V2: Updated commit log to reflect why this issue is observed on Tegra with
these particular cards

 drivers/pci/controller/pci-tegra.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 16d4d3cba3ff..9ee111062ab7 100644
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


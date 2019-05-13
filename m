Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311671BCD1
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfEMSJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18105 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2c30000>; Mon, 13 May 2019 11:09:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 May 2019 11:09:00 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:00 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:08:57 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 16/29] PCI: tegra: Set target speed as Gen1 before starting LTSSM
Date:   Mon, 13 May 2019 23:37:31 +0530
Message-ID: <20190513180744.16493-17-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770947; bh=3gJPdvaI4aTqNDjpwn3sCoTGpNfHpfG9vgT4l36bcfo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RLiJtTYLaPLrk8NOnefIcPWfRM335ynUdVQgAepUhZ6/SRFoS7NWzlRuwiPPtPz5u
         YmpkGpkEA/pt0h5iAuAufnKBzlKW+uUrhLTVAL3MUGAJjCJbMx0vhLa0K6yX/KYEbg
         SyEAtdBHTFOxTt2FS/aPnVLQORceleG5Q/fSbzzgizPsff+RTauepnw54txoXTUKQa
         pQINieri4Z1XStxgzAvWM6NMqqtEMHR7SzjLQv0bQYgF3XdbuVVqfpDo2FMX0U7X6n
         X6Phup8BUK1UVZK0LBfWgKeQlVzZHov6Q7oXMNe4WT1T/jy7FJrn3Jp8OSntcAPuDd
         TM88CG8/3N3NQ==
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


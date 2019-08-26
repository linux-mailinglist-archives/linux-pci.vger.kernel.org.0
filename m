Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C29CA85
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfHZHcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 03:32:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10958 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfHZHcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 03:32:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d638af90002>; Mon, 26 Aug 2019 00:32:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 26 Aug 2019 00:32:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 26 Aug 2019 00:32:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 07:32:08 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 07:32:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Aug 2019 07:32:08 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d638af30001>; Mon, 26 Aug 2019 00:32:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 3/6] PCI: tegra: Add support to configure sideband pins
Date:   Mon, 26 Aug 2019 13:01:40 +0530
Message-ID: <20190826073143.4582-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826073143.4582-1-vidyas@nvidia.com>
References: <20190826073143.4582-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566804729; bh=ADNWY6D18iASNntieqTjCPp7lsXA6jQML9nnBWw895Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jeTwYT2iS12PPwyC0Ld8lTHD+FIuHUtHKTLihXLYR01J92uIwHuS1SM5KPu0l1+7R
         tkU+QwWZDkarpFCcFuZypPCqT8LaXzkBbS4sjg6XFtEHwnO/JsYd1YOH61vUrDoFxM
         ZO4JLVXN6+h4rC6+OAYDL0WDSuxdHtygD19VkaFfsjvk2PBumgRdBhL1Ma0W/aL0zg
         XRMeX2EvgZWOVHfjTtIf5m7GCc9wJfekjjQnzjOmWCOi5ROPRU5+vX1u3Ndy8L8nUS
         GRBZj0erUOlYsKcH7z+n90eDDpzz2hUBPb1muYLvH52BRKd4TI24ZfalA8Z8E5h+4T
         8Mpn/LJ85VQZQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to configure sideband signal pins when information is present
in respective controller's device-tree node.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc0dbeb31d78..8a27b25893c9 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1308,6 +1308,12 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		return ret;
 	}
 
+	ret = pinctrl_pm_select_default_state(pcie->dev);
+	if (ret < 0) {
+		dev_err(pcie->dev, "Failed to configure sideband pins\n");
+		return ret;
+	}
+
 	tegra_pcie_init_controller(pcie);
 
 	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
-- 
2.17.1


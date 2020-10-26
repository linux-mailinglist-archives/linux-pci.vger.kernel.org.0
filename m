Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7E298722
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770797AbgJZGzN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 02:55:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18151 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768361AbgJZGzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 02:55:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9672bb0000>; Sun, 25 Oct 2020 23:54:51 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:55:11 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:55:08 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 1/4] PCI: tegra: Fix ASPM-L1SS advertisement disable code
Date:   Mon, 26 Oct 2020 12:24:56 +0530
Message-ID: <20201026065459.28509-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026065459.28509-1-vidyas@nvidia.com>
References: <20201026065459.28509-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603695291; bh=/DUL5KI3q62bzSd7mI3FJUQl1oNiuiFR8PzvH9Fi7Hw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=BxocTS86r6UQCOJvcheF7vbGzAt17YNLqzqRr4cHaIPGI3gMqv3+E+JHttqz3lx0U
         7ouqlGShrt0JT4r06+5Rm4bFXFHof2RxwXiB9SthU1ZGBo+jPOe8dLIVJbhDz8jgpG
         kUW7+Cd3Gv5jj2q5xErFAyTzCTc0hHDmfoLQx2KB4xdVG8W8Xl54sUlvjEaU7SN9bu
         u/+CbJLHAzwwfNhdJU38Vdlv6p6LKhKCrQBFOzxO4ncHbC7qhM/JX5Tpmpl0spH+Mu
         bjwThcvZOVaU9AwLyLOelJjmRVzJUdq68dOTB3vDI47UfY2VeYjWc2XqnPW6qYwRXi
         f8+VCPUmOjhwQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the absence of CLKREQ# signal is indicated by the absence of
"supports-clkreq" in the device-tree node, current driver is disabling
the advertisement of ASPM-L1 Sub-States *before* the ASPM-L1 Sub-States
offset is correctly initialized. Since default value of the ASPM-L1SS
offset is zero, this is causing the Vendor-ID wrongly programmed to 0x10d2
instead of Nvidia's 0x10de thereby the quirks applicable for Tegra194 are
not being applied. This patch fixes this issue by refactoring the
code that disables the ASPM-L1SS advertisement.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index aa511ec0d800..b172b1d49713 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -896,6 +896,12 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 
 	init_host_aspm(pcie);
 
+	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
+	if (!pcie->supports_clkreq) {
+		disable_aspm_l11(pcie);
+		disable_aspm_l12(pcie);
+	}
+
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
@@ -1400,12 +1406,6 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 
-	/* Disable ASPM-L1SS advertisement as there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	return ret;
 
 fail_phy:
-- 
2.17.1


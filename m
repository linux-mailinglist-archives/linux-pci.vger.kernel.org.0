Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4612F85E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgACMoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:44:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10569 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACMoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 07:44:20 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f36f80000>; Fri, 03 Jan 2020 04:43:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 04:44:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 03 Jan 2020 04:44:20 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 12:44:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 12:44:19 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f371f0001>; Fri, 03 Jan 2020 04:44:19 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 1/5] soc/tegra: bpmp: Update ABI header
Date:   Fri, 3 Jan 2020 18:14:00 +0530
Message-ID: <20200103124404.20662-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103124404.20662-1-vidyas@nvidia.com>
References: <20200103124404.20662-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578055416; bh=CQGXHZYbyzfijuWfKoywjCBY7hwzaU1tc1bdNFjJ15g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UAQECaNkn3JLvEm3cUlVRmYz0XplAJUhnHJpmtPkUH4pQkNNXjrePkMCNod9FIdaA
         ckWME0pQVt3+XBMvxa0EygYuBtwUcQHFJ037+IlUAog0JEaN+eE0CA4fP3vbGcxHU/
         /3fAWquYabn5rLU4cjtnwiWZe9WGPFxV69IulSViY0tzVnOPlnhwJxzfNYxSVCJHI0
         mJaevwiQnsd+eTy30ppmMagJgLjGpKER9QJVNV51+FKFGfxRVA2xIFdq6wE3Mukpc5
         v8jUT49My1JJdBn63Gdrl/RLSCgOGxo3s/ij0JnRGT8o/TW8n33+cAj7h6fSwqUwGw
         0HQPbzCl2QY4A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the firmware header to support uninitialization of UPHY PLL
when the PCIe controller is operating in endpoint mode and host cuts
the PCIe reference clock.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Changed Copyright year from 2019 to 2020

 include/soc/tegra/bpmp-abi.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
index cac6f610b3fe..322d06e21918 100644
--- a/include/soc/tegra/bpmp-abi.h
+++ b/include/soc/tegra/bpmp-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #ifndef _ABI_BPMP_ABI_H_
@@ -2119,6 +2119,7 @@ enum {
 	CMD_UPHY_PCIE_LANE_MARGIN_STATUS = 2,
 	CMD_UPHY_PCIE_EP_CONTROLLER_PLL_INIT = 3,
 	CMD_UPHY_PCIE_CONTROLLER_STATE = 4,
+	CMD_UPHY_PCIE_EP_CONTROLLER_PLL_OFF = 5,
 	CMD_UPHY_MAX,
 };
 
@@ -2151,6 +2152,11 @@ struct cmd_uphy_pcie_controller_state_request {
 	uint8_t enable;
 } __ABI_PACKED;
 
+struct cmd_uphy_ep_controller_pll_off_request {
+	/** @brief EP controller number, valid: 0, 4, 5 */
+	uint8_t ep_controller;
+} __ABI_PACKED;
+
 /**
  * @ingroup UPHY
  * @brief Request with #MRQ_UPHY
@@ -2165,6 +2171,7 @@ struct cmd_uphy_pcie_controller_state_request {
  * |CMD_UPHY_PCIE_LANE_MARGIN_STATUS     |                                        |
  * |CMD_UPHY_PCIE_EP_CONTROLLER_PLL_INIT |cmd_uphy_ep_controller_pll_init_request |
  * |CMD_UPHY_PCIE_CONTROLLER_STATE       |cmd_uphy_pcie_controller_state_request  |
+ * |CMD_UPHY_PCIE_EP_CONTROLLER_PLL_OFF  |cmd_uphy_ep_controller_pll_off_request  |
  *
  */
 
@@ -2178,6 +2185,7 @@ struct mrq_uphy_request {
 		struct cmd_uphy_margin_control_request uphy_set_margin_control;
 		struct cmd_uphy_ep_controller_pll_init_request ep_ctrlr_pll_init;
 		struct cmd_uphy_pcie_controller_state_request controller_state;
+		struct cmd_uphy_ep_controller_pll_off_request ep_ctrlr_pll_off;
 	} __UNION_ANON;
 } __ABI_PACKED;
 
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC213987C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMSO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 13:14:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4677 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMSO0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 13:14:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cb36d0004>; Mon, 13 Jan 2020 10:14:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 10:14:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 10:14:25 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 18:14:25 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 18:14:25 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1cb37d0000>; Mon, 13 Jan 2020 10:14:24 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 1/5] soc/tegra: bpmp: Update ABI header
Date:   Mon, 13 Jan 2020 23:44:07 +0530
Message-ID: <20200113181411.32743-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113181411.32743-1-vidyas@nvidia.com>
References: <20200113181411.32743-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578939246; bh=ju2l2Bs83jaZ91tODF7C1ihiW86yISZwSsqAP7YxJMI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZayeXmpma382P7NwF4e7IcbK9qIJHOWTJSBchqeJ91qhWl+TlpVGVfqJ08g+mAEvo
         C2ayC1N7oWaowl98FVRdX+EhzGiqV6X+RBx5XgZKNiXqn8+YJcEgJ2RygQh+b6jZWm
         LGwVLzX4Ldw410eaSQm9bBYQAx6dKz77Ls1zn7kSh7bceudW32NRTgLgMVRHlGeSd9
         PoDuWimE+ePVG+309rEQ8tEErJ4bI34hFkaVIzR+UW7DAky1VmUjpdlO8nfQJZdd1z
         81HaDfQ/kMlesdcay++JkSU/1zrdXzgCzrP8FeGfm4+tGUbkK6P6JBTaxWws39vwvD
         7MdsKk2s/HThA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the firmware header to support uninitialization of UPHY PLL
when the PCIe controller is operating in endpoint mode and host cuts
the PCIe reference clock.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V3:
* Added Acked-by: Thierry Reding <treding@nvidia.com>

V2:
* Changed Copyright year from 2019 to 2020

 include/soc/tegra/bpmp-abi.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
index cac6f610b3fe..8f8e73e5cd45 100644
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


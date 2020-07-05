Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFD214B58
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgGEJST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:18:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46998 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgGEJSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:18 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2020 02:18:17 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 05 Jul 2020 02:18:11 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id A85DB213B5; Sun,  5 Jul 2020 14:48:09 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        sivaprak@codeaurora.org, mgautam@codeaurora.org,
        smuthayy@codeaurora.org, varada@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: [PATCH 4/9] clk: qcom: ipq8074: Add missing clocks for pcie
Date:   Sun,  5 Jul 2020 14:47:55 +0530
Message-Id: <1593940680-2363-5-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing clocks and resets for pcie port0 of ipq8074 devices.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/clk/qcom/gcc-ipq8074.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index e01f5f591d1e..443e28cda8ed 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4316,6 +4316,62 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
+struct freq_tbl ftbl_pcie_rchng_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(100000000, P_GPLL0, 8, 0, 0),
+	{ }
+};
+
+struct clk_rcg2 pcie0_rchng_clk_src = {
+	.cmd_rcgr = 0x75070,
+	.freq_tbl = ftbl_pcie_rchng_clk_src,
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pcie0_rchng_clk_src",
+		.parent_hws = (const struct clk_hw *[]) {
+				&gpll0.clkr.hw },
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gcc_pcie0_rchng_clk = {
+	.halt_reg = 0x75070,
+	.halt_bit = 31,
+	.clkr = {
+		.enable_reg = 0x75070,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie0_rchng_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&pcie0_rchng_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie0_axi_s_bridge_clk = {
+	.halt_reg = 0x75048,
+	.halt_bit = 31,
+	.clkr = {
+		.enable_reg = 0x75048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie0_axi_s_bridge_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&pcie0_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_hw *gcc_ipq8074_hws[] = {
 	&gpll0_out_main_div2.hw,
 	&gpll6_out_main_div2.hw,
@@ -4551,6 +4607,9 @@ static struct clk_regmap *gcc_ipq8074_clks[] = {
 	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
 	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_PCIE0_RCHNG_CLK_SRC] = &pcie0_rchng_clk_src.clkr,
+	[GCC_PCIE0_RCHNG_CLK] = &gcc_pcie0_rchng_clk.clkr,
+	[GCC_PCIE0_AXI_S_BRIDGE_CLK] = &gcc_pcie0_axi_s_bridge_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq8074_resets[] = {
@@ -4678,6 +4737,7 @@ static const struct qcom_reset_map gcc_ipq8074_resets[] = {
 	[GCC_PCIE0_AXI_SLAVE_ARES] = { 0x75040, 4 },
 	[GCC_PCIE0_AHB_ARES] = { 0x75040, 5 },
 	[GCC_PCIE0_AXI_MASTER_STICKY_ARES] = { 0x75040, 6 },
+	[GCC_PCIE0_AXI_SLAVE_STICKY_ARES] = { 0x75040, 7 },
 	[GCC_PCIE1_PIPE_ARES] = { 0x76040, 0 },
 	[GCC_PCIE1_SLEEP_ARES] = { 0x76040, 1 },
 	[GCC_PCIE1_CORE_STICKY_ARES] = { 0x76040, 2 },
-- 
2.7.4


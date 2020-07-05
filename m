Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D56214B76
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGEJTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:19:03 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:22188 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgGEJSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:17 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2020 02:18:17 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 05 Jul 2020 02:18:11 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 90DE9213B6; Sun,  5 Jul 2020 14:48:09 +0530 (IST)
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
Subject: [PATCH 3/9] clk: qcom: ipq8074: Add missing bindings for pcie
Date:   Sun,  5 Jul 2020 14:47:54 +0530
Message-Id: <1593940680-2363-4-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing clock bindings for pcie port0 of ipq8074.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index 4de4811a3540..e3e018565add 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -362,5 +362,9 @@
 #define GCC_PCIE1_AXI_SLAVE_ARES		128
 #define GCC_PCIE1_AHB_ARES			129
 #define GCC_PCIE1_AXI_MASTER_STICKY_ARES	130
+#define GCC_PCIE0_AXI_SLAVE_STICKY_ARES		131
+#define GCC_PCIE0_AXI_S_BRIDGE_CLK		132
+#define GCC_PCIE0_RCHNG_CLK_SRC			133
+#define GCC_PCIE0_RCHNG_CLK			134
 
 #endif
-- 
2.7.4


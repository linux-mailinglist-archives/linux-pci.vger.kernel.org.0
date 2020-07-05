Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B65214B70
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGEJSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:18:53 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:22188 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbgGEJST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:19 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2020 02:18:18 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 05 Jul 2020 02:18:11 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 5BA1721185; Sun,  5 Jul 2020 14:48:09 +0530 (IST)
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
Subject: [PATCH 1/9] dt-bindings: pci: Add ipq8074 gen3 pci compatible
Date:   Sun,  5 Jul 2020 14:47:52 +0530
Message-Id: <1593940680-2363-2-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ipq8074 has two PCIe ports while the support for gen2 pcie port is
already available add the support for gen3 binding.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index b119ce4711b4..b5ec45df735e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -22,6 +22,7 @@ properties:
       - qcom,pcie-ipq4019
       - qcom,pcie-ipq8064
       - qcom,pcie-ipq8074
+      - qcom,pcie-ipq8074-gen3
       - qcom,pcie-msm8996
       - qcom,pcie-qcs404
       - qcom,pcie-sdm845
@@ -330,6 +331,52 @@ allOf:
        compatible:
          contains:
            enum:
+             - qcom,pcie-ipq8074-gen3
+   then:
+     properties:
+       clocks:
+         items:
+           - description: sys noc interface clock
+           - description: AXI master clock
+           - description: AXI slave clock
+           - description: AHB clock
+           - description: Auxilary clock
+           - description: AXI slave bridge clock
+           - description: PCIe rchng clock
+       clock-names:
+         items:
+           - const: iface
+           - const: axi_m
+           - const: axi_s
+           - const: ahb
+           - const: aux
+           - const: axi_bridge
+           - const: rchng
+       resets:
+         items:
+           - description: PIPE reset
+           - description: PCIe sleep reset
+           - description: PCIe sticky reset
+           - description: AXI master reset
+           - description: AXI slave reset
+           - description: AHB reset
+           - description: AXI master sticky reset
+           - description: AXI Slave sticky reset
+       reset-names:
+         items:
+           - const: pipe
+           - const: sleep
+           - const: sticky
+           - const: axi_m
+           - const: axi_s
+           - const: ahb
+           - const: axi_m_sticky
+           - const: axi_s_sticky
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
              - qcom,pcie-msm8996
    then:
      properties:
-- 
2.7.4


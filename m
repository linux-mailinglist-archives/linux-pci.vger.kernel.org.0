Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7423219E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgG2Pb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 11:31:29 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10011 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgG2PbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 11:31:07 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jul 2020 08:31:04 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 29 Jul 2020 08:30:56 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id BB28021149; Wed, 29 Jul 2020 21:00:54 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, sivaprak@codeaurora.org,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: [PATCH V2 1/7] dt-bindings: PCI: qcom: Add ipq8074 Gen3 PCIe compatible
Date:   Wed, 29 Jul 2020 21:00:01 +0530
Message-Id: <1596036607-11877-2-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ipq8074 has two PCIe ports while the support for Gen2 PCIe port is
already available add the support for Gen3 binding.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 2eef6d5..e0559dd 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,pcie-ipq8064
       - qcom,pcie-ipq8064-v2
       - qcom,pcie-ipq8074
+      - qcom,pcie-ipq8074-gen3
       - qcom,pcie-msm8996
       - qcom,pcie-qcs404
       - qcom,pcie-sdm845
@@ -295,6 +296,52 @@ allOf:
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
+           - description: AXI secondary clock
+           - description: AHB clock
+           - description: Auxilary clock
+           - description: AXI secondary bridge clock
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
+           - description: AXI secondary reset
+           - description: AHB reset
+           - description: AXI master sticky reset
+           - description: AXI secondary sticky reset
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


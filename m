Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A60214B54
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGEJSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:18:18 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46989 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbgGEJSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:17 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2020 02:18:16 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 05 Jul 2020 02:18:11 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 6C0F6213B2; Sun,  5 Jul 2020 14:48:09 +0530 (IST)
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
Subject: [PATCH 2/9] dt-bindings: phy: qcom,qmp: Add dt-binding for ipq8074 gen3 pcie phy
Date:   Sun,  5 Jul 2020 14:47:53 +0530
Message-Id: <1593940680-2363-3-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ipq8074 has two different phy blocks for two pcie ports, with pcie gen2
compatible already available, specify the pcie phy compatible
for gen3 pcie port.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index f80f8896d527..3e8681679f53 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq8074-qmp-pcie-gen3-phy
       - qcom,msm8996-qmp-pcie-phy
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8996-qmp-usb3-phy
-- 
2.7.4


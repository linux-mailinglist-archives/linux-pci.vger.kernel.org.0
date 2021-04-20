Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0236577E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhDTLWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 07:22:22 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43030 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDTLWW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:22:22 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 475FA440E71;
        Tue, 20 Apr 2021 14:21:47 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC
Date:   Tue, 20 Apr 2021 14:21:40 +0300
Message-Id: <e285d5041b8c19d4a7fab4d1a3ce9dd2b487cbad.1618916235.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618916235.git.baruch@tkos.co.il>
References: <cover.1618916235.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document qcom,pcie-ipq6018. This is similar to the ipq8074 with a few
different clock sources, and one additional reset.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 0da458a051b6..25f4def468bf 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -14,6 +14,7 @@
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sdm845" for sdm845
 			- "qcom,pcie-sm8250" for sm8250
+			- "qcom,pcie-ipq6018" for ipq6018
 
 - reg:
 	Usage: required
@@ -123,6 +124,16 @@
 			- "ahb"		AHB clock
 			- "aux"		Auxiliary clock
 
+- clock-names:
+	Usage: required for ipq6018
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "iface"	PCIe to SysNOC BIU clock
+			- "axi_m"	AXI Master clock
+			- "axi_s"	AXI Slave clock
+			- "axi_bridge"	AXI bridge clock
+			- "rchng"
+
 - clock-names:
 	Usage: required for qcs404
 	Value type: <stringlist>
@@ -209,6 +220,19 @@
 			- "ahb"			AHB Reset
 			- "axi_m_sticky"	AXI Master Sticky reset
 
+- reset-names:
+	Usage: required for ipq6018
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "pipe"		PIPE reset
+			- "sleep"		Sleep reset
+			- "sticky"		Core Sticky reset
+			- "axi_m"		AXI Master reset
+			- "axi_s"		AXI Slave reset
+			- "ahb"			AHB Reset
+			- "axi_m_sticky"	AXI Master Sticky reset
+			- "axi_s_sticky"	AXI Slave Sticky reset
+
 - reset-names:
 	Usage: required for qcs404
 	Value type: <stringlist>
-- 
2.30.2


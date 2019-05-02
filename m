Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9C11097
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 02:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEBAUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 20:20:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39222 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfEBAUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 20:20:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so221251pfg.6
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOX2/9YMhYx6NwQ57eXLSGYkGV1gXg9VrE1XDNjSrv4=;
        b=PWfnoS+WyhcX6ZCm1ceySEc9ia93sr6Wr43eachngJm2pr+OtYajuR7/AGDwK8aoPB
         4+60xLNOQYtSVa9q9U5G3oE1A3USMYc9+RqBBnzrG8mdryPuT7/B18q4oWBj7tmJ6JD0
         mY05ObVxQPHYIt2+z1cUGbma0/XhF2p6s1KaOTKkEIoYCGOKbAwIWp+ceeqXf5IygLgD
         KearGa6MQyqRV+BzvUeaEcvsNo8bmNdHfSx+5PrjiP8ov3T5p9U6iVG7C/Vq3TLyEKtA
         ftSnzD1PO38LZIiFytFhuSGyLZpW8zC2BqMzBLWNFPFuQ2aSALAEY6vOmlpTMF7TiOJl
         BbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOX2/9YMhYx6NwQ57eXLSGYkGV1gXg9VrE1XDNjSrv4=;
        b=R4zgCMoA9ochURztpZnKsad4DuucenfIInkMzTGrrw3lNviQ+u2n8AavGQyowBivM8
         Dd0P4mJ/D4Gk9cn+Ra66w4dWmuzrDIKVN/t7ysZML1RnXGKIoyQrURNpbsZzQo/xkrQf
         D0wjh0bKzNuHo2JlvY98n93GT9AaZEftseAFr5A101VHtEtu3VHrD3oszwne0oFl6OQ8
         0K1q5EGK7Masvnh51/Shr3uk8HUhW41daM7UYt0GHSzF/Qv5iWiyIqn8uy027PB+XY8k
         74AweU4dbA0cM8n64mNVnWROt6KmMmGVqBrtoAuaPTlGRk3Knyv3Aq17+kV7kpZ0oDtG
         /PiA==
X-Gm-Message-State: APjAAAVwGOsOX4gOdQo/AV7aqmBSrrzw6AqoSlGsE6CHaGk4BN/sqnfk
        9BVdjKvJqMeNhLtIEV1DXlQCzg==
X-Google-Smtp-Source: APXvYqynrUdVA5xmmAy+LKXYbnIt4cdGdGVVgAoXehedevQSGPlYPMlpJAlKekuAwsF4gmdOp7CYMA==
X-Received: by 2002:a63:e10b:: with SMTP id z11mr855602pgh.46.1556756403251;
        Wed, 01 May 2019 17:20:03 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s198sm36927534pfs.34.2019.05.01.17.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:20:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] PCI: qcom: Add QCS404 PCIe controller support
Date:   Wed,  1 May 2019 17:19:55 -0700
Message-Id: <20190502001955.10575-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190502001955.10575-1-bjorn.andersson@linaro.org>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The QCS404 platform contains a PCIe controller of version 2.4.0 and a
Qualcomm PCIe2 PHY. The driver already supports version 2.4.0, for the
IPQ4019, but this support touches clocks and resets related to the PHY
as well, and there's no upstream driver for the PHY.

On QCS404 we must initialize the PHY, so a separate PHY driver is
implemented to take care of this and the controller driver is updated to
not require the PHY related resources. This is done by relying on the
fact that operations in both the clock and reset framework are nops when
passed NULL, so we can isolate this change to only the get_resource
function.

For QCS404 we also need to enable the AHB (iface) clock, in order to
access the register space of the controller, but as this is not part of
the IPQ4019 DT binding this is only added for new users of the 2.4.0
controller.

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 drivers/pci/controller/dwc/pcie-qcom.c | 64 +++++++++++++++-----------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d740cbe0e56d..d101bc5c0def 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -112,7 +112,7 @@ struct qcom_pcie_resources_2_3_2 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
+#define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
 struct qcom_pcie_resources_2_4_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
 	int num_clks;
@@ -638,13 +638,16 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");
 	int ret;
 
 	res->clks[0].id = "aux";
 	res->clks[1].id = "master_bus";
 	res->clks[2].id = "slave_bus";
+	res->clks[3].id = "iface";
 
-	res->num_clks = 3;
+	/* qcom,pcie-ipq4019 is defined without "iface" */
+	res->num_clks = is_ipq ? 3 : 4;
 
 	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
 	if (ret < 0)
@@ -658,27 +661,33 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->axi_s_reset))
 		return PTR_ERR(res->axi_s_reset);
 
-	res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(res->pipe_reset))
-		return PTR_ERR(res->pipe_reset);
-
-	res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
-								 "axi_m_vmid");
-	if (IS_ERR(res->axi_m_vmid_reset))
-		return PTR_ERR(res->axi_m_vmid_reset);
-
-	res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
-								"axi_s_xpu");
-	if (IS_ERR(res->axi_s_xpu_reset))
-		return PTR_ERR(res->axi_s_xpu_reset);
-
-	res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
-	if (IS_ERR(res->parf_reset))
-		return PTR_ERR(res->parf_reset);
-
-	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
-	if (IS_ERR(res->phy_reset))
-		return PTR_ERR(res->phy_reset);
+	if (is_ipq) {
+		/*
+		 * These resources relates to the PHY or are secure clocks, but
+		 * are controlled here for IPQ4019
+		 */
+		res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
+		if (IS_ERR(res->pipe_reset))
+			return PTR_ERR(res->pipe_reset);
+
+		res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
+									 "axi_m_vmid");
+		if (IS_ERR(res->axi_m_vmid_reset))
+			return PTR_ERR(res->axi_m_vmid_reset);
+
+		res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
+									"axi_s_xpu");
+		if (IS_ERR(res->axi_s_xpu_reset))
+			return PTR_ERR(res->axi_s_xpu_reset);
+
+		res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
+		if (IS_ERR(res->parf_reset))
+			return PTR_ERR(res->parf_reset);
+
+		res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
+		if (IS_ERR(res->phy_reset))
+			return PTR_ERR(res->phy_reset);
+	}
 
 	res->axi_m_sticky_reset = devm_reset_control_get_exclusive(dev,
 								   "axi_m_sticky");
@@ -698,9 +707,11 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->ahb_reset))
 		return PTR_ERR(res->ahb_reset);
 
-	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
-	if (IS_ERR(res->phy_ahb_reset))
-		return PTR_ERR(res->phy_ahb_reset);
+	if (is_ipq) {
+		res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
+		if (IS_ERR(res->phy_ahb_reset))
+			return PTR_ERR(res->phy_ahb_reset);
+	}
 
 	return 0;
 }
@@ -1268,6 +1279,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
+	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ }
 };
 
-- 
2.18.0


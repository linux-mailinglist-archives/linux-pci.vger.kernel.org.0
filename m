Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4625214B5A
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGEJSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:18:25 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:47006 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgGEJSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:24 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2020 02:18:23 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 05 Jul 2020 02:18:17 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id F0F51213CC; Sun,  5 Jul 2020 14:48:09 +0530 (IST)
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
Subject: [PATCH 7/9] pci: dwc: qcom: do phy power on before pcie init
Date:   Sun,  5 Jul 2020 14:47:58 +0530
Message-Id: <1593940680-2363-8-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit cc1e06f033af ("phy: qcom: qmp: Use power_on/off ops for PCIe")
changed phy ops from init/deinit to power on/off, due to this phy enable
is getting called after pcie init.

On some platforms like ipq8074 phy should be inited before accessing the
pcie register space, otherwise the system would hang.

So move phy_power_on API before pcie init API.

Fixes: commit cc1e06f033af ("phy: qcom: qmp: Use power_on/off ops for PCIe")
Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 138e1a2d21cc..aa52a2124760 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1222,18 +1222,18 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_assert(pcie);
 
-	ret = pcie->ops->init(pcie);
+	ret = phy_power_on(pcie->phy);
 	if (ret)
 		return ret;
 
-	ret = phy_power_on(pcie->phy);
+	ret = pcie->ops->init(pcie);
 	if (ret)
-		goto err_deinit;
+		goto err_disable_phy;
 
 	if (pcie->ops->post_init) {
 		ret = pcie->ops->post_init(pcie);
 		if (ret)
-			goto err_disable_phy;
+			goto err_deinit;
 	}
 
 	dw_pcie_setup_rc(pp);
@@ -1252,10 +1252,10 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	qcom_ep_reset_assert(pcie);
 	if (pcie->ops->post_deinit)
 		pcie->ops->post_deinit(pcie);
-err_disable_phy:
-	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+err_disable_phy:
+	phy_power_off(pcie->phy);
 
 	return ret;
 }
-- 
2.7.4


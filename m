Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939A954C995
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiFONQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351651AbiFONQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 09:16:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43202DD53;
        Wed, 15 Jun 2022 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655298971; x=1686834971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wzF6b6MTfDg6r5cQXsyGjFsRdC++A5N+KLhQ3vIsIjo=;
  b=GcchhxsvU9tYLShKkgwTRgpfC6AXfF5HeoIcyFp/u4fmZHgmufc7raju
   TD0vKKQSKyddZyeqFbD0qhnXqKxqsNEsMHFUjZq8q9HbHVJpmujt4/rfh
   PQOpMz/ZhWQMoSWivgQ0ZUVVQvap4eKxxWkjr1+kWHu32C3/xSz9PFV28
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Jun 2022 06:16:10 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2022 06:16:07 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 Jun 2022 18:45:44 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4FDBF414F; Wed, 15 Jun 2022 18:45:43 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: qcom: Allow L1 and its sub states
Date:   Wed, 15 Jun 2022 18:45:39 +0530
Message-Id: <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow L1 and its sub-states in the qcom pcie driver.
By default this is disabled in the hardware. So enabling it explicitly.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab9089..0d8efcc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -41,6 +41,9 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
+#define PCIE20_PARF_PM_CTRL			0x20
+#define REQ_NOT_ENTR_L1				BIT(5)
+
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -1267,6 +1270,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val |= BIT(4);
 	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
 
+	/* Enable L1 and L1ss */
+	val = readl(pcie->parf + PCIE20_PARF_PM_CTRL);
+	val &= ~REQ_NOT_ENTR_L1;
+	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
+
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
 		val |= BIT(31);
-- 
2.7.4


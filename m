Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870AC19C0D7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbgDBMML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33325 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbgDBMMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so3841800ede.0;
        Thu, 02 Apr 2020 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDYxV67s8P5RgobB2MSQS+2SI1Pzl0kBmeEF5B8gAR8=;
        b=vGv46FzwXEGLJw8mRO55Ylg5m9OIyZAnDw1z2dVQ8iKg/h31tQKamcQhTbMH5hhCU2
         e78cgHcWuqWUwuWJS3VuOckj37vERlfSxdqn/AOL/lTFF+upUy641boO2llgVNrXCZ5O
         ApAoo2uXz+HKIME05jcICx4GbUPI8kanLPteAU3sG0l0lIgY6lbWzV9Xk4XWTIfkMIt4
         kG0O5qet6Wgq4yKSwvaIUmg0L29BhrQGfekYVKk2rnkpX3Le1FWa50L7Vk9sDyielU16
         EcT31ajnaiHq05plJIVRMFTANdIzFwmbZTAHFAKSUxMWhVtLDR/E7DnkBW+98w9eTZu2
         KVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDYxV67s8P5RgobB2MSQS+2SI1Pzl0kBmeEF5B8gAR8=;
        b=PE37ke8ZVURBoxSDxMAo6zXrKAImeUaYXHRlioX03GLX7jBEKufy+6cjS3ExY1asIp
         qMpEHKXSIK+v5knjf9NC35SV3BgvM1qF1eQ+lA2rp9eXFL3typDCPfhhBh3OvCLoMsme
         MZT+PzA/uE8smE8g5DN47gkgzMANPl0f8xypalSXq3FSbeInFvKaiFcBWx1Gs5kAdU8B
         aOE6XSAqj50UGj3czUzYrB3sJzk1AmcLrqdL9/ZMcPxzl+pwMF2yunl0EA/WVziDr/be
         i0SNVKmUUa07C/iE6butE/2b5nh87ynrzcadgpNGSLYKkzTT1XLNGe7yJ8n9qcq4Lntf
         9VQQ==
X-Gm-Message-State: AGi0PuahOHLxe67Qafcu0fQ6Xz5ntHsKSYHkTrHFFXSn67mNSqbQ9Qat
        gs24Jzl6xPFrL8jxdwa1KlA=
X-Google-Smtp-Source: APiQypJWUSMKw1fpV8OosLT3iblRQBPuFwagUnBBdYDxqBWaoTGAjxGCq5AJ2rX4sedeCqmrLf0Faw==
X-Received: by 2002:a50:d987:: with SMTP id w7mr2501574edj.276.1585829527306;
        Thu, 02 Apr 2020 05:12:07 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:06 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] PCIe: qcom: add missing reset for ipq806x
Date:   Thu,  2 Apr 2020 14:11:42 +0200
Message-Id: <20200402121148.1767-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing ext reset used by ipq806x SoC in PCIe qcom driver.

Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 596731b54728..211a1aa7d0f1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -95,6 +95,7 @@ struct qcom_pcie_resources_2_1_0 {
 	struct reset_control *ahb_reset;
 	struct reset_control *por_reset;
 	struct reset_control *phy_reset;
+	struct reset_control *ext_reset;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
@@ -272,6 +273,10 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->por_reset))
 		return PTR_ERR(res->por_reset);
 
+	res->ext_reset = devm_reset_control_get_exclusive(dev, "ext");
+	if (IS_ERR(res->ext_reset))
+		return PTR_ERR(res->ext_reset);
+
 	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
@@ -285,6 +290,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
+	reset_control_assert(res->ext_reset);
 	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
@@ -343,6 +349,12 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_deassert_ahb;
 	}
 
+	ret = reset_control_deassert(res->ext_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert ext reset\n");
+		goto err_deassert_ahb;
+	}
+
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
 	val &= ~BIT(0);
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D11FA279
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgFOVGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgFOVGp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81864C08C5C5;
        Mon, 15 Jun 2020 14:06:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so18972308eja.7;
        Mon, 15 Jun 2020 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1JV3CXtWnCDf52pi6FDmUEpTUr0tLhuu541saxjHEI=;
        b=Z4pY9opfhhvGea/MOsllxIaNmvyJGxZq48BRu+78lWmOHGt/CRLVSdJBc5pNAjpXHX
         MTK1X+UC3oq+jADFPxMw3RFixQoVxqGxyEV2myuabTpGQusza9gKTzLR8GaYxtqpobJ/
         N/Xn/fYAiIP3dh8FrcXpTxpkIYQ3apCrpRjDrpXdCMOjbj5fi5jzIhU7pLr+X2Au9JIX
         w33lHhOY0nztFZ7cOZvH8xmY8SAvDWz+4j67n4D7xfRoY93MdZd1flfl0X+nCHtM4Hsi
         0VELaneQkb88GPsN5ruEpfY1Q/3gBdsK4HG5HGXpsw2rf56C8rupaCLjvZMPyFQzVpeo
         GyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1JV3CXtWnCDf52pi6FDmUEpTUr0tLhuu541saxjHEI=;
        b=ucNswi4DtA+0UrdGlBckvTGLZoXptfumHeCCs2lXQZhFO22KmFhJR3IBv/425G9tjO
         0xDhq2Wmzno19TLvoM+2YbZdkXfatoYKAnEFnHR7a0uVzW+5IlGRHqBTj1VjmssOpQUm
         JePHlfqBZtBSbh8WXH28BPuGxXTNq9dU6abfFoWD+3EWM0xXXHk+PmUNuO8qsSBk5zXA
         aft++8/DcyU45IXAsec9drTCmxOR8s5P6rU67raZFzeHT3PyVyIwJA3fBliOa+C9/tIs
         hKe3YNN8oDBHG4EqcCZvToVF+EzffQlYuoNEGVTJhD22QmmU5Ly7jSmDXy9cmrcRvzHc
         CuEQ==
X-Gm-Message-State: AOAM530TUrHR9DwMIx3lED/lAmc8YVrfMuAayLYQHbz0qFAUBACMOJ+P
        J0/SKYelXq0QjjcnOskHSWE=
X-Google-Smtp-Source: ABdhPJxlXYUjd15RFk8CBG6UIc9d/yo7kuVUtZIdTWjh+B9ECG73/qaJPjEYy/EXD89DLyDCtK6blQ==
X-Received: by 2002:a17:906:1184:: with SMTP id n4mr5224874eja.115.1592255202187;
        Mon, 15 Jun 2020 14:06:42 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:41 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/12] PCI: qcom: Replace define with standard value
Date:   Mon, 15 Jun 2020 23:06:08 +0200
Message-Id: <20200615210608.21469-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lots of define are actually already defined in pci_regs.h, directly use
the standard defines.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c40921589122..a23d3d886479 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -40,11 +40,6 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PCIE20_COMMAND_STATUS			0x04
-#define CMD_BME_VAL				0x4
-#define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
-#define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
-
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -73,8 +68,8 @@
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
 #define PCIE20_CAP				0x70
-#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + 0xC)
-#define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT	(BIT(10) | BIT(11))
+#define PCIE20_DEVICE_CONTROL2_STATUS2		(PCIE20_CAP + PCI_EXP_DEVCTL2)
+#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + PCI_EXP_LNKCAP)
 #define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
 #define PCIE_CAP_LINK1_VAL			0x2FD7F
 
@@ -1095,15 +1090,15 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		pcie->parf + PCIE20_PARF_SYS_CTRL);
 	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
 
-	writel(CMD_BME_VAL, pci->dbi_base + PCIE20_COMMAND_STATUS);
+	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
 	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
 
 	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
-	val &= ~PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT;
+	val &= ~PCI_EXP_LNKCAP_ASPMS;
 	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
 
-	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
+	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base +
 		PCIE20_DEVICE_CONTROL2_STATUS2);
 
 	return 0;
-- 
2.27.0.rc0


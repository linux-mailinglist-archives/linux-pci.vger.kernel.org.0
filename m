Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AAA1FA27D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgFOVG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbgFOVGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B885C061A0E;
        Mon, 15 Jun 2020 14:06:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o15so18949132ejm.12;
        Mon, 15 Jun 2020 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qk9kJyl6xBs7NFHSty0oErpx4zGo0ReUFZlbaqRNYPs=;
        b=dkzP8Jq0x2fUTU2b/tFozk9+Wun/+haYoHAexmI0WJHmv809aW5/yvxZ1GypsufitD
         3NlVoyV5/l61fORMPFRcytjQykeS5IAHtjgHdqgb8DNVhwiKGUWcsHOzex5bKPrELkmj
         lD1AzH70nmiAYLOF+Kmn6mL2NOXaIWX8xc5YCYpWUhFStBfMO96BovNv2rwBRjTSGo6r
         HnaxRnnkD/JyGYvYT15MQN8UNI8uL/9npOHFQH/NH0Uh9mteI+ayy+JT3gAQP7+TscCK
         HoSA6Lfu2WlKWkIsPhNwxULBoJH7Ixf4fVEwQVnkaKM6qpBWfsLbkw+lB1NTPrZdFrQF
         BOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qk9kJyl6xBs7NFHSty0oErpx4zGo0ReUFZlbaqRNYPs=;
        b=t3PcV21CO6atk3WmJMEfPEl86rexizePn06bPnKPLEU/Vr6nRqk+fcBCTx1dPxHFcu
         nasgEPtLOoqSQbagE5cQy1EyWuFSAa7BU66A+rTvi8xdiO7vEXGu/4MawvI4+3+yDdMc
         VeMqvJrCbHAAKcsT/axGSr3rftxFeud6aFDActaFM5HJTb+wMuvIgyGms0cwyN+kV1Wm
         sninM8CNqCArn3VshSHxjg8oTdlthuFWX3Qv2i0uZrxiwUPUqrDYP5RRZfnWOhxOjswG
         DCHcVyWKwGysJgvPNYgZM/p3xIk1QSGW8z0X18H9u5KgA1hsPXXjgu0W7Jdg7kQFj4ad
         C7AA==
X-Gm-Message-State: AOAM533t78lwLak31uj+EOLWNzFHrsF6yXWrPTJlfKzTWVUcgqZrg2pW
        HlXMWDjQbRIiqcFr7vWDdgw=
X-Google-Smtp-Source: ABdhPJyc4yxO4q5FGFJ0IFqE2jFCbHKF/8kBv0fGSC41jRkaEwAla+s9I7WWysulTAldPZOp6frCsA==
X-Received: by 2002:a17:906:2581:: with SMTP id m1mr8061904ejb.89.1592255199974;
        Mon, 15 Jun 2020 14:06:39 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:39 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/12] PCI: qcom: Support pci speed set for ipq806x
Date:   Mon, 15 Jun 2020 23:06:07 +0200
Message-Id: <20200615210608.21469-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Some SoC based on ipq8064/5 needs to be limited to pci GEN1 speed due to
some hardware limitations. Add support for speed setting defined by the
max-link-speed binding. If not defined the max speed is set to GEN2 by
default.

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 259b627bf890..c40921589122 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define PCIE20_PARF_SYS_CTRL			0x00
@@ -99,6 +100,8 @@
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
+#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
+
 #define DEVICE_TYPE_RC				0x4
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
@@ -195,6 +198,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	int gen;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -395,6 +399,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
+	if (pcie->gen == 1) {
+		val = readl(pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
+		val |= PCI_EXP_LNKSTA_CLS_2_5GB;
+		writel(val, pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
+	}
 
 	/* Set the Max TLP size to 2K, instead of using default of 4K */
 	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
@@ -1397,6 +1406,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
+	if (pcie->gen < 0)
+		pcie->gen = 2;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
 	pcie->parf = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->parf)) {
-- 
2.27.0.rc0


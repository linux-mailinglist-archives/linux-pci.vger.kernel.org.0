Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85F61EBB0F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgFBLy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBLy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58405C061A0E;
        Tue,  2 Jun 2020 04:54:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j10so3089533wrw.8;
        Tue, 02 Jun 2020 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7M0pgcCpgKIyPa/msmRAjsWPWr7rOEx9Iq4gL/Ihm/M=;
        b=MABAl+mEplCv5avjexorM4MeCMlpqiWsDvbKgPGJa8TCuGMSFtIOLMF9a3HPXQcuQs
         qzzFlsMc1kcTv1VBaZ5qUbMdmwUtJCqdq0GHpDJxFJFgUhv1U5Sl34NiNdoLcLEnME8+
         5RmYc/ysWbT4k5xpaoTKWrizTrQTaRIz5xVrO0lbV56z0WypNdFcfyQtai+EU7wX7hiM
         qe1utxf0Ua6i7W0a4Cy/CV1Nxjgo6iScq+l1FErSp5xVYwK57oijSK08oS1pDMCM3Z8Q
         +E/y6R913frD++QMrhszSRFy0I3Vwi6aiSwXoV5tIjYV3o3tR1XAxsNraF1BY/ddPKJP
         1ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7M0pgcCpgKIyPa/msmRAjsWPWr7rOEx9Iq4gL/Ihm/M=;
        b=dAjcndXn+ck8S0L6kSwJF0B5ZnSyWE4GnOEDKOjaMFvzxKBu3SeXxtKYbJh0+2i+ED
         8Tp8PY80kCD8Nyig+T3zTAP6eHKrI9HxCxamj73LVtFbXFJdi2xWd8jpxGDRBNZoc3Aa
         TvT2fKnEdW7d3h31EuUjuioweKKQdhQNJJfVeaq/OQwo5dgWl3B5nb4Ym0xYEZ9H0dgb
         Oo+Yo3hQR2CjeElH2O6T/YdsIHO5irijBh8QM2Aut4tqGnOHhbMmy0LiRJ0Z+qohMKtH
         aEsuyJ2SNfWk05MLdK+C4xqHMCdd3wTnEmVPNgiMK/F7fpiC2fu0+gucCys2Ve3622ay
         +drg==
X-Gm-Message-State: AOAM532DDj9qkiSf8mnzrYwvBukak2AyiZHxnRfApTOI6A9cwBFJdhg2
        SB4yEZ52zJSAGv7ELoDKScYA3kRAtBGjow==
X-Google-Smtp-Source: ABdhPJypOIwgcVbOKZfGKseAXLeB7agS7aD0IDuLQSIbdUKttZtsgODYJZ3f2BbVpqx6ZtbHjdU+Ew==
X-Received: by 2002:adf:c391:: with SMTP id p17mr24817566wrf.243.1591098893955;
        Tue, 02 Jun 2020 04:54:53 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:53 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
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
Subject: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
Date:   Tue,  2 Jun 2020 13:53:52 +0200
Message-Id: <20200602115353.20143-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add Force GEN1 support needed in some ipq8064 board that needs to limit
some PCIe line to gen1 for some hardware limitation. This is set by the
max-link-speed binding and needed by some soc based on ipq8064. (for
example Netgear R7800 router)

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 259b627bf890..0ce15d53c46e 100644
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
+		val |= 1;
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
2.25.1


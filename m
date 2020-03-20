Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A80418D73D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCTSfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44481 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id z3so8266718edq.11;
        Fri, 20 Mar 2020 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGZNkaeSgH2Ia/qzhM5CNeT0pv+X7+3+Gb2pdjSMGCU=;
        b=rBAXr6Sf2nZ5TYuifwsb71mUsVZl34Q5Nb/L02j2b8yzwjCUnPFUuz4XfHWFlw4was
         dVfwR6ftScUpNVUNOgGxJG7kcFsd63d4Pb6k7apa0UdiiQKaPEkIYRqe3txhde/xN+Dp
         kpH6x0wvGtKloqgHtc2G7T235cg2aAG3mo/fZp3mVC0bBSgAnbfAaDL8lixk6bhbYumH
         maKA9PbACjkGTMJFWGLDeu1l59O2H+hBfz4F31ruUtWui6ZTnV3lie+PsJYiBCGcONTL
         n/gyeYQs0cgmsT8VU6cssE3r4YHFYzlj3f8vSPcLIp/yHwJKtA7jd5o83veckyVYjcYP
         nlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGZNkaeSgH2Ia/qzhM5CNeT0pv+X7+3+Gb2pdjSMGCU=;
        b=rGDooNJ06IH7gOBsDvkqTG1AqDGGyJYQtsznOXkp0Tuhksiod+vEL/YKe2APn1u2Kw
         +aaZxLNisxRqlVIFG+tRQuNm87c4xpn93nqT/78cOBYQs/VryJ402aPj93fN0p9TqvRe
         CzZqcZvXWuJL+v039rWQAsYxnuDWbzHvWYmX0hW/vvuZIsN56MdkblUu1hRxcdA+VRaa
         v151msPYzsuK1CAdvrfYjdH7uUaPTNRBbBUcUlknnkYRVuHyhW/VyhFSPIu5vl+5XTQw
         xZmuXZ/+myvh9FD1SADjbfVLfiuzmIq2clZF+rSe1UZjEjt4wq7JSj/7U8PA76UEqr9I
         fnxg==
X-Gm-Message-State: ANhLgQ2hWa9PJCdS2+brg5dkUz/SZQyZq8M3hHgHrRjevEpCPU60Lm/Y
        jjShIeWB3IAUlK58p+ArFlo=
X-Google-Smtp-Source: ADFU+vviOQwMW3HASaguuY6rBmj6IAJbDOHwyuY4ghziSVXDR/mOHFhjkk1oj9CihWdLHFXlxW8pyw==
X-Received: by 2002:a17:906:fc01:: with SMTP id ov1mr9556367ejb.65.1584729329072;
        Fri, 20 Mar 2020 11:35:29 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] pcie: qcom: add Force GEN1 support
Date:   Fri, 20 Mar 2020 19:34:52 +0100
Message-Id: <20200320183455.21311-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add Force GEN1 support needed in some ipq806x board
that needs to limit some pcie line to gen1 for some
hardware limitation

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e26ba8f63d4f..03130a3206b4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -123,6 +123,8 @@
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
+#define PCIE20_LNK_CONTROL2_LINK_STATUS2        0xA0
+
 #define DEVICE_TYPE_RC				0x4
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
@@ -223,6 +225,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	uint32_t force_gen1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -515,6 +518,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
+	if (pcie->force_gen1) {
+		writel_relaxed((readl_relaxed(
+			pcie->pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2) | 1),
+			pcie->pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
+	}
 
 
 	/* Set the Max TLP size to 2K, instead of using default of 4K */
@@ -1487,6 +1495,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
 	int ret;
+	uint32_t force_gen1 = 0;
+	struct device_node *np = pdev->dev.of_node;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1517,6 +1527,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	of_property_read_u32(np, "force_gen1", &force_gen1);
+	pcie->force_gen1 = force_gen1;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
 	pcie->parf = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->parf)) {
-- 
2.25.1


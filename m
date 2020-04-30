Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88A71C0A10
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgD3WHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgD3WHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:07:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432AC035494;
        Thu, 30 Apr 2020 15:07:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr25so5994238ejb.10;
        Thu, 30 Apr 2020 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5A/crgfZBL8YxYLkhsNHl2s+K8l8jm+GhQ951aW+/A=;
        b=bhmK4NgXPzg+9b2pTOX7XMP/8EMjfOr97em1PZUZZXthc6eMXBGfuItM+KkSQhVpcF
         W7IIcBrQYURVrkZG1CaFst8mjutMNOKwDPVEWr7ff2McocuUlPz2yyZ3BGOBVEUeK4/9
         sBu0ua1seONVYb5fq93X6RP3WbVv6pImCErSiG6orXkOmFmTDepfVmQV9cfu0N2ULAMr
         dmNEVP7UhsFWNot3hmrq0G7sW+2+iczzDnEvMWAXbCFagqTe0GsYFM5f2RKgNC7MnZQV
         hAiOHn1Xkod++cixNMgfXyE8hCsfxYMDddOVCUrH623VmHeVXjseSc1nurTr/go0gnUk
         sbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5A/crgfZBL8YxYLkhsNHl2s+K8l8jm+GhQ951aW+/A=;
        b=PzFAsfW4yyQ5chCFc4avwg/Ler6drwzaR1xnRqXzdd31MW6TtHfsO9aK+LzAOmFd9S
         t5qO3By8CSdShQ8enq8SNCssy4df2XgRpRSHf27pQeYImxbfN6qbB0hLbrd6NeS1tcHZ
         j900TyKIKo4pULSKNWhpt00LwJDzhk2VBNYBhz5hhmjat6UgWU4OvMGy35yo4uW+RB6H
         qb6OMdF5/h0XQP60UE/77vBCzlpGkff2pJCZSSVB/2+363Zam3v7HPf/MYtPQ8+JRTqm
         yMS56zDD/AOq2ioB6Me/bKHyuWHyZMX7dlQD/929PxhWPiLtOce19da0LNkfiGMeNGtm
         hKAg==
X-Gm-Message-State: AGi0PuZidYlXaYBCg8apC0w9/Q7WvE04HVgImQo0x6/UStPrTt/qqpfn
        hNAzGPjIelcJbkoOf+Tg/sM=
X-Google-Smtp-Source: APiQypLzZJfog1vNc6Uoeh95qV8hGH+RRLoLGbJzYGzYvuO7ke/M2nr92ZgUv1ctCRRYieb/Nvolig==
X-Received: by 2002:a17:906:4e50:: with SMTP id g16mr570966ejw.338.1588284423757;
        Thu, 30 Apr 2020 15:07:03 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:07:03 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] PCI: qcom: add Force GEN1 support
Date:   Fri,  1 May 2020 00:06:18 +0200
Message-Id: <20200430220619.3169-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add Force GEN1 support needed in some ipq8064 board that needs to limit
some PCIe line to gen1 for some hardware limitation.
This is set by the max-link-speed binding and needed by some soc based
on ipq8064. (for example Netgear R7800 router)

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 372d2c8508b5..a568f28645e7 100644
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
@@ -205,6 +208,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	int gen;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -462,6 +466,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
+	if (pcie->gen == 1) {
+		qcom_clear_and_set_dword(pci->dbi_base +
+				PCIE20_LNK_CONTROL2_LINK_STATUS2, 0, 1);
+	}
+
 
 	/* Set the Max TLP size to 2K, instead of using default of 4K */
 	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
@@ -1431,6 +1440,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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


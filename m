Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42421F58A7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgFJQHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbgFJQHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2EEC03E96B;
        Wed, 10 Jun 2020 09:07:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so3194588eja.7;
        Wed, 10 Jun 2020 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBawc5k6GxDTKkYoHLQZS2nVPl6YhwGiJUu0dW6sBLY=;
        b=Gw+n06Xh+9mlnB6Qq6ff5reYXGcVg6OypuPAc0+0amLiFLWO70fTOpvE88LwYtjYkZ
         qj4398gCR9Azojwj+5EXAw2iNhdVo/DIT9JkKQ0eODsIjmK7bTD5yy/fmd0lvG+1p4Vp
         zDzubVYds6eTSQVLTeGLqXx0CROZpxuYKDYEamwupuH3sUnJ76gqrX1YgiyFS4ayb7se
         UN6S60jMRDuI0co55E7l7VbLcHtuwmUsyM/gmavNdIRmGKtpPbhGU1fUcwdT8Eea4Xi5
         VLFIYKx7oDGI8eGWqPDxhwD2wd7L+2+JQiJKZi/a68PIObreeL0XiW+GnRo6ihDZ0Y/Z
         AdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBawc5k6GxDTKkYoHLQZS2nVPl6YhwGiJUu0dW6sBLY=;
        b=ta0Sk4EG4Qavr7m9/PZCL6+liMfaObD8vAS5QLhDog9w3VZ8crYQ44DbWApXVN9nH/
         96PyLXjsZcSaZNgfq5YXJXZL1wZSQ2cIfdPdS3gealKFAscKbwmu1JnOWkZTby89cNFD
         iESv4C7ATjyEvjExqpdP+B6ixtX78dVSJX6T/uqSkPPepqOWj8bupPqbqi6lS6oFfK7O
         MDEspLtuTxrpUg3Epg/12PnbS5Xt3OiA1pUJsV+/rcigRXrovWkcfWA6vZoblLYwK3iP
         exPH0nZ20M+RqCiWweu1KAjAefiED3L2UZdvJrby3fGEoP5PCLDntv5Va+MIjkHCEi0b
         WHYw==
X-Gm-Message-State: AOAM532xr4FKPcb/1KX2p59pfpTfzFZ53+GgcJobAsJiRR4WYj+4FLA4
        wWspuhP7wTnroYn3E9TkRkM=
X-Google-Smtp-Source: ABdhPJwiYTeGguvYZa0LgBVb566b/fEUL0GY/Kiywrpja0bmnzGWRJkmgPhiqMJdaI6XG2yTlc7VOA==
X-Received: by 2002:a17:906:e0cf:: with SMTP id gl15mr4290108ejb.501.1591805255138;
        Wed, 10 Jun 2020 09:07:35 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:34 -0700 (PDT)
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
Subject: [PATCH v6 11/12] PCI: qcom: Add Force GEN1 support
Date:   Wed, 10 Jun 2020 18:06:53 +0200
Message-Id: <20200610160655.27799-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
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
2.25.1


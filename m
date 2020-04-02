Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4F19C0D1
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbgDBMMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46489 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbgDBMMW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id cf14so3744598edb.13;
        Thu, 02 Apr 2020 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpfK5CYxI8iAPFcZqyQcL5PaZpDr+KrVab+ErVI0E9A=;
        b=uVKjtr9Z2nepMqEDTiTNNduDfcQJhvvNnmcyS8yfwHjpDvWzEIMZz0lRCYqqz8EoQh
         MSmE0pl+mSAZNhfA9/7nz32tzqB3NOdIlvpeqtbwPGqFbk4pX1MyiMo2zFL2v/H6dEFB
         cPJyWiU3Wqu6OFboT+zFQj3b/26oTBr5026kW601iqMQh1wuc+LdDb4xenB5wHhgXOBx
         cTPErLGCyz6VGn/uTIOlXVvAV/0JR2N7jNnl0wr8rWJsIBGMEJ+JNhFNVLNOOwvjx5jb
         0Pp2KFAlPvZs1D+EWdph5/O5Jx661nzq3sKTvehAq6nOvmqh2Ua936zmS58Ku64XQvn8
         Hf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpfK5CYxI8iAPFcZqyQcL5PaZpDr+KrVab+ErVI0E9A=;
        b=W2pew44VtueUFF6FzjeByfHzvx70hu2Ciz56ckwzgwZfzLQhUItyhAN9dTO5ZunpBK
         yKYg0Oki1iqF7fYhibbcYbluCKqlsDPeSgULrY40UGr02NkTxbKwsdvlcvlYcVeyfcs4
         95dIEZXe/xka65jwVCuTTII1b0ziFfolEXH2wbVANSA3t0RlZN1JTZAA/KRnzGAWgpy2
         WPf8i/4j6RksMYaC0Dupvyjvx1oym4+6rdVIOBOtvqxvAVSeegSN8ue4IdieQiUfxV1P
         NJU24yPhr/tutWA/bOI065dSBXAIdv/CkQCiSSEofLqIFF+KRZ2RPts3KyroTF+YwV0N
         77iA==
X-Gm-Message-State: AGi0PuZUS4A+cXrQ/oMtV/zRPZgaAfcQsFall4oberEZCgOygEXU+bHZ
        Gb4nHaoCsQDb4SwBqVWoUaU=
X-Google-Smtp-Source: APiQypIPnU/+DrVqHsBOAMuaMwGL5dXkm117kJM04jvdu64bzzV0k35KALXEyjji5Vk3p5vPMd/48A==
X-Received: by 2002:a17:907:aab:: with SMTP id bz11mr2764943ejc.311.1585829540059;
        Thu, 02 Apr 2020 05:12:20 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v2 10/10] PCIe: qcom: add Force GEN1 support
Date:   Thu,  2 Apr 2020 14:11:47 +0200
Message-Id: <20200402121148.1767-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add Force GEN1 support needed in some ipq806x board
that needs to limit some pcie line to gen1 for some
hardware limitation.
This is set by the max-link-speed dts entry and needed
by some soc based on ipq806x. (for example Netgear R7800
router)

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8047ac7dc8c7..2212e9498b91 100644
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
 
+#define PCIE20_LNK_CONTROL2_LINK_STATUS2        0xA0
+
 #define DEVICE_TYPE_RC				0x4
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
@@ -199,6 +202,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	bool force_gen1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -441,6 +445,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
+	if (pcie->force_gen1) {
+		writel_relaxed((readl_relaxed(
+		  pcie->pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2) | 1),
+		  pcie->pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
+	}
 
 
 	/* Set the Max TLP size to 2K, instead of using default of 4K */
@@ -1440,6 +1449,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	ret = of_pci_get_max_link_speed(pdev->dev.of_node);
+	if (ret == 1)
+		pcie->force_gen1 = true;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
 	pcie->parf = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->parf)) {
-- 
2.25.1


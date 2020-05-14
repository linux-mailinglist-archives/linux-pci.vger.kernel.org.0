Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3F1D3E97
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgENUH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729388AbgENUHz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:55 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0847C061A0C;
        Thu, 14 May 2020 13:07:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h16so3459991eds.5;
        Thu, 14 May 2020 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGP2kVUTi+hmH+HLFCJp0uoULPxAxN5xn10J+tUm53U=;
        b=Hpw4cPqfiPP3//Dxg/Vtg9+8ubhTtUWWjO+Fya935pmnju/CQ7D//KNkSI6oDphlLl
         8QBclziH4I/bWcoITfofG9Xo1reP1ot4UZwlSjUzcB3cyXasR7OQ1JR2ZOgBnAGslSAA
         PkWKXSyrbiFGrTCYChsIEhEguRZP3mHbHyA5Z1dqvc/xEzG4c5Dqj66PBfvE/V6M4jhj
         p5E8FaMPvA7fBEceWuK5Hg/SZLf9ojNAfMX+LXM/wKVpLESlssJB8S3bx9awKhvOPhcn
         y7Cm4FiB5eCNqjA7hXGI+9G9GCcK5RbVLZZhLxaGJ4Uajmcctw6YCwGS47+XqO3FdBty
         gkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGP2kVUTi+hmH+HLFCJp0uoULPxAxN5xn10J+tUm53U=;
        b=mxmyM+uw+p8SoVzO2nAq8AGzfae5Hf2NR6R6kXRBZLuDgLilq2TXYuxKbsl4/U7SU2
         LTUdVea7i7jGhB52DJdaJ/blr4X4cwsh54O9TtoRaPBDlWgrAwpS/XYO6cJGhdC9E9mM
         7KF9GySl03Qo1nV8C5uNiakS0Y/qm6QIHmLK34pN2itx9h9EjweFq1O1j0RE5e38gS5P
         WbTZBjmWS7QY/76zu1uX3gCC1x74DM8ETFCNdXgClQ8V/78yt5+u9rEg9HIaQK+SOVT1
         qfHSA6g5S86f6qxrebds2fbAU4YUWhNr3fBLik/38dklEcBbNo2V9ryDnQgiUQP0ooiH
         W/Ww==
X-Gm-Message-State: AOAM533fXLI89T7Fyyq4S1swAv85l/UDe/YbvdIpz98DoOOlcR8wr17v
        6AEw94WPZTyXzKrra0luBsI=
X-Google-Smtp-Source: ABdhPJwIrv2umWBuAOzcuH4PGpXomvSLEHSaSd7MZc9vrXVBYLGk7Eqisbbb08WV/iDalRuLVulGXA==
X-Received: by 2002:a05:6402:1296:: with SMTP id w22mr5233666edv.364.1589486873617;
        Thu, 14 May 2020 13:07:53 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:53 -0700 (PDT)
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
Subject: [PATCH v4 10/10] PCI: qcom: Add Force GEN1 support
Date:   Thu, 14 May 2020 22:07:11 +0200
Message-Id: <20200514200712.12232-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
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
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ab6f1bdd24c3..f6190c954e92 100644
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


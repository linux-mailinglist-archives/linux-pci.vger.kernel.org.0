Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A44AC310
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiBGPXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442933AbiBGPKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:10:13 -0500
Received: from mx.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BE7C0401C2;
        Mon,  7 Feb 2022 07:08:44 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id A502B440F66;
        Mon,  7 Feb 2022 16:51:33 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1644245494;
        bh=KLPNQ4abl6ySCDQvYAo8MjsLaFhwDEQEKjXfmAojE54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V69dBlpiNiL99ucIMVVNmy0+vyv1hGHdralahf+rs2dkb3M8O84nPIx21Ax0MmjZ1
         XIB9iMU7tVujx8pER2lD8GxCr0rTW7T34cMtqUL0AMNBMWlXfTnq7rk6TeEUwjE/1w
         S8jbns3Mvm254na3pC6dH0V9QBXgw1YCqsW9IkzzTcTNw2lZxyGMfWye7PNUwg9rqd
         WYYw47oupGQItPTD5ZKDkIY0MZ7wlSeXypcmQ3m3QPqEZqYbNeNgPFnM23tcC6uKKo
         4+p1U9MuRoxxuCX9T1b59IkCOynN44fPC7R9fC8ehcn2CTvZW+fIQdiXCTRqdrw6sa
         GXBLD8pEHB4Og==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
        Rob Herring <robh@kernel.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v6 1/3] PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
Date:   Mon,  7 Feb 2022 16:51:24 +0200
Message-Id: <2525ebececdd7597c03c1b460924628735b43c59.1644234441.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644234441.git.baruch@tkos.co.il>
References: <cover.1644234441.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

These are common dwc macros that will be used for other platforms.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 6 ++++++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..ea87809ee298 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -74,6 +74,12 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define GEN3_RELATED_OFF			0x890
+#define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b1b5f836a806..74bf66d9afeb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -193,12 +193,6 @@
 #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
 #define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK	GENMASK(3, 0)
 
-#define GEN3_RELATED_OFF			0x890
-#define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
-#define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
-#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
-#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
-
 #define PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT	0x8D0
 #define AMBA_ERROR_RESPONSE_CRS_SHIFT		3
 #define AMBA_ERROR_RESPONSE_CRS_MASK		GENMASK(1, 0)
-- 
2.34.1


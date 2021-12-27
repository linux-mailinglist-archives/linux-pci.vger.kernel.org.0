Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548B047FA9B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 07:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhL0GqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Dec 2021 01:46:14 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:53450 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235367AbhL0GqM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Dec 2021 01:46:12 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 9FE4144066E;
        Mon, 27 Dec 2021 08:45:59 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1640587560;
        bh=Ztwqjvo8hT2FiIK1PcXrHCs9IJPR3RveZxZjfCdaqus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMfiilkGPqzBpHugvUxxQMKBcGowsUXt4/ETfK34+FXTdCOM452zeNwBpegcz8U0y
         qRL9G9kkYJhNXsMbsPA3tYCugOs2uzbxHi8DCZgzT8MaI689q0+w6olF+wNpD1faAj
         7aA3HQp6HNhsRVYiNjUuWmOJ576ucCB5PbumBslP6/UkbheHuDwg2HJCMO+J3hzgxb
         pQ/ws73w/6ExYjBQkZqRC3Zxs32CfuRwzVNwrrMdyZfOmh+SS3cW3UM/AGdHvIxFQQ
         lLNuV6ei+z+qMt812CGlfZ1M/GB+r7Z3d9CwhyLS1M30d21SRzNvim+/qxzNPs3a9v
         aqtX3xHdAuOIg==
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
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 2/3] PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
Date:   Mon, 27 Dec 2021 08:46:04 +0200
Message-Id: <a81f7a7caf16dc8692019e9ed5f8cba15013ce30.1640587131.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1640587131.git.baruch@tkos.co.il>
References: <cover.1640587131.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 904976913081..846c9d154f49 100644
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


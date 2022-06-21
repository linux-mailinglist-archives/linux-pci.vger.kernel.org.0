Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCFB552D9B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346820AbiFUIzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348565AbiFUIzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 04:55:08 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EEA25EB4;
        Tue, 21 Jun 2022 01:55:05 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id C40594407DA;
        Tue, 21 Jun 2022 11:54:39 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655801680;
        bh=/rQFltQbwW1NtS1kguqnicZH12kOh3aebtATb/mTZtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K89WwHjGMxO/tcmUAP6DyOb6mH8so44bT7pzNO0zGkyU4z1Nv8ws2DaqVjQa6pnt0
         cvbcSrb3lK60Iia8dXPyzKZZwcDAW1bSubaMES/4nmJhGNf/0rvryElbpWSRyYnPlU
         +zMdtKzC+os8bzhNCvf7QJKDj8KLst4niHP2lUZWRSj58ntx0XibLR9ca7+/8kdcaK
         lt7SvjZCAli0a3QAiFIKBRT2sjK2EPluO2Rb7fDEqr7jeYLpZXQT9EVoIjaYbMlOLC
         HApc5gGOfr/xFS0AKkGPjXv9AzL+15pF0PSEkklMbWVsjHZqaCjGc6evQsFcB9l9Vf
         YQx9D2eknBVug==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
        Rob Herring <robh@kernel.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v8 1/3] PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
Date:   Tue, 21 Jun 2022 11:54:52 +0300
Message-Id: <1c2d5a7a139be81fa15f356b2380163dbdebdc09.1655799816.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655799816.git.baruch@tkos.co.il>
References: <cover.1655799816.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index cc2678490162..0190786a24b8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -191,12 +191,6 @@
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
2.35.1


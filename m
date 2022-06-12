Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4E5479BE
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jun 2022 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiFLKSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jun 2022 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiFLKSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2022 06:18:52 -0400
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1422BCE;
        Sun, 12 Jun 2022 03:18:51 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 828B944091D;
        Sun, 12 Jun 2022 13:18:33 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655029114;
        bh=KuQXYgm8NThAIzb7Ikf1sLboR2SVHi9w/PFiSS2oBeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOp6x8CPE5LAHYBIj5eIocJB8SItVI5ytlhbXSpwGr5vTbkrRUM1qycjJQly1tftR
         XqtDzOH82NvIPMCgvMwy60TwCzmKzCZOoWVrhj7hKFDw8cnetdpMIz6YL7qCogDua8
         NsuYVmgNpcJ8AUld6hEGILMYfjuwoTpV6KebUKZaph7mrRjhymhIJ0Kj/tS6Nex10a
         NPrMeIotyVKWdIcvhzAgWtq/fo6s8HV73UrkwAKxQoWtYDia90/Cf2L0NNLxAGHp3l
         fhE6TeT62FvUQ6MR+TYJd4aWxnHBTu0u7Q2qnIcFnxlycx/FGscR58szcyn3qlJK/g
         UXO7w3gmCKxnw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
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
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v7 2/3] PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
Date:   Sun, 12 Jun 2022 13:18:34 +0300
Message-Id: <27d2c59cc9a916754e0dc68f44447ecefe378410.1655028401.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655028401.git.baruch@tkos.co.il>
References: <cover.1655028401.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
describe its meaning.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
v7:
  Use FIELD_PREP for power limit and stale (Pali Rohár)
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ea13750b492..5ad9be6372f4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -69,7 +69,20 @@
 #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE_CAP_LINK1_VAL			0x2FD7F
+#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, \
+						250)
+#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, \
+						1)
+#define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
+						PCI_EXP_SLTCAP_PCP | \
+						PCI_EXP_SLTCAP_MRLSP | \
+						PCI_EXP_SLTCAP_AIP | \
+						PCI_EXP_SLTCAP_PIP | \
+						PCI_EXP_SLTCAP_HPS | \
+						PCI_EXP_SLTCAP_HPC | \
+						PCI_EXP_SLTCAP_EIP | \
+						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
+						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
 #define PCIE20_PARF_Q2A_FLUSH			0x1AC
 
@@ -1114,7 +1127,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
-	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_ASPMS;
-- 
2.35.1


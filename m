Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07BE4AC304
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbiBGPXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442928AbiBGPKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:10:13 -0500
X-Greylist: delayed 604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 07:08:45 PST
Received: from mx.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D11C0401C3;
        Mon,  7 Feb 2022 07:08:44 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 4997E440F71;
        Mon,  7 Feb 2022 16:51:34 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1644245494;
        bh=nIrfa8mEKTC6oAB6BkMaHvbfljToR8zQJ/TwO5fY1Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfuU94QdoNOvooJMskmALPxCAzB1BY+XMLMVf1A2XFxRqlp7Jc7Ys/nUZ1cnM+yhQ
         q6vN5jV9nubAn4haHlRInv7jKJGiDCcphOnc8SXDv/Bm/IZDNDQ0hrt9AWMdidZE2N
         2yIHXShQnjt25pLd/7BO4EEPFkIvC28ZPs8N9WqwEtUpWwqlVKmhJW3s21NKykxTRn
         IujfZyBrrOekn6dl6qqNhzG3HwC5YWtrvs2foMx18KzpuGVNPo7JhW5XaH1DlG8u7v
         JB+tyLJeS4xVWFud6gDc/TD5iGLFZeTuLiPP72iD7briKk5zI0SPc03GcAzuY5Rcmq
         Zmo6VncRe66qg==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
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
Subject: [PATCH v6 2/3] PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
Date:   Mon,  7 Feb 2022 16:51:25 +0200
Message-Id: <f452d0d28482462557485805d708b9adb9e0f6c0.1644234441.git.baruch@tkos.co.il>
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

The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
describe its meaning.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506ed3f..01e58b057d2a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -69,7 +69,18 @@
 #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE_CAP_LINK1_VAL			0x2FD7F
+#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		0x7D00
+#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		0x8000
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
 
@@ -1111,7 +1122,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
-	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_ASPMS;
-- 
2.34.1


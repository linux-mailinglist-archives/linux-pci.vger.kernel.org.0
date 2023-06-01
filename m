Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A44B71EF38
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjFAQjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAQjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 12:39:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DB196
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 09:39:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-65055aa4ed7so511137b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637558; x=1688229558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jhi/SGtXf0zcdn3PGnK3djwXYahz8JQorb98x1QvGk=;
        b=Xn/NRwPDI6HpANyrkks5fzFEE67qAj4af2lWBD1rDIyt1Ney3dCiXRymzDS+XvX4BL
         H8LoIHenyRU7nik0zxODlsldTuCR4YC1LEUlt3OF5m2I3kuDj4Ck8rUgfdD2JZ+wld0w
         OhElSzjGv5SjqZ9zi7OBN3ATZaovvPW2ciW5TIGM0Yez9TIUiU1t2AI0VuZ5oQSOGZpW
         4WJcNqhFb4C1PHmxBq/dGXNfA+MJ+/T6rcczqUHeyXhPXOXSLAviFY5ryesSFB5JOoJ8
         XHNLGQ8uIqLGDE5tRp/i/tJdbo9VpaGLi+oTDDQUwInTG+sGy1Ab0QQy2VCo0gTH+WPd
         hU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637558; x=1688229558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jhi/SGtXf0zcdn3PGnK3djwXYahz8JQorb98x1QvGk=;
        b=j4Nv6yx6J4UZKgU28vnFqRQYs76Der7cLXcyEVAWiNnVJRp3qzwOHBKGgoHplIW40J
         vBgXZvAoExYN1eAmCKqkITw/pPf7ggu21ldFB1PSBV4KXPlqhet904NHHQPChxEpcxsQ
         Ry/I1d00lHDVGBT6gd0lTnvToXNx4X5NGQOi2eUnWEn3rCDM8Ywq6Ris2iMriKbIgaty
         jb95ClSNOklBNVjoOQaPCO5oM64tOj9qma71zAyHvw3brZoz/vQ+sH85ByfQ4DJH4WY5
         lMbtD6+dLLTL4jZsApVhiX10b5wTkzh3mOB5VVjL6TD4ww0usjBncETQIgDSQIP6KxoX
         iS7A==
X-Gm-Message-State: AC+VfDxZuh+jOPfz1D01cwBIzxwefngNQqMK6fYbTvUWdIjkf1rjdkj4
        IHWH0H7l/iAyaRuYRZ2eoeMb
X-Google-Smtp-Source: ACHHUZ4c81XxdaW+VFcaYDhF2yAW5EiYmmmxUGAvQerboA7m2X50pNmd0SYbpzZj6NcB4i02zQs2rg==
X-Received: by 2002:a05:6a00:15ca:b0:64f:e997:50fc with SMTP id o10-20020a056a0015ca00b0064fe99750fcmr8711274pfu.2.1685637558349;
        Thu, 01 Jun 2023 09:39:18 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 1/8] PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
Date:   Thu,  1 Jun 2023 22:08:53 +0530
Message-Id: <20230601163900.15500-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
References: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DWC core already exposes dw_pcie_dbi_ro_wr_{en/dis} helper APIs for
enabling and disabling the write access to read only DBI registers. So
let's use them instead of doing it manually.

Also, the existing code doesn't disable the write access when it's done.
This is also fixed now.

Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..01795ee7ce45 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -61,7 +61,6 @@
 /* DBI registers */
 #define AXI_MSTR_RESP_COMP_CTRL0		0x818
 #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
-#define MISC_CONTROL_1_REG			0x8bc
 
 /* MHI registers */
 #define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
@@ -132,9 +131,6 @@
 /* AXI_MSTR_RESP_COMP_CTRL1 register fields */
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-/* MISC_CONTROL_1_REG register fields */
-#define DBI_RO_WR_EN				1
-
 /* PCI_EXP_SLTCAP register fields */
 #define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
 #define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
@@ -826,7 +822,9 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
-	writel(DBI_RO_WR_EN, pci->dbi_base + MISC_CONTROL_1_REG);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
@@ -836,6 +834,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 		PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
-- 
2.25.1


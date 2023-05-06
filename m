Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E66F901C
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjEFHc4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjEFHcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 03:32:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC941160C
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 00:32:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f6461af24so1830799a12.2
        for <linux-pci@vger.kernel.org>; Sat, 06 May 2023 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358334; x=1685950334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH0yxvscWy6M74r31hy+vSy8BszcaFbA7sdRCYqfUk8=;
        b=ySWPP+6jIHHGIxP0yxEcdDnkFlhMJHYfneDfATLw9zMYLX2ozUlUZ2/ZEZmbaQVEF4
         3MPSq4i3HTLfHZnN5RChGZpZ/mCOcFL4MKrb0/aKcLNyUYd/0r67zWstgvY8IbpEnjXe
         qWxs8Kw8GsztiCABc/rtgCfuBP2BQ54tYENFCDTJrItVUNU5qNpgOVZdNOd8Ystoqtdj
         2NXxWojhXMxZyRa399J5BzY00p3S0r4z4zbctYKsqAakNe1nrlwm3Ghj2rugZAmoi5oc
         e7/XdXV/0NbQJOXtxfuoPaVScA/grZjUhOLfGa19bUe6/Cm5nVkRtiDGvKDUXMJEwqkj
         80ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358334; x=1685950334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZH0yxvscWy6M74r31hy+vSy8BszcaFbA7sdRCYqfUk8=;
        b=EauqriCpXQbb/U2Q6wC/jQMMtAp80R2DFOOgZ6bw18otLsnDXpAgM69GAOmC/NZwVQ
         eBhAkv7quu3ABk3dcesbpyWnVlNipYjg18bL8qMPJ2d7jU1vMwilERJzXWx3Ikzo21CU
         OXLCrr10OJleJLwSPQa+A0D0tpRdHYO4Hg5M676hRCK00DKqx/hFb03B/yAGglA2Ekal
         AFxT6cT5c+8SX4PN/8UxE4Ys76wy6s2eibb4ibQ+gDh88FTWIzeGirqnAxA6sQ8a+PJJ
         ycrOQaefNXg/1VYBoAzzWOj2S6pLIiWzDIi9fhlI4JdoLr7uvEXI5GKG+CUVD8C6xzqw
         XB8w==
X-Gm-Message-State: AC+VfDxcWbvEiwmP7ctRblkygrGeHGpTu6RqXLUf77En/62A25Kq8HCE
        GnJp3JXemKj3s8TD6hi2nvf4
X-Google-Smtp-Source: ACHHUZ7PoJNc/RalS5bigWkkvXzZSEr/I8iFHeacq2GKl5dj4eWSATnyW6Fedde9k5Vh4kklQfgz8w==
X-Received: by 2002:a05:6a20:3d82:b0:ff:6110:66c5 with SMTP id s2-20020a056a203d8200b000ff611066c5mr2409592pzi.5.1683358334075;
        Sat, 06 May 2023 00:32:14 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0062a56e51fd7sm2627373pfn.188.2023.05.06.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:32:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/8] PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
Date:   Sat,  6 May 2023 13:01:38 +0530
Message-Id: <20230506073139.8789-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SoCs making use of Qcom PCIe controller IP v1.0.0 do not support hotplug
functionality. But the hotplug capability bit is set by default in the
hardware. This causes the kernel PCI core to register hotplug service for
the controller and send hotplug commands to it. But those commands will
timeout generating messages as below during boot and suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's clear the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0c5e825c6360..6fbaf7b419e6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -497,16 +497,27 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
 	/* change DBI base address */
 	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
-
+		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 		val |= EN;
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	val &= ~PCI_EXP_SLTCAP_HPC;
+	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
-- 
2.25.1


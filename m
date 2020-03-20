Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D718D741
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCTSfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39443 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgCTSf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so8311781edf.6;
        Fri, 20 Mar 2020 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eK3e1PI+UmHz8Hye1maNufVhAlQwBW5fj1ru2/xppA=;
        b=sBbFrg0zbNZn74IeuNSoXSU6Y9Ofyq5BN2GbFCQXl9G1RaU95yjB1ZnZyv8AAJtwrn
         A4YGM+8QDWL6BA71j9jt7C9D2c4qH6q8brieLBfWztcwlGlAznnrhY+g+Fq7vSSmAdCG
         aH+A5d3Faz76PLzG9cMFpk/IUuJkaaFdpzEx3MnBrHa7vNy+4zJDUqLVjO0wfVZlN0o7
         V6xUVCgIZ9W6EUpvu0WgLF/iKCDqTaxUbUirJcDWZqa6DT4AIX12+X3izpOBCAqSGj7K
         7vdkv+bD8gZXidcwexThuXEJJauXAhWvJ/VcfxQHoBejwD85PKHkOybgZnRhgPiYFT0s
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eK3e1PI+UmHz8Hye1maNufVhAlQwBW5fj1ru2/xppA=;
        b=EEHrKER8e2NOQ/jEsE4RJ7XxQiKN0zAbp8cpS/Um3XrjHk30+dIln7IpLOXzXTM+4S
         G2Jjn+Kn2p74bIXzyDWuCuO6WY/lamp1OY2PXSV7G14GwK4DnsngiqnhMM131zhKjMPl
         rWxMLxp8NlmI6Mfnm0/RY101N1vJ8zRXzAu7lIZe21AtrtxLnbkCH8svkWPqDWOec6+S
         uebyPZI6biLZyHyNScIsPYGU8wbvnTbZ20hZTbneFK+24CPvNnTgv73hOsniIKjTkS+D
         er4bWBJzGBJdO0JSSoKCyyezKSSt3TRfWdKRIvf9Op0a1Jiq8HUpCjiMupC8+qAUybkI
         ZZDg==
X-Gm-Message-State: ANhLgQ3S12xiHYla348dqgq6fXWYF1U1rCneD+NhCsGiDGc37J/KAaPL
        11uBH6GtvxIAZbQk5eXYVGM=
X-Google-Smtp-Source: ADFU+vus817SAtCmyfU8vW8+j/gVz5a9XM2N41s6kR7OjTLOec8BOPOW4+naOkkgNjtoHKeFcJ76xQ==
X-Received: by 2002:aa7:cd8f:: with SMTP id x15mr9317135edv.156.1584729326478;
        Fri, 20 Mar 2020 11:35:26 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:25 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] pcie: qcom: Programming the PCIE iATU for IPQ806x
Date:   Fri, 20 Mar 2020 19:34:51 +0100
Message-Id: <20200320183455.21311-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Resolved PCIE EP detection errors caused due to missing iATU programming.

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8009e3117765..e26ba8f63d4f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -77,6 +77,30 @@
 #define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
 #define PCIE_CAP_LINK1_VAL			0x2FD7F
 
+#define PCIE20_CAP_LINKCTRLSTATUS		(PCIE20_CAP + 0x10)
+
+#define PCIE20_AXI_MSTR_RESP_COMP_CTRL0		0x818
+#define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
+
+#define PCIE20_PLR_IATU_VIEWPORT		0x900
+#define PCIE20_PLR_IATU_REGION_OUTBOUND		(0x0 << 31)
+#define PCIE20_PLR_IATU_REGION_INDEX(x)		(x << 0)
+
+#define PCIE20_PLR_IATU_CTRL1			0x904
+#define PCIE20_PLR_IATU_TYPE_CFG0		(0x4 << 0)
+#define PCIE20_PLR_IATU_TYPE_MEM		(0x0 << 0)
+
+#define PCIE20_PLR_IATU_CTRL2			0x908
+#define PCIE20_PLR_IATU_ENABLE			BIT(31)
+
+#define PCIE20_PLR_IATU_LBAR			0x90C
+#define PCIE20_PLR_IATU_UBAR			0x910
+#define PCIE20_PLR_IATU_LAR			0x914
+#define PCIE20_PLR_IATU_LTAR			0x918
+#define PCIE20_PLR_IATU_UTAR			0x91c
+
+#define MSM_PCIE_DEV_CFG_ADDR			0x01000000
+
 #define PCIE20_PARF_Q2A_FLUSH			0x1AC
 
 #define PCIE20_MISC_CONTROL_1_REG		0x8BC
@@ -251,6 +275,57 @@ static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
 }
 
+static void qcom_pcie_prog_viewport_cfg0(struct qcom_pcie *pcie, u32 busdev)
+{
+	struct pcie_port *pp = &pcie->pci->pp;
+
+	/*
+	 * program and enable address translation region 0 (device config
+	 * address space); region type config;
+	 * axi config address range to device config address range
+	 */
+	writel(PCIE20_PLR_IATU_REGION_OUTBOUND |
+	       PCIE20_PLR_IATU_REGION_INDEX(0),
+	       pcie->pci->dbi_base + PCIE20_PLR_IATU_VIEWPORT);
+
+	writel(PCIE20_PLR_IATU_TYPE_CFG0, pcie->pci->dbi_base + PCIE20_PLR_IATU_CTRL1);
+	writel(PCIE20_PLR_IATU_ENABLE, pcie->pci->dbi_base + PCIE20_PLR_IATU_CTRL2);
+	writel(pp->cfg0_base, pcie->pci->dbi_base + PCIE20_PLR_IATU_LBAR);
+	writel((pp->cfg0_base >> 32), pcie->pci->dbi_base + PCIE20_PLR_IATU_UBAR);
+	writel((pp->cfg0_base + pp->cfg0_size - 1),
+	       pcie->pci->dbi_base + PCIE20_PLR_IATU_LAR);
+	writel(busdev, pcie->pci->dbi_base + PCIE20_PLR_IATU_LTAR);
+	writel(0, pcie->pci->dbi_base + PCIE20_PLR_IATU_UTAR);
+}
+
+static void qcom_pcie_prog_viewport_mem2_outbound(struct qcom_pcie *pcie)
+{
+	struct pcie_port *pp = &pcie->pci->pp;
+
+	/*
+	 * program and enable address translation region 2 (device resource
+	 * address space); region type memory;
+	 * axi device bar address range to device bar address range
+	 */
+	writel(PCIE20_PLR_IATU_REGION_OUTBOUND |
+	       PCIE20_PLR_IATU_REGION_INDEX(2),
+	       pcie->pci->dbi_base + PCIE20_PLR_IATU_VIEWPORT);
+
+	writel(PCIE20_PLR_IATU_TYPE_MEM, pcie->pci->dbi_base + PCIE20_PLR_IATU_CTRL1);
+	writel(PCIE20_PLR_IATU_ENABLE, pcie->pci->dbi_base + PCIE20_PLR_IATU_CTRL2);
+	writel(pp->mem_base, pcie->pci->dbi_base + PCIE20_PLR_IATU_LBAR);
+	writel((pp->mem_base >> 32), pcie->pci->dbi_base + PCIE20_PLR_IATU_UBAR);
+	writel(pp->mem_base + pp->mem_size - 1,
+	       pcie->pci->dbi_base + PCIE20_PLR_IATU_LAR);
+	writel(pp->mem_bus_addr, pcie->pci->dbi_base + PCIE20_PLR_IATU_LTAR);
+	writel(upper_32_bits(pp->mem_bus_addr),
+	       pcie->pci->dbi_base + PCIE20_PLR_IATU_UTAR);
+
+	/* 256B PCIE buffer setting */
+	writel(0x1, pcie->pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL0);
+	writel(0x1, pcie->pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
+}
+
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
@@ -448,6 +523,9 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
 
+	qcom_pcie_prog_viewport_cfg0(pcie, MSM_PCIE_DEV_CFG_ADDR);
+	qcom_pcie_prog_viewport_mem2_outbound(pcie);
+
 	return 0;
 
 err_deassert_ahb:
-- 
2.25.1


Return-Path: <linux-pci+bounces-13846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60188990C6B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DDB1F26C48
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AF21C191;
	Fri,  4 Oct 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McdwyXZq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E01F709F;
	Fri,  4 Oct 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066193; cv=none; b=SS6J9mqFI/qhLXdImPYsDJ8YHTnDVpn+Q2j3+hn/AbazIFEq9rfiItOlkpmoc8GjmqaMW2P0fH/xlyneEwaw5b7czwC2WSYAfObd6xR7mbgGWPM3IUJGvjeQlAa+gOhjTnyTc0NaFGtsKzpWp2OVB4JjvCtr8kw2ocLktIJUmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066193; c=relaxed/simple;
	bh=LV6/8sInqNJQ94n/PHbBsBClTJET/v8G+eUKe4oEfnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3K8AJYcdIJqt3uFME4V8pEDeQi+zxLzaHP/cYS/7kyV6zGIzbVKDfn78nUf/vutrntok2dW+WvemVosd/RwjjYq5J94yYiO30MoQWEcsQN4+6dATwQNjcjzo7s1nKfs0e3PZPfcEV2s3aUvlgRkJlEsPGkst731wnWOfV4Yj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McdwyXZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA905C4CEC6;
	Fri,  4 Oct 2024 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066193;
	bh=LV6/8sInqNJQ94n/PHbBsBClTJET/v8G+eUKe4oEfnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McdwyXZqyNir72k0duGxeAbq8mCXRN0EePJAhwN4rL6Q0lBg5MawYREKBuSOtLeHC
	 dqrb/yoSD2TT32WPM+XQiUQLqv7OMhoIwsO7r5aVraicjmJV99vn4DQi0D00rP20VP
	 6pr085/Gxev8CuWhSzDF+2upDMm795uyemSMJdfWphK7eL7y5MdzCBUd44ughesgxW
	 g9c3f6BV3L+BNFBLQRR/c1k32PVyTrdUkqj/9AYkOOkol97Eg717nKSEuBL+UsYR+L
	 dg8Xa0e7FXRhhI5dvDdrHKhj9o0QMoS3VdhZis20xQVJZa2bpGCIVztTG2rCknHThY
	 lEUtJ1yy7KFOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Mayank Rana <quic_mrana@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 37/70] PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region
Date: Fri,  4 Oct 2024 14:20:35 -0400
Message-ID: <20241004182200.3670903-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

[ Upstream commit 10ba0854c5e6165b58e17bda5fb671e729fecf9e ]

PARF hardware block which is a wrapper on top of DWC PCIe controller
mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
register to get the size of the memory block to be mirrored and uses
PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
address of DBI and ATU space inside the memory block that is being
mirrored.

When a memory region which is located above the SLV_ADDR_SPACE_SIZE
boundary is used for BAR region then there could be an overlap of DBI and
ATU address space that is getting mirrored and the BAR region. This
results in DBI and ATU address space contents getting updated when a PCIe
function driver tries updating the BAR/MMIO memory region. Reference
memory map of the PCIe memory region with DBI and ATU address space
overlapping BAR region is as below.

                        |---------------|
                        |               |
                        |               |
        ------- --------|---------------|
           |       |    |---------------|
           |       |    |       DBI     |
           |       |    |---------------|---->DBI_BASE_ADDR
           |       |    |               |
           |       |    |               |
           |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
           |    BAR/MMIO|---------------|
           |    Region  |       ATU     |
           |       |    |---------------|---->ATU_BASE_ADDR
           |       |    |               |
        PCIe       |    |---------------|
        Memory     |    |       DBI     |
        Region     |    |---------------|---->DBI_BASE_ADDR
           |       |    |               |
           |    --------|               |
           |            |               |---->SLV_ADDR_SPACE_SIZE
           |            |---------------|
           |            |       ATU     |
           |            |---------------|---->ATU_BASE_ADDR
           |            |               |
           |            |---------------|
           |            |       DBI     |
           |            |---------------|---->DBI_BASE_ADDR
           |            |               |
           |            |               |
        ----------------|---------------|
                        |               |
                        |               |
                        |               |
                        |---------------|

Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
used for BAR region which is why the above mentioned issue is not
encountered. This issue is discovered as part of internal testing when we
tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
we are trying to fix this.

As PARF hardware block mirrors DBI and ATU register space after every
PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, program
maximum possible size to this register by writing 0x80000000 to it(it
considers only powers of 2 as values) to avoid mirroring DBI and ATU to
BAR/MMIO region. Write the physical base address of DBI and ATU register
blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR (default
0x1000) respectively to make sure DBI and ATU blocks are at expected
memory locations.

The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
and PARF_ATU_BASE_ADDR are applicable for platforms that use Qcom IP
rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for Qcom IP rev 2.3.3.
PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for Qcom
IP rev 1.0.0, 2.3.2 and 2.4.0. Update init()/post_init() functions of the
respective Qcom IP versions to program applicable PARF_DBI_BASE_ADDR,
PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR register offsets. Update
the SLV_ADDR_SPACE_SZ macro to 0x80000000 to set highest bit in
PARF_SLV_ADDR_SPACE_SIZE register.

Cache DBI and iATU physical addresses in 'struct dw_pcie' so that
pcie_qcom.c driver can program these addresses in the PARF_DBI_BASE_ADDR
and PARF_ATU_BASE_ADDR registers.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/linux-pci/20240814220338.1969668-1-quic_pyarlaga@quicinc.com
Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |  2 +
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 72 ++++++++++++++++----
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b858..d59f607b71f17 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
 		if (IS_ERR(pci->dbi_base))
 			return PTR_ERR(pci->dbi_base);
+		pci->dbi_phys_addr = res->start;
 	}
 
 	/* DBI2 is mainly useful for the endpoint controller */
@@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->atu_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->atu_base))
 				return PTR_ERR(pci->atu_base);
+			pci->atu_phys_addr = res->start;
 		} else {
 			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 		}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207bd..ea3c22f713111 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -387,8 +387,10 @@ struct dw_pcie_ops {
 struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
+	resource_size_t		dbi_phys_addr;
 	void __iomem		*dbi_base2;
 	void __iomem		*atu_base;
+	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7fa1fe5a29e3d..28bfd8b38dc7a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -43,6 +43,7 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE		0x16c
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -50,8 +51,13 @@
 #define PARF_LTSSM				0x1b0
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DBI_BASE_ADDR_V2			0x350
+#define PARF_DBI_BASE_ADDR_V2_HI		0x354
+#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
+#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
 #define PARF_NO_SNOOP_OVERIDE			0x3d4
+#define PARF_ATU_BASE_ADDR			0x634
+#define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
@@ -106,7 +112,7 @@
 #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
 
 /* PARF_SLV_ADDR_SPACE_SIZE register value */
-#define SLV_ADDR_SPACE_SZ			0x10000000
+#define SLV_ADDR_SPACE_SZ			0x80000000
 
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
@@ -323,6 +329,50 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pci->dbi_phys_addr) {
+		/*
+		 * PARF_DBI_BASE_ADDR register is in CPU domain and require to
+		 * be programmed with CPU physical address.
+		 */
+		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
+							PARF_DBI_BASE_ADDR);
+		writel(SLV_ADDR_SPACE_SZ, pcie->parf +
+						PARF_SLV_ADDR_SPACE_SIZE);
+	}
+}
+
+static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pci->dbi_phys_addr) {
+		/*
+		 * PARF_DBI_BASE_ADDR_V2 and PARF_ATU_BASE_ADDR registers are
+		 * in CPU domain and require to be programmed with CPU
+		 * physical addresses.
+		 */
+		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
+							PARF_DBI_BASE_ADDR_V2);
+		writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf +
+						PARF_DBI_BASE_ADDR_V2_HI);
+
+		if (pci->atu_phys_addr) {
+			writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
+							PARF_ATU_BASE_ADDR);
+			writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
+							PARF_ATU_BASE_ADDR_HI);
+		}
+
+		writel(0x0, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
+		writel(SLV_ADDR_SPACE_SZ, pcie->parf +
+					PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
+	}
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -553,8 +603,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 {
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
@@ -644,8 +693,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -837,13 +885,11 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
 		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
@@ -966,8 +1012,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -1181,14 +1226,11 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	u32 val;
 	int i;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
-- 
2.43.0



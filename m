Return-Path: <linux-pci+bounces-35730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D599EB4A308
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D5E1BC6D89
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A83081BD;
	Tue,  9 Sep 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc0uXzTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74A3081B3;
	Tue,  9 Sep 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401697; cv=none; b=t8c8+RF4osYcu9+ToTBoZA3Q/oiPMlwr9zRe2+uukiroSRzEMXoZH4Gg6SaYXpCYbNX5UWibnaoTmouVNkljhCgFVoX0131GPDN3V5BVBRGMsuQ5EVaTzpiFvMim8bcETkzaqP6RAD8TF8bkx0gLu1U1GY5omQXZpceQMWb/iOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401697; c=relaxed/simple;
	bh=RZ8tW8iUEXt+riPodRCIZ/rwnZo7JoKB5BjoCIqk0BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqrfBbwZ4exi/p50z5Uf544ZkXHYXMVx3KmrjMJZaGuNEBd+kf7tRS3B4jgv8/KHSK93lrhI19H77Gwah1kb/Q4vHNPsixwHqSgf2dPXCsmb9xKQ9o84+iONMUj1GQ8TkJpEjFUqPCDOKmOe22efirzEbMdg0VpKnY8TbrhA7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc0uXzTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2EFC4CEF4;
	Tue,  9 Sep 2025 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757401697;
	bh=RZ8tW8iUEXt+riPodRCIZ/rwnZo7JoKB5BjoCIqk0BY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gc0uXzTXO9w3yceN091XK4b2Kt8ZBkMBy4blis6l5wHWusGZDE0vvbCxXLER3s0sE
	 2TdDauTMP4k03pbux4UVAIshMscZzwa//eZDdN1xj5pOv5OiIU9uzWRW0R2CPjn1jf
	 os9omIaYUhz6IG3ngPS6FGO9TsgZPqJjAHH4E/XyRTxQXDtqN/sqckRkuBn0kJwTvA
	 8mG5ZsMHn3ONE93l6ZIBU9SKvdaiFhFSvclmjhZ4ANuggG9jngH8QJRFwda2/6uKox
	 lUiBkErkAs/Dwego+zk8Cld11Bmbqv9GfzEjRM3Qkr87UzlOlytPr7v0aOxtw6Cu/k
	 jOxyMWR4JFDzA==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Tue, 09 Sep 2025 12:37:52 +0530
Subject: [PATCH v9 3/4] PCI: qcom: Prepare for the DWC ECAM enablement
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-controller-dwc-ecam-v9-3-7d5b651840dd@kernel.org>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
In-Reply-To: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Chocron <jonnyc@amazon.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5855; i=mani@kernel.org;
 h=from:subject:message-id; bh=JTMChg6PVfEBCYWx0M6eUkDGk8ialE1YepnfzE8n/ys=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBov9JO1tq4u+1qA4OufrDqhYD2PkakBUdHiUTbc
 f3gMpsvLqiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaL/STgAKCRBVnxHm/pHO
 9eGdB/9eKcQfDkZPpQWO3BjtTOsVSF5Z9H8QiAIzE8Vj1RKACNY3ivPzSXVingzP4YEl9BWPXpj
 uRui+GjXwPIQBhD+tXDJeROr1GHSQe5HMKcNMBeaDPjw4I12Gg0ARTPhPMBjN5jVm1d1/AhvSO0
 JgPIRLi4L4MobXvIXPiDBP1W6dDcPa7dUlKEQ2Ju7+RLFRjiRM9fk2s0DcL2qBOYAACfbXwBm2w
 xsqUKR0vLTMd+N15ru6wjJ8pLCGQQR9usDi5QpuTZvNPNWjsm0CHgfOL+gwKBRT99SirAb8IbeT
 OG7hyNHv+DFmFu+fO79825BJbZrPQuy1LrT+i5l/rhETdUW4
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

To support the DWC ECAM mechanism, prepare the driver by performing below
configurations:

  1. Since the ELBI region will be covered by the ECAM 'config' space,
     override the 'elbi_base' with the address derived from 'dbi_base' and
     the offset from PARF_SLV_DBI_ELBI register.

  2. Block the transactions from the host bridge to devices other than Root
     Port on the root bus to return all F's. This is required when the 'CFG
     Shift Feature' of iATU is enabled.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
[mani: code split, reworded subject/description and comments]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5092752de23866ef95036bb3f8fae9bb06e8ea1e..4324555de72adbdd3dcdf59497f9bd067d9c90ab 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -55,6 +55,7 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
+#define PARF_SLV_DBI_ELBI			0x1b4
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
@@ -64,6 +65,16 @@
 #define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
+#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
+#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
+#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
+#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
+#define PARF_ECAM_BASE				0x380
+#define PARF_ECAM_BASE_HI			0x384
 #define PARF_NO_SNOOP_OVERRIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
@@ -87,6 +98,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define PCIE_ECAM_BLOCKER_EN			BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -134,6 +146,9 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
+/* PARF_SLV_DBI_ELBI */
+#define SLV_DBI_ELBI_ADDR_BASE			GENMASK(11, 0)
+
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_UP			BIT(13)
 #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
@@ -317,6 +332,47 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	qcom_perst_assert(pcie, false);
 }
 
+static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u64 addr, addr_end;
+	u32 val;
+
+	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	/*
+	 * The only device on root bus is a single Root Port. So if PCI core
+	 * tries to access any devices other than Device/Function (0.0) in Bus
+	 * 0, the TLP will go outside of the controller to the PCI bus. But with
+	 * CFG Shift Feature (ECAM) enabled in iATU, there is no guarantee that
+	 * the response is going to be all F's. Hence, to make sure that the
+	 * requester gets all F's response for accesses other than the Root
+	 * Port, configure iATU to block the transactions starting from function
+	 * 1 of the root bus to the end of the root bus (i.e from dbi_base + 4kb
+	 * to dbi_base + 1MB).
+	 */
+	addr = pci->dbi_phys_addr + SZ_4K;
+	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
+	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
+
+	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
+	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
+
+	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
+
+	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
+	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
+
+	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
+	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
+
+	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
+	val |= PCIE_ECAM_BLOCKER_EN;
+	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
+}
+
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -326,6 +382,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
+	if (pci->pp.ecam_enabled)
+		qcom_pci_config_ecam(&pci->pp);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
@@ -1314,6 +1373,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1322,6 +1382,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	if (pp->ecam_enabled) {
+		/*
+		 * Override ELBI when ECAM is enabled, as when ECAM is enabled,
+		 * ELBI moves under the 'config' space.
+		 */
+		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
+		pci->elbi_base = pci->dbi_base + offset;
+	}
+
 	ret = qcom_pcie_phy_power_on(pcie);
 	if (ret)
 		goto err_deinit;

-- 
2.45.2



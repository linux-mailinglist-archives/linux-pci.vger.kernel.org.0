Return-Path: <linux-pci+bounces-11683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9510A952535
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 00:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F91B1F22FE7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 22:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED4145B00;
	Wed, 14 Aug 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E4CMS5Dr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA9139CE3;
	Wed, 14 Aug 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673126; cv=none; b=rvktqBHQ3laLnRGNjRaO9iRe3EISObzZEWnFjSrwquF7XNW4Cyn89yf1BE4h0ZzGVPcP/KjvQHlocxLAnLjHxF/cifA8UwfCW3bPnG4Eql6XbFJd2OrrLIQR8ZudujDrfZzKiOCGo/VWnyujBTGVbFfAhQmu6vKyDDx8c3XDlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673126; c=relaxed/simple;
	bh=3TeTHhtlVF+HT3Kzug+vcVhUSuKGRJequxjUXzsIPmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AuN78T4hmlmjG9Z0vFdZVbIfGgvEBlrQyCJc9LxwcNEsRO2NsWlJwyVXLWMo9DBbiVglxC2qWO6ssoMDUCHaa62euV9i8kb431DYRDkAavHLjNYkuT0qkqrGf4N2fggXOYYLr9xI8CQuO95kyyo8US2H+rcdGWt8Qulo4Sc3EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E4CMS5Dr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EJqSh9016363;
	Wed, 14 Aug 2024 22:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KAiR7NA6x+Ein79OOkruur
	Pzx7CD/sjJO2mJmtnsKWg=; b=E4CMS5Dr26u4QAsuyx2hHp3GKBvEK6ViWGwz+v
	cLisnRP3ejZ/LDTKFnFiLiqDfZcnFgvTT7tZKx5egKEyqirIASbjbwf8PL+RLkpM
	9CiGK94U4V8REHZNnkK6i1TVCjk1IonYeZqmKp4HicJK57BTpJa8ajEfM28f4TkR
	TZBn8kFUGqfPhY2Jk0agjvErtU+GFGPiF0t5C7ko5+ETgKW2aVIJMN+qYBCU17Qn
	BKCpHuN/7+hc2P0d/cH8CeDHyfmuQ5GfsKbHfjAK8cKamcLRg4u+eCnY+KU/+Ap3
	1tgmmpI2eaiKBG05ojA6gJCyQAEHdutrpBpC3FT1HQcyLXtw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41134eg82k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 22:04:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EM4tRs030306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 22:04:55 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 15:04:55 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>
Subject: [PATCH v4] PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region
Date: Wed, 14 Aug 2024 15:03:38 -0700
Message-ID: <20240814220338.1969668-1-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RohhCJV1xzeBXph8iu9gzPSU9FERpgK2
X-Proofpoint-GUID: RohhCJV1xzeBXph8iu9gzPSU9FERpgK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_18,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140152

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
Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v4:
- Updated the subject line as suggested by Manivannan Sadhasivam.
- Updated commit message as suggested by Manivannan Sadhasivam.
- Modified the register offsets to be in lowercase for hex as
  suggested by Manivannan Sadhasivam.
- Squashed the patches as suggested by Bjorn Helgaas.
- Added a comment regarding the CPU physical addresses being programmed
  to PARF registers as suggested by Bjorn Helgaas.
- Updated the type of 'dbi_phys_addr' and 'atu_phys_addr' fileds to
  resource_size_t as suggested by Serge Semin.
- Changed the value being programmed to PARF_SLV_ADDR_SPACE_SIZE
  register from all 0xFs to setting 0x80000000 as this register
  only considers powers of 2 as value. Updated the commit message to
  reflect the same.
- Link to v3: https://lore.kernel.org/linux-pci/20240724022719.2868490-1-quic_pyarlaga@quicinc.com/T/

Changes in v3:
- Updated the functions qcom_pcie_configure_dbi_atu_base() and
  qcom_pcie_configure_dbi_base() to make having 'dbi_phys_addr' mandatory
  before programming PARF_SLV_ADDR_SPACE_SIZE register as suggested by
  Mayank Rana.
- Link to v2: https://lore.kernel.org/linux-pci/20240718051258.1115271-1-quic_pyarlaga@quicinc.com/T/

Changes in v2:
- Updated commit message as suggested by Bjorn Helgaas.
- Updated function name from qcom_pcie_avoid_dbi_atu_mirroring()
  to qcom_pcie_configure_dbi_atu_base() as suggested by Bjorn Helgaas.
- Removed check for pdev in qcom_pcie_configure_dbi_atu_base() as
  suggested by Bjorn Helgaas.
- Moved the qcom_pcie_configure_dbi_atu_base() call in the
  qcom_pcie_init_2_7_0() to the same place where PARF_DBI_BASE_ADDR
  register is being programmed as suggested by Bjorn Helgaas.
- Added 'dbi_phys_addr', 'atu_phys_addr' in the 'struct dw_pcie' to store
  the physical addresses of dbi, atu base registers in
  dw_pcie_get_resources() as suggested by Manivannan Sadhasivam.
- Added separate functions qcom_pcie_configure_dbi_atu_base() and
  qcom_pcie_configure_dbi_base() to program PARF register of different
  PARF versions. This is to disable DBI mirroring in all Qualcomm PCIe
  controllers as suggested by Manivannan Sadhasivam.
- Link to v1: https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/

Tested:
- Validated NVME functionality with PCIe6a on x1e80100 platform.
- Validated WiFi functionality with PCIe4 on x1e80100 platform.

 drivers/pci/controller/dwc/pcie-designware.c |  2 +
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 72 ++++++++++++++++----
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1b5aba1f0c92..bc3a5d6b0177 100644
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
index 53c4c8f399c8..e518f81ea80c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -407,8 +407,10 @@ struct dw_pcie_ops {
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
index 0180edf3310e..4d74d1b652be 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,6 +45,7 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE		0x16c
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -52,8 +53,13 @@
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
@@ -108,7 +114,7 @@
 #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
 
 /* PARF_SLV_ADDR_SPACE_SIZE register value */
-#define SLV_ADDR_SPACE_SZ			0x10000000
+#define SLV_ADDR_SPACE_SZ			0x80000000
 
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
@@ -324,6 +330,50 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
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
@@ -540,8 +590,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 {
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
@@ -628,8 +677,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -811,13 +859,11 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
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
@@ -913,8 +959,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -1123,14 +1168,11 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
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
2.25.1



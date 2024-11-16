Return-Path: <linux-pci+bounces-16992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E029D0126
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 23:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC606B24E34
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D2198A1A;
	Sat, 16 Nov 2024 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="avJUIMRu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C291925A1;
	Sat, 16 Nov 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731794464; cv=none; b=bHX8FJZ3VoIAXRFopP/zTiIMhEsVJxcsU9eE5A/WqH9rNbMBeVC3apsBfu/ORAJIguN9dgH1+q0+vjE7KyROdj+LUZR6HX18oYmSpncg3wWg0BTvFA9wb7BgUfx/kLUULiIhD0eP07znYa7qRDrCSkHp35VjtbM60wP+GpCAl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731794464; c=relaxed/simple;
	bh=muhbEbOygMma18foJZDQ+spIZoyqLn4uzrGIS55KVT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Jf+e9oIGbQAOlBNOWpVJBTx2ZvGe9xowgi1JLvS5yvKZD5Ll40HMLgWJnZksBdZwflVyLoSaV21MH7vZ3nGGZonnkSbUG7uC9KRGk35/acxM57GVKeIAyLHXj+rk8Qj9QXDsrWh1MwxkZqqpy7JoeExpdqkutIa4u5U6Cc+LvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=avJUIMRu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGKe1B4003438;
	Sat, 16 Nov 2024 22:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wJ/tZArJsR4egOigBip48/hKVBuqAoC/njUwFjUqQ8o=; b=avJUIMRupnVO5u6r
	yAs++jxxzZM803d0pqTgIVeHAyaHuI+sod5ZteAJsktTfnjTFUg7ihOpJy4eOHwE
	vXY7/bhcsdYt+mYBL5T/EzPs8OsQdYvhbmBxiObgisS37XZNvei10NOVXEBm0KnM
	/xT6cnr2bie/lNnKthfJtEDy27XVJE90dXzKG7jRPti1ikq/qYT27m5BSrLYZqGr
	Go4Edyy44kOoinfqsG0cjafjybUnzZn7OnIaDrMu7hWwwGS4qZTIepDTyrZxluuE
	94gNsTYFoSeUIdMZ8Gh1F3q4gQbcn+kXfx1H/CPrSUUgub3iXZLCDAAhKQJSUvJf
	+mtAyg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xkt9sdv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 22:00:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGM0oqe017788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 22:00:50 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 16 Nov 2024 14:00:43 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 17 Nov 2024 03:30:20 +0530
Subject: [PATCH 3/3] PCI: qcom: Enable ECAM feature based on config size
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241117-ecam-v1-3-6059faf38d07@quicinc.com>
References: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
In-Reply-To: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        <mmareddy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731794424; l=6734;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=muhbEbOygMma18foJZDQ+spIZoyqLn4uzrGIS55KVT4=;
 b=1YpfpbY3s3d3rzs+Or2qWgXNnjvLSF0Xd6ySsN+dBulKQXY/Oz94Pvp7seErcX83cKZNsGYa8
 qLRX1Px697WDkDa0GeUhLImfXc12+9GIaKy+MoFgI0/7nSO/hVSJCA7
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BoPPcHAhe3KqKrsugIez_w_BMlfzH3Od
X-Proofpoint-ORIG-GUID: BoPPcHAhe3KqKrsugIez_w_BMlfzH3Od
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411160192

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

The ELBI registers falls after the DBI space, so use the cfg win returned
from the ecam init to map these regions instead of doing the ioremap again.
ELBI starts at offset 0xf20 from dbi.

On bus 0, we have only the root complex. Any access other than that should
not go out of the link and should return all F's. Since the IATU is
configured for bus 1 onwards, block the transactions for bus 0:0:1 to
0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
link through ecam blocker through parf registers.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 104 +++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..266de2aa3a71 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -61,6 +61,17 @@
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
+
 #define PARF_NO_SNOOP_OVERIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
@@ -68,6 +79,8 @@
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
 
+#define ELBI_OFFSET				0xf20
+
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
 
@@ -84,6 +97,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define PCIE_ECAM_BLOCKER_EN			BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -293,15 +307,68 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
+static int qcom_pci_config_ecam_blocker(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u64 addr, addr_end;
+	u32 val;
+
+	/* Set the ECAM base */
+	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	/*
+	 * On bus 0, we have only the root complex. Any access other than that
+	 * should not go out of the link and should return all F's. Since the
+	 * IATU is configured for bus 1 onwards, block the transactions for
+	 * bus 0:0:1 to 0:31:7 (i.e from dbi_base + 4kb to dbi_base + 1MB) from
+	 * going outside the link.
+	 */
+	addr = pci->dbi_phys_addr + SZ_4K;
+	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
+	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
+
+	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
+	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
+
+	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
+
+	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
+	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
+
+	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
+	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
+
+	val = readl(pcie->parf + PARF_SYS_CTRL);
+	val |= PCIE_ECAM_BLOCKER_EN;
+	writel(val, pcie->parf + PARF_SYS_CTRL);
+	return 0;
+}
+
+static int qcom_pcie_ecam_init(struct dw_pcie *pci, struct pci_config_window *cfg)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	pcie->elbi = pci->dbi_base + ELBI_OFFSET;
+	return 0;
+}
+
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	int ret;
 
 	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_equalization(pci);
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
+	if (pci->pp.enable_ecam) {
+		ret = qcom_pci_config_ecam_blocker(&pci->pp);
+		if (ret)
+			return ret;
+	}
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
@@ -1297,6 +1364,7 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
 	.post_init	= qcom_pcie_host_post_init,
+	.ecam_init	= qcom_pcie_ecam_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1566,6 +1634,31 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static bool qcom_pcie_check_ecam_support(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource bus_range, *config_res;
+	u64 bus_config_space_count;
+	int ret;
+
+	/* If bus range is not present, keep the bus range as maximum value */
+	ret = of_pci_parse_bus_range(dev->of_node, &bus_range);
+	if (ret) {
+		bus_range.start = 0x0;
+		bus_range.end = 0xff;
+	}
+
+	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!config_res)
+		return false;
+
+	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
+	if (resource_size(&bus_range) > bus_config_space_count)
+		return false;
+
+	return true;
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
@@ -1600,6 +1693,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
+	pci->pp.enable_ecam = qcom_pcie_check_ecam_support(dev);
 	pp = &pci->pp;
 
 	pcie->pci = pci;
@@ -1618,10 +1712,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pcie->elbi)) {
-		ret = PTR_ERR(pcie->elbi);
-		goto err_pm_runtime_put;
+	if (!pp->enable_ecam) {
+		pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
+		if (IS_ERR(pcie->elbi)) {
+			ret = PTR_ERR(pcie->elbi);
+			goto err_pm_runtime_put;
+		}
 	}
 
 	/* MHI region is optional */

-- 
2.34.1



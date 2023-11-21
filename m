Return-Path: <linux-pci+bounces-39-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0817F3130
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720B2B21AA2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D61FAB;
	Tue, 21 Nov 2023 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KuC5/jTU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57C90;
	Tue, 21 Nov 2023 06:38:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE2Kx1003273;
	Tue, 21 Nov 2023 14:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6m9K4vniRM1cm9XykEn3aVVrElNUgVyAXXqNcin6ABs=;
 b=KuC5/jTUeIpKJsd/lz6YLK4RNKtyKi5xAgmImS9bbx8i+NY3yLXcptxNuRx7tl3CbuR4
 Nw0lr8QGalMH+eqFD9whMi2ev5P5RuJCZqKm+4+2rojxJ59z5atgbb3rIv6OS/IJcLUK
 G1/1hPTEQXjeg4hXh39L2XRiXJcZ7Y0l0sdnashjn+L6+Otq2iSXx5Cyf8CAt/PHouev
 ow3r/8oOU+o7StAhloN/dFocRyA5CjC8pnqNAJdWknDAODvikhhkJm0i1tiMvi6QeiMS
 X3zuJUN2WlZ++UuhfsovIv/sytHlcdB98vTFxGtmUknFqfJx5T6JO7n/HJb6CucTEHwL JQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugssks5be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 14:38:25 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3ALEcLDP006122;
	Tue, 21 Nov 2023 14:38:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3uepbke7qa-1;
	Tue, 21 Nov 2023 14:38:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALEcLTi006115;
	Tue, 21 Nov 2023 14:38:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ALEcK62006113;
	Tue, 21 Nov 2023 14:38:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id DE5704C8C; Tue, 21 Nov 2023 20:08:19 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P EP
Date: Tue, 21 Nov 2023 20:08:12 +0530
Message-Id: <1700577493-18538-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: df912xcZi2L0VD-UTdSz1fttClD93xBa
X-Proofpoint-ORIG-GUID: df912xcZi2L0VD-UTdSz1fttClD93xBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_08,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=643
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210114

In a multiprocessor system cache snooping maintains the consistency
of caches. Snooping logic is disabled from HW on this platform.
Cache coherency doesn’t work without enabling this logic.

8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for
this platform. Add struct qcom_pcie_ep_cfg as match data. Assign
no_snoop_override flag into struct qcom_pcie_ep_cfg and set it true
in cfg_1_34_0 and enable cache snooping if this particular flag is
true.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 3a53d97..2cf9a24 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -47,6 +47,7 @@
 #define PARF_DBI_BASE_ADDR_HI			0x354
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
+#define PCIE_PARF_NO_SNOOP_OVERIDE		0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_SRIS_MODE				0x644
@@ -86,6 +87,10 @@
 #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
 #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
 
+/* PARF_NO_SNOOP_OVERIDE register fields */
+#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
+#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
+
 /* PARF_DEVICE_TYPE register fields */
 #define PARF_DEVICE_TYPE_EP			0x0
 
@@ -149,6 +154,10 @@ enum qcom_pcie_ep_link_status {
 	QCOM_PCIE_EP_LINK_DOWN,
 };
 
+struct qcom_pcie_ep_cfg {
+	bool no_snoop_overide;
+};
+
 /**
  * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
  * @pci: Designware PCIe controller struct
@@ -167,6 +176,7 @@ enum qcom_pcie_ep_link_status {
  * @num_clks: PCIe clocks count
  * @perst_en: Flag for PERST enable
  * @perst_sep_en: Flag for PERST separation enable
+ * @cfg: PCIe EP config struct
  * @link_status: PCIe Link status
  * @global_irq: Qualcomm PCIe specific Global IRQ
  * @perst_irq: PERST# IRQ
@@ -194,6 +204,7 @@ struct qcom_pcie_ep {
 	u32 perst_en;
 	u32 perst_sep_en;
 
+	const struct qcom_pcie_ep_cfg *cfg;
 	enum qcom_pcie_ep_link_status link_status;
 	int global_irq;
 	int perst_irq;
@@ -489,6 +500,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val |= BIT(8);
 	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
 
+	/* Enable cache snooping for SA8775P */
+	if (pcie_ep->cfg && pcie_ep->cfg->no_snoop_overide)
+		writel_relaxed(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
+				pcie_ep->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
+
 	return 0;
 
 err_disable_resources:
@@ -511,6 +527,10 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }
 
+static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
+	.no_snoop_overide = true,
+};
+
 /* Common DWC controller ops */
 static const struct dw_pcie_ops pci_ops = {
 	.link_up = qcom_pcie_dw_link_up,
@@ -817,6 +837,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
 	pcie_ep->pci.edma.nr_irqs = 1;
 	platform_set_drvdata(pdev, pcie_ep);
+	pcie_ep->cfg = of_device_get_match_data(dev);
 
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
 	if (ret)
@@ -875,7 +896,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
-	{ .compatible = "qcom,sa8775p-pcie-ep", },
+	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
-- 
2.7.4



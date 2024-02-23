Return-Path: <linux-pci+bounces-3918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9486138C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422E8B23340
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD71823CE;
	Fri, 23 Feb 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NLRK/UpB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F381ACC;
	Fri, 23 Feb 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697050; cv=none; b=p1I707Vw6JbCKEEuGQVJP5eZmkm+h7U6pPk4FEx0H9EFYVpwSVgBIDuhrr8cIffyUymzHXGsD7ZGNDuqaujep5ZK0ntWZRpBCZvSuizymEQenxKtq7sui3jJILfQ1WI3TrK4o25nceOnEs/uP2EAxlMoicctVKs2vyaCTucf8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697050; c=relaxed/simple;
	bh=xPsYxYaXctL6OwVxC6q/yhBVDQBb7DxQdGMybM75kxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ep/3vBGmFkhvotGcDElZvr1r4NxMBpni7V0higr0pxlMAHgmfMdx0z5Pg3QdjMtXM4xTE6+6HnXELin5Hn2/HzDxMVZQgGoP5ChpTWDEUEDdzuwP9O8FUFko1kSe3FAx6YOGjn3DsFjLNR52lKfpinVL9DKAL1T9+9Txok0YMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NLRK/UpB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41ND8GAk022566;
	Fri, 23 Feb 2024 14:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=ZYjOvKqIdGSZ4UkdmEQfuRqPiU0eAQeT2YEEkDuGum4=; b=NL
	RK/UpBtz/5uVRvis7pdgwkutUKMLZHu89nuL5XPumvJisZIxcsoA/PHG9YHqY6Kn
	W4qGx9nyndLFqR7PkJovGbDmONPsluzxL6daUFilfB8oEsI+6Poj1KAwkkzZdUqJ
	pYmvp0dqIXYPvPEZ4+ocr+ExWCi3RMLXxGmX9mDiZUjvNMSU2Wzp3tM3/c/Q0zal
	uAmYpCux7WEL9KrfUENS/AJuCY41ZxK89VaaxpcTa98wUPi7YT1qFCWPd1OrjGN7
	SPm9e0/jB15vm+9mjBUYLV3tT7svdeWPO2vM32Rjzm64wh++QS0yMTyoJwoaSRMM
	a6cpwT4hVVR/7oieXDHA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqcf8sgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:03:59 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41NE3rad027358;
	Fri, 23 Feb 2024 14:03:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvme288-1;
	Fri, 23 Feb 2024 14:03:55 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NE3teL027395;
	Fri, 23 Feb 2024 14:03:55 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41NE3two027392;
	Fri, 23 Feb 2024 14:03:55 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 6C35A14F8; Fri, 23 Feb 2024 19:33:54 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P EP
Date: Fri, 23 Feb 2024 19:33:39 +0530
Message-Id: <1708697021-16877-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
References: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1UHkap_p5j5UxBqNwVhWGqZUp_FiDhN1
X-Proofpoint-GUID: 1UHkap_p5j5UxBqNwVhWGqZUp_FiDhN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230102
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that there no cache coherency issues exit
for the addressed memory on the host i.e., memory is not cached. But
in reality, requester cannot assume this unless there is a complete
control/visibility over the addressed memory on the host.

And worst case, if the memory is cached on the host, it may lead to
memory corruption issues. It should be noted that the caching of memory
on the host is not solely dependent on the NO_SNOOP attribute in TLP.

So to avoid the corruption, this patch overrides the NO_SNOOP attribute
by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
needed for other upstream supported platforms since they do not set
NO_SNOOP attribute by default.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 89d06a3e6e06..369954649254 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -45,6 +45,7 @@
 #define PARF_SLV_ADDR_MSB_CTRL			0x2c0
 #define PARF_DBI_BASE_ADDR			0x350
 #define PARF_DBI_BASE_ADDR_HI			0x354
+#define PARF_NO_SNOOP_OVERIDE			0x3d4
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
 #define PARF_ATU_BASE_ADDR			0x634
@@ -86,6 +87,10 @@
 #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
 #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
 
+/* PARF_NO_SNOOP_OVERIDE register fields */
+#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
+#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
+
 /* PARF_DEVICE_TYPE register fields */
 #define PARF_DEVICE_TYPE_EP			0x0
 
@@ -152,9 +157,11 @@ enum qcom_pcie_ep_link_status {
 /**
  * struct qcom_pcie_ep_cfg - Per SoC config struct
  * @hdma_support: HDMA support on this SoC
+ * @enable_cache_snoop: enable cache snooping on this SoC
  */
 struct qcom_pcie_ep_cfg {
 	bool hdma_support;
+	bool enable_cache_snoop;
 };
 
 /**
@@ -175,6 +182,7 @@ struct qcom_pcie_ep_cfg {
  * @num_clks: PCIe clocks count
  * @perst_en: Flag for PERST enable
  * @perst_sep_en: Flag for PERST separation enable
+ * @cfg: PCIe EP config struct
  * @link_status: PCIe Link status
  * @global_irq: Qualcomm PCIe specific Global IRQ
  * @perst_irq: PERST# IRQ
@@ -202,6 +210,7 @@ struct qcom_pcie_ep {
 	u32 perst_en;
 	u32 perst_sep_en;
 
+	const struct qcom_pcie_ep_cfg *cfg;
 	enum qcom_pcie_ep_link_status link_status;
 	int global_irq;
 	int perst_irq;
@@ -497,6 +506,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val |= BIT(8);
 	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
 
+	/* Enable cache snooping for SA8775P */
+	if (pcie_ep->cfg && pcie_ep->cfg->enable_cache_snoop)
+		writel_relaxed(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
+				pcie_ep->parf + PARF_NO_SNOOP_OVERIDE);
+
 	return 0;
 
 err_disable_resources:
@@ -811,7 +825,6 @@ static const struct dw_pcie_ep_ops pci_ep_ops = {
 
 static int qcom_pcie_ep_probe(struct platform_device *pdev)
 {
-	const struct qcom_pcie_ep_cfg *cfg;
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie_ep *pcie_ep;
 	char *name;
@@ -826,8 +839,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
 	pcie_ep->pci.edma.nr_irqs = 1;
 
-	cfg = of_device_get_match_data(dev);
-	if (cfg && cfg->hdma_support) {
+	pcie_ep->cfg = of_device_get_match_data(dev);
+	if (pcie_ep->cfg && pcie_ep->cfg->hdma_support) {
 		pcie_ep->pci.edma.ll_wr_cnt = 8;
 		pcie_ep->pci.edma.ll_rd_cnt = 8;
 		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
@@ -893,6 +906,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 
 static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
 	.hdma_support = true,
+	.enable_cache_snoop = true,
 };
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
-- 
2.40.1



Return-Path: <linux-pci+bounces-4576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2F787376B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417331F23F04
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CF131759;
	Wed,  6 Mar 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bKONn1aJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69576131721;
	Wed,  6 Mar 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730693; cv=none; b=muAdqGCaZamymlrztB4bjaXvLXdo2dtc0CjsGc3+6j7oDiCsKDeQ1o1HO7Q8gZzHOu7y1SSToWNlyyC/O3/vyd32NHolWIPToGjDaQz2qPM00+IAftYtyiv5NdF2wsRZCOqLNC3lb+JCOnzFaDQbmANW1Ax/BigDo0SN8YgdG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730693; c=relaxed/simple;
	bh=mcqBM8uJUuDNR7WGFdZLnE8j/xBMjzJ4J/8bu4EgkqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nhhYTx5lnHo1pSaFxYWANkJQDRNlhxLjNWIKtCcVGLyAE3V+uLwGN7aP2l1/HkyHQVBD4sqp/1MZPitwJimjAhDSHDuAr1Tqeo5psjsyC1jQAhV68eSX48/x4Rc3OiZUsZQEogxm1JNyEHALQDRQgo+1+B/2dxoq2LFBtbh+lR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bKONn1aJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426CPd9x002949;
	Wed, 6 Mar 2024 13:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=CquC/umhJwKa66muxW7FvRds55imuq41L55a4pHAccQ=; b=bK
	ONn1aJYklscAaoTH2/BgTOtvjmp5DL7bVJiT1QUPygB2ZKl2zPU5YtUMWm7kiigd
	JSbQOXUhieZTnBBOGYsML8fjQW191BDDGOQY6Czf2wnytmbf+AvAqGG8tRqoNKs/
	Zx+tQMXnJllmZFewf/MAv/teQ40Hcz9uwNdgzpmCvOPJRsD8Ah4wYtx6jsrscKDe
	xAWxpJgau4ammYZ1OUuabYnSC3WKad+C5Qj3d4LAwBp1q7qwsSWAe+c7dJP5AOC/
	cXM5DBOG7z7ixeYOlQ68pEpcsLsiuZ9mQUMf3If3lSDljXq02sJT28XrmEI8o3VM
	il0Bf1AcXI6zC6309GZg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpbav1pvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 13:11:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 426DBKT2019110;
	Wed, 6 Mar 2024 13:11:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wp0608qkv-1;
	Wed, 06 Mar 2024 13:11:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426DBKUi019104;
	Wed, 6 Mar 2024 13:11:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 426DBJXV019103;
	Wed, 06 Mar 2024 13:11:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 90A5326B8; Wed,  6 Mar 2024 18:41:18 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 2/3] PCI: qcom-ep: Override NO_SNOOP attribute for SA8775P EP
Date: Wed,  6 Mar 2024 18:41:11 +0530
Message-Id: <1709730673-6699-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
References: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3xUhdoOt2LHp5EAG4q_wu0WbCZBVKjl2
X-Proofpoint-ORIG-GUID: 3xUhdoOt2LHp5EAG4q_wu0WbCZBVKjl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060105
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that no cache coherency issues exist for
the addressed memory on the host i.e., memory is not cached. But in
reality, requester cannot assume this unless there is a complete
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
index 89d06a3..aa8e979 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -47,6 +47,7 @@
 #define PARF_DBI_BASE_ADDR_HI			0x354
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
+#define PARF_NO_SNOOP_OVERIDE			0x3d4
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
 
@@ -152,9 +157,11 @@ enum qcom_pcie_ep_link_status {
 /**
  * struct qcom_pcie_ep_cfg - Per SoC config struct
  * @hdma_support: HDMA support on this SoC
+ * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
  */
 struct qcom_pcie_ep_cfg {
 	bool hdma_support;
+	bool override_no_snoop;
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
 
+	/* Override NO_SNOOP attribute in TLP to enable cache snooping */
+	if (pcie_ep->cfg && pcie_ep->cfg->override_no_snoop)
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
+	.override_no_snoop = true,
 };
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
-- 
2.7.4



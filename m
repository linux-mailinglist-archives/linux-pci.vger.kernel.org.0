Return-Path: <linux-pci+bounces-19009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3809FBF05
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 15:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722A21884745
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82C1DBB38;
	Tue, 24 Dec 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="il/TPmrg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A61D79B3
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735049468; cv=none; b=Bb8CV8Qpv9eT7R2VynNhlLe33VgDrO5Kjqx236TuvOA5Cy0oMDC0GNHaa30sw36wnfr3GZOaFEp9p+5yhLCYGtAiOj23kG41hhjA/SU04Pv1zXzJ2JTFu/SydgxlKz3xMgEhVM2JNqdG6JTfUsj9qcOea3I46H2xRlP9kp9q2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735049468; c=relaxed/simple;
	bh=wUYvHZAm3A/KcGP43qeUWycLI5gU56sEXnr/Lx8vtfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnLp6B9gTZeQZ9Ujwtc0gzfsV5S8PqF68tISt8YptbIaiMk07Hp2OwY28ndTp3pJyaYuyX3Km3xSk3f2aPeaDZ89EQFb04RkFuWbarbOCeejgOAgDoDkpm8or4Ed1W7VuRvyEIr/TKTdOw8WWtnNxO9FfbftrI5/deLLIOE+zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=il/TPmrg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO9ZZVJ007854
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 14:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vPQy9s4x824wAEkt8ywhd2HnwSF0tV7LCRg9PNd+bLc=; b=il/TPmrgxXzjYejR
	KrH1oV6naHe4APpK9pgQLFyET7/4BTk9nU8tLz1AKQt3mi4OIxkJmg3biyX6fLUo
	CvPlMqNmM5lLSCH8mpwmqoXcw23UxuZXZbxA1Sk4jyx8JqkZvvuxW7tPpOTsxjSy
	D8W1MFPD82ENQsZewb/xAIPWZckZCZQDlee1ty3BhKHtSwUnD9ToA7EWlnzCQrOB
	CLVHRUFzAjqtLpPFYeIw6rFv3u8qzhbzBuU3QGLl2MNdt8D68wLdvcRA1PImQOpK
	P1DX8c9wI5EsaM7FsKEZQTsgzM0WMLIUz9Q9sX3BzgwwjyegbYaj81lri1VvVK0E
	oHNN/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qtf89djq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 14:11:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso5058799a91.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 06:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735049464; x=1735654264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPQy9s4x824wAEkt8ywhd2HnwSF0tV7LCRg9PNd+bLc=;
        b=AgmMtPKqCmQXs0RMUg/9PjOj81U6dMCKDeCwAS/sNlqBi4HtIO7tlMMR6osjkvmr+T
         GMIydzU3eBo1jKlIj6voAFAuZhDL9C0p/x0LluwjCOdQo96T4aRcYhqcVxs12sZyA7Q5
         D5pksDiDk5UxZsuSXqysvV5ij4TqzeJXUsNnj2TVMDqaOjPE2C7s4ysEpcj5OyV0RY3q
         qAPiJjXnfB8jo65vbn9055mISjasNs4ZHUDoqJnKeCDkp1JbXlUvzCVTiOFumb5GST6X
         QtkvAjTjK4s1/VSgjRJpG98t1OpdN7jR+IjD2AIBG78k2fhcPsm48NLWmdhea09DDzfr
         47nA==
X-Forwarded-Encrypted: i=1; AJvYcCUhegALMpNTsj64wa8mZu/PpD3+Cmykf6b9bJ5GJgF628H54B6/ga8mE85zV/V8+JVQ8IPtZAKp6LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIZmVP0t/YlpMnqM4Y03RmKjl7brKjtJtC/q9xZUoerjcrKX/
	IMpJwmXVh5OLY9uUiaZw7VteVhkSBMsxO744AgEt4cghreLU+UkwJ5j867Ew9CNNzVyyvf3q1TX
	UDc82kdW9IL7xSKmfb4tJE5bMcKBJvxcrBBSgbFREX43d43UCUPUAOm/BeyU=
X-Gm-Gg: ASbGncsmyTrMtPppQXhT0Y0TFOu9nlSyBpzb7/SnTL6n12y2XGfOh7kMTnwYSvxxrm+
	ie5BckxLs+FSNLvpr0xHIVfR8owMxFj9/a4opanQuu6SIPQFgNbyDRiFp7exZfzRUy5oXgCnAYj
	3G3WPY4wovaaRxDOJj43cPoRqywmD4tADXoi2mHYUh7BzrliCO5Xg/bsRUJGiDPkJ7hyyVsvGjW
	kHQwH0zkaUX6X06rrN9JFNaMIyx7BGhHsNcRYmoCHySBdOhHQtI+Ccy2nfqicdPngW0D15KqDXj
	W3SjAhJxYQdzL7zX
X-Received: by 2002:a05:6a00:7428:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-72aa9a10440mr28763232b3a.3.1735049463615;
        Tue, 24 Dec 2024 06:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErff/FA1vKquEFtYhlg+zdGdF4K7JzJ02E1k3WXm+tdcOzvFvSCIJeGGmW9knAoOWGJCCAyw==
X-Received: by 2002:a05:6a00:7428:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-72aa9a10440mr28763175b3a.3.1735049463166;
        Tue, 24 Dec 2024 06:11:03 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90b8f5sm9691216b3a.194.2024.12.24.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:11:02 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 24 Dec 2024 19:40:18 +0530
Subject: [PATCH v2 4/4] PCI: qcom: Enable ECAM feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-enable_ecam-v2-4-43daef68a901@oss.qualcomm.com>
References: <20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com>
In-Reply-To: <20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, mmareddy@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735049433; l=6085;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SYsZuISEFecO0dItPGcTh+FGUKWuxe8fmZZ5miNptNM=;
 b=dLBEFEgy1I5Gl1ZJAKGNY0qz6PpU7YGeC8ekRh7iiq6BJwbg6v31pm9WdBv1yxGgCqiFpqTsM
 zKTdDCvesKEAwi0z29XkkxKSQXAIBO5IzcBlW9NEbOn1SUMfYkE6DFX
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: sDVZN2ZbJbQEsnvTxfK-K5sT7q7ikitl
X-Proofpoint-ORIG-GUID: sDVZN2ZbJbQEsnvTxfK-K5sT7q7ikitl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240120

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. so use this offset and cfg
win to map these regions instead of doing the ioremap again.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc102d8bd58c..cf94718d3059 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -52,6 +52,7 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
+#define PARF_SLV_DBI_ELBI			0x1b4
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
@@ -61,6 +62,17 @@
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
@@ -84,6 +96,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define PCIE_ECAM_BLOCKER_EN			BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -294,15 +307,60 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
+static int qcom_pci_config_ecam(struct dw_pcie_rp *pp)
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
+	 * The only device on root bus is the Root Port. Any access other than that
+	 * should not go out of the link and should return all F's. Since the iATU
+	 * is configured for the buses which starts after root bus, block the transactions
+	 * starting from function 1 of the root bus to the end of the root bus (i.e from
+	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
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
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	int ret;
 
 	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_equalization(pci);
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
+	if (pci->pp.ecam_mode) {
+		ret = qcom_pci_config_ecam(&pci->pp);
+		if (ret)
+			return ret;
+	}
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
@@ -1233,6 +1291,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1241,6 +1300,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	if (pp->ecam_mode) {
+		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
+		pcie->elbi = pci->dbi_base + offset;
+	}
+
 	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
 	if (ret)
 		goto err_deinit;
@@ -1613,6 +1677,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
 
+	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!pp->bridge) {
+		ret = -ENOMEM;
+		goto err_pm_runtime_put;
+	}
+
+	pci->pp.ecam_mode = dw_pcie_ecam_supported(pp);
 	pcie->pci = pci;
 
 	pcie->cfg = pcie_cfg;
@@ -1629,10 +1700,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pcie->elbi)) {
-		ret = PTR_ERR(pcie->elbi);
-		goto err_pm_runtime_put;
+	if (!pp->ecam_mode) {
+		pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
+		if (IS_ERR(pcie->elbi)) {
+			ret = PTR_ERR(pcie->elbi);
+			goto err_pm_runtime_put;
+		}
 	}
 
 	/* MHI region is optional */

-- 
2.34.1



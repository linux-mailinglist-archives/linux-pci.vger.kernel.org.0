Return-Path: <linux-pci+bounces-20849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1535A2B69F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 00:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC323A6591
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6F23BFA1;
	Thu,  6 Feb 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NfNNVWdA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47F23909E
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738884572; cv=none; b=c29blf1y1AcnXabHrV1IXG5KuYZPuK89+5KuOHcDbhaYdG9v40M0UCO3YEp0SelyUrIGVrVCoAzw/GSirOvsfo5yZ2Fl0H8/BcwMAk+4pfGFmCIPu6AieT4z2hmtCPmkk/QLaghfuDYyMECM6JJzcX5JO7dgV0MHBe0POnLvbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738884572; c=relaxed/simple;
	bh=BgNsZ2EhBxd/BSWpqXyZykgbwBhLSUsbRTbb1BSQdUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8ZtewGtYBhhbxMZZigkv3EfbOR3eBsBVIudmMFVyWVB8UXFzxv6TpQYEjWcGqQdeIG8OwT0FKPj7r04++y0dGA4z1q0F5VDzOdHn2yyzNaEgfGdoF4j/tiMeA02yonpRrl3ioyZO6/rfwxc1BGy/64YxD5xtHy7Zdea8rHYUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NfNNVWdA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516ELgTi017417
	for <linux-pci@vger.kernel.org>; Thu, 6 Feb 2025 23:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U+bqz9EHeHzQ2Pjn9rG9487ONwiuzpgqIzdaaOh917I=; b=NfNNVWdAWoboHRnz
	+N4Zg7BpQUG/peh4iVo+XwQBbLfrD09C+v0ZykMi8vDnNRVjss7p2gl+XKRcMKQ7
	CuVuRYIXCYcxZcvhsJOTqDceuWVfI4GuXFWg+ddPnZtiCQxR7LQ4mrT5sRV306gO
	kbrBrvXpiHP6T3LBuec+ikVUmIiH2fHQTKPvHkYlJ7PDZJUNVTw+mM/eW+bXLobQ
	r6JYDxbCVPXhzeU8Xq5j8BM07UOt04ljxdtcPgml3WGQXHqoXStRaFGEkzl2OARQ
	Xy4u7aNv6E92mTlv+3HniBmlLNxbb02SjIXznACPURSLjRaXujwqeP+R9bKFdWmk
	Gr0yLQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mxsc17wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 23:29:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa11d8e448so3256115a91.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 15:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738884569; x=1739489369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+bqz9EHeHzQ2Pjn9rG9487ONwiuzpgqIzdaaOh917I=;
        b=u8d7XGFIhmlBlDtJzGL4Qkbgwmby66kO+vSDTRmIAVL1G/i5p0+ppYbyQbGW8tteDb
         UF/PHNXmcm9eTOqBJHrJZbGzFeKqytKr0J2HMm0Pl3pzDp5scW7K6E5e1/+0KfXPsXeo
         rZezuCZ3LXX8PXlevwuhU9HUMhBzQvccqo6Io10lDPcm+zE3KLJGzshDicbNbINnHGD9
         L+XQOA+ftDvLGAHOEw/Idg5W+Smv9fQXr7Uabb84tgf1R9EalqjkmqZmfjLXezs8R96d
         kqBs/rVvyi8/cYwPBmddicQbw8aTpCuDYSUnHuK0w9MAmiK6lhTwO51mCMpsEWtQwAc8
         V6sg==
X-Forwarded-Encrypted: i=1; AJvYcCX4dpidvsP3yOhxr2cIEICf8PR4OC4k+PoINFaK0ZTzdpXZPxAi0R1T84ZOuXtrUr1RMiHRALiAD0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLBlHYM0LZGKE+nAGuo+jyYHd3iDyAcu5Nq6jPDPmRKIaqzpZ
	8R/JZPnCiQUgSqbLPPBUFYrDPu6MeKAD+EWKTcope+/z6Gv7HvHfnIEt51QVsEwBSxHey94UFTD
	Rfxd48pH1KuEJpqn5DggGeRTzkm9ZB+etA9Zl1osAd6Mx/VQ+NjRN3PNmfF7o0azT1wY=
X-Gm-Gg: ASbGncvRfLd3XQbRNQMfW6s/OqmBO8C5O1BREMRLf839mSwoUJxKBkPA94Fl8GdjDKk
	opxt8+NTX9jzEUBpjpQ9bzRrior4vkLhSsrXvJXvSOe4IH/3gocN5J1YTQ8scPYEJ4iH/O5vlf5
	NnDWPRgVuelpZt8J1/ILdy0yxaPtKHn8nW1YnIsIl90I3FTqvz/1v8EH2x5YpzF3+U4i8Js3UCw
	wWqKgmBpDRPiYn5NdzAKt4xKmr25mJ12s/U5kUkBBkqzm2TShnMG+tsflSq0e0uGq+PkV403FRY
	j4S/hbGZ9r2c3HmFnEbsUoDRRdtESFUHUp29NKaT
X-Received: by 2002:a05:6a00:4303:b0:72a:83ec:b16e with SMTP id d2e1a72fcca58-7305d53a58fmr1438936b3a.21.1738884568601;
        Thu, 06 Feb 2025 15:29:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1nJAHgxkAN6yu/cuiRuyEu57hBwAYKzGaS3dQQShr42srddHjkm9PXWcqaHXZhbVEMDlPig==
X-Received: by 2002:a05:6a00:4303:b0:72a:83ec:b16e with SMTP id d2e1a72fcca58-7305d53a58fmr1438906b3a.21.1738884568240;
        Thu, 06 Feb 2025 15:29:28 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm1845905b3a.74.2025.02.06.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 15:29:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 07 Feb 2025 04:58:59 +0530
Subject: [PATCH v4 4/4] PCI: qcom: Enable ECAM feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ecam_v4-v4-4-94b5d5ec5017@oss.qualcomm.com>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
In-Reply-To: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
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
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738884540; l=6070;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=BgNsZ2EhBxd/BSWpqXyZykgbwBhLSUsbRTbb1BSQdUc=;
 b=LUuYaHAwc2zakqylAGfB988VMwU6n8H9p/Go6NO2jnuQGQwnPr1ZV2j/g3cwoTXFzmrXapBWG
 5rIWwjQ4XseBpCb7AXnc0WZ9i67sgP/RrbMPxDYSABKTH+VjaJLT5im
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: q5eb0K-RUiz95MZXCZFoJrVUufoEa4u2
X-Proofpoint-GUID: q5eb0K-RUiz95MZXCZFoJrVUufoEa4u2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502060182

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
 drivers/pci/controller/dwc/pcie-qcom.c | 77 ++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..84297b308e7e 100644
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
@@ -294,6 +307,44 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
+static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u64 addr, addr_end;
+	u32 val;
+
+	/* Set the ECAM base */
+	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	/*
+	 * The only device on root bus is the Root Port. Any access other than that
+	 * should not go out of the link and should return all F's. Since the iATU
+	 * is configured for the buses which starts after root bus, block the transactions
+	 * starting from function 1 of the root bus to the end of the root bus (i.e from
+	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
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
@@ -303,6 +354,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
+	if (pci->pp.ecam_mode)
+		qcom_pci_config_ecam(&pci->pp);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
@@ -1233,6 +1287,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1241,6 +1296,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1615,6 +1675,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1631,10 +1698,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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



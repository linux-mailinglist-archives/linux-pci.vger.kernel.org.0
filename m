Return-Path: <linux-pci+bounces-38548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06FBEC3E0
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 03:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8C41A65B46
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 01:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0619995E;
	Sat, 18 Oct 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5n/i9yd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F2217736
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751237; cv=none; b=hGIOGNuYrPK+eTCNSi4qv8o1oc6U3DAD9m5hFoRnThJl5AuTeuSH5jsp+vUWvTFsHj0LvK9QNtGPQsxs4JXUiRJhvpZhQCAPosexLLIKQFwbR04n+nza2XLeuOy8J2uSfKUxMlcEtgiIe6XCk0vDcc6pMnMVr5XlCs5AkUVOTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751237; c=relaxed/simple;
	bh=FpDxHLlqUZ+XGHyViui56XmvYboqFqBaLMsyLmHrEjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dibLKleyHLJQYAS6BbZzhPUWKUmFagF0JnA0zDaWpZMgcQFGPeNPRrRw4MkQCAarxbimm4FLrv0Blh7ftBney4K//Ijfyd63FUKUbu99nVXOhINvllZk60VGO1f6bhhxpopYf5ktdTBtSXWMAE8Qc3X1H2YyiLuXhvUd5qlsccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5n/i9yd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJG7bV018419
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ul01yB/PmIF5rsEoiQYYpJP41+BqBJ4MU+FjnMDvYVQ=; b=b5n/i9ydwyPNRF4C
	mNwPiE/afJxNHr9XdkDxHnofotjPRlipfBXq30EbfqHwJ09tz3WMhUYDSn62HFLA
	sCSziuYYsXqdjFp55VSyb9yka5e1hPTsX5O2onngANc9DS6HHtQOluJHFUPvnBlx
	Dn3uY3cSl/TY7VjJyOphQPGfFXnJ/I/joYP5nY/k7GFcphWNGrWvQD0cGJMHIRlG
	HICjWA6cFIZY0v1S9ltoBmlgh4oHolmPbnLrGtHA7aidNU94BtqjhTv5g6V7HlT1
	gQhB+xjR7xct1E9FV5lmlcOwONY27TWOoLRP3xT51RGhV1Yf2jG/dyjUgCR0e1ON
	W6YyTQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8p5t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so2008894a91.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751233; x=1761356033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul01yB/PmIF5rsEoiQYYpJP41+BqBJ4MU+FjnMDvYVQ=;
        b=SWeTWRkmxv+ivOJlCHjp5fMZ51HjkJhJdtUXEQb7j3ihSycJzh1YmWwgGTzjDsuGTU
         Y1cJoPTy0sFXJ6ZelG3pn8dIOXnNrFAaQu1hQ7WPFcRKdvrxfgKseQTYfq8U2tomX+yD
         Bhcvy5U+YruuEU3N+ut8H3Qs7URtdu43sbkqTWU4UYaWiq2256TwvU7oM78da2VPYqpc
         LaTasJ3SR4dAPk9Ynmn/gy5wLcxHGQpuTrrFIeh0bbkWhHK9nNzEX880bYXxUVhZnKaU
         WbznAU6gZ9SmiCSoqEC01wtDNnHcMN6XkR646bVCbvQ9EVZGQ5dJIW2OYHHeNhI2ReN5
         hDQA==
X-Forwarded-Encrypted: i=1; AJvYcCVZLOojdZgQeYlCUEoB52YmuNerHIcRRAK3sZm22P9wJy5gP9sL7hYagHmRECjPpXFUMyNPQfx92+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2B1UkWoI2VFBLzAq3xWKMqf8hiU2fj8h7KNqQX3VvEqVCgyW
	Kxy83HBtLJsQTnYpJbzifFSdxxTeXQJIJRyf3hM+VIwsl+D5hM8k31kY0LmcwjYda4FyER9Ebx3
	mqSvAR1R0DRiVmF8qD5W1LwV+lgTvpklwPsXC5iR3+ipSH3EqmPWA/GCfn1nVMSE=
X-Gm-Gg: ASbGnctqgSGEg5VU8+WBAwIMxqvvTcgzUWSjscSPpjdegub9eynseVAeYjCivXW/yG9
	oLDPggQZ+WKSmf9J+e7EhFWkN00UA+il84cT6jRf2SV4ItwK38wSa2CJ74zG6GLDS0VZB8nMi2H
	h4Ogm+aY5b99HY77XaiJ97wZdTmtUHAFzm1IFMN0QgvbgEZxfvB+d02MbK6FNPlnYoBm8QFE6S8
	TBiAW/wWMhcxHmbDTqX8D6L/FjM43nHHg2OL8nqrfRf8o4YfVqdSTrJqvhaERcF4zyP0B8QAKSL
	If/6V+KpVVatP05p1xKSWyVc2tCGBtXPduXNNQm/xor4y/KEkj5yi8Gn39Fu7Av9qJXXiDDN9/D
	GKAi0UbkclYBZCdcEodw7Dy8kHEPbTCT6/mvQQ4K+6qeP8A==
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-33bcf8faaeamr7027700a91.24.1760751233321;
        Fri, 17 Oct 2025 18:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhgd8h+gjYCRAgJsNizEhdpEKTIJOJyi7ZEUs7pkgwCNS/nw/yoWOt3jimgW+A8TBDaTv9cQ==
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-33bcf8faaeamr7027679a91.24.1760751232945;
        Fri, 17 Oct 2025 18:33:52 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:52 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:43 -0700
Subject: [PATCH v5 6/6] phy: qcom: qmp-pcie: Add support for glymur PCIe
 Gen4 x2 PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=2061;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=iLPr+Du4SVVY2HNyB1uA8pllKkcuQDXDVG2QxHgn67Y=;
 b=Efk0/KbSfZj/WjkKqRhvcxliPbFO58kqb9rWUzQCQX8ah7wkDvdoRXAx9aYAlPBHZxJEcO4eq
 PxKIJ6L3AIeCJUKTVCeC6B3F3Bfbvt0rn+CAF9ToLzzCsQA8i1HqlDa
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: jSZcU7tdLGCAMmE0He1FNdHm5BvDLl0q
X-Proofpoint-ORIG-GUID: jSZcU7tdLGCAMmE0He1FNdHm5BvDLl0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX9TxP10k+9Usu
 lBzy2AInsLGqbW3rrboMykvhinmoUY1MtKwfOhMmOyOn1HdBEnTwwSJy0qdgdQ8MfxUjMUE2y7N
 5bcDXEpreVRxzkWCeuFjfTSxc9r7AFrp99918wHLSQRxkNmy1JK/rrLK1eP0Md7dePEjCNNw7Y0
 cbq4xjJs9Yt0MlVc21DULO38q9BuH2I2l+pB9wwewNHDdys+i+YN6f8r4dZJPEkXXTj6l8rWDab
 Cz5niCf+GoOxdabpC8QBHNCgq9MhG+KXVsSYzUqZBh+GByV3GvWIRXRT98fDqWpdZPukVQgtB8j
 Dik6PMs4XB1Gm1mWGUlSIyPHwlR0WDjznMtTEVTZVyNDkV9Sqqk1wrLcYsEwPpmHJBlFnvwAonj
 THcylvm+QAvzS2FGGZrn/U2HmkBrJQ==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f2ee82 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=hii3Kp118aGdntTlwUgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

From: Qiang Yu <quic_qianyu@quicinc.com>

Add support for Gen4 x2 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..2747e71bf865907f139422a9ed33709c4a7ae7ea 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3363,6 +3363,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
 	.ln_shrd	= 0x8000,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
+	.serdes     = 0x1000,
+	.pcs        = 0x1400,
+	.pcs_misc	= 0x1800,
+	.tx		= 0x0000,
+	.rx		= 0x0200,
+	.tx2		= 0x0800,
+	.rx2		= 0x0a00,
+};
+
 static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
 	.serdes     = 0x8000,
 	.pcs        = 0x9000,
@@ -4441,6 +4451,21 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v8,
+
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v6_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -5192,6 +5217,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
+		.compatible = "qcom,glymur-qmp-gen4x2-pcie-phy",
+		.data = &glymur_qmp_gen4x2_pciephy_cfg,
+	}, {
 		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
 		.data = &glymur_qmp_gen5x4_pciephy_cfg,
 	}, {

-- 
2.34.1



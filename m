Return-Path: <linux-pci+bounces-34973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CDCB39566
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFE71660A6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15241F8AC5;
	Thu, 28 Aug 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdFsJQGq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B930102D
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366529; cv=none; b=lazIdXGKZUWDLEEPqgGxrJDAy6YVQtF8y/Q70nG68VsVMRmFv95dsCooRkegZjcrOsAItIgkrV+KuSV7c/v4AZM3zKWrHHmzttj6iYT5gjRcGv3bcFm/Zoo9Dj2udrfuQbwZP8Njgb0oyP8+KygYPTjvL9wDEyhY97o3/Cju2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366529; c=relaxed/simple;
	bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MYNh1f3iD8onsBGNP2ecNtL+0sOov1+PFfONA43lSBJWJm4Lncgn0wDpFln1xzVwq23gEc/mrClTA9HLX/9MhxXyDaUlJ5dEmaAdtq3q4BWDzc13UR6bGWqZlReLqO+xZgDnGjHoOoeS2v41rXhU4gLYD/3ZdmfWpdWxjSFZcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdFsJQGq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5uTqX031932
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=; b=gdFsJQGqYz55xKds
	CDh/O1YqTzzh99grZt3qs0FAgX+aiYMIEraOuCHZQjnO17+x7jTZy/NrywqSsJKf
	Me+JTyt44f55pAeqKbSAPMp2tbxpN4zGEfr93+ssRlBbVMI1KocloPE79HUnbjr+
	lGc9BXFiEo74tqRjj/5Y7hccztxSyg9wAPfS+bdEzqObvUTa3H6mZkHhEsC9Tyg8
	uj6agE1JbCskozaCOWBxtt67tsYv4SACJgjJ8X5LMCZc2TQRabJ3vHAkAJicfXIF
	/V9yAWuBF5lgKKOflKOxtl6djEk5C9FwGZYXjEXbseZ1oHZoS/s7ylEZHKKr8DSH
	ah+rtw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpyhxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-771e1451631so1430108b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 00:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366526; x=1756971326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=;
        b=RC/AoyLAidyLLIGPmpvnQoesQtHzxvBFZRmIfNS5lgnL9SyKRBxUT2q13TCYfeDwNs
         G92bROzt6smgE9uwVzX5xyL3FK0zaOdfwX1JWgIPKvSnTaagtxYtWWHn2eX8oIEmJn07
         GF2RUp8L8r7rNSa16u6wOLZp9fexFFyc+cUCfczREXiiHSPuAH3rZ4sEoWcrqVih/QlI
         jsDcH2CMh8lnonN2PrRLO37BXXWbBkO+If7eEB3RtME4jK/1M8AK7QRK4i/gRRPQ+gIN
         bTdrIVyIm0sj79AWdC2wQopKjZssZQuFEiAHr8KrY/oHNh9NRggTi2zCxr4W/L4XLlAa
         sY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhsJkeMpLeMn0cSAPFvE3M45GCTPoEr8zeeMPlXmvKTXHXE5CECpK4I5n4rFG02G47fXHGplUic9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHYa60ahMEH9VSiPARvZeilkcuhkrI6S5Lk/hx/17HmXAg1tc
	EIcVPBNpiDGBeNo/weqRndg2vRfYmfozsCYsiYFKH6pco38CJXXZfnoOAs5SLfaqTwQwNkBf1HI
	KAPAlaFtZLN7P5PYNQoTGQrEhkGijrDBco9RxsNlmy7i9VoGgBbjszrVRAibqezY=
X-Gm-Gg: ASbGncvTIN7jzKiNoELd/l5EiqFeoGEgVXU0vgVGZ2Nar9RcwG1oGC7+gHOD/b2ATJE
	KzUdcIg3BAruM0GFyUsPhVV/2Rd67g2X4yIw851PT+OYghzb4VB8E68fBliwyuPj+8X10MGvWSK
	6gRfD+U3G4eDfSFZUfn8mhfMZHfJhW+rpf1FVIp9vxrAn/Fop+6o/++6hEDCd+aPosFcIyH9RMU
	WYdNw8iw7FLyxtWtqTP3YcjQJ6Q1gyJsIghj348d8pIAYs13aNfyav4QvKjDCkr2BYQIZOcYRBc
	LOFKtSolygDJ0gPYUvbAPLcXLRDiMWodPKyLSYjg7S6Nz8+zkDtiA6zNzd4o/7Ndj8bV+wn7BZ4
	=
X-Received: by 2002:a05:6a21:99a5:b0:243:a05d:7aae with SMTP id adf61e73a8af0-243a05d865emr7069731637.43.1756366526211;
        Thu, 28 Aug 2025 00:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEoFuJglFABJuxVf4orjreJLtLa4Oys5F+mE17UzaMHIHMwekOoVe1507tRqq6Fvj9qvtHSw==
X-Received: by 2002:a05:6a21:99a5:b0:243:a05d:7aae with SMTP id adf61e73a8af0-243a05d865emr7069681637.43.1756366525677;
        Thu, 28 Aug 2025 00:35:25 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:25 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:04:24 +0530
Subject: [PATCH v8 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-ecam_v4-v8-3-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=1995;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
 b=oNV0PxO/r7YhMLERiBsCRDsXhtCB4hqyzujBvtZI4waA9lAZMe/RlJVDQFVqejVxU9MxfVrdZ
 t1pV5VoAoE7BTWts4EGqxE7hXlWO+5yOsh+8ziCrYnGV4mE6wHMf07x
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68b006bf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mQMofg9ppjh3Gm7am32mN_5pAfpQbtMP
X-Proofpoint-ORIG-GUID: mQMofg9ppjh3Gm7am32mN_5pAfpQbtMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6YQ9lnTruPcg
 3n77YuWnFMuKf7AkcKodc+KOQWdXX070H2cGNFB4C/Afe3AibQKNcCfEGMKrRa4IOdrhCJpvN8I
 jYIFDOg4a/uVD5cf5GWBcTRnfj7PVXAzhqoksYpXhUTy1KBhch6PAl25qPNKBkRYCSvOsm15fRj
 6cLpzGblRZkpavEqoofaGiQr6VOVzhlbaQz0Q2f+TtobESZbDJ7f2mVQgEmyxkl4EaRGoJX6+iH
 kHkIpZjROYKiJm6fVbHF21h1KyGEgmWwSNW3HoZvR97Xfh6KAZKvuCRsrvsoBdZpPd+/0OCMvP3
 usNYA6iFIr47IjX0ZQXLPVa3vNB4kRdNaYbxCGcP3uc7WSNIqhyPavamzE2vmRyxbflEnEEOxTR
 fpbDRUfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Instead of using qcom ELBI resources mapping let the DWC core map it
ELBI is DWC specific.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5092752de23866ef95036bb3f8fae9bb06e8ea1e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -276,7 +276,6 @@ struct qcom_pcie_port {
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
-	void __iomem *elbi;			/* DT elbi */
 	void __iomem *mhi;
 	union qcom_pcie_resources res;
 	struct phy *phy;
@@ -414,12 +413,17 @@ static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
 
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
 	u32 val;
 
+	if (!pci->elbi_base) {
+		dev_err(pci->dev, "ELBI is not present\n");
+		return;
+	}
 	/* enable link training */
-	val = readl(pcie->elbi + ELBI_SYS_CTRL);
+	val = readl(pci->elbi_base + ELBI_SYS_CTRL);
 	val |= ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + ELBI_SYS_CTRL);
+	writel(val, pci->elbi_base + ELBI_SYS_CTRL);
 }
 
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
@@ -1861,12 +1865,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pcie->elbi)) {
-		ret = PTR_ERR(pcie->elbi);
-		goto err_pm_runtime_put;
-	}
-
 	/* MHI region is optional */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
 	if (res) {

-- 
2.34.1



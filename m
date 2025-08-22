Return-Path: <linux-pci+bounces-34544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB6B31320
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9663FB6466F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700D2F2909;
	Fri, 22 Aug 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euDquhTu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C42F0693
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854886; cv=none; b=S3PgvykBuI+IobClxIn0SIYZPRRBI3oJ508hxqn112T9VPhQugtdSJxWitgC8VKdBootnbj85CM/nCzZt2sdIZiJuHDyukaDRsupMd0lURG1H0UFQJSg0qbL1gC4n0dJVH6YgjuQaFfczKj58lbGQ8EorFaX+xXG0hXl5yLo05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854886; c=relaxed/simple;
	bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFBj9zGAtv7SZLY5lMPQu/v/bPHfWAo069ZTE1erdAEO4RojJfA4Tvvc48WVzn4aS+zw/zZMY3ogzg/bN411rhSQPLXqDslzz7VrmKO3OSashVwivubjbaNvJ29p6C5WWTTBd5cTBlYaQfH5a4wVsGASIgHYVWDY1H1bl0C+FXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euDquhTu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UWLB005932
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=; b=euDquhTu/ucAegwr
	sRsjVVucPzpJLIpEPrKj5Cmra5+yQgiV3k2cEdEXD9mhMB68u2UWpsD2OyXCbm0f
	K0cZW7r7HPpybTLSUqq/5r8AFB/XqQnXXsBri3Ml1e63Me95hHnd6R7mI26v3enn
	bddoGtm4FUEJSKA/X9zYaoaUUIfKdXZOIWE8/NwySqdjlZTnWRwJYrd0Tza90ty0
	rqHGeK3SlN+SEC0qM2rIqk7Yi4FCl27WQVVsSGPFoTzeD7oTeyxnXpl2XeRCq8QQ
	Jh/A08EEPw/3cQslEEgsmq0cAqsaJi0cF24IuCge8bDo5sXEy3Fop+HscwxEyBH3
	fv68oA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52drkf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:28:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so3371730a12.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 02:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854882; x=1756459682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJK4jm7RiyIMS3SdVA3437OyfLU1Kx1wG7QYMtyssFY=;
        b=FD7G/pRTvSyKHUhejpjtvlitgnyuZ1dPTEpSYr3qwH8Y+mI7eCyi7oMR0s5+yxbf5Q
         44TgTiYxsu8zSLltGa/Fhd+tx3Rwm8Ax8n/crBakWM7eVLQcSttA6pXnEEKH6xAzZxkY
         bT/4nhD2i86pnOOHbNBRSbfpFbPqAHU+TE7oGrfXjgnOk/G84H+4w1b7bI1qpg+kJFoi
         eSHRZPrtuTWr33nZ6OAkHIUIznC9hMo5dqUMGhMJN7OL4P93vB2MU8X4SOdD4ggxwvSo
         vQyW4idPnv/ZZ2WcVNQPwumezHT2zBTGanSYEWWTTzvpNHSPioQnH66oDKhGWOjsxDQU
         rMFg==
X-Forwarded-Encrypted: i=1; AJvYcCWo+e67UML1l1nmRhJiXItElnkxv4Nnwj1E3Ii4PB1JWNWw5U7TN8Lv+Od7t/eNNx6Ew5daLepBjw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GrWgUKlbh7kkob+/dZHfTrakm7hkTEzVGsQaKF5hY6qwnGQi
	5ng4Iq4sBTDB1V5TcNoA407BSBUSOdOVMjkLe8mbYnxbI1UupjmEqCUqLGNJiUOYwt4Uxpd+2+t
	6krWZ6NuOe9K6HHWy/CPG0NHX2Q79gaqjHJqxpH+mIKtGRPhNqYK9lPu8lKr0cwM=
X-Gm-Gg: ASbGncsiRYRmgda0JPJEFwpvcIJvd7o8aeaI+rD0PkVacbosaX3LOSpeHM/upUza8JM
	iE6wWW0ttbtOxJMc8IoHbiGBc9imwkHsBGtkeuH/7x30fPh0Tk8ja4bb+lXuQXv47K45YP7tk3S
	37AeghfhJrTb2J5hFlD1q7vOSCsn4Zfa/1uZGlpQzN0lz8DQZ3LF8TJs2mHkOvn/y1g65EYk6JT
	WauqnJPPan9vSKJopCW5dR07eSMGYiAytFxvBN+gt1R6u0bMnAdByPUexD/3+R2jTbBJsAGEC/S
	FJP/MZ30quXAoW/k+n/UpUGqJnfgk9FkguyzhLCGO0swCctpNjZDelqe/eUPzncJymOOJON96Fc
	=
X-Received: by 2002:a05:6a20:3d87:b0:243:25b0:2324 with SMTP id adf61e73a8af0-24340e6c885mr3572769637.50.1755854882143;
        Fri, 22 Aug 2025 02:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErgeNlZZ3m9zZEU4DFuk4AWE8QrCvzoihF9b2xvmNf1xFNoCh3S8xIrxIN7DbWrNSGU4njQQ==
X-Received: by 2002:a05:6a20:3d87:b0:243:25b0:2324 with SMTP id adf61e73a8af0-24340e6c885mr3572721637.50.1755854881669;
        Fri, 22 Aug 2025 02:28:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32525205d1csm549417a91.4.2025.08.22.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:28:01 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:57:31 +0530
Subject: [PATCH v7 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ecam_v4-v7-3-098fb4ca77c1@oss.qualcomm.com>
References: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
In-Reply-To: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854858; l=1995;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=KBp6nSRvIcRzTpSQhn0xmjkXEw3wCkCaBQEeNdgizT0=;
 b=FxAcYjubv2407Ih8C9wrp9VHcvr+HHvpAVCt3J0qt5lQ+3kXOTeXaZHvFSccVZCwsgGp0S/YA
 VKNYdLGH3MtCpsND0xyAgf0RvbF72ImpVk1pjGGfo4rgRjrugdLCbRS
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxK4jJvwo+pqs
 Q7Oc2aSE71c5at2mo15lEia7SpET6btTXdVnR5296nrmUEWDHiZXNe7MCB88cv1wiZrSa1NpAb3
 zHXBGtbwBITtClJ0wfShMAvU2WzPCevPjMQh2tqBVY/i7v7x6XbP79/biFc1tHCL6Fwo6U6R+W9
 mwiZDHIQmpkIqPxSH63uOqWp/XuFWx5s5/KXjsxv8ACqGRBMjlyM28SCD3i7183q6aZWiTJEKdl
 XFBPQ4Ue/wvKgcBZ7kmgZXlchxvqOInP0nPJC6Ypc8X8km5QTMsSnbIyYX27smS/c+atdcmRQ8T
 cHdBzH2jhy2HAAYxzci1EKKHKdiQujH34+lD89epl721Kf1F92bia779PXetfQoifUfosnYS9Km
 DAknezzQ6+/WTrfmkbU4CTyyQOEAGw==
X-Proofpoint-ORIG-GUID: 9ynisQv2yPKiKAXmd70AurRjN1tEtwdI
X-Proofpoint-GUID: 9ynisQv2yPKiKAXmd70AurRjN1tEtwdI
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a83823 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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



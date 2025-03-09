Return-Path: <linux-pci+bounces-23203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2CA580C7
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 06:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7403518907E9
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FD13EFE3;
	Sun,  9 Mar 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBwFGUOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949C33F9
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499186; cv=none; b=Av6Hwh53Izlkb/TWJPivSFMYl8/jck5XbThFP7mrUasP6Vy0kLamy0kIqajIMeHiYBFXLnPAAo2PfURuqdhYNlki+ix3C/ZdGYI6WEP0UlkNoSFfxNkUL6bp4U9R4Jy8Z/wxDLaxPpTVoLONrZqQV4+v79H0oKuQM/cepKyW5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499186; c=relaxed/simple;
	bh=yzvYS+vDkvHU/sbyPg2yR5foiv1dbD+/nutD89aVNFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDXM/TloSyO5i5Nco1s+a+zWuSOFm7m8ZWM6LJH3cdQCoM9rfmtoxvz7lBB79p96jbbp95EJ+GD6BMtjOE74970L5UqJ1D92JHFh7It7tuKmDp1KB+tpKDN1TfSLt7CEncO7uKUAPo68M7emH/OP264NyJGjgdKHpe4Xis0Hu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBwFGUOD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5292IQZp007799
	for <linux-pci@vger.kernel.org>; Sun, 9 Mar 2025 05:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xd5/NY/AbI/ojxPiTnWZDegzzMxF2ObPIkWgoHjce9E=; b=RBwFGUODwevnW+uu
	Rho/gnIs/l+x2KSBcECGgreHHLXiBd51X9KyswSeE8Y9kfZ7jVguE5cCVUxEhWZc
	h4FtQ/ir/zAoc7Ec8fC683uh0eOKtCrtlkYyP01mNAF8c6ZKue0tMoOS/pA800UX
	FrF9BuENDn0OWfilECnVVbCjyqTxGlCbrti8efhP3hAla4fJd8z3ILAGgizmmjV2
	nyLi2kJXADbGvc4iD8V0TxYcoaIbxzb2zH6tag/Grs0Zc4Il9akjF23E4ZfWzzIb
	C0kpRBWhngdn2uDzMAVqRSReB0a4VCE+TBrQGVG4C7QGbMe8LJo6+3Gtpy5meirc
	RaZ4JQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0w1pc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 09 Mar 2025 05:46:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240c997059so74590765ad.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 21:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499183; x=1742103983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xd5/NY/AbI/ojxPiTnWZDegzzMxF2ObPIkWgoHjce9E=;
        b=HmBehGxtEssaKqHq2+fSLNEmURGHhpJv8gOINW7kzU2GdeFvmeAy/714gclgHPAxKT
         eVpbMVnf74XM+M2nLWaNgmlslcCzFw4iXuak83lh9H3PDxtaC1cnJPyt8BFq49LOlBwf
         LSZSuI+d39rVjOO3gkijxikh9ny0ueZ0LR/jAGXMNT2UyuU/XLC4moTxEDxvRiTDTMYI
         G+axLkfq1D40JXnr9nU4DBks9f5SVCe9FFKqnX96VhAEI2twDif1kPgySyV/XXB/flBl
         KHXrjNcW+J3+wPVG76bQK7IzZwwnYtA8qzcCiuMqlDQc7sHTziNCmE1nEIG9/Vo1Ckxn
         EhAA==
X-Forwarded-Encrypted: i=1; AJvYcCVyHRa7DcTsM8pynGtFKu2A9I/3O4aRPnxT1V44kCPfqwrtBb+XR1EoxZt1bFxlgAsoklfx4kzenJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfJFCM1PRuTPawQCv3KlHxL3kx9zI50xsh318lPLV7RNuPELy
	LZzdLQtEJh7I52pvsyBEEnP19coj/9vpv8nsZoYnNKE0qk5Sh6t/oQCg32TikanJnh6WJ8k1wE7
	XjClreRgKzXV1JYBf2hrBSvL5oVDcsemdPGJgKCT65Axe66BAakbbCOQjvng=
X-Gm-Gg: ASbGncu299obI5qW4ip/ZcLFHW19JUCTCGJX2WRKzLWKGCHoYKmQWK9krjX31vAmEf/
	04Cl/8yyfglruzvpih3QL/bYPOHQZRwYBZRcSRIrWpI2ksZm31sScOdFDk/QOlDhxW8kCGZ+Qnz
	B6cXblkzUzIyLzZ/ZhvYt+tPeqFJjphO+pBa5/KnmvdiZJelc4PWsWpWRJPEgkfIp5Jjq7VMrpp
	iZF3jhvJSTIekK5wC0AEfqjubf5+FTJnKnSpqqnB4ZQ4d78lXgKol04FUPkD7reBqW6omfjigee
	6IRLBRuBQkY6TnFchRRFeZ0KrvT7/LK63tn6zrI72Ef6puIbEU0=
X-Received: by 2002:a17:902:e80a:b0:224:1074:63a0 with SMTP id d9443c01a7336-22428ab7313mr144081775ad.34.1741499183135;
        Sat, 08 Mar 2025 21:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8jQ41ewm8mRMToOvvbPTBKa6DdkpK8KF4isFprAHrCTfOwjmsi4gJjMmDCobS1C6QBUqZ8w==
X-Received: by 2002:a17:902:e80a:b0:224:1074:63a0 with SMTP id d9443c01a7336-22428ab7313mr144081455ad.34.1741499182676;
        Sat, 08 Mar 2025 21:46:22 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:22 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 09 Mar 2025 11:15:25 +0530
Subject: [PATCH v5 3/7] arch: arm64: qcom: sc7280: Remove optional elbi
 register
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ecam_v4-v5-3-8eff4b59790d@oss.qualcomm.com>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
In-Reply-To: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=1000;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yzvYS+vDkvHU/sbyPg2yR5foiv1dbD+/nutD89aVNFA=;
 b=8Jt0eDX2uQWxV+tx6Vb6Uv/IKPa3yVlq2Br+SVVptGCggq25ML51gwaCZysbJxBqI6kKh9z6v
 jaSwx0UM+oNC/wgb374BOelNO2/DLenm+S+c2em+fVjMbatR84eyUZU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 4Ia43WK9ehsNPxXWa0axnLQik1yxGdKp
X-Proofpoint-GUID: 4Ia43WK9ehsNPxXWa0axnLQik1yxGdKp
X-Authority-Analysis: v=2.4 cv=MICamNZl c=1 sm=1 tr=0 ts=67cd2b30 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=bu6UjZ7a5GH_BZZocUYA:9 a=QEXdDO2ut3YA:10
 a=DLZpj_5H-hTUFZwOGiJR:22 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=747 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

ELBI registers are optional registers which are not used by this
platform. So removing the elbi registers from PCIe node.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64c46221d8bf..e556285d6b75 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2202,11 +2202,10 @@ pcie1: pcie@1c08000 {
 			compatible = "qcom,pcie-sc7280";
 			reg = <0 0x01c08000 0 0x3000>,
 			      <4 0x00000000 0 0xf1d>,
-			      <4 0x00000f20 0 0xa8>,
 			      <4 0x10000000 0 0x1000>,
 			      <4 0x00000000 0 0x10000000>;
 
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "dbi", "atu", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;

-- 
2.34.1



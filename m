Return-Path: <linux-pci+bounces-20330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126F8A1B4AB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E1E16B4E2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38E21B18C;
	Fri, 24 Jan 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="On3/Jag2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F57F21ADA2
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717792; cv=none; b=Zt/D8hfHsJ2H4sbWLUa6YihxvZkbXDuut0xYfgeQaKST3r+dddwhBpOKP4lWOTP7ZSQgbpkTGHCHK9rcL9bP+OErc5zJ/PIBWz+HhSe6+FfQ1pysrmCPlG7FWfUbpvXiTcyfyVNKJzAtYSAQ3qSG9irJqWNA84ItQhWyfLf0Egw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717792; c=relaxed/simple;
	bh=1cCWyVa5AK2/6g1dA5pRl5YsQKIo2vs/YZuAmrzjF+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehoUiwgBOVWA8ssxP5RELsVTQURZyVKEZpIMT+HvVDBUnJrSkR8GRjUFkbTy2MmKXACgw/hwl4mZqWCkEe7AyUq19ACSRrMUcnVWfPLMb1OhqtoECWy9IlEqurMpBXdyaTDwV3O6YzZxNxprKvY7SQeyQBtL8VKQlc8dRSX6Fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=On3/Jag2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OAoU4q025504
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r3fyHfyMlBiD4pkCqczBKmlgoz+Ny2UI/7GNprFqSSU=; b=On3/Jag2cLhSaqMy
	tCFOKub8I2bQ1uB37dtEsbiCox22aIxINxnSwwnmEJW7Zs64uvW1b9yfP7vCDeoR
	dhefG0720a/IuXkFjqHbflzDuLhx5Y/KBdbPzE+iIcmjPTffWFWmrHNpFV7++L0d
	uSaO5JOTdfbahldA/9yccU4SeE576331ZiiUKMh785Bthm02WXH4qA9sSKfdJ3WR
	Y/W/vRzk6s4CxSin4rjQ+/m6W6jfbF1hHWd30E+5goptIUL03nFOuBMHvZ+EM0dq
	yw+i/crA4jN5/4C/vbtKQUGLISmRc8RRYH/A7DqBr5/IgchFrkYZb0qHE4/GJmtd
	O55jTg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c9fd03mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166f9f52fbso59967695ad.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 03:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717787; x=1738322587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3fyHfyMlBiD4pkCqczBKmlgoz+Ny2UI/7GNprFqSSU=;
        b=qmEaNa990j1Hqu1c0UpksRrk8dc7gBj3SboY4O5HXDraId20T8Rq6ZPRqeXUeu2A4X
         /29v+wYmpUFZYPzvaZwzqSBd0/AF9O8CFZsWtUAJa+GutyNDOwF0Kh4ImqfAV3/Npg1D
         01uyneVzepZlu8ACP6sx+cHL+Z5FVnB5/Fc9E6fZChNW0HjW4/Q8MYF+5ePiiP9jKld+
         e4QNYCbBbDKrtESMY8arhun+r09V0rA9LWuzD3QeYDUYzvCbMDwkNBjkO+NVGpG/ZiGN
         eK3fYKYfTM+NDdsro+RN7faIeU+0xu29dTUaQWReFjNIgLswBM/m7jZq2b1rDzxiNQtw
         1vFA==
X-Forwarded-Encrypted: i=1; AJvYcCWJP52SJZcpLmRg31ANRAT4AsaOTwVbwVWXgIsZ0OTdJUk3yIdjv8M4etqY8D9uVpTxsoNiXxFiNdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYmy7jSl9S0/VPTEMdPnVkY0jDv/IeUjlqP45rTJuCZycQUbl
	qaUmnexKs6aWZi0LRPdI7094MDL1wbKr8CSlt+IsdNklpSvekpxLhUtf2Z7M73PU0q3w4A9EyGq
	I14WIoV2tf464XQSMsxnG39QevvJUlEw3FVvDmnkAG0vM1ELzFATkxH53Dpo=
X-Gm-Gg: ASbGncu4Yc8V1Xx4mEH5yIo7qFKBYvPR/f0QqJHiTQMYcRUEbJxkcOyYGJRkc5c2k9a
	jBmHoFnu4/l8nQ7E0Ve+CGD1iwDMjpcKhH8WphBevLGBRZBhkU9WTc1SH4eDm4O2oeMf8QNhXt6
	82qA0sU5JjO5/9GzY8XOyosBCllU8LbW0Xc88EdIl6bzxYOIOq7wnABEtKUssRUEKdMIAd8XSIu
	wE3zAZEtOyKQBo/kgTaiN2GFDORlF4RjP+f00D2q05z7nlkEyy+KK1v4fUz1zYFzh8zKhYH2QOt
	11D9G72oku4N/huHfMJ7vJjbblcA/g==
X-Received: by 2002:a17:902:e544:b0:21a:87d1:168a with SMTP id d9443c01a7336-21c3563c6e6mr493276915ad.41.1737717787502;
        Fri, 24 Jan 2025 03:23:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy2tDIcgxd5++o9SOPR2tYwiD2dziflaSrZA/gwxFQXN3UBI1mtwMZRzdExbNkM+eWLzrPqw==
X-Received: by 2002:a17:902:e544:b0:21a:87d1:168a with SMTP id d9443c01a7336-21c3563c6e6mr493276635ad.41.1737717787163;
        Fri, 24 Jan 2025 03:23:07 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cc20sm14025385ad.165.2025.01.24.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:23:06 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 16:52:47 +0530
Subject: [PATCH v4 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-preset_v2-v4-1-0b512cad08e1@oss.qualcomm.com>
References: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
In-Reply-To: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737717776; l=1380;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=1cCWyVa5AK2/6g1dA5pRl5YsQKIo2vs/YZuAmrzjF+g=;
 b=O3T80ZKL0sUlxwGUvDzRVdMKESDBubPScoivfbYlONH8VRavEh0VwCnLXbPceheS0NYL3m5N4
 iwVCUDvQjQfA5Jkf9dzx6putbgPDoxEbIiDQADqY0XC42Cc5Dh7zv04
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: v813-WwUpBGILPg7WVRg1H9C7ZICYH7S
X-Proofpoint-GUID: v813-WwUpBGILPg7WVRg1H9C7ZICYH7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=934
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240083

Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
rates used in lane equalization procedure.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
This patch depends on the this dt binding pull request which got recently
merged: https://github.com/devicetree-org/dt-schema/pull/146
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a36076e3c56b..6a2074297030 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2993,6 +2993,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie6a_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
+			eq-presets-16gts = /bits/ 8 <0x55 0x55>;
+
 			status = "disabled";
 		};
 
@@ -3115,6 +3119,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie5_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
 			status = "disabled";
 		};
 
@@ -3235,6 +3241,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&pcie4_phy>;
 			phy-names = "pciephy";
 
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
+
 			status = "disabled";
 
 			pcie4_port0: pcie@0 {

-- 
2.34.1



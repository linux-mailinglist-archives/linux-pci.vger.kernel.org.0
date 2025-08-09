Return-Path: <linux-pci+bounces-33660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B822BB1F3EC
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDAC1891BEE
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36625D540;
	Sat,  9 Aug 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puKuQImG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80325BF1B
	for <linux-pci@vger.kernel.org>; Sat,  9 Aug 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733590; cv=none; b=OCT2CcfoRClPuB7ANmU+qavq8+s8omNe5vSirlLFpZ+4SUELaTfMMDC/v25wnXfokjhgCzZRGjs3CI56L+0R9BxvwR8UOHENbuP5CGqVQjk8WzrgUrjfmFsXTGRty/B8qnpoYOgKdbM6amWvmVAcHpj2UL8X0yJ3w6pS5mn262E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733590; c=relaxed/simple;
	bh=R4uNQJTJ6TZ6UIRq4jvXRMv3opNeQTLyTEdp1tmrcFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqA0Xb8/Mi0h9wa9fhx6YsJiK+lKI9Bs94x9aRqwStLU53Ng8an0/52YRfXH6iBc1+adnvFexk7cTjPebwc73wlw6emNOZAeIZs+cSSy+R/9/2D0N3x38/J9QIOCRX6AQLJpjY1bSqkcYm8ZdLeG6DZWC3LLoc3aAbf+2nXa6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puKuQImG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5798pJSB001388
	for <linux-pci@vger.kernel.org>; Sat, 9 Aug 2025 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBQ0e2SAV0/ngnuxIOs6ha4YTv6YdCMqfkqSUm1Uz4E=; b=puKuQImGkrw2xjYE
	KdY49eiqRNdnHwyRNr1zflmaFztoalO3ECQJMLsUzqks5MfKDWKlP6rYoX4TyS31
	rQ4Qh//C7FJ40AUzZty7lFrsw2Hgk4Am4WEe2jH3Bob/SO1huYT3D7i+GI2uc1oI
	q0HJqWhG9KEbaMyJvPpZ9dygy0aPx4SgTFPmhPVCnmWaEp6nWDSHei1PaFdTktev
	K609WAo1EHyj44tednHlNw3fJqFYkEPRvdeyCKyiGt6OdELbk7romPqTBeVZMVJ6
	LxbtO3AQQwjNp4chKo+en1ZeXmW6DVWnFn3vwFYSPcDvodM01f3aP8cUUaS9SNCS
	hJBVvg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dym9gbrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 09:59:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fed1492f6so44835735ad.2
        for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 02:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733587; x=1755338387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBQ0e2SAV0/ngnuxIOs6ha4YTv6YdCMqfkqSUm1Uz4E=;
        b=pchxKai8VC76eHsr/+4cEfKpCUwal31vTyq51tsy/hIoYMvywgIRE0rPSh8NP93jxl
         JUvjkDvptR68CimoGfbmLe65+P75VjqXN9vnkztoG5X20GlMSb7oqT0dP4CYV98MYMFd
         YP2F2+a5hVdvPLOVDCiXFedP1i4rtXOs25eg5pDNC7ydaWWJWz+chajy2/RY1QM6EkyJ
         irLdEDDxYV+uSvFvcREKfSPnIV9CEXVOtpOSL/JH0mnUcHHjSBVxiIRV2HCc+bIpHosh
         hErbxRimn6OY1cg1ermypr3ucA5OTy7WkeJcAF1EuoQyNxuheT/djyu3coqNE2iymNUO
         753A==
X-Forwarded-Encrypted: i=1; AJvYcCVEC2zwJvskIau2BX7wboZi9iUzE+dIr6D24IwhwbwamExvIEmFwRYWT3ilvr+PWzrO6naslEqxvbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWFmoLcauGxo4UxeuV+f+gV0g4l5T+sTWsKPHZkoTrRzcAJXx
	lWaBoQxya+trtTSxLypX14RNhEWXi6ldPKZvT45zZBDQGPbsmzd4K2fCFt48XWY+ZB/lG5Q6IT8
	OiJpKFVEQXiG9SIepECdnSkeBNT5T/jZceeUyBkjAdnIUzxoG634y1+gpbLx69UY=
X-Gm-Gg: ASbGncstKGsPYBhbrMY7SjiY7qMzAkY2C11047agg5aHwhOHiac4KyBZvSMlfWSTvQc
	wLSGBluOZZl8dTC390/sNvgovbWenXRZCD8HhEUd89r3DS7G00ujwDweigxLybVZsxXHe99sEG4
	HxIDQYqmIgQRLxNhWwrYs290yRDzNpBOb0CAOc+46EgwVFEPNjpnq8dSauhTiI3Pj3tuEQ6kulK
	Yhlz6eWNFxIobH2KjhDU/GHjuOdE3DC41t1pn1Z3NmR8XTTSpIA5qx/nNFs9Tb1ihb6yPyAhs3a
	muOODW+eh6XRrn9vANFSqHXc+dqSeaEq9FHKj1uc/WLzKfP24lC0+YgXS6sScXkmN6cka+drnZI
	=
X-Received: by 2002:a17:902:d2c9:b0:240:1953:f9a with SMTP id d9443c01a7336-242c20703d5mr104333385ad.2.1754733587524;
        Sat, 09 Aug 2025 02:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4c/wiGzwRmWvFnGhbo7cmBsz+6nWkl5TgRx8Q2bsS4E4Vq6y5oGW9hWnJRcnT/BPcwMFLTw==
X-Received: by 2002:a17:902:d2c9:b0:240:1953:f9a with SMTP id d9443c01a7336-242c20703d5mr104333145ad.2.1754733587106;
        Sat, 09 Aug 2025 02:59:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm225962845ad.133.2025.08.09.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:59:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 15:29:16 +0530
Subject: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document
 the SM8750 QMP PCIe PHY Gen3 x2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-pakala-v1-1-abf1c416dbaa@oss.qualcomm.com>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
In-Reply-To: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754733575; l=1281;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=R4uNQJTJ6TZ6UIRq4jvXRMv3opNeQTLyTEdp1tmrcFg=;
 b=Pn44e4XwnwfvY73BZod/cOU+TNd9XbdK5DnaUkh10yJmXKf+BBVokgllhEO5swZK6AJvGflcQ
 3E3Jgc+ZT5JBvWhJhQOkMM5Ib7UJOT30HMRDM4dxwY/tg3q7YF12YGJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 43AIaVgi9D-tY-hm-QNVRKTyKLa_aCHO
X-Proofpoint-ORIG-GUID: 43AIaVgi9D-tY-hm-QNVRKTyKLa_aCHO
X-Authority-Analysis: v=2.4 cv=YZ+95xRf c=1 sm=1 tr=0 ts=68971c14 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=AUvBg9Asf6StguVY0UIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNiBTYWx0ZWRfX/Mra+W3mNRgu
 zD+EXqyncjQPXI/oItWlK7KlGQgAQRgfFMiS6qRmOs3qqqqhZ5SavgTk8zHnzyaxZV5iA9CBKtz
 qBFj/H6NIcqRbgEStqomHB4sePtcOonsqycAKyxvj8cS46m1bvEFNPfT7yWwovYcanT7U00uyVF
 J6g7sH1rODPuDiYO8q02pCqOcNduoSptUIMhfrkh7I2PIETYPQpGy+dofbeTYD16UaWhNHrn0Jy
 /D/kVbyw4P1e7EB+kvodhx9pahBjK7F0GycZefZ0tLDOIlna4o653vTFP4/NCZgMSAKrD5b4zvT
 ITg9HGqWvt/S4nzlTUrF3KbtiEMo4Q4iBSsRiudTeKqaB5Vk0gN9+CMAHJV6i2qr0NmIWpODc2j
 l+vXQ7fU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090036

Document the QMP PCIe PHY on the SM8750 platform.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index a1ae8c7988c891a11f6872e58d25e9d04abb41ce..cb706cf8219d015cc21c1c7ea1cae49b4bf0319f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -42,6 +42,7 @@ properties:
       - qcom,sm8550-qmp-gen4x2-pcie-phy
       - qcom,sm8650-qmp-gen3x2-pcie-phy
       - qcom,sm8650-qmp-gen4x2-pcie-phy
+      - qcom,sm8750-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x4-pcie-phy
@@ -164,6 +165,7 @@ allOf:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen3x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
+              - qcom,sm8750-qmp-gen3x2-pcie-phy
     then:
       properties:
         clocks:

-- 
2.34.1



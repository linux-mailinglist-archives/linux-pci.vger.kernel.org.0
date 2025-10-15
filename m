Return-Path: <linux-pci+bounces-38195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8922BDDFCA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B16E19C20E2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101231D728;
	Wed, 15 Oct 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PiiM9jbA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289331D367
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524071; cv=none; b=XSBqWBnFw3+gb+h3FOqeezLL/DYTFfFlgj5Zp0x1JIZ+n0XPG86BlI+0x/rtCPc4flcHd2CSg+7W/BbcZWrLyvpBy7JaSWXK2RPEWQ7VS0Na8fmSceQMSWD9j17seTHEL7080VpMaxLhvZsVKiBRbOuoYFgmgbR6196RH9l0pUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524071; c=relaxed/simple;
	bh=VPVFV+qu0aJDwF/BGABycXVuxxH/BpzJrdbWSDyC0FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNXBcEB5QgVX80IePylslaLKYRdV4qS9P2P8gd/OjZUgokPHtzAQPQxP2PZwSJmj49k87qTBb1kJWyMrvvLAksGbnkek9zQi36mP/lM7cxSK0Dk0eFbmIljuE0H372fm0q/8qW7mj7mt4d8BtfrhfQVLZqY/qNNY4aNWw6kZF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PiiM9jbA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s9kV009128
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XzlpRyA3eGYUHs3zByL6o8kdScATL/4OhlJTdAgnfN0=; b=PiiM9jbA9KBX2e1z
	pQjb5fyBUQm7mFH2ofRTViRGCvHOln4y6S0ZP5LvF4fGfR7RNgjCH8KAGRP/xLAb
	IauAvx4Bl8PPwTUSBQ66igrFNFDD9t0/ebzt2H9rHXduYcGxCNEcvyVcmm9mvETZ
	awssP2WVKoVPW4RVk1xUggVRgjsm63/TcbACBaSPJgELzwQzASRBksbxspAjtZkh
	g9QXyNCECfGEW32iqcq4fUjOyIqhnEdjIwm2Ml9vBym3OThUjB+5YlgXqK762NlI
	KQJ58pScXOI37AESBNd217/TV7gqyj0WXyQV87eyOWZ368FZB719hKimMn/EuGnd
	a0Ud5w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c404e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so16795061a91.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 03:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524067; x=1761128867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzlpRyA3eGYUHs3zByL6o8kdScATL/4OhlJTdAgnfN0=;
        b=KVN4NY1GvxzLTx0aJJ4JOQZGg4z9/xjCg6iCTd5+nTK/jC7Qoty8zp5o2r/SHJpfgL
         QFB+ySrF2HEdhVVcVjRvWZKzA3fjWxqNW8ai4jOlPfFh9otcY5R5rnuUuU/YJaNrJbWR
         ++SBNzf18/7kvBhCAFGRiPukPhkvRhliYuOH8MOYjZyEt1GDnVWuwntm4Qsb/omsnpvQ
         5scAh1sMETq97L53Qlu9HuRreZG7XOGau1vcLByvnu0b5loSON6+hbAS8R1QUdaEM2LH
         BpT2LvKPTa7mR1Jc1k672AV7MbVup0UP1B+WXi/MARYYO0AoM5a5IpFHXpcemhhhKQpa
         p/YA==
X-Forwarded-Encrypted: i=1; AJvYcCWtYN1a2ERdhw+CThKVqpuQVawbTJjZd91UZ8Tj4rwEEy0lRSJ+UNXWtybhb0cQb1qCwvnYqtH5yyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4SkCLAnNOplLxM+/Gg20tDSS66CQ0b+J/fZOjP7eIKjCyYVs
	aL3wM3p9QKpSyJuhTXgKBhwm76SZ8ybqygEj9G899Lhds4mGXLnJqazeeQYkOXLQQlivEmOePhI
	m2qd72KOOhB9JJdNVKC9cQJLIGw3int76zTOpuc7ds93/IHTJJD9rjM2Krbsim5Q=
X-Gm-Gg: ASbGnctSN03rZs5OGrCO0iLzH1M24f3nAu3r40N3xHeLW55dsp9pBX4SVmo+hpEBzVJ
	FI9kRJWtHR83Wa27APkSDTwcBY67Xuo5Y17KUscXpkn3Tks1fGFUtsK9ixaZ4gAoLCUaqLnbJSJ
	aQPO9t7fsDCalwZiX3NfD9OGFTjsapw2gK0NrvDnxi81AItm54RNHnThaIjI6rQdaIRp2G1yCEw
	5IGqtfxo0ezVUY0zDNFVHC7S6pjDRE+C5Lr1o0i5+KJIqn6BP1d+FNq3/rs5pTwZhMs2d1eBoTY
	ATGpjQjf7K1cAvRTg9lCV0Ek1wBfF4FxzQssvuKSFyRUrb+kkno1SuSjvwahFE5Jv5bICBu9jf1
	fXjdUHzXM6FM=
X-Received: by 2002:a17:90b:388e:b0:33b:6c1f:4d25 with SMTP id 98e67ed59e1d1-33b6c1f5256mr22073730a91.16.1760524067597;
        Wed, 15 Oct 2025 03:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+D1rBOUBrT97sPb6p/Z4zWKTgshtRDcFAgDXfnHqIFIHXjIFB0HEIzDtAHWj2QuWYcTW2ag==
X-Received: by 2002:a17:90b:388e:b0:33b:6c1f:4d25 with SMTP id 98e67ed59e1d1-33b6c1f5256mr22073663a91.16.1760524067015;
        Wed, 15 Oct 2025 03:27:47 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787a1a7sm1993574a91.18.2025.10.15.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:27:46 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 03:27:32 -0700
Subject: [PATCH v2 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Kaanapali compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-kaanapali-pcie-upstream-v2-2-84fa7ea638a1@oss.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760524063; l=1557;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=VPVFV+qu0aJDwF/BGABycXVuxxH/BpzJrdbWSDyC0FI=;
 b=Otezu43DwHlgJ/x1TVecF/6XNvXp8kqdlVGHqsZ5IEoyYH56lqF5M21nlBT3cDfjJrHraJ3M7
 1VHEDq74JZNASXBjQZORo5giYEtOD9vEXrQ0ob9Q7miQN5VioCl4BO2
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: gUzLX5cKibQBT9JDUUtyQyDG1KPnhmLX
X-Proofpoint-ORIG-GUID: gUzLX5cKibQBT9JDUUtyQyDG1KPnhmLX
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef7724 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=A6CI9_SKnrlR1hncxxMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX/kAkk7/toZLm
 Tli8M6E5LAnhDco4q031fUu++isKmTq2Mt+K7IVZcaaCOh7uooLfRfTeS5ynLMYpFT50VE5A7LE
 +F1PEs6MM8i1K/2XN5wpHyInmUtKTECTZZMui1qAiwDrS0atFH8ggTFpN0eEH3X3IcnHIl/8Jgv
 amYZA6bJQq7ln0LtAzrZsV3QM1m03H2JnapA6EVvgowGhAc0Z9LM6Gs4Mme/ia/WJ4WzqEcwZXN
 BEeHk/CJ2G7/4XLi2l9e/XR7iVR+bCWJi7cghgJYBk9JXm7NVhGAHCRJN5xlC4PhXTprluGuEMq
 tDJ2Ynq/QAn62xZw/ojv6tkiBw5xcegYq1nHqjpuE023hladwFQRHcQKbBsGUYPoKm1d0I/vYPy
 ZjGHWlOnzI7Hf7OsiVh52jNIkKeRgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Document compatible for the QMP PCIe PHY on Kaanapali platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd66fe59d91c377449d27d2f69e080..9f7a276a84ad1e4ec0101c4cedc25230f509fa82 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,kaanapali-qmp-gen3x2-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -146,6 +147,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-qmp-gen3x2-pcie-phy
               - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sar2130p-qmp-gen3x2-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-qmp-gen3x2-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1



Return-Path: <linux-pci+bounces-38543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E95BEC398
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 03:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888B14E2E4F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790E1E5018;
	Sat, 18 Oct 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZFkYHsT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EA1D130E
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751227; cv=none; b=joHhN/u8GzzKU0skiiFTjFWv9X3s5EC89qJexb1kvJff8DqzgJXnTNNf8v7PDUu6Dd1zeMLIDvM34Ivb7xqXY2UXagjVBP2eCrd9o1BI/eMUi6WwoEcm+vV8HrH9DwKWTrGMMOJGr0w2CTi7lv7OFOAfBlV/+HZoYrmBedn2r1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751227; c=relaxed/simple;
	bh=buXpzzB6V8sEDjGSLlS3HLSwcvy9LS6XrxQaYUlSJAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqBUvHJ2ZomZ9miLkrm9/IUjc3bVqq+PpiNtpALhgZjf9w1GWuvM6VZjVPoNot0AsXJPr30uY98HPW15RFXwWbqu6KFRf79RtLd/Fk4v09Tccnzzj8D07WATOdWdE2xAZnYJO8FdAehusR8vaTaaDsjD/wdOEjWCFuQqpmZs+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZFkYHsT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGH8g016392
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nyHt6+e//Wm27OxUhgiz4v3Hh8EOKz906PnWuB/Ipos=; b=WZFkYHsT1Yal2fvx
	D1iFhNbGt0819LtqmCDw2K0E/LG0hlK/4iL/pDtyOLcd+3gGNN0V0XOQ/DvuM3fD
	AMmV4m8kd3PJwmma8iVl/b9bWPiOk3Czxf6q+y/LDrZj+l6CbruIkR4gCgQt21le
	ecTpR4CGjc6ga2x49j40NR9eRyCOJWQEUJ9b2XLqe7oSneE2Gw4atkm0SzrODhkA
	82Dpl7BBtSKOyD1nRRBz4S2i6rLaJrsLisrECY3q5ubTQaHxvydolPkKVp9gsYx+
	oTGsvUfvKjex4s+iRBC+/tzSPPNhCEeJG6uBO2OR3Qhknajy5fXSqPBkDIYudodn
	FDleeA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49uqun9kae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so2081854a91.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751225; x=1761356025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyHt6+e//Wm27OxUhgiz4v3Hh8EOKz906PnWuB/Ipos=;
        b=V68nj7bGCtWeSQ09QMT/eYvvdaaJo9Ba4CeD821/1vFWLxmLMDhVnqtrTUqWmIc/JX
         E9F6RCwnXAL0hbcBLAJxzh42Tc8ROSsfg4WyHAnQQpyIixoDwpS1j01XT0/waJ7ekgw3
         BFJ6Py026gtkxAi0PXBq9zLd3/x84nsg8/jP7fZgwuonpY8ckFeUFHw9vePh6ANNjv3c
         pLLVVK+Rx5T0DWk/1lYLeDpqd/UR3CUtidn3WCzKkiiRz1jg6QGOWaMiVpmWO/119vUG
         6M6rVF15rNcgWMwyfdN4riuUxWsHX/irfgmHaTFnOHb1zmWk8pkkJh+o13gvnfzM9hru
         xg7w==
X-Forwarded-Encrypted: i=1; AJvYcCWbTWmVjwQ6/gDUC5dFg2dpEzeofnTJApE1VbmWqj1reFVRe5T5zFVsSv4DrNwfOQonKxDFX44GXDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsApmnE3TNRkKE7v1alqjg9eCNv9C5QhSN8cR11B5KoUgecMt
	Z9IPrA2aZFFHcqhcA46vvzBeqwvhc6qLOUBh2k78fPdkpugp2HCndCbiEdkrzIh6svIaYy81z1W
	/nJANxx2SwIrjvwDoO3vFpGe33Co2Z/vFGeEyMmSaaAynh43l2wDAdIDzMACwOl0=
X-Gm-Gg: ASbGncs7TZaBBM2QSP3nMo2EpHwZmThE/hp29m8O+8KBFZ6GiSWGD8HWyj1w3kihCgh
	A4L9+BMxszl3Q8R1c870D7gv/z3gOreblrBxJI0Pn+tpU9EobFJhgDbTRc6+4HxO1TlqHTEqjDn
	XtKQtqItplYpnttT6NS3XZ1LYN09mfD/+vkKecMB1PuEBTehM+cYlewaBoUtyaxzefo8qzgaKgN
	tOAvGI9Y5eHFFAr7UsBFzMFrzeUHz/0U1oCIIT6BM2oYZdZKlwiscHuLx4+ZWoJ7bDUrVdeUN2W
	DEktSi5vVC4DmdFD8/yBO5ix+z9ysZU6QNR3u2uBSicrKJurYXGns9FGOnvkk/0C20JgunJx+M3
	CJk9iqNm05Dqv+/pA+khdV2UESKlgdyuWdjdTWm1zd6iGuA==
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr6171145a91.32.1760751224671;
        Fri, 17 Oct 2025 18:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIKBsbjRuVOEEafzTskcxI+RIZweN4v3yg7SFBNeHWuxqa9Up6EUtbI6hu7qPV7UnkBxYrVg==
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr6171120a91.32.1760751224239;
        Fri, 17 Oct 2025 18:33:44 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:43 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:38 -0700
Subject: [PATCH v5 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-1-82d0c4bd402b@oss.qualcomm.com>
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
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=1696;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=ORqLDn4tPxAJKBqLDSOiTLOmLrdC5p3+AUzGMEo0jrI=;
 b=CX/0QSCszI3KvpDNAdbz5w/KezYYoQGSTW/BMRP/Y/UANFpHNaQ7g3fYwWTse42LYKhiCnKtk
 yMwkgU4A+l0A3wrq190ZEWJwbKdWxzkI3EjKDLU/hS1jJtPSuaOGu6T
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=aM/9aL9m c=1 sm=1 tr=0 ts=68f2ee79 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=prgL3jgsdPShhDvlN2UA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEwOSBTYWx0ZWRfX4j89Nq8XHJCr
 gAfocmhaRXvrixHpvWGvgVkyY9bvyTMi8FPU5PsoLMuel9k+MmdziJC/g3txV7L2RVIyuKx88HB
 KQLQ77CLISoys7caGir9zBu8dGJlB7eMn9ew40qWYl4/qwyWZ0Sj7RflGtuBHSj3L3Vi4lTj2Ar
 wT2MextKOMAz8XVKmRBuUGgDg3abO4RQEfzcXv8gT4PUaLPGTZ8MPfYPGIXccHDD7/7s4anGDS8
 rXxdI8lnNkXcys6Jk4wTNjgHP4wON/Kz+YXy5odsFMf07wLZB2L6kP7xY8OeswNSGmtWul7VZwB
 BPQ+RJ3fJ9Scz4+vXt6tMKFiKRzdAxEZXDzg+VUmq8Hmsvc3gCNr6hviASm3f9PkDsfv9LXeD1m
 wc1RsAuGcbtPq3L485jLeNtWXwOnzQ==
X-Proofpoint-ORIG-GUID: Tlj8HAx4_nEQ23Oy96PV9jXykmxWE6WD
X-Proofpoint-GUID: Tlj8HAx4_nEQ23Oy96PV9jXykmxWE6WD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510170109

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd66fe59d91c377449d27d2f69e080..3adeca46d9aadce103fba8e037582f29ff481357 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -178,6 +179,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1



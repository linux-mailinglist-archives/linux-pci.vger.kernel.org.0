Return-Path: <linux-pci+bounces-34708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF0B353BA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F40368291D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B62F5329;
	Tue, 26 Aug 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYl0MsJp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0022F49FF
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188192; cv=none; b=e5PP/dRbF6riSrfYBD9BOXcDX4SZxAFYbAHKDUeK58JaSLYLSy5PMgQtLM8/dsv83ElanGtN1mKLP2jUay40dkg3cP+Bqybof8uopQA7QdD1FoM26Rzuis3vY7qttbp10c9P/gbSpUeEYG48RUIcw8nZf9rdiw9pxm5BCSqWCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188192; c=relaxed/simple;
	bh=Z59JyNXY1bhJzhN5VigUElth0S2Utp0rRQ8o37kZbzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1/JPGod+DxMKBaQllkcAQjPLYe2BkNnohjRnTAd/rvo5c9atQdhzp0QvSXNCwb8ESutu2xoZUrChQ9dKctuK8Vy3L5xB4idPRTSKHDMR9V8l3z8PqUyx8OL+wVVqbcdFKX0eZmmz6bP9GdQI8XvnGhBicOn65hW7SE27ytJCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYl0MsJp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q58w0i009905
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3aPHP/ZvWkk9g17nfgyfPgB0CX4dTinxdGvwP60Nou0=; b=iYl0MsJp27Kknz6t
	hyobAzDkq4KAVMfkfhD6iCLryJM6MjakS+co+iGgfu2hDjeIaEYmV//fwJSdDrzf
	zXzk5xpCyY5EI+rP3tDAFnT3et3vPPcvJzGGyUcED5qZ7lXuzqly3afDn4yVgaIe
	Pddld/uzSAjJNPaRhTuldP1Fq0I+799qPElFbmS1H5VpIpJDXhhz+ifqLDzsQZW0
	c+5dHOce8IlzY0/xvGdWGG+s6lRkzzFLC2FYU9eWPp+dYBeMJ3dTKD9M3EEebJzU
	YikDY0Xjz3bDX6efPskkPeDBryyND3cLkPV8MLl4u4fAJV1cD8IGWP6a5U/veBN5
	NEScwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpqs3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:03:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246f49067bdso15440685ad.0
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 23:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188189; x=1756792989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aPHP/ZvWkk9g17nfgyfPgB0CX4dTinxdGvwP60Nou0=;
        b=jUja0PW4s22vym5uU5XI13fEWs92olvAVM+PdMYx3X6sI20h2Tcos3aHSuv08AcEVV
         AKcVNSNDbRVlczIQNhjnJszxL7sa+TA1YC01ou3vzcAqV8arNUtMsVra2YlhGCQUg876
         fd3Efs7LvSJSX+HsWxxzgeAckrC0FPQtig+IM9KUrs8CbfR7NRraeffyFshljolsXmFp
         JM0zSWGTHau5NCiuGydlIXHlgu6DdU9X/reYgUg/CAeFzeknoJuoNOIxkEgAfy+dnKMP
         gmO9mc2dY7fgSjeYX5XkyfH0kZuGoyAbH7vt3zDIoiv65qNdXM5R8KzWYgW0EemP7cO9
         Fc5g==
X-Forwarded-Encrypted: i=1; AJvYcCVyZx5D2sj8NZKMnHCDh0Z0qGaT/sx2MkpATRqxpRZvMZmkAPtazQt1j4QuyE7CiZlnlzEKcqHDdlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOnq3c3PJcVjrhtC8OLA4nrblXPcoGq1YmowuaXZ29qNNM1kH
	YoeoIcPsQjdeehsBy1gA/0ghMzwJxnFO0Mr20imdFxk6MTBRBmiVtW52S12ponYfab9wl124bEi
	Iyeb+VvVOgFuERrC9GELoWAV/c0kP1YpkL+bvysiVYa5AiVDTaDL1AYRbELaLWx8=
X-Gm-Gg: ASbGncsgSUK4FjPogrniHvIsTFIq1THMwqnIOBCwS4THnBPJH32fb8C+031c9+oVuDv
	BU/mxuJPWaR4iwMf1ug7SE6MIcXpOOOcYsiwk0PbeQfHI09jVS7vT2DnnHRBNdCK6IgAwyJFWDb
	oZfJ3jv4XW7wzbztYplezB3h+BhrsVPiWFtRBYthDXc//w+f9QdTzkFCH6atGcDt+WgdpySINJP
	lS+Qbd0+RNARnJOVSO6y+Q3iga6w+il5JmukwcXoUgnre4BSyJi4wBZrYOyIBDzFqeK2r1FwvQA
	Ukd/zI+qT/BK4xXpWPCRThWANgNqXAiphmMxDB+FL9/YHBCvzJXPSSvMIqR31l4E4JQLRus0utc
	jBxleZS6gVZXEV8o=
X-Received: by 2002:a17:902:ce01:b0:234:914b:3841 with SMTP id d9443c01a7336-2462ef036c1mr206242255ad.39.1756188189268;
        Mon, 25 Aug 2025 23:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPv084Dt4hnW5Zi6YWCsq9muv/c3TBUeRCKcrebtzv4eUqKfQpl97L7mhcppIGA72kG1DfDw==
X-Received: by 2002:a17:902:ce01:b0:234:914b:3841 with SMTP id d9443c01a7336-2462ef036c1mr206241815ad.39.1756188188802;
        Mon, 25 Aug 2025 23:03:08 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864431sm84989705ad.93.2025.08.25.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:03:08 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 23:01:48 -0700
Subject: [PATCH v3 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-glymur_pcie5-v3-2-5c1d1730c16f@oss.qualcomm.com>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
In-Reply-To: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756188184; l=1219;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=NNqB0T3SwC/nQPPpaZYNgmY4nF2H4V0Dr0y62les5Jc=;
 b=ZDarMZfCReeORTZs5PxdEl4S2aPFqVIxv2EnYj6iaL/AYqteR1RV6Dx6wxWy0mBpmOZZXxiff
 hcewqh4Nz6CC5EfKXz0o2ljqB7nquJPGkQqdIBMLCPirIG861GtVj+H
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ad4e1e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=WgZgizuZlwTqGGW0kXsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jJrQbiv_UJ_tS9IqdzT3UjiJhIuFiUyl
X-Proofpoint-ORIG-GUID: jJrQbiv_UJ_tS9IqdzT3UjiJhIuFiUyl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXzo4LKiS8OGYC
 tZh+jdcb5oG1fOttCvHScZQy3dGmK/q2VuTuxjQbo8jWEgW1LHbUju1mqLvHG1tjlFja9YVfiWW
 bqGeB6EoM8P3Nx2KOC2KnslRNvBcZAYF2pSneYwfOMpzRhZuBpL8umNSwbBzieo9DHISt4GX/dt
 PvsK/Px0I8Qh+ElMKRdJ8g1d1LZTSWlwNKNP5lepCcWDz+ZX8aOzKR5YvFyKb6gxIGSUADXQqp9
 U2JBUW61yMlYzUAEfbLL8DzPTohlKfLfqwnLcwruffoiW+qMR4l/RrESDXAVyRradHKQ8IL83p2
 3CO8MvtkQVNZyIaGbayO3xlddCbmFyI4lLFEQUcWdtwoyIYaJj0OpL36s++esHaQt1WMlXk73yO
 SRovWYQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
controller present on the X1E80100 platform. So document the PCIe
controllers found on Glymur and use the X1E80100 compatible string as a
fallback in the schema.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 257068a1826492a7071600d03ca0c99babb75bd9..8600f2c74cb81bcb924fa2035d992c3bd147db31 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-x1e80100
+    oneOf:
+      - const: qcom,pcie-x1e80100
+      - items:
+          - enum:
+              - qcom,glymur-pcie
+          - const: qcom,pcie-x1e80100
 
   reg:
     minItems: 6

-- 
2.34.1



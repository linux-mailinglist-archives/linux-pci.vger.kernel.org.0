Return-Path: <linux-pci+bounces-34273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DBB2BE27
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133AD5A24E1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22A3203B4;
	Tue, 19 Aug 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1gd3tfW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6733203A7
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597171; cv=none; b=QWtpar7Pm6lkctxXDlYSDzaX45Fi0/CJih4yD8qMFycrSyvVOM8+O8ps7Z3iYCN38bR9yjz4iXB2p2NmAjNSzW2PDlGGdE6UBLMw32ahZlOIE3NGvYtIm0nt8fPsVjhAlo4yNcK8cCF03yTsqpbWEXwY2Dws3AU3RlxK3tn3fYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597171; c=relaxed/simple;
	bh=ekdA9CVOTz1DmJofPhYI0+HcBHPnLV+Txm+2ENdkrHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ul2b6SqRycr+nHsv6ryj3/V7I63+WbuBNbIcRDqQPzWq7X1az9/vHFyxzhglVTi4nqBE0dBFqV0Nv2yWu8YfkoHpAAGfqojiXQpxPDjZwMzv6XIPXiMKo2Tzu6x5SvlTjCV3uQ8gSY4GXWjRBZpdlyQQ0Kr2AZ6Q87uC7nByj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n1gd3tfW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Y51023100
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=; b=n1gd3tfWgh4Lple2
	RUP0TcqfCejGVxtXIvYyxDgViyFw0n5gKq1/3QvburWZ0byEhkv0siASr08gQUJL
	8y+juCf9hO4kCtDML0dDO7bIc/ZXYY8W3URSt1G8SWGLWjR9wkwn8EwX/PQpKsbQ
	tVSy9QpSUovsa4Cr8Whfl2Vd4LPXmeLIIcwnbUJM7q//+9itjZOuEU1Qhn0rJTOa
	2FZbqFQoD+obABmuddnvgHf0qRyRfPPFmK93mx5oLv3kpfnCW9BxuA1GJhVmOjXn
	nhpbxfhdClpqYmWjPh3oDVtk4UkMv6Z4fDfStqeEyVJCwnspE1Yktmu7RjoZCqLu
	OXxGww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5hrs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e5fde8fso4843352b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 02:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597168; x=1756201968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=;
        b=WtuZe2WJnqwSW3VlQC9Y/UVQBztLAB3wWzRUdsz524qXvFvglKfyIOKGc0uim/wN2m
         WKyF5AnBc7JDGbwU2kJFjd64L8KnPFNkVBHwuyZVPe4+qZ8zJjpRQv6U4sSZ6CD1sS3S
         9O1RoKigO5DVL4J+DCywpwAcLlwJoaEwUkWAb8CqrUMxNb/sfyx/TuIRrfL12//o30ud
         /4nU862NnQg6ZCw88XKBOFW1bEWe1sRwxLFFG2qB+PdK/NtjOHAqYyxAvZ9KKesx7K02
         XsXKHZ52Vq99I13G7sQoadAe8QYO4T9ZSB9jOarmBs9X8RqNMwh9BXLIii/7ifI7L5My
         9ogQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmAT21T7pflLklxKO0/yK6d6Wd5CAC6RSUB9uN0QZlYi8g13Rn72CmRToQ+avqpH6EKd0Ea6xbSMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/4oSu4w/y/0ibAtGXzhFpqJHHcYIVVSAHpo/nDBVHV0XRtEU
	Aab6Vyz6ZDgA0mB7LaPNI3PkVQ0i5JX4e4Soi8D2kNMzZCkaotbUr2bsNTLEg+Xwu3ps1rtvY+v
	QM5jnjBSlxq+F+dSIaKKr0ycFjHaYgZljPltF2ZXne1ijKQOCSFuSI7qn5S+oybeIjAXg+1IsMQ
	==
X-Gm-Gg: ASbGncuXH0ZMnfPpi9CEGerFifUhL7Z1YHmArU9O+MloIRLHoHp02ObLstDDUEXJ3Qi
	myOBkMHsrzXMxM3vOvvq1RoL7uZsqC8MmgOgJpvWk9yF8CNJhePV1TZjnFoxtvia8jTuigfCzBF
	WNd/6aJAc3X2qNvFLz5DkgV3GyuVIei7FGP7luPYwWBxONQEKA0i0PiZEGITSEMR8sDmwe8IvTP
	nZjlriMy6y9TuplhEImZBFyqF1qsIBe9MQ7knhUpc7K0uQMWNQouAC9Kbq0pqB4TkvjbW/Nqx5z
	F5qSs/OdS1T3BlydGsrI/4KrD8PEbawg+TTzhsgcdD1p4LogHr5LrYJI2YXDjtIVLYLJfPrn2qM
	wAJWPsrgLABLdFZw=
X-Received: by 2002:a05:6a00:238c:b0:76b:f0ac:e798 with SMTP id d2e1a72fcca58-76e80ec16cbmr2675709b3a.7.1755597168025;
        Tue, 19 Aug 2025 02:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENz0VJ98WADN+joIk0/P7w0o0p+4hmpEs1o6oCjBWcA7BvrTOLvz8FOh4tQnOd04eMjoXMVQ==
X-Received: by 2002:a05:6a00:238c:b0:76b:f0ac:e798 with SMTP id d2e1a72fcca58-76e80ec16cbmr2675678b3a.7.1755597167592;
        Tue, 19 Aug 2025 02:52:47 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:47 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:06 -0700
Subject: [PATCH 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=1172;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=jt6UG6eiIFzDb1oeF0pFhVGf3jfLG0hsOnnZ5HuEIJI=;
 b=aLluycJkcVAxmTz5cJvmmczoB2nQCBmt5en2PL/z+GQMXGS1yuhRxxt+knyE5tfFmYvmM1uZ3
 3TxgHk0HhLTAUMfkAk+qLqJLStjDeG3lHUrH6iLe1j1Pj7Ojlp56vIp
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a44971 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WgZgizuZlwTqGGW0kXsA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uH00rz7jYY4d92Y7oe8S2gD0OzCB6EBa
X-Proofpoint-GUID: uH00rz7jYY4d92Y7oe8S2gD0OzCB6EBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX27rzXRmwmwqt
 1Q6r9TmNvpvfhJ7XjzjegwKDQXmcoQ75sGR7Jy+giyY+OnP6M0DhxACBwjU/z2Wl9lLTU1ga5xF
 ZWFORxJKg4EMtb2U3Sfekpd2tw2HE8/N+zrmPnrhb8Yuug+9qLd+vqCUfqiDbk9IfKLFoIe6XLF
 Y70WdYFOyMVqARkeCgJTuDjzY9JTD2WblsLz6wFrOFfM9XCVC7Q2rLzVrx6/LOO4zaxcewQUmZP
 Y/EJ9tBvjPPSIGY5Xr1Oq9uxxxaLqfP7xUWt57PBsGB3KLX5DY+a7VCNhNG7zxZrYaShTYz8ZMz
 3TqSXVfy9+31K9IKsiXOoxAmebhDsegO8N3bYODkxt1N9nuj77/Rov+T+iOZ9vUz8SRmQc87283
 MPA3CIDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
controller present on the X1E80100 platform. So document the PCIe
controllers found on Glymur and use the X1E80100 compatible string as a
fallback in the schema.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
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



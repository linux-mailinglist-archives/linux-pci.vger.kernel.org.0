Return-Path: <linux-pci+bounces-24428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416CA6C74F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62BA7A8E4E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05E4A05;
	Sat, 22 Mar 2025 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xvn7B/Lx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D377102
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742612467; cv=none; b=H4wR6tX1chNSotoYJIl+RXflBHgnOOrQmlHXCYV01BkXrU5u7z5NKaQEi5rQoE132aSwUZvfFXf+dxLJG8GK48W/qgwTGEr7aOpZir/4IcqNZ1HMFy7cO6IWD3IXGUpTQziw3ZENrNoW+AKGNDGLgGd+hGPzRdO/8o/dHe4iLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742612467; c=relaxed/simple;
	bh=J7qmsQ+A2fIonAzDIDVYg3tQK/uWUAEhXZI4HRbecCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXYNtPErolnYPfAItT4tVA8pyBxDqTI30WqNy+SkKYaCBOJSVCcOjHFxz41DHWWPrnzd07Vfq12UR0Yj9O4vByo9Zw3ezHpjy/pkgkmn5VvaaCDJ5EULgVgjzVSWGYaezcBc3DBN1L5+xUt1KQN4RN4SuvVqD2DuC5cOq/UC3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xvn7B/Lx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M2XoVU008159
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L6NsJ67mbWVdBD1xaBbCR7wFG6yiWcFKT01m4CKJ8jg=; b=Xvn7B/LxM41RQLJe
	lKRN+fhQ0575YtujuZ1ScgJnmaibFTSyI9VY/xHy1ab4jhDSeX9GCUZgU+YtNqqs
	VB4g/bg9jtnDJbwEShsgvc7W0JDdPOHpqPcTGM06HJTL9Ky5xT9gzogTeNn1aYQh
	jN1YuNVGULq1cbsgzJH2yNW5WoQ5Ihfjch8WnJyEkeEdD8nEdnM8F3rrlqJpVZID
	Le1Gx599KcNisM+3maHxzfGsiaKXdv88tjkJvA7+/Tdxa7LE5OfWGOW40qpzW+b1
	fsVa4sAOc1CORyS9H96v+35+up3iw8iIc6knZmr+EG7CDCkTie8bFlYJJabCRQEG
	ejrixg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmhk01em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224192ff68bso36854985ad.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 20:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742612459; x=1743217259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6NsJ67mbWVdBD1xaBbCR7wFG6yiWcFKT01m4CKJ8jg=;
        b=KNqEQWGAhzfdWeg/4Fuy3LW8SKzKKoc7NAg4l8reizXGQiSfwg9y2gC5FhutlLXZlr
         uTlcqkUIkDayqSrNxlUQZozxhxImiA/Umj93qU4/3ZLg69RC9sf5yzPL16Ro1ctX/wIa
         YsLFdxa+DVXMdXlNNx6WQMkYd7x+K59hhoF+VZ1e8pzMaXw6I3eWpgG4saDaMUIA34cp
         k4vElVVQgz8iOpgrkRIGtrkp90/pQwmP1Su7M+gQQrbN4M4mR3/fXaqBlcQcQnC+SW0Y
         F7DmcHggFDs5nvFDjM5Njmt6i+hXkaa+btjiUY8PLVOcGYxiMWnCFtpnMRiazZeUHXyY
         ylpw==
X-Forwarded-Encrypted: i=1; AJvYcCVVtD62RhbJAD38RbTuvm773TRovO6MyXBI0k0okXuFyr2T6Lnj23Si0VRLvCGzzofwIqZR2LE9OM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEGY4pIh7YZAIkpRbMr/pX6fp+RzZUzWzLHeUqdbP4oc0g67/
	xxH5qjD5BcEXiPV53jgTXmV4T3K7EeRZNaSw79agsEWinpqywKKQVwXMCoFqBPTAVJ6//DJxMrx
	SZUF/QRXRQmVzyY/FBoTMmqsdBQEnuyT+oCAwgOgKsbjf8083TCGQ7U54wLWUychd1sc=
X-Gm-Gg: ASbGncvLD+0N2mX0jJ1gMb1J5QvgqC0G4p47lxj4OtroRX5GJHiwF9Ge4zY8sezhpRu
	KEveKV4Bb9j+m6s5+FdPV0jo0vhp8KkZbWgkS1Sm4ZoZK3wGqlQgqBzTp9yP3lt70V76ZwXE0ug
	IH9WGuQA0qszJiQGBh8ZUlWnLFvBfZeJlrbGUXO/b4JCPGYpWlYMpHgcv06b7VODifR/LdPOGXr
	/4x5FnlfFVUiJDnPCLt0dEXLEOVLwW1rPF4vwXtyN81QZzv6/XTWzxLT19Wr9ufgYpDSOAmU4yZ
	j9MM8kSBp2Qbrf6nwmCdhqyI30Vf8oxlRN1fg5yVBnRbRdkYPgY=
X-Received: by 2002:a17:903:41cf:b0:223:5e56:a1ce with SMTP id d9443c01a7336-22780e0a90cmr86917165ad.32.1742612458946;
        Fri, 21 Mar 2025 20:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyPGDyW8IrAOK+/PcXgL0d7SLEzCd55inihl6cMxYyLgi9/fFL6XvvpBDEyUXBHPph3ViRfw==
X-Received: by 2002:a17:903:41cf:b0:223:5e56:a1ce with SMTP id d9443c01a7336-22780e0a90cmr86916595ad.32.1742612458395;
        Fri, 21 Mar 2025 20:00:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bdca7sm25859945ad.137.2025.03.21.20.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 20:00:58 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 22 Mar 2025 08:30:43 +0530
Subject: [PATCH 1/3] dt-bindings: PCI: qcom: Move phy, wake & reset gpio's
 to root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-perst-v1-1-e5e4da74a204@oss.qualcomm.com>
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
In-Reply-To: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742612448; l=2972;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=J7qmsQ+A2fIonAzDIDVYg3tQK/uWUAEhXZI4HRbecCA=;
 b=PLdg+I9pHswAaTCNTR6hEMJ1mJz7oOkFCeznCwpsFEfqymTrHBQv+qBwt8btkyYnHQEToG65g
 Z6qUnOtyicSBTP6tWlvuqJlOZIRoP46fH4D5ouqxU2ZsoSA4B29eryl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=C4PpyRP+ c=1 sm=1 tr=0 ts=67de27ec cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=stmhjgsGwY9JSZftE7EA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 5_-qHpGvAdmjgtKA1_m26xxb2f8ZweNI
X-Proofpoint-ORIG-GUID: 5_-qHpGvAdmjgtKA1_m26xxb2f8ZweNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503220019

Move the phy, phy-names, wake-gpio's to the pcie root port node instead of
the bridge node, as agreed upon in multiple places one instance is[1].

Update the qcom,pcie-common.yaml to include the phy, phy-names, and
wake-gpios properties in the root port node. There is already reset-gpio
defined for PERST# in pci-bus-common.yaml, start using that property
instead of perst-gpio.

For backward compatibility, do not remove any existing properties in the
bridge node.

[1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 22 ++++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 18 ++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0480c58f7d99..258c21c01c72 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -85,6 +85,28 @@ properties:
   opp-table:
     type: object
 
+patternProperties:
+  "^pcie@":
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      phys:
+        maxItems: 1
+
+      phy-names:
+        items:
+          - const: pciephy
+
+      wake-gpios:
+        description: GPIO controlled connection to WAKE# signal
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 76cb9fbfd476..c0a7cfdbfd2a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -162,9 +162,6 @@ examples:
             iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
                         <0x100 &apps_smmu 0x1c81 0x1>;
 
-            phys = <&pcie1_phy>;
-            phy-names = "pciephy";
-
             pinctrl-names = "default";
             pinctrl-0 = <&pcie1_clkreq_n>;
 
@@ -173,7 +170,20 @@ examples:
             resets = <&gcc GCC_PCIE_1_BCR>;
             reset-names = "pci";
 
-            perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
             vddpe-3v3-supply = <&pp3300_ssd>;
+            pcieport1: pcie@0 {
+              device_type = "pci";
+              reg = <0x0 0x0 0x0 0x0 0x0>;
+              bus-range = <0x01 0xff>;
+
+              #address-cells = <3>;
+              #size-cells = <2>;
+              ranges;
+              phys = <&pcie1_phy>;
+              phy-names = "pciephy";
+
+              reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+            };
+
         };
     };

-- 
2.34.1



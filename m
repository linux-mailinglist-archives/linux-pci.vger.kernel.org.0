Return-Path: <linux-pci+bounces-31244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065CAF1393
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6661C235D0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E726560D;
	Wed,  2 Jul 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3lcgbMU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EE265293
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455267; cv=none; b=I6cbSAKs4OGRjqEFi0QJnMEDQa/EW5FB502vfp5Tk6EnwxoNHyFKrFThHhI4DRX03i3vKX4XIPBhq3eqxsKLOSoSbhFKOOrCYSA7TLXe/WeAl99XynWCOyG+PqZPcs8mYexGs1yI7z6/t5sFrbxZc/MqeHmBza/XVzFuC4LM63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455267; c=relaxed/simple;
	bh=mZuE27azPdIvbDzxvjiYb0E7ejogNzvkKRaIgbsTuhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+YqGQ1JDTP1RMI/E9NWbxtpbQ+POtL+lJE8l3lH97j9h+hQ8wUWsSMfQnV+NO854fTvPINObkT7jsKJGJ7MLBkMNFekO9NnFHLOdpws5Pj0jkRRrDTbWQdWmrH5Bp6ZRUfOgNDu/WjkyrNPzTC9i6wcADfOpPkMjeMMBtzYTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3lcgbMU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5626KiVG032748
	for <linux-pci@vger.kernel.org>; Wed, 2 Jul 2025 11:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45WlQ/PAE3dUlwreJniG3qDKTMo5dFCVE7Tjs+AVG7I=; b=M3lcgbMUVq0dncDk
	DzZdBrvkQJj6jgqlsG/qmiTpqitx63upXENFbFcYdDP5JGwqC6zHSJapmHJwMCRX
	7ncmN7hNPG5L4TmnwDcAgbUlJILFO2xCXonI8F7hqfy+fXDRKpt7Vp87WJM8gJ9B
	QuM5VIrGFLuOSYHyWxRsuEMHy7UOxaBteQe0thCDzyjDrQTRTdabck2HjZmR/5Cq
	brCA3Mk06s8vTtat7gLb+V4RKYjBAfBefz3wuPATo/wLRb/NvPfMfLmb0JsPzK5I
	7bEtMYZuqcLKWq2TY1HYrOVnxCrraACLfT56fC9DfJGiEMM4LiO2Li/guYwtwlZn
	ejw+DA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qmcbgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 11:21:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-236725af87fso85371585ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 04:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455263; x=1752060063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45WlQ/PAE3dUlwreJniG3qDKTMo5dFCVE7Tjs+AVG7I=;
        b=xNtBAAv7yx6cTEHI0MKKCg2RIUrDRzkd/IUvOAGdTEWWm27yoqdEiLsmXleTAcjiRC
         GJOo/esqfFm4ccHhUE0UcH42h1oO/GVtUuYW3JYAL+KzFRMTqi1QI+pJ3BZCd0eW4em1
         wVhZkfPHasaCLkTLJcGh/HOIRbM8bDTUJsRO0DilU/6lZbxIcKOapQGiufoqf8Uud+H5
         TAnFS+0Ep91oQ9WTb3w2tSKKOZ65ck91adpza4UNBMZcHRDL9AhSHf1+mdOII/MCfHKR
         0RFzkfDGqDS1jl+uLKg857/BL/kdu9VyKJFrwTB5nmJId5JtlzAuhNDZ8hbav6ZznliG
         Iqcg==
X-Forwarded-Encrypted: i=1; AJvYcCWa1g+FRjymP3ouu6/hTaBGc+lxlNzbIFeo8g/1W8S1QUdDj/hwJIXHZarp5YWMXzAMiOUEGiZ20xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9CKDIwcKBmQGnOuhOGzRbwkxCJrJXic+s7ZPnM2T2b3TMwy/
	RCd/ZlfgGoC7MoIrkONSgVUaqiSnekS01x2kAcfNarxiOcRRmpJh8rh7OOVNOqJDvoWp0JwAkC1
	EcWxjZRmHs7AIzRHfqmsvAuBvgn3l7UCBP2fdk6p2ecbttgH902HIw+li4uCqCsk=
X-Gm-Gg: ASbGncsoZuO27Ynx6+5GiywjMLvi2ATeLkwJlKWcTfnz9q0FzCUyKLDmfVgCOhLbRmR
	DhEI+TIIg+xlulbxUIuoAhUV9BB/A2aq/nLYpRaTFzTpHRm+aBj2YtcKlJeSDBVkeS7WP0BSPXT
	XirlEPtaFEcr6MrupwQH/IFG2Vx+IfUTZEk8SxCMz2dKK3foTrXJ3kOpMsQHqrlyRQ9FFkNnSgS
	246GnY9WMG5FnrmSPOw+8uZA+xzrs3xPJFsdINOblwzbkdd4Cprz8ztrWtaZRTovwZ1Sg9TCu7V
	3gfpF30sXXbEbrIyve7XZOF57XEtLeSHvR7TdB/qL53ut8IspNgQlmnpvA==
X-Received: by 2002:a17:902:fc8c:b0:234:8a16:d62b with SMTP id d9443c01a7336-23c6e502f5bmr35405565ad.12.1751455263125;
        Wed, 02 Jul 2025 04:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3LU6NCdJqbUegAWYO1/+AgmzqN4CUPaebCfavq1oAx367KiHtwLJ/h6ewk5RGWJzv3TXQpQ==
X-Received: by 2002:a17:902:fc8c:b0:234:8a16:d62b with SMTP id d9443c01a7336-23c6e502f5bmr35405075ad.12.1751455262662;
        Wed, 02 Jul 2025 04:21:02 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23b0b3bc0f1sm83926955ad.171.2025.07.02.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:21:02 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 02 Jul 2025 16:50:41 +0530
Subject: [PATCH v5 1/2] dt-bindings: PCI: qcom: Move phy & reset gpio's to
 root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-perst-v5-1-920b3d1f6ee1@qti.qualcomm.com>
References: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
In-Reply-To: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751455253; l=4305;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=mZuE27azPdIvbDzxvjiYb0E7ejogNzvkKRaIgbsTuhY=;
 b=bCNw2ESCGuQTp/9kPFa43+JWcP+WMvt5N8sOqCw72jLQ3qMSvS9zLcXdXfOzb7otKE0NaR1MA
 dP7iOC2WVOJBQvXwKBqrjnk5ocOmfKN8NDPkzAQm7fL0syo8dHHeZrH
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=68651620 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=zZdbXEcupTeRExCOI60A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: D0y4fxSvDJvZD2W3WQq5jKsaRcffpzg9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5MiBTYWx0ZWRfX5O9xv8Wuva9v
 P3MakMLuMkv9kCwN9BCykj3upIAnX18zL6ledelapoqw1JcjOhUsvbRvX3bNGewrj9rJ5XZ3egz
 nM+vj7Jmsa1UI6OPYu2s0tjLwG8NnwEubXL/TRZ8A6PQruJQaS3oVddiPp/8/mjlZm6/ZQXI61H
 AYVziuR/7bc2oHXtRHykFhG3urUFZVID8ncpasb/DrUFhRvf8tRsrn2yp0ejjnaUOh+SJFuojp7
 uT9Qtx3f9OQHlpaskMlgThRLNQu5Q7hrr6L3oQizF08ev0QNpzwNfoyC4TxdM+BCrMO01g1JlS0
 95qKn6wGWJ1/k6s8SSHFu/wmzTClGDORsM4SOgcsadioOwWp1ACtn5LaVK7qJySauc1m16m0OaS
 eLeh34OsbDxkx/2T3bbCNakZnc7zmjYhARjixCFDSqo8/ifeHCLHi6RuDOVxXwSwwPEHbdXh
X-Proofpoint-GUID: D0y4fxSvDJvZD2W3WQq5jKsaRcffpzg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020092

Move the phys, phy-names etc to the pcie root port node from host bridge
node, as agreed upon in multiple places one instance is[1].

Update the qcom,pcie-common.yaml to include the phys, phy-names properties
in the root port node. There is already reset-gpios defined for PERST# in
pci-bus-common.yaml, start using that property instead of perst-gpio.

For backward compatibility, do not remove any existing properties in the
bridge node. Hence mark them as 'deprecated'.

[1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 32 ++++++++++++++++++++--
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 16 ++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0480c58f7d998adbac4c6de20cdaec945b3bab21..ab2509ec1c4b40ac91a93033d1bab1b12c39362f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -51,10 +51,18 @@ properties:
 
   phys:
     maxItems: 1
+    deprecated: true
+    description:
+      This property is deprecated, instead of referencing this property from
+      the host bridge node, use the property from the PCIe root port node.
 
   phy-names:
     items:
       - const: pciephy
+    deprecated: true
+    description:
+      Phandle to the register map node. This property is deprecated, and not
+      required to add in the root port also, as the root port has only one phy.
 
   power-domains:
     maxItems: 1
@@ -71,12 +79,18 @@ properties:
     maxItems: 12
 
   perst-gpios:
-    description: GPIO controlled connection to PERST# signal
+    description: GPIO controlled connection to PERST# signal. This property is
+      deprecated, instead of referencing this property from the host bridge node,
+      use the reset-gpios property from the root port node.
     maxItems: 1
+    deprecated: true
 
   wake-gpios:
-    description: GPIO controlled connection to WAKE# signal
+    description: GPIO controlled connection to WAKE# signal. This property is
+      deprecated, instead of referencing this property from the host bridge node,
+      use the property from the PCIe root port node.
     maxItems: 1
+    deprecated: true
 
   vddpe-3v3-supply:
     description: PCIe endpoint power supply
@@ -85,6 +99,20 @@ properties:
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
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index ff508f592a1acf7557ed8035d819207dab01f94d..4d0a915566030f8fbd8bf83a9ccca00fbc7574bd 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -165,9 +165,6 @@ examples:
             iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
                         <0x100 &apps_smmu 0x1c81 0x1>;
 
-            phys = <&pcie1_phy>;
-            phy-names = "pciephy";
-
             pinctrl-names = "default";
             pinctrl-0 = <&pcie1_clkreq_n>;
 
@@ -176,7 +173,18 @@ examples:
             resets = <&gcc GCC_PCIE_1_BCR>;
             reset-names = "pci";
 
-            perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
             vddpe-3v3-supply = <&pp3300_ssd>;
+            pcie1_port0: pcie@0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                bus-range = <0x01 0xff>;
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+                phys = <&pcie1_phy>;
+
+                reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+            };
         };
     };

-- 
2.34.1



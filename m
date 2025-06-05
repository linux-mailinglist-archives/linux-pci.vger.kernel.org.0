Return-Path: <linux-pci+bounces-29019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761FACEBEB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049661752B1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5820C026;
	Thu,  5 Jun 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PykBNQOA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3220B81B
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112258; cv=none; b=lZgs/YRBuRGNRS3k5KsKF8+mQpOgJjIUQiDa1gTBciPm2P7sE1TqyuP3S7J46eaWUy9yhtx9QldZ9G8HqSh8J1E5ngAQL2pSKiuicrnwwPrQjRbfHxBHDAJnZj2ZCVB1yjp2VIeNk8L04O2NZYZ0iJFvDKZX1QREBxn7vwHSsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112258; c=relaxed/simple;
	bh=mZuE27azPdIvbDzxvjiYb0E7ejogNzvkKRaIgbsTuhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCfohCYyTjvXTpOuXd1oMHGCppQbh63vJQS1CMzdPHz0dj5U6ZhOEExqztavnMBnBzcc71Q8pPsowjkiOCPHwlS10hayU4UtzXMA0naP7IMJYfuZQLG3Gvqn5u1xbR6GldTP/1vKzkerxW+G1mLoGm0oRUu+f5MiSML31R+2h4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PykBNQOA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Nrdcj023175
	for <linux-pci@vger.kernel.org>; Thu, 5 Jun 2025 08:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45WlQ/PAE3dUlwreJniG3qDKTMo5dFCVE7Tjs+AVG7I=; b=PykBNQOAhXIlEPgm
	qTPsHCBk1dkHfLEyvHo7Tx4DHjAgmJq2bGT25ArSluF47xkKAz/wkbiwlTzP0lg6
	BPvgPNZGIDewxu9fGqMOMKYEGzmgOF2/ejLJ3yAUkR/4scL6vuWrD9QWgsTRpeER
	g+nDKrGhYwho+XAWxuJiDpdlDQ8rjgf7IVHTtKJY7+6+pMGDSttE0QNMV+RdY5gm
	gCyc5OB81gZ8LQy8XdGiQIjRxVez7oC8pOJYzDsMhrFdxqpTtoT0IyvUUlIpS0qR
	i5WjAzVOORKateir4Z8yKDLZ4ofE4CmSG5Mo3BsP/qNO1FPfCMSV8J+TVPYR2Nh1
	PKW4ww==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn02x6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 08:30:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7462aff55bfso773349b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 01:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112254; x=1749717054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45WlQ/PAE3dUlwreJniG3qDKTMo5dFCVE7Tjs+AVG7I=;
        b=xOXR5icU+ppzuH7vcMxHDx1xOGetgeazM9HiFyL0lLT0CejilHmo6CDiF4uOST4/5c
         xn5qjFU3YqYxlrPhqfXTlRHkkH86Kn/bCyOoEoxW5WpmKEeshoNZBJp06X88wqm7YTty
         x7q+Wc44/KDtrH+4xqgms+04OJUSvgSZghw/jVtpR5fWyh6G9F0pzW1zQsyQVtC6OcXf
         1Px24hpt1aGPvJ3WA3u3R3EzFh8iBXnJx+z3+FtXJNKpurvuMTzitfnqef52SOlelomg
         STy7THT+wIO3mG4SC5fwnajDkuTIlKVvywfJmoJamamSe550DSzLWmZ38RnqBZc0r2a9
         wDxw==
X-Forwarded-Encrypted: i=1; AJvYcCX2O5jKhE2pjA3DtucLJPeCW2u/EmV/LWqvc2XFbEsE4rw2sSh0JPHJfXLYRNwxQxA/0qnKnraKudI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4975lyT7TgmU390QlxwN3enA5SvSTYFpkiIL5ruQpvACHDJAU
	9FkY09GT3kkLavr5sKYh8lJw/vprWFPYJ1w50semQIpkkFEqDjpq+1C3+cIsZu5g6dQs/uoE5Xz
	onX8Npwt+zeRBOdZhIz2WUMnfZU31qAVLKImJ0gP+W7ZNLjh365PmdaTguOvp3inrwQp3S5g=
X-Gm-Gg: ASbGncuRvMriX68x1HNswI3+tvs9G2D8X2zoJz4PMgVeWE9KY8MAIrlC9OvoPfMsM2q
	i0B/WXAC5f5/pPRdguGVxiZJI5oumGOLsjb9UxVn+fB2/IyxslNcm8i5Oczut9Nk1syMcnB7TNv
	+Fa1lpNuYKfhrUQTLFVh6f+wussQOOEw4M2qugpvVAGaVsf7VFbmTgab7V+ffwfLHe9FAUM60i7
	8b8TLoeNrIAsBM4D8MPtU8Lrp1jgTwVJNCTj89RZVM7Uj5lXdv8+f6x1JYDCMDSUqkGIMpE348Z
	zavWWAiftLtV39ZNkzzj1A2C9K1Nz12oC2fxnm7h8vGoSQ8=
X-Received: by 2002:a05:6a20:9383:b0:215:f505:b49f with SMTP id adf61e73a8af0-21d22c1d177mr9125236637.14.1749112253721;
        Thu, 05 Jun 2025 01:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqFjTLGfcXnF+9ATlP1SM7b6Sc3CJEbPIP/XGue/SHgpd/MXqwn+cWPa2kNnGocEAwKpsIBA==
X-Received: by 2002:a05:6a20:9383:b0:215:f505:b49f with SMTP id adf61e73a8af0-21d22c1d177mr9125181637.14.1749112253235;
        Thu, 05 Jun 2025 01:30:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb37d5dsm9819095a12.34.2025.06.05.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:30:52 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 05 Jun 2025 14:00:37 +0530
Subject: [PATCH v4 1/2] dt-bindings: PCI: qcom: Move phy & reset gpio's to
 root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-perst-v4-1-efe8a0905c27@oss.qualcomm.com>
References: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
In-Reply-To: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749112243; l=4305;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=mZuE27azPdIvbDzxvjiYb0E7ejogNzvkKRaIgbsTuhY=;
 b=JpvQJTfKOzsPUnxBNZ9GCINo/hwqV56gA/WXaqGSBdv9k3YYpjKjgTh0aiUk1REPlEmBiAOwH
 aDgxCvbwTBhDx54eH/7iOeUuQKvoaA+IO4rI8Vw/ZOvlOgZIiCIXOTO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: odDtiUtT9xr_65eKBmkq_YJaOrmea9_s
X-Proofpoint-GUID: odDtiUtT9xr_65eKBmkq_YJaOrmea9_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NCBTYWx0ZWRfXyvEznFKJw+LX
 ohJfH5+46ey9tXa7b7ydLIIbvNScZ2wqYMjFjI2FZxWITdi2udTgPCcICtnqCU6IA0VXsTAvCbs
 6XKjEq9l/jnfTsZHZDox89+4fxaf9X0Jup9R3L6Y53XdFHNbt9AD4sPKp5szbNU8gvW9qayfsi+
 mPyjm46+DXtNfoZ8e+pIYz+ApZ8g/TkY44urmKG/gl2t7VrZQcBHe//G3ElP7e2rgqGNYZmvYyv
 dSigiI0N7W8QDEEOK88QbWFcHl3jn3+NGc4OXP4Hy6+QjWKSLoEeuTZdzGROSFqbQXCB4l7swDJ
 pBRFkHqi556WRj15h9iHuVOLo1d+9csmcs+6rB6/sPc+IYta5qvqDQvByffdx6uzEvb/stuy+KL
 RDvSiU/GL2ztQdmZSGuprgN8fYmCNpednQdl8WAVhc6dG5uRnusMl5cji1zuMEia3tCZGdv2
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=684155bf cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=zZdbXEcupTeRExCOI60A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050074

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



Return-Path: <linux-pci+bounces-43220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCECC8CBA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B1DD30579A4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080634DB53;
	Wed, 17 Dec 2025 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U60rIXl1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRR2lyki"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E734D4E2
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988389; cv=none; b=YaXkxcV9PFqQqhPV+U1N/6VSEcuIBGmjhrL83vliHE9tqnnL5xV4Ork/L6AhF6oKGz59HffPJtaS3Tgggqd9kSgMxisuxs+S+0P5TDucs/U/pGxGIsyXRPP2Y2uhRYGL05I8ReTfmHDkHqLqDXSsk/inU861xSL54AjU3fBR0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988389; c=relaxed/simple;
	bh=X2WjbqSMKIHdODzRlYp1Zh7d8krI26AQDQ8zCc7GDn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx0zQtSwvrjrWvMMTYmamkv3VTVkzTXoJHggaSiBsyXpM7jLCf1y4UNxf6akWoZjnbJ9dvQRp38hX3HYeKHILcSQIT8fTYjPZ8y8rKjePLiarxd546I3TH2dlqDGqUUpFE6IPr7ZNGL/BSwfOveL9IReyNUxKR1v6agRNdV2Wyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U60rIXl1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TRR2lyki; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCL9I63002293
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uVLs+KRrLIALpA0CvJSphRb7a3JC4XUYap9lokNywfM=; b=U60rIXl1hkPORA06
	3WvoXWiF6QbbV2nj7NMnvKacp02/WJpodu8NAJAggQdoWciyDmJmZ9VFGu8ywhTD
	i1+4ERE9B+MBkBfRyRsKSK55idQdCETLAKwymr+RoQBE/zmlH0kz7D+hvnS6JUFD
	qk67hFgDtO82qcx/NTG6/NbEd21NDH3EL/enNYkAn63cGWUyMooCinavV8pw5Wl2
	Rt4vIspgddDdYX4/49WMufHTdnXs5qTxQBG0IWiogBt7sZcFca83jN1D1qb67sxy
	2qu/UI6oAtq/jIkDK8yFhZg61lG9aXrvJNkMJckb2CHnr1kkQ5glKc1kj+yGzUb1
	tKg+Bw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3n332aj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee1b7293e7so199935241cf.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765988385; x=1766593185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVLs+KRrLIALpA0CvJSphRb7a3JC4XUYap9lokNywfM=;
        b=TRR2lykifBKpLKrJHOnvJIRIdeKn48NbFgf89Jjp/rWh7zci6T38Qmx5rWHrSQ3cZ4
         LcFr9OmJKK4SX0+K0QYybqBn9tUzEDIzR9ePStv4HZcwm7boG8+WjZdrec18jz8sUEuy
         UlUk7ksgy5wQZqqowq/0bZraXsEz2dguRH12w8UPzCKNOsPPOIDvDBiX6yQpRP/8VWeu
         1j5fh1ChiUo/cYovCdgEYGgqyoenE+81UsDw/sXoevZNOIx/+GCEEeBwR9s2bCU/OEGW
         nvmKih1CKmXrytoMc5aRJrXp90dl2gDABJ+g8LYzue0pUPa2rg8NBiFCBSnKYDWZNkeu
         KKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988385; x=1766593185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uVLs+KRrLIALpA0CvJSphRb7a3JC4XUYap9lokNywfM=;
        b=ED6iZ0nTN7SAjdhAlHhP5paQLTpe/J1Op9qAqdJFv0/HqVUfL5SosOYxpuiwFaus6i
         xM/e3dqVbaHiwyhIkcUod/9SlxmkccCS3zRFHTw/PKToIis1b1hXivrRHb9D812vhfSx
         thV/RegwsE6QOATk6qMTu0xLB8JPZWwm+zqf7K+ce2K7pI/qnxTK6+zUD56AkqjveZ4A
         qN9saAyhnoFZSk9zQJunT6sVZOzo/E9j2cgS5nKz1/ojYO3qNQsRbGaMDIzu3wUH+aKZ
         obAc+elrCCHbP4oiOs2CYWCFdrUPUd+M3lRiG4hOYwO7gyjL0GRdgofUhHCsd4hf9LDB
         Q/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXB5K4c2SsKtJKt3JJmNUCy+wK5OBdZWp/3SSU+93LJ7FIiC6ejmz+/42PV6P8cv6+rLNG9c4ApOXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGs4WirmG3KBAOu8i5j3HbJYwHoenZPL2b3EtK8CaptqQyKMnd
	wYzVn7KJpjvK7M3Wl+32/wD2rovzGnwBWCr6sVXQxZdWtnI52mzMiDoxxX+fzCl48g4byPlRsQK
	xKZipNd751Pon+CaTGMZqcuRbyrJMXYpq+Dg98dxBGyQEg9m8cl6jNGJl7A0PxhI=
X-Gm-Gg: AY/fxX5unCz3KuzNcyiblBAqqsyAY5LSQIZJMrjSuwUuiUbhc3YRXq8nj5lry6bmt6g
	H56VvfugxcGMZvr/wtZgYkgXTZOlHcsI9ETLzBcF2yap6hR5a6gVvqYB/K0Uts7sfMxTkylRE8t
	zrltL4qje4z4sgOPp8CiCLjeMG1phkCpHHive+ZS1v74gBDjDfLiDgj6TtUhy9hB4uhqMlZhHPz
	lZE88bAfQql09bvV0ow0hvshuQSDRRb8c6PhPKs1BphfUlyg/GHy+rATdZ4AYXt+awxdOqxW99A
	Gkm2zV0pRGfv58CWXBky5ND0yEdeMAlw96hY4CcjWJA+tyCk9BqJXPTQy4QBWwt3WeBi3U3eZ8Z
	7kdPbJn/hWmk89ujI4UsUglBKaeGa8+zi
X-Received: by 2002:a05:622a:1e8e:b0:4ed:b441:d866 with SMTP id d75a77b69052e-4f1d05fcb76mr251114831cf.65.1765988385430;
        Wed, 17 Dec 2025 08:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBPDcxWde60PwU3M4SitdXmJ33mRfEM+V0oKYO8+w4QjzwiQ4ik0pO0n/N0kov9LvEj2NtMA==
X-Received: by 2002:a05:622a:1e8e:b0:4ed:b441:d866 with SMTP id d75a77b69052e-4f1d05fcb76mr251113861cf.65.1765988384420;
        Wed, 17 Dec 2025 08:19:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1987868666b.10.2025.12.17.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:19:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 17:19:17 +0100
Subject: [PATCH v2 11/12] dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-pci-qcom-v2-11-873721599754@oss.qualcomm.com>
References: <20251217-dt-bindings-pci-qcom-v2-0-873721599754@oss.qualcomm.com>
In-Reply-To: <20251217-dt-bindings-pci-qcom-v2-0-873721599754@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8360;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=X2WjbqSMKIHdODzRlYp1Zh7d8krI26AQDQ8zCc7GDn4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtgF+80PGRZh4ZcDUSsFlR57fDthMMCHobVZa
 liRR0em2GGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULYBQAKCRDBN2bmhouD
 18/uEACD/hnhoGJK4tOQp84LQEzUz1op6WqpnsB19gE78NnzIAMrpTlq8ZuLvcCYKUd1kA+sAlX
 W44gJ3X150nNEMViQxazRADVMI5KBtHQ6r8XXDwUArR7Xb9u1WfHz4xHBlMIOHDdQR3iVT9jLwe
 RNHv0IFQFFUw1xKpSxnw4asBzzgMPGCjgzCRedzs9KhSd4G5K25QttunJjWTbYkFBuX8LFzk49s
 l4Xv332TnTvonffigOQa9HgLwm7B6q8O2Z6IG1rFBf4QmNH5dy/8jgtiGo3+grdPy2gGnrB/BKB
 fyE/lxbb+dYVzIVCigisC18bdcdBnieRra6vEmOpfB90k3WwjYL5Og1SJAqJPvyo9KB2xBA9auM
 6ojNJwuxj6Fm8+dzIcE1H2xLOQTSE2cD+Sct4asLYIiqd2G+WV378zuTamGyH5ItTURn+z8RQAw
 pjvifYgiDMl2IlX1Cvt4JtCEUonqdk16p9xBaWg3ltVHiyPhctISIoIL8UQGyTCruupc8CWmVGJ
 6PT4LNsz/tDVLATIV0CEMyXhszuED07LKerFzDwm2/0QeYxGDhkOx9Ty4TAH6xO2Ia2IVHIYHEa
 T/VhqnFbEdegP2vvxSwIwyD157cREajFHZ3G3NguRPH/Ij53GfVFK7A1J41tS24djiw1Ob/HdbG
 CH+pBvxzcrVm7yA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyOCBTYWx0ZWRfX+bsXo2j8Hyb4
 mE1xRm3apu5nD3D9XCLNGmpyN3cOMLyA18O+Nyfyu9pRvfoQpS+5GRMvvbUQc+U8KSZ1HY9o1VR
 F392oGLRZJqhw+i3yh0maDQETVxbhwlqbcsTx+c0k5y6lHY3AvFMxLXNcw98K2l5KBJTKa3QRwN
 /ogL//oqjUZ+MbtMFv/48wulnSmPT/XPGm6EQVXvSjLiDwoxlZodN0Nra4B7PVno/nL7VtOxoQ6
 Szacgdn5mkzb9B+KdKuVh3mIMWvXal6C6lacy1uLveedX5/+ceNRsZtJZ+gGnhmH5vVgx/NJIc4
 X9eqDjCZqnYF/TXpHpNWCyIUSVhDvDruz+Zir01rljh4tuyUzRFqN4G/uWJbXZDVYFmKFpHIMLH
 RItbbDMXkZ3+eRfOpeZ/Zs23s4uwbQ==
X-Proofpoint-GUID: iAWoxPFBAOxIe-kRwV6AgzrHKOXO7QZ8
X-Proofpoint-ORIG-GUID: iAWoxPFBAOxIe-kRwV6AgzrHKOXO7QZ8
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=6942d822 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=IKDxjynl_XDzIR9_nSAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170128

Move MSM8996 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Expecting eight MSI interrupts and one global, instead of only one,
   which was incomplete hardware description.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-msm8996.yaml | 156 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  61 --------
 2 files changed, 156 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml
new file mode 100644
index 000000000000..f2081ae1593f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-msm8996.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8996 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,pcie-msm8996
+      - items:
+          - const: qcom,pcie-msm8998
+          - const: qcom,pcie-msm8996
+
+  reg:
+    minItems: 4
+    maxItems: 5
+
+  reg-names:
+    minItems: 4
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: config
+      - const: mhi
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: pipe # Pipe Clock driving internal logic
+      - const: aux
+      - const: cfg
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+
+  interrupts:
+    minItems: 8
+    maxItems: 9
+
+  interrupt-names:
+    minItems: 8
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: global
+
+  vdda-supply:
+    description: A phandle to the core analog power supply
+
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
+required:
+  - power-domains
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@600000 {
+        compatible = "qcom,pcie-msm8996";
+        reg = <0x00600000 0x2000>,
+              <0x0c000000 0xf1d>,
+              <0x0c000f20 0xa8>,
+              <0x0c100000 0x100000>;
+        reg-names = "parf", "dbi", "elbi", "config";
+        ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+                 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+
+        device_type = "pci";
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        linux,pci-domain = <0>;
+
+        clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+                 <&gcc GCC_PCIE_0_AUX_CLK>,
+                 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+        clock-names = "pipe",
+                     "aux",
+                     "cfg",
+                     "bus_master",
+                     "bus_slave";
+
+        interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&pcie0_state_on>;
+        pinctrl-1 = <&pcie0_state_off>;
+
+        phys = <&pciephy_0>;
+        phy-names = "pciephy";
+
+        power-domains = <&gcc PCIE0_GDSC>;
+
+        perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+        vddpe-3v3-supply = <&wlan_en>;
+        vdda-supply = <&vreg_l28a_0p925>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index c9b41c2254b1..0d3b49485505 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -19,10 +19,6 @@ properties:
     oneOf:
       - enum:
           - qcom,pcie-apq8084
-          - qcom,pcie-msm8996
-      - items:
-          - const: qcom,pcie-msm8998
-          - const: qcom,pcie-msm8996
 
   reg:
     minItems: 4
@@ -75,9 +71,6 @@ properties:
   vdda-supply:
     description: A phandle to the core analog power supply
 
-  vddpe-3v3-supply:
-    description: A phandle to the PCIe endpoint power supply
-
   phys:
     maxItems: 1
 
@@ -124,7 +117,6 @@ allOf:
           contains:
             enum:
               - qcom,pcie-apq8084
-              - qcom,pcie-msm8996
     then:
       properties:
         reg:
@@ -162,27 +154,6 @@ allOf:
           items:
             - const: core # Core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-msm8996
-    then:
-      properties:
-        clocks:
-          minItems: 5
-          maxItems: 5
-        clock-names:
-          items:
-            - const: pipe # Pipe Clock driving internal logic
-            - const: aux # Auxiliary (AUX) clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-        resets: false
-        reset-names: false
-
   - if:
       not:
         properties:
@@ -195,38 +166,6 @@ allOf:
         - resets
         - reset-names
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-msm8996
-              - qcom,pcie-msm8998
-    then:
-      oneOf:
-        - properties:
-            interrupts:
-              maxItems: 1
-            interrupt-names:
-              items:
-                - const: msi
-        - properties:
-            interrupts:
-              minItems: 8
-              maxItems: 9
-            interrupt-names:
-              minItems: 8
-              items:
-                - const: msi0
-                - const: msi1
-                - const: msi2
-                - const: msi3
-                - const: msi4
-                - const: msi5
-                - const: msi6
-                - const: msi7
-                - const: global
-
   - if:
       properties:
         compatible:

-- 
2.51.0



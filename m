Return-Path: <linux-pci+bounces-43126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 496B5CC3594
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DA0F300EA05
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1143590A6;
	Tue, 16 Dec 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jquW4tpA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqkkG1dg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61038346FBC
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892973; cv=none; b=SUV6S8fG9Y6LAJfGO7CRPnjqZ0Qg2K53BvKunywDveBsMfbwNrdoiWagVYfSNdyKKVPYbyyt0hlncda8KgctPInpLHD8vWRI/aJ5XDQOzOE4goc9nUQdH1BioF96gICPdqsRc+P/BfPBNDTAlberINRV7ISS7QB7KLCtCGOG4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892973; c=relaxed/simple;
	bh=c4FFwDxKmm7Viy1qgmx4f9Kwxu7zWPYcOsV/EyMcA3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UY3w1DhekOCpxbs6tgztuBaELH4cN8JaRmosGnbssPqiRjjaqbfW6rWRXcBvwoOO/oNAsdBjkC73djCmw5yGlrOcUrRFNQY9Zd+VWwMD7r2fqNbNHl+6ZDWiAeyo/c0CwtQ4Jfh96TyEgyhBd/fG/AkILGCxm7vei3u5Od8HjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jquW4tpA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GqkkG1dg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGD9r6l2573323
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XIeEwdaKSmwUKhVRwes28nlFxirSYBP0M2N+FYQE2U=; b=jquW4tpATXWbpnAV
	FA/3VFH1M3BQt9IjEde18yF36vUbR5rQpjFlEWD6T23VHtrYS0UvjpdMjl7DoNif
	NGU+THvYrE0wTZ6MWUfwMBaf6ZTpqg+61xLsJr6Tmv/cRnhQnfZut6jfjM788tSk
	z0kmaWJH3aQYSSo+BTgNebzqzg2tnQFeE/CgXegs0t8gEKlCwXz7dDERyv3a+wzK
	pQmJPnofoIgznEqpKa1xBolYkUy+gEhFMurjmqsZm6Zuz0s04q+f9h8QXbIDy0UE
	WLAl4xd3h2rBRHaqL3gydILEaUXj5KgomUSBw1LJyvoKmd6xHCE4h3Qx2V6E696S
	eWmSBw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33thsc9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a08cbeb87eso38037835ad.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765892971; x=1766497771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XIeEwdaKSmwUKhVRwes28nlFxirSYBP0M2N+FYQE2U=;
        b=GqkkG1dgVqYuTUOu2Rb0JrYg3EejUTepADvMg4S3RppZzHd6qMvNJlaVW+ckrNu2uv
         EbOk/fxGskB91qUWsXsFhkPlNS9nq2kjb9fP8E3Z+Wz3KXuRcPSAGEPh667GHtzjAfyP
         GWZoQncPbKi0nKMGbWQ3ahTXbEX0F0O8PE9Tq28BLgR3wseO2VRNPP4xEcOMWA4XjBnw
         Tng86IBZ6+qzDewUXvl69K5DEIkPgbFpR/IDqmSeqI3T1QBWAdOejZUjt4WfrAACGJPI
         /3DPyJsXUmSHDZdX0eZ7A3MVV9Ey6UolG6fEH6PJMNozRIjPc8NmnefBgCJbCb+N7A9u
         ViQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892971; x=1766497771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5XIeEwdaKSmwUKhVRwes28nlFxirSYBP0M2N+FYQE2U=;
        b=fZhnk9w9tlB1RYmkz88iEc1RzFvgdrbgVrRMqxz5Xbl1+kvI+6oFFQdnuXXvudILsc
         ecPo93anHCdNoJe2CNJtm13UDXlAYB98fmJHemgOx45AZe/A2G4Pga/A1CSoTobvheAQ
         G9TAO9647L3MaCEE+5yhwke8nFTmCET2D8CCczkeHdotk0TBsi5epdumlgu5McH4sKry
         N98oa3N8ZqlFeFX4+cawUH39Ur67aawizZ4elww7ZyfeI36uwmaBLyJy8diJ9LL/fm48
         oSedY1+htr3EF4Gtiqprrz/ubrnKP1NppWh/dGSvisCLXjiqQDAE6p9q3vdW18MQmO7S
         Nm3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+lwg8y9zNl4O8VgUuyP0LMhPFWHDnW6xJ268tP6kyX7CggZk9+EH+0mUwSYR06Ydj4/SlRvnJDTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQBInhLpOb5S+ga5xew/CSgf3ZcFsW0q4e05pS9UnkzZqXwMn
	2i32fF+WQFolg/IjSwOPwdQJkmkCvCetr6A/1FxETEnol/U/ip5aWEC9qhUaapBw1xxh63rOhKB
	6qN8QerVZID+VqlsnIi/IkSZ/7UGTLLWk/3RbcxPPA//Ha76LGxrB26SBCtAbi8s=
X-Gm-Gg: AY/fxX5SgXcC5qDyJggFh1dtZacWYwoD9hEIzMdBrDQdeBJKU3PooyP83En5PZ0ksvy
	YUKk7ANWiD77t2/OIus8q3OiIS4HVRAjcVDvhHwDk+JEsLHgmxZ/pz+l4TBC8d28bvT+U4BsVIp
	Isyti/cnzaXkvUK0OyFp4moSQxY53LgLmmR7s+C4CAYSNGGRH6arN66pUhNoYkiWSdkcWb6SRQF
	jfpZrubBSwYyC5O9Mms7hEP4LbLJ3x2Fm23iOOZ33bjLdG2KA0VKO3J5YG+nIASKJmC+2t3QbAn
	HxEPhBGMkhsiEyFrEg5/XsjkLa7gxVdvfv/6aktbQ3CQZFyjhiXrPKI0TNkDGcQ3OPlmXgYP3c9
	kCM97KWuO3Y9zPARq97NptwcJ4XAit83l5yIFx3lWVkM=
X-Received: by 2002:a17:902:f612:b0:2a0:ccee:b350 with SMTP id d9443c01a7336-2a0cceebc96mr83993425ad.58.1765892970697;
        Tue, 16 Dec 2025 05:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0I2m3AUrFktxRdsW8oXiDacvT1fHbe8STll0ZhCKYN0uLRfQfttLiE9BN6uw7AZAwioU3BQ==
X-Received: by 2002:a17:902:f612:b0:2a0:ccee:b350 with SMTP id d9443c01a7336-2a0cceebc96mr83992975ad.58.1765892970151;
        Tue, 16 Dec 2025 05:49:30 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0993ab61dsm99697165ad.46.2025.12.16.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:49:29 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 19:19:17 +0530
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-firmware_managed_ep-v2-1-7a731327307f@oss.qualcomm.com>
References: <20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com>
In-Reply-To: <20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765892958; l=3868;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=c4FFwDxKmm7Viy1qgmx4f9Kwxu7zWPYcOsV/EyMcA3s=;
 b=jCHtdBtffAxpeTUhtrWvDTVASY338tchL1PwotlFzI5KJkvrM05jcUl+Btfg6lzMXRlR0a7qa
 JhAu1Q5RW+dBq25aJ7wdqTJ//6GbggGDnq1gd3qdDYpAfye0c6FrNha
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Authority-Analysis: v=2.4 cv=ZIPaWH7b c=1 sm=1 tr=0 ts=6941636b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=avnAaoOVoNrTWVjlPhgA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: yET0rfDkbwdOjvQ-ddWll1CyPENedd4Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDExOCBTYWx0ZWRfX+8LsOMqowQXh
 VlKNdlEEExe1NsqiV+qmsm6m9cEzaTB0DCObQ3uCHf3asN6WMgJO+RfpStNpgcbt/Dcvn/t3VuV
 bPnEfX+OpBK+xbnafI8Zth9hWjL+vYdTA9p4UBUTjehUseQeToxr9eP89fpgRcOazMcjWHpPVKJ
 pxShKDcESow0ZbPuuJU4/gph+efFWNI5qUxF9Cj1PDTKNNq7ODeSpKbQ1gE2QQHSspWxUzO1bqM
 mNL82bSBVJCW6qX2jlw2g7ST1/YgmkW/DbEpO5ZHj1BaHskOaqxiGFhUncFSvrMHNn6Nw8pTXSR
 0S92RfTwTjQ6a8Ay3hvre2YSvCtIl7QSSvUKcy0g0dF7Orlt5jpy6JxNVTvtjkEA6ZfK8YqyD7m
 pGexWzXQzSj20iya4FP19J3YH8zXZg==
X-Proofpoint-ORIG-GUID: yET0rfDkbwdOjvQ-ddWll1CyPENedd4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160118

Document the required configuration to enable the PCIe Endpoint controller
on SA8255p which is managed by firmware using power-domain based handling.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
 .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a88c39b7f8b8bc0cfdf4e62678b8ad89f2043031
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ep-sa8255p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm firmware managed PCIe Endpoint Controller
+
+description:
+  Qualcomm SA8255p SoC PCIe endpoint controller is based on the Synopsys
+  DesignWare PCIe IP which is managed by firmware.
+
+maintainers:
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    const: qcom,pcie-ep-sa8255p
+
+  reg:
+    items:
+      - description: Qualcomm-specific PARF configuration registers
+      - description: DesignWare PCIe registers
+      - description: External local bus interface registers
+      - description: Address Translation Unit (ATU) registers
+      - description: Memory region used to map remote RC address space
+      - description: BAR memory region
+      - description: DMA register space
+
+  reg-names:
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: addr_space
+      - const: mmio
+      - const: dma
+
+  interrupts:
+    items:
+      - description: PCIe Global interrupt
+      - description: PCIe Doorbell interrupt
+      - description: DMA interrupt
+
+  interrupt-names:
+    items:
+      - const: global
+      - const: doorbell
+      - const: dma
+
+  iommus:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO used as PERST# input signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO used as WAKE# output signal
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  dma-coherent: true
+
+  num-lanes:
+    default: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - reset-gpios
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie1_ep: pcie-ep@1c10000 {
+            compatible = "qcom,sa8255p-pcie-ep";
+            reg = <0x0 0x01c10000 0x0 0x3000>,
+                  <0x0 0x60000000 0x0 0xf20>,
+                  <0x0 0x60000f20 0x0 0xa8>,
+                  <0x0 0x60001000 0x0 0x4000>,
+                  <0x0 0x60200000 0x0 0x100000>,
+                  <0x0 0x01c13000 0x0 0x1000>,
+                  <0x0 0x60005000 0x0 0x2000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "addr_space", "mmio", "dma";
+            interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "global", "doorbell", "dma";
+            reset-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 5 GPIO_ACTIVE_LOW>;
+            dma-coherent;
+            iommus = <&pcie_smmu 0x80 0x7f>;
+            power-domains = <&scmi6_pd 1>;
+            num-lanes = <4>;
+        };
+    };

-- 
2.25.1



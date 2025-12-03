Return-Path: <linux-pci+bounces-42563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E1C9F20C
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 14:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E363A3CE1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7234B2F7AA2;
	Wed,  3 Dec 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YP+XQAqv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJ6wWlCW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62112DFF28
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768427; cv=none; b=VYqXKwGAeslzBmm8qrV05L8jozxuXur+sKBWdgTSOpvg63XSXxRi/aU6kM8T3Kr1Ls4Xz0KGHZ1VkxYDbTArAAWgPB19IcbPSewWC8kB7v/gBoTPWQgMsqyq+6vdZLJbuHnCnHMWHmNFXDW9pYLxCBlXaCF2tgUb1y8rv7UZiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768427; c=relaxed/simple;
	bh=NNc36LsdP5Sf/Sh+P4pWzTOufULJNwh9nH+aJTkV9xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLeU97rtQg8JTD2huwqUtNVl2A1NPv0WTRwbvFScy7Ejda/MQladFqO1aV7cXn1MSQ8IFBTP6kSuBXS5sM+YGF+hSe3J+e6GEbxPbFtLddyKgkAUD7UYwXhQ/srsJl0FwY79OvEIMn8zzpL1rUTkVun0ERVl0VgHbcPV6DOWKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YP+XQAqv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJ6wWlCW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B37Y4AY1909762
	for <linux-pci@vger.kernel.org>; Wed, 3 Dec 2025 13:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uDy47w3xn9wW2ymSLV4Sfp6HrTahu+PFDgo9mndL1mY=; b=YP+XQAqvXEA1rH+j
	emM22xJOI4e56QeP6OcxQ50pf3fZCs9bw/4bbS2uQde+DcaMsOzz3lrTlDBBORu+
	AA9/hlsjvlkWwgzAJeZWdMAh/ZtMOmuCco2SP/M0qaVoRkuMDhjAy1aM2Pq1cbbF
	7XeBjBpIDnEonF4hermbf1+EhtrbGJuB4As5XuqBR88cMaracqMb1wfZyhsqrv1x
	QtaGzKr1cAjAXkPATbq1FUxjOJl81K9dmEUZg6DC9CWot8vXfLmsu+Wn3cD+kez8
	yvfedu06X4QQEOjXAIeqr6prF72Pr2G61W1AcxJ8g8gJJs5DwjbRNMU53Uj86xLh
	z888fw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atgx3h1yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 13:27:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso11500200b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 05:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764768423; x=1765373223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDy47w3xn9wW2ymSLV4Sfp6HrTahu+PFDgo9mndL1mY=;
        b=GJ6wWlCWjJ5mvPwVRCWofDMHJKC+o6eef2XJSv0BJH/JLLv9JApo+IIaFg3i53Sj+9
         ETGk9NUpIxYzmrzI3v/AleP55T7010hV8iN1DrvpZY9yxvW1vMExHPrwQhZzu7Ql+DGs
         hXwW2saadCze8Se9BTm3gFZUC2glKRNCPFx+3D9WnJVFZq2wzNU3wRFameh8yRNTvDE7
         Dd04NWXpGbMOwO8yOU4Kf1er8KrOcrcCcfjQHGtiq3YgSgBSbjSpvsZJ8ca56u4hX7QU
         4KPUam7qUiPRnCCC7URNOrUQDxBgsZVTr+KZiFma2M7Pm26ravOQw3eICOHpTCZPMw8v
         XZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764768423; x=1765373223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDy47w3xn9wW2ymSLV4Sfp6HrTahu+PFDgo9mndL1mY=;
        b=VfWImo79oh3+Kds8Ushftzus5RQz4LM5sACUOT0Y84xBJFrLeI2+Fm4EsVMJLrPww3
         JqKt7IHpkwRZBy34GOQvfAXyIhsQCzZZMhxdrXXuqbZf746WjzUvvZ0+uwOxR3JuNs/Z
         GVhfxA04yHqMRr7xN8FdtnEJ163/DqwhLAqf5CEyaVc2b7w4zXruAhrSnejN2YfIi5Ek
         xH3+p57Ay1LmO900Z8DGAp3POh3AMtIAGOpMUcy9wjZ6Cmq5e7+6J/+0tpu09Za/nSRv
         u43oTTtWlWELV5vlHS7WRAvhsGHobrtKeSFX894Xi0wy08nhJDT5cuwpTrtGDt+hsvdN
         EmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWosnptk9NqXxWZ7bVz2fEyHOW/hhGn/4lYMV84c3AReYpxUHOPbW/gtExRY4rhNU+T8lHiu+cSFx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOYL2AUR40GmM7+QtE5Ym9csV/2ufFd+nD0NweKJZspARi4qP
	vhe7/Oq1gdxgYKOh2EK9WVrl5LKyeR7UdoqmTBd+1nQKYfZY1UFTqLLMGRwPVn4R1+TgjNyA/Wm
	E67+RvrvHgBYQydc73FAw21YxhADsk04IQ9J80UFJGLoihHXFY7weXq/ZUIKBKG4=
X-Gm-Gg: ASbGncvnz7veaMrgR5GFz6C2VDVxzaytj9Ooa9+QSYz437wjYxVXpe2CUoQbMHkDBd6
	eDWr5c+AHOPl3kOm4S3GBjO7TALm+H40JBNnYrJKXfyUfsm7911CQZqd6XOcJYeKnQRGDe0vtIe
	uE+5BgMwySTCd1mhTUxXgFF+QRmGeEOBLWKld7ZS2Cx12TD9rLL/fjV54ZRLki6lGolj7gZ1sac
	riIWrqzqtjMN7AxxumihhihvAC4CMh280G4Q2Qy2tBUH5eSt4cEjJqS7fdVCEf4r94IhO4SoMMy
	76EgrmeevF9Qf0LitjozPL/O8VBtwVrgTmrVqhx5OQfC4UwhL18mwqnyYb2bHM9y7jhGZWswU2r
	5UNwuWfdZzg/kBWXaCl+wNNv8nbYg4/ihxsplPYowrA8=
X-Received: by 2002:a05:6a00:3997:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7e00d9f1159mr2905633b3a.18.1764768423087;
        Wed, 03 Dec 2025 05:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3XWwRERuATrIUZCSdcB+/sIIpWZxxTyj2tL66l6kLmoEFxK0f5zm0a6z6wxREpXe72xyS6Q==
X-Received: by 2002:a05:6a00:3997:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7e00d9f1159mr2905595b3a.18.1764768422586;
        Wed, 03 Dec 2025 05:27:02 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e6e6e06sm20287524b3a.43.2025.12.03.05.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:27:02 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Wed, 03 Dec 2025 18:56:47 +0530
Subject: [PATCH 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-firmware_managed_ep-v1-1-295977600fa5@oss.qualcomm.com>
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
In-Reply-To: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764768410; l=3940;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=NNc36LsdP5Sf/Sh+P4pWzTOufULJNwh9nH+aJTkV9xI=;
 b=HiCJ3Fl8IFEM+UrqtTkUmEmPs9kOd1R/nCNE9OLGPFWL3jjEBxeLf5lQThy+R7ZRcRJF+nfon
 Dor8rwhGev1D/1cg2Z0p/PMG6QGxvOxQM8ZnIoqY0Z0HpVEDRyZursA
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEwNyBTYWx0ZWRfX5ahFtB8ONmrH
 0QI0yHPW3AIw5yeCwITV3YEkux4wa3wTgGdry1DyNNDQKOYtRzHC2t7mE1cFG06rMWBBncMig/t
 fPPoK1A5fD3SiP391Ump9rxxsGnzhJsf97VSS7qxSGQmxIUMIdu0MTUErCoH/ogwjON+9XTtQZV
 /RhoeReeLY8eYDXbCHcvP+WKLMiHsTQtL+DzLdGvF15qhAvkII5S0beKo3fxy1BVFzcp8w4KYlP
 7r3f07Iu+BJTxMf5MFG/ZlgrjIG31pS3JHbZ0LPmCk9wm59/G+XXnrMQuqXmoaTbmwHa2M25I86
 whvOEScVjymendy4JHl2n0giJfjni8FZ/9MMPnHTgAa2l0exfMuR0+5EhsnQmcHShW5jMaCei/f
 OPnAvGaqDbxGNSLJd4IR7ArZiwYZ6g==
X-Proofpoint-GUID: uA4YgLohmc8uJNr7AcTYOa5cLDkXqraP
X-Proofpoint-ORIG-GUID: uA4YgLohmc8uJNr7AcTYOa5cLDkXqraP
X-Authority-Analysis: v=2.4 cv=R/QO2NRX c=1 sm=1 tr=0 ts=69303aa8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=avnAaoOVoNrTWVjlPhgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030107

Document the required configuration to enable the PCIe Endpoint controller
on SA8255p which is managed by firmware using power-domain based handling.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
 .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..970f65d46c8e2fa4c44665cb7a346dea1dc9e06a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
@@ -0,0 +1,114 @@
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
+    const: qcom,sa8255p-pcie-ep
+
+  reg:
+    minItems: 6
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
+    minItems: 6
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
+    minItems: 2
+    items:
+      - description: PCIe Global interrupt
+      - description: PCIe Doorbell interrupt
+      - description: DMA interrupt
+
+  interrupt-names:
+    minItems: 2
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



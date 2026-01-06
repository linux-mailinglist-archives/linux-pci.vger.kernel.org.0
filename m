Return-Path: <linux-pci+bounces-44099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634ECF855A
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD3DA302A471
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9832D42B;
	Tue,  6 Jan 2026 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/W1YzTl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="esC/h1T0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26232BF49
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702914; cv=none; b=MVkOzPqzVy3B0MA68Ki4bd6OQT45mhtPqTXMJy5bSufmKmkPQ+PTNyjz9U987hcRVKU08TxeExS2CgzUhYWnuioM5nJU46AIEi2rCakY7YCIzgeHm0aC9hPAktgGuq3lZ5AEyLJiNcNkkl5pAEz9xJjB1rZ+oV280NTvKrr81iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702914; c=relaxed/simple;
	bh=zUnjg5STwT2JcN7sapEyt9FKEu5Sav3x2pxp2wVNl+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcW2Xt69hUZip2fiK6oDqW2ISJ8HgzpRmgYTTe+D2qvjyKp6g/iFeImXD11x8fzeTizcT1G/5EiYjS0CT+veiJ/X7B7TAj4aaV6NytpxEz2LuFRZM+ugWu7yEL16pQUKD/KuGtsELrZzfnRpAWdIS35fSrxmTdoXG6NIdgqw8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/W1YzTl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=esC/h1T0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606B2DXf2684789
	for <linux-pci@vger.kernel.org>; Tue, 6 Jan 2026 12:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yii7HJwaI90HAG/Tr2RZQ4/4GgSOzXggxzDrx1pXU7I=; b=e/W1YzTlmBX2mnVQ
	bv8cMkcRXyjRMFDS7UBW9Qf+kKPE7u1+EHAsN6XJC8UAjHTcRS5uTHiMNF1niGjX
	/Je8yATI6Fve7nKlyZwP4z8vugHBpaewXg1KMnM6Y1iQ36UfgH0ERp6COxArQcQI
	w7XS91naTI0MvYqAhoH8dlvpK6sTRHHLMPpfDf0d0NM47mYZIMVf9334PmoPEo32
	T0C30iRls7h1LoxMh8vmLLrsHY4U0vKsg3uvVp4HWUmFyX4j/HX6mQA0NoVx8PJk
	pSYH4XpvSCyVq7ENIUsq57F1TEq4JLX6cS568ZCDKQJzLdaohKbrItshGaLze3nC
	+McfPA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgty5hce3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 12:35:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7aa148105a2so956062b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767702910; x=1768307710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yii7HJwaI90HAG/Tr2RZQ4/4GgSOzXggxzDrx1pXU7I=;
        b=esC/h1T0EAWtDE366Nd8Un/+Wh1H9d1qR+8Ug1mAL7wWom2mUQ3pMRjMU7+hrdiM81
         jFVp+T7OYt1BCqKcG4UBWzW2QwJGnEJQehFMyJ2R/MxVSY3rzrv8nTBhZvnoGjdCJmX1
         5HilmTu8TYTO0PJq+AMBNQLbuQZtZWbWgf02mWq6KSq7RHYFyfusixHcrOk908ffbINM
         p8F4khk4Qb4hRLQa3u5LFZWk1acHipmUzwnbyM7/NBGlxivxuP0UgVUMTZZj6xVXqcjp
         p9lzoOBTKNei8LPEF+hwF0d6e7zCXuL8OdEhn8tEtMH7gqkLYNQN1v9n6hBTHmaLU9s0
         1l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702910; x=1768307710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yii7HJwaI90HAG/Tr2RZQ4/4GgSOzXggxzDrx1pXU7I=;
        b=Xzsv7s3A6mtZkh4mYKJXieXQE3BTACIY9NeccYmo1v4KlrFpj3AHPVufIF19Hh66d1
         AQ5ogL7M009lqgJPUhFDVlksplnYMCIxA1UWI9RS6yzYQVo3ax2iJmVnuuZhxV7x/DI1
         4IcV+LYDuVwlRvWG3HJGFrsc5ZkhEp4x+sNqnp5DF8BBGFIIUhicrRjf6K5IUdkrR62k
         znfhgknkgERudw6m0cYikwpTE5n5/z5cK1h9p/271G+MmBqmnwfvThKEmtAGiPksxOF5
         AzXbuUMQaHVcVFqucdrpz904tVB4twb04mYnlvCE3kqU04V76dT/tdEDKC5r2KJ9kob/
         Ha/g==
X-Forwarded-Encrypted: i=1; AJvYcCVMS0uIBwSaQnsY00eklvJZHvIiEK06f3Ie+SFyolIksXu5gtG+Hks2RLobBFR0Xkw36pCPXVvq49c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYpRV3sRBjf+QWlJ9/kYYFHycGMvWk84gmyyVF5Ug0KW8zDsQ
	JoGDUY0zkne5XMAJ63CiU0oH8C0NNJPjH1uTplkRInxuL1dbzVNPAZLYThzwRR7cAhK0+UIFxzc
	Qx3jO+sunv7Ath6BNaxP8h906aDrHALMvSrtQNjmLeb5CMg+G3K7HYbEQ77evH6o=
X-Gm-Gg: AY/fxX6vMMe6cSdvt1rtNXsGb1w/n39JOTkOkQo9cgre6V1culAdWccCqxKYiNxhvXm
	XZ0jNLKSSUmgxQ/hM3JLfPRBHoDhE3Xhurf7n73hu7ymj4ZpqQRlrPtV8+4+T1d+lKKnGz58VNJ
	hAn4NXp/sZSzQ2AP5W+66K8ZDlgdfAkruW0ECLLMpHB408lQrHnXTOyLDsILaK56kGKCn9E32+Y
	KfkbRtlMBgTCLGGnUG6kWFcfs6nX6VwtGWJ/44pmfQH1+DAxaUukOXhg5cOHtmLhsPoMboLos2v
	CPxUMBCLG4NX/T/VI8gdOOfTiw0GsHaPxfDT1zT7Oyzdnqlo6eysZwVyktuJkbiRk++y+D7nbx/
	w7uPklrWLsipgpfqejcaX6ALhmOu6+015UyEyu2NEl0Q=
X-Received: by 2002:a05:6a00:288a:b0:7f6:2e6e:5289 with SMTP id d2e1a72fcca58-8187fd7a783mr2519526b3a.49.1767702909937;
        Tue, 06 Jan 2026 04:35:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz42Qofmrfiv1X0ozcVb2AMYtMVNQ33zWXO61I2220TjQ7Pyu2v1SgprAjnJpWs4sLmO6UgQ==
X-Received: by 2002:a05:6a00:288a:b0:7f6:2e6e:5289 with SMTP id d2e1a72fcca58-8187fd7a783mr2519495b3a.49.1767702909406;
        Tue, 06 Jan 2026 04:35:09 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e83bcsm2161583b3a.56.2026.01.06.04.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:35:08 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 18:04:45 +0530
Subject: [PATCH v5 1/2] dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document
 firmware managed PCIe endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-firmware_managed_ep-v5-1-1933432127ec@oss.qualcomm.com>
References: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
In-Reply-To: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
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
        Nitesh Gupta <quic_nitegupt@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767702896; l=3941;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=zUnjg5STwT2JcN7sapEyt9FKEu5Sav3x2pxp2wVNl+8=;
 b=QSEE7qmRpM7Gu0Mt4F7bFfUXbtjAQo29ZDWpFjXTEdvMxo52IHpKZB+LfPBKtaGZ8Q4Y4XPGb
 eKquey+bKEWCF68VO65zCYbv/abEW8sxEoiJvZe1F5lm4jnbg4pRQxJ
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwOCBTYWx0ZWRfX91ViwHZogmnt
 mX9rcNLGeYILHY8DASQewGcfoCA2T0xNaTRJKV5HEBThOrrk5i2J10x/NYlUmkrSsexIZPgs7tF
 PbUB00BZXFtXuwP1taZeWIq5eTyr/H8v594c71JR+r3n+CY7NE+AL1JS0RlFez+gox8XiQwXMXG
 9hV5t/12siVddGHD6f70gjhafXq6TcnUX0RKV8PMCxXKas3MPnuxz0GLtP+T9VM9mektFXT/V2l
 QN2L8Cn4je7/jXIyW/vcU5DLDkfMzkPb5gLTWeOOoiujrW/z2gSkz9zT+4ItnLw5ZQkB3VpqzMw
 f3indArQqHr7PT7Wi0maquiKNJZ/ULrii7XXHYAxCuJ3OJnKmZNXweYzw5v9bsP1HcaFOp62Bmq
 rQnB6g/88nna8rSG1fsm/tCftaGdJW2xLRPkA0F+QzhQPI19GrGu+oaLO8/u6zIbwxdmZrI4Ezs
 Oj8QOIDuf3ZUX3qkZ6g==
X-Authority-Analysis: v=2.4 cv=Rfidyltv c=1 sm=1 tr=0 ts=695d017f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=avnAaoOVoNrTWVjlPhgA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: yOJSjVisOGV-g4DHROIP11AYz43Y99Ho
X-Proofpoint-ORIG-GUID: yOJSjVisOGV-g4DHROIP11AYz43Y99Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060108

Document the required configuration to enable the PCIe Endpoint controller
on SA8255p which is managed by firmware using power-domain based handling.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/pci/qcom,sa8255p-pcie-ep.yaml         | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,sa8255p-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,sa8255p-pcie-ep.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e338797d5dc2f68e2ad658e7f2c073023c4aea75
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,sa8255p-pcie-ep.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,sa8255p-pcie-ep.yaml#
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



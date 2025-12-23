Return-Path: <linux-pci+bounces-43562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FFCCD88AA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A8D93019840
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DD30C36C;
	Tue, 23 Dec 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G60oct1E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jDW73+n5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43329309DB1
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481398; cv=none; b=k00jnN6kJpdPgJTlxFTcOcM67KoDBwTG+WQ8nP/TEYqJIUlSuKQlIC5FzuEtSIhna4fe/WAgNjWULBthsYtgDMil7RAcegDazI5BBvTO/Ges0hoUsmiacZX0XGQTkEDNPAsGwqBTJiVt1CDwQxt4rh+sLNmUcUMPLXcoP99DKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481398; c=relaxed/simple;
	bh=5KumP20fDI2ZbJDHb4/tO7FSR6emNSPBnijP7UxKCAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggwYiKrS7O3XVZ26N84s3SxJuRI8deDxpek1nne5+jP2ZxF/2uOu28uUGe3S/94SW9AwhGuYgs5uj8S0uWYmDhYM8bTRgVt1w3Qxv/tLT0PcktLxdPScoiWOMq7nE4OKQViQN0lG0ZZby2TS2pTvfvPdrECv35xZc4rZ3THr8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G60oct1E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jDW73+n5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN43hBf1356381
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNuj5fMI4Xpxt6s2cvQVzAdTguidM5KXUybpFV8NeYA=; b=G60oct1E5AKiarxt
	Zn0QJc8C+DvbXtCiFNVeTJW+Ggx3p2tSxg7eN2PczS3ZhRh2cahDP3jo/uyJ/cZQ
	Lh3FfhI6MKjja9Y10h1oaO3AU5f/KM9Cy4NEGkHMqmuwmuSVTlxdPheW0I3cXNw2
	xGYUI31WNFrzmAmLH1zO6nh2a7sHfbr4Mt5MwMOT4kfNFfp2PEAL/4HejFaixFvy
	uOK5noBcFu3w8UZJ04LrktzUCpFHyDVSFvLJLwifcV4LUShRONJzWNzs1VmztlX8
	Bktmg5v8PuQe7hp8Cmpg2ij+VZn1vc+XhAxJmU6W5919kUsj/RJVNBIwZb6B7G14
	yoyh2Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b78xc2ky0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13cd9a784so51502185ad.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 01:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766481395; x=1767086195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNuj5fMI4Xpxt6s2cvQVzAdTguidM5KXUybpFV8NeYA=;
        b=jDW73+n5WvQKxEgQb1+Gax0NzqPYM0CpRX+HyECvVL3NmdjCBVwUk+0LiHoAdXdPTu
         xZztMfY7T2aHzotZeADUKyaM+hmNxEa0BAW7QHEHT3/yLlvOTQcQtf0VsybWInyuxsOm
         p+wLfxvKiVZPAv+lUAMXNBUr3riN5NAH4l+fWmO1zwFM2/5lcV9Jfw+zB+cGh8QtUYLF
         03IB8oQZYTkFCblqHhIO7uXv1etag68YQsvLzcxihXEmeZ7PDxhLErarQ2Bxqr4CUvON
         jeU5tlKuLNlyT8Ey/BYG/7n0ZRoM57Ged4xXu9Kk3ox3qEN3qahDD3BrJ8dEetkqka9N
         bIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481395; x=1767086195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNuj5fMI4Xpxt6s2cvQVzAdTguidM5KXUybpFV8NeYA=;
        b=pKOV9OLldrMWtoPZ9Y/7e8ZCP8iDQXq5UxaVM3/6ZAjj0t2IyVcO/YpDUiRg1ONifB
         m2JNNYijqkigtQ9xxTzWRclQs6XUHl1FUZz8lle7NFC8TKJRk7ENrHPZlkRXfXhTxqkf
         AkUBkP8IcxykHtPLd9YDdST7xBpKSWbPMSJvv+ogUL1Hs8TXh4JNeuzFKGbm4pYZVNMK
         RXOQ4i9c6xQQfTFEiyJLbeAx4sS02jwZVsg7ne00zBvIQW9aeBrhne4mnOh4f60Qb8eD
         zX5R/uTeWlUtBLxgHj6othQ4qBIRfQKKwnck8pAFDxllKlciKuAwa8dcZabLbRVmabAB
         rUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVRLKsi4YH2eY+I0wNm6pFGMbbS7MG3a/f4TZ51GRS+mfPv6NRoy3E7ZJDkuUNcH//zyVWEXk/OUEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9xnQhK1ImXRzkUq9u67fNkYsi8eb8t2hQ62n+PhF1PIPCl1t
	HTnsXmNzisFZwmib0Hl1ncKaVn3Wm9xVGykNFijsV9SBZ2UJ55w4aemvGwII8yJAcIPKmyVkb2U
	1XSZBC3hB+XJl57g3BktJPSqp1qw3QBCOBHcqL91gsXQOaKG4f7dcrCtNPFQxFjw=
X-Gm-Gg: AY/fxX4xjoHMZJZ8k3AohT3mFNB0DIwbwOM8zI+REOi2fiWoNkRwwaRRs9TjP2C6aqL
	SynPYbvFMTzbiqGYnj++joM7hx5ifVlKdFDT1MubsndgKDM4qwQRJ8Bd+3a1cgrd0NWGxaY8B61
	eEp78a9AWHZm6ujBQL6N8zsiJU9UAAYGZkZ0B493YdLqDXbQcBhT/eDnfxqjnD9KegnNfLR9J3O
	rqfbE+N/T2Mw9qZjzkPd6ho2HGfAXWx0LyUvPoowHxCyz1qSHV1wU79Oxps8jr+mHlP2zb+bEht
	KTWGv9RUXy6LVsGdJCeOOC+nseGdwvR4O9roEbTuBdvx710XGWHv/0tPok965MUi8bAgbYhoxAw
	/qMQ4fGziaComcLPv8fX2NxZ/y0jawWVf1EKN5QP2k9k=
X-Received: by 2002:a17:902:ef0a:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2a2f2840085mr125555355ad.47.1766481395152;
        Tue, 23 Dec 2025 01:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvV0SECnt5qr2+m+UX+cGQTWDSVIgi6rAUtFKfd1ZisA+JQJTtq4hEzNrXUMisbHRIUEJB8A==
X-Received: by 2002:a17:902:ef0a:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2a2f2840085mr125554935ad.47.1766481394647;
        Tue, 23 Dec 2025 01:16:34 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ceesm122507585ad.91.2025.12.23.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:16:34 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 14:46:20 +0530
Subject: [PATCH v4 1/2] dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document
 firmware managed PCIe endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-firmware_managed_ep-v4-1-7f7c1b83d679@oss.qualcomm.com>
References: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
In-Reply-To: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766481382; l=3868;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=5KumP20fDI2ZbJDHb4/tO7FSR6emNSPBnijP7UxKCAE=;
 b=y8UTo8ea7bkyRTK9lgNPiEvbBGa2FlFKJn362J0hRNhJbymyNLIk097LtE0fO5lGxDEuW1x2c
 DWEVHqC8ZVvCFJo4T7sAyz+ng5womvaok85sMqlEUfWl8nudU+jR7CA
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-GUID: alEEqn4GwfcOPF0GyDJRO4EHJ0hg1f4Z
X-Proofpoint-ORIG-GUID: alEEqn4GwfcOPF0GyDJRO4EHJ0hg1f4Z
X-Authority-Analysis: v=2.4 cv=cuKWUl4i c=1 sm=1 tr=0 ts=694a5df4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=avnAaoOVoNrTWVjlPhgA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NCBTYWx0ZWRfX7txD0ZS0+SGr
 fDTQRiReCRSNSDwBHltQbg4a8ydwt5BZE8IFdqrA8MZVQluKJdLYEH0RTiEo1Q5NnP6fDZiRBOA
 7XjoCDjj/rCg0oXf5U4AFRnSvfSYiIbCKakG/oaSpvHZBue6ohq4E1kPmIcOTCk7I1ryu5J0sim
 JhbZLWtRX3Zdz30KvK5shFg5p3YuBN5shfCeruNqU5nBL+fofZQRj7AD39hJB7m7p89qRBrsuEU
 1rtNXl5mXdPwzwK3fFWoqVsoaX7XgtvBLKid7pn2kvLeK/66OZz69q8EkOvwTOnL79sSl9SIt54
 jJdYn81Cg6HtAwaMw7HVr88OylEdpPLwGIttY/bMWnJ0IJT4Izn0PCEWihDDk6qTf5IaHTaMArc
 UPx8bFu2c/PPEodQJzhmJfXPvD/58vvnj9sJyXbBwriKpifHevL+i4JPhLnf4GoB0qlHI+omfa5
 xkpEGJmSV7v49CCE9qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230074

Document the required configuration to enable the PCIe Endpoint controller
on SA8255p which is managed by firmware using power-domain based handling.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
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



Return-Path: <linux-pci+bounces-43217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6BCC8C27
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE4C3027DB6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C13168EE;
	Wed, 17 Dec 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYGWCkDv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3ITJc0H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6A34CFCE
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988383; cv=none; b=miJXRhOQP+dm8mfhlDqhEJlXKYKqYvSQYWdNz27xJRoXt6nC0+tVFT3Z/ub96SzYYdfqlIbwqffPmDLFn3l9ociWhatU/ZZnjMtj31I4Y2O3JeSsP2GOOFJhRWpCI+xABBD7Hn6pIrlRlSFZLX1K3sv8d6ydzB0i8pYeeXNX7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988383; c=relaxed/simple;
	bh=fwwvTAHHN2lNGk849hvRPwFvied04vmzzOv5gjzHx/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTDVR4aHj1gMHzNS1EjXJXWha2TzZstkaZJHJ3oTA2AboYPYvXmKZPP5D6B+W7NdQTwXp8viBucDq1/OZg3M6a8UG1jCHbc9DTOBGIKkt9UG7DVxBPKydVENkXADaEfQOn9pr5nV2i2yO4/gYXSOF36D6/FRjcYN3p7pZhkiSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYGWCkDv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3ITJc0H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKxRb330805
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YNmS/S8KWoU4BRwA6oCB8rj8oljkhocnlAvoPMHAqqA=; b=dYGWCkDvn2MGzUcO
	TC+9rpO/TQIiIlgX3DwE0IGwrE7Ldk0a+WyBtbi+vtesiBrfERBcOYd0UIlaheyS
	AKDpyb37t+04KZE29HGE82QsPrqUQApRKTXRE/kxUrtQiL4LTSkqwzH+ACnmdM+J
	o3qoZ7CKHhmmPR7puVIOMZmIqnZBBRSUga0jZyWc+stGM1zLjW5VvgGhd50jpIv8
	w8DSoKh08TA2b1TCv/UWQtKI2y62KUnLUfGxolznTUken+Lzf8cJ5gwDJAaoOra2
	daGgAWjaknwD1n8vz6ENT+GILAgaUPBzOzCeq63p+nnOeExJrl3dJDo5S3wrAHyM
	BdwNNQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3t8e17bg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1dea13d34so106990821cf.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 08:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765988380; x=1766593180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNmS/S8KWoU4BRwA6oCB8rj8oljkhocnlAvoPMHAqqA=;
        b=T3ITJc0HM1fvblUiCsf5p8To1HP8QX2d05mEc2F+e5m7pQ1q5vD3bHeeoK3o2erJFk
         bEL26aP37mAEjkI6pm150CrqLJpYrgZHAOYfruoNZAxmA8KUaLDg3S9Hs9IWxIY9kwFs
         A+0A1P4ut35NcEfAgzFJau/JfDbYxB7FNgz8yL3sm72mYknwHHYi7kvB2c4qoLSrlsgm
         Le3cFU4Ad76T5RHmAffgWJCUlPdCW00zFR724TmbQpA7q6M9BoGfQ7OrcnWrG4VhLcoP
         A7hpDtWcJHi092F3ujEb0D1dmTtPMITJZ3Oul7GDsx9mzsFmNlUahBViHlhYA0UoGiVV
         posg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988380; x=1766593180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YNmS/S8KWoU4BRwA6oCB8rj8oljkhocnlAvoPMHAqqA=;
        b=g8PaHH1Ip9KokKDzEvLTHQCMXGjKws2izpKsLU6U6yATrYVOzNdlG54t33ilQHJ3fB
         JJqLx34I7DGxzIzAKRRD8Uj9hD4SW3GaZiYAnHS27Yvxq1s7wlWUjAE3ESXvcy9q80hX
         WF2U63dt6BKrRI1YZ73lQ55dwvSGUo7lbIBwhrgyQhx+CYOSFvCw1mUS2klhixe310ng
         XTW0RvflPq0ltzdCXjreSPnPCNz4FALRpyjPM97FAgnqLY6P2aJHMeFP/V/YXsLfOdrv
         gBEMubA1f+AoZBscsONOEvSG1hZkCivqUamW1OGUXPlAsUrG+csiUpTjnqMnc1nhsJQF
         RVZA==
X-Forwarded-Encrypted: i=1; AJvYcCXTxfCr7VgJ2KPQFrAtxhvx6i64VskK9tO0o8jOKveDjQrLbnWVZ9Kl6SgwXMc0ICmU+cUJEM1ab8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEw7uShKlGbPb+0O0dfHG0etKRbZLj0fbguxjv4RAIQvW4gKf
	/Dqc2Tzmc0qS/oQoBWddu34uHIXHkvcfSjRahApHpivkW7kXEWMw5lVRA6CahyEJO0XOb3Eutw2
	Vbb4xYIyNx51s0s+nel6NpLzSErcMRL+cWf1nCbMjoEeF7rXO/b4LR/x9nOgPmg0=
X-Gm-Gg: AY/fxX6bNrMP/EyP0s0vnctvFZ0VUEmCyaHf2nLHsv8N/jE/s0qBafJIJdpOBFIQjWv
	K6UKDU5CaALa6suFaNljX7DsBUam1JAV3pXKeVNqV7XqIUIu5Kku6q8UbL4z+mZYXDm/ZYQYTXq
	/So6B5YapnVfRk69aQihDXOIkz9z7KxJEJwtGfgJigDGNh39BMCA9a8kj++wGa7mxIp78K338ij
	ckTM03aeFu/rqdhn3ihXHr2RKoCvzXUInkom3denuMXMkox68GX2Xrm1uIWnaqa5iTGeVyIjazg
	GdCvTKlw09u+M9jBlQ4NEEULPyJUc7L1NXF91sAqMI5MacCLSysNxGbm1wKLgU3YW4+bH9UWROw
	qs7/E171wuXyS2Ku/LX+QMdTfjwOOyzKw
X-Received: by 2002:ac8:5794:0:b0:4f1:c6c4:dbcf with SMTP id d75a77b69052e-4f1d05e1994mr216191331cf.41.1765988379720;
        Wed, 17 Dec 2025 08:19:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmuhCzE56zD6F+UM7xZpcGi6NIsSaX7ktklAxR6sjzyi/NBlIhCg3jK0eilwEQaZAVgCMf7A==
X-Received: by 2002:ac8:5794:0:b0:4f1:c6c4:dbcf with SMTP id d75a77b69052e-4f1d05e1994mr216190911cf.41.1765988379176;
        Wed, 17 Dec 2025 08:19:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1987868666b.10.2025.12.17.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:19:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 17:19:14 +0100
Subject: [PATCH v2 08/12] dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-pci-qcom-v2-8-873721599754@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7671;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fwwvTAHHN2lNGk849hvRPwFvied04vmzzOv5gjzHx/0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtgD1rVCcA6OKgbqLBy0X5JKj9KUGzSd6qjMH
 3GC9U5wna6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULYAwAKCRDBN2bmhouD
 15lwD/940NaUDyFttaPpJu37DYkQrGhbkICy3HtzUFk/FiCfHaGYiqqhVa4OewvthKwL4ycqzFB
 3hl+BKkGD8cLzJl2MxitEashYHLcuRyFePjA8ItEIWLQm3xe/B7flzAH80vD8gPb1mZbmu39zSw
 Z37n2yxvhAxoqZoQTxwr/NjiSbdtaYb/qAqkS2fcnpuCqLKLmbcx7mol5qAQ/SpyhyQ9RkjeTEK
 7WnpBsuNVWfrFcTRhP6tcfDEA/b0mvjE+CGwF8r/H6zH4pVUQsYgVpuwcuPwXXo5/5qnd8jIg1/
 r6hR0Xp4a/BliBEsKunUG0kHwWxFySE/zwt/iK8SbymaXFFU+7OuM4eCMGkmfTqHeuPfgGjpY0w
 USoU/Fo4Is4DuLIala13H7cvzqCG0nm4DuwejpSVhiujzOdKSSQD6HOCaxsWyqZ+BnvXkvKDWGH
 gDxfWnA8WcPnbFcV67f50IvfXmcNwds80GSxAV1+lPWIleJZTKDPL0k8UPxBtFvXZfekk0TPc4q
 lRg8+vYbhw/Aq/fQhhUUSsmpVgRWNOIm6/78Vjj0CVdyC5JVbsavXLjkeCGIR6YZsitsCnCGWr3
 aY4oBGJfGBAPScLaTKrMVZIBwTUK9m39tDEC8lBeZ4e1MMX5FHr5WUHXle3vIJBI+bXyD6gSFyZ
 E3qY79YgFbCHnjA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyOCBTYWx0ZWRfXx/TJU2rpfKcr
 wlgmH2xkgaBXapkl951Adf21FI6GZPufEsobifah7kMlMBch+ehSe3y9ZTsvf5tSvcFy+KytzOM
 FTCjCy9kO/vU6U/NJIEbbyxpTfIslZEL0VeHsS1gR/R18NV0Kz7FoutAaCi+Ag/GBU163SsdLdX
 NomDyNUe2tLOonarH+Ik44SnFtx+3u0crbKqQ4hitWQcTNGTxgbUKzgMoaAWSlacwDmBNuPdTf/
 ANSTAKl2dLaDdTdDUEVhzda+1GywxsiNFc8HCUvgH1iM2jRX7TnRNIGlk/hd8pIK3OdHY65lTvM
 xn9zXwjjl+/w91PrJn3ULGC2OBzOY+bA1aUKWyMkvGdOpD4hzVvRx1sYjHaYHsi20u14iPpE7dI
 w+HUYIDUDLY+vteAbZ8UcxFHXRVpPQ==
X-Proofpoint-GUID: 5JOY_JXlQmIJNnoIsn906Zcr0EklawW8
X-Proofpoint-ORIG-GUID: 5JOY_JXlQmIJNnoIsn906Zcr0EklawW8
X-Authority-Analysis: v=2.4 cv=EsHfbCcA c=1 sm=1 tr=0 ts=6942d81c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=klm9TE13DJW_JFRMJakA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170128

Move IPQ4019 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq4019.yaml | 146 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  38 ------
 2 files changed, 146 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml
new file mode 100644
index 000000000000..fd6ecd1c43a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq4019.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ4019 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq4019
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: elbi
+      - const: parf
+      - const: config
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: aux
+      - const: master_bus # Master AXI clock
+      - const: slave_bus # Slave AXI clock
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    maxItems: 12
+
+  reset-names:
+    items:
+      - const: axi_m # AXI master reset
+      - const: axi_s # AXI slave reset
+      - const: pipe
+      - const: axi_m_vmid
+      - const: axi_s_xpu
+      - const: parf
+      - const: phy
+      - const: axi_m_sticky # AXI master sticky reset
+      - const: pipe_sticky
+      - const: pwr
+      - const: ahb
+      - const: phy_ahb
+
+required:
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@40000000 {
+        compatible = "qcom,pcie-ipq4019";
+        reg = <0x40000000 0xf1d>,
+              <0x40000f20 0xa8>,
+              <0x80000 0x2000>,
+              <0x40100000 0x1000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+                 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
+
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_PCIE_AHB_CLK>,
+                 <&gcc GCC_PCIE_AXI_M_CLK>,
+                 <&gcc GCC_PCIE_AXI_S_CLK>;
+        clock-names = "aux",
+                      "master_bus",
+                      "slave_bus";
+
+        interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        resets = <&gcc PCIE_AXI_M_ARES>,
+                 <&gcc PCIE_AXI_S_ARES>,
+                 <&gcc PCIE_PIPE_ARES>,
+                 <&gcc PCIE_AXI_M_VMIDMT_ARES>,
+                 <&gcc PCIE_AXI_S_XPU_ARES>,
+                 <&gcc PCIE_PARF_XPU_ARES>,
+                 <&gcc PCIE_PHY_ARES>,
+                 <&gcc PCIE_AXI_M_STICKY_ARES>,
+                 <&gcc PCIE_PIPE_STICKY_ARES>,
+                 <&gcc PCIE_PWR_ARES>,
+                 <&gcc PCIE_AHB_ARES>,
+                 <&gcc PCIE_PHY_AHB_ARES>;
+        reset-names = "axi_m",
+                      "axi_s",
+                      "pipe",
+                      "axi_m_vmid",
+                      "axi_s_xpu",
+                      "parf",
+                      "phy",
+                      "axi_m_sticky",
+                      "pipe_sticky",
+                      "pwr",
+                      "ahb",
+                      "phy_ahb";
+
+        perst-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
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
index 8ff4c16b31c8..1ff63d7e772a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -20,7 +20,6 @@ properties:
       - enum:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
-          - qcom,pcie-ipq4019
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq9574
@@ -140,7 +139,6 @@ allOf:
           contains:
             enum:
               - qcom,pcie-apq8064
-              - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064v2
     then:
@@ -258,40 +256,6 @@ allOf:
           items:
             - const: core # Core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq4019
-    then:
-      properties:
-        clocks:
-          minItems: 3
-          maxItems: 3
-        clock-names:
-          items:
-            - const: aux # Auxiliary (AUX) clock
-            - const: master_bus # Master AXI clock
-            - const: slave_bus # Slave AXI clock
-        resets:
-          minItems: 12
-          maxItems: 12
-        reset-names:
-          items:
-            - const: axi_m # AXI master reset
-            - const: axi_s # AXI slave reset
-            - const: pipe # PIPE reset
-            - const: axi_m_vmid # VMID reset
-            - const: axi_s_xpu # XPU reset
-            - const: parf # PARF reset
-            - const: phy # PHY reset
-            - const: axi_m_sticky # AXI sticky reset
-            - const: pipe_sticky # PIPE sticky reset
-            - const: pwr # PWR reset
-            - const: ahb # AHB reset
-            - const: phy_ahb # PHY AHB reset
-
   - if:
       properties:
         compatible:
@@ -369,7 +333,6 @@ allOf:
             contains:
               enum:
                 - qcom,pcie-apq8064
-                - qcom,pcie-ipq4019
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq9574
@@ -428,7 +391,6 @@ allOf:
             enum:
               - qcom,pcie-apq8064
               - qcom,pcie-apq8084
-              - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
     then:

-- 
2.51.0



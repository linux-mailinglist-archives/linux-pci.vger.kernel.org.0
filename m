Return-Path: <linux-pci+bounces-43211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BCCC8C51
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495EA306D096
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27833DEDF;
	Wed, 17 Dec 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VROU9UeB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSAW9NYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB33168EE
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988371; cv=none; b=oG63j7mCTByqPDV2PsrrR85S+ZbNJHKTJYK1cPzB5e07OFGa0JI9rZYUmHLSYNfgQcH5mB4rWwQhriCK3Ew2K3KBQGvpDNFou3WdAzl9nsvcdEhxC8BibIZlqO/hjNx22foEovoi9s4E5iDpEmZYdxhP6fOOuFngOWMoXfgt0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988371; c=relaxed/simple;
	bh=LR/FQBATgMO/UVGWrdZY62ELBL/9ndTjPtSWv9hC0M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDK6+p56X9hWmwsipxk1zlWmiBtRmgSWm6RoFluNApr2Y2vKlK7jfJRZpSwI4hgoCX9Jj7iQgqwoN4V71uEQBU8ns0heL76LpqSav5u0GpTbT7jIBD9ou1xYoYyuX7I0lOZAFVzUZUp9wrn1Ae1yfVcPzTdf0mjNnSoAr0Vq2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VROU9UeB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSAW9NYw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCLHCZ2466119
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oo36gjSASJj40XPbYdPCkJV7xFSUk3DQ3EwxnCWVDYA=; b=VROU9UeB877zk5rY
	i2WicvMeEc91UqTVujPREcAWEvB71toGkH4UPL5UAI/6a1zBVm7AXrPS2ZyExE0i
	zj/ASUyH67iMHAXdMTEdJcObeDTg65V/abdH5CifkcCG+7LKh2Py5VBi4xRC6ttS
	3Yl9NMU3HkBXSiWc3Xj0CZ/j3riLfM53TPC2pIkvSOyNpvrmlRUkMexUTlEOj1oy
	ZWVsYchwAqg/yQCmob2aIewqaH248HDSf0oVODY+LhMdV6jmkSkk/JBGydH7V3k5
	1Nw0Eqo+mnD99y4nCUUk9omHlgVwheiFMulekZAg3RQVMxFJ4TW4VD2ChIxARPYA
	3hwH2g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fe2b66a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so16862341cf.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765988367; x=1766593167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oo36gjSASJj40XPbYdPCkJV7xFSUk3DQ3EwxnCWVDYA=;
        b=KSAW9NYwTYtp2kQvDJfPWzOojLeHQeZk+ZAAVmGjAF6fOS73r3PG4I4qF2d//RT512
         unrLcJw1R33H7pg/O7faWKM9Y2Tp03vHMOtZRH5wVxRYJraFNhka4D6BqQO6T0ms1sro
         E7cNYt1nMaK93whdL0DZ6w9DxzXHKR2HBdXkQZHi6p47T+7ZYn0beh0w/xToDPR1BYxU
         0fFmkzVpqUnfR+XpiKMSm8p7fWxyh/yfgemYSKNTuUism1H5SxPu/TMmFyB4Eh96atmS
         yQWi809hYZaRWApXV3aJHX6jePkFSDZ/3Bj6FnJ4DuZ4hQeU6eJGnzykmH1oltdj4oEg
         sm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988367; x=1766593167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oo36gjSASJj40XPbYdPCkJV7xFSUk3DQ3EwxnCWVDYA=;
        b=aXhc80VBjLzwy0aEQDEkAozaz+SNTtlrgXfXd4raXdy7CCSIJsWrJrySSjukTUvGZL
         H5dEsLwuqICK9qwHYVdEGSz6CW+KYugisQOdo2RlYVj2zS2Nb7SIk+z78haclTGxdbS9
         FR4lxHTnngkLgqHYewH0lzTvQRbRpvWRN24QqMmMAXBQjpHXW5cxxvS+S6YQ+rZBTc+E
         Zwe+9ZSGiTbjeLoqeEuyqJ60IssUKhOBQ0fVTXpfq5ej/QvhXsrBUeAFj1VF8+iA2AEP
         Ls2CUSCsveG/VFqzM6CQlaxOYsiIJHa3wzDZyivHNAEYjiHZdg2DVpbPmxo6ZS37cRkj
         hEEA==
X-Forwarded-Encrypted: i=1; AJvYcCVRhb+EoTcUPvjn1WT5AXfFSx5hArcWN28n7gNv9+QTJ3HsCycxnIBdz9zCGmZMfFqNYnpsj8a13vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDR4zPq3BcEk9Uff2Q0rMHi2NqopNLyFVaVVYEyR3P1SVxZOb
	ACNPCoFRqRyZ0r8jXS1vK83GGk68b1qZdffYX8ndaBvLN0/urrcRmNb206ix1nB0dO/EPY+gkk4
	CDrm5701iVokL9raaMOomxUWR31K9z+2UjGrVs4oo1V6U80UKEz1z9AVBJW+pnkE=
X-Gm-Gg: AY/fxX5yZTjEpRCpEM+vHnCzUouE3dFsWiE738RjLgewguXoi15nWC+NBEpMTSVAnLQ
	gD7BLd/rLwAlLHLSYaBnN613dmUTtjwAq5ghKu+QwuQha9CW96gRI2Bzwea35J2xoSg2zA5ZtXE
	kerAXHcypMVoDdYjHgVpRCSTCkgHvZ8mdf0VbCMuMg1zdn+TbHt/dFO9qpCRGl0WoHXLMlyEqtl
	EziLZ0v+cLPP4ok8xkddKd6R70/eW0voEuUf4g8FMI8+Qa0BnMJ5GSqzO8HHFOxEcYmYcp0z2Mp
	CKNzkXXNrXUHlvCN9gNlR4pd+JT0oZu1n3YXgHrgfgq5nZyfeIVJGBFLyx/S1H59wuc6gULIKfk
	+DE9MyNXKoNdQZoHZNDjXH3DDul4WSsbo
X-Received: by 2002:a05:622a:11cc:b0:4ee:17d8:b583 with SMTP id d75a77b69052e-4f1bfc35dd4mr273369701cf.27.1765988366619;
        Wed, 17 Dec 2025 08:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi5Q6v0Of6oxuKw7JGP1L9W6cQeMCi6gPvpY6QygOeseGy/G9ty0aJw19CZfZGaFSY3fkhAw==
X-Received: by 2002:a05:622a:11cc:b0:4ee:17d8:b583 with SMTP id d75a77b69052e-4f1bfc35dd4mr273368131cf.27.1765988365172;
        Wed, 17 Dec 2025 08:19:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1987868666b.10.2025.12.17.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:19:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 17:19:08 +0100
Subject: [PATCH v2 02/12] dt-bindings: PCI: qcom,pcie-sdx55: Move SDX55 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-pci-qcom-v2-2-873721599754@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8236;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LR/FQBATgMO/UVGWrdZY62ELBL/9ndTjPtSWv9hC0M0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtf9UxFrHLm34w5JiPynQKo56li1qMd9Cg6gB
 APkTZb5xcaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULX/QAKCRDBN2bmhouD
 1+MID/4qYAsckrU+C5CJ1iQNSHs+A8Ic5MktGFqKW7HteJ+9AtEKsa1LtPqWog0Zr3gJfYZ/Q0k
 gCH3SIvchyNQ4lp9U4HhdC7zZ3TBOPESr6qrVtmhUCZw4WOMYvuXRK6x/375zNxkvfJMcvrX5Bx
 zeisiFJJYXEfyfm+/dLhOIkDDlPnZnsiIiCPVuvoe/JqMOGrYVJBu3512fpAujhfj/shUPtYipH
 1lm+lfVi6htbcqNBIjmBgaIUapADuH1ZXVMpSA68BU/mHncxD43RvwRqcjmnIPK0iwBKleTjE0T
 Q+E4/kea4UTT5OHV3YQcB+GKYSkTySbizDlkdDPX2hcU+t11uhB9/cK2vxxSmjDNlFQn/bJ1GvE
 1TH1M2DoNl0xfbTuyOE5miF0WNj6Ay995z1aW8FMl38X/1sc1Brn1qsqa6oRNK0LenA6ZGTlwhn
 HUDFfUMfiJIS2W4f4dfM82w7LXlhezO6tFwSkRTl1GJBdFO4eQLOwu/TlO8mTQNhPH5r+PRaphe
 s6Ayt3H/btHBexKQlaifLb02QEsqsvfV3MbyvsN2sYqUAbP9+ecNogMk1EFiDRGOfF0AHvQjNEg
 nhrWHzaQcVFP84JFYCUFqWDui/Cxt9O5gwxL15XpZDliVs+xZO6682/DI7HBQjUJghetqwC/Bxf
 dWUIM3QF3mcS/Dg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: Raoo0UYBspPUusc2eMl-th5oCBV_Ag5j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyOCBTYWx0ZWRfX6698Gd2m7lx9
 QG3VleI+iPuvV5Q4tIj6F8GEGMAl/mS4aD8lyNghLjhpeISJ5ZblofwGCTR3hoEQWXaTk0wUxkn
 7peugSRN0620Hcw6b9A7224YfbyuhXcstM3pTWf7woTaSpLf7tP9ybbcwf5RYcPnMVBxr9SfE89
 ZFxO64b0AS3W26c1G4R0AA7vV9GTH/UBPFpW9qGdmGB7gmCK885410uwOsseny3bOV2dQPSu4l0
 neu2wUvOjJxCDMvJt/b/rBhvxgkcgkIpfxkPAAnxKlfpoK1iG1NYGxe0rQc0CNrh/7pCc40mxGn
 Kdd7yDovHWZvDOXXKfH6d1lIooiu1+ea+0EqRuB2NVWhyjvLyORcEselJu87WqQdcgrBbMHdJXf
 9JYXNIaXbZ9x94belSKzy7qYTXQorg==
X-Proofpoint-ORIG-GUID: Raoo0UYBspPUusc2eMl-th5oCBV_Ag5j
X-Authority-Analysis: v=2.4 cv=HpN72kTS c=1 sm=1 tr=0 ts=6942d80f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=klm9TE13DJW_JFRMJakA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170128

Move SDX55 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Adding interrupts based on the DTS, which were missing in the
   all-in-one binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sdx55.yaml   | 172 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  48 ------
 2 files changed, 172 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sdx55.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sdx55.yaml
new file mode 100644
index 000000000000..7f6fd81e7ed0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sdx55.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sdx55.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDX55 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-sdx55
+
+  reg:
+    minItems: 5
+    maxItems: 6
+
+  reg-names:
+    minItems: 5
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: config
+      - const: mhi
+
+  clocks:
+    maxItems: 7
+
+  clock-names:
+    items:
+      - const: pipe
+      - const: aux
+      - const: cfg
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a
+      - const: sleep
+
+  interrupts:
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: msi8
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+required:
+  - power-domains
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
+    #include <dt-bindings/clock/qcom,gcc-sdx55.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@1c00000 {
+        compatible = "qcom,pcie-sdx55";
+        reg = <0x01c00000 0x3000>,
+              <0x40000000 0xf1d>,
+              <0x40000f20 0xc8>,
+              <0x40001000 0x1000>,
+              <0x40100000 0x100000>;
+        reg-names = "parf",
+                    "dbi",
+                    "elbi",
+                    "atu",
+                    "config";
+        ranges = <0x01000000 0x0 0x00000000 0x40200000 0x0 0x100000>,
+                 <0x02000000 0x0 0x40300000 0x40300000 0x0 0x3fd00000>;
+
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7",
+                          "msi8";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        clocks = <&gcc GCC_PCIE_PIPE_CLK>,
+                 <&gcc GCC_PCIE_AUX_CLK>,
+                 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+                 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+                 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+                 <&gcc GCC_PCIE_SLEEP_CLK>;
+        clock-names = "pipe",
+                      "aux",
+                      "cfg",
+                      "bus_master",
+                      "bus_slave",
+                      "slave_q2a",
+                      "sleep";
+
+        assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>;
+        assigned-clock-rates = <19200000>;
+
+        iommu-map = <0x0 &apps_smmu 0x0200 0x1>,
+                    <0x100 &apps_smmu 0x0201 0x1>,
+                    <0x200 &apps_smmu 0x0202 0x1>,
+                    <0x300 &apps_smmu 0x0203 0x1>,
+                    <0x400 &apps_smmu 0x0204 0x1>;
+
+        power-domains = <&gcc PCIE_GDSC>;
+
+        phys = <&pcie_phy>;
+        phy-names = "pciephy";
+
+        resets = <&gcc GCC_PCIE_BCR>;
+        reset-names = "pci";
+
+        perst-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+        wake-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
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
index c61930441be0..0e6d11791eec 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -31,7 +31,6 @@ properties:
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sdm845
-          - qcom,pcie-sdx55
       - items:
           - enum:
               - qcom,pcie-ipq5332
@@ -210,27 +209,6 @@ allOf:
             - const: config # PCIe configuration space
             - const: mhi # MHI registers
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sdx55
-    then:
-      properties:
-        reg:
-          minItems: 5
-          maxItems: 6
-        reg-names:
-          minItems: 5
-          items:
-            - const: parf # Qualcomm specific registers
-            - const: dbi # DesignWare PCIe registers
-            - const: elbi # External local bus interface registers
-            - const: atu # ATU address space
-            - const: config # PCIe configuration space
-            - const: mhi # MHI registers
-
   - if:
       properties:
         compatible:
@@ -579,32 +557,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sdx55
-    then:
-      properties:
-        clocks:
-          minItems: 7
-          maxItems: 7
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: sleep # PCIe Sleep clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       not:
         properties:

-- 
2.51.0



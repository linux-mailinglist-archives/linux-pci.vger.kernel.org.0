Return-Path: <linux-pci+bounces-43216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C89CC8C90
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2550F30D3C78
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E334D394;
	Wed, 17 Dec 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lw9AhNNA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g65iuSDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685D3358C5
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988382; cv=none; b=dVdLuOV8CZtXuKN65lhCcz5DGLZh0UQOo32wxgUK0H3aMAWxMaBgv3YD+AIfmKUTlFm+F/G2xdw2BTsmUqN7A4GDloe027uTpAEFb+f6xklxiuDDWfzUn+jeX5HvzoSCSf6u8cJXp6zFv6SupX/sk4w7c55IxYKhf9vCR1dO2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988382; c=relaxed/simple;
	bh=24lMzxCr9aUhET7WAIp3X/uFZFDJp3XdSSyMZd7Klr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG0SOHiy2pg6HrAXwlw1gIBOqtI4zJE1ESeHNRE9E9w4+G4094h3vISZlCzNf8CJ18TsFhX+pdz8k/mUli2UydzA7CCCDxF2gHg8+4/y/bBhtIyBPPXNkNUEUF83aRUHqYtK1KAXS1SvC4pK9tlFNLrMZK8U+sojn0bJs7zEy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lw9AhNNA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g65iuSDo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKn6o2673912
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WR/dfYC00x/AcEZxRcVeNHh3CdklEyCy5ODJfsssD0M=; b=lw9AhNNA22TSuys5
	RYe4G6lUa8Wdkyl5Lw3U+vYCQYtOjEYLve+ziJmXgWFPK9vs3r21hK3iQxy7CLuk
	AexhFNpoxZVsVSP4KBJUw/3TXzWOU4EhZwmMWA2c9VGnvgj2SKw8rIS0uAnGU/BK
	VS3oD8VNdfl4EBjQ1JQ6QCkMd3GZ6/VFBYtLPw8wTGr3S112h7JIZjdrKWlNsYlt
	oj39tamEKE+6BpzB+FPA8SYINeEkaIuZSaSV9DdZ9MmXxhp812uwvKn7BV8uP7IB
	vQhLpUKxJWA8lV6HrYGSnxcRlb8hSadVY1A1kh5sTN1XHnL0wSmQvL7SodMfDiMf
	cIOE+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3myj2c28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6ff3de05so50473001cf.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765988378; x=1766593178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WR/dfYC00x/AcEZxRcVeNHh3CdklEyCy5ODJfsssD0M=;
        b=g65iuSDo9OI5igu5agQ6Qeh031va+tw19vaVZ38rTDI1MtvoDWI39o58qq8CQemiAd
         EZK6I6Voh65PRmGI4Md0RxYPTDQwQ1tVktaLqiMlBt7ttZVfwxc2cYRjcxoAsbYZffgv
         tp0bnCpwVClxVOzbDeWDoZcA6rvhJQ1dT6A4DtAIQv2MdDTSmMEkAntEgYZWtU7Evnmu
         Yy47P0cSkPLkyp+YbEmEn+fLWeom0dZBHDs6t3uIqO6DeQpPV3k0lLRtXlZqKWehECEK
         b8vWNCYGgsEZkq4p7mpPn+nY9Hgb1AEVK239gk2n/IX9NUgdzThSUqjZ5f9XL0hV8E8h
         6Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988378; x=1766593178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WR/dfYC00x/AcEZxRcVeNHh3CdklEyCy5ODJfsssD0M=;
        b=s7iBqxjCMGxjDA9lJ3owdF+fS9+nPauut64uvatBU3q1/l2NdoWC5bOqmWVexhV3bx
         Z7Rq2dPcV9oJNgQ4KCFR/0i9/8aAn04Mfv507bHFILyzyRjdVFEuyOHtEa1cx/BZs8N3
         4JxoAgT4oWg5sTE2XRfTBsUYTispCfyj3I4J1720TAQ6qXwqsCqaYygNPb52A1MMgMDl
         EoOnK+UnFqTLGNyjGKgQwSRLAQndKFduN4QmWKBtx4/TOhT5KHna73RwKG+6XJFiLvht
         lCyG7xvqyD8J3ePv171tL9lxZUjloPYcoScgsscCWik9+7laD5hZojhmG7Qh7CK3Cyah
         CK1A==
X-Forwarded-Encrypted: i=1; AJvYcCUbQnyxoE5uvWKgRPTtcy81mObGy9UsjQuyECpGVrvRSQRwzCUWZdBHK3YwwmGu6AzIvpYOWUEWNp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVluH5wPtbIO+rNkxyEuTxxcdKt1B7VXMVnVrC3n9MfO7LzdL/
	J+Vp3ql4FMsav/Fw1LSTFxpWDRo+fa0neDxkiJyaLOFU/xuh7fP5Mnv+9TntHwpUx9fiS7mrft1
	UQZuC3ROtA/YS6BvUm+fIf/8kbtKfrloKzjAYcq3gEgqOF8JGYj2v6W+VsnwTVeI=
X-Gm-Gg: AY/fxX6CeWeIDStUQTNiYrpNfsD8BcOFYj8hY46nXtWz7xWz6VELleSxdI7g1XYf25C
	KWiMKw9+FUh68i1eliGmdVtwdNvD0SIyJde9r/52ArKw0Zg9NYP4ChmzGsmG45MfejN77hoh79P
	k4UFKOGJFerSWb1Q4jFf/1meUv1lcto/WOjZtVnRPXdvkDlM2cLGgs4jFxDcllXy18bchiCKcLt
	KNeXLkAP72TyPzQaIOuZiR1lJcxiebXlBY8p9GhZTpr78oujXG+3sNL/DXE/tOnDkjTkMSwLGKe
	WH8WkGsenQlJxdjTeOYWe+QLGp/3woQ8A9a0H5sbmlF1UmySZxhthJ31PgKr+ZBRmenzPPyEofJ
	EC2RIyZR1rGZiJeswhxXP8ml+nMfpO1sI
X-Received: by 2002:a05:622a:5c9b:b0:4ed:b5d8:a192 with SMTP id d75a77b69052e-4f1d059b587mr264415451cf.38.1765988377847;
        Wed, 17 Dec 2025 08:19:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoNfHevQSWsz1Y923eorWUuNbmdgR3RbxNNgtAyDznRQt0soUwRocHLxSWWFBliLJQfHnmVA==
X-Received: by 2002:a05:622a:5c9b:b0:4ed:b5d8:a192 with SMTP id d75a77b69052e-4f1d059b587mr264411671cf.38.1765988374404;
        Wed, 17 Dec 2025 08:19:34 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1987868666b.10.2025.12.17.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:19:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 17:19:13 +0100
Subject: [PATCH v2 07/12] dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-pci-qcom-v2-7-873721599754@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8405;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=24lMzxCr9aUhET7WAIp3X/uFZFDJp3XdSSyMZd7Klr0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtgCK2GLdaGJA03qWdN4yo57JREPBt5t98/XT
 gqPOGUUb6uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULYAgAKCRDBN2bmhouD
 14XhD/4vIYccUZjmHT3kOojid8Y0H1FL3Qpk9VGFnAmIWc6ZS7hEeL7ciA9gWEq6JLDpK4ErSD1
 yaaJXf7wfN8CSQd3YT8X4/SNl/jDWBcBqulqU0Fx+BwexrC5wNSgXmr8iOpmPVAXuUYU3zscTxg
 lHSE/izrXmfpeUzXIT6G89UVZgZe3AiOK3GBjEarbk6rL4DAjQ5oZyRWnQnlJu26U43Np/8vGhG
 +cX2CUsTzMeeVNp1ILDI621QjIr0QwhJsiGy8Pv+YVdXSYpnioqvZ2Grvmvuv/bhOpXUJJszHBK
 /L2LwueR20PHjkLi2Vg46dIhZgD4YpyghVspwM1gTOYybF4u1phaPNAQuMFN6SNWjLXiTG9wuWj
 +2tRrRjKih3A+MkvuL0aR01aFmm9w+J3o1Nws+cLFbNuwIv3TtWZWWq85GjMSYMTDxGRyjTemBA
 5HQ3OB/3rr1ySnY+mBErQ7wa99vCB+w2nWMwBqgiBUlCzfTXfOqAc8RzKQUWcAdq0c30pLYpYGj
 JUw1zPzMJ+ukIlJOxGoIbZf/T27604wWdOf6WoAiOz1eYROLqaGixMcuaVvvvbE2tYR6X0enA4e
 PEqUc/w/nVgHIJQ+mDFQcPpdsSKB5LC1TNOfJMwmWE22c8rCpVPP1mldRfEyTWJHx82JYEravNX
 HzmwOWQUxI7wLcA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyOCBTYWx0ZWRfX4r3DY40mqxNo
 Vi8p5mHNkKxgQphy8eNJuTXKLnRpbOEm9S1cBcolxVIjIoQWraa2JaQO2P2jFCnIw+CgXU2zdP9
 kp76X7pAqJscGcju8UiJkKXvNFwaKpG2u2Q+ccFp8tufvTxIlaJBtzjfOBrE0wN99a03jMOF1KX
 NH+jczquz6e169qOsmn3mvHWtZHFGcMZ1A3GRkT/1rKKaetOLtznePRuXfxW5aWWSKC7kmhZF04
 ywe9DOHFZwAv79i0xmg/8w4eK16x/t9I/iPHFo+lROAV130daq6UQltTWNLDyrndMehlqvPJHun
 7USLRImbx3T+lDveQahE4V0aP2rBo0BTOjks4WQ/8oDeuPDil+aqrDs5NgAxZwn1CApO8V86HTY
 GUrHFtz1YUWT542PVcWDfodMVL1U8w==
X-Proofpoint-ORIG-GUID: cuT9jOlc2FdXRN-1fgXcXnkqvurYSgYR
X-Authority-Analysis: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6942d81a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=IKDxjynl_XDzIR9_nSAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: cuT9jOlc2FdXRN-1fgXcXnkqvurYSgYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170128

Move IPQ8074 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Expecting eight MSI interrupts and one global, instead of only one,
   which was incomplete hardware description.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq8074.yaml | 165 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  35 -----
 2 files changed, 165 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml
new file mode 100644
index 000000000000..da975f943a7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq8074.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ8074 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq8074
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
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: iface # PCIe to SysNOC BIU clock
+      - const: axi_m # AXI Master clock
+      - const: axi_s # AXI Slave clock
+      - const: ahb
+      - const: aux
+
+  interrupts:
+    maxItems: 9
+
+  interrupt-names:
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
+  resets:
+    maxItems: 7
+
+  reset-names:
+    items:
+      - const: pipe
+      - const: sleep
+      - const: sticky # Core sticky reset
+      - const: axi_m # AXI master reset
+      - const: axi_s # AXI slave reset
+      - const: ahb
+      - const: axi_m_sticky # AXI master sticky reset
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
+    #include <dt-bindings/clock/qcom,gcc-ipq8074.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@10000000 {
+        compatible = "qcom,pcie-ipq8074";
+        reg = <0x10000000 0xf1d>,
+              <0x10000f20 0xa8>,
+              <0x00088000 0x2000>,
+              <0x10100000 0x1000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
+                 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
+
+        device_type = "pci";
+        linux,pci-domain = <1>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        max-link-speed = <2>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+                 <&gcc GCC_PCIE1_AXI_M_CLK>,
+                 <&gcc GCC_PCIE1_AXI_S_CLK>,
+                 <&gcc GCC_PCIE1_AHB_CLK>,
+                 <&gcc GCC_PCIE1_AUX_CLK>;
+        clock-names = "iface",
+                      "axi_m",
+                      "axi_s",
+                      "ahb",
+                      "aux";
+
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7",
+                          "global";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc 0 GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc 0 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc 0 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc 0 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        phys = <&pcie_qmp1>;
+        phy-names = "pciephy";
+
+        resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+                 <&gcc GCC_PCIE1_SLEEP_ARES>,
+                 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+                 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+                 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+                 <&gcc GCC_PCIE1_AHB_ARES>,
+                 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>;
+        reset-names = "pipe",
+                      "sleep",
+                      "sticky",
+                      "axi_m",
+                      "axi_s",
+                      "ahb",
+                      "axi_m_sticky";
+
+        perst-gpios = <&tlmm 58 GPIO_ACTIVE_LOW>;
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
index 780a77f35b34..8ff4c16b31c8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -23,7 +23,6 @@ properties:
           - qcom,pcie-ipq4019
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
-          - qcom,pcie-ipq8074
           - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
       - items:
@@ -144,7 +143,6 @@ allOf:
               - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064v2
-              - qcom,pcie-ipq8074
     then:
       properties:
         reg:
@@ -315,37 +313,6 @@ allOf:
         resets: false
         reset-names: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq8074
-    then:
-      properties:
-        clocks:
-          minItems: 5
-          maxItems: 5
-        clock-names:
-          items:
-            - const: iface # PCIe to SysNOC BIU clock
-            - const: axi_m # AXI Master clock
-            - const: axi_s # AXI Slave clock
-            - const: ahb # AHB clock
-            - const: aux # Auxiliary clock
-        resets:
-          minItems: 7
-          maxItems: 7
-        reset-names:
-          items:
-            - const: pipe # PIPE reset
-            - const: sleep # Sleep reset
-            - const: sticky # Core Sticky reset
-            - const: axi_m # AXI Master reset
-            - const: axi_s # AXI Slave reset
-            - const: ahb # AHB Reset
-            - const: axi_m_sticky # AXI Master Sticky reset
-
   - if:
       properties:
         compatible:
@@ -405,7 +372,6 @@ allOf:
                 - qcom,pcie-ipq4019
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
-                - qcom,pcie-ipq8074
                 - qcom,pcie-ipq9574
     then:
       required:
@@ -428,7 +394,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq8074
               - qcom,pcie-msm8996
               - qcom,pcie-msm8998
     then:

-- 
2.51.0



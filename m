Return-Path: <linux-pci+bounces-43210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37ACC8BB2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FB8830150EA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7728000A;
	Wed, 17 Dec 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isq6XdyA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRky0ctE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E42335566
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988368; cv=none; b=Jh7h8j1dfNunZ/CKxd6BPfUCFjxjx9V3fwNYxjKtQ8CAbekjWQObmn5V2XuMcRN3f3NSNgcWBXfq7bw9bNOOeQt2BxKiY80mTD/Ygsg/Bg3Trfb3COUPb3BGdGgyZA8+fdDmq6ORlGhFTTyJ/XkHhefTQa7XQwQAxPca3a6jRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988368; c=relaxed/simple;
	bh=Fm/yq5Cq8klq4CkYmEM+bbcSx8udY9AgBOJpvYHYnz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYmRefNpb3sXbBYpAtSKIzPGURtxBAxWksxZFcbI6Nb6DuKxrCuX0/qimJQpGo5GtZXxt36MUOf2tSS2jJD8l7WAqzbv/MLFUo8qMMpz+PezvylbzbC4Qgv+Cb4QvTfAKjHNy3DIqYKaoj2ep6UwNCA/KDzPJdyUrQ42JLpaUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isq6XdyA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRky0ctE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKoVn2042720
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VoBysAa5zD19GImKMc+94Oe1pXavQb9op8Tz+mb+yPY=; b=isq6XdyASzzd24Qr
	0WnAOt4i5lVt1CxPxaC+4J8T02Y6ntuwPIvmn+rssDacrXVcFAl3+n6FjYXKlK12
	TBiPZOl/TcCnCEh0LxioTY/H4uuWJkwdCeAhwJfsknJa+sXK7pNs5WTTUrJzN/S7
	d4peM2bHzAK4rRILdMcG2BX12y5s1yZxUk8Dc+8aiSXZJgG03wozwaR5Kt2RuayV
	ydWJLs0q+kBZLAGvzB1sDgxYud6n/YZEOTN9A7HfLuqbAlXhxBkVakVre304Sg3d
	tYYKLkL6aXWTUM0ebX2oNgq38zNFlUhW0EVmIHPFW8ddlV6OcnPlwFh/bOJmn51c
	0o1SAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fj1u6cy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee09211413so152826241cf.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 08:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765988364; x=1766593164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoBysAa5zD19GImKMc+94Oe1pXavQb9op8Tz+mb+yPY=;
        b=NRky0ctE7lGsxFFtTsL18mUPEOnOye2lp+C/Jzi5lSIxZ/8DQ2/YUHGDvZ/zdsY+sj
         UXe3GQvySLhWq/WNst2Y/xiGT9pS35mp6siev3KcFjojNuzpaTD0RWp0B0+BG1ycvkQi
         P4Xno+ftEWv7ZxY5SgqMOQxBbxAKeTk2nJXl+LYgR8OU+6zADsyHd7YATc671JicI8YE
         tKbZieUeBNw8qkitxDn/aY1vt3+sb63msTPuBmKwmx9kfU83sl/Axe6u576AOsuE7t0Z
         WMWARxNtli3hibMbkkxVY1g48NmSWdhBMB/Zrgcq0IubBWQSkmo3QQyxgvT9PeED9R2I
         WyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988364; x=1766593164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VoBysAa5zD19GImKMc+94Oe1pXavQb9op8Tz+mb+yPY=;
        b=uLeykb4IkYEqsCFbDKQlMNnSZjSHItYzR6E5D7IC6U2z6nRzMFidHZdNWfh0wx/qwQ
         KojGXfBqAWhfuUEQzdSxBGYx9vR8+51/+jLOUDp+W98KrSMzwuNIU+d8o/haDGNxCj8Q
         kM62ZAJhC3ft/in66vTAjfPDtxaDb+ji++MnwQJc6rdLYH1Bc0aD5RhNzX24nLfWyhDe
         8uScdaZ65xt+zj4A94lUIyr+eIvdlDmcfqDy5Hx5OZx01GXfKlo/lhZZ9Gp3nIKjnKb4
         XsoV5AeFsw3uwXjySEEfL7RBAjWrYdpf1Dv9soA66nAAPCLaW3D+eGRgAtDjR4XFJN0r
         WqxA==
X-Forwarded-Encrypted: i=1; AJvYcCV/hUttsuzN7qaaBejq6Pc/Y2hGkW7wGO9iCkWIosztRmGeZhfWjKppC/RAHyP79zd5WIjfcoNIEBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQ8alJg/pSkhll1YvprJo3VKa/VHCHXIrTNzc+h/mKAs0t8m7
	b1Ix/O12YebQHDzagG61xM0F1xqJasI5uQuEMcaO1ba4KEgsRKy9JBn0VcYMiU41Hdfi5Q+5pQx
	YwDr62hlQVaT8jvuuG4rLljd2Ce+zN71uCbvuUc3pLX69JdwzL+puDIqYEl3CeG6kxs+qpEI=
X-Gm-Gg: AY/fxX4CksyRYbQAmiAXXgBlCwBciHm8+rRcFUQvi71lbAIAS4t1h9MoItLGOrFv7Sz
	/8LCwkCsAaGyfA7Dnb3ZQhPd+82h6hLEVarJvoG7ENh3INEcd4z0GjNauFINy1hbAphawNmTXq/
	eApEcGAemrU3YTuoN/dXv14p+kMd22x99sN5A9aQFwDh1JVtxi3jinFVjGS7wcoKzRwatYrDp4V
	qCSCIKGir0XQJtk8AtjzIobXtMLTWFFBTycSnQN17WYXlbkYA4sfYgOM8A2DndF3Ku7bvnXQbjT
	CA236OZrwVEvPd3p8uRV+xKZ9VlwIVjZnll9qijMc3wVkehFTgbT5g8nBmTR0BzdXZ7L7PbDTMA
	LNBlIWQ/TMfjXutvarxK0u+DNClR6G0On
X-Received: by 2002:a05:622a:5984:b0:4f1:ba00:4cc6 with SMTP id d75a77b69052e-4f1d064ec9fmr284208091cf.79.1765988363855;
        Wed, 17 Dec 2025 08:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5wX7nr54SGIviXSSgE9qxdEPyQBvwedeFhT7CzRb62/G9Rd+exqMVi8x33z/MsEZY9gE5qw==
X-Received: by 2002:a05:622a:5984:b0:4f1:ba00:4cc6 with SMTP id d75a77b69052e-4f1d064ec9fmr284207441cf.79.1765988363401;
        Wed, 17 Dec 2025 08:19:23 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1987868666b.10.2025.12.17.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:19:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 17:19:07 +0100
Subject: [PATCH v2 01/12] dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x
 into SM8150
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-pci-qcom-v2-1-873721599754@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6957;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Fm/yq5Cq8klq4CkYmEM+bbcSx8udY9AgBOJpvYHYnz8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtf8kHOUu9hqnWAN4qIze7nN7GMawqQLhbRTV
 jS2xn2IKz6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULX/AAKCRDBN2bmhouD
 14CIEACE6CA5CQ8pgZN591n9ToOp0PZccD1CwSZl6l+hwmFfJR/aP0F/LtCHHjcD5RLABnzb7vF
 XKfmFGJBVOQUNnUYyeGrOOjCUQIN1EtyOfbZIS0k9nyc5jIFrjkuXHwRpH+cY74RqXslCDpKAkI
 Es5Z22ECRh9nG7Ac3x7gFgu0H/b6d5by6i3rDeBbygPnKTnIclgemck8+6p6+fRoHGRAEPoqwre
 z2LQkEIaZtUTffR+7nFPGwusD83yUBEnCfuKM2Wy1NognODBKQM1QyJ3bfeu106YRzZclUOosBo
 Sr9tPepyoYASlyjs5OdHyb6xCt55oZ2Bt5uOVORNpHDq3341rgMffMOa5gHK46wRqj9FAcpSVv3
 Fc6k5+O0FDmSUN+dQQJ2HjrKf7gCFoKHSRmrlp75ngBpuRRK7igFjD1VzH3DaSXKxiBdeX7yacl
 ywnrG/PQX3gIHYZUFn8n1dEh8NwIjTCcZKGhm47boHfB6ULF6+q9dxz4OHh3z5mcDxieHllZsKg
 BOhkSkH4FYvIdk3xO5RMDb24NCc3J4Eptf1IcVpz8zA7IELGGrjuVE4sv767F6GiaX/d80fR360
 eYZftmCCvq6ZpPBDSFWkiTAX/Fyr220q+rLmfiTxhUjyjhMD8emDvLcDrHGBJmIVSg/K5kt4cOA
 Z7kfDPZ03wRBbsg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyOCBTYWx0ZWRfX7NmNTGh4wz2/
 Ag+UPNyJczcaVyUrRrNACBtwgHVfee75FXmlkrltXOu/V8AwDLTZb+i7r9CXu2tBc2W6KHhQ2Gk
 otPbRDQJNMCuU7dhRTPZ2S06lDPDMrcJN1c5tpUViOjBJjgjqkrp8GKJGbpl6UBTN4RvW3GBJYz
 7mW/GQokrMZgXIHLOce9BZf/EKCoGaeBob2YmUVvTVa28nzVSqhbz/66I+CyBMb/7DebfGxmzK8
 eEoSHz8unA/nw1jw8TPPO58vw8PacvWRyy5YaYAnfToD7cafGg1e3NIVizPcMt5B6UeLl7jozXF
 UOplItOIZW78ysgQuYJXASwpRMgvXn79Tw71wh7Vehyq9uksSbEcGEb41xlH2Dc1ZKxyZhRiXnX
 h/qZqY1QJ7/CdiUnQd6b0uDd0tEb8g==
X-Proofpoint-ORIG-GUID: Tm6O0J5uCmMs9vfjcKexSIhQcJS8X7fM
X-Proofpoint-GUID: Tm6O0J5uCmMs9vfjcKexSIhQcJS8X7fM
X-Authority-Analysis: v=2.4 cv=edgwvrEH c=1 sm=1 tr=0 ts=6942d80d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=N0pzolelIEQcvTdeIfcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170128

After the commit 26daa18e35eb ("dt-bindings: PCI: qcom,pcie-sc8180x:
Drop unrelated clocks from PCIe hosts") and the
commit e1cb67ab82aa ("dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated
clocks from PCIe hosts"), which dropped two clocks from each of the
bindings, the devices share entire binding and could be kept in one file
for simplicity.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 168 ---------------------
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |   1 +
 2 files changed, 1 insertion(+), 168 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
deleted file mode 100644
index 6a7c410c9fc3..000000000000
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
+++ /dev/null
@@ -1,168 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SC8180x PCI Express Root Complex
-
-maintainers:
-  - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <mani@kernel.org>
-
-description:
-  Qualcomm SC8180x SoC PCIe root complex controller is based on the Synopsys
-  DesignWare PCIe IP.
-
-properties:
-  compatible:
-    const: qcom,pcie-sc8180x
-
-  reg:
-    minItems: 5
-    maxItems: 6
-
-  reg-names:
-    minItems: 5
-    items:
-      - const: parf # Qualcomm specific registers
-      - const: dbi # DesignWare PCIe registers
-      - const: elbi # External local bus interface registers
-      - const: atu # ATU address space
-      - const: config # PCIe configuration space
-      - const: mhi # MHI registers
-
-  clocks:
-    minItems: 6
-    maxItems: 6
-
-  clock-names:
-    items:
-      - const: pipe # PIPE clock
-      - const: aux # Auxiliary clock
-      - const: cfg # Configuration clock
-      - const: bus_master # Master AXI clock
-      - const: bus_slave # Slave AXI clock
-      - const: slave_q2a # Slave Q2A clock
-
-  interrupts:
-    minItems: 8
-    maxItems: 9
-
-  interrupt-names:
-    minItems: 8
-    items:
-      - const: msi0
-      - const: msi1
-      - const: msi2
-      - const: msi3
-      - const: msi4
-      - const: msi5
-      - const: msi6
-      - const: msi7
-      - const: global
-
-  resets:
-    maxItems: 1
-
-  reset-names:
-    items:
-      - const: pci
-
-allOf:
-  - $ref: qcom,pcie-common.yaml#
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sc8180x.h>
-    #include <dt-bindings/interconnect/qcom,sc8180x.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        pcie@1c00000 {
-            compatible = "qcom,pcie-sc8180x";
-            reg = <0 0x01c00000 0 0x3000>,
-                  <0 0x60000000 0 0xf1d>,
-                  <0 0x60000f20 0 0xa8>,
-                  <0 0x60001000 0 0x1000>,
-                  <0 0x60100000 0 0x100000>;
-            reg-names = "parf",
-                        "dbi",
-                        "elbi",
-                        "atu",
-                        "config";
-            ranges = <0x01000000 0x0 0x60200000 0x0 0x60200000 0x0 0x100000>,
-                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
-
-            bus-range = <0x00 0xff>;
-            device_type = "pci";
-            linux,pci-domain = <0>;
-            num-lanes = <2>;
-
-            #address-cells = <3>;
-            #size-cells = <2>;
-
-            assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
-            assigned-clock-rates = <19200000>;
-
-            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
-                     <&gcc GCC_PCIE_0_AUX_CLK>,
-                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
-                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
-            clock-names = "pipe",
-                          "aux",
-                          "cfg",
-                          "bus_master",
-                          "bus_slave",
-                          "slave_q2a";
-
-            dma-coherent;
-
-            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi0",
-                          "msi1",
-                          "msi2",
-                          "msi3",
-                          "msi4",
-                          "msi5",
-                          "msi6",
-                          "msi7",
-                          "global";
-            #interrupt-cells = <1>;
-            interrupt-map-mask = <0 0 0 0x7>;
-            interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-                            <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-                            <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-                            <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-
-            interconnects = <&aggre2_noc MASTER_PCIE 0 &mc_virt SLAVE_EBI_CH0 0>,
-                            <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_PCIE_0 0>;
-            interconnect-names = "pcie-mem", "cpu-pcie";
-
-            iommu-map = <0x0 &apps_smmu 0x1d80 0x1>,
-                        <0x100 &apps_smmu 0x1d81 0x1>;
-
-            phys = <&pcie0_phy>;
-            phy-names = "pciephy";
-
-            power-domains = <&gcc PCIE_0_GDSC>;
-
-            resets = <&gcc GCC_PCIE_0_BCR>;
-            reset-names = "pci";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 6a5421e4f19d..ea29d0900a25 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -17,6 +17,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: qcom,pcie-sc8180x
       - const: qcom,pcie-sm8150
       - items:
           - enum:

-- 
2.51.0



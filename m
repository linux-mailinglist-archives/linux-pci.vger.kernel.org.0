Return-Path: <linux-pci+bounces-43221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD996CC8C48
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0EC30D8449
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131BD34DB7B;
	Wed, 17 Dec 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oPLC2t7w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBRwSa3e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7434D93C
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988390; cv=none; b=cTrKkbqYzX7kAocUFw0KECDbeE+yTZAUQSGOhe1nMNkyWXL8/jHGnNwu4F0PaEtgKMaz3sPY3CR+QlnNuwZIDIEJNYoDhfH1s6+Metni16ASux7Q9pXX/kVQ8dvzEjouRh0Uxw8A7Pyi9tLIM974Lrg3n935cZA8B3u6HQcc8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988390; c=relaxed/simple;
	bh=NnZyOyFe4FnWrR22Z6ZQaG8VqxTtc1lzACMmhkeCFlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eau5OaF5R/nzugDKSjef6iUnhfG5nGLcwuU45YqXcuNVQUKthMbp0Nn/X0BzbijSmR5+eUIx8w0YSsW6oLSZ3/jVMxOznlb8gNtQCxkpHBM87iRw6buW1fn3x9XcqT2kPMCRCvzLaPI57VGLn6HYR/0ZOdpLy9fSkeeCP28oThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oPLC2t7w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BBRwSa3e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCL9I73002293
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CjvZPydUOKQsxJNULi3PTLu6MGnbp11iV7Wnr2pvt1I=; b=oPLC2t7wlMDrHLqr
	vh28mrx26QO3vdGykbebiTJ5w7hTj4JFeJG7+jNGFgiv8b/4q7TpjpKP1RMtEv8K
	HwkoKbpoyANYWOfaXvpTu0ooZNGhsM/ml4LzYV+63vJBKm83p5RRlpxuOCSy/U3G
	QRzpDYUhOrgHJ4ki+kkqNSLBCqzhIr6V7Em0ODG7zRshVJN+yXYMsWppSaGsJBfd
	JJ+8gRNfxy49Tlxc4lOAtOiY1sumal0kt1mSvJkIfClGzRZU730rdTuyqAv7780o
	5y9pJonuqGNd9EiubmkvJQgHndC2Cq90areQ/OG2s56DQNS3buwcGdCgvXajqqKY
	Y1CrJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3n332aj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 16:19:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74ab4172so124354971cf.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 08:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765988387; x=1766593187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjvZPydUOKQsxJNULi3PTLu6MGnbp11iV7Wnr2pvt1I=;
        b=BBRwSa3euaYs/9L7j3RrhT7wWGZLat0YSjJ8l+cGUbWvP0sC/xOdUTyQzn5Rw7g+dG
         852a9sEs1CVFxMV21DfiPmVHu7GIzVICeJUarYKAtFrc5kLGVvHwnPp7JtbWfXDf4tq9
         JFzN14EOA7qo1g+w8ySOhYtW/TP4FPI9vi+CACg4ey7jBv5+EVvJc01g2Z5H0pHOL6T1
         7kF3JzonM98rg/UWBvGnV1P5gZz+iM5AY3cDdmk/oMVI8VhcrJjLOjZq6zLsZvxrZi/a
         wqP80SbmWpH3uZXt88MBzDHK2foG8nNDfPqUckBl9lfNxL/YiK4lArH+3VCRQF0l4Ut/
         xDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988387; x=1766593187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CjvZPydUOKQsxJNULi3PTLu6MGnbp11iV7Wnr2pvt1I=;
        b=X4pwaCgO68jUCxukz3aWZYVjmDud6rS6aSb5mF/t7Arh1fVAMD6tMH6I4mXtXy9Yez
         ojfzNKER2U/7dcH6HPwsCbT9JUUL1PhzH4FQvl/4aLHtIlnU4MOcFFl6GO1C9u3qo1oq
         jaBPsmjOrEzOFqYm7tOgvKNApq+WMpYiMcjI9/fXCTUq6dZ7Zjm8P7IE3nhCWdCmN0WV
         VCdqmNSzoRXWgkLn0QuKW4guYZyYDNTSpN8VyoWKjlXKguR+xcbEYUdJSX39GA23QUPp
         mbTjwrUM2v/EHbqz3S7Kkp1hZuISvsDTsf8hRFejkbsXdXRCD0GEeeTQKFsp7vUKqeZp
         B/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp/RH1ThuTk3Fzwq1usRwNurE+wxYI/fT5pU2z5aIBVTyh9YUDriaThRR8vN9lXK4R5saGwxmgj4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjachEyswpHMGg3c6xqrP5i8oyRMLz01QrR8AxD5f2MHHwMXkN
	95/QKrt68yle6asBqBeaes0z6fWvdnaoHqhBXMPS/OWMPSj1KbQFnGQVwcbwplYjpE56Z1pxMU9
	zb5vtDApxI1aKXHP+/PVoQ8SleNyixlkmSVk9dETu9lkodWRmFpRGaReidZZlcnE=
X-Gm-Gg: AY/fxX5pUgHE4gfXKSPmdfojSB3f9aH5oNBlxVbOdHDLSSOAtTUcZokX5Q+1wUe7HNC
	9l81YKP1D9dNF8q426h1air0nGYZQhWKMYgI5dJmOU9OK/JSkTAtUn42JcP3qbS7Iz/uhJynUnF
	fzADioUcE7igWTcVzywAfqTWk6OY4bTiTUGTMJ0S6tqKNPl0CzpIihTU2EDPnR9HfeJ/9pweGpq
	6xzfDM+WsJaRatSDC4SvlynPfAy4ehY1VXuNJ+5Dk2RttpYS4fTwx5rKQJhS6uWd8+CZWNQSN7v
	8yKsLTFsjVWfqjUSZQ4mD22s/NqiDYhYkhE6PS/1IsHXhx5TLymqTr7Jkocx17LSupE+gwpHbDJ
	Iw4v+B1RtdIu7mbS/iKueLtFGNnOO2l4C
X-Received: by 2002:a05:622a:180f:b0:4ee:24b8:2275 with SMTP id d75a77b69052e-4f1d0463687mr220494171cf.1.1765988386856;
        Wed, 17 Dec 2025 08:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0UIdj3bhiwSCVd9ZUniHbV6/8OzytUWixPUgdG/R3jP7Qiis3SqdbyCkNR+uFz8EjSIVlNQ==
X-Received: by 2002:a05:622a:180f:b0:4ee:24b8:2275 with SMTP id d75a77b69052e-4f1d0463687mr220493751cf.1.1765988386348;
        Wed, 17 Dec 2025 08:19:46 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1987868666b.10.2025.12.17.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:19:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 17:19:18 +0100
Subject: [PATCH v2 12/12] dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-pci-qcom-v2-12-873721599754@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9690;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NnZyOyFe4FnWrR22Z6ZQaG8VqxTtc1lzACMmhkeCFlY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtgGGmH7Vf9cEL7vLe8i382DU4vNF3YU/4eul
 S53gtblGHyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULYBgAKCRDBN2bmhouD
 1zguEACLbarrFplIOVoJMOleMAjkKWo3ji26Kl3m5SewnOLsV058qiJw7ZCuvRv6P4Wv1mOJdWH
 la9SkR5f7vveVEr2zOCM89p1uGRa7vodej1XRTek02GFl/AJet4HvumH/F93oZMopyJ+xKCgswY
 /2pYBzNu039phHifF7ZTvZKOxNR0nOlGF6wNPd+UlTXxmlW043aagGdwQBzekiG/vXOfhK423pe
 FgimePO2l1x24uyCwXT6PuxmYa+5kXz7Ygw/bKi76d3q4Igwpj1Iv3XYF7zQTxklsnz8sIINXsG
 NAIkb7S1L0gklg2mwIZj5Ado6OlpWGbawABp5MLAAKCb9754LxCNGrTOJPsuMZKoLyCL7Z8jkKB
 fP3ki2WrV0jEVfv3yGHujuN2zDYrfG3cIY308Fo23EXjB2ec2dN6KP50zK6/47mmWxRXPksD74P
 LO7dpsIPoSTA63dk5ypsckQ6KAS0tqnNmj8YXj3JYnluGhebN6PvIGqcmZdQxVHgzKPhYcJ8FIT
 YuryIjKIcN0t+65N5WoXPUDvYn/N5myq+ty8IRwl/a74K6T7VgF1f/I3Xn7twLZAj/nRk0qrvKe
 gRIyYlyx+Qa2nECiYVwk8ttselb6f12j+wPdVdaITfKQT8O+BcAa5Pi0spEuatSu2Y3iq0QIcvb
 u4VtUYUyxtz67SQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyOCBTYWx0ZWRfX9mruy2m/GR3b
 t6oUEgpVDtg1Rn1JN5Gndfe0XGgAJWq2YZXJYEQgSWgxrEksYtOINY0ErxMHwqMCDDrD0tBGUQx
 ngX9/vTWfk3UpTqVSsMTu17k8ro47C8cZnAXLR2KR0JyQpD+Ezsegi+ZKYF7ACs3X1Rn5+Ya8mj
 U0Ct8IkoDyTJTh2yj3VEc0aVOYQXa72PhiyLlvkI0DeRwWE7fr599/1vi53O4xK60BB+kMdZEn0
 sCYI5SqHjBHLMSKy/Amtp4VbzhWeKRnTRLdTu+ReQBXm+BtF+sjbqpoVzA4DUbaKorHkLaJoMBb
 yy/6uOWqhFQ008ZtbxR+MCmGuvVvwbY4Pv3EpP2dpQngt4vIqYf35F84Mi3DkzXR2408uZurMsP
 he+bZZYj06S0U2/mg9zBi3JPlcAnBw==
X-Proofpoint-GUID: oX9lSdvqxwdIfrEapTx7_t-n9nXqO6ut
X-Proofpoint-ORIG-GUID: oX9lSdvqxwdIfrEapTx7_t-n9nXqO6ut
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=6942d823 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=d0cN-5R3_aeRheYbsGEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170128

Move APQ8084 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

After moving the qcom,pcie.yaml becames empty thus can be entirely
removed.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-apq8084.yaml | 109 ++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 227 ---------------------
 2 files changed, 109 insertions(+), 227 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml
new file mode 100644
index 000000000000..a6403a3de076
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-apq8084.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APQ8084 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-apq8084
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
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: iface # Configuration AHB clock
+      - const: master_bus # Master AXI clock
+      - const: slave_bus # Slave AXI clock
+      - const: aux
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: core
+
+  vdda-supply:
+    description: A phandle to the core analog power supply
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pcie@fc520000 {
+      compatible = "qcom,pcie-apq8084";
+      reg = <0xfc520000 0x2000>,
+            <0xff000000 0x1000>,
+            <0xff001000 0x1000>,
+            <0xff002000 0x2000>;
+      reg-names = "parf", "dbi", "elbi", "config";
+      device_type = "pci";
+      linux,pci-domain = <0>;
+      bus-range = <0x00 0xff>;
+      num-lanes = <1>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>,
+               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>;
+      interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "msi";
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0x7>;
+      interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&gcc 324>,
+               <&gcc 325>,
+               <&gcc 327>,
+               <&gcc 323>;
+      clock-names = "iface", "master_bus", "slave_bus", "aux";
+      resets = <&gcc 81>;
+      reset-names = "core";
+      power-domains = <&gcc 1>;
+      vdda-supply = <&pma8084_l3>;
+      phys = <&pciephy0>;
+      phy-names = "pciephy";
+      perst-gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
+      pinctrl-0 = <&pcie0_pins_default>;
+      pinctrl-names = "default";
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
deleted file mode 100644
index 0d3b49485505..000000000000
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ /dev/null
@@ -1,227 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm PCI express root complex
-
-maintainers:
-  - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Manivannan Sadhasivam <mani@kernel.org>
-
-description: |
-  Qualcomm PCIe root complex controller is based on the Synopsys DesignWare
-  PCIe IP.
-
-properties:
-  compatible:
-    oneOf:
-      - enum:
-          - qcom,pcie-apq8084
-
-  reg:
-    minItems: 4
-    maxItems: 6
-
-  reg-names:
-    minItems: 4
-    maxItems: 6
-
-  interrupts:
-    minItems: 1
-    maxItems: 9
-
-  interrupt-names:
-    minItems: 1
-    maxItems: 9
-
-  iommu-map:
-    minItems: 1
-    maxItems: 16
-
-  # Common definitions for clocks, clock-names and reset.
-  # Platform constraints are described later.
-  clocks:
-    minItems: 3
-    maxItems: 13
-
-  clock-names:
-    minItems: 3
-    maxItems: 13
-
-  dma-coherent: true
-
-  interconnects:
-    maxItems: 2
-
-  interconnect-names:
-    items:
-      - const: pcie-mem
-      - const: cpu-pcie
-
-  resets:
-    minItems: 1
-    maxItems: 12
-
-  reset-names:
-    minItems: 1
-    maxItems: 12
-
-  vdda-supply:
-    description: A phandle to the core analog power supply
-
-  phys:
-    maxItems: 1
-
-  phy-names:
-    items:
-      - const: pciephy
-
-  power-domains:
-    maxItems: 1
-
-  perst-gpios:
-    description: GPIO controlled connection to PERST# signal
-    maxItems: 1
-
-  required-opps:
-    maxItems: 1
-
-  wake-gpios:
-    description: GPIO controlled connection to WAKE# signal
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - interrupt-map-mask
-  - interrupt-map
-  - clocks
-  - clock-names
-
-anyOf:
-  - required:
-      - interrupts
-      - interrupt-names
-      - "#interrupt-cells"
-  - required:
-      - msi-map
-
-allOf:
-  - $ref: /schemas/pci/pci-host-bridge.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8084
-    then:
-      properties:
-        reg:
-          minItems: 4
-          maxItems: 5
-        reg-names:
-          minItems: 4
-          items:
-            - const: parf # Qualcomm specific registers
-            - const: dbi # DesignWare PCIe registers
-            - const: elbi # External local bus interface registers
-            - const: config # PCIe configuration space
-            - const: mhi # MHI registers
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8084
-    then:
-      properties:
-        clocks:
-          minItems: 4
-          maxItems: 4
-        clock-names:
-          items:
-            - const: iface # Configuration AHB clock
-            - const: master_bus # Master AXI clock
-            - const: slave_bus # Slave AXI clock
-            - const: aux # Auxiliary (AUX) clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: core # Core reset
-
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,pcie-msm8996
-    then:
-      required:
-        - resets
-        - reset-names
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8084
-    then:
-      properties:
-        interrupts:
-          maxItems: 1
-        interrupt-names:
-          items:
-            - const: msi
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/gpio/gpio.h>
-    pcie@fc520000 {
-      compatible = "qcom,pcie-apq8084";
-      reg = <0xfc520000 0x2000>,
-            <0xff000000 0x1000>,
-            <0xff001000 0x1000>,
-            <0xff002000 0x2000>;
-      reg-names = "parf", "dbi", "elbi", "config";
-      device_type = "pci";
-      linux,pci-domain = <0>;
-      bus-range = <0x00 0xff>;
-      num-lanes = <1>;
-      #address-cells = <3>;
-      #size-cells = <2>;
-      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>,
-               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>;
-      interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-names = "msi";
-      #interrupt-cells = <1>;
-      interrupt-map-mask = <0 0 0 0x7>;
-      interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>;
-      clocks = <&gcc 324>,
-               <&gcc 325>,
-               <&gcc 327>,
-               <&gcc 323>;
-      clock-names = "iface", "master_bus", "slave_bus", "aux";
-      resets = <&gcc 81>;
-      reset-names = "core";
-      power-domains = <&gcc 1>;
-      vdda-supply = <&pma8084_l3>;
-      phys = <&pciephy0>;
-      phy-names = "pciephy";
-      perst-gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
-      pinctrl-0 = <&pcie0_pins_default>;
-      pinctrl-names = "default";
-    };
-...

-- 
2.51.0



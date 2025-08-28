Return-Path: <linux-pci+bounces-34996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CEFB39C65
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DD9984936
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE830FF39;
	Thu, 28 Aug 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBGkOii2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5D30F54E
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383022; cv=none; b=Qeu51Rl2pi2C8iS02uS49coN5BT1fxIRJahrEz1TBMQRBx2t636s5Fg+7Epyk484rNIhBmJj3cNwNyRKUKbk6b8qZslHRjhBn05oBU5ltuzcBShT4X8pi7J13ghOuzgrFZfnLMRFmAWyhcx32H7M9RR+s2KmUoCMDn4Nv6m+Yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383022; c=relaxed/simple;
	bh=8zvZqpFeuXSiqe4t+MpIJYoVCiPCsJm1Ov8cxUJVKCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMnQN70RIORBuJj5EQOPMeocv4MzrUIzRiaHwRAVpyWTh5JE2oV0d6KfygiDIQjgK/y6MOl/kCiQinOzlW3AwDIjiX+aBPq3SFN2FUnQgolbacnhMXZtU+Aij42rqele1Lod/887+isoCculITWd1ZGHw+/l19E7wfXed4oowNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBGkOii2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5Pq46031174
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N5SuIv3JLHlPvqOUKHgEWsX4PG4GINisx08kaTXoUAg=; b=WBGkOii2Zwhsy+sc
	xHBvriDMKvagkkmCF1m5HAzgGrJlOPOSBamZyFPpDTo9lCegzVLsHhwhFgSS5QpZ
	p2jpV5+Tf6WPAjIuZikuSPXh1AdvCnv+xk7D2BraiDpX2NRYVzgqHSfsujd9//hH
	S2z9EqpuKtIDkrEi5pcWPGaY1IrlyCJq24vpBEvNXWfgdXNuEN8a0JsXgbR/lnxY
	H5I7srI6ghOIe0ZJ3m77+ckmzifG9ZdOCN6zmlzPcmToKNRbkeoPO/d/G8CoqSS9
	aMG+eud5nX30EczdV7aAJyJ29y5uLQx7d0Nrpz4WGBlLJxyBZ2RYeQEVQeKKQ3ZU
	9MnWpw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615r1vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3276af4de80so1331509a91.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383010; x=1756987810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5SuIv3JLHlPvqOUKHgEWsX4PG4GINisx08kaTXoUAg=;
        b=piIn9t/SkHw1INK7lGeKH8/wjIU0ZTnt3CpRvBJEUr2A1ExdL7KceUZd/6U9sOgSJP
         O469I9KPAYoS959fHF3XB2G8ZN3AP4DkUnUi4CUcxWQVhjDAS9wNI2p2xUAqaGhXt20E
         BMN/4zynwXNUIdEkVrkhtrVeCSDqw5red6+XEOOdXWU6+4V4BRlhaOB+MPyzmlOroG8B
         gQuH3kmDyBWauvhAoI9avJU1K6pdNpJa6g5hMpZ5HdTDQ7TUtOilRPEt0VT7RTGi5x+W
         tDAJr2Da+keBzs/IhW49xySQIs5J9pwhl3vTeKwaMHFhKCl82XIpR3S34YbGe9BdaZvt
         FsYA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5HvxpyU/Y+r0beBps1FAKjqqUq7EQhC2RsNzSQlNeE7QLPdilsHmhSphVl+cxUCQd/Wmb7adjFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDtppe9dFCJw/xUp4psoacpunix2AR0a7Wq2FWpi03IffVziaX
	pE9LIh2r1sGKJHndI2iZljFzRYU1fcHJwpuKodxpeo5p4ruHsiIBgtZMUPpOqChyReGEtWNNHxN
	a7iZVqsoQkoGVLhBb4JZViE3fH+8xplAqWeg8fOTq735ilRCprjSTIY5O6pYByo0=
X-Gm-Gg: ASbGncsoZCzOX7srj+9OUfICKGWDqkQqHOF6S7Rt+QBEA7fS50IuuLKf5JtYeSRgmHK
	xwDzGlxQ4vCBtVNNwqSifTcjPxXNx5HbTn1ys6rtE32orqFFvkiPvDnTZgAtGKxx/7slsQK3xz2
	+TxcXacz9y8RfV5nTdSyqOpgnZJvbUozbq5e13UclfBGKpiS8fSUH/h+MEJ6YXQgajjLoWwxoFQ
	mjo+wxudQPaCgxVAbBGUpdLS5ocosKqxlqTCbiAin3pdu1vSFdo8LEQ9YKk3ku8UgDR7HIkosX6
	v3Y0tQubngaeEEb3b0gUdUdEPzlTjnAnO465SoP/HDHun6cIwDH6cyRAnUL8grLikY1U2e9PHaM
	=
X-Received: by 2002:a17:90b:5445:b0:327:6a43:c73f with SMTP id 98e67ed59e1d1-3276a43ccb8mr8454348a91.20.1756383009733;
        Thu, 28 Aug 2025 05:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ1xN1nH2+SOb4TBgCljRgNHYk41wxaH6Bv3TBCbiJASEGGgEmFVy9pBEJvSscYC2NVVceMQ==
X-Received: by 2002:a17:90b:5445:b0:327:6a43:c73f with SMTP id 98e67ed59e1d1-3276a43ccb8mr8454272a91.20.1756383009006;
        Thu, 28 Aug 2025 05:10:09 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:38:58 +0530
Subject: [PATCH v6 1/9] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-1-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=5849;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=8zvZqpFeuXSiqe4t+MpIJYoVCiPCsJm1Ov8cxUJVKCk=;
 b=jmYXpazt1LKuasdTDORWhr1cdImPInQgvTaDPJW/cJ43tD/9dbY47ia5cmphxGwxpSeg2YmcK
 zDj8ENLXIXfAy6GkNEgqDWx0QQOU+mh4pdMcKY2526d6HsUk6IKx2i+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX87BYjjAkTi1D
 TdUEsOe+0RadoRU2JVesG5LwHpSHWCPhgMnO9Lo3GZtGNgyh5mvfzscfZBB2K/kf4M034qJwFfU
 CCG2ZUFw/uHLJV52vgqtHZJCNccwtHtuTy8gXoF2bXT6Ss51UPtLoRHoIk7Mp2AOP0QkCmJ0R0Q
 WJ7oS2BZ39H3egko3kzS2XHvkeJn3VqcP1gTYozwMfqm8Prm7M+eXTxoa/lYSNyifh95JpQ0OnQ
 FYewflIEgy5okr6dd5H8vzrx0tpV0S4VMwuD0yveuRFx8dLgOcIiBCt9iQ35o9dhq8PRt+CixO8
 /iLeVfCMX1m4fxaIEG1TpXo8srAvzHvDMOtK8ZMw5NO4db/Tt+7Bb9Bv8xSfUlSeO+XSJNNcQrk
 CUPnmuhX
X-Proofpoint-GUID: 4QhxrN7K8ZgiwMOfFzHgwUeVn-2DBczq
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b0472b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=dWfasREweX4F4dHnDHIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4QhxrN7K8ZgiwMOfFzHgwUeVn-2DBczq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Add a device tree binding for the Toshiba TC9563 PCIe switch, which
provides an Ethernet MAC integrated to the 3rd downstream port and
two downstream PCIe ports.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..82c902b67852d6c4b0305764a2231fe04e83458d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/toshiba,tc9563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9563 PCIe switch
+
+maintainers:
+  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
+
+description: |
+  Toshiba TC9563 PCIe switch has one upstream and three downstream ports.
+  The 3rd downstream port has integrated endpoint device of Ethernet MAC.
+  Other two downstream ports are supposed to connect to external device.
+
+  The TC9563 PCIe switch can be configured through I2C interface before
+  PCIe link is established to change FTS, ASPM related entry delays,
+  tx amplitude etc for better power efficiency and functionality.
+
+properties:
+  compatible:
+    enum:
+      - pci1179,0623
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling the RESX# pin.
+
+  vdd18-supply: true
+
+  vdd09-supply: true
+
+  vddc-supply: true
+
+  vddio1-supply: true
+
+  vddio2-supply: true
+
+  vddio18-supply: true
+
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle to the parent I2C node and the slave address of the device
+      used to do configure tc9563 to change FTS, tx amplitude etc.
+    items:
+      - description: Phandle to the I2C controller node
+      - description: I2C slave address
+
+patternProperties:
+  "^pcie@[1-3],0$":
+    description:
+      child nodes describing the internal downstream ports
+      the tc9563 switch.
+    type: object
+    allOf:
+      - $ref: "#/$defs/tc9563-node"
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+    unevaluatedProperties: false
+
+$defs:
+  tc9563-node:
+    type: object
+
+    properties:
+      toshiba,tx-amplitude-microvolt:
+        description:
+          Change Tx Margin setting for low power consumption.
+
+      toshiba,no-dfe-support:
+        type: boolean
+        description:
+          Disable DFE (Decision Feedback Equalizer), which mitigates
+          intersymbol interference and some reflections caused by impedance mismatches.
+
+required:
+  - reset-gpios
+  - vdd18-supply
+  - vdd09-supply
+  - vddc-supply
+  - vddio1-supply
+  - vddio2-supply
+  - vddio18-supply
+  - i2c-parent
+
+allOf:
+  - $ref: "#/$defs/tc9563-node"
+  - $ref: /schemas/pci/pci-bus-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+            bus-range = <0x01 0xff>;
+
+            pcie@0,0 {
+                compatible = "pci1179,0623";
+
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+                device_type = "pci";
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+                bus-range = <0x02 0xff>;
+
+                i2c-parent = <&qup_i2c 0x77>;
+
+                vdd18-supply = <&vdd>;
+                vdd09-supply = <&vdd>;
+                vddc-supply = <&vdd>;
+                vddio1-supply = <&vdd>;
+                vddio2-supply = <&vdd>;
+                vddio18-supply = <&vdd>;
+
+                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+
+                pcie@1,0 {
+                    compatible = "pciclass,0604";
+                    reg = <0x20800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x03 0xff>;
+
+                    toshiba,no-dfe-support;
+                };
+
+                pcie@2,0 {
+                    compatible = "pciclass,0604";
+                    reg = <0x21000 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x04 0xff>;
+                };
+
+                pcie@3,0 {
+                    compatible = "pciclass,0604";
+                    reg = <0x21800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x05 0xff>;
+
+                    toshiba,tx-amplitude-microvolt = <10>;
+
+                    ethernet@0,0 {
+                        reg = <0x50000 0x0 0x0 0x0 0x0>;
+                    };
+
+                    ethernet@0,1 {
+                        reg = <0x50100 0x0 0x0 0x0 0x0>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.34.1



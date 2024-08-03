Return-Path: <linux-pci+bounces-11220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EF7946708
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F84281D60
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A46E546;
	Sat,  3 Aug 2024 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPTSKfh4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908C6FC1;
	Sat,  3 Aug 2024 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655478; cv=none; b=YY0DmZZIzLucwRxtFvWSQLiOvPCGKjIccvbVngSsHo4+ewmEqo7WaCsAmyjIv6XzwXHluyyaWmHJlPnkkBHKa4dm15n4zw488GfDf5ffLUb2XbFHOXX8NJuW0jbl4hyO3BcFaIR3zmaFfy1Td3NQGTrIomk54GJxXjSmYg3WeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655478; c=relaxed/simple;
	bh=eJ8UjGJSk1cQrUYQZwXrF5Pbxqxz0KOV/CbK8lo0w3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IrZgfu8L8QwXgpOIpu8CIvunk1+ZHkS7/fTHrZb1tfNArxtJENjW3MHqyJ1PN9FNzvqE59Dokh1A5Dz9leoFkw1gJaJPu8JtqdtwMyd4TkcGcdE1DO7UNzKErSJIBK2JRDd0jyqhkz7tLfuVouJba1nQEz0FXHVa7ow3jzy8HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPTSKfh4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4732j2oA008584;
	Sat, 3 Aug 2024 03:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uLW6EQ1Z/U0FrL/Kas5u4vHKb/B0BzUUAB+VtrRB16Y=; b=gPTSKfh4WbvvHtHb
	AECv4o3jFzpVpB00/zEBe+a6N1bKGtWUI36Ji+Ct+STFcK2Cn2Fmeu2KuMuiU/9w
	gNDDUGKErMH6IiaCDwK7OnDEQoPlKTd2KiJsz7Lfre+YdkUs835whpzBv1luCQ3d
	uqs2fRPU4kB4zLdWShzyLV6o+eeI63meMyBLYQ2cH9cUKUfGvMMfSSXKQkMPDg4m
	VfiRIksnHDaxFX9kaCbeZitrz0PV3NOgIwrmFOmTdfNPTtsYsWemjWP6I7s3Zels
	/xh4r92OfnEyVXIx3APAOlIltqtNeCqBfjwgFOQylCWp6FZhegp1y7OtUh3gAUdt
	UXuoxg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rjecb0ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:23:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733NBR4021649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:23:11 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 20:23:05 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 3 Aug 2024 08:52:47 +0530
Subject: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722655379; l=6064;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=eJ8UjGJSk1cQrUYQZwXrF5Pbxqxz0KOV/CbK8lo0w3U=;
 b=WezehRBLR9Eo4ZHlr+6vN7PNnfCEXzdlXnTVBXjsCRfo33+BU0NuJ9dMkeZlDm6dnbA1mhp0Z
 7PSif9ejFqzAOqlzdaJet6wu095iPEMco0fXdwZLc5ygTW2/gs05yRF
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gZNWCtz4hNaJ5pleODK_jMbD76MJ14D6
X-Proofpoint-ORIG-GUID: gZNWCtz4hNaJ5pleODK_jMbD76MJ14D6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408030020

Add binding describing the Qualcomm PCIe switch, QPS615,
which provides Ethernet MAC integrated to the 3rd downstream port
and two downstream PCIe ports.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
new file mode 100644
index 000000000000..ea0c953ee56f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QPS615 PCIe switch
+
+maintainers:
+  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
+
+description: |
+  Qualcomm QPS615 PCIe switch has one upstream and three downstream
+  ports. The 3rd downstream port has integrated endpoint device of
+  Ethernet MAC. Other two downstream ports are supposed to connect
+  to external device.
+
+  The QPS615 PCIe switch can be configured through I2C interface before
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
+  qcom,qps615-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Reference to the I2C client used to do configure qps615
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
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling the RESX# pin.
+
+  qps615,axi-clk-freq-hz:
+    description:
+      AXI clock which internal bus of the switch.
+
+  qcom,l0s-entry-delay-ns:
+    description: Aspm l0s entry delay in nanoseconds.
+
+  qcom,l1-entry-delay-ns:
+    description: Aspm l1 entry delay in nanoseconds.
+
+  qcom,tx-amplitude-millivolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Change Tx Margin setting for low power consumption.
+
+  qcom,no-dfe:
+    type: boolean
+    description: Disables DFE (Decision Feedback Equalizer).
+
+  qcom,nfts:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Fast Training Sequence (FTS) is the mechanism that
+      is used for bit and Symbol lock.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: pci1179,0623
+      required:
+        - compatible
+    then:
+      required:
+        - vdd18-supply
+        - vdd09-supply
+        - vddc-supply
+        - vddio1-supply
+        - vddio2-supply
+        - vddio18-supply
+        - qcom,qps615-controller
+        - reset-gpios
+
+patternProperties:
+  "@1?[0-9a-f](,[0-7])?$":
+    type: object
+    $ref: qcom,qps615.yaml#
+    additionalProperties: true
+
+additionalProperties: true
+
+examples:
+  - |
+
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
+
+            pcie@0,0 {
+                compatible = "pci1179,0623";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+                device_type = "pci";
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                qcom,qps615-controller = <&qps615_controller>;
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
+                    reg = <0x20800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+
+                    qcom,no-dfe;
+                };
+
+                pcie@2,0 {
+                    reg = <0x21000 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+
+                    qcom,nfts = /bits/ 8 <10>;
+                };
+
+                pcie@3,0 {
+                    reg = <0x21800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+
+                    qcom,tx-amplitude-millivolt = <10>;
+
+                         pcie@0,0 {
+                              reg = <0x40000 0x0 0x0 0x0 0x0>;
+                              #address-cells = <3>;
+                              #size-cells = <2>;
+                              device_type = "pci";
+                              ranges;
+
+                              qcom,l1-entry-delay-ns = <10>;
+                         };
+
+                         pcie@0,1 {
+                              reg = <0x40100 0x0 0x0 0x0 0x0>;
+                              #address-cells = <3>;
+                              #size-cells = <2>;
+                              device_type = "pci";
+                              ranges;
+
+                              qcom,l0s-entry-delay-ns = <10>;
+                         };
+                };
+            };
+        };
+    };

-- 
2.34.1



Return-Path: <linux-pci+bounces-16549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37529C5B42
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EC71F24390
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E02200CAA;
	Tue, 12 Nov 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M8IDAbN3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FB200CAE;
	Tue, 12 Nov 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423737; cv=none; b=pmtym25NniC5v0LGrOTDocRpGfwp4NoC0vcGgSp62ZjDc1zi/ugurk7Yj62DptXtVMxzT/gcDX9YBtGIBaF0n41zRMZuNEIaSImY5Fw4W4vkj85dx1Co910m0vuSlMXGNiWx6HYPdAaJv6YfByHeyBuN+4jtLc2vwl6decVNWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423737; c=relaxed/simple;
	bh=y5zwbwdP91oKRtbUAddeJWBahdA4vNRB9M41llfF0Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LBBXOaK3ObDQdZmbDYcvU7Zdeh50BT9X9funuVAunSuqHEJqvqs3srSXiVOj52x0upr8RtDIy4jZ3uaxb2kB4X3E/dSvslkGjSTLIz9kRUlOe2cfm/bltYTYSfvd4n27lKTQGCPgXhyg48PTkeft3gx9x8hF3fnFccPbq+1VXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M8IDAbN3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC9f0LD025084;
	Tue, 12 Nov 2024 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KvjTKyTC+nGvQjd4HOn2InSv+BQXoVS+uUjtShLLOvU=; b=M8IDAbN3X2Fxdho3
	4RO4Wo0+S4dH3UryVMx9o+Sx74QwtFjJsVylUi+VcpZG9dVeQBYekrDlu/Tsb53p
	2B3J/V7H091qJfljROLDpxyYy2hmjb3NELwavGMF3VrGvf6xsgeMpZneJkkQzbPj
	Q9+mGNSvwg4pwTAvEuxM2XY4IKzR+abnfsbOLrGZasphcUDzGIcPXM2f5FmlUcNP
	LGZkLMaR+Jubghxk++6n+JcU1deNY9k2jjFkvq9nAB/+nABs0CVE2dfk3tZi7/oS
	wHiZ3QacBoGZZTj7vAuF7lW8gyp+iYSRFL0f1ITrqA/oGixu0L8tXHrXXHR4Bcda
	GpoMXw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v4kqrsqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:02:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACF21RR001336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:02:01 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 07:01:56 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 12 Nov 2024 20:31:33 +0530
Subject: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
In-Reply-To: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
To: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731423711; l=6624;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=y5zwbwdP91oKRtbUAddeJWBahdA4vNRB9M41llfF0Q4=;
 b=pY8Dob4EXrVUj/kFO27BhLEZJSXXM0D7Pe/L3IIgQ172KGN2v5Yi6roDMwiHLynaj3IRpxQnF
 offEA5iYHX3C/8DDjqPYEyTlg8PJFrIWdLjo5xBOHCv00qolFwnCeGD
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PmCzQXWvbiNqBW5wePCktB8XY9DjhMvn
X-Proofpoint-GUID: PmCzQXWvbiNqBW5wePCktB8XY9DjhMvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120121

Add binding describing the Qualcomm PCIe switch, QPS615,
which provides Ethernet MAC integrated to the 3rd downstream port
and two downstream PCIe ports.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
new file mode 100644
index 000000000000..e6a63a0bb0f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
@@ -0,0 +1,205 @@
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
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      A phandle to the parent I2C node and the slave address of the device
+      used to do configure qps615 to change FTS, tx amplitude etc.
+    items:
+      - description: Phandle to the I2C controller node
+      - description: I2C slave address
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
+      AXI clock rate which is internal bus of the switch
+      The switch only runs in two frequencies i.e 250MHz and 125MHz.
+    enum: [125000000, 250000000]
+
+allOf:
+  - $ref: "#/$defs/qps615-node"
+
+patternProperties:
+  "@1?[0-9a-f](,[0-7])?$":
+    description: child nodes describing the internal downstream ports
+      the qps615 switch.
+    type: object
+    $ref: "#/$defs/qps615-node"
+    unevaluatedProperties: false
+
+$defs:
+  qps615-node:
+    type: object
+
+    properties:
+      qcom,l0s-entry-delay-ns:
+        description: Aspm l0s entry delay.
+
+      qcom,l1-entry-delay-ns:
+        description: Aspm l1 entry delay.
+
+      qcom,tx-amplitude-millivolt:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Change Tx Margin setting for low power consumption.
+
+      qcom,no-dfe-support:
+        type: boolean
+        description: Disable DFE (Decision Feedback Equalizer), which mitigates
+          intersymbol interference and some reflections caused by impedance mismatches.
+
+      qcom,nfts:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Number of Fast Training Sequence (FTS) used during L0s to L0 exit
+          for bit and Symbol lock.
+
+    allOf:
+      - $ref: /schemas/pci/pci-bus.yaml#
+
+unevaluatedProperties: false
+
+required:
+  - vdd18-supply
+  - vdd09-supply
+  - vddc-supply
+  - vddio1-supply
+  - vddio2-supply
+  - vddio18-supply
+  - i2c-parent
+  - reset-gpios
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
+            bus-range = <0x01 0xff>;
+
+            pcie@0,0 {
+                compatible = "pci1179,0623";
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
+                    reg = <0x20800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x03 0xff>;
+
+                    qcom,no-dfe-support;
+                };
+
+                pcie@2,0 {
+                    reg = <0x21000 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x04 0xff>;
+
+                    qcom,nfts = <10>;
+                };
+
+                pcie@3,0 {
+                    reg = <0x21800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x05 0xff>;
+
+                    qcom,tx-amplitude-millivolt = <10>;
+                    pcie@0,0 {
+                        reg = <0x50000 0x0 0x0 0x0 0x0>;
+                        #address-cells = <3>;
+                        #size-cells = <2>;
+                        device_type = "pci";
+                        ranges;
+
+                        qcom,l1-entry-delay-ns = <10>;
+                    };
+
+                    pcie@0,1 {
+                        reg = <0x50100 0x0 0x0 0x0 0x0>;
+                        #address-cells = <3>;
+                        #size-cells = <2>;
+                        device_type = "pci";
+                        ranges;
+
+                        qcom,l0s-entry-delay-ns = <10>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.34.1



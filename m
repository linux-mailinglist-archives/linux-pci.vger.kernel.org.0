Return-Path: <linux-pci+bounces-22301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9CA439BB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6B318903FE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3326159F;
	Tue, 25 Feb 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IwL/Tehi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32918261373
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476079; cv=none; b=AnUmX5Cgq0kaPeJxagSOuWFpSyMJBHlO/0BGt0xWvbsVOdmiDR7Pei7R8hKgRexArsnb0nlplPGal2BioJ4h0YBfsQSgGkUd6pOrOGZcNjQhqlHTeIOOZbIanpTx9vH6FhE4WjhS5uk/yCwC7wTepO4YePv1zQIH9bXN29jCV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476079; c=relaxed/simple;
	bh=VMaieC3p7d7h+BKd20qmksO2FRNzpQZ5H7nxfFEYOIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCtYDNjWdIxe3slTIMZW1S6GJ2I3T61qGJprGyrsG5PuZEE+EzXealTBtAduPrbwsJujMaoFOI4gdUES9cm74EAexVqSA1G/GXrvV7ivPBWLGj6lfkMOk1FcagDkIWpQ6zhiPiG4X/X47KqVe1ePvYnhkdID5f4ArXmka1soLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IwL/Tehi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8F6he013490
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XsE5WvYbRTtHjWkWh0b8hh2A7z6b+pDn2VzrFovXRtY=; b=IwL/TehiJt6ARZuo
	Lb2dSAuX0wa1UEXr1/ds4U/0OLDjatl3I+X3xqfPk4QVzmc7cOt5KiFB1lUUhcnP
	mk9FtHJcbQidYH8shPKXKSrY1L9kDI/j9uv1WhDMukA6wGj4SR4R+2ZEd4SEBqbo
	VE2uI1PlYe77fRKoNnCkYG5PgQpGHYAD/DNR/97pClKkQgtghJdnp2JHx/yAxYbi
	OTcgLn5uBsTcT/DracVte1crgTJMfE/ROOBcfG0FLcrub6lHDPH4mUX36s7tP2OR
	zz5i/n5VgaiLMGE93uYZkfowkgJ2tnOHT5vK314m/7JHoR1GhSWAcVnEf0e71IFT
	xanhKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgrdrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:34:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so18177217a91.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 01:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476075; x=1741080875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsE5WvYbRTtHjWkWh0b8hh2A7z6b+pDn2VzrFovXRtY=;
        b=EpVaCNAiVf0DRBpKq1c+IwM0mBXOPwLYqaG/qyc+wyE2f1eOYmCRrguQeoVY2F6h/r
         eo8RfVo5QcK1nwBLA22EjceAWvfkDqN5bFG+VHBSDbEn5Sbf547psMWb4tKyRmS/N18a
         /ZaJLK5dVvcJtWA9Wpj6sEuPdCHzQ8lXdRgd/nGvMb9e18p0zQU8ugvbfFdsCsHufebI
         jPl1yNxJzqfr3T4GGNAI6ymZmRGWQqYWps0JuL4jADqmAgU5fp4yQD1fwH7GrN/u5kHT
         Rzlj8ww30WZ/5zbuG/tkv+f6Ox1/5vOgJbvYS911rGAlfhXj06ykmMZx1KFUp5Ctlfy5
         V0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDFT2cbLats8fo5NA/1J4jnCW4gUSbdwkmCVI9JutQLYPrF1hpap71feyMbb73++cxLJOMmz3EO0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RJ5xIEE4Ei7vIrvPbCDBut00BEs66OrPoWqyZmKOn+n+PeMc
	66VTapFUAwBO1oeLmUCppmGRUuzcpQHU99hB6s1qYaEY1j5VdtO7aea3345cqaLFD1URl+p2g3Z
	IZbnqQNWYceACRcsJXDSvWt6UGOBwQVYkYQvAb3ysLaMhub84kOfk1DPHwpw=
X-Gm-Gg: ASbGncuTPRHeWpnca9gS9LOFjX77Yo/7LSWENVO8Xhqn6BLHMQ/cI6l98TVlK2cdbcp
	OpvooBg9EfbBs86hZr6j48eZZjgFs032iuWwpLx9YaoZlBQAeFXvUbAqFXBt+uRWOhBgfRhrf9G
	netvg+Ukreik8E7VW+ZKTBZHd3dYPTjha55AvRl9lgHzRWofLt8Esc+yflZnrSRuvmxb5T3LYJO
	y/1QnJKjzGpJuicKLbvQWusUPId+h6mck3hv1WOXENUB/RYfI1I/B3R7gz7JODKFd2st0eGR9Lk
	0raY1oc2kvNpMfo+v3oHbC5mox9qZWoe9HnkZPVZdMENZ1WraEM=
X-Received: by 2002:a17:90b:38c3:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2fce779ffaemr29343138a91.2.1740476075245;
        Tue, 25 Feb 2025 01:34:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2B59jUe1Exesv/ylkZfCZktr0zWjqiDai3G8L/s1PyuX+VDChVsAlOE8MCqL5yJAHAxFlGQ==
X-Received: by 2002:a17:90b:38c3:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2fce779ffaemr29343108a91.2.1740476074810;
        Tue, 25 Feb 2025 01:34:34 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1080770a91.20.2025.02.25.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:34:34 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 15:03:58 +0530
Subject: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740476062; l=5709;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=brkFgGbvu8Si1vNLuH/EyodmI+pPyxs89QuPsEBMO1M=;
 b=8VJIODrxDNySrUb8DA3brne3D67GwyM9bxMEYuBbY/IBld+zlE7Q3K59qObaWFZ78uPgyN+zR
 yjnkB/X8NU/D9ploAU1/XjeUiKoEQdlY9d7mdqAagOnOI4o9YZUgREw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: mkBTNilHXKHoq7SteiZw5PSQ-9Tw1O-b
X-Proofpoint-ORIG-GUID: mkBTNilHXKHoq7SteiZw5PSQ-9Tw1O-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250066

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add a device tree binding for the Toshiba TC956x PCIe switch, which
provides an Ethernet MAC integrated to the 3rd downstream port and two
downstream PCIe ports.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
new file mode 100644
index 000000000000..ffed23004f0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/toshiba,tc956x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC956x PCIe switch
+
+maintainers:
+  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
+
+description: |
+  Toshiba TC956x PCIe switch has one upstream and three downstream
+  ports. The 3rd downstream port has integrated endpoint device of
+  Ethernet MAC. Other two downstream ports are supposed to connect
+  to external device.
+
+  The TC956x PCIe switch can be configured through I2C interface before
+  PCIe link is established to change FTS, ASPM related entry delays,
+  tx amplitude etc for better power efficiency and functionality.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - "pci1179,0623"
+      - const: pciclass,0604
+
+  reg:
+    maxItems: 1
+
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle to the parent I2C node and the slave address of the device
+      used to do configure tc956x to change FTS, tx amplitude etc.
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
+allOf:
+  - $ref: "#/$defs/tc956x-node"
+
+patternProperties:
+  "^pcie@[1-3],0$":
+    description:
+      child nodes describing the internal downstream ports
+      the tc956x switch.
+    type: object
+    $ref: "#/$defs/tc956x-node"
+    unevaluatedProperties: false
+
+$defs:
+  tc956x-node:
+    type: object
+
+    properties:
+      tc956x,tx-amplitude-microvolt:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Change Tx Margin setting for low power consumption.
+
+      tc956x,no-dfe-support:
+        type: boolean
+        description:
+          Disable DFE (Decision Feedback Equalizer), which mitigates
+          intersymbol interference and some reflections caused by impedance mismatches.
+
+    allOf:
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
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
+                compatible = "pci1179,0623", "pciclass,0604";
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
+                    reg = <0x20800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x03 0xff>;
+
+                    tc956x,no-dfe-support;
+                };
+
+                pcie@2,0 {
+                    reg = <0x21000 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x04 0xff>;
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
+                    tc956x,tx-amplitude-microvolt = <10>;
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



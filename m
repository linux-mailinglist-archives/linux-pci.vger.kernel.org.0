Return-Path: <linux-pci+bounces-9300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1C918106
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101A31F23F3A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0265181D05;
	Wed, 26 Jun 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hUyxviVN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354611474D4;
	Wed, 26 Jun 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405494; cv=none; b=W52jtL7YSZ2CW5YGHDNr38bYoj3jwy3Q/C2ySSBNRecWs98hMNi3Uv6XjgmJMcGBQVhTb3icN9HCXrnE2qIv7WlQ0mkQhga+Z/RIzJlkp9DLk/fcDZKW5g8iW8U5c7t0ntVvJLWA5llHRc/TN1GAB72YyG3Wp9/O9ZOzzC+76Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405494; c=relaxed/simple;
	bh=/aw0WtwPmVZySBFz2H9clszTt8P3jzZkMlqbGcwPdoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nVF5O1re7wKwdJm7FverIaaBlRkou+DjoD5gTi/3uPzIBRi/FWXYiURYIkBu+HAeMQav8r2ufOH8okRa0VaOmRkBJEl7Q04KF7EEpsXPJN76BLyokvribAmHj7zhnzi+pLeXs0MqIAxQ7krrGd1YXXg1UHkUbRqzIUxb9FejmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hUyxviVN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfx0T023802;
	Wed, 26 Jun 2024 12:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ym+MeZBsyG1LqJ0E152Hbacte6hCq3neQexQF+Tmao8=; b=hUyxviVNmmKlMzCk
	wUVWrrFuwcMwpwQBNqEegYLpPJxuVOroRxTpcQntrWl+jYB2Hpo80Ft+utF9aFCa
	/L3taSHVgrxHX0P8w0Ni3h2NcfgXIVYW/kcMYHB3WJcag/TyO3S8CJZRnUbD6D23
	htusbGzKgoXdLFRrOJNHkxgEQ/sllJnhWEQmWFmr0YOaIuro7M10VjsiQRsitiHt
	h8YX9c+g3nuzpGlHJRiCtyWwbKX36JVZz5vVI2Dh6ETxw7HTsrquOmA0BpkezLNv
	qe/PbPG3tfNhuXA9Oil3R1eurRtj27/KnZYU9SoIgnS1XMu17CkVLFUHBroZDFwE
	+sHeWQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9h4rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCc1Op011726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:01 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:37:56 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 26 Jun 2024 18:07:49 +0530
Subject: [PATCH RFC 1/7] dt: bindings: add qcom,qps615.yaml
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-qps615-v1-1-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=2476;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=/aw0WtwPmVZySBFz2H9clszTt8P3jzZkMlqbGcwPdoI=;
 b=DXkeP/a4jyMBskUt3dtXDg5vn4ouKucKv75saOW7IjhogYzEQO+CWEfTIyiqg97Hw4sxPAJQY
 J0Bluq4gh5wC6v1PLa1X0tod4887sWejSjKVfX35v6RthJkGumkn1Ne
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: luvrWw1hPqj0IRKmVmZaB13A5VcNCPqI
X-Proofpoint-GUID: luvrWw1hPqj0IRKmVmZaB13A5VcNCPqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260094

qps615 is a driver for Qualcomm PCIe switch driver which controls
power & configuration of the hardware.
Add a bindings document for the driver.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,qps615.yaml       | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
new file mode 100644
index 000000000000..f090683f9e2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-qps615.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QPS615 PCIe switch
+
+maintainers:
+  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
+
+description: |
+  Qualcomm QPS615 PCIe switch has one upstream and three downstream
+  ports. One of the downstream ports is used as endpoint device of
+  Ethernet MAC. Other two downstream ports are supposed to connect
+  to external device.
+
+  The power controlled by the GPIO's, if we enable the GPIO's the
+  power to the switch will be on.
+
+  The QPS615 PCIe switch is configured through I2C interface before
+  PCIe link is established.
+
+properties:
+  compatible:
+    enum:
+      - pci1179,0623
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Phandle to the vdd input voltage which are fixed regulators which
+      in are mapped to the GPIO's.
+
+  switch-i2c-cntrl:
+    description: |
+      phandle to i2c controller which is used to configure the PCIe
+      switch.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - switch-i2c-cntrl
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            bus-range = <0x01 0xff>;
+
+            qps615@0 {
+                compatible = "pci1179,0623";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                vdd-supply = <&vdd>;
+		switch-i2c-cntrl = <&foo>;
+            };
+        };
+    };

-- 
2.42.0



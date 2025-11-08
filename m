Return-Path: <linux-pci+bounces-40609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F03C425D7
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 04:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C23A43E6
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7152D7398;
	Sat,  8 Nov 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VC8Zbcx3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAFsaDUK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0A2D641F
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572229; cv=none; b=RTNkizBI9fxor1pHLO4rYfoYF+mc8cJPmr7hTPiKBQS31m6OsGMlHyPsNhxF8XB7Nv2S554+nk5H0JUh15RU0DJGzbji4XgCwPBye5nnGkps03Wq2i/fQDba0ebQJPuEju6SHG3yOzaLzONWJC0RQXlINvPYhWEtJCKRjvagTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572229; c=relaxed/simple;
	bh=RgUlDFA8EMEpttKlTDJYobiWG40v64BIS8+KI3fKgXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PLQaO6g/YBqOtEPycBdHh7T1pUhOWsUo77dpa8lUsTO+8OiZveY/H16ugUZeUO9SIycaxSxrTkVw4T4gRDqC5GcfCkQM/KiT66x0EtAT4wTbFnggCXIKXQa8xYaMrkTfQNVfXIyrXqMr/lT6QIrFRxVKBRTmx4XInOf9dENzDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VC8Zbcx3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LAFsaDUK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7N2khM292065
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 03:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oMN3nMFr3c2WRD8oHMsK27DUEcxtRmnExaVK596aUtk=; b=VC8Zbcx3my/xHboV
	gGlYEVRQS5i4L4uPLISiP2+rMH+VVoT2j/ScgwrhFQO4EKJHJ7hMLa84jdZYdlvX
	IIwHfAIKeIrfPOxVuRH4+JFtPEU15ckilTgyqVPfDR4k5r84O2+vSYSRjySEkNdt
	ZzFxcMh+x4oPepue3bOqDpxjz6Vdfa7LHoVbSMWTHqtICW2acaBP2nAbUpkblexa
	TU8rBVugrTn11jYaoItTnmI0ScIeH5Lg7sRjZ+vqOY/9/l66Wr/UfKT7qindPPUn
	3m/aB13LtZmIUcmWKwp5v7NXga8MCN6sIprHFgZn/4ZsxZAsmBkMlLRfkLZUdhWw
	yQUGaQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9t3d8c9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 03:23:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso1401604a12.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 19:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762572225; x=1763177025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMN3nMFr3c2WRD8oHMsK27DUEcxtRmnExaVK596aUtk=;
        b=LAFsaDUK0D3NKgSXV+qLPyVQ7mmNqs25lmR8oAcJKtdqvfvQX8QnkXRZQqYnbuY9lt
         +14IhUUzo+9dXG6Bmab2Y0BYFEj5gPJn3+ltDFMSI8G6Qz5IKL64Ol1XSGvXN1yke3td
         fpPlIgThHeEP5I2t4JysjX5HNsKSf/2+c4ivjL+HlUceGeslhvrsAr2xFXUowcZUcTn4
         BG2gOVaOs4mweQ7DCnMdvuEyEKTZ+ZRV2SjqHZuvEJ01JmwcQMHOEOSsjATqGMWyaRFj
         OvOzfPjwYBk6KXrU5rSMqhK6hct4HXFwuPEXA1Hb2uX22TZkzlg5+qlqJrXxrngPAxyw
         eqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762572225; x=1763177025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMN3nMFr3c2WRD8oHMsK27DUEcxtRmnExaVK596aUtk=;
        b=uX5Ozfc8n1pmqfBZJTll3kzb2BZSpdyba3N4XBc+xd+37wGZ7hl1nOtUyo8Q7q7TKv
         i+5y9gcfB0NvgPMnV5uaiFdvulT2wTNPozdlX6CGHdtfXWA036Ib8qS9QYP+ttQT1NME
         KTDixPrHblQiwo65mDzlgJg635riQQv+fvMarQafOXSDpVoq5LUPKytXEbTl8a+6VGci
         onP7lx7IG528hb/rKUQzGRFfYDJYVdW5xZmfw0ooQNbukzrKkvOqPVprjyLqLnYEbQbR
         /03BNtacpHrXT+S+16m7Nu0+AwVsZb8u4gQh+dw/A1s7Ql2d57yR6SC++alp7vZplXfe
         ABGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX93Mgcc9f/ccoEkhB7uyD5fiXXe9yW5aevzb3iJY4f2qi0QynUt7wmQLY03aVQVSZu239kXzubZG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wqnV9TjlUBtLXtNYiLUQa2cGojhXTzzMuarCnKw/pXxc3BHv
	YAQuqyNuf8nCJ8/Is9Fhuurt656V78Hc5EWI5kTo+VKc8Z1Ik9/OOM/Fyjr5/pq+sUljfKkonas
	4pQ0KkI9Ejylv4Xo1MwExFmK+yQFdP041eW2H2Mu2hX1bwHbXPr+Wj9pTwYOjECA=
X-Gm-Gg: ASbGncs1CeThz0syxrf765F4R+C00XXNa13q8qAO/e4/sftRe1HLuyitQdH04gZgD9n
	iB6qnlIx7n+fwOWxkWDA/lS3aPy1nXVcqOqOanFF9FqE3B6A5Q/oUxzW/i8bieycoMvpHNI/Gr5
	wvhvg/8JdsIqAjVIX06SbubyRbMoP9mQ9xBryqArI9jvVRT+qNKd12B15lvJNzVpLtWTnHFWC0u
	Oq3Az73Bqb6jtLqD/mZKYCeunQyRKPAycQJCB7pTqLC/3q3XZuviOfMTDom6nXhfE1dg44Tb7+t
	jz763+pdpCn9VulSZrgFSTK4/up7yDWj1/TAbnP4fu1Mfymv8d7r5sa5Pi4NdaZvEfbWWhFGnnk
	vf3lPtsJnOHsX71pGJKC5IhYxuPWg5J0=
X-Received: by 2002:a17:903:3848:b0:295:f95a:5122 with SMTP id d9443c01a7336-297e5627d72mr16515755ad.15.1762572224799;
        Fri, 07 Nov 2025 19:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsTYIVRT6qlJmjHXf2NxiivBAttXUJZLK+Ny9ctfC528cmK1JB1gu30Gksok82PPLNbrsv8g==
X-Received: by 2002:a17:903:3848:b0:295:f95a:5122 with SMTP id d9443c01a7336-297e5627d72mr16515415ad.15.1762572224255;
        Fri, 07 Nov 2025 19:23:44 -0800 (PST)
Received: from [192.168.0.104] ([106.219.179.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm19942445ad.44.2025.11.07.19.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:23:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sat, 08 Nov 2025 08:53:19 +0530
Subject: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 M connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5568;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=RgUlDFA8EMEpttKlTDJYobiWG40v64BIS8+KI3fKgXo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpDre1GvMNdkcH834eeaQi0dzjSPFMgOPJLsZrr
 kqV7yzdmSSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQ63tQAKCRBVnxHm/pHO
 9TxaB/wKoCDbnIVtlKnvrC0nKe2cZ87NEsY/ntIMxbCHBSjSAILq7lEOOFd7lR4nixLSVxa0+vS
 U5RqimS6nqaomL15YF44QZEG8H+DE8rYTN/mwZybQNoczyhu8vutO0avGNPRL/AwCEBUNXIvw0K
 rJRl581SD2zGZyiv9bU6fKxGl0z6z/jqls4fIj28QUsKxB0iP0cNM29jC6I7drtQWJkqRES3Cq0
 DJWcMwKSYLZ/l+bnjH91W7eLsrrE2HEVpt4Al0iWafIPX5jJxbVcWZWvKiy6Mi3kUUSsDN3EKLj
 oXsvZxvJtikNmOpkvFIMfRoehMGwKU2AMP/xVbzdLQJ7oET2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: MiwzipyYFTYVQVKDNrcWW9CRqb0xGvxp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyNyBTYWx0ZWRfX2CDygb1/2oHY
 VgDUz1OhxZPUa+1DJJ5VF2PHm7h4RixKWB7/ULq4qbxTfzBFls3T+7AAcUcvhqlsRRrujnmoKKw
 0TvW6HebQRg43JTN6rDhX7lZOhMsHs0uzrSqKrkr0oZx8y3n/YooBlbxKRPHFFLnucVXTosayEF
 /2xixlCeupnBR3aegXmVoa6GgeiggTbEZrWSEQVZMIRMs8MtfLAqKa/KAcAFRBIO2RMbVcrscug
 e5MDLY01V4iv62IUZqZN/SsLGo4Q5YzXrKk59Vivy6AQofNGkIfck5RpeKM95MMuluQwfWtRNW3
 W7TFm2BaAqq3oI3HwzaZ1ytyHUdU0iAEvvDX/dheTshinah5QX9NEYGBYtPgj7Wsw5QeNJHfpGJ
 4BrjI2GPcSVAQm1g+eYBCCNzeK7wTw==
X-Authority-Analysis: v=2.4 cv=dsnWylg4 c=1 sm=1 tr=0 ts=690eb7c1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qronr9GGDLuyXDLutoyxMA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=wQxqEM7SeJhtJFFEbD4A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: MiwzipyYFTYVQVKDNrcWW9CRqb0xGvxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080027

Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
provides interfaces like PCIe and SATA to attach the Solid State Drives
(SSDs) to the host machine along with additional interfaces like USB, and
SMB for debugging and supplementary features. At any point of time, the
connector can only support either PCIe or SATA as the primary host
interface.

The connector provides a primary power supply of 3.3v, along with an
optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
1.8v sideband signaling.

The connector also supplies optional signals in the form of GPIOs for fine
grained power management.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key M Connector
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
+  connector. The Mechanical Key M connectors are used to connect SSDs to the
+  host system over PCIe/SATA interfaces. These connectors also offer optional
+  interfaces like USB, SMB.
+
+properties:
+  compatible:
+    const: pcie-m2-m-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for 3.3v supply.
+
+  vio1v8-supply:
+    description: A phandle to the regulator for VIO 1.8v supply.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Since a single connector can have multiple interfaces, every
+      interface has an assigned OF graph port number as described below.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: PCIe/SATA interface
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB interface
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: SMB interface
+
+    required:
+      - port@0
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  pedet-gpios:
+    description: GPIO controlled connection to PEDET signal. This signal is used
+      by the host systems to determine the communication protocol that the M.2
+      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
+      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
+    maxItems: 1
+
+  led1-gpios:
+    description: GPIO controlled connection to LED_1# signal. This signal is
+      used by the M.2 card to indicate the card status via the system mounted
+      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
+      details.
+    maxItems: 1
+
+  viocfg-gpios:
+    description: GPIO controlled connection to IO voltage configuration
+      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
+      host system that the card supports an independent IO voltage domain for
+      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
+      3.1.15.1 for more details.
+    maxItems: 1
+
+  pwrdis-gpios:
+    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
+      This signal is used by the host system to disable power on the M.2 card.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
+    maxItems: 1
+
+  pln-gpios:
+    description: GPIO controlled connection to Power Loss Notification (PLN#)
+      signal. This signal is use to notify the M.2 card by the host system that
+      the power loss event is expected to occur. Refer, PCI Express M.2
+      Specification r4.0, sec 3.2.17.1 for more details.
+    maxItems: 1
+
+  plas3-gpios:
+    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
+      signal. This signal is used by the M.2 card to notify the host system, the
+      status of the M.2 card's preparation for power loss.
+    maxItems: 1
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key M connector for SSDs with PCIe interface
+  - |
+    connector {
+        compatible = "pcie-m2-m-connector";
+        vpcie3v3-supply = <&vreg_nvme>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                endpoint {
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+        };
+    };

-- 
2.48.1



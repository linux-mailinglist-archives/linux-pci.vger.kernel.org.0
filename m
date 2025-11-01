Return-Path: <linux-pci+bounces-39989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5FCC2770B
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76C394E36F3
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6E264614;
	Sat,  1 Nov 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARCjd3mR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G2jkhru/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E812261B9C
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969591; cv=none; b=rEe/Bxwv47yrUGOTu+STju0wUvKSoXAUVGNli5RzA/0pl/5BjOCM8PUibXAHWMZnGSNfVtOletcV9GXT7acg3W+UtmYgtJzi4N+X5dRv0yZiHBCvPpqY/emiLe/FrnCXcpbLLd3qJLk5gEhHiP4N52e6PFgx4E1BGTl0yWBX/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969591; c=relaxed/simple;
	bh=Yx47/v7UP2S9t4kbCJoO8vfIzHGQNKl3EuLxc5b7Of4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vcy5NAX0frtR6lRvm2dTl2vv5MO2K0KdgF4mWanSDFHBO8gKuixJbti+TM1BkyOSokmXTWLD0iVeiXrPY6kccTu/v1PVEf04HW352H6BQ0hS1J1Qcnvw1KYcCJDkcB2eat0Xi5Z7OPuVAVLZsB8+1q+2yJk6wunxTAgNuKAKixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARCjd3mR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G2jkhru/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13YfCZ428182
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 03:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uOuNrPNOxNtGjbqecQTezoMALC4gh5guIoDEvWHDAF8=; b=ARCjd3mRjjR+xne1
	2cTg7UmlpSzqP2pV5LVSpc3OclNEYf9+oXaVE6dFalPb7wY9gYGGM2AGB1qC+xzs
	qeNv24mCaZTUd8RlwUUP0yQZ3dfQz7xCz/snR3/tQXwf2Ht6AoMxcE8z1LzNJfq8
	z0Vlpb0cgfzQ/XYuOeIkWdSAwn3/0Kg6jHStDmAp7WVgtKYFoOiKvb5VXoGZOvPD
	iGOB0m3oX4ez7VM3wDZg+1H3Jf9u0Ams14giD6Bl3inq1arClVorKIkNl5OjRux6
	yP73RPqexEyceFzTtY+HvMp2NPpn56N05NJDEkuLLaVSE9BIyrFQfhh6R1ajrSYD
	bOPtXA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ae300uu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 03:59:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294fb21b0e9so23589025ad.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969588; x=1762574388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOuNrPNOxNtGjbqecQTezoMALC4gh5guIoDEvWHDAF8=;
        b=G2jkhru/RMUNB7Ml08cXmo73GunQHXOIyz2khe15x2rF20H7H7qEPQ5vW6dFQtkp7z
         Xn7Cl0BcMmlDNizDYiV1E31cbxkC3LodUbdhsjrsnPaN69Xbx6Dk4thO9TWkIezuRDv2
         gyGA364CHgU00yXD/XVHhkb0NSDGu+hd0vX5AzVVPFvF457BSbNxWO6Tg5fRew7DoNu4
         Un9rx4almR3XZhcaFUuejrwREfF0nlWZtHh8Ekh6zsztMrJud1miUxHdAuSmYPvDSbib
         soXZxy83Gl4n8cRuQiaej0HPTlrL4BIlDGrFbenvQCloCJy9XWhVBRDLvCnOv3WGhW1f
         NfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969588; x=1762574388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOuNrPNOxNtGjbqecQTezoMALC4gh5guIoDEvWHDAF8=;
        b=JrRLiN8Kz03fBkL9/+BEmleI+2/jgoh9ilIXreJNsWCz2jkWHN3iirKbt3zCgFJ5LF
         9u6hHgcp/5UJSAJPJX1PQXhjbKN/6jg/OuiLT4wLmWyKo6w0pAHL0WG79qRFH//PIn/S
         xjRMg2T+UD1MWvMiFvFlY7p/SNRjbmjhocc3pvti1vrAHRhy/XzRvJ7D/BUnHK6Zmy6x
         vJIwfmZZY8XMd8o6RYncyArtx2YYwrSUvx9QMEWvWOJZtIbvilXCPMF/w5IWk9vlmyuV
         M+btEXsKtiMsi27GIdC0Svt2xbwNk0/6aWcZo5OARV5E/dyrPLCi1FwrGACuJV/pGgxg
         WVnA==
X-Gm-Message-State: AOJu0YzFt0xQ0F9J6bILbEas1dGeiFbY7a+44BgjRBx4/RjOjenQq0Be
	2qNVwS12bb+9NsbT9YgkFZSlu1ISfmT1da1Ye5cZubBSVMvagxq+gFLe5AnoyJZ8oBriI3D2N42
	1DAC0fWvz3ti9NKGh0lqDxRrMN8D5srnqQkoO89exRw1+D+/A1Bih6GvSKvpzZSk=
X-Gm-Gg: ASbGncv31z2r7NQA3lU4nDihtDq6T2d3kq0XJcbMH6McduShrXmwbDGF0u7hdtsrh48
	Pr0vhb78XTZt6yKIiipbS2GKndCnFvSnPkJdD7CjLe4h3J0LleuC9ZdVLxlCfhOp8zpqN6uSn50
	WWYC9ATL0GybENRQKWLfdIJNShoxQlMIYT0Yyy2mqnIgIc/aNKUl6rnOH2rxfMfAa7NsKMu32mV
	hqEgWjkj544xmZvWdHo6QLAOJAUWxMumQVkMldr560GO/bvjTiF91EXx/fNfJVmyIpT/NvwlxVL
	/vkMfcB1frIAqYvEEL+77/Jf3FkqLsUlNoKxVuo9B/E/HCTVBpo0DTWwZ/8bov0PIp/mgAYGM6t
	Azia85T/J9GokDr0QuvyZzkUCcGWquPTj3Q==
X-Received: by 2002:a17:903:234b:b0:295:3e41:5aa1 with SMTP id d9443c01a7336-2953e415cc4mr43463865ad.21.1761969588181;
        Fri, 31 Oct 2025 20:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEou51Q4Z7vnpG3VKsqD3DPTzo9lSyIzhBdN0I3SsB9JhOkCBLILKQLgfWf8OK/OV1KgNHzng==
X-Received: by 2002:a17:903:234b:b0:295:3e41:5aa1 with SMTP id d9443c01a7336-2953e415cc4mr43463495ad.21.1761969587623;
        Fri, 31 Oct 2025 20:59:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.20.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 20:59:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:32 +0530
Subject: [PATCH v9 1/7] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-1-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=5917;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Yx47/v7UP2S9t4kbCJoO8vfIzHGQNKl3EuLxc5b7Of4=;
 b=6ZhmnVVExo5QQm+sgn0bDG4eLmae4mGL05kLPko5sybEGRHO3CWJHXMYEewwqs2/nLEBHxP7O
 HGjTNqhbVXFBxs24h1ou4jhppEtQOBNYvV9bsEbxJwwqdsHmvZJaGzl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: eL_r7dK6YgIj2JhQSwMHFVmg9PGUO6cG
X-Proofpoint-GUID: eL_r7dK6YgIj2JhQSwMHFVmg9PGUO6cG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX0cJw7cz6oYTB
 mPza4vD4QPlTKn0oUk5rlgV2ihoMKSdGidV7LxlEEovKivzsheEXa2404F2AHxUdodF8bNkF4T/
 9FfuqM+M5mJzmHBp2aswkxg2W78N63nuuXBV7k+J2dd59KeApi6mwd6TVBNWQvEbPsBekLdg7GT
 InBPk9Es9/kzOM8iKu14xtjuGB0td4Re+H6DjdNh9Fd/tyO2GVvk1jAIBuFxQ1rteSM8oRFmSFe
 +jFtKhF+xINA0SARta18NvfZmtt+WF3j2mltfka4ExDxa6FNgqMXiUY/QKqx9cBS4pXsinXOv0K
 jRJCrn81V23VDgzrZEeY0HBf+zNXy9LDSMkcd4DNaj39K2w2sRqIMF5K5F/Y/smnqBVttm1RioJ
 7w5feAjn6R3Fz/LVV7GrDxrsogBv9Q==
X-Authority-Analysis: v=2.4 cv=CfUFJbrl c=1 sm=1 tr=0 ts=690585b4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dWfasREweX4F4dHnDHIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

Add a device tree binding for the Toshiba TC9563 PCIe switch, which
provides an Ethernet MAC integrated to the 3rd downstream port and
two downstream PCIe ports.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 179 +++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fae466064780959833e7102164a124086bd9099e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/toshiba,tc9563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9563 PCIe switch
+
+maintainers:
+  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
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
+  resx-gpios:
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
+      used to configure tc9563 to change FTS, tx amplitude etc.
+    items:
+      - description: Phandle to the I2C controller node
+      - description: I2C slave address
+
+patternProperties:
+  "^pcie@[1-3],0$":
+    description:
+      child nodes describing the internal downstream ports of
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
+          intersymbol interference and some reflections caused by
+          impedance mismatches.
+
+required:
+  - resx-gpios
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
+                resx-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
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



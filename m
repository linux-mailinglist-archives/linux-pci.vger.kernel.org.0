Return-Path: <linux-pci+bounces-21949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F31A3EA2E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0083AF259
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC6156880;
	Fri, 21 Feb 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6dKqQ+Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1314900B;
	Fri, 21 Feb 2025 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101902; cv=none; b=S0eNBStmvhp0nW5s/NBfgqP/TqTbfJENP0tDw5TcFxTWPO8/FB9N8sEti5quwSUCM6x9mg6F3Ph/QOJRLVK+szvw19ZZ7dQRvE62vW7Fi3cq+RJzzczJMo+FVscxAnInpyTV2+rbHjGIwtYWbRh9KmhZnyNApjVryFGRynaFbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101902; c=relaxed/simple;
	bh=BD9KdEXsrlMdRk3WhhadsPYsdk4Zdoh4Ky7iC5f6+2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfrmwIIiWmYdBrAk11OzxWxLDprOp6oC0o+S4tI3gA13AxmNWQFAPg5rR8u2CdmRI4qxN/7O9U44Q8D3gCgi6Gvhctg3Q9nwMPKM8o6d/MTQdd1IIqUuim6sAH+RdrVubytTRq3JadQJivWsl7CijAKMb9l/EgAbPDOeIzUul/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6dKqQ+Y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e67f377236so12626206d6.1;
        Thu, 20 Feb 2025 17:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740101899; x=1740706699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7LTcAf+ZyZRbj1wIT6OJpobzFlxe4+MXo9izwg7tN8=;
        b=D6dKqQ+YjhUHPIBCRnHAdtrJx/N0uepVkzSNArdS9eFgsTJ25icoO4KpNX8jN4h2De
         RcVfzSclkaPKEw1Z3UJ6v9+4ra029/rjXWpc+FmxMGaTRUmSdLOuY37z639r0XAkh/Jt
         P0Pjagha3l8MDOXjfSHS+RQTvf0b4VPdJLGYxDcoifq9AMDoyt4/1sUVmKJ/NXBHxULp
         +lyOfkxSznR2OwGeWMYuNHkMUdzamJXFLC5AoXMciUfGgnriSpHJnbKQfhMl4NhIH8Q8
         M7pdZiyMNNuQLYtQ65WDUDG92OwbxDwyzHeDdNeYzHjJNl+MQTuRgRUfj7Aw6+iBbgvp
         pVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101899; x=1740706699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7LTcAf+ZyZRbj1wIT6OJpobzFlxe4+MXo9izwg7tN8=;
        b=db/h3ZWGp9uCHLI6tThxdBWc2UlNH8So6H3VgrHniswj0gc/H/ywGxgo7sOh/Ya/km
         PwBHIq2FOaRVDHTlQQn7TIyCZLPjfwOf49Ia1sa22EwJxD401pB/6pbOVcQFlgHoy07q
         twIojzTP3dqfzjMPOEGHR2jSGZ20MFeTki5rMgELEuuT83zQaMo5Yw42xTxISAHAw0fl
         FtYjS8zaTXPDXBqBhp5GqGagp9vg2xj8l9MnDIjjUEqgA7l6wEYKivKxLbtlvQmNjShh
         OXd2pNvF1fXRqfQ6IIy5PLzFk7RrNhZyCxLUbHusmbRwQ7cjU/137Ssbt2bIjGkcTGtv
         TkAg==
X-Forwarded-Encrypted: i=1; AJvYcCW1WsZoVB5Mnb2tZwxS1Sma0zPWhGXFZ7TTXHBcF0FZKoPtLl5fFnid7SA051j4MYkDJwfwnHYz7e91@vger.kernel.org, AJvYcCXxEhho5sZpaBPRlzRl1MsGdMA6EHNGBTmmd9PkAY1xAkjwKdSId7Dd3Itp2dh/nCF3UenW6hOOaY/lAnRa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5dRJDA4tiV2acH7c6ZCTKmNUSB27St6117GumgaEMFHSsR/l
	ECHjhLMLMvswqOLmqRuYanR04y7TAs5x4yQlGlozWnpGXs9Fr7Wp
X-Gm-Gg: ASbGncuRkqrDkT4QhmzI5zqsX7oZV7OR1SJL4aJPk1pw+siP2mQewdV7FWElIO+dusf
	mHx6VYZv3hjCTl0oN8eq1a5aDQD7L+jkWgl3lJTam97P3nnE+CPcyM5ODRY4NWNvrw4maIaBwKR
	aKcLt+kuXSYIUo9hx1ZpyqEK0cmdVnrGLuu7EkrkiHXSKTIQ2LeKrc6q9i61zLaAlgx3eczNe2w
	iCbQXxh375MmkD2ygQzQFQHboxdkB899YvZJ1O6H6EZ3Qoe7wN2ky879UK4Vjsykjtq0SkuQQG9
	EA==
X-Google-Smtp-Source: AGHT+IHfY7LcEkIB9TKCmoPKS1hMGvEeQzHukRp3+FUGzCZPUNuqH/fv35zegFODvu5oVyOB5whJhA==
X-Received: by 2002:a05:6214:4007:b0:6e6:6699:7e58 with SMTP id 6a1803df08f44-6e6b00349bamr11779546d6.1.1740101899241;
        Thu, 20 Feb 2025 17:38:19 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d77c878sm92420986d6.20.2025.02.20.17.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:38:18 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Date: Fri, 21 Feb 2025 09:37:55 +0800
Message-ID: <20250221013758.370936-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221013758.370936-1-inochiama@gmail.com>
References: <20250221013758.370936-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcie controller on the SG2044 is designware based with
custom app registers.

Add binding document for SG2044 PCIe host controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
new file mode 100644
index 000000000000..040dabe905e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description: |+
+  SG2044 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  snps,dw-pcie.yaml.
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2044-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers
+      - description: iATU registers
+      - description: Config registers
+      - description: Sophgo designed configuration registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: config
+      - const: app
+
+  clocks:
+    items:
+      - description: core clk
+
+  clock-names:
+    items:
+      - const: core
+
+  dma-coherent: true
+
+  interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+      interrupt-controller: true
+
+      interrupts:
+        items:
+          - description: combined legacy interrupt
+
+    required:
+      - "#address-cells"
+      - "#interrupt-cells"
+      - interrupt-controller
+      - interrupts
+
+    additionalProperties: false
+
+  msi-parent: true
+
+  ranges:
+    maxItems: 5
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie@6c00400000 {
+        compatible = "sophgo,sg2044-pcie";
+        reg = <0x6c 0x00400000 0x0 0x00001000>,
+              <0x6c 0x00700000 0x0 0x00004000>,
+              <0x40 0x00000000 0x0 0x00001000>,
+              <0x6c 0x00780c00 0x0 0x00000400>;
+        reg-names = "dbi", "atu", "config", "app";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        bus-range = <0x00 0xff>;
+        clocks = <&clk 0>;
+        clock-names = "core";
+        device_type = "pci";
+        dma-coherent;
+        linux,pci-domain = <0>;
+        msi-parent = <&msi>;
+        ranges = <0x01000000 0x0  0x00000000  0x40 0x10000000  0x0 0x00200000>,
+                 <0x42000000 0x0  0x00000000  0x0  0x00000000  0x0 0x04000000>,
+                 <0x02000000 0x0  0x04000000  0x0  0x04000000  0x0 0x04000000>,
+                 <0x43000000 0x42 0x00000000  0x42 0x00000000  0x2 0x00000000>,
+                 <0x03000000 0x41 0x00000000  0x41 0x00000000  0x1 0x00000000>;
+
+        interrupt-controller {
+          #address-cells = <0>;
+          #interrupt-cells = <1>;
+          interrupt-controller;
+          interrupt-parent = <&intc>;
+          interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+        };
+      };
+    };
+...
-- 
2.48.1



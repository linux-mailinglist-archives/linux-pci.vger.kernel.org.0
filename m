Return-Path: <linux-pci+bounces-27114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80900AA8371
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 02:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D937189C806
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 00:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E551BC3F;
	Sun,  4 May 2025 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjYBmDpA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADB17C98;
	Sun,  4 May 2025 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746319489; cv=none; b=hsx/c6ZiYrUmwI60hLlwgZEHMrAEb7uyNC/tkivBGl0IVYVf7l0T6XkI8+6GLdaFcX+C60vnky/DMvaokgbMR5YIdv9UtOKK5wt08syVat+DyoXJOtdPJXD/qXAYoVaaP9ynU94B8TVChnVtzB8o6daHOEVC/IBVLodkzDaAnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746319489; c=relaxed/simple;
	bh=AiuXcbaJV+NjYtUCDlBF6XIAxgKFZTkh5kCXtC3qd5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7pX3yjfcpZqdhVq1TVuUMZ9oQazc6+pomh6k1HvQvnSELk/ZjRGGmumWnugvhbpWAx7WInt54FnydXPQR5JepdyI6XjUwdyXfeM0vd9hUYaHRLUcyRgneqp1k/9OMCshQHcU5aS/6FtDz5ysxy5R2VDPBZRtJkr/bIesDXWFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjYBmDpA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c546334bdeso300479785a.2;
        Sat, 03 May 2025 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746319486; x=1746924286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoA+ZSOYEZQCjKYMYI3mrz31xQWAvL5C4Z9pWmjD/v0=;
        b=CjYBmDpAHVjy1tBhzMWRP63aQ0SHat+PLIEIc1xcg599hwLO0AfGP4/Hnh9ASRX8jG
         aVChxDDVflDZMTIeX5Y3mVS8fnBjdlVY16BmVhI95lWmDKeP2H0OwAs+VlY9Qs0kTtCE
         gizJz04qyhZzBf1Fge5utjPJ+ESoHIds6zQXyOGVrUIMYbJ4D96mX28PvTVYOYOgE25H
         re6651jBK23dVYKghcf4dsypdvp6PDarzsCazAWSuvhvdd4vulnVvkZ6FU7HoVUmeLsJ
         wBCOWR4egvzckS/YdsWmv/SPFNEnLG8pe79aafEMMtpdkAFwb/bjoiSKA4NBHpjGNeLW
         DRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746319486; x=1746924286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoA+ZSOYEZQCjKYMYI3mrz31xQWAvL5C4Z9pWmjD/v0=;
        b=WOlxW9z+6TwX+fIRMR3pfXa2IpyS5D235piqvumUrP0e+F+lrzCGyblVR2cwzXXndg
         HHUG81CgIXPZXweeCg8C1V9ajNoGQWEUElhhAuHb2kUfLXQafbNFBz0QVx8YgBG6BMAc
         FTu1Whd8qitdh3KTJVRBZjsJc4VQ+ZeEjiaovHVaFlbQ49x4D0xcszRK3XgYzYB4hjlx
         TQweceHFwZIBEeMj1Ti9ljplBl+CXaxc5hQ9UWv5ZVAaItYGaBDaddLHkITYMa5TmbMt
         J0tH9J939A0HbzZl8BnqWDEnMlGz2+LxyEs2/wJOE22VjY9Mzu0Euv7HAILCNoUqNbcf
         uvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWWaXVoKxrBm52lyfqVFnRLLROWRx4P8FOJyzXwX3yESBaXm8TkWPBV2WiFsSAYNrhgYxSrkWGctmd9Gm0V@vger.kernel.org, AJvYcCXtzBa2CRLSnmEh+f1RpYJqxpV/86gmxUFpBK2TNev7xCws85ydX62NsX44c0+5Hn8YBRD9xYZRNocm@vger.kernel.org
X-Gm-Message-State: AOJu0YyEl/j0Nhbn04OL0Pd6CeGYSDTOvYjTuAIpqqIhsJHwEScp8sVR
	KfSvPEaXrBAMPWWsVha1zQePB9yb4YlvuQEgSFl7pFu+AMsNUZFe
X-Gm-Gg: ASbGncsymZChtahwBim8241G5OBIrZ/OF5IWC2DMyCQJTtvvXHjNIZ4WjctW1+dMGpH
	Phu0Um8kIE9FfmvH2KXBEaqIkJX9Il+HpwvRvUf0ntxjvvjT6r87nMpFnsKldBtmsNaPCYmsVDw
	rqCP4WCe6JmtB1uNHAHUyWSgx2vQfT1uaYoxHwj9MRGSEanVWe36SlSTQzHHE/c7/sh9mmG+QaG
	K2Xk+hByb/SGGqjzuK9KKVUtnLkkDR+/uEoUNvPrMv/iUCKnVdtSdGtN8sSJ2MFJ+IigAwGsMAJ
	dQY5J28li38tYzy5
X-Google-Smtp-Source: AGHT+IHlMrma4ZEgM4G81axUlK/JXKGY6wtDLe1XBP+NpBnysT5RTGS7PbK4xZuVe4+AfSaQT4uAFw==
X-Received: by 2002:a05:620a:448c:b0:7c5:5e9f:eb30 with SMTP id af79cd13be357-7cae3a9ce2dmr321428085a.15.1746319486286;
        Sat, 03 May 2025 17:44:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad243fc7dsm389133685a.94.2025.05.03.17.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 17:44:45 -0700 (PDT)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Niklas Cassel <cassel@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Date: Sun,  4 May 2025 08:44:18 +0800
Message-ID: <20250504004420.202685-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504004420.202685-1-inochiama@gmail.com>
References: <20250504004420.202685-1-inochiama@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
new file mode 100644
index 000000000000..ff1133bae3ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
@@ -0,0 +1,122 @@
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
+description:
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
2.49.0



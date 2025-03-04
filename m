Return-Path: <linux-pci+bounces-22808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D8A4D4A3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DC23B0C2C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703E1F91C7;
	Tue,  4 Mar 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHVpsmAm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA51F8BD6;
	Tue,  4 Mar 2025 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072403; cv=none; b=VCGdtivlqKjIRq8KYtpV/3QRlgELCSthNUdxx96wFFa89dol6ewiVX7Nqso60/IUgGxA8/lyfU1SGx5GDHmrARQ995ocD4pDinIDLfNekk+LSI84ENjbxQ0CsjlvJA47+KXpP3rJNqruoNytFjfWz1bWTwqAn8MyKuZrLDNG5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072403; c=relaxed/simple;
	bh=WVGXxBVXg1aTl+bt/UgUg63ySw9YcbgbqMypwQzqcBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBkA9bC1YUU0PqZMZWzpwfz5tERW0QJrCDMEuO+itxLcJN4ihj0qE/xo5D9bnTpkMm6B4ej+Kl4GcceFEVqmaoZZYus74xYeC0HeyrkKjZYYumQSsy6Ico4Ltl6vIvkna3uZkgeTE3X+p7V9ZR/eA/+/NF0cFbNCu8leQtuJ+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHVpsmAm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd01781b56so61832326d6.0;
        Mon, 03 Mar 2025 23:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741072400; x=1741677200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwq6vuPmMVxWBoFCtw5ASb1VQcjTGQ3SeY+f38l0crU=;
        b=UHVpsmAmn7ZT/mqHBtUA2RtvcPfMjbuV/Aovp7adGlnxExSLrI9Vu1Oy//73uHKBvf
         1AaeNrNwF7nTGVIKUmyKfH9iA4MHzlu75wLBtkPJafVf03gWdCy0ZM/9feTjhOA78SWi
         ynBUpLY7DHELqHHYCQlMsE/LD/CbuJjKqP7eiQA54hS2dhLQqgE27JdKgEOfAtGvhQ3z
         68SCUFAOvc/qmyWfZV7aDlKzWwRTkVgYGZBZOP0EvTmso4B2okHcI2gKCTXMeo5SeyMz
         tDKnPmP3eUgyh+ho/WtlmONdZo400deTPydkw0BQFy7Y7DqSORSQ2zDUfwzD2aRZp4Cr
         pNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741072400; x=1741677200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwq6vuPmMVxWBoFCtw5ASb1VQcjTGQ3SeY+f38l0crU=;
        b=mjeK9uv4mwSBbXlNl+9NpP5xmkfZmS7vWIaMa5dc63AeXuOzgC2epLtgPikfN20IYE
         X1IwNyhgt2ETeLwedyGh0bFlAwiOzOH9JkH+kJ5t9JQHHYjg+A+aiemkcrBN4F5qwPlt
         8kPbw4ej6HpHQ5UoGPbvq7Fzk5ku5Q6jsfK6/T7Te3l0bCK53asMz5GTTuVV/bwxImJS
         AG6C/JVKSbMULZtHF+GdBhpC8pDDznfrrtDgPStm+P5SSFwswEjcIAnfssSshp6eGO0w
         py+VS0+eGP3EP5P6k0KNImZihA2cHF2IIWTXFujEkjv4sLSJBF5XWCD2nhb8sPYmjh0P
         AX4g==
X-Forwarded-Encrypted: i=1; AJvYcCUMtN53apNeWh9tIJAfmzYRyD57GBz/GgoBfq9H0QnBHyc+8EBrWCo01uNUoLijBcJ7bd5FS7ZUC193@vger.kernel.org, AJvYcCWyW9u/hssx3P6WmQzoMV1DjprrHIk0XfXOJ6Sll+Pub18c+wPlJdJmTJXcwf5TCC48jN1ZkNhLOYQaGy5P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/AbpbgnulHWdhd2dnyC2gpyleKRE5BQks21uRWHkVISEw9wa
	gSrl92dOdE7P+S/8ZUfiyhuDsWa+IH+jWVjCwSNb4DNjuz0MyvOp
X-Gm-Gg: ASbGncuvdWe5ibV9kzhdJNefPLv7wS+fO5eLKcj8Gps+5FvZgla8I4TuJVQ6JBi8S58
	PfG2jLJyI8CZF6p1xg7+2uzwPQ9bZzOO9l7aVCLiAFJjmGId8UDqqLb8ef6MzZuSgMs7ob21VuL
	WTMD5M4geIQDn+RT/DA0bT0Fa9oM065nAdGe6uD8STYGFdJRxWYNuLP6iZGhus78TgvB4b7Hc/S
	BcqJx+yIHiNvHrhqAt8tct+Y2u9ywld5zt4YJTUYV40e+dQO9ekly/oNnLHrA79E9ryHH8Ch5HA
	TaniYjfIoDNZnE70qvsh
X-Google-Smtp-Source: AGHT+IEKSycuKiArRIB4aWqnh4JSLR0m/JXw8SZWd7kwiy/1aB9gpEr55GNFHqueYCWrKy1q0fPQNg==
X-Received: by 2002:a05:6214:2aa1:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6e8a0d4a9f6mr259141056d6.34.1741072400555;
        Mon, 03 Mar 2025 23:13:20 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8bd85184csm33263806d6.49.2025.03.03.23.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:13:20 -0800 (PST)
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
	Johan Hovold <johan+linaro@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Date: Tue,  4 Mar 2025 15:12:37 +0800
Message-ID: <20250304071239.352486-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304071239.352486-1-inochiama@gmail.com>
References: <20250304071239.352486-1-inochiama@gmail.com>
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
 .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
new file mode 100644
index 000000000000..2860d0f13146
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
2.48.1



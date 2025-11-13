Return-Path: <linux-pci+bounces-41192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88437C5A377
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBD63BAF62
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD39325732;
	Thu, 13 Nov 2025 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="J049lLwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FD3254B9
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070353; cv=none; b=rpaa7Hj8B7aofEnJLLf9poyq8+8nuTdNTDOamEok+Cvh3uGUhdDEkJvxCbWPB3O1wmBPswfo76fU76FCxOnB2hKU673aEmedvrly9YaN/js2hkKbRCjHeKovokTtaVeiMYFtwnCpf3zAajc0l+ziwdk76qw2f6pWuR1ma9xpzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070353; c=relaxed/simple;
	bh=pUZ/2iJtftGs7oXna+UtCd7yHJv39wuU0cwbMoeHLk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEciy6iEuxFjVry7PdBwnjrGeSkU0+D4fKRx2mCt/rkXX7ALR7t+TbmsnlztYo0IESQHtC/vd9GP3K+lb2yh3Sj+8k2z1qxrZHq982FSPZh7aPFO8s8qhbPEEZck/xFDtOOyUMPcgdP/MDe+d7qz01RfSjPGALYyf15vDG9rLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=J049lLwe; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-43326c74911so7617455ab.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 13:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763070350; x=1763675150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH/xVMS32HLxpkBHVxi/V+Wnd3NwVi+5SDMCFTBBK7U=;
        b=J049lLweJUg1+X2mCoN/7sW8Yq6/zoe81i4bWw0I0+xEFryrJtfTRVI6cPNuuzL8If
         L5lwgtssy1n6GMQCUAo4Fxo4g/sYpqKrmVMKZgHCMU1DfmsATgtLuz80NrXtyCfDUXGH
         VfHs29wg309dP/AXZcwXMJ+JuGK66jiQou7vQJsOsnlQmBD71m4L9Y+ZAVGzznNb3rfP
         sZKIRxWUJKnjeC49OgAfD1UJ40SjQIQTKmyxzdtuA2aErh3EySL83DchY/XSAijZ1TFN
         0dGC+94FGJxBwELCnzEUO6BB4MkiJOgqm5ip431hkuGMTcR6VJ7XZxU9oOznCyirHKKU
         RJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763070350; x=1763675150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mH/xVMS32HLxpkBHVxi/V+Wnd3NwVi+5SDMCFTBBK7U=;
        b=Oe2YKALeQdBbU3glrRjlUera2TG3nQQlswwuajZxiCuQgkNA9M5nlkgx6Uf8D1mDG/
         ARFYNTlZ6UJz5hw4TotVGoAusRafD1KalecGy4IJTCbrk92okVrHSN3Y+dpXnc9d4FlC
         vsqO/y8Nqu1bYfy6BhqoE9ZCj+M6pt9VxqvlN92K78h8YVXF6D0kEmQ2ELWroAqDBDE6
         neLcOryjowL8m3Jh9mo83mWBOST3P/w/QtqKranO0rERk6VvBYZ13bZ5pzsCY3cgteuN
         BqZQ6IyYPLt6oNaZmQbbJ/kGTg5KI9OEsil0ZKvnkyFxjw6vEx1q+Zf+FbKXoFzW3r9j
         Si2g==
X-Forwarded-Encrypted: i=1; AJvYcCV2gtNK+rUuu/39uisKxoVkO3CDkKXtMraTIWrDhgUZBEHshR5UhMEfGzhx9PXvT21N0FAImIH9tNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyauj1OrLNA+n8IvFQFu6BktvH4ZqOuDki8forYbl35Yu1T6qLr
	nL6p2tYOm1JkX6kZc6XTdbcZR9ubfLvJrp19WzePpRPFTuzbtbs1HrxI7lqHb3ZsygM=
X-Gm-Gg: ASbGncsCsAcT+6OZyGlYIKQ1E9k0q0twv4SZing091La/7bddtJiAwqNiLbOpSV+jc4
	+fZ222Mvkw++hqG49Hw6b6DIojW8lir51JrsZTP4wc1SyzQT0nqSl4V0Av5U+ST/Px89enCFHBV
	O5lue+IjjLFjwCh1pM1zCSTHAdNwcWz5mNf0yGPBsecLRdar4MR6LWMkYG9iWGkqdGG2VUHHKox
	qqtUmunidJUzqvnc/E6UzwEX0XvkJnbWRdDVWuV9FnBUUnWraWy6IuWLA5uVzVLL1g67V6XJgFU
	Z17EJIbpJXzkYmNv+rxTz2Dw8hXDxx9nbCgj6E163ichfeFCl5f3cmF4Y0Qn7uMvmEBUI/jpXdy
	qjLKxXvXWwDEFU4c7AU7HCl3UGPtMUxR/BMJlWEVrlZ4/5A5fW5X6eJ2dULSZQf8+O+kIWUqN5g
	zN9Uy07HrgAVL9OLyW7xkdeGJ5hnW/34fSkM6uH8h/X7nIHAuLuCuLxw==
X-Google-Smtp-Source: AGHT+IHT5rjiNvmqOH2t901xQsIP//7SsNWDMamOM11kpXdtNiVAX9RsLeYKi9slTC6iSHqCfSYAzg==
X-Received: by 2002:a92:c26c:0:b0:433:7896:3e51 with SMTP id e9e14a558f8ab-4348c878e29mr17562905ab.2.1763070350356;
        Thu, 13 Nov 2025 13:45:50 -0800 (PST)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839a4ac7sm10877115ab.25.2025.11.13.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:45:49 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/7] dt-bindings: pci: spacemit: Introduce PCIe host controller
Date: Thu, 13 Nov 2025 15:45:35 -0600
Message-ID: <20251113214540.2623070-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113214540.2623070-1-elder@riscstar.com>
References: <20251113214540.2623070-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding for the PCIe root complex found on the
SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
typically used to support a USB 3 port.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
new file mode 100644
index 0000000000000..c4c00b5fcdc0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCI Express Host Controller
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description: >
+  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys DesignWare
+  PCIe IP.  The controller uses the DesignWare built-in MSI interrupt
+  controller, and supports 256 MSIs.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-pcie
+
+  reg:
+    items:
+      - description: DesignWare PCIe registers
+      - description: ATU address space
+      - description: PCIe configuration space
+      - description: Link control registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: config
+      - const: link
+
+  clocks:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) clock
+      - description: DWC PCIe application AXI-bus master interface clock
+      - description: DWC PCIe application AXI-bus slave interface clock
+
+  clock-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  resets:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) reset
+      - description: DWC PCIe application AXI-bus master interface reset
+      - description: DWC PCIe application AXI-bus slave interface reset
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  interrupts:
+    items:
+      - description: Interrupt used for MSIs
+
+  interrupt-names:
+    const: msi
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle that refers to the APMU system controller, whose regmap is
+      used in managing resets and link state, along with and offset of its
+      reset control register.
+    items:
+      - items:
+          - description: phandle to APMU system controller
+          - description: register offset
+
+patternProperties:
+  '^pcie@':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      phys:
+        maxItems: 1
+
+      vpcie3v3-supply:
+        description:
+          A phandle for 3.3v regulator to use for PCIe
+
+    required:
+      - phys
+      - vpcie3v3-supply
+
+    unevaluatedProperties: false
+
+required:
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - spacemit,apmu
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    pcie@ca400000 {
+        device_type = "pci";
+        compatible = "spacemit,k1-pcie";
+        reg = <0xca400000 0x00001000>,
+              <0xca700000 0x0001ff24>,
+              <0x9f000000 0x00002000>,
+              <0xc0c20000 0x00001000>;
+        reg-names = "dbi",
+                    "atu",
+                    "config",
+                    "link";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x01000000 0x0 0x00000000 0x9f002000 0x0 0x00100000>,
+                 <0x02000000 0x0 0x90000000 0x90000000 0x0 0x0f000000>;
+        interrupts = <142>;
+        interrupt-names = "msi";
+        clocks = <&syscon_apmu CLK_PCIE1_DBI>,
+                 <&syscon_apmu CLK_PCIE1_MASTER>,
+                 <&syscon_apmu CLK_PCIE1_SLAVE>;
+        clock-names = "dbi",
+                      "mstr",
+                      "slv";
+        resets = <&syscon_apmu RESET_PCIE1_DBI>,
+                 <&syscon_apmu RESET_PCIE1_MASTER>,
+                 <&syscon_apmu RESET_PCIE1_SLAVE>;
+        reset-names = "dbi",
+                      "mstr",
+                      "slv";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie1_3_cfg>;
+        spacemit,apmu = <&syscon_apmu 0x3d4>;
+
+        pcie@0 {
+          device_type = "pci";
+          compatible = "pciclass,0604";
+          reg = <0x0 0x0 0x0 0x0 0x0>;
+          bus-range = <0x01 0xff>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+          phys = <&pcie1_phy>;
+          vpcie3v3-supply = <&pcie_vcc_3v3>;
+        };
+    };
-- 
2.48.1



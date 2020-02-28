Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2367E173BE0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgB1PmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:42:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40051 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgB1PmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:42:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id d138so2082384wmd.5;
        Fri, 28 Feb 2020 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tydCqefpRAiM8TxJYR22+ZNMRD98oyKBlX5K6Oe7m5M=;
        b=NlRQ/A3ZIuvune2sh7ASmytwru9f5VtLMq4MwdfOlResHzAFeHMGkLVZRtXTGEo9Lw
         kDS1ltiis7PSqNMLcgCP54Jx3dCWVET/blN70hFFCT1iYj2AJ85VtxglH2uTSx0ZNu6s
         0ctK7noY68yW58ICsVV1El3LIn3gTw/TkmT/JDcAgPmTyKVpzhYVHVE7QGYMB1foMpOJ
         Lha+kZ5BhhFCNa3ZFdcGOeUbKX+iRDuU15w89Ha8UUCMvMw7TFzyLqj5qZOi8QhULpqB
         5zc8JW9Vjwa4kBRHmUo7iaKAzHk4H/3lUb87u07L96B4hClHmmHwR8TPalH2vMv+2E7j
         KUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tydCqefpRAiM8TxJYR22+ZNMRD98oyKBlX5K6Oe7m5M=;
        b=OhFtfRlrWb+OcD7dg/HBVUjLQPW2U0Ay88dYTQ9Mjxl/zYYZ3gejnBhB7vk7sy2bRf
         LefqPdfOAlwfdbpsZbhkt+hxvA9zc805m0BFtcgKYjSA30kA2d76rkRIhATRnW/I8YPG
         ckBEWWd0791bA+Y8bJjrBYo0vkI1mRYXz3BBMcZ7fhiX3pOoD1WBbVKABvWbDzPWgjpf
         vJ8tzwLoVOXYWNkQwGeS/GnHJ5Ybyfy6PljsyTauekn6jF5mzrONu6NRZCYf/IVROaRN
         +4FJnmAeoKgMmxamrYMvkL+N4z6fY+3yDKHrBYaszSaiqskQlrTc0HA5f5GAWZoQrctf
         PWoA==
X-Gm-Message-State: APjAAAXQj6e4nMxuev43ybsnfFXykDW4tsen6CUom9Pp3i+6vlup7in4
        SahbfDT3+ytWvsB4KBE2W8E=
X-Google-Smtp-Source: APXvYqy5mp+jeXmLU4fCJ72eZVrwLD5Dhfz9BwLviLvJbhwlj3Q8WU1dIX32i9RlHr4KRGVpm9H3qQ==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr5518985wmj.165.1582904531486;
        Fri, 28 Feb 2020 07:42:11 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id k16sm13355349wrd.17.2020.02.28.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:42:10 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 5/7] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller
Date:   Fri, 28 Feb 2020 15:41:20 +0000
Message-Id: <20200228154122.14164-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds the bindings for the R-Car PCIe endpoint driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
new file mode 100644
index 0000000..07cd5a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rcar-pci-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car PCIe Endpoint
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r8a774c0-pcie-ep
+      - const: renesas,rcar-gen3-pcie-ep
+
+  reg:
+    maxItems: 5
+
+  reg-names:
+    items:
+      - const: apb-base
+      - const: memory0
+      - const: memory1
+      - const: memory2
+      - const: memory3
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pcie
+
+  max-functions:
+    minimum: 1
+    maximum: 6
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - power-domains
+  - clocks
+  - clock-names
+  - max-functions
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
+    #include <dt-bindings/power/r8a774c0-sysc.h>
+
+     pcie0_ep: pcie-ep@fe000000 {
+            compatible = "renesas,r8a774c0-pcie-ep",
+                         "renesas,rcar-gen3-pcie-ep";
+            reg = <0 0xfe000000 0 0x80000>,
+                  <0x0 0xfe100000 0 0x100000>,
+                  <0x0 0xfe200000 0 0x200000>,
+                  <0x0 0x30000000 0 0x8000000>,
+                  <0x0 0x38000000 0 0x8000000>;
+            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+            resets = <&cpg 319>;
+            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+            clocks = <&cpg CPG_MOD 319>;
+            clock-names = "pcie";
+            max-functions = /bits/ 8 <1>;
+    };
-- 
2.7.4


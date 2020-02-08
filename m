Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253B31566CC
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgBHShE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:37:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34153 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgBHShB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:37:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so5398510wme.1;
        Sat, 08 Feb 2020 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4wkoWcQnJp+t8wN1Rg1EugZCOCvQJKoH8CuDWH6aPc=;
        b=QbULqGc5tmXT0mWgOLyvt9tb0dNgj4Amg0ebxx8YgfZAUyLehH8BQNhW8ZYO6YlpOS
         kcYNDFUIFmYhZ7Tan6akUSxIMLUw9yst1CaiCBd63JNfKNTApYQc4oTqk3n/SPcjd3UE
         JvkKRbs+WN5ZLan58rC/xOfIaFs0qzcRlhkmd301tqnZ/4JA2Uz6c+/aqmdS3afniTS/
         C0eTF1TGk3oewzg4c29F2jvTkEx97oUw1fNhehggLBm7f9Fti9cDOujU4X0T4bwjUgB6
         y/DUjpDopqbpBYW8QloomzxlUeoB+N4Iv9kV71l56cD48x8TriXOc0sg7v/SbeoMnwk4
         3MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4wkoWcQnJp+t8wN1Rg1EugZCOCvQJKoH8CuDWH6aPc=;
        b=EW/ucCb8zTdwEgNVyukWa5D/ktBUif1gXwHWpTc7WBn5sbNWkMabhYR7e2dCE+9K1q
         +DZjZwM3y920eLLqvsaWP5CReYaNGv2UUW8BEf6KAFyAAC0dkOLS1nBu3kIyf7NHJ8iL
         L4YubWIufNjj+qbW6RAmoUPbtdtKhUZDoZKK8bAcZHpk9JY2jPiudBzCiMnZHq6BvRM6
         Diwcp9a5igx1WGaOmI50X39dz6MBa0qyG6iVgTIG4beTyKT71c8/X+tH2ZAYc9m2+7c1
         7bQPYWvHSa1BNzkGv+LJAR0mhEmm3GcdRjAQKO7QAC/Z6x6DzYQ49G80vOmtfgF8X4Ku
         qk/w==
X-Gm-Message-State: APjAAAVXp2Xb3ufrP4A2b9o5xOx+Ls6zLOJwbRQfTAxRnliE763PutQ1
        M5MU5saRkQzTEpT7X2OUdFA=
X-Google-Smtp-Source: APXvYqypINsuLcSbnhMi3GbDPw9Y+AStMkm0YqSJxtCnbBf0rGrFRP3tqEs36ksYbsN0b/ADZKI1NA==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr5271814wme.28.1581187019830;
        Sat, 08 Feb 2020 10:36:59 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:a553:90a1:93f5:e306])
        by smtp.gmail.com with ESMTPSA id b67sm8404385wmc.38.2020.02.08.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:36:59 -0800 (PST)
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller
Date:   Sat,  8 Feb 2020 18:36:39 +0000
Message-Id: <20200208183641.6674-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds the bindings for the R-Car PCIe endpoint driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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


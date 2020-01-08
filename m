Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42931347B9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 17:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAHQWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 11:22:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgAHQWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 11:22:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so3141482wmd.1;
        Wed, 08 Jan 2020 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfL24R1jbieE92Zr2OINAr/LHQLYTr+DjNdDMkvlSSs=;
        b=DKe3OjAewdlKxi5A5DrjA+hPYhuiuqf9P55p1QfwL4dmlyOlHsnzOlt6c9lseJVRE4
         zEIqVq+DIGf36Bgq5/j9f+EU5tJSYhLgfOaN9SUjoaLWOY47U3EX7HzPeCdtYV3qdQ6t
         o2MzVfFzk8FCEq7kXe3hM8GURb+vgGnWezs8jZrpjNnOIHqlD+eh/CvbGaaIxLoOmHGQ
         jpy8wKysYn8oDbXcp3isBt0aTQg3fCu2Fn6i/9FMuGa5BLhZNPSMA6XPwdjvnb2CA5QM
         oLEzlf5+JsRPGjrC9fRC1kgtDo9W3hzalsKDBPfDzrJmmDT5f+31alcASf4c6WPzhZKj
         XZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfL24R1jbieE92Zr2OINAr/LHQLYTr+DjNdDMkvlSSs=;
        b=TIwpBzkKiH3lST+O4DPnNPorkzWxAWN3u2lHvgCnEehgx3ZCyZDdn4LcYXlcrd6Iyt
         GCe7gpxQR694mhLs0xgBYkWbqbOROQjx1rldqgDPyiyzkK4fEGFx8LABIec2fGHG/yM8
         Oyry91RH0pjSvdH8nT/v2ZOq2NygopnG9mBhAD/p8GYYcoiG7Zle74WnMFsd51To1n+p
         ei3o5wnvmd2Z3qJ706JMRo+Y+m8+w9NPmAwoqDAf5Onn09kruVUkFUhofpWQtdC8H2JT
         CQ1ozQxjBbfUbA46TiJ18cptHSUUIQ2pSpHb5Fh0JELAL/M8VjkCOhoAFmt6YW4if5er
         GdfQ==
X-Gm-Message-State: APjAAAX/1AtqpMMECSpH9mQl3i7ljogzJi03omV8K0plnypG3x9pUEUZ
        paSGL0t2okX/IiG1GutBcJg=
X-Google-Smtp-Source: APXvYqz6e4O8N1oBV+D3PFV4CPHG2KoFc+aqTo2lzVIxRuRIAafTkSuZLrV9KTPvkqw0PeJAkz8PIw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4981393wmk.68.1578500538653;
        Wed, 08 Jan 2020 08:22:18 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:2811:8b65:294e:fa09])
        by smtp.gmail.com with ESMTPSA id q3sm5112180wrn.33.2020.01.08.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:22:18 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v3 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller
Date:   Wed,  8 Jan 2020 16:22:09 +0000
Message-Id: <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds the bindings for the R-Car PCIe endpoint driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
new file mode 100644
index 000000000000..99c2a1174463
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rcar-pcie-ep.yaml#
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
2.20.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE80C3F9D72
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhH0RQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 13:16:43 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:38261 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238836AbhH0RQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 13:16:39 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud8.xs4all.net with ESMTPA
        id JfS3mDfw9JWNeJfSDm6c3h; Fri, 27 Aug 2021 19:15:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1630084546; bh=dV4tRmJ5z8UQ8vCAPACt05N5ZSm5ssASld+lbfZlIJQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=Ypp9ykoXUTKiwYdod2H6rRl1UFcycfJLv5ciwtTB/TKDpWdsO32/gMrmsIt4tdY4l
         Hzfwl6sHlhsKOSdiJNfBBJE9IaaDjH0vctjhVwAWbOaFvekIkKzvhnX/WS2GijRROD
         NanyG+3wzo76pBfUOVnzCO7yHBGhPAx9RS6TEXHpPJfeDDSZyu5VdDKblXQ5yaYKSd
         3p4xvBJh9Cf2v6KTnNi5SAnd0gHoSil0SU41gqkj/NB2qPLkmQC1xTGa3UTFzJ1bGW
         PhA/TaMggkAjb9mCpnpzGtfVyLGXgZ2TD+vt+6rCdkdicFaZS6vLirauzpNY7V2/vH
         2jW3RYDWXn16Q==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] dt-bindings: interrupt-controller: Convert MSI controller to json-schema
Date:   Fri, 27 Aug 2021 19:15:26 +0200
Message-Id: <20210827171534.62380-2-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEM2JDAnX6AANU9YyG5nNUjDjBfhHMBb9vhc+ykvvD4fBFpcXLUhPgqqGN0q3CustNsvfvm5kpvwyHDaGzXDq5K6r1WFkqwTQqvpC3TZw7v+sQvO+jdl
 T7Q1oLXYB/cyOnhOj2j/CMkhJonw+sDUTbAK6agj/tc6k27PaKEGumUa35Uuf6gUgMka1wmxVj1jbWFQ5cOT09f5FpwNB2CVAWoSVIuZBSyctM63oVH9aeBp
 6LB5K6w0Hn4lib7syfMtjKZYKUK6fM2Phq0iUNuRNTld/8EsbNS+5nJVX0E+bqn3EaCv+SEOliOd558GNmJf5e4Wgj9hh6cLih4KBnNECQR5BcGJZ3IZGYlm
 fMbRwquxo/p9BiS3mgR40mca2eer8OpkW+JMtX+EWOjB+BSePGiAxelT7GgF9WqtCKe8cQRY/Pj8acYyxu/t+rj87jD6Q42LRSTzN/wy96X/1L5193eN1DoH
 Wx+GRIHzqd2BaqErrtOv0KShvZ7Tyo4QTDtIfVJL5SRDo/QmINP4yNKPTFwH2Ek4W5HK1JTw01Y083HZQafyWCVh+ZL6eXvYlTS2jatAKMY7bK4ZifEizDBd
 tPY50P1d3Vk272wKBDplyVv6aRmxdEmciwLGauVtoTPxwsxyn0/6GFt5zv7SyjSIFVjs5/tWV/yruHfpTNcJWPkp6OGNWazEbAMQfwF0wGEH8hbqTba2OPUR
 y/HObJxzas6Uay9obkVc1zdvx6fDXcV+tTqnlTG2Bby9VYGAewOxJoNePkJEvnocr9UHPNiyUizqu3h6JuLAh1RSy5B3YMJKkBU3vIE0AYtDLJUe/Y0ik/vH
 2fpaK2NeE1RPVqCavNc=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

Split the MSI controller bindings from the MSI binding document
into DT schema format using json-schema.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../interrupt-controller/msi-controller.yaml  | 34 +++++++++++++++++++
 .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
 .../bindings/pci/microchip,pcie-host.yaml     |  1 +
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
new file mode 100644
index 000000000000..5ed6cd46e2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/msi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MSI controller
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+
+description: |
+  An MSI controller signals interrupts to a CPU when a write is made
+  to an MMIO address by some master. An MSI controller may feature a
+  number of doorbells.
+
+properties:
+  "#msi-cells":
+    description: |
+      The number of cells in an msi-specifier, required if not zero.
+
+      Typically this will encode information related to sideband data,
+      and will not encode doorbells or payloads as these can be
+      configured dynamically.
+
+      The meaning of the msi-specifier is defined by the device tree
+      binding of the specific MSI controller.
+
+  msi-controller:
+    description:
+      Identifies the node as an MSI controller.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index b9589a0daa5c..5c67976a8dc2 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -88,6 +88,7 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: ../interrupt-controller/msi-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index fb95c276a986..684d9d036f48 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: ../interrupt-controller/msi-controller.yaml#
 
 properties:
   compatible:
-- 
2.32.0


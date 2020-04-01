Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671A319A3D8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 05:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgDADJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 23:09:53 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17813 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731703AbgDADJw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 23:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585710560;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=oHT243SqhEnlwJmznwvLkEn/AwmbR4FJ1c5fVo13EZM=;
        b=X11A1BFsafZip2AqAGmsYowNKs5b1HFHI7LNlZ2k2e/8EKKp0EFyyDcetVoXmQ91
        /1VMsOW7IlLqg1NteiG3FXzN4RiqBP/ob1msPVcdj8Q9s2ZKUaQl120eKf2RTmlnv8j
        qgrf2js902OWTeCbxQ/iEzurjUtfXrsSGjbTdw5Y=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585710558237311.0139215144561; Wed, 1 Apr 2020 11:09:18 +0800 (CST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200401030658.1174045-4-jiaxun.yang@flygoat.com>
Subject: [PATCH v2 3/5] dt-bindings: Document Loongson PCI Host Controller
Date:   Wed,  1 Apr 2020 11:06:47 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
References: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host controller found on Loongson PCHs and SoCs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../devicetree/bindings/pci/loongson.yaml     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml

diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Document=
ation/devicetree/bindings/pci/loongson.yaml
new file mode 100644
index 000000000000..2995437ef61a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/loongson.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/loongson.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson PCI Host Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description: |+
+  PCI host controller found on Loongson PCHs and SoCs.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,rs780e-pci
+      - const: loongson,ls7a-pci
+      - const: loongson,ls2k-pci
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: CFG0 standard config space register
+      - description: CFG1 extended config space register
+
+  ranges:
+    maxItems: 3
+
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+examples:
+  - |
+
+    bus {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+        pcie@40000000 {
+            compatible =3D "loongson,rs780e-pci";
+            device_type =3D "pci";
+            #address-cells =3D <3>;
+            #size-cells =3D <2>;
+
+            reg =3D <0 0x1a000000 0 0x0200000>;
+            ranges =3D <0x02000000 0 0x40000000 0 0x40000000 0 0x40000000>=
;
+        };
+    };
+...
--=20
2.26.0.rc2



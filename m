Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB21F40B9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgFIQ0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgFIQ0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:26:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A4C05BD1E;
        Tue,  9 Jun 2020 09:26:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so23045745ejd.8;
        Tue, 09 Jun 2020 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9wKymHH/v6YunAl/pZm4DJsFjD8Guav1ycXTwqFKww=;
        b=vfKyVdxRxA4q52gnUsYFw4pFYUu4DGV+yk/EOOlEdBQxj1G7G1e+GMtG+CjjpiwCxe
         vSnxDZqt1mh4wExaCTrlRinXa0vic9S4GhsstXDSJwblbn+mp5Znuf7l+bW5R5kWx6vp
         vAvokFjnQU5q7N9lp1imkWvZ/U+6FzifXYKcHbDvBvsDP5NWMJHqUOpaPpsehEiLB5xt
         RXx5Mj/k9PNoPYROGUwL3M6Lxf/+C8xuJKuMsMZM7Lo9kyFP7z8bOh2H36tTWamVeWHC
         sL3BUGeUnkwL4FBc/sXmo7SUKqkzZzdCLTiebtsgtwCCIWRLEXILcX0YeJZQ10fKTJ2y
         jntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9wKymHH/v6YunAl/pZm4DJsFjD8Guav1ycXTwqFKww=;
        b=jurxOI5v8xJakmB8krl4AxVGlycfZgCbwLUQbU24uMEJYUXeXp53vosTWxPC1qY4WD
         OGuhmIEI8HuX8t8zuBq/Krn4A/ZhlbOPXM1VaGvYcIXsbI2qhH/NQsYpXjsCVYCGQdXg
         BBaZVcROgseinsgedElzpBbLYHnWstc4jgA674bKcbM7pLUAvCygh+46Y0X0LGtanIoM
         FTXNyDXA+Vc64BQCyrANDueyu+J2Gqu498ewHLqCIX6b/Q+0gUsiDkHN+p83LYQfSDqa
         KrgpMAh/1MmWcpD271zYWnWANKRSRnXpAZr02e9RVyru9I/tUMEH2ztqf2P6hZv68ZrV
         OpsQ==
X-Gm-Message-State: AOAM533SLyfJTPHnwnKOLcO59WU5WRhXVwjsFl7gU9dEaMOio68jrxQW
        u6acwCDKi79PbxZrbMAIxMc=
X-Google-Smtp-Source: ABdhPJx4rgMVM78n7LsoCAFv0aB42Sqnt/xc+Emq8/snmpfRTfRhsfsSlFJPG8YDyDyIy9WJTrWyrQ==
X-Received: by 2002:a17:906:aec3:: with SMTP id me3mr2000797ejb.94.1591719990308;
        Tue, 09 Jun 2020 09:26:30 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id cb6sm15374049edb.18.2020.06.09.09.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:26:29 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] dt-bindings: pci: iommu: Convert to json-schema
Date:   Tue,  9 Jun 2020 18:26:28 +0200
Message-Id: <20200609162628.1769705-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the PCI IOMMU device tree bindings from free-form text format to
json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/pci/pci-iommu.txt     | 171 ------------------
 .../devicetree/bindings/pci/pci-iommu.yaml    | 168 +++++++++++++++++
 2 files changed, 168 insertions(+), 171 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
deleted file mode 100644
index 0def586fdcdf..000000000000
--- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
+++ /dev/null
@@ -1,171 +0,0 @@
-This document describes the generic device tree binding for describing the
-relationship between PCI(e) devices and IOMMU(s).
-
-Each PCI(e) device under a root complex is uniquely identified by its Requester
-ID (AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
-Function number.
-
-For the purpose of this document, when treated as a numeric value, a RID is
-formatted such that:
-
-* Bits [15:8] are the Bus number.
-* Bits [7:3] are the Device number.
-* Bits [2:0] are the Function number.
-* Any other bits required for padding must be zero.
-
-IOMMUs may distinguish PCI devices through sideband data derived from the
-Requester ID. While a given PCI device can only master through one IOMMU, a
-root complex may split masters across a set of IOMMUs (e.g. with one IOMMU per
-bus).
-
-The generic 'iommus' property is insufficient to describe this relationship,
-and a mechanism is required to map from a PCI device to its IOMMU and sideband
-data.
-
-For generic IOMMU bindings, see
-Documentation/devicetree/bindings/iommu/iommu.txt.
-
-
-PCI root complex
-================
-
-Optional properties
--------------------
-
-- iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifier
-  data.
-
-  The property is an arbitrary number of tuples of
-  (rid-base,iommu,iommu-base,length).
-
-  Any RID r in the interval [rid-base, rid-base + length) is associated with
-  the listed IOMMU, with the IOMMU specifier (r - rid-base + iommu-base).
-
-- iommu-map-mask: A mask to be applied to each Requester ID prior to being
-  mapped to an IOMMU specifier per the iommu-map property.
-
-
-Example (1)
-===========
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	iommu: iommu@a {
-		reg = <0xa 0x1>;
-		compatible = "vendor,some-iommu";
-		#iommu-cells = <1>;
-	};
-
-	pci: pci@f {
-		reg = <0xf 0x1>;
-		compatible = "vendor,pcie-root-complex";
-		device_type = "pci";
-
-		/*
-		 * The sideband data provided to the IOMMU is the RID,
-		 * identity-mapped.
-		 */
-		iommu-map = <0x0 &iommu 0x0 0x10000>;
-	};
-};
-
-
-Example (2)
-===========
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	iommu: iommu@a {
-		reg = <0xa 0x1>;
-		compatible = "vendor,some-iommu";
-		#iommu-cells = <1>;
-	};
-
-	pci: pci@f {
-		reg = <0xf 0x1>;
-		compatible = "vendor,pcie-root-complex";
-		device_type = "pci";
-
-		/*
-		 * The sideband data provided to the IOMMU is the RID with the
-		 * function bits masked out.
-		 */
-		iommu-map = <0x0 &iommu 0x0 0x10000>;
-		iommu-map-mask = <0xfff8>;
-	};
-};
-
-
-Example (3)
-===========
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	iommu: iommu@a {
-		reg = <0xa 0x1>;
-		compatible = "vendor,some-iommu";
-		#iommu-cells = <1>;
-	};
-
-	pci: pci@f {
-		reg = <0xf 0x1>;
-		compatible = "vendor,pcie-root-complex";
-		device_type = "pci";
-
-		/*
-		 * The sideband data provided to the IOMMU is the RID,
-		 * but the high bits of the bus number are flipped.
-		 */
-		iommu-map = <0x0000 &iommu 0x8000 0x8000>,
-			    <0x8000 &iommu 0x0000 0x8000>;
-	};
-};
-
-
-Example (4)
-===========
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	iommu_a: iommu@a {
-		reg = <0xa 0x1>;
-		compatible = "vendor,some-iommu";
-		#iommu-cells = <1>;
-	};
-
-	iommu_b: iommu@b {
-		reg = <0xb 0x1>;
-		compatible = "vendor,some-iommu";
-		#iommu-cells = <1>;
-	};
-
-	iommu_c: iommu@c {
-		reg = <0xc 0x1>;
-		compatible = "vendor,some-iommu";
-		#iommu-cells = <1>;
-	};
-
-	pci: pci@f {
-		reg = <0xf 0x1>;
-		compatible = "vendor,pcie-root-complex";
-		device_type = "pci";
-
-		/*
-		 * Devices with bus number 0-127 are mastered via IOMMU
-		 * a, with sideband data being RID[14:0].
-		 * Devices with bus number 128-255 are mastered via
-		 * IOMMU b, with sideband data being RID[14:0].
-		 * No devices master via IOMMU c.
-		 */
-		iommu-map = <0x0000 &iommu_a 0x0000 0x8000>,
-			    <0x8000 &iommu_b 0x0000 0x8000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.yaml b/Documentation/devicetree/bindings/pci/pci-iommu.yaml
new file mode 100644
index 000000000000..8aaa8e657559
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-iommu.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/pci-iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCI IOMMU bindings
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+
+description: |
+  This document describes the generic device tree binding for describing the
+  relationship between PCI(e) devices and IOMMU(s).
+
+  Each PCI(e) device under a root complex is uniquely identified by its
+  Requester ID (AKA RID). A Requester ID is a triplet of a Bus number, Device
+  number, and Function number.
+
+  For the purpose of this document, when treated as a numeric value, a RID is
+  formatted such that:
+
+    * Bits [15:8] are the Bus number.
+    * Bits [7:3] are the Device number.
+    * Bits [2:0] are the Function number.
+    * Any other bits required for padding must be zero.
+
+  IOMMUs may distinguish PCI devices through sideband data derived from the
+  Requester ID. While a given PCI device can only master through one IOMMU, a
+  root complex may split masters across a set of IOMMUs (e.g. with one IOMMU
+  per bus).
+
+  The generic 'iommus' property is insufficient to describe this relationship,
+  and a mechanism is required to map from a PCI device to its IOMMU and
+  sideband data.
+
+  For generic IOMMU bindings, see
+  Documentation/devicetree/bindings/iommu/iommu.txt.
+
+properties:
+  iommu-map:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: |
+      Maps a Requester ID to an IOMMU and associated IOMMU specifier data.
+
+      The property is an arbitrary number of tuples of (rid-base, iommu,
+      iommu-base, length).
+
+      Any RID r in the interval [rid-base, rid-base + length) is associated
+      with the listed IOMMU, with the IOMMU specifier (r - rid-base +
+      iommu-base).
+
+  iommu-map-mask:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      A mask to be applied to each Requester ID prior to being mapped to an
+      IOMMU specifier per the iommu-map property.
+
+examples:
+  - |
+    iommu0: iommu@a {
+        reg = <0xa 0x1>;
+        compatible = "vendor,some-iommu";
+        #iommu-cells = <1>;
+    };
+
+    pci@f {
+        reg = <0xf 0x1>;
+        compatible = "vendor,pcie-root-complex";
+        device_type = "pci";
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0 0x00000000 0x00000000 0 0x00000000>;
+
+        /*
+         * The sideband data provided to the IOMMU is the RID,
+         * identity-mapped.
+         */
+        iommu-map = <0x0 &iommu0 0x0 0x10000>;
+    };
+
+  - |
+    iommu1: iommu@a {
+        reg = <0xa 0x1>;
+        compatible = "vendor,some-iommu";
+        #iommu-cells = <1>;
+    };
+
+    pci@f {
+        reg = <0xf 0x1>;
+        compatible = "vendor,pcie-root-complex";
+        device_type = "pci";
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0 0x00000000 0x00000000 0 0x00000000>;
+
+        /*
+         * The sideband data provided to the IOMMU is the RID with the
+         * function bits masked out.
+         */
+        iommu-map = <0x0 &iommu 0x0 0x10000>;
+        iommu-map-mask = <0xfff8>;
+    };
+
+  - |
+    iommu2: iommu@a {
+        reg = <0xa 0x1>;
+        compatible = "vendor,some-iommu";
+        #iommu-cells = <1>;
+    };
+
+    pci@f {
+        reg = <0xf 0x1>;
+        compatible = "vendor,pcie-root-complex";
+        device_type = "pci";
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0 0x00000000 0x00000000 0 0x00000000>;
+
+        /*
+         * The sideband data provided to the IOMMU is the RID,
+         * but the high bits of the bus number are flipped.
+         */
+        iommu-map = <0x0000 &iommu2 0x8000 0x8000>,
+                    <0x8000 &iommu2 0x0000 0x8000>;
+    };
+
+  - |
+    iommu_a: iommu@a {
+        reg = <0xa 0x1>;
+        compatible = "vendor,some-iommu";
+        #iommu-cells = <1>;
+    };
+
+    iommu_b: iommu@b {
+        reg = <0xb 0x1>;
+        compatible = "vendor,some-iommu";
+        #iommu-cells = <1>;
+    };
+
+    iommu_c: iommu@c {
+        reg = <0xc 0x1>;
+        compatible = "vendor,some-iommu";
+        #iommu-cells = <1>;
+    };
+
+    pci@f {
+        reg = <0xf 0x1>;
+        compatible = "vendor,pcie-root-complex";
+        device_type = "pci";
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0 0x00000000 0x00000000 0 0x00000000>;
+
+        /*
+         * Devices with bus number 0-127 are mastered via IOMMU
+         * a, with sideband data being RID[14:0].
+         * Devices with bus number 128-255 are mastered via
+         * IOMMU b, with sideband data being RID[14:0].
+         * No devices master via IOMMU c.
+         */
+        iommu-map = <0x0000 &iommu_a 0x0000 0x8000>,
+                    <0x8000 &iommu_b 0x0000 0x8000>;
+    };
-- 
2.24.1


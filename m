Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6152003B5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgFSIXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 04:23:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgFSIVH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 04:21:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AED12B;
        Fri, 19 Jun 2020 01:20:51 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D353F71F;
        Fri, 19 Jun 2020 01:20:48 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>
Subject: [PATCH v2 08/12] dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus
Date:   Fri, 19 Jun 2020 09:20:09 +0100
Message-Id: <20200619082013.13661-9-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The existing bindings cannot be used to specify the relationship
between fsl-mc devices and GIC ITSes.
Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
msi-map property.
In addition, deprecate msi-parent property which no longer makes sense
now that we support translating the MSIs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 50 ++++++++++++++++---
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 9134e9bcca56..ebd329181c14 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -28,6 +28,16 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
 For arm-smmu binding, see:
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
 
+The MSI writes are accompanied by sideband data which is derived from the ICID.
+The msi-map property is used to associate the devices with both the ITS
+controller and the sideband data which accompanies the writes.
+
+For generic MSI bindings, see
+Documentation/devicetree/bindings/interrupt-controller/msi.txt.
+
+For GICv3 and GIC ITS bindings, see:
+Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
+
 Required properties:
 
     - compatible
@@ -49,11 +59,6 @@ Required properties:
                         region may not be present in some scenarios, such
                         as in the device tree presented to a virtual machine.
 
-    - msi-parent
-        Value type: <phandle>
-        Definition: Must be present and point to the MSI controller node
-                    handling message interrupts for the MC.
-
     - ranges
         Value type: <prop-encoded-array>
         Definition: A standard property.  Defines the mapping between the child
@@ -119,6 +124,28 @@ Optional properties:
   associated with the listed IOMMU, with the iommu-specifier
   (i - icid-base + iommu-base).
 
+- msi-map: Maps an ICID to a GIC ITS and associated msi-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,gic-its,msi-base,length).
+
+  Any ICID in the interval [icid-base, icid-base + length) is
+  associated with the listed GIC ITS, with the msi-specifier
+  (i - icid-base + msi-base).
+
+Deprecated properties:
+
+    - msi-parent
+        Value type: <phandle>
+        Definition: Describes the MSI controller node handling message
+                    interrupts for the MC. When there is no translation
+                    between the ICID and deviceID this property can be used
+                    to describe the MSI controller used by the devices on the
+                    mc-bus.
+                    The use of this property for mc-bus is deprecated. Please
+                    use msi-map.
+
 Example:
 
         smmu: iommu@5000000 {
@@ -128,13 +155,24 @@ Example:
                ...
         };
 
+        gic: interrupt-controller@6000000 {
+               compatible = "arm,gic-v3";
+               ...
+        }
+        its: gic-its@6020000 {
+               compatible = "arm,gic-v3-its";
+               msi-controller;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-                msi-parent = <&its>;
                 /* define map for ICIDs 23-64 */
                 iommu-map = <23 &smmu 23 41>;
+                /* define msi map for ICIDs 23-64 */
+                msi-map = <23 &its 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
2.26.1


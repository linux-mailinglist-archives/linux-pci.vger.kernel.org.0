Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577811DCD8D
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgEUNAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 09:00:44 -0400
Received: from foss.arm.com ([217.140.110.172]:46196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbgEUNAm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 09:00:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5DC1045;
        Thu, 21 May 2020 06:00:41 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.29.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A613F305;
        Thu, 21 May 2020 06:00:39 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
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
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus
Date:   Thu, 21 May 2020 14:00:05 +0100
Message-Id: <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
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

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 9134e9bcca56..b0813b2d0493 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
 the requester.
 
 The generic 'iommus' property is insufficient to describe the relationship
-between ICIDs and IOMMUs, so an iommu-map property is used to define
-the set of possible ICIDs under a root DPRC and how they map to
-an IOMMU.
+between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
+to define the set of possible ICIDs under a root DPRC and how they map to
+an IOMMU and a GIC ITS respectively.
 
 For generic IOMMU bindings, see
 Documentation/devicetree/bindings/iommu/iommu.txt.
@@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
 For arm-smmu binding, see:
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
 
+For GICv3 and GIC ITS bindings, see:
+Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
+
 Required properties:
 
     - compatible
@@ -119,6 +122,15 @@ Optional properties:
   associated with the listed IOMMU, with the iommu-specifier
   (i - icid-base + iommu-base).
 
+- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,iommu,iommu-base,length).
+
+  Any ICID in the interval [icid-base, icid-base + length) is
+  associated with the listed GIC ITS, with the iommu-specifier
+  (i - icid-base + iommu-base).
 Example:
 
         smmu: iommu@5000000 {
@@ -128,6 +140,16 @@ Example:
                ...
         };
 
+	gic: interrupt-controller@6000000 {
+		compatible = "arm,gic-v3";
+		...
+		its: gic-its@6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			...
+		};
+	};
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
@@ -135,6 +157,8 @@ Example:
                 msi-parent = <&its>;
                 /* define map for ICIDs 23-64 */
                 iommu-map = <23 &smmu 23 41>;
+                /* define msi map for ICIDs 23-64 */
+                msi-map = <23 &its 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
2.26.1


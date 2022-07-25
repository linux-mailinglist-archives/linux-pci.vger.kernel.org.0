Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2D5802E5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiGYQjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiGYQjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:39:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 129FA1D303;
        Mon, 25 Jul 2022 09:39:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 654AA153B;
        Mon, 25 Jul 2022 09:39:16 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B5163F73D;
        Mon, 25 Jul 2022 09:39:15 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     will@kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 4/4] dt-bindings: PCI: Note the use of pci-host-smc-generic
Date:   Mon, 25 Jul 2022 11:39:05 -0500
Message-Id: <20220725163905.2024437-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220725163905.2024437-1-jeremy.linton@arm.com>
References: <20220725163905.2024437-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Note the addition of pci-host-smc-generic for
firmware based config assistance, and the relaxation
of the 'reg' property for such machines.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 .../bindings/pci/host-generic-pci.yaml        | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 6bcaa8f2c3cf..b4471617fa46 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -18,10 +18,11 @@ description: |
   presenting a set of fixed windows describing a subset of IO, Memory and
   Configuration Spaces.
 
-  Configuration Space is assumed to be memory-mapped (as opposed to being
-  accessed via an ioport) and laid out with a direct correspondence to the
-  geography of a PCI bus address by concatenating the various components to
-  form an offset.
+  Configuration Space is assumed to be laid out with a direct correspondence
+  to the geography of a PCI bus address by concatenating the various components
+  to form an offset. The CAM and ECAM mechanisms require a memory mapped
+  interface, while the SMC traps to the firmware to perform config space
+  reads and writes decoded similarly to the ECAM mapping.
 
   For CAM, this 24-bit offset is:
 
@@ -86,6 +87,7 @@ properties:
         enum:
           - pci-host-cam-generic
           - pci-host-ecam-generic
+          - pci-host-smc-generic
 
   reg:
     description:
@@ -93,7 +95,8 @@ properties:
       bus. The base address corresponds to the first bus in the "bus-range"
       property. If no "bus-range" is specified, this will be bus 0 (the
       default). Some host controllers have a 2nd non-compliant address range,
-      so 2 entries are allowed.
+      so 2 entries are allowed. Machines which implement the Arm PCI SMCCC spec
+      must not provide this property.
     minItems: 1
     maxItems: 2
 
@@ -109,7 +112,6 @@ properties:
 
 required:
   - compatible
-  - reg
   - ranges
 
 allOf:
@@ -123,6 +125,16 @@ allOf:
       required:
         - dma-coherent
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: pci-host-smc-generic
+    then:
+      required:
+        - reg
+
   - if:
       properties:
         compatible:
-- 
2.37.1


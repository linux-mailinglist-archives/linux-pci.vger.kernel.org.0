Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE33C6F7A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhGMLU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 07:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235536AbhGMLU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 07:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A19161164;
        Tue, 13 Jul 2021 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175088;
        bh=CN7ehAB5S35gvRZXjgzc9EKa/GhaE/o4PIt57vBUW2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4kK59fa/hhPkvxvlYGMYFNr3ka38OaDXTCD3EYXdVsHf/IOzZBOdVI8DNAmBU80G
         0iOCtxuTjid2vOeo/T1vGchORjx7dPHAdfiBSP7q79wvUp9VqoU1/CWJm9xv7W+94v
         FNY7iDLHPkrulr/wge4Dz04gZ+YkI8zdQxL8Z09NsK7Xs4rQXRUkpxFf11ZeyeVpEj
         B4+YVWwot5Wk616AiK0eB3Yh7V1c1F59QnSJhpmeMO7F68HhWE8QGUUUByrlgzxFvY
         4oXmXfQ/smtFkaU6pFUqX+BhlFfCjr2aN4stohb4GBcvmZdKTU8AoSgEvszUbG4rAK
         JOrZGiMp0sQ4g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3GQL-006b3k-1e; Tue, 13 Jul 2021 13:18:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: PCI: remove designware-pcie.txt
Date:   Tue, 13 Jul 2021 13:17:54 +0200
Message-Id: <30b3b4cd8708c6684d9de9d962a3569bd703ba39.1626174242.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626174242.git.mchehab+huawei@kernel.org>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the properties defined there were converted to DT schema,
and the other dt-bindings are pointing to the new schemas,
drop it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/designware-pcie.txt          | 77 -------------------
 MAINTAINERS                                   |  1 -
 2 files changed, 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
deleted file mode 100644
index 78494c4050f7..000000000000
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-* Synopsys DesignWare PCIe interface
-
-Required properties:
-- compatible:
-	"snps,dw-pcie" for RC mode;
-	"snps,dw-pcie-ep" for EP mode;
-- reg: For designware cores version < 4.80 contains the configuration
-       address space. For designware core version >= 4.80, contains
-       the configuration and ATU address space
-- reg-names: Must be "config" for the PCIe configuration space and "atu" for
-	     the ATU address space.
-    (The old way of getting the configuration address space from "ranges"
-    is deprecated and should be avoided.)
-RC mode:
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- device_type: set to "pci"
-- ranges: ranges for the PCI memory and I/O regions
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI
-	properties to define the mapping of the PCIe interface to interrupt
-	numbers.
-EP mode:
-- num-ib-windows: number of inbound address translation windows
-- num-ob-windows: number of outbound address translation windows
-
-Optional properties:
-- num-lanes: number of lanes to use (this property should be specified unless
-  the link is brought already up in BIOS)
-- reset-gpio: GPIO pin number of power good signal
-- clocks: Must contain an entry for each entry in clock-names.
-	See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-	- "pcie"
-	- "pcie_bus"
-- snps,enable-cdm-check: This is a boolean property and if present enables
-   automatic checking of CDM (Configuration Dependent Module) registers
-   for data corruption. CDM registers include standard PCIe configuration
-   space registers, Port Logic registers, DMA and iATU (internal Address
-   Translation Unit) registers.
-RC mode:
-- num-viewport: number of view ports configured in hardware. If a platform
-  does not specify it, the driver assumes 2.
-- bus-range: PCI bus numbers covered (it is recommended for new devicetrees
-  to specify this property, to keep backwards compatibility a range of
-  0x00-0xff is assumed if not present)
-
-EP mode:
-- max-functions: maximum number of functions that can be configured
-
-Example configuration:
-
-	pcie: pcie@dfc00000 {
-		compatible = "snps,dw-pcie";
-		reg = <0xdfc00000 0x0001000>, /* IP registers */
-		      <0xd0000000 0x0002000>; /* Configuration space */
-		reg-names = "dbi", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
-			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
-		interrupts = <25>, <24>;
-		#interrupt-cells = <1>;
-		num-lanes = <1>;
-	};
-or
-	pcie: pcie@dfc00000 {
-		compatible = "snps,dw-pcie-ep";
-		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
-		      <0xdfc01000 0x0001000>, /* IP registers 2 */
-		      <0xd0000000 0x2000000>; /* Configuration space */
-		reg-names = "dbi", "dbi2", "addr_space";
-		num-ib-windows = <6>;
-		num-ob-windows = <2>;
-		num-lanes = <1>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index f0cf510c26fd..b54bd9dd07ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14282,7 +14282,6 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/*designware*
-- 
2.31.1


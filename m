Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B09F3CC8CD
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 13:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhGRLn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 07:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhGRLn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF269611AC;
        Sun, 18 Jul 2021 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626608458;
        bh=NQtcaMW3WONkvO9K0k2+VTaH0xarqr2QJAoOPFOVUqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qvg/sFH7+40sx2UTTWPjyLFGDx5xMQVWeK+uLQjiE8DgP3ELlsVDncAedLoPTQEix
         dm1broT8/0OG59S24I+nTkZbswXgexEfqtZk5J3RJyHDVhGKHzZ+ICdy20pH0LNJ/u
         qNumXw5nT0Alk7i4DGxtvG83tboQQ5V5GwZHYgZtplYv56rIdUCEIiEND3GZKdVYJj
         OoxepRjFI4BNJljCMJXL8y2FQ0C5GUlQ4Usix4mWz0j0TXMgMrIsb3CnDPzhgHr6hk
         uqL0Fd4YDvUZcnIMbBc6a7y7TGoiVhBc2p97wTHfc4uloAGRQ/Mr6hmGvLZCX1K/vD
         +hzNK0FzuqCOg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m55AE-001Dw9-CL; Sun, 18 Jul 2021 13:40:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v5 4/5] dt-bindings: PCI: remove designware-pcie.txt
Date:   Sun, 18 Jul 2021 13:40:51 +0200
Message-Id: <c93261b41f9ffe8d97d8c930f57b41aaf7de5264.1626608375.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626608375.git.mchehab+huawei@kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
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
index 5818733eace7..bc28b27764e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14305,7 +14305,6 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/*designware*
-- 
2.31.1


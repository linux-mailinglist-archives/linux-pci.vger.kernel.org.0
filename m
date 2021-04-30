Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3236FDCA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhD3PdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:33:18 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38655 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhD3PdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:33:17 -0400
Received: by mail-ot1-f46.google.com with SMTP id v23-20020a9d60570000b02902a53bac99a3so9973793otj.5;
        Fri, 30 Apr 2021 08:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCLS1GLyQlkGp3zu1BU9RazGdGYYmfQhtwc4wI/aLgg=;
        b=h8WWQONUWlWcfq0FNnxp3nNMiq/PN62EFCfaYzF8uCs4CysqopJmWSNq8etjk6TgPk
         kj0hJg4o9pSXdbCG4CHVJT1KtXgaA2Ni1mxw+dyHBcdANQ3XnALzqwOybJYaA6Y4DBbn
         1J9XrqGrXJQGJiYvUgURcI3erOmNmZLXFOYU2UI5GhIlwU1RJddrMZzqWd8E40odeY+Q
         vuy+sx623N0DYH+moc1jKCPt8B2OadfN+RBHwJh4oIsdkyEh6szePTySZfum593BAHHl
         S1rE4jRDFLQWQHxjpWgopYYuBLdu7lN2HFFF5R1EW7OsV4G9l37tLqIfhGYTlTgVp5w0
         OdHQ==
X-Gm-Message-State: AOAM533l61+vl8NXR4mLbp6EYLjBjUbjRWA6YCca6Ww/L7hgdGRE0Ohu
        uhodIl3WciUbB9vAAcvY4uvuhccIwQ==
X-Google-Smtp-Source: ABdhPJxspi8koawi87rDZP8S4ambTTkmJXTP/reXKGk5kGoiZqXjRxtH1DFAiLza5teOv/WVW/j/Wg==
X-Received: by 2002:a9d:d0f:: with SMTP id 15mr564205oti.255.1619796747191;
        Fri, 30 Apr 2021 08:32:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j22sm757610otr.0.2021.04.30.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:32:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove unused Sigma Designs Tango bindings
Date:   Fri, 30 Apr 2021 10:32:25 -0500
Message-Id: <20210430153225.3366000-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Sigma Designs Tango support has been removed, but 2 binding docs
for NAND and PCIe were missed. Remove them.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/tango-nand.txt    | 38 -------------------
 .../devicetree/bindings/pci/tango-pcie.txt    | 29 --------------
 2 files changed, 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/tango-nand.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt

diff --git a/Documentation/devicetree/bindings/mtd/tango-nand.txt b/Documentation/devicetree/bindings/mtd/tango-nand.txt
deleted file mode 100644
index 91c8420241af..000000000000
--- a/Documentation/devicetree/bindings/mtd/tango-nand.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Sigma Designs Tango4 NAND Flash Controller (NFC)
-
-Required properties:
-
-- compatible: "sigma,smp8758-nand"
-- reg: address/size of nfc_reg, nfc_mem, and pbus_reg
-- dmas: reference to the DMA channel used by the controller
-- dma-names: "rxtx"
-- clocks: reference to the system clock
-- #address-cells: <1>
-- #size-cells: <0>
-
-Children nodes represent the available NAND chips.
-See Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindings.
-
-Example:
-
-	nandc: nand-controller@2c000 {
-		compatible = "sigma,smp8758-nand";
-		reg = <0x2c000 0x30>, <0x2d000 0x800>, <0x20000 0x1000>;
-		dmas = <&dma0 3>;
-		dma-names = "rxtx";
-		clocks = <&clkgen SYS_CLK>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		nand@0 {
-			reg = <0>; /* CS0 */
-			nand-ecc-strength = <14>;
-			nand-ecc-step-size = <1024>;
-		};
-
-		nand@1 {
-			reg = <1>; /* CS1 */
-			nand-ecc-strength = <14>;
-			nand-ecc-step-size = <1024>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
deleted file mode 100644
index 244683836a79..000000000000
--- a/Documentation/devicetree/bindings/pci/tango-pcie.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Sigma Designs Tango PCIe controller
-
-Required properties:
-
-- compatible: "sigma,smp8759-pcie"
-- reg: address/size of PCI configuration space, address/size of register area
-- bus-range: defined by size of PCI configuration space
-- device_type: "pci"
-- #size-cells: <2>
-- #address-cells: <3>
-- msi-controller
-- ranges: translation from system to bus addresses
-- interrupts: spec for misc interrupts, spec for MSI
-
-Example:
-
-	pcie@2e000 {
-		compatible = "sigma,smp8759-pcie";
-		reg = <0x50000000 0x400000>, <0x2e000 0x100>;
-		bus-range = <0 3>;
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		msi-controller;
-		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 0x3c00000>;
-		interrupts =
-			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
-			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
-	};
-- 
2.27.0


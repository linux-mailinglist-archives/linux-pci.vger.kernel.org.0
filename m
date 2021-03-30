Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7434E9D9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhC3OFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 10:05:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15406 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhC3OFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 10:05:24 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8rlD3GBdzpStM;
        Tue, 30 Mar 2021 22:03:36 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 22:05:10 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <wangzhou1@hisilicon.com>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH V2] dt-bindings: PCI: hisi: Delete the obsolete HiSilicon PCIe file
Date:   Tue, 30 Mar 2021 21:43:19 +0800
Message-ID: <1617111799-109749-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hisilicon-pcie.txt file is no longer useful since commit
c2fa6cf76d20 (PCI: dwc: hisi: Remove non-ECAM HiSilicon
hip05/hip06 driver), so delete it and remove related code in
MAINTAINERS file.

Suggested-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---
v1->v2:
Fix comments by Krzysztof.
Remove related code in MAINTAINERS file suggested by Zhou.
---
 .../devicetree/bindings/pci/hisilicon-pcie.txt     | 43 ----------------------
 MAINTAINERS                                        |  1 -
 2 files changed, 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
deleted file mode 100644
index d6796ef..0000000
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-HiSilicon Hip05 and Hip06 PCIe host bridge DT description
-
-HiSilicon PCIe host controller is based on the Synopsys DesignWare PCI core.
-It shares common functions with the PCIe DesignWare core driver and inherits
-common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
-
-Additional properties are described here:
-
-Required properties
-- compatible: Should contain "hisilicon,hip05-pcie" or "hisilicon,hip06-pcie".
-- reg: Should contain rc_dbi, config registers location and length.
-- reg-names: Must include the following entries:
-  "rc_dbi": controller configuration registers;
-  "config": PCIe configuration space registers.
-- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
-- port-id: Should be 0, 1, 2 or 3.
-
-Optional properties:
-- status: Either "ok" or "disabled".
-- dma-coherent: Present if DMA operations are coherent.
-
-Hip05 Example (note that Hip06 is the same except compatible):
-	pcie@b0080000 {
-		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
-		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
-		reg-names = "rc_dbi", "config";
-		bus-range = <0  15>;
-		msi-parent = <&its_pcie>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		dma-coherent;
-		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
-		num-lanes = <8>;
-		port-id = <1>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <0x0 0 0 1 &mbigen_pcie 1 10
-				 0x0 0 0 2 &mbigen_pcie 2 11
-				 0x0 0 0 3 &mbigen_pcie 3 12
-				 0x0 0 0 4 &mbigen_pcie 4 13>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e87692..f7f0c18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13899,7 +13899,6 @@ PCIE DRIVER FOR HISILICON
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/controller/dwc/pcie-hisi.c

 PCIE DRIVER FOR HISILICON KIRIN
--
1.9.1


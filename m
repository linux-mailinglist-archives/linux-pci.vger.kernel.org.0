Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB534B6BF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC0LJk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 07:09:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14173 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhC0LJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 07:09:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6wyv4mdhznbBZ;
        Sat, 27 Mar 2021 19:07:03 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 19:09:28 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <wangzhou1@hisilicon.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH] dt-bindings: PCI: hisi: Delete the useless HiSilicon PCIe file
Date:   Sat, 27 Mar 2021 18:47:42 +0800
Message-ID: <1616842062-21823-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hisilicon-pcie.txt file is no longer useful since commit
c2fa6cf76d20 (PCI: dwc: hisi: Remove non-ECAM HiSilicon
hip05/hip06 driver), so delete it.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 .../devicetree/bindings/pci/hisilicon-pcie.txt     | 43 ----------------------
 1 file changed, 43 deletions(-)
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
-- 
1.9.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038362E98DC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbhADPcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 10:32:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39544 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbhADPco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 10:32:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104FUu9G030070;
        Mon, 4 Jan 2021 09:30:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609774256;
        bh=4Fz6/znawPVT5Re4ej/ysxXwiAWhNVKJ7aypY2BXCzQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pOSIOr6eMrMCFb65QsL60EzRrGkJ2cbkRxCPoGXt9am++B7B1LLPsY1z2ZnFQaA6H
         ljuNPaPSSj3XxfOV9oe1xXZucuKwtZylHDhjatPbgDi4ST7LiY23+bIDg4oJIAt1Fc
         Rpd3QRbbrEOawqcwTtsRzQrZqEvOtKlMpH4U68gI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104FUu9j081325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 09:30:56 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 09:30:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 09:30:56 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104FTFZN093710;
        Mon, 4 Jan 2021 09:30:51 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
Subject: [PATCH v9 17/17] Documentation: PCI: Add userguide for PCI endpoint NTB function
Date:   Mon, 4 Jan 2021 20:59:09 +0530
Message-ID: <20210104152909.22038-18-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104152909.22038-1-kishon@ti.com>
References: <20210104152909.22038-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add documentation to help users use pci-epf-ntb function driver and
existing host side NTB infrastructure for NTB functionality.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/PCI/endpoint/index.rst         |   1 +
 Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 9cb6e5f3c4d5..38ea1f604b6d 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -12,6 +12,7 @@ PCI Endpoint Framework
    pci-test-function
    pci-test-howto
    pci-ntb-function
+   pci-ntb-howto
 
    function/binding/pci-test
    function/binding/pci-ntb
diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
new file mode 100644
index 000000000000..b6e1073c9a39
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
@@ -0,0 +1,160 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+PCI Non-Transparent Bridge (NTB) Endpoint Function (EPF) User Guide
+===================================================================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
+
+This document is a guide to help users use pci-epf-ntb function driver
+and ntb_hw_epf host driver for NTB functionality. The list of steps to
+be followed in the host side and EP side is given below. For the hardware
+configuration and internals of NTB using configurable endpoints see
+Documentation/PCI/endpoint/pci-ntb-function.rst
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+For implementing NTB functionality at least two endpoint controller devices
+are required.
+To find the list of endpoint controller devices in the system::
+
+        # ls /sys/class/pci_epc/
+          2900000.pcie-ep  2910000.pcie-ep
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	  2900000.pcie-ep  2910000.pcie-ep
+
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	  pci_epf_ntb   pci_epf_ntb
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	  pci_epf_ntb   pci_epf_ntb
+
+
+Creating pci-epf-ntb Device
+----------------------------
+
+PCI endpoint function device can be created using the configfs. To create
+pci-epf-ntb device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_ntb/func1
+
+The "mkdir func1" above creates the pci-epf-ntb function device that will
+be probed by pci_epf_ntb driver.
+
+The PCI endpoint framework populates the directory with the following
+configurable fields::
+
+	# ls functions/pci_epf_ntb/func1
+          baseclass_code    deviceid          msi_interrupts    pci-epf-ntb.0
+          progif_code       secondary         subsys_id         vendorid
+          cache_line_size   interrupt_pin     msix_interrupts   primary
+          revid             subclass_code     subsys_vendor_id
+
+The PCI endpoint function driver populates these entries with default values
+when the device is bound to the driver. The pci-epf-ntb driver populates
+vendorid with 0xffff and interrupt_pin with 0x0001::
+
+	# cat functions/pci_epf_ntb/func1/vendorid
+	  0xffff
+	# cat functions/pci_epf_ntb/func1/interrupt_pin
+	  0x0001
+
+
+Configuring pci-epf-ntb Device
+-------------------------------
+
+The user can configure the pci-epf-ntb device using its configfs entry. In order
+to change the vendorid and the deviceid, the following
+commands can be used::
+
+	# echo 0x104c > functions/pci_epf_ntb/func1/vendorid
+	# echo 0xb00d > functions/pci_epf_ntb/func1/deviceid
+
+In order to configure NTB specific attributes, a new sub-directory to func1
+should be created::
+
+	# mkdir functions/pci_epf_ntb/func1/pci_epf_ntb.0/
+
+The NTB function driver will populate this directory with various attributes
+that can be configured by the user::
+
+	# ls functions/pci_epf_ntb/func1/pci_epf_ntb.0/
+          db_count    mw1         mw2         mw3         mw4         num_mws
+          spad_count
+
+A sample configuration for NTB function is given below::
+
+	# echo 4 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/db_count
+	# echo 128 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/spad_count
+	# echo 2 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/num_mws
+	# echo 0x100000 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/mw1
+	# echo 0x100000 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/mw2
+
+Binding pci-epf-ntb Device to EP Controller
+--------------------------------------------
+
+NTB function device should be attached to two PCIe endpoint controllers
+connected to the two hosts. Use the 'primary' and 'secondary' entries
+inside NTB function device to attach one PCIe endpoint controller to
+primary interface and the other PCIe endpoint controller to the secondary
+interface. ::
+
+        # ln -s controllers/2900000.pcie-ep/ functions/pci-epf-ntb/func1/primary
+        # ln -s controllers/2910000.pcie-ep/ functions/pci-epf-ntb/func1/secondary
+
+Once the above step is completed, both the PCI endpoint controllers are ready to
+establish a link with the host.
+
+
+Start the Link
+--------------
+
+In order for the endpoint device to establish a link with the host, the _start_
+field should be populated with '1'. For NTB, both the PCIe endpoint controllers
+should establish link with the host::
+
+        #echo 1 > controllers/2900000.pcie-ep/start
+        #echo 1 > controllers/2910000.pcie-ep/start
+
+
+RootComplex Device
+==================
+
+lspci Output
+------------
+
+Note that the devices listed here correspond to the values populated in
+"Creating pci-epf-ntb Device" section above::
+
+        # lspci
+        0000:00:00.0 PCI bridge: Texas Instruments Device b00d
+        0000:01:00.0 RAM memory: Texas Instruments Device b00d
+
+
+Using ntb_hw_epf Device
+-----------------------
+
+The host side software follows the standard NTB software architecture in Linux.
+All the existing client side NTB utilities like NTB Transport Client and NTB
+Netdev, NTB Ping Pong Test Client and NTB Tool Test Client can be used with NTB
+function device.
+
+For more information on NTB see
+:doc:`Non-Transparent Bridge <../../driver-api/ntb>`
-- 
2.17.1


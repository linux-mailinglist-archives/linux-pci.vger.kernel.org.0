Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FEC1B82E
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfEMOVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:21:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34772 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfEMOVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:21:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so6586422plz.1;
        Mon, 13 May 2019 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPJyTDsfdBAYb4kysJw7JhftNxA9CSPFTGsSIHtwfqc=;
        b=PKz9xIzJsV8FvKKhM32LY9tJ7AHA3ixuXLI1lNTCsneFKSdjEsR8if+ZA9ZIOTiCzy
         KulwGbA0Ovs88qAmzVu9/0+OxJjpbVHNt9qhIFH8Xc3h7LVRo1dGypp8pR9RKvAi2l2y
         Uj/mNgnhk6ioflcHfefO4PRGD2rXa3XuFsC3bN4g/iNKgWy0fGrfQ/1KTkPumxWq9enc
         Zq2WqI+023SBJFKYLTLD+enzTC9B3HSodHqWwO4O9IrxniXUvzeepw/L3Gat8uIgX4A4
         An1t8K4aLh3fUBq5stbtG8Z31AA99l+Ubu2uOk4aDNrrNKHZqlgj8e7hwtf/N6HUEQwl
         hh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPJyTDsfdBAYb4kysJw7JhftNxA9CSPFTGsSIHtwfqc=;
        b=nnJY5OS465P3UXx4OxKSwwxcFa7JPEv1wlWXU9hx+2k1yv5vYWZVQ0KC6W9eLsNPpf
         iefM5VqBS4PTD3/soU09GVO8ddKpoGjbCtysbW1Qn5918jArg8ljL7/GV0uMa0kO3vac
         xXpirn4Z4GuERskPCnrHNdofQPi9eUY6C0TgYkGMpyhuqcuX7GRRjHbv/TK8smYXAQ9b
         UFGFAHAspZKLF7E0q0taW1/dJNHoo68lYyX1GVWToDvKF6QAz/M33dXUR5nwm1RJ5LwR
         nUSJmCWeETe8y/4ierKyHj4y5Q6TKmZCVOSJyqUlrY/0GyJo77WV14XCKlcAbLbhtvGG
         p5Pw==
X-Gm-Message-State: APjAAAVZWCBu9xuG3Mr4LQcASqOyECNs76hnKVor1ULJnIift2kpGlTY
        Eu3YQj7clgHuVsL18BmWDHj/6Awi
X-Google-Smtp-Source: APXvYqwYSqe/GEqOGH/lyLIgfVJAq5QTol2Yp2DjbbJT03ray/MdMiX9stOY2sF5Wfh2TU9SKAGsAw==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr7447898plb.238.1557757289676;
        Mon, 13 May 2019 07:21:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.21.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:21:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 12/12] Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
Date:   Mon, 13 May 2019 22:20:00 +0800
Message-Id: <20190513142000.3524-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513142000.3524-1-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/PCI/endpoint/index.rst          |  1 +
 ...{pci-test-howto.txt => pci-test-howto.rst} | 81 +++++++++++++------
 2 files changed, 56 insertions(+), 26 deletions(-)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index b680a3fc4fec..d114ea74b444 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -10,3 +10,4 @@ PCI Endpoint Framework
    pci-endpoint
    pci-endpoint-cfs
    pci-test-function
+   pci-test-howto
diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.rst
similarity index 78%
rename from Documentation/PCI/endpoint/pci-test-howto.txt
rename to Documentation/PCI/endpoint/pci-test-howto.rst
index 040479f437a5..909f770a07d6 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.txt
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -1,38 +1,51 @@
-			    PCI TEST USERGUIDE
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+PCI Test User Guide
+===================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to help users use pci-epf-test function driver
 and pci_endpoint_test host driver for testing PCI. The list of steps to
 be followed in the host side and EP side is given below.
 
-1. Endpoint Device
+Endpoint Device
+===============
 
-1.1 Endpoint Controller Devices
+Endpoint Controller Devices
+---------------------------
 
-To find the list of endpoint controller devices in the system:
+To find the list of endpoint controller devices in the system::
 
 	# ls /sys/class/pci_epc/
 	  51000000.pcie_ep
 
-If PCI_ENDPOINT_CONFIGFS is enabled
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
 	# ls /sys/kernel/config/pci_ep/controllers
 	  51000000.pcie_ep
 
-1.2 Endpoint Function Drivers
 
-To find the list of endpoint function drivers in the system:
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
 
 	# ls /sys/bus/pci-epf/drivers
 	  pci_epf_test
 
-If PCI_ENDPOINT_CONFIGFS is enabled
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
 	# ls /sys/kernel/config/pci_ep/functions
 	  pci_epf_test
 
-1.3 Creating pci-epf-test Device
+
+Creating pci-epf-test Device
+----------------------------
 
 PCI endpoint function device can be created using the configfs. To create
-pci-epf-test device, the following commands can be used
+pci-epf-test device, the following commands can be used::
 
 	# mount -t configfs none /sys/kernel/config
 	# cd /sys/kernel/config/pci_ep/
@@ -42,7 +55,7 @@ The "mkdir func1" above creates the pci-epf-test function device that will
 be probed by pci_epf_test driver.
 
 The PCI endpoint framework populates the directory with the following
-configurable fields.
+configurable fields::
 
 	# ls functions/pci_epf_test/func1
 	  baseclass_code	interrupt_pin	progif_code	subsys_id
@@ -51,67 +64,83 @@ configurable fields.
 
 The PCI endpoint function driver populates these entries with default values
 when the device is bound to the driver. The pci-epf-test driver populates
-vendorid with 0xffff and interrupt_pin with 0x0001
+vendorid with 0xffff and interrupt_pin with 0x0001::
 
 	# cat functions/pci_epf_test/func1/vendorid
 	  0xffff
 	# cat functions/pci_epf_test/func1/interrupt_pin
 	  0x0001
 
-1.4 Configuring pci-epf-test Device
+
+Configuring pci-epf-test Device
+-------------------------------
 
 The user can configure the pci-epf-test device using configfs entry. In order
 to change the vendorid and the number of MSI interrupts used by the function
-device, the following commands can be used.
+device, the following commands can be used::
 
 	# echo 0x104c > functions/pci_epf_test/func1/vendorid
 	# echo 0xb500 > functions/pci_epf_test/func1/deviceid
 	# echo 16 > functions/pci_epf_test/func1/msi_interrupts
 	# echo 8 > functions/pci_epf_test/func1/msix_interrupts
 
-1.5 Binding pci-epf-test Device to EP Controller
+
+Binding pci-epf-test Device to EP Controller
+--------------------------------------------
 
 In order for the endpoint function device to be useful, it has to be bound to
 a PCI endpoint controller driver. Use the configfs to bind the function
-device to one of the controller driver present in the system.
+device to one of the controller driver present in the system::
 
 	# ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
 
 Once the above step is completed, the PCI endpoint is ready to establish a link
 with the host.
 
-1.6 Start the Link
+
+Start the Link
+--------------
 
 In order for the endpoint device to establish a link with the host, the _start_
-field should be populated with '1'.
+field should be populated with '1'::
 
 	# echo 1 > controllers/51000000.pcie_ep/start
 
-2. RootComplex Device
 
-2.1 lspci Output
+RootComplex Device
+==================
+
+lspci Output
+------------
 
-Note that the devices listed here correspond to the value populated in 1.4 above
+Note that the devices listed here correspond to the value populated in 1.4
+above::
 
 	00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01)
 	01:00.0 Unassigned class [ff00]: Texas Instruments Device b500
 
-2.2 Using Endpoint Test function Device
+
+Using Endpoint Test function Device
+-----------------------------------
 
 pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
-tests. To compile this tool the following commands should be used:
+tests. To compile this tool the following commands should be used::
 
 	# cd <kernel-dir>
 	# make -C tools/pci
 
-or if you desire to compile and install in your system:
+or if you desire to compile and install in your system::
 
 	# cd <kernel-dir>
 	# make -C tools/pci install
 
 The tool and script will be located in <rootfs>/usr/bin/
 
-2.2.1 pcitest.sh Output
+
+pcitest.sh Output
+~~~~~~~~~~~~~~~~~
+::
+
 	# pcitest.sh
 	BAR tests
 
-- 
2.20.1


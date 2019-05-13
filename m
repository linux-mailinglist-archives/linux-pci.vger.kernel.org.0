Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C71B822
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfEMOVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:21:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39849 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfEMOVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:21:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so6572180plm.6;
        Mon, 13 May 2019 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iV4qf7P3wOSNgHYBGx5p21x5gyc5f2HpE3IlLQrdRX4=;
        b=rW6mU6ZsyncVmrqb0C7+DcerxJ3S9eZ63mFx3uHJqAn09NwhbkN+KaL+ezqdaubqxn
         L+oGodge33szY2ooMT4T6RvH+ioq87CU6lShORsiYi7UE9zkmomFzgDxfNltHxNuC1jB
         s67JsCMjXafQEgd31ApsswNNGKfdeqqrkOs/lRp1DR14GxWqkmU4F1EA9fIX3WjfzSBh
         JbdY+6sz1NeJFBN0bO49s3JAeETWo4HGP1emHEXvR7lWwSTq/fnSTRLp2TvlKieaF8ik
         uldPADOmgAjAPDUzvTiK/jIZgocvbCoIrpJpbzrAISWQVE11heEJ/MZUR6rGRg8oRM5+
         dn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iV4qf7P3wOSNgHYBGx5p21x5gyc5f2HpE3IlLQrdRX4=;
        b=offu6p9t8dKuamy5ipLLNAw/SkyGix7zZA+IWOlh3VIxYzBjKAnYnlWtQhGLrT+N5t
         htLUZOuiAmlzoz+Qv7ZmzSVhkVR3aL9otrBwcc++cHYm3GAldrp7oPUsHZKXcg+YICz6
         pl6jGlbUjgbC/zwxCEkAivQ9neTYk+SZxqrqMRPU1d9ipqKEUgPBera0+X7ENO1ANbwe
         CttnoHwCc3PMBApGVncOe9mEchyB9xhsVZHOQOuIuZfzkFyBPJ8+3duiAD5ZsI4g9I9Z
         AwWQoQE1njpJMGMjcdeRis9y8zvg0WSr3L8jMmwb3TPJz0VFhAIn6OUzjJ5yuFYj4QaX
         H7VA==
X-Gm-Message-State: APjAAAX48Epozj/rLLozOG4+RwjZqn9zmDj947nswgp8PsyqV0iFle6M
        4ih9LVL9iaEzbDCHDV9e9HM=
X-Google-Smtp-Source: APXvYqwKRpm1fZg8q4xO1JWiEe29GpK9aOP9/tBFAGNMj++StXh6crbWxewENM6lm7jFtQ3HpEbsog==
X-Received: by 2002:a17:902:e708:: with SMTP id co8mr30700551plb.141.1557757264251;
        Mon, 13 May 2019 07:21:04 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.20.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:21:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 08/12] Documentation: PCI: convert pcieaer-howto.txt to reST
Date:   Mon, 13 May 2019 22:19:56 +0800
Message-Id: <20190513142000.3524-9-changbin.du@gmail.com>
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
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/PCI/index.rst                   |   1 +
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 156 +++++++++++-------
 2 files changed, 101 insertions(+), 56 deletions(-)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 92e62d0fc9e6..f54b65b1ca5f 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -14,3 +14,4 @@ Linux PCI Bus Subsystem
    msi-howto
    acpi-info
    pci-error-recovery
+   pcieaer-howto
diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.rst
similarity index 72%
rename from Documentation/PCI/pcieaer-howto.txt
rename to Documentation/PCI/pcieaer-howto.rst
index 48ce7903e3c6..18bdefaafd1a 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -1,21 +1,29 @@
-   The PCI Express Advanced Error Reporting Driver Guide HOWTO
-		T. Long Nguyen	<tom.l.nguyen@intel.com>
-		Yanmin Zhang	<yanmin.zhang@intel.com>
-				07/29/2006
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+===========================================================
+The PCI Express Advanced Error Reporting Driver Guide HOWTO
+===========================================================
 
-1. Overview
+:Authors: - T. Long Nguyen <tom.l.nguyen@intel.com>
+          - Yanmin Zhang <yanmin.zhang@intel.com>
 
-1.1 About this guide
+:Copyright: |copy| 2006 Intel Corporation
+
+Overview
+===========
+
+About this guide
+----------------
 
 This guide describes the basics of the PCI Express Advanced Error
 Reporting (AER) driver and provides information on how to use it, as
 well as how to enable the drivers of endpoint devices to conform with
 PCI Express AER driver.
 
-1.2 Copyright (C) Intel Corporation 2006.
 
-1.3 What is the PCI Express AER Driver?
+What is the PCI Express AER Driver?
+-----------------------------------
 
 PCI Express error signaling can occur on the PCI Express link itself
 or on behalf of transactions initiated on the link. PCI Express
@@ -30,17 +38,19 @@ The PCI Express AER driver provides the infrastructure to support PCI
 Express Advanced Error Reporting capability. The PCI Express AER
 driver provides three basic functions:
 
--	Gathers the comprehensive error information if errors occurred.
--	Reports error to the users.
--	Performs error recovery actions.
+  - Gathers the comprehensive error information if errors occurred.
+  - Reports error to the users.
+  - Performs error recovery actions.
 
 AER driver only attaches root ports which support PCI-Express AER
 capability.
 
 
-2. User Guide
+User Guide
+==========
 
-2.1 Include the PCI Express AER Root Driver into the Linux Kernel
+Include the PCI Express AER Root Driver into the Linux Kernel
+-------------------------------------------------------------
 
 The PCI Express AER Root driver is a Root Port service driver attached
 to the PCI Express Port Bus driver. If a user wants to use it, the driver
@@ -48,7 +58,8 @@ has to be compiled. Option CONFIG_PCIEAER supports this capability. It
 depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
 CONFIG_PCIEAER = y.
 
-2.2 Load PCI Express AER Root Driver
+Load PCI Express AER Root Driver
+--------------------------------
 
 Some systems have AER support in firmware. Enabling Linux AER support at
 the same time the firmware handles AER may result in unpredictable
@@ -56,30 +67,34 @@ behavior. Therefore, Linux does not handle AER events unless the firmware
 grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
 Specification for details regarding _OSC usage.
 
-2.3 AER error output
+AER error output
+----------------
 
 When a PCIe AER error is captured, an error message will be output to
 console. If it's a correctable error, it is output as a warning.
 Otherwise, it is printed as an error. So users could choose different
 log level to filter out correctable error messages.
 
-Below shows an example:
-0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
-0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
-0000:50:00.0:    [20] Unsupported Request    (First)
-0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
+Below shows an example::
+
+  0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
+  0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
+  0000:50:00.0:    [20] Unsupported Request    (First)
+  0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
 
 In the example, 'Requester ID' means the ID of the device who sends
 the error message to root port. Pls. refer to pci express specs for
 other fields.
 
-2.4 AER Statistics / Counters
+AER Statistics / Counters
+-------------------------
 
 When PCIe AER errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 
-3. Developer Guide
+Developer Guide
+===============
 
 To enable AER aware support requires a software driver to configure
 the AER capability structure within its device and to provide callbacks.
@@ -120,7 +135,8 @@ hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
 
-3.1 Configure the AER capability structure
+Configure the AER capability structure
+--------------------------------------
 
 AER aware drivers of PCI Express component need change the device
 control registers to enable AER. They also could change AER registers,
@@ -128,9 +144,11 @@ including mask and severity registers. Helper function
 pci_enable_pcie_error_reporting could be used to enable AER. See
 section 3.3.
 
-3.2. Provide callbacks
+Provide callbacks
+-----------------
 
-3.2.1 callback reset_link to reset pci express link
+callback reset_link to reset pci express link
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This callback is used to reset the pci express physical link when a
 fatal error happens. The root port aer service driver provides a
@@ -140,13 +158,15 @@ upstream ports should provide their own reset_link functions.
 
 In struct pcie_port_service_driver, a new pointer, reset_link, is
 added.
+::
 
-pci_ers_result_t (*reset_link) (struct pci_dev *dev);
+	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
 
 Section 3.2.2.2 provides more detailed info on when to call
 reset_link.
 
-3.2.2 PCI error-recovery callbacks
+PCI error-recovery callbacks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The PCI Express AER Root driver uses error callbacks to coordinate
 with downstream device drivers associated with a hierarchy in question
@@ -161,7 +181,8 @@ definitions of the callbacks.
 
 Below sections specify when to call the error callback functions.
 
-3.2.2.1 Correctable errors
+Correctable errors
+~~~~~~~~~~~~~~~~~~
 
 Correctable errors pose no impacts on the functionality of
 the interface. The PCI Express protocol can recover without any
@@ -169,13 +190,16 @@ software intervention or any loss of data. These errors do not
 require any recovery actions. The AER driver clears the device's
 correctable error status register accordingly and logs these errors.
 
-3.2.2.2 Non-correctable (non-fatal and fatal) errors
+Non-correctable (non-fatal and fatal) errors
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If an error message indicates a non-fatal error, performing link reset
 at upstream is not required. The AER driver calls error_detected(dev,
 pci_channel_io_normal) to all drivers associated within a hierarchy in
-question. for example,
-EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort.
+question. for example::
+
+  EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort
+
 If Upstream port A captures an AER error, the hierarchy consists of
 Downstream port B and EndPoint.
 
@@ -199,53 +223,72 @@ function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
 reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
 
-3.3 helper functions
+helper functions
+----------------
+::
+
+  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 
-3.3.1 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 pci_enable_pcie_error_reporting enables the device to send error
 messages to root port when an error is detected. Note that devices
 don't enable the error reporting by default, so device drivers need
 call this function to enable it.
 
-3.3.2 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+::
+
+  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+
 pci_disable_pcie_error_reporting disables the device to send error
 messages to root port when an error is detected.
 
-3.3.3 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+::
+
+  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
+
 pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
 error status register.
 
-3.4 Frequent Asked Questions
+Frequent Asked Questions
+------------------------
 
-Q: What happens if a PCI Express device driver does not provide an
-error recovery handler (pci_driver->err_handler is equal to NULL)?
+Q:
+  What happens if a PCI Express device driver does not provide an
+  error recovery handler (pci_driver->err_handler is equal to NULL)?
 
-A: The devices attached with the driver won't be recovered. If the
-error is fatal, kernel will print out warning messages. Please refer
-to section 3 for more information.
+A:
+  The devices attached with the driver won't be recovered. If the
+  error is fatal, kernel will print out warning messages. Please refer
+  to section 3 for more information.
 
-Q: What happens if an upstream port service driver does not provide
-callback reset_link?
+Q:
+  What happens if an upstream port service driver does not provide
+  callback reset_link?
 
-A: Fatal error recovery will fail if the errors are reported by the
-upstream ports who are attached by the service driver.
+A:
+  Fatal error recovery will fail if the errors are reported by the
+  upstream ports who are attached by the service driver.
 
-Q: How does this infrastructure deal with driver that is not PCI
-Express aware?
+Q:
+  How does this infrastructure deal with driver that is not PCI
+  Express aware?
 
-A: This infrastructure calls the error callback functions of the
-driver when an error happens. But if the driver is not aware of
-PCI Express, the device might not report its own errors to root
-port.
+A:
+  This infrastructure calls the error callback functions of the
+  driver when an error happens. But if the driver is not aware of
+  PCI Express, the device might not report its own errors to root
+  port.
 
-Q: What modifications will that driver need to make it compatible
-with the PCI Express AER Root driver?
+Q:
+  What modifications will that driver need to make it compatible
+  with the PCI Express AER Root driver?
 
-A: It could call the helper functions to enable AER in devices and
-cleanup uncorrectable status register. Pls. refer to section 3.3.
+A:
+  It could call the helper functions to enable AER in devices and
+  cleanup uncorrectable status register. Pls. refer to section 3.3.
 
 
-4. Software error injection
+Software error injection
+========================
 
 Debugging PCIe AER error recovery code is quite difficult because it
 is hard to trigger real hardware errors. Software based error
@@ -261,6 +304,7 @@ After reboot with new kernel or insert the module, a device file named
 
 Then, you need a user space tool named aer-inject, which can be gotten
 from:
+
     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
 More information about aer-inject can be found in the document comes
-- 
2.20.1


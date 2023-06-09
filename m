Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3A72A63F
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjFIWZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjFIWZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 18:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C71359C
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 15:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A8E265C9F
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 22:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6F3C433EF;
        Fri,  9 Jun 2023 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686349517;
        bh=18eqYvuUgumbqmoU8CxmwyRnQEsJ0+q+1eIDDvqKTFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kru0NueqTk1wblhOrYQZdPb2cCNkQFNTtLRuCnG6IMt1634n/0POgmGeUNgZCCqbB
         zIq4owbXbh2RJ/+T7Et4uH/QFYJIeFCtaf6l8uemNZhnsKLgrBy5j2gHu8Qz5TAsD8
         U5u9X400qqP8LEyh/DsNvDmZ5If1O1Tog13NDLMPe7Eo1qsMsir7PBkaTmKnFlgSkR
         7hup3mlqCCIp+Y9aT3uNRnvpPvp0fGp9I9Rfg55fl9jkCoSBMyNBxUatlLVwr+0E5X
         yVQCYaf2vqLx55TR1H+UFSOtU+qOmCb7nnc35mRSuBZd02S5Bz3scyixdsHt2Z98W4
         YQlw/MnA96BYA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/4] Documentation: PCI: Tidy AER documentation
Date:   Fri,  9 Jun 2023 17:25:00 -0500
Message-Id: <20230609222500.1267795-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609222500.1267795-1-helgaas@kernel.org>
References: <20230609222500.1267795-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Consistently use:

  PCIe          previously PCIe, PCI Express, or pci express
  Root Port     previously Root Port or root port
  Endpoint      previously EndPoint or endpoint
  AER           previously AER or aer
  please        previously pls

Also update a few awkward wordings.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pcieaer-howto.rst | 131 ++++++++++++++--------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 3f91d54af770..e00d63971695 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -16,62 +16,61 @@ Overview
 About this guide
 ----------------
 
-This guide describes the basics of the PCI Express Advanced Error
+This guide describes the basics of the PCI Express (PCIe) Advanced Error
 Reporting (AER) driver and provides information on how to use it, as
-well as how to enable the drivers of endpoint devices to conform with
-PCI Express AER driver.
+well as how to enable the drivers of Endpoint devices to conform with
+the PCIe AER driver.
 
 
-What is the PCI Express AER Driver?
------------------------------------
+What is the PCIe AER Driver?
+----------------------------
 
-PCI Express error signaling can occur on the PCI Express link itself
-or on behalf of transactions initiated on the link. PCI Express
+PCIe error signaling can occur on the PCIe link itself
+or on behalf of transactions initiated on the link. PCIe
 defines two error reporting paradigms: the baseline capability and
 the Advanced Error Reporting capability. The baseline capability is
-required of all PCI Express components providing a minimum defined
+required of all PCIe components providing a minimum defined
 set of error reporting requirements. Advanced Error Reporting
-capability is implemented with a PCI Express advanced error reporting
+capability is implemented with a PCIe Advanced Error Reporting
 extended capability structure providing more robust error reporting.
 
-The PCI Express AER driver provides the infrastructure to support PCI
-Express Advanced Error Reporting capability. The PCI Express AER
-driver provides three basic functions:
+The PCIe AER driver provides the infrastructure to support PCIe Advanced
+Error Reporting capability. The PCIe AER driver provides three basic
+functions:
 
   - Gathers the comprehensive error information if errors occurred.
   - Reports error to the users.
   - Performs error recovery actions.
 
-AER driver only attaches root ports which support PCI-Express AER
-capability.
+The AER driver only attaches to Root Ports and RCECs that support the PCIe
+AER capability.
 
 
 User Guide
 ==========
 
-Include the PCI Express AER Root Driver into the Linux Kernel
--------------------------------------------------------------
+Include the PCIe AER Root Driver into the Linux Kernel
+------------------------------------------------------
 
-The PCI Express AER Root driver is a Root Port service driver attached
-to the PCI Express Port Bus driver. If a user wants to use it, the driver
-has to be compiled. Option CONFIG_PCIEAER supports this capability. It
-depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
-CONFIG_PCIEAER = y.
+The PCIe AER driver is a Root Port service driver attached
+via the PCIe Port Bus driver. If a user wants to use it, the driver
+must be compiled. It is enabled with CONFIG_PCIEAER, which
+depends on CONFIG_PCIEPORTBUS.
 
-Load PCI Express AER Root Driver
---------------------------------
+Load PCIe AER Root Driver
+-------------------------
 
 Some systems have AER support in firmware. Enabling Linux AER support at
-the same time the firmware handles AER may result in unpredictable
+the same time the firmware handles AER would result in unpredictable
 behavior. Therefore, Linux does not handle AER events unless the firmware
-grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
+grants AER control to the OS via the ACPI _OSC method. See the PCI Firmware
 Specification for details regarding _OSC usage.
 
 AER error output
 ----------------
 
 When a PCIe AER error is captured, an error message will be output to
-console. If it's a correctable error, it is output as a warning.
+console. If it's a correctable error, it is output as an info message.
 Otherwise, it is printed as an error. So users could choose different
 log level to filter out correctable error messages.
 
@@ -82,9 +81,9 @@ Below shows an example::
   0000:50:00.0:    [20] Unsupported Request    (First)
   0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
 
-In the example, 'Requester ID' means the ID of the device who sends
-the error message to root port. Pls. refer to pci express specs for
-other fields.
+In the example, 'Requester ID' means the ID of the device that sent
+the error message to the Root Port. Please refer to PCIe specs for other
+fields.
 
 AER Statistics / Counters
 -------------------------
@@ -96,41 +95,41 @@ Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 Developer Guide
 ===============
 
-To enable AER aware support requires a software driver to provide
-callbacks.
+To enable error recovery, a software driver must provide callbacks.
 
-To support AER better, developers need understand how AER does work
-firstly.
+To support AER better, developers need to understand how AER works.
 
-PCI Express errors are classified into two types: correctable errors
-and uncorrectable errors. This classification is based on the impacts
+PCIe errors are classified into two types: correctable errors
+and uncorrectable errors. This classification is based on the impact
 of those errors, which may result in degraded performance or function
 failure.
 
 Correctable errors pose no impacts on the functionality of the
-interface. The PCI Express protocol can recover without any software
+interface. The PCIe protocol can recover without any software
 intervention or any loss of data. These errors are detected and
-corrected by hardware. Unlike correctable errors, uncorrectable
+corrected by hardware.
+
+Unlike correctable errors, uncorrectable
 errors impact functionality of the interface. Uncorrectable errors
-can cause a particular transaction or a particular PCI Express link
+can cause a particular transaction or a particular PCIe link
 to be unreliable. Depending on those error conditions, uncorrectable
 errors are further classified into non-fatal errors and fatal errors.
 Non-fatal errors cause the particular transaction to be unreliable,
-but the PCI Express link itself is fully functional. Fatal errors, on
+but the PCIe link itself is fully functional. Fatal errors, on
 the other hand, cause the link to be unreliable.
 
-When AER is enabled, a PCI Express device will automatically send an
-error message to the PCIe root port above it when the device captures
+When PCIe error reporting is enabled, a device will automatically send an
+error message to the Root Port above it when it captures
 an error. The Root Port, upon receiving an error reporting message,
-internally processes and logs the error message in its PCI Express
-capability structure. Error information being logged includes storing
+internally processes and logs the error message in its AER
+Capability structure. Error information being logged includes storing
 the error reporting agent's requestor ID into the Error Source
 Identification Registers and setting the error bits of the Root Error
-Status Register accordingly. If AER error reporting is enabled in Root
-Error Command Register, the Root Port generates an interrupt if an
+Status Register accordingly. If AER error reporting is enabled in the Root
+Error Command Register, the Root Port generates an interrupt when an
 error is detected.
 
-Note that the errors as described above are related to the PCI Express
+Note that the errors as described above are related to the PCIe
 hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
@@ -138,14 +137,14 @@ the device driver.
 Provide callbacks
 -----------------
 
-callback reset_link to reset pci express link
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+callback reset_link to reset PCIe link
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This callback is used to reset the pci express physical link when a
-fatal error happens. The root port aer service driver provides a
-default reset_link function, but different upstream ports might
-have different specifications to reset pci express link, so all
-upstream ports should provide their own reset_link functions.
+This callback is used to reset the PCIe physical link when a
+fatal error happens. The Root Port AER service driver provides a
+default reset_link function, but different Upstream Ports might
+have different specifications to reset the PCIe link, so
+Upstream Port drivers may provide their own reset_link functions.
 
 Section 3.2.2.2 provides more detailed info on when to call
 reset_link.
@@ -153,24 +152,24 @@ reset_link.
 PCI error-recovery callbacks
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The PCI Express AER Root driver uses error callbacks to coordinate
+The PCIe AER Root driver uses error callbacks to coordinate
 with downstream device drivers associated with a hierarchy in question
 when performing error recovery actions.
 
 Data struct pci_driver has a pointer, err_handler, to point to
 pci_error_handlers who consists of a couple of callback function
-pointers. AER driver follows the rules defined in
-pci-error-recovery.rst except pci express specific parts (e.g.
-reset_link). Pls. refer to pci-error-recovery.rst for detailed
+pointers. The AER driver follows the rules defined in
+pci-error-recovery.rst except PCIe-specific parts (e.g.
+reset_link). Please refer to pci-error-recovery.rst for detailed
 definitions of the callbacks.
 
-Below sections specify when to call the error callback functions.
+The sections below specify when to call the error callback functions.
 
 Correctable errors
 ~~~~~~~~~~~~~~~~~~
 
 Correctable errors pose no impacts on the functionality of
-the interface. The PCI Express protocol can recover without any
+the interface. The PCIe protocol can recover without any
 software intervention or any loss of data. These errors do not
 require any recovery actions. The AER driver clears the device's
 correctable error status register accordingly and logs these errors.
@@ -181,12 +180,12 @@ Non-correctable (non-fatal and fatal) errors
 If an error message indicates a non-fatal error, performing link reset
 at upstream is not required. The AER driver calls error_detected(dev,
 pci_channel_io_normal) to all drivers associated within a hierarchy in
-question. for example::
+question. For example::
 
-  EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort
+  Endpoint <==> Downstream Port B <==> Upstream Port A <==> Root Port
 
-If Upstream port A captures an AER error, the hierarchy consists of
-Downstream port B and EndPoint.
+If Upstream Port A captures an AER error, the hierarchy consists of
+Downstream Port B and Endpoint.
 
 A driver may return PCI_ERS_RESULT_CAN_RECOVER,
 PCI_ERS_RESULT_DISCONNECT, or PCI_ERS_RESULT_NEED_RESET, depending on
@@ -207,7 +206,7 @@ Frequent Asked Questions
 ------------------------
 
 Q:
-  What happens if a PCI Express device driver does not provide an
+  What happens if a PCIe device driver does not provide an
   error recovery handler (pci_driver->err_handler is equal to NULL)?
 
 A:
@@ -244,5 +243,5 @@ from:
 
     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
-More information about aer-inject can be found in the document comes
-with its source code.
+More information about aer-inject can be found in the document in
+its source code.
-- 
2.34.1


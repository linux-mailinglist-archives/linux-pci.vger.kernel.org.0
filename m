Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C065772A63D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjFIWZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjFIWZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 18:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43553359D
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 15:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55A56574B
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 22:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AB4C433EF;
        Fri,  9 Jun 2023 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686349513;
        bh=nseC6wZXew+P7GsSIeFvw7TjfqoYsAbSg4t2AF0brKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecYvCyN53Vs+ZuLeRm7hZIPgdYmqg3V6ZEuw0PZ0Oo5Djuf+5Va+boCQWcWd1ihPu
         a6seF+MRDszBuvmmtagMZzkMrOepva1pIj8Sau3s3RP7HM9/qD1SinRAddnlK9qRYp
         aiDMpOkLF8qOxiw6lWBVeF3T3tYEeaTeM6VZSkErbofqNvY6kKO9yJiS0a0MIjR4in
         ZEq418txQjqrViBYxk6e4hPBK1bohN2UUCypmaO8baNaCq4Hqgpx83XQAG2WexVRMH
         ssFumYYEszt2zKBRzxOAU/qcnEu8A02x2QDq9IffuA8uH30SqycmYYjopx02V0BW96
         U7TrXpxNvhiIg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/4] Documentation: PCI: Drop recommendation to configure AER Capability
Date:   Fri,  9 Jun 2023 17:24:58 -0500
Message-Id: <20230609222500.1267795-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609222500.1267795-1-helgaas@kernel.org>
References: <20230609222500.1267795-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
the PCI core enables PCIe device error reporting for all devices during
enumeration, so drivers don't need to do it.

Remove the recommendation for drivers to configure AER and call
pci_enable_pcie_error_reporting() themselves.

Also remove the suggestion that drivers may change AER mask and severity
registers.  Ownership of these registers is negotiated between the OS and
platform firmware.  If firmware owns these registers, the OS must not
change them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 Documentation/PCI/pcieaer-howto.rst | 56 ++---------------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 0b36b9ebfa4b..c98a229ea9f5 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -96,8 +96,8 @@ Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 Developer Guide
 ===============
 
-To enable AER aware support requires a software driver to configure
-the AER capability structure within its device and to provide callbacks.
+To enable AER aware support requires a software driver to provide
+callbacks.
 
 To support AER better, developers need understand how AER does work
 firstly.
@@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
 
-Configure the AER capability structure
---------------------------------------
-
-AER aware drivers of PCI Express component need change the device
-control registers to enable AER. They also could change AER registers,
-including mask and severity registers. Helper function
-pci_enable_pcie_error_reporting could be used to enable AER. See
-section 3.3.
-
 Provide callbacks
 -----------------
 
@@ -212,31 +203,6 @@ to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
 and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
 
-helper functions
-----------------
-::
-
-  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
-
-pci_enable_pcie_error_reporting enables the device to send error
-messages to root port when an error is detected. Note that devices
-don't enable the error reporting by default, so device drivers need
-call this function to enable it.
-
-::
-
-  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
-
-pci_disable_pcie_error_reporting disables the device to send error
-messages to root port when an error is detected.
-
-::
-
-  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);`
-
-pci_aer_clear_nonfatal_status clears non-fatal errors in the uncorrectable
-error status register.
-
 Frequent Asked Questions
 ------------------------
 
@@ -257,24 +223,6 @@ A:
   Fatal error recovery will fail if the errors are reported by the
   upstream ports who are attached by the service driver.
 
-Q:
-  How does this infrastructure deal with driver that is not PCI
-  Express aware?
-
-A:
-  This infrastructure calls the error callback functions of the
-  driver when an error happens. But if the driver is not aware of
-  PCI Express, the device might not report its own errors to root
-  port.
-
-Q:
-  What modifications will that driver need to make it compatible
-  with the PCI Express AER Root driver?
-
-A:
-  It could call the helper functions to enable AER in devices and
-  cleanup uncorrectable status register. Pls. refer to section 3.3.
-
 
 Software error injection
 ========================
-- 
2.34.1


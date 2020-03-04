Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFEB178884
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgCDCjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:56583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgCDCjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866905"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 06/12] Documentation: PCI: Remove reset_link references
Date:   Tue,  3 Mar 2020 18:36:29 -0800
Message-Id: <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

After pcie_do_recovery() refactor, instead of reset_link
member in struct pcie_port_service_driver, we use reset_cb
callback parameter in pcie_do_recovery() function to pass
the service driver specific reset_link function. So modify
the Documentation to reflect the latest changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/PCI/pcieaer-howto.rst | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 18bdefaafd1a..0f3e5880efb8 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -147,7 +147,7 @@ section 3.3.
 Provide callbacks
 -----------------
 
-callback reset_link to reset pci express link
+callback reset_cb to reset pci express link
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This callback is used to reset the pci express physical link when a
@@ -156,11 +156,8 @@ default reset_link function, but different upstream ports might
 have different specifications to reset pci express link, so all
 upstream ports should provide their own reset_link functions.
 
-In struct pcie_port_service_driver, a new pointer, reset_link, is
-added.
-::
-
-	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
+In pcie_do_recovery function, reset_cb function pointer can be used
+to pass the port specific reset_link callback.
 
 Section 3.2.2.2 provides more detailed info on when to call
 reset_link.
@@ -212,13 +209,13 @@ error_detected(dev, pci_channel_io_frozen) to all drivers within
 a hierarchy in question. Then, performing link reset at upstream is
 necessary. As different kinds of devices might use different approaches
 to reset link, AER port service driver is required to provide the
-function to reset link. Firstly, kernel looks for if the upstream
-component has an aer driver. If it has, kernel uses the reset_link
-callback of the aer driver. If the upstream component has no aer driver
-and the port is downstream port, we will perform a hot reset as the
-default by setting the Secondary Bus Reset bit of the Bridge Control
-register associated with the downstream port. As for upstream ports,
-they should provide their own aer service drivers with reset_link
+function to reset link via reset_cb parameter of pcie_do_recovery()
+function call. If reset_cb is not NULL, recovery function will use it
+to reset the link. If there is no reset_cb callback provided and
+the port is downstream port, we will perform a hot reset as the default
+by setting the Secondary Bus Reset bit of the Bridge Control register
+associated with the downstream port. As for upstream ports,
+they should provide their own reset_link function via reset_cb callback
 function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
 reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
@@ -262,7 +259,7 @@ A:
 
 Q:
   What happens if an upstream port service driver does not provide
-  callback reset_link?
+  callback reset_cb?
 
 A:
   Fatal error recovery will fail if the errors are reported by the
-- 
2.25.1


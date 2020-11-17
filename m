Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E712B6E59
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKQTUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:20:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:31769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKQTUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 14:20:36 -0500
IronPort-SDR: CcSUa+peULv8BX74RGANtd/niPwF2V133bDGALbwu4jlLVZUz+R5TTTV4l4F1WEqQXNGHGsPlq
 6ftkFLtkHiPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168417195"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168417195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:34 -0800
IronPort-SDR: u06Rhl411ETR6L9Sn2gs33PHg6bN7q6fD/zxaXMBHSBz31WvQIX4MZcNWLnbY9H3fvTe/p8nEc
 KPkol5p0/KUA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="533931666"
Received: from rojasmor-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.231.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:33 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v11 00/16] Add RCEC handling to PCI/AER
Date:   Tue, 17 Nov 2020 11:19:38 -0800
Message-Id: <20201117191954.1322844-1-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v10 [1] and pci/master tree [2]:

- No functional changes. Tested with aer injection.

AER: aer_root_reset() non-native handling
- Noted lack of historical context on isolation of both the
pci_bus_error_reset() and the clearing of Root Error Status. In fact,
the call to aer_enable_rootport() likewise disables system error generation
in response to error messages around the clearing of the error status. So
retained the flow and the wrapping of the  "clear, reset, enable".

PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
- Added an extra check on existence of dev->rcec via the assignment of
the variable aer in combination with the existing check on
pcie_aer_is_native().

[1] https://lore.kernel.org/linux-pci/20201106001444.667232-1-sean.v.kelley@intel.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/


Root Complex Event Collectors (RCEC) provide support for terminating error
and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An RCEC
resides on a Bus in the Root Complex. Multiple RCECs can in fact reside on
a single bus. An RCEC will explicitly declare supported RCiEPs through the
Root Complex Endpoint Association Extended Capability.

(See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. Cap.))

The kernel lacks handling for these RCECs and the error messages received
from their respective associated RCiEPs. More recently, a new CPU
interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities for
purposes of error messaging from CXL 1.1 supported RCiEP devices.

DocLink: https://www.computeexpresslink.org/

This use case is not limited to CXL. Existing hardware today includes
support for RCECs, such as the Denverton microserver product
family. Future hardware will be forthcoming.

(See Intel Document, Order number: 33061-003US)

So services such as AER or PME could be associated with an RCEC driver.
In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated with a
platform's RCEC it shall signal PME and AER error conditions through that
RCEC.

Towards the above use cases, add the missing RCEC class and extend the
PCIe Root Port and service drivers to allow association of RCiEPs to their
respective parent RCEC and facilitate handling of terminating error and PME
messages.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #non-native/no RCEC

Qiuxu Zhuo (4):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (12):
  AER: aer_root_reset() non-native handling
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/ERR: Rename reset_link() to reset_subordinates()
  PCI/ERR: Simplify by using pci_upstream_bridge()
  PCI/ERR: Simplify by computing pci_pcie_type() once
  PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
  PCI/ERR: Avoid negated conditional for clarity
  PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
  PCI/ERR: Limit AER resets in pcie_do_recovery()
  PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
  PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
  PCI/PME: Add pcie_walk_rcec() to RCEC PME handling

 drivers/pci/pci.h               |  29 ++++-
 drivers/pci/pcie/Makefile       |   2 +-
 drivers/pci/pcie/aer.c          |  84 ++++++++++----
 drivers/pci/pcie/aer_inject.c   |   5 +-
 drivers/pci/pcie/err.c          |  93 +++++++++++-----
 drivers/pci/pcie/pme.c          |  15 ++-
 drivers/pci/pcie/portdrv_core.c |   9 +-
 drivers/pci/pcie/portdrv_pci.c  |   8 +-
 drivers/pci/pcie/rcec.c         | 190 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |   2 +
 include/linux/pci.h             |   5 +
 include/linux/pci_ids.h         |   1 +
 include/uapi/linux/pci_regs.h   |   7 ++
 13 files changed, 386 insertions(+), 64 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.29.2


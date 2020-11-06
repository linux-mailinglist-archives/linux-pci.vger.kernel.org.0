Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E02A8B31
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgKFAPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:15:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:23004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgKFAPI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:08 -0500
IronPort-SDR: /ouWvUINHyrgcAKr5YsCI9B8+cPhR1rlosvqYpISKKYrXjtiDy1avVrntUEU/EHFosTpY4pnXg
 FglsSxfDmWtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759521"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:05 -0800
IronPort-SDR: Po4Mv59ZiFm33GRA+bMex8AEd4jBdPh9+KgnQWeZQoPNmD8L1+QinhmCZ014BsHweO5DuZEchw
 uPRsRP/+qGFg==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621679"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:04 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v10 00/16] Add RCEC handling to PCI/AER
Date:   Thu,  5 Nov 2020 16:14:28 -0800
Message-Id: <20201106001444.667232-1-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v9 [1], based on discussion [2], AER patch [3],
and pci/master tree [4]:

- No functional changes. Tested with aer injection.

PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
- Tighten up aer_root_reset() as a preliminary patch separate from RCEC/RCIEP
series. So rebase series with the aer_root_reset() patch.
(Bjorn Helgaas)

[1] https://lore.kernel.org/linux-pci/20201016001113.2301761-1-seanvk.dev@oregontracks.org/
[2] https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precision-5520/
[3] https://lore.kernel.org/linux-pci/20201104232244.434115-1-sean.v.kelley@intel.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/


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
 drivers/pci/pcie/aer.c          |  79 +++++++++----
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
 13 files changed, 382 insertions(+), 63 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.29.2


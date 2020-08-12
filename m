Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695E242D90
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLQrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 12:47:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:33828 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgHLQrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Aug 2020 12:47:07 -0400
IronPort-SDR: 5uNKi1eEgsbnQ5RIsxQFKAd2F1AXS7aSty5sTOB6l00WqpZOKU7mzUxG8kXMEzYoUI94W5gGGf
 ek6bOpWhHOEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133538377"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="133538377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:06 -0700
IronPort-SDR: GeMpyFfscfPQ3/Q2X8U5RYDvZN6tyxMc4BPxsU+ouOvC1cUlcQTKNmslT6WEKl/MYmGx/4uGJC
 EMebacxg9G+w==
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="439442572"
Received: from ticede-or-099.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.58.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:04 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v3 00/10] Add RCEC handling to PCI/AER
Date:   Wed, 12 Aug 2020 09:46:49 -0700
Message-Id: <20200812164659.1118946-1-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Ongoing discussion on patch 4/9 [1]:

[1] https://lore.kernel.org/linux-pci/20200810103252.00000318@Huawei.com/

Changes since v2 [2]:

- Fix comment header for get_port_device_capability().
- Remove pcie_aer_is_native() check in pcie_do_recovery().
- Fix wording of error message in aer_inject().
- Use "non-native handling" in place of "firmware first"
(Jonathan Cameron)

- Prefer patches based on pci/master.
- Correct order of tags, especially when using Co-developed-by.
- Fix two patches ensuring that most important words appear early in one-liner.
- Check on type for bitmap in pcie_walk_rciep_devfn(). However, due to use
of for_each_set_bit() macro, const unsigned long is needed. Unchanged.
- Matching pci_dev_put() needed where pci_get_slot() is used.
- Read the RCEC Associated Endpoint Capabilities and cache them at enumeration
time, e.g., pci_init_capabilities().
- Remove unnecessary use of pci_find_bus() and corresponding check on value.
- Replace use of pdev/pbus with dev/bus (preferred naming style).
- Mention name of new function pci_walk_dev_affected() in 4/9.
- Use "()" after function names in log for 4/9.
- Fix width to wrap within 75 col for 4/9.
- Use word "bridge" in place of "port" in function comment.
- Fix style in conditional in pci_walk_dev_affected().
(Bjorn Helgaas)

[2] https://lore.kernel.org/linux-pci/20200804194052.193272-1-sean.v.kelley@intel.com/

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


Jonathan Cameron (1):
  PCI/AER: Extend AER error handling to RCECs

Qiuxu Zhuo (6):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/RCEC: Add pcie_walk_rcec() to walk associated RCiEPs
  PCI/AER: Apply function level reset to RCiEP on fatal error
  PCI: Add 'rcec' field to pci_dev for associated RCiEPs
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (3):
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/AER: Add RCEC AER handling
  PCI/PME: Add RCEC PME handling

 drivers/pci/pci.h               |  22 ++++++
 drivers/pci/pcie/Makefile       |   2 +-
 drivers/pci/pcie/aer.c          |  36 ++++++---
 drivers/pci/pcie/aer_inject.c   |   5 +-
 drivers/pci/pcie/err.c          |  85 +++++++++++++++++----
 drivers/pci/pcie/pme.c          |  15 +++-
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/pcie/portdrv_pci.c  |  20 ++++-
 drivers/pci/pcie/rcec.c         | 128 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |   2 +
 include/linux/pci.h             |   5 ++
 include/linux/pci_ids.h         |   1 +
 include/uapi/linux/pci_regs.h   |   7 ++
 13 files changed, 300 insertions(+), 36 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.28.0


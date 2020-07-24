Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0152B22CBEF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGXRWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:22:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:2758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXRWa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:30 -0400
IronPort-SDR: L8ZVvMReFcL9nKB3twul6pG3HTMAfnQRFeGRw3z7hfk2QFr5ri+VROgAOcGPBAncBjVqlw4QUe
 Dr4IrHlGdb5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130823238"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130823238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:29 -0700
IronPort-SDR: RCZ18sSisFVjxscl3aJapkVYwnFzSgiyMBkc9z0D/2H1O3HlOL0UlyCVtl0xPkLQgAN93QekfM
 DOtyQ8IPtWZQ==
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302730254"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.24.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:28 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@kernel.org, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [RFC PATCH 0/9] Add RCEC handling to PCI/AER
Date:   Fri, 24 Jul 2020 10:22:14 -0700
Message-Id: <20200724172223.145608-1-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

TESTING:

   Results:
    1) Show RCiEPs which are associated with RCECs:
	Run dmesg | grep "RCiEP"
	Log:
	[    8.981698] pcieport 0000:e8:00.4: RCiEP(under an RCEC) 0000:e8:01.0
	[    8.988830] pcieport 0000:e8:00.4: RCiEP(under an RCEC) 0000:e8:02.0
	[    8.995956] pcieport 0000:e8:00.4: RCiEP(under an RCEC) 0000:e9:00.0
	[    9.023034] pcieport 0000:ed:00.4: RCiEP(under an RCEC) 0000:ed:01.0
	[    9.030159] pcieport 0000:ed:00.4: RCiEP(under an RCEC) 0000:ed:02.0
	[    9.037282] pcieport 0000:ed:00.4: RCiEP(under an RCEC) 0000:ee:00.0
	[    9.064294] pcieport 0000:f2:00.4: RCiEP(under an RCEC) 0000:f2:01.0
	[    9.071409] pcieport 0000:f2:00.4: RCiEP(under an RCEC) 0000:f2:02.0
	[    9.078526] pcieport 0000:f2:00.4: RCiEP(under an RCEC) 0000:f3:00.0
	[    9.105535] pcieport 0000:f7:00.4: RCiEP(under an RCEC) 0000:f7:01.0
	[    9.112652] pcieport 0000:f7:00.4: RCiEP(under an RCEC) 0000:f7:02.0
	[    9.119774] pcieport 0000:f7:00.4: RCiEP(under an RCEC) 0000:f8:00.0

    2) Inject a correctable error to the RCiEP 0000:e9:00.0
	Run ./aer_inject <a parameter file as below>:
	AER
	PCI_ID 0000:e9:00.0
	COR_STATUS BAD_TLP
	HEADER_LOG 0 1 2 3

	Log:
	[  253.248362] pcieport 0000:e8:00.4: aer_inject: Injecting errors 00000040/00000000 into device 0000:e9:00.0
	[  253.260656] pcieport 0000:e8:00.4: AER: Corrected error received: 0000:e9:00.0
	[  253.269919] pci 0000:e9:00.0: AER: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
	[  253.282549] pci 0000:e9:00.0: AER:   device [8086:4940] error status/mask=00000040/00002000
	[  253.293937] pci 0000:e9:00.0: AER:    [ 6] BadTLP

    3) Inject a non-fatal error to the RCiEP 0000:e8:01.0
	Run ./aer_inject <a parameter file as below>:
	AER
	PCI_ID 0000:e8:01.0
	UNCOR_STATUS COMP_ABORT
	HEADER_LOG 0 1 2 3

	Log:
	[  288.405326] pcieport 0000:e8:00.4: aer_inject: Injecting errors 00000000/00008000 into device 0000:e8:01.0
	[  288.416881] pcieport 0000:e8:00.4: AER: Uncorrected (Non-Fatal) error received: 0000:e8:01.0
	[  288.427487] igen6_edac 0000:e8:01.0: AER: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer ID)
	[  288.442098] igen6_edac 0000:e8:01.0: AER:   device [8086:0b25] error status/mask=00008000/00100000
	[  288.452869] igen6_edac 0000:e8:01.0: AER:    [15] CmpltAbrt
	[  288.461118] igen6_edac 0000:e8:01.0: AER:   TLP Header: 00000000 00000001 00000002 00000003
	[  288.471192] igen6_edac 0000:e8:01.0: AER: device recovery successful

    4) Inject a fatal error to the RCiEP 0000:ed:01.0
	Run ./aer_inject <a parameter file as below>:
	AER
	PCI_ID 0000:ed:01.0
	UNCOR_STATUS MALF_TLP
	HEADER_LOG 0 1 2 3

	Log:
	[  535.537281] pcieport 0000:ed:00.4: aer_inject: Injecting errors 00000000/00040000 into device 0000:ed:01.0
	[  535.551911] pcieport 0000:ed:00.4: AER: Uncorrected (Fatal) error received: 0000:ed:01.0
	[  535.561556] igen6_edac 0000:ed:01.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
	[  535.684964] igen6_edac 0000:ed:01.0: AER: device recovery successful


Jonathan Cameron (1):
  PCI/AER: Extend AER error handling to RCECs

Qiuxu Zhuo (6):
  pci_ids: Add class code and extended capability for RCEC
  PCI: Extend Root Port Driver to support RCEC
  PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs associated with RCEC
  PCI/AER: Apply function level reset to RCiEP on fatal error
  PCI: Add 'rcec' field to pci_dev for associated RCiEPs
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (2):
  PCI/AER: Add RCEC AER handling
  PCI/PME: Add RCEC PME handling

 drivers/pci/pcie/aer.c          | 43 ++++++++++++-----
 drivers/pci/pcie/aer_inject.c   |  5 +-
 drivers/pci/pcie/err.c          | 85 +++++++++++++++++++++++++++------
 drivers/pci/pcie/pme.c          | 15 ++++--
 drivers/pci/pcie/portdrv.h      |  2 +
 drivers/pci/pcie/portdrv_core.c | 82 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_pci.c  | 20 +++++++-
 include/linux/pci.h             |  3 ++
 include/linux/pci_ids.h         |  1 +
 include/uapi/linux/pci_regs.h   |  7 +++
 10 files changed, 232 insertions(+), 31 deletions(-)

--
2.27.0


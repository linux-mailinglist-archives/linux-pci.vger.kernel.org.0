Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8B26E0A9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgIQQ0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 12:26:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:44126 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgIQQ0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:26:06 -0400
IronPort-SDR: KqhSo08t43PRozhHTbKbsSi05NvU/pZ72j/3gjeYyw0CZ4nngfLG+ZL0wJ6JN6kbmrARSLsp5d
 HJBb+a0Ca9iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139236813"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="139236813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:52 -0700
IronPort-SDR: R8Ghkbem4vprjlZhsEoN1X0wJ5JD1ezk/G7yxA9kWavIynpUWC1nn0bqaAJ4LcvnjPsDVFJLZX
 SHYpusB54LrA==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="332220045"
Received: from mbair-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.181.111])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:51 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH V4 00/10] Add RCEC handling to PCI/AER
Date:   Thu, 17 Sep 2020 09:25:38 -0700
Message-Id: <20200917162548.2079894-1-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v3 [1]:

- Merge usage patch and API (pcie_walk_rcec).
(Sathyanarayanan Kuppuswamy)

- Considering the possible ways to call pcie_do_recovery(), make
the flow more understandable through assignments of the incoming
devices in terms of 'bridges'.
- reset_link() may be misnamed. The point is really to reset any devices
below 'dev', which is a bridge. Using reset_subordinate_devices() makes it
more clear that we pass a bridge and reset the devices *below* it.
- In pcie_walk_rcec() an RCEC bus number does not indicate association
in the Assocated Bus Numbers register so skip it (7.9.10.3)
- Potential for a lot of churning to call pci_get_slot() in
pcie_walk_rciep_Devfn(). Attempt to reduce the number of calls by identifying
the associations through bus walks.
- Change pr_dbg of link RCiEP to "PME & error events reported via.."
(Bjorn Helgaas)

- In some cases (AER via APEI) there may not exist an RCEC. In these cases
the bridge is NULL. Account for that in the bridge walk.
(Jonathan Cameron)


[1] https://lore.kernel.org/linux-pci/20200812164659.1118946-1-sean.v.kelley@intel.com/


Jonathan Cameron (1):
  PCI/AER: Extend AER error handling to RCECs

Qiuxu Zhuo (5):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/AER: Apply function level reset to RCiEP on fatal error
  PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (4):
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
  PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
  PCI/PME: Add pcie_walk_rcec() to RCEC PME handling

 drivers/pci/pci.h               |  26 ++++-
 drivers/pci/pcie/Makefile       |   2 +-
 drivers/pci/pcie/aer.c          |  36 +++++--
 drivers/pci/pcie/aer_inject.c   |   5 +-
 drivers/pci/pcie/err.c          | 102 ++++++++++++++----
 drivers/pci/pcie/pme.c          |  15 ++-
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/pcie/portdrv_pci.c  |   8 +-
 drivers/pci/pcie/rcec.c         | 185 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |   3 +-
 include/linux/pci.h             |   5 +
 include/linux/pci_ids.h         |   1 +
 include/uapi/linux/pci_regs.h   |   7 ++
 13 files changed, 359 insertions(+), 44 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.28.0


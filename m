Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED74C1D7EA5
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgERQf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:35:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:16277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERQf1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:35:27 -0400
IronPort-SDR: acu3cf1c8cHr+7y7/Wc9xG7bmN/rctQv9hc1StRF9NZT0OFmb0QMd1DFGOLaJ3c1jF3iOzxP0s
 UnJLMnJqBXUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:27 -0700
IronPort-SDR: tIiZalxemVzC8wfCTjMDmUhf1WwA+VczUG28LAnt+JhT2xRo+Xk9R6nL8NzzqNQXQ+2ucqEMow
 LX0J846Z3BLQ==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="264014280"
Received: from kharjox-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.180.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:25 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH V2 0/3] PCI: Add basic Compute eXpress Link DVSEC decode
Date:   Mon, 18 May 2020 09:35:20 -0700
Message-Id: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1 [1]:

- Make use pci_info() and FLAG(), as in pcie_init().
- Wrap new cxl_cap in pci_dev struct within #ifdef PCI_CXL.
(Bjorn Helgaas)

- Added functionality for some CXL.mem and CXL.cache helper functions.
Snoop filter helper functions along with a performance hint as
well as a toggle for viral self-isolation mode could be implemented.
However, in the absence of CXL devices with their associated drivers, it
perhaps makes best sense to be in a holding pattern on this until we have
something to exercise it with.

Thoughts?

[1] https://lore.kernel.org/linux-pci/20200515175528.980103-1-sean.v.kelley@linux.intel.com/

This patch series implements basic Designated Vendor-Specific Extended
Capabilities (DVSEC) decode for Compute eXpress Link devices, a new CPU
interconnect building upon PCIe. As a basis for the CXL support it provides
PCI init handling for detection, decode, and caching of CXL device
capabilities.  Moreover, it makes use of the DVSEC Vendor ID and DVSEC ID so
as to identify a CXL capable device. (PCIe r5.0, sec 7.9.6.2)

DocLink: https://www.computeexpresslink.org/

For your reference, a parallel series of patches have been submitted to enable
lspci decode of CXL DVSEC and may be tracked.

Link: https://lore.kernel.org/linux-pci/20200511174618.10589-1-sean.v.kelley@linux.intel.com/

This patch makes use of pending DVSEC related header additions and the
first patch of that series is included here. It can be sorted out when the
upstream merge is done.

Link: https://lore.kernel.org/linux-pci/20200508021844.6911-2-david.e.box@linux.intel.com/

Sample dmesg output of a CXL Type 3 device (CXL.io, CXL.mem):
[    2.997177] pci 0000:6b:00.0: CXL: Cache- IO+ Mem+ Viral- HDMCount 1
[    2.997188] pci 0000:6b:00.0: CXL: cap ctrl status ctrl2 status2 lock
[    2.997201] pci 0000:6b:00.0: CXL: 001e 0002 0000 0000 0000 0000

David E. Box (1):
  pci: Add Designated Vendor Specific Capability

Sean V Kelley (2):
  PCI: Add basic Compute eXpress Link DVSEC decode
  PCI: Add helpers to enable/disable CXL.mem and CXL.cache

 drivers/pci/Kconfig           |   9 ++
 drivers/pci/Makefile          |   1 +
 drivers/pci/cxl.c             | 175 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  15 +++
 drivers/pci/probe.c           |   1 +
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |   5 +
 7 files changed, 209 insertions(+)
 create mode 100644 drivers/pci/cxl.c

--
2.26.2


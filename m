Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD01DBC4A
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETSGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 14:06:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:46824 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETSGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 14:06:44 -0400
IronPort-SDR: avk0EXXk/h0dCQNoTIak9WnOaGTj6Q8smROg7lR9ZwpJwHeLiMIkc9qMtdltJYm1w34//cBaIF
 i4bzjty01ymA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:06:44 -0700
IronPort-SDR: myMLfqYlETX8Cg344bi4EHE++S9oBorIPeTLkUaRdq/FJynnzL9+C2ORkE2Aw+T2IPrjnCbQU1
 aDQ0+RojBYyw==
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="289442233"
Received: from ydandeka-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.5.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:06:43 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH V3 0/3] PCI: Add basic Compute eXpress Link DVSEC decode
Date:   Wed, 20 May 2020 11:06:37 -0700
Message-Id: <20200520180640.1911202-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v2 [1]:

- Provide comment about what PCI_CXL_LOCK does.
- Use "cxl" in place of "pos" where appropriate to make code more descriptive.
- Remove unnecessary extra check for pci_is_pcie(dev).
- Remove reshuffling of pci_read_config_word() and put them in the right place
when first added.
- Make inline stubs consistent in format locally.
(Bjorn Helgaas)
- Add return to inline stubs to fix warning.
- Refreshed David's patch (V2)

[1] https://lore.kernel.org/linux-pci/20200518163523.1225643-1-sean.v.kelley@linux.intel.com/

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
  PCI: Add defines for Designated Vendor-Specific Capability

Sean V Kelley (2):
  PCI: Add basic Compute eXpress Link DVSEC decode
  PCI: Add helpers to enable/disable CXL.mem and CXL.cache

 drivers/pci/Kconfig           |   9 ++
 drivers/pci/Makefile          |   1 +
 drivers/pci/cxl.c             | 176 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  15 +++
 drivers/pci/probe.c           |   1 +
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |   5 +
 7 files changed, 210 insertions(+)
 create mode 100644 drivers/pci/cxl.c

--
2.26.2


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86841D5862
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEORzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 13:55:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:26829 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEORzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 13:55:33 -0400
IronPort-SDR: UIAnu/tCtLGImoaeSaH/xDDLuq6PRNd6cH37Ojq67LivAPTbGCH5ViLsFeT/Hf04Av5KxYpcLX
 76ktuMZAz6gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:55:32 -0700
IronPort-SDR: 9AkNMV+Z5iNMk5sGL13LOjuA8Bfj2b7u7jpkxwSw8qoxmYbxr9oI2Clt3PUW9VKkJf6+R/oAsI
 S+b3B64VNpYA==
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="464804635"
Received: from msethi-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.178.149])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:55:31 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [RFC PATCH 0/2] PCI: Add basic Compute eXpress Link DVSEC decode
Date:   Fri, 15 May 2020 10:55:26 -0700
Message-Id: <20200515175528.980103-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Sean V Kelley (1):
  PCI: Add basic Compute eXpress Link DVSEC decode

 drivers/pci/Kconfig           |  9 ++++
 drivers/pci/Makefile          |  1 +
 drivers/pci/cxl.c             | 89 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  7 +++
 drivers/pci/probe.c           |  1 +
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  5 ++
 7 files changed, 113 insertions(+)
 create mode 100644 drivers/pci/cxl.c

--
2.26.2


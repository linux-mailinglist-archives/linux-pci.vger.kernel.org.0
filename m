Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AD473364
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbhLMR7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 12:59:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:56114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241455AbhLMR7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 12:59:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225648983"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="225648983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 09:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505000139"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 09:59:24 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.243.203])
        by linux.intel.com (Postfix) with ESMTP id 93861580A85;
        Mon, 13 Dec 2021 09:59:24 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V3 0/6] Auxiliary bus driver support for Intel PCIe VSEC/DVSEC
Date:   Mon, 13 Dec 2021 09:59:15 -0800
Message-Id: <20211213175921.1897860-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series makes changes to the current intel_pmt driver to give it
broader support for Intel defined PCIe VSEC and DVSEC features. It
moves the implementation from MFD to the auxiliary bus and creates a
generic framework for enumerating the extended capabilities. It also
adds support for a new VSEC, Software Defined Silicon (SDSi).

David E. Box (6):
  PCI: Add #defines for accessing PCIe DVSEC fields
  driver core: auxiliary bus: Add driver data helpers
  platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus
  platform/x86: Add Intel Software Defined Silicon driver
  tools arch x86: Add Intel SDSi provisiong tool
  selftests: sdsi: test sysfs setup

 .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
 MAINTAINERS                                   |  19 +-
 drivers/mfd/Kconfig                           |  10 -
 drivers/mfd/Makefile                          |   1 -
 drivers/mfd/intel_pmt.c                       | 261 --------
 drivers/platform/x86/intel/Kconfig            |  23 +
 drivers/platform/x86/intel/Makefile           |   4 +
 drivers/platform/x86/intel/pmt/Kconfig        |   4 +-
 drivers/platform/x86/intel/pmt/class.c        |  21 +-
 drivers/platform/x86/intel/pmt/class.h        |   5 +-
 drivers/platform/x86/intel/pmt/crashlog.c     |  47 +-
 drivers/platform/x86/intel/pmt/telemetry.c    |  46 +-
 drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
 drivers/platform/x86/intel/vsec.c             | 422 +++++++++++++
 drivers/platform/x86/intel/vsec.h             |  43 ++
 include/linux/auxiliary_bus.h                 |  10 +
 include/uapi/linux/pci_regs.h                 |   4 +
 tools/arch/x86/intel_sdsi/Makefile            |   9 +
 tools/arch/x86/intel_sdsi/sdsi.c              | 540 +++++++++++++++++
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 +
 .../selftests/drivers/sdsi/sdsi_test.py       | 226 +++++++
 21 files changed, 2026 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 delete mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 drivers/platform/x86/intel/vsec.c
 create mode 100644 drivers/platform/x86/intel/vsec.h
 create mode 100644 tools/arch/x86/intel_sdsi/Makefile
 create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907C246CA48
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 02:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhLHByK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 20:54:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:52890 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243247AbhLHByH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Dec 2021 20:54:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="224992835"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224992835"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 17:50:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="515966485"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 17:50:17 -0800
Received: from debox1-desk4.hsd1.or.comcast.net (unknown [10.251.18.198])
        by linux.intel.com (Postfix) with ESMTP id BA2685805EC;
        Tue,  7 Dec 2021 17:50:15 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH RESEND V2 0/6] Auxiliary bus driver support for Intel PCIe VSEC/DVSEC
Date:   Tue,  7 Dec 2021 17:50:09 -0800
Message-Id: <20211208015015.891275-1-david.e.box@linux.intel.com>
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

Version 2 adds two new patches, sample code and testing.

Resend due to missing 'PATCH' in Subject of previous series.

David E. Box (6):
  PCI: Add #defines for accessing PCIe DVSEC fields
  driver core: auxiliary bus: Add driver data helpers
  platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus
  platform/x86: Add Intel Software Defined Silicon driver
  sample/sdsi: Sample of SDSi provisiong using sysfs
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
 drivers/platform/x86/intel/vsec.c             | 418 +++++++++++++
 drivers/platform/x86/intel/vsec.h             |  43 ++
 include/linux/auxiliary_bus.h                 |  10 +
 include/uapi/linux/pci_regs.h                 |   4 +
 samples/sdsi/Makefile                         |   9 +
 samples/sdsi/sdsi-sample.c                    | 399 ++++++++++++
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 +
 .../selftests/drivers/sdsi/sdsi_test.py       | 166 +++++
 21 files changed, 1821 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 delete mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 drivers/platform/x86/intel/vsec.c
 create mode 100644 drivers/platform/x86/intel/vsec.h
 create mode 100644 samples/sdsi/Makefile
 create mode 100644 samples/sdsi/sdsi-sample.c
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEE4580E3
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 00:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbhKTXUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 18:20:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:31731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237081AbhKTXUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Nov 2021 18:20:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="234851529"
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="234851529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 15:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="648141051"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2021 15:17:06 -0800
Received: from debox1-desk4.intel.com (dseghete-mobl.amr.corp.intel.com [10.209.30.58])
        by linux.intel.com (Postfix) with ESMTP id B628F580BF8;
        Sat, 20 Nov 2021 15:17:05 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/4] Auxiliary bus driver support for Intel PCIe VSEC/DVSEC
Date:   Sat, 20 Nov 2021 15:17:01 -0800
Message-Id: <20211120231705.189969-1-david.e.box@linux.intel.com>
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

David E. Box (4):
  PCI: Add #defines for accessing PCIe DVSEC fields
  driver core: auxiliary bus: Add driver data helpers
  platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus
  platform/x86: Add Intel Software Defined Silicon driver

 .../ABI/testing/sysfs-driver-intel_sdsi       |  75 +++
 MAINTAINERS                                   |  17 +-
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
 17 files changed, 1225 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 delete mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 drivers/platform/x86/intel/vsec.c
 create mode 100644 drivers/platform/x86/intel/vsec.h

-- 
2.25.1


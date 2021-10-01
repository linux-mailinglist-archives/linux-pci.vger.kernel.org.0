Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A541E5B8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 03:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351158AbhJAB37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 21:29:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:56854 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhJAB37 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 21:29:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="286348495"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="286348495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 18:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="521417044"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2021 18:28:15 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id CB5965808E0;
        Thu, 30 Sep 2021 18:28:15 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/5] Move intel_pm from MFD to Auxiliary bus
Date:   Thu, 30 Sep 2021 18:28:10 -0700
Message-Id: <20211001012815.1999501-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series converts the intel_pmt driver from an MFD driver to an
auxiliary bus driver. The series also combines and supersedes two previous
patch sets [1] and [2]. Though starting from V1, revision history from each
series is summarized for each patch.

David E. Box (5):
  PCI: Add #defines for accessing PCIe DVSEC fields
  platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus
  platform/x86/intel: extended_caps: Add support for PCIe VSEC
    structures
  Documentation: Update ioctl-number.rst for Intel Software Defined
    Silicon interface
  platform/x86: Add Intel Software Defined Silicon driver

 .../ABI/testing/sysfs-driver-intel_sdsi       |  28 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  16 +-
 drivers/mfd/Kconfig                           |  10 -
 drivers/mfd/Makefile                          |   1 -
 drivers/mfd/intel_pmt.c                       | 261 -------
 drivers/platform/x86/intel/Kconfig            |  23 +
 drivers/platform/x86/intel/Makefile           |   4 +
 drivers/platform/x86/intel/extended_caps.c    | 401 ++++++++++
 drivers/platform/x86/intel/extended_caps.h    |  42 ++
 drivers/platform/x86/intel/pmt/Kconfig        |   4 +-
 drivers/platform/x86/intel/pmt/class.c        |  18 +-
 drivers/platform/x86/intel/pmt/class.h        |   5 +-
 drivers/platform/x86/intel/pmt/crashlog.c     |  43 +-
 drivers/platform/x86/intel/pmt/telemetry.c    |  47 +-
 drivers/platform/x86/intel/sdsi.c             | 692 ++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |   4 +
 include/uapi/linux/sdsi_if.h                  |  47 ++
 18 files changed, 1318 insertions(+), 329 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 delete mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel/extended_caps.c
 create mode 100644 drivers/platform/x86/intel/extended_caps.h
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 include/uapi/linux/sdsi_if.h

-- 
2.25.1


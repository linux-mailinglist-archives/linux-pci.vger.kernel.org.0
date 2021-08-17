Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E919C3EF5DE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 00:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhHQWnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 18:43:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:58065 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236220AbhHQWnX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 18:43:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="216209991"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="216209991"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="462555358"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2021 15:42:46 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 5CD455808DB;
        Tue, 17 Aug 2021 15:42:46 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/5] MFD: intel_pmt: Add general DVSEC/VSEC support
Date:   Tue, 17 Aug 2021 15:40:13 -0700
Message-Id: <20210817224018.1013192-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch enables general support for Intel defined PCIe VSEC and DVSEC
capabilities in the Intel Platform Monitoring Technology (PMT) driver.
Though the driver was written exclusively for PMT capabilities, newer DVSEC
and VSEC IDs for other capabilities can exist on the same device requiring
that the driver handle them.

This 2nd revision drops the creation of a separate OOBMSM driver. Instead,
all cell drivers will have a dependency on CONFIG_MFD_INTEL_PMT, whether or
not they are PMT. Changes in this patchset to the current cell drivers
located in platform/x86 are based on Hans for-next branch where they have
been moved to the intel/pmt subfolder.

David E. Box (5):
  PCI: Add #defines for accessing PCIE DVSEC fields
  MFD: intel_pmt: Support non-PMT capabilities
  MFD: intel_pmt: Add support for PCIe VSEC structures
  platform/x86: intel_pmt_telemetry: Ignore zero sized entries
  MFD: intel_pmt: Add DG2 support

 drivers/mfd/intel_pmt.c                    | 256 +++++++++++++++------
 drivers/platform/x86/intel/pmt/class.c     |   2 +
 drivers/platform/x86/intel/pmt/crashlog.c  |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c |  10 +-
 include/uapi/linux/pci_regs.h              |   4 +
 5 files changed, 197 insertions(+), 77 deletions(-)


base-commit: ca42c119fc6746e65423257e7eddf5fc9e96edc2
-- 
2.25.1


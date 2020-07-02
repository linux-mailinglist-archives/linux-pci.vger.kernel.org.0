Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B51212ADA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGBRJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:38697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgGBRJB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:01 -0400
IronPort-SDR: JiIodZ9+PZ7x9p+3DprbN3m4cIH9NA+xr3mh0BWP0vSg7LcNAvGkVUfoxEM7QPAFmSnxOLi2zq
 sUudJJ4aN9+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587451"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:08:55 -0700
IronPort-SDR: CzVd/meu4IuQuwDBFokF2ceUZ0Ui0Yp+W2oDGmlqxIr7ZYbWJNuUZOaXEbz0kmIV9LGqyZ1Kbn
 1zgv8RWANSoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763168"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:08:54 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/7] Support PCIe3 uncore PMU on Snow Ridge
Date:   Thu,  2 Jul 2020 10:05:10 -0700
Message-Id: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Snow Ridge integrated PCIe3 uncore performance monitoring unit (PMU)
can be used to collect the performance data, e.g., the utilization
between the PCIe devices and the components (in M2IOSF) which are
responsible for translating and managing the requests to/from the
device. The performance data is very useful for analyzing the
performance of the PCIe devices.

The PCIe3 uncore PMU was once supported in the Linux kernel, but it was
removed by the commit id 2167f1625c2f ("perf/x86/intel/uncore: Remove
PCIe3 unit for SNR") due to the conflict between the PCIe Root Port
driver and the perf uncore driver. The counters of the PCIe3 uncore PMU
are located in the configuration space of the PCIe Root Port device,
which already has a bonded driver portdrv_pci. One device can only have
one bonded driver. The uncore driver is always failed to be loaded.

To re-enable the PCIe3 uncore PMU support in the uncore driver, a new
solution should be introduced, which has to meet the requirements as
below:
- must have a reliable way to find the PCIe Root Port device from the
  uncore driver;
- must be able to access the uncore counters of the PCIe Root Port
  device from the uncore driver;
- must support hotplug. When the PCIe Root Port device is removed, the
  uncore driver has to be notified and unregisters the PCIe3 uncore
  PMU.

A new platform device 'perf_uncore_pcieport' as a child device of the
PCIe Root Port device is introduced to address the issue, which:
- can be probed by a unique name, 'perf_uncore_pcieport'. The uncore
  driver is the only driver for the new platform device.
- can provide the struct pci_dev of its parent, aka the PCIe Root Port
  device. The struct pci_dev can be used by the uncore driver to
  register a PMU for accessing the counters in the PCIe Root Port
  device.
- can be notified if its parent PCIe Root Port device is removed.
  The uncore driver can unregister the PMU accordingly.

Kan Liang (7):
  PCI/portdrv: Create a platform device for the perf uncore driver
  perf/x86/intel/uncore: Factor out uncore_pci_get_die_info()
  perf/x86/intel/uncore: Factor out uncore_find_pmu_by_pci_dev()
  perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
  perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
  perf/x86/intel/uncore: Generic support for the platform device
  perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge

 arch/x86/events/intel/uncore.c       | 213 +++++++++++++++++++++++++----------
 arch/x86/events/intel/uncore.h       |  19 ++++
 arch/x86/events/intel/uncore_snbep.c |  60 ++++++++++
 drivers/pci/pcie/portdrv_pci.c       |  38 +++++++
 4 files changed, 271 insertions(+), 59 deletions(-)

-- 
2.7.4


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE3427E1FB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgI3HHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 03:07:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:34468 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3HH3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 03:07:29 -0400
IronPort-SDR: DXbEjkgqGgvUwkOsh1amVnGvMILGPYcVdZ19OpT0O5r3goSER34THJIzfgKy+lV6rtEUWDkOQt
 Too7EWyy7oHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226533012"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="226533012"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:07:26 -0700
IronPort-SDR: TFQeep3QT+fbAISxcAj64F7pyegxewJ9qRkC8X5x4sLtsoMAZYdxL0YBvjZF4WJQa3qoS1O+/+
 STpPvPc7o1fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="496013036"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2020 00:07:23 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v6 0/5] Fix DPC hotplug race and enhance error handling
Date:   Wed, 30 Sep 2020 03:05:32 -0400
Message-Id: <20200930070537.30982-1-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,folks,

This simple patch set fixed some serious security issues found when DPC
error injection and NVMe SSD hotplug brute force test were doing -- race
condition between DPC handler and pciehp, AER interrupt handlers, caused
system hang and system with DPC feature couldn't recover to normal
working state as expected (NVMe instance lost, mount operation hang,
race PCIe access caused uncorrectable errors reported alternatively etc).

With this patch set applied, stable 5.9-rc6 on ICS (Ice Lake SP platform,
see
https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))

could pass the PCIe Gen4 NVMe SSD brute force hotplug test with any time
interval between hot-remove and plug-in operation tens of times without
any errors occur and system works normal.

With this patch set applied, system with DPC feature could recover from
NON-FATAL and FATAL errors injection test and works as expected.

System works smoothly when errors happen while hotplug is doing, no
uncorrectable errors found.

Brute DPC error injection script:

for i in {0..100}
do
        setpci -s 64:02.0 0x196.w=000a
        setpci -s 65:00.0 0x04.w=0544
        mount /dev/nvme0n1p1 /root/nvme
        sleep 1
done

Other details see every commits description part.

This patch set could be applied to stable 5.9-rc6/rc7 directly.

Help to review and test.

v2: changed according to review by Andy Shevchenko.
v3: changed patch 4/5 to simpler coding.
v4: move function pci_wait_port_outdpc() to DPC driver and its
   declaration to pci.h. (tip from Christoph Hellwig <hch@infradead.org>).
v5: fix building issue reported by lkp@intel.com with some config.
v6: move patch[3/5] as the first patch according to Lukas's suggestion.
    and rewrite the comment part of patch[3/5].
    
Ethan Zhao (5):
  PCI/ERR: get device before call device driver to avoid NULL pointer
    dereference
  PCI/DPC: define a function to check and wait till port finish DPC
    handling
  PCI: pciehp: check and wait port status out of DPC before handling
    DLLSC and PDC
  PCI: only return true when dev io state is really changed
  PCI/ERR: don't mix io state not changed and no driver together

 drivers/pci/hotplug/pciehp_hpc.c |  4 +++-
 drivers/pci/pci.h                | 39 ++++++--------------------------
 drivers/pci/pcie/dpc.c           | 27 ++++++++++++++++++++++
 drivers/pci/pcie/err.c           | 18 +++++++++++++--
 4 files changed, 53 insertions(+), 35 deletions(-)


base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
-- 
2.18.4


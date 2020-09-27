Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07F4279E67
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 07:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgI0FaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 01:30:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:23634 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0FaS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 01:30:18 -0400
IronPort-SDR: HnnCRNj9qAllc+CzZ3KOVlDfFKtYDYEk4b92uzqS+8CgYhWQfgxPHiHaL0nKJfXtjxIKtBWpcQ
 WSHeZ9Ujh9zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="225993129"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="225993129"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 22:30:15 -0700
IronPort-SDR: OoVEK/uMjplKf0pD7VtT6xnlAYkCMFVXCHQj4qS6jp5Ev2u3cUAIoZftIz6YeOdsOwF3MPu6i5
 zY+tbC0Bg0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="323909277"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2020 22:30:11 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 0/5 V3] Fix DPC hotplug race and enhance error handling
Date:   Sun, 27 Sep 2020 01:28:36 -0400
Message-Id: <20200927052841.12629-1-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

This patch set could be applied to stable 5.9-rc6 directly.

Help to review and test.

V2: changed according to review by Andy Shevchenko.
V3: changed patch 4/5 to simpler coding.

Thanks,
Ethan


Ethan Zhao (5):
  PCI: define a function to check and wait till port finish DPC handling
  PCI: pciehp: check and wait port status out of DPC before handling
    DLLSC and PDC
  PCI/ERR: get device before call device driver to avoid NULL pointer
    reference
  PCI: only return true when dev io state is really changed
  PCI/ERR: don't mix io state not changed and no driver together

 drivers/pci/hotplug/pciehp_hpc.c |  4 +++-
 drivers/pci/pci.h                | 34 +++++---------------------------
 drivers/pci/pcie/err.c           | 18 +++++++++++++++--
 include/linux/pci.h              | 31 +++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 32 deletions(-)

-- 
2.18.4


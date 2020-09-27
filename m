Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB7279DB7
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 05:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgI0DaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 23:30:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:65381 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0DaD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Sep 2020 23:30:03 -0400
IronPort-SDR: vIW2bpVRdPzzqU8w5m86e0KorsX/8rIMh53lrD3yGZaUsCDQO6b2yxw5cYvkSsvZihbyCPdxF0
 NKTe//tz4PrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="141242654"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="141242654"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 20:30:01 -0700
IronPort-SDR: UJQ1DRrW6W1kOmgpEwtYKfzfnc7rROn/qt2K99QA9TQRYbieQH6Hyv68nrUvbG/W8lQCdBdFqc
 W+EoGXIp0dAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="337697443"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2020 20:29:57 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 0/5 V2] Fix DPC hotplug race and enhance error handling
Date:   Sat, 26 Sep 2020 23:28:24 -0400
Message-Id: <20200927032829.11321-1-haifeng.zhao@intel.com>
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C364F277DFE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 04:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgIYCfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 22:35:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:60412 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgIYCfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 22:35:47 -0400
IronPort-SDR: PZtvdKBMOSoKsi3bx1U0g9OKxucrqvllCfwM4GyQkpWADjeXx9cwf0B8KlAX2Fm6aTdBVmDxhT
 bwWAJrsFJIAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141431825"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="141431825"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 19:35:47 -0700
IronPort-SDR: uvRW4c1Gjpz9Zdmem0wOJ/y9+cc3plXzDC0G6l7t7EWENM1kpCx/s4SO6ex32H7qchpmhY6hVA
 G6Zp5jdlL0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="512515273"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2020 19:35:44 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 0/5] Fix DPC hotplug race and enhance error hanlding
Date:   Thu, 24 Sep 2020 22:34:18 -0400
Message-Id: <20200925023423.42675-1-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This simple patch set fixed some serious security issues found when DPC
error injection and NVMe SSD hotplug brute force test were doing -- race
condition between DPC handler and pciehp, AER interrupt handlers, caused
system hang and system with DPC feature couldn't recover to normal
working state as expected (NVMe instance lost, mount operation hang,
race PCIe access caused uncorrectable errors reported alternativly etc). 

With this patch set applied, stable 5.9-rc6 could pass the PCIe Gen4 NVMe
SSD brute force hotplug test with any time interval between hot-remove and
plug-in operation tens of times without any errors occur and system works
normal.

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

Thanks,
Ethan


Ethan Zhao (5):
  PCI: define a function to check and wait till port finish DPC handling
  PCI: pciehp: check and wait port status out of DPC before handling
    DLLSC and PDC
  PCI/ERR: get device before call device driver to avoid null pointer
    reference
  PCI: only return true when dev io state is really changed
  PCI/ERR: don't mix io state not changed and no driver together

 drivers/pci/hotplug/pciehp_hpc.c |  4 +++-
 drivers/pci/pci.h                | 31 +++----------------------------
 drivers/pci/pcie/err.c           | 18 ++++++++++++++++--
 include/linux/pci.h              | 31 +++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 31 deletions(-)

-- 
2.18.4


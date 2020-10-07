Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD77285E2E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgJGLdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:33:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:24765 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGLdb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 07:33:31 -0400
IronPort-SDR: 2uGq1vyDYod8468Ir1BCGFPnOMs7AIbtlicnT8ofPFSnx5yFp6yDBxvgAoyLaXHYtrPBXcLczp
 Pg2vA/ztmGjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226492529"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="226492529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:33:29 -0700
IronPort-SDR: lRnRKhudSEUyaGcD9Hhhrwe7ic1WEvkeZ/TS293akbgdAZYnzI1S6uc5G1dN9h2TBmjo2VS+DM
 H/sEfhJuvN4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354862114"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 04:33:25 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v8 0/6] Fix DPC hotplug race and enhance error handling
Date:   Wed,  7 Oct 2020 07:31:52 -0400
Message-Id: <20201007113158.48933-1-haifeng.zhao@intel.com>
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

The fundamental premise is that when due to error conditions (NON-FATAL/
FATAL) when events are processed by both DPC handler and hotplug handling
of DLLSC/PDC both operating on the same device object ends up with crashes 
(from  Ashok).

Debug shows when port DPC feature was enabled and triggered by errors,
DLLSC/PDC/DPC interrupts will be sent to pciehp and DPC driver almost
at the same time, and no delay between them is required by specification.
so DPC driver and pciehp drivers may handle these interrupts cocurrently,
thus introduces the possibility of race condition, other details see every
commit description part.

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

This patch set could be applied to stable 5.9-rc6/rc7/rc8 directly.

Help to review and test.

v2: changed according to review by Andy Shevchenko.
v3: changed patch 4/5 to simpler coding.
v4: move function pci_wait_port_outdpc() to DPC driver and its
   declaration to pci.h. (tip from Christoph Hellwig <hch@infradead.org>).
v5: fix building issue reported by lkp@intel.com with some config.
v6: move patch[3/5] as the first patch according to Lukas's suggestion.
    and rewrite the comment part of patch[3/5].
v7: change the patch[4/5], based on Bjorn's code and truth table.
    change the patch[5/5] about the debug output information.
v8: according Bjorn's suggestion, put the pci_dev_set_io_state()
    simplification but no function code in one patch.(almost copy of
    Bjorn's code and truth table, understood).
    patch 5/6 re-based the function change code of pci_dev_set_io_state().
    per Ashok's request, add more description to this cover-letter part.


Thanks,
Ethan


Ethan Zhao (6):
  PCI/ERR: get device before call device driver to avoid NULL pointer
    dereference
  PCI/DPC: define a function to check and wait till port finish DPC
    handling
  PCI: pciehp: check and wait port status out of DPC before handling
    DLLSC and PDC
  PCI/ERR: simplify function pci_dev_set_io_state() with if
  PCI/ERR: only return true when dev io state is really changed
  PCI/ERR: don't mix io state not changed and no driver together

 drivers/pci/hotplug/pciehp_hpc.c |  4 ++-
 drivers/pci/pci.h                | 55 +++++++++++++-------------------
 drivers/pci/pcie/dpc.c           | 27 ++++++++++++++++
 drivers/pci/pcie/err.c           | 18 +++++++++--
 4 files changed, 69 insertions(+), 35 deletions(-)


base-commit: 549738f15da0e5a00275977623be199fbbf7df50
-- 
2.18.4


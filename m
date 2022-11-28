Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BB63A6DB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 12:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiK1LN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 06:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiK1LNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 06:13:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E14DA7
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 03:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669634029; x=1701170029;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tw3FhiLKuauznMZnHElqDya1ByLTSzIrLTlVuBJ952Y=;
  b=d3fL1vcrV3jz8ndPfEkC/RC3ZvKnxD1tMzR1tSvHIVIiamz32EhwU23f
   9b8Zn4ViwrksW+uDy2ZYsCvdVpGU2CLbujj3t1hPcY1nIzZyL4WPQ1sRu
   63Vk8yu1HHdtkjOX2Sg9n94a0niH1k5cjc4zpoes+TX/99FIUMDEFAdsH
   EEDQYeRZf8k0YuEn4KoV1Jjm9r7XetZMAmh11Mz16WKSjmpgNVlL8Tq1H
   CdcBZ1rkA/l4f2z4dcR5Z5SE98avxURzhldvbRrwM2nyH6y0AAQr2XbmA
   k8/L0Nz5Duutoow130PTovl9zgIptOCpRppvWXF5vwbfmWXQ1xewjw7q1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="379063538"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379063538"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 03:13:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="643352975"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643352975"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 03:13:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B644E184; Mon, 28 Nov 2022 13:14:14 +0200 (EET)
Date:   Mon, 28 Nov 2022 13:14:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: PCI resource allocation mismatch with BIOS
Message-ID: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

There is another PCI resource allocation issue with some Intel GPUs but
probably applies to other similar devices as well. This is something
encountered in data centers where they trigger reset (secondary bus
reset) to the GPUs if there is hang or similar detected. Basically they
do something like:

  1. Unbind the graphics driver(s) through sysfs.
  2. Remove the PCIe devices under the root port or the PCIe switch
     upstream port through sysfs (echo 1 > ../remove).
  3. Trigger reset through config space or use the sysfs reset attribute.
  4. Run rescan on the root bus (echo 1 > /sys/bus/pci/rescan) 

Expectation is to see the devices come back in the same way prior the
reset but what actually happens is that the Linux PCI resource
allocation fails to allocate space for some of the resources. In this
case it is the IOV BARs.

BIOS allocates resources for all these at boot time but after the rescan
Linux tries to re-allocate them but since the allocation algorithm is
more "consuming" some of the BARs do not fit to the available resource
space.

Here is an example. The devices involved are:

53:00.0		GPU with IOV BARs
52:01.0		PCIe switch downstream port

PF = Physical Function
VF = Virtual Function

BIOS allocation (dmesg)
-----------------------
pci 0000:52:01.0: scanning [bus 53-54] behind bridge, pass 0
pci 0000:53:00.0: [8086:56c0] type 00 class 0x038000
pci 0000:53:00.0: reg 0x10: [mem 0x205e1f000000-0x205e1fffffff 64bit pref]
pci 0000:53:00.0: reg 0x18: [mem 0x201c00000000-0x201fffffffff 64bit pref]
pci 0000:53:00.0: reg 0x30: [mem 0xffe00000-0xffffffff pref]
pci 0000:53:00.0: reg 0x344: [mem 0x205e00000000-0x205e00ffffff 64bit pref]
pci 0000:53:00.0: VF(n) BAR0 space: [mem 0x205e00000000-0x205e1effffff 64bit pref] (contains BAR0 for 31 VFs)
pci 0000:53:00.0: reg 0x34c: [mem 0x202000000000-0x2021ffffffff 64bit pref]
pci 0000:53:00.0: VF(n) BAR2 space: [mem 0x202000000000-0x205dffffffff 64bit pref] (contains BAR2 for 31 VFs)
pci 0000:52:01.0: PCI bridge to [bus 53-54]
pci 0000:52:01.0:   bridge window [mem 0x201c00000000-0x205e1fffffff 64bit pref]

GPU
~~~
0x201c00000000-0x201fffffffff	PF BAR2 16384M
0x202000000000-0x205dffffffff	VF BAR2	253952M (31 * 8G)
0x205e00000000-0x205e1effffff	VF BAR0 496M (31 * 16M)
0x205e1f000000-0x205e1fffffff 	PF BAR0 16M
					270848M

PCIe downstream port
~~~~~~~~~~~~~~~~~~~~
0x201c00000000-0x205e1fffffff		270848M

Linux allocation (dmesg)
------------------------
pci 0000:52:01.0: [8086:4fa4] type 01 class 0x060400
pci_bus 0000:52: fixups for bus
pci 0000:51:00.0: PCI bridge to [bus 52-54]
pci 0000:51:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:51:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:51:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:52:01.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:52:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:52:01.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:53: scanning bus
pci 0000:53:00.0: [8086:56c0] type 00 class 0x038000
pci 0000:53:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit pref]
pci 0000:53:00.0: reg 0x18: [mem 0x00000000-0x3ffffffff 64bit pref]
pci 0000:53:00.0: reg 0x30: [mem 0x00000000-0x001fffff pref]
pci 0000:53:00.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit pref]
pci 0000:53:00.0: VF(n) BAR0 space: [mem 0x00000000-0x1effffff 64bit pref] (contains BAR0 for 31 VFs)
pci 0000:53:00.0: reg 0x34c: [mem 0x00000000-0x1ffffffff 64bit pref]
pci 0000:53:00.0: VF(n) BAR2 space: [mem 0x00000000-0x3dffffffff 64bit pref] (contains BAR2 for 31 VFs)
pci_bus 0000:53: fixups for bus
pci 0000:52:01.0: PCI bridge to [bus 53-54]
pci 0000:52:01.0:   bridge window [io  0x0000-0x0fff]
pci 0000:52:01.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:52:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:52:01.0: bridge window [mem 0x200000000-0x7ffffffff 64bit pref] to [bus 53] add_size 3e00000000 add_align 200000000
pci 0000:51:00.0: bridge window [mem 0x200000000-0x7ffffffff 64bit pref] to [bus 52-53] add_size 3e00000000 add_align 200000000
pcieport 0000:50:02.0: BAR 13: assigned [io  0x8000-0x8fff]
pci 0000:51:00.0: BAR 15: no space for [mem size 0x4400000000 64bit pref]
pci 0000:51:00.0: BAR 15: failed to assign [mem size 0x4400000000 64bit pref]
pci 0000:51:00.0: BAR 0: assigned [mem 0x201c00000000-0x201c007fffff 64bit pref]
pci 0000:51:00.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
pci 0000:51:00.0: BAR 13: assigned [io  0x8000-0x8fff]
pci 0000:51:00.0: BAR 15: assigned [mem 0x201c00000000-0x2021ffffffff 64bit pref]
pci 0000:51:00.0: BAR 0: assigned [mem 0x202200000000-0x2022007fffff 64bit pref]
pci 0000:51:00.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
pci 0000:51:00.0: BAR 15: [mem 0x201c00000000-0x2021ffffffff 64bit pref] (failed to expand by 0x3e00000000)
pci 0000:51:00.0: failed to add 3e00000000 res[15]=[mem 0x201c00000000-0x2021ffffffff 64bit pref]
pci 0000:52:01.0: BAR 15: no space for [mem size 0x4400000000 64bit pref]
pci 0000:52:01.0: BAR 15: failed to assign [mem size 0x4400000000 64bit pref]
pci 0000:52:01.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
pci 0000:52:01.0: BAR 13: assigned [io  0x8000-0x8fff]
pci 0000:52:01.0: BAR 15: assigned [mem 0x201c00000000-0x2021ffffffff 64bit pref]
pci 0000:52:01.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
pci 0000:52:01.0: BAR 15: [mem 0x201c00000000-0x2021ffffffff 64bit pref] (failed to expand by 0x3e00000000)
pci 0000:52:01.0: failed to add 3e00000000 res[15]=[mem 0x201c00000000-0x2021ffffffff 64bit pref]
pci 0000:53:00.0: BAR 2: assigned [mem 0x201c00000000-0x201fffffffff 64bit pref]
pci 0000:53:00.0: BAR 9: no space for [mem size 0x3e00000000 64bit pref]
pci 0000:53:00.0: BAR 9: failed to assign [mem size 0x3e00000000 64bit pref]
pci 0000:53:00.0: BAR 0: assigned [mem 0x202000000000-0x202000ffffff 64bit pref]
pci 0000:53:00.0: BAR 7: assigned [mem 0x202001000000-0x20201fffffff 64bit pref]
pci 0000:53:00.0: BAR 6: assigned [mem 0xbb800000-0xbb9fffff pref]
pci 0000:53:00.0: BAR 2: assigned [mem 0x201c00000000-0x201fffffffff 64bit pref]
pci 0000:53:00.0: BAR 0: assigned [mem 0x202000000000-0x202000ffffff 64bit pref]
pci 0000:53:00.0: BAR 6: assigned [mem 0xbb800000-0xbb9fffff pref]
pci 0000:53:00.0: BAR 9: no space for [mem size 0x3e00000000 64bit pref]
pci 0000:53:00.0: BAR 9: failed to assign [mem size 0x3e00000000 64bit pref]
pci 0000:53:00.0: BAR 7: assigned [mem 0x202001000000-0x20201fffffff 64bit pref]
pci 0000:52:01.0: PCI bridge to [bus 53]
pci 0000:52:01.0:   bridge window [io  0x8000-0x8fff]
pci 0000:52:01.0:   bridge window [mem 0xbb800000-0xbb9fffff]
pci 0000:52:01.0:   bridge window [mem 0x201c00000000-0x2021ffffffff 64bit pref]

GPU
~~~
0x201c00000000-0x201fffffffff	PF BAR2 16834M
0x202000000000-0x202000ffffff	PF BAR0	16M
0x202001000000-0x20201fffffff 	VF BAR0	496M (31 * 16M)
FAIL				VF BAR2 253952M (31 * 8G)

PCIe downstream port
~~~~~~~~~~~~~~~~~~~~
0x201c00000000-0x2021ffffffff		24576M

Now, if I hack the allocation algorithm (in pbus_size_mem()) to "mimic"
the BIOS allocation then these fit fine. However, if the BIOS allocation
ever changes we may end up in similar issue. Also the Linux PCI resource
allocation code has been like that for aeons so changing it would likely
cause regressions.

Let me know if more information is needed. I have one of these cards
locally and have remote access to a similar system where the above
example was take so I can run additional testing.

Also let me know if you want me to file a bug in kernel.org bugzilla.

Thanks in advance!

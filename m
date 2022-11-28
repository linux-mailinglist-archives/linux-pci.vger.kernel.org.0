Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6963B374
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 21:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiK1Ujh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 15:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiK1Ujg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 15:39:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6582BB5E
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 12:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0279761425
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 20:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38302C433D7;
        Mon, 28 Nov 2022 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669667974;
        bh=S872SNclyqAEsepDsV4nGIWJkWi1gVXAmspzDiMUJL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qNX65prcLEnoGDkrxUiRqiMOIcpeg0BAycsZFrcEAROZnDl7m4LyO087WTgaI8jJH
         b5Gsmx2PdiVnL3Rq3N2+dO0YhEBw+XEi/PzV23UlzKikfEInfjiDW6L0gJ6GJdKgUw
         t6utNON7ar6yAnNwp/9fJBAnnK0mQCknATtFgoKdbw1rwiaMHNmt6w4ce7hY6Ppaqc
         +OKGDKXFlVN2J05ta99Ba3XpSTkxXZtX8SmBeAcxidAgltG+C2DxaV3Nzg5MkP7qyt
         GYZkzhbVTwnTOG4guc8HYnQTvXXAPNW8mm3d8CirnUtOhls5V/272P2/A1rcS3SEdg
         LFrWGgnHt4jqg==
Date:   Mon, 28 Nov 2022 14:39:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221128203932.GA644781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

Hi Mika,

On Mon, Nov 28, 2022 at 01:14:14PM +0200, Mika Westerberg wrote:
> Hi Bjorn,
> 
> There is another PCI resource allocation issue with some Intel GPUs but
> probably applies to other similar devices as well. This is something
> encountered in data centers where they trigger reset (secondary bus
> reset) to the GPUs if there is hang or similar detected. Basically they
> do something like:
> 
>   1. Unbind the graphics driver(s) through sysfs.
>   2. Remove the PCIe devices under the root port or the PCIe switch
>      upstream port through sysfs (echo 1 > ../remove).
>   3. Trigger reset through config space or use the sysfs reset attribute.
>   4. Run rescan on the root bus (echo 1 > /sys/bus/pci/rescan) 
> 
> Expectation is to see the devices come back in the same way prior the
> reset but what actually happens is that the Linux PCI resource
> allocation fails to allocate space for some of the resources. In this
> case it is the IOV BARs.
> 
> BIOS allocates resources for all these at boot time but after the rescan
> Linux tries to re-allocate them but since the allocation algorithm is
> more "consuming" some of the BARs do not fit to the available resource
> space.

Thanks for the report!  Definitely sounds like an issue.  I doubt that
I'll have time to work on it myself in the near future.

Is the "remove" before the reset actually necessary?  If we could
avoid the removal, maybe the config space save/restore we already do
around reset would avoid the issue?

Bjorn

> Here is an example. The devices involved are:
> 
> 53:00.0		GPU with IOV BARs
> 52:01.0		PCIe switch downstream port
> 
> PF = Physical Function
> VF = Virtual Function
> 
> BIOS allocation (dmesg)
> -----------------------
> pci 0000:52:01.0: scanning [bus 53-54] behind bridge, pass 0
> pci 0000:53:00.0: [8086:56c0] type 00 class 0x038000
> pci 0000:53:00.0: reg 0x10: [mem 0x205e1f000000-0x205e1fffffff 64bit pref]
> pci 0000:53:00.0: reg 0x18: [mem 0x201c00000000-0x201fffffffff 64bit pref]
> pci 0000:53:00.0: reg 0x30: [mem 0xffe00000-0xffffffff pref]
> pci 0000:53:00.0: reg 0x344: [mem 0x205e00000000-0x205e00ffffff 64bit pref]
> pci 0000:53:00.0: VF(n) BAR0 space: [mem 0x205e00000000-0x205e1effffff 64bit pref] (contains BAR0 for 31 VFs)
> pci 0000:53:00.0: reg 0x34c: [mem 0x202000000000-0x2021ffffffff 64bit pref]
> pci 0000:53:00.0: VF(n) BAR2 space: [mem 0x202000000000-0x205dffffffff 64bit pref] (contains BAR2 for 31 VFs)
> pci 0000:52:01.0: PCI bridge to [bus 53-54]
> pci 0000:52:01.0:   bridge window [mem 0x201c00000000-0x205e1fffffff 64bit pref]
> 
> GPU
> ~~~
> 0x201c00000000-0x201fffffffff	PF BAR2 16384M
> 0x202000000000-0x205dffffffff	VF BAR2	253952M (31 * 8G)
> 0x205e00000000-0x205e1effffff	VF BAR0 496M (31 * 16M)
> 0x205e1f000000-0x205e1fffffff 	PF BAR0 16M
> 					270848M
> 
> PCIe downstream port
> ~~~~~~~~~~~~~~~~~~~~
> 0x201c00000000-0x205e1fffffff		270848M
> 
> Linux allocation (dmesg)
> ------------------------
> pci 0000:52:01.0: [8086:4fa4] type 01 class 0x060400
> pci_bus 0000:52: fixups for bus
> pci 0000:51:00.0: PCI bridge to [bus 52-54]
> pci 0000:51:00.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:51:00.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:51:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0000:52:01.0: scanning [bus 00-00] behind bridge, pass 0
> pci 0000:52:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> pci 0000:52:01.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:53: scanning bus
> pci 0000:53:00.0: [8086:56c0] type 00 class 0x038000
> pci 0000:53:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit pref]
> pci 0000:53:00.0: reg 0x18: [mem 0x00000000-0x3ffffffff 64bit pref]
> pci 0000:53:00.0: reg 0x30: [mem 0x00000000-0x001fffff pref]
> pci 0000:53:00.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit pref]
> pci 0000:53:00.0: VF(n) BAR0 space: [mem 0x00000000-0x1effffff 64bit pref] (contains BAR0 for 31 VFs)
> pci 0000:53:00.0: reg 0x34c: [mem 0x00000000-0x1ffffffff 64bit pref]
> pci 0000:53:00.0: VF(n) BAR2 space: [mem 0x00000000-0x3dffffffff 64bit pref] (contains BAR2 for 31 VFs)
> pci_bus 0000:53: fixups for bus
> pci 0000:52:01.0: PCI bridge to [bus 53-54]
> pci 0000:52:01.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:52:01.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:52:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0000:52:01.0: bridge window [mem 0x200000000-0x7ffffffff 64bit pref] to [bus 53] add_size 3e00000000 add_align 200000000
> pci 0000:51:00.0: bridge window [mem 0x200000000-0x7ffffffff 64bit pref] to [bus 52-53] add_size 3e00000000 add_align 200000000
> pcieport 0000:50:02.0: BAR 13: assigned [io  0x8000-0x8fff]
> pci 0000:51:00.0: BAR 15: no space for [mem size 0x4400000000 64bit pref]
> pci 0000:51:00.0: BAR 15: failed to assign [mem size 0x4400000000 64bit pref]
> pci 0000:51:00.0: BAR 0: assigned [mem 0x201c00000000-0x201c007fffff 64bit pref]
> pci 0000:51:00.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
> pci 0000:51:00.0: BAR 13: assigned [io  0x8000-0x8fff]
> pci 0000:51:00.0: BAR 15: assigned [mem 0x201c00000000-0x2021ffffffff 64bit pref]
> pci 0000:51:00.0: BAR 0: assigned [mem 0x202200000000-0x2022007fffff 64bit pref]
> pci 0000:51:00.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
> pci 0000:51:00.0: BAR 15: [mem 0x201c00000000-0x2021ffffffff 64bit pref] (failed to expand by 0x3e00000000)
> pci 0000:51:00.0: failed to add 3e00000000 res[15]=[mem 0x201c00000000-0x2021ffffffff 64bit pref]
> pci 0000:52:01.0: BAR 15: no space for [mem size 0x4400000000 64bit pref]
> pci 0000:52:01.0: BAR 15: failed to assign [mem size 0x4400000000 64bit pref]
> pci 0000:52:01.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
> pci 0000:52:01.0: BAR 13: assigned [io  0x8000-0x8fff]
> pci 0000:52:01.0: BAR 15: assigned [mem 0x201c00000000-0x2021ffffffff 64bit pref]
> pci 0000:52:01.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
> pci 0000:52:01.0: BAR 15: [mem 0x201c00000000-0x2021ffffffff 64bit pref] (failed to expand by 0x3e00000000)
> pci 0000:52:01.0: failed to add 3e00000000 res[15]=[mem 0x201c00000000-0x2021ffffffff 64bit pref]
> pci 0000:53:00.0: BAR 2: assigned [mem 0x201c00000000-0x201fffffffff 64bit pref]
> pci 0000:53:00.0: BAR 9: no space for [mem size 0x3e00000000 64bit pref]
> pci 0000:53:00.0: BAR 9: failed to assign [mem size 0x3e00000000 64bit pref]
> pci 0000:53:00.0: BAR 0: assigned [mem 0x202000000000-0x202000ffffff 64bit pref]
> pci 0000:53:00.0: BAR 7: assigned [mem 0x202001000000-0x20201fffffff 64bit pref]
> pci 0000:53:00.0: BAR 6: assigned [mem 0xbb800000-0xbb9fffff pref]
> pci 0000:53:00.0: BAR 2: assigned [mem 0x201c00000000-0x201fffffffff 64bit pref]
> pci 0000:53:00.0: BAR 0: assigned [mem 0x202000000000-0x202000ffffff 64bit pref]
> pci 0000:53:00.0: BAR 6: assigned [mem 0xbb800000-0xbb9fffff pref]
> pci 0000:53:00.0: BAR 9: no space for [mem size 0x3e00000000 64bit pref]
> pci 0000:53:00.0: BAR 9: failed to assign [mem size 0x3e00000000 64bit pref]
> pci 0000:53:00.0: BAR 7: assigned [mem 0x202001000000-0x20201fffffff 64bit pref]
> pci 0000:52:01.0: PCI bridge to [bus 53]
> pci 0000:52:01.0:   bridge window [io  0x8000-0x8fff]
> pci 0000:52:01.0:   bridge window [mem 0xbb800000-0xbb9fffff]
> pci 0000:52:01.0:   bridge window [mem 0x201c00000000-0x2021ffffffff 64bit pref]
> 
> GPU
> ~~~
> 0x201c00000000-0x201fffffffff	PF BAR2 16834M
> 0x202000000000-0x202000ffffff	PF BAR0	16M
> 0x202001000000-0x20201fffffff 	VF BAR0	496M (31 * 16M)
> FAIL				VF BAR2 253952M (31 * 8G)
> 
> PCIe downstream port
> ~~~~~~~~~~~~~~~~~~~~
> 0x201c00000000-0x2021ffffffff		24576M
> 
> Now, if I hack the allocation algorithm (in pbus_size_mem()) to "mimic"
> the BIOS allocation then these fit fine. However, if the BIOS allocation
> ever changes we may end up in similar issue. Also the Linux PCI resource
> allocation code has been like that for aeons so changing it would likely
> cause regressions.
> 
> Let me know if more information is needed. I have one of these cards
> locally and have remote access to a similar system where the above
> example was take so I can run additional testing.
> 
> Also let me know if you want me to file a bug in kernel.org bugzilla.
> 
> Thanks in advance!

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD19680E13
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjA3Mxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 07:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA3Mxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 07:53:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E2710E3
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 04:53:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 744F6B8101B
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 12:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB740C433D2;
        Mon, 30 Jan 2023 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675083206;
        bh=JQrgXuXXwFkHzdHdUgc8yy07YjGNtZzrnqlxPa6RdBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UuodaFprjjZArAEoXHhnRvhfkCtPbqpcQVBVKfy0/5dHb8rGgkuz/Xee0GZ1TTNxC
         lbxIvuKpAPooIf7P+anSbupySyVRMu8lA30ZmvnfRFDuAoGesCNBVyxBdLM9MB80CP
         dyPIZnTFSs8FCCeo2wTIXKlAuPGEkmGCb0QBaekJjiORrciUMPqCxKXrxBGNXKs07H
         IhWxaAPsawFP1QPzrrS/nBriizyELyJai0YOhc9nRjSWu5dXbOf2IsUSM+RpiATJUc
         rOh8UjWOidyyoKED0HODFV80zl98gtOajuZZS2FWpFq7+QvNNdKMrJoD9h6LaP/lYd
         3dkB9ozzlHvHQ==
Date:   Mon, 30 Jan 2023 06:53:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Bug 216795] New: PCI resource allocation mismatch with BIOS
Message-ID: <20230130125324.GA1661790@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216795-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 11:03:06AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216795
> 
>             Bug ID: 216795
>            Summary: PCI resource allocation mismatch with BIOS
>     Kernel Version: v6.1-rc8
>           Reporter: mika.westerberg@linux.intel.com
> 
> Created attachment 303384
>   --> https://bugzilla.kernel.org/attachment.cgi?id=303384&action=edit
> Dmesg from the system
> 
> The device in question is a GPU with an integrated PCIe switch connected
> to a root port of a system:
> 
> 0000:50:02.0 Root Port
>   0000:51:00.0 Switch Upstream Port
>   0000:52:01.0 Switch Downstream Port
>    0000:53:00.0 GPU Endpoint
> 
> The GPU has SRIOV capability and the BIOS allocates resources for these
> (see the attached dumps). However, if parts of the topology is removed
> through sysfs and then re-scanned the resource allocation fails and that
> leaves the GPU without any resources assigned.
> 
> The real use-case is in data centers if the GPU hangs to reset it
> through Secondary Bus Reset. This avoids rebooting the whole system. The
> below steps are the minimal to get it reproduced in the current
> Linux mainline (v6.1-rc8).
> 
> The expectation is that the rescan results similar resource allocation
> than what was done by the BIOS. What happens though is that the Linux
> resource allocation seems to allocate "bigger" windows that then does
> not fit into the BIOS allocated resources above the Downststream Port.
> 
> Steps
> -----
> 1. Boot the system up
> 2. Take lspci and iomem dumps
> 
> # lspci -vv > lspci.before
> # cp /proc/iomem iomem.before
> 
> 3. Remove the Switch Downstream Port and the GPU Endpoint
> 
> # echo 1 > /sys/bus/pci/devices/0000:50:02.0/0000:51:00.0/0000:52:01.0/remove
> 
> 4. Rescan from the Switch Upstream Port
> 
> # echo 1 > /sys/bus/pci/devices/0000:50:02.0/0000:51:00.0/rescan
> 
> 5. Take the dumps
> 
> # lspci -vv > lspci.after
> # cp /proc/iomem iomem.after
> 
> BIOS assigned resources (lspci.before)
> --------------------------------------
> 52:01.0 PCI bridge: Intel Corporation Device 4fa4 (prog-if 00 [Normal decode])
>         ...
>         Bus: primary=52, secondary=53, subordinate=54, sec-latency=0
>         I/O behind bridge: [disabled]
>         Memory behind bridge: bb800000-bb9fffff [size=2M]
>         Prefetchable memory behind bridge: 0000201c00000000-0000205e1fffffff
> [size=270848M]
> 
> 53:00.0 Display controller: Intel Corporation Device 56c0 (rev 08)
>         ...
>         Region 0: Memory at 205e1f000000 (64-bit, prefetchable) [size=16M]
>         Region 2: Memory at 201c00000000 (64-bit, prefetchable) [size=16G]
>         Expansion ROM at bb800000 [disabled] [size=2M]
>         ...
>         Capabilities: [320 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
>                 IOVSta: Migration-
>                 Initial VFs: 31, Total VFs: 31, Number of VFs: 0, Function
> Dependency Link: 00
>                 VF offset: 1, stride: 1, Device ID: 56c0
>                 Supported Page Size: 00000553, System Page Size: 00000001
>                 Region 0: Memory at 0000205e00000000 (64-bit, prefetchable)
>                 Region 2: Memory at 0000202000000000 (64-bit, prefetchable)
>                 VF Migration: offset: 00000000, BIR: 0
> 
> Linux assigned resources (lspci.after)
> --------------------------------------
> 52:01.0 PCI bridge: Intel Corporation Device 4fa4 (prog-if 00 [Normal decode])
>         ...
>         Bus: primary=52, secondary=53, subordinate=54, sec-latency=0
>         I/O behind bridge: [disabled]
>         Memory behind bridge: bb800000-bb9fffff [size=2M]
>         Prefetchable memory behind bridge: [disabled]
> 
> 53:00.0 Display controller: Intel Corporation Device 56c0 (rev 08)
>         ...
>         Region 0: Memory at <ignored> (64-bit, prefetchable)
>         Region 2: Memory at <ignored> (64-bit, prefetchable)
>         ...
>         Capabilities: [320 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
>                 IOVSta: Migration-
>                 Initial VFs: 31, Total VFs: 31, Number of VFs: 0, Function
> Dependency Link: 00
>                 VF offset: 1, stride: 1, Device ID: 56c0
>                 Supported Page Size: 00000553, System Page Size: 00000001
>                 Region 0: Memory at 0000205e00000000 (64-bit, prefetchable)
>                 Region 2: Memory at 0000202000000000 (64-bit, prefetchable)
>                 VF Migration: offset: 00000000, BIR: 0
> 
> Relevant lines in dmesg
> -----------------------
> [  131.882092] i915 0000:53:00.0: PME# disabled
> [  131.882115] i915 0000:53:00.0: vgaarb: pci_notify
> [  131.997587] pci 0000:53:00.0: vgaarb: pci_notify
> [  131.997646] pcieport 0000:52:01.0: PME# disabled
> [  131.997658] pcieport 0000:52:01.0: vgaarb: pci_notify
> [  131.997675] pci 0000:52:01.0: vgaarb: pci_notify
> [  131.997690] pci 0000:53:00.0: vgaarb: pci_notify
> [  131.997788] pci 0000:53:00.0: vgaarb: pci_notify
> [  131.997811] pci 0000:53:00.0: device released
> [  131.997820] pci_bus 0000:53: busn_res: [bus 53-54] is released
> [  131.997868] pci 0000:52:01.0: vgaarb: pci_notify
> [  131.997953] pcieport 0000:51:00.0: saving config space at offset 0x0
> (reading 0x4fa08086)
> [  131.997960] pcieport 0000:51:00.0: saving config space at offset 0x4
> (reading 0x110147)
> [  131.997966] pcieport 0000:51:00.0: saving config space at offset 0x8
> (reading 0x6040001)
> [  131.997970] pcieport 0000:51:00.0: saving config space at offset 0xc
> (reading 0x10008)
> [  131.997975] pcieport 0000:51:00.0: saving config space at offset 0x10
> (reading 0x2000000c)
> [  131.997980] pcieport 0000:51:00.0: saving config space at offset 0x14
> (reading 0x205e)
> [  131.997985] pcieport 0000:51:00.0: saving config space at offset 0x18
> (reading 0x545251)
> [  131.997989] pcieport 0000:51:00.0: saving config space at offset 0x1c
> (reading 0x1f1)
> [  131.997993] pcieport 0000:51:00.0: saving config space at offset 0x20
> (reading 0xbb90bb80)
> [  131.997998] pcieport 0000:51:00.0: saving config space at offset 0x24
> (reading 0x1ff10001)
> [  131.998002] pcieport 0000:51:00.0: saving config space at offset 0x28
> (reading 0x201c)
> [  131.998007] pcieport 0000:51:00.0: saving config space at offset 0x2c
> (reading 0x205e)
> [  131.998011] pcieport 0000:51:00.0: saving config space at offset 0x30
> (reading 0x0)
> [  131.998015] pcieport 0000:51:00.0: saving config space at offset 0x34
> (reading 0x40)
> [  131.998020] pcieport 0000:51:00.0: saving config space at offset 0x38
> (reading 0x0)
> [  131.998024] pcieport 0000:51:00.0: saving config space at offset 0x3c
> (reading 0x301ff)
> [  131.998072] pcieport 0000:51:00.0: PME# enabled
> [  131.998122] pci 0000:52:01.0: vgaarb: pci_notify
> [  131.998140] pci 0000:52:01.0: device released
> [  132.009340] pcieport 0000:50:02.0: saving config space at offset 0x0
> (reading 0x347a8086)
> [  132.009353] pcieport 0000:50:02.0: saving config space at offset 0x4
> (reading 0x100547)
> [  132.009359] pcieport 0000:50:02.0: saving config space at offset 0x8
> (reading 0x6040004)
> [  132.009363] pcieport 0000:50:02.0: saving config space at offset 0xc
> (reading 0x10000)
> [  132.009368] pcieport 0000:50:02.0: saving config space at offset 0x10
> (reading 0x20800004)
> [  132.009372] pcieport 0000:50:02.0: saving config space at offset 0x14
> (reading 0x205e)
> [  132.009377] pcieport 0000:50:02.0: saving config space at offset 0x18
> (reading 0x545150)
> [  132.009381] pcieport 0000:50:02.0: saving config space at offset 0x1c
> (reading 0x200000f0)
> [  132.009385] pcieport 0000:50:02.0: saving config space at offset 0x20
> (reading 0xbb90bb80)
> [  132.009390] pcieport 0000:50:02.0: saving config space at offset 0x24
> (reading 0x20710001)
> [  132.009394] pcieport 0000:50:02.0: saving config space at offset 0x28
> (reading 0x201c)
> [  132.009398] pcieport 0000:50:02.0: saving config space at offset 0x2c
> (reading 0x205e)
> [  132.009402] pcieport 0000:50:02.0: saving config space at offset 0x30
> (reading 0x0)
> [  132.009406] pcieport 0000:50:02.0: saving config space at offset 0x34
> (reading 0x40)
> [  132.009411] pcieport 0000:50:02.0: saving config space at offset 0x38
> (reading 0x0)
> [  132.009415] pcieport 0000:50:02.0: saving config space at offset 0x3c
> (reading 0x201ff)
> [  132.009453] pcieport 0000:50:02.0: PME# enabled
> [  150.136581] pci_bus 0000:51: scanning bus
> [  150.148686] pcieport 0000:50:02.0: restoring config space at offset 0x2c
> (was 0x205e, writing 0x205e)
> [  150.148700] pcieport 0000:50:02.0: restoring config space at offset 0x28
> (was 0x201c, writing 0x201c)
> [  150.148708] pcieport 0000:50:02.0: restoring config space at offset 0x24
> (was 0x20710001, writing 0x20710001)
> [  150.148783] pcieport 0000:50:02.0: PME# disabled
> [  150.160911] pcieport 0000:51:00.0: restoring config space at offset 0x2c
> (was 0x205e, writing 0x205e)
> [  150.160925] pcieport 0000:51:00.0: restoring config space at offset 0x28
> (was 0x201c, writing 0x201c)
> [  150.160932] pcieport 0000:51:00.0: restoring config space at offset 0x24
> (was 0x1ff10001, writing 0x1ff10001)
> [  150.160967] pcieport 0000:51:00.0: PME# disabled
> [  150.160976] pcieport 0000:51:00.0: scanning [bus 52-54] behind bridge, pass
> 0
> [  150.160988] pci_bus 0000:52: scanning bus
> [  150.161024] pci 0000:52:01.0: [8086:4fa4] type 01 class 0x060400
> [  150.161219] pci 0000:52:01.0: PME# supported from D0 D3hot D3cold
> [  150.161228] pci 0000:52:01.0: PME# disabled
> [  150.161372] pci 0000:52:01.0: vgaarb: pci_notify
> [  150.161466] pci 0000:52:01.0: scanning [bus 53-54] behind bridge, pass 0
> [  150.161536] pci_bus 0000:53: scanning bus
> [  150.161565] pci 0000:53:00.0: [8086:56c0] type 00 class 0x038000
> [  150.161597] pci 0000:53:00.0: reg 0x10: [mem 0x205e1f000000-0x205e1fffffff
> 64bit pref]
> [  150.161620] pci 0000:53:00.0: reg 0x18: [mem 0x201c00000000-0x201fffffffff
> 64bit pref]
> [  150.161656] pci 0000:53:00.0: reg 0x30: [mem 0xffe00000-0xffffffff pref]
> [  150.161707] pci 0000:53:00.0: ASPM: overriding L1 acceptable latency from
> 0x0 to 0x7
> [  150.161787] pci 0000:53:00.0: PME# supported from D0 D3hot
> [  150.161794] pci 0000:53:00.0: PME# disabled
> [  150.161832] pci 0000:53:00.0: reg 0x344: [mem 0x205e00000000-0x205e00ffffff
> 64bit pref]
> [  150.161837] pci 0000:53:00.0: VF(n) BAR0 space: [mem
> 0x205e00000000-0x205e1effffff 64bit pref] (contains BAR0 for 31 VFs)
> [  150.161854] pci 0000:53:00.0: reg 0x34c: [mem 0x202000000000-0x2021ffffffff
> 64bit pref]
> [  150.161858] pci 0000:53:00.0: VF(n) BAR2 space: [mem
> 0x202000000000-0x205dffffffff 64bit pref] (contains BAR2 for 31 VFs)
> [  150.162112] pci 0000:53:00.0: vgaarb: pci_notify
> [  150.162173] pci_bus 0000:53: fixups for bus
> [  150.162177] pci 0000:52:01.0: PCI bridge to [bus 53-54]
> [  150.162187] pci 0000:52:01.0:   bridge window [mem 0xbb800000-0xbb9fffff]
> [  150.162198] pci 0000:52:01.0:   bridge window [mem
> 0x201c00000000-0x205e1fffffff 64bit pref]
> [  150.162202] pci_bus 0000:53: bus scan returning with max=53
> [  150.162210] pci 0000:52:01.0: scanning [bus 53-54] behind bridge, pass 1
> [  150.162219] pci_bus 0000:52: bus scan returning with max=54
> [  150.162225] pcieport 0000:51:00.0: scanning [bus 52-54] behind bridge, pass
> 1
> [  150.162233] pci_bus 0000:51: bus scan returning with max=54
> [  150.162240] pci 0000:52:01.0: bridge window [mem 0x200000000-0x45ffffffff
> 64bit pref] to [bus 53-54] add_size 3e00000000 add_align 200000000
> [  150.162259] pci 0000:52:01.0: BAR 15: no space for [mem size 0x8200000000
> 64bit pref]
> [  150.162265] pci 0000:52:01.0: BAR 15: failed to assign [mem size
> 0x8200000000 64bit pref]
> [  150.162270] pci 0000:52:01.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
> [  150.162278] pci 0000:52:01.0: BAR 15: no space for [mem size 0x4400000000
> 64bit pref]
> [  150.162282] pci 0000:52:01.0: BAR 15: failed to assign [mem size
> 0x4400000000 64bit pref]
> [  150.162286] pci 0000:52:01.0: BAR 14: assigned [mem 0xbb800000-0xbb9fffff]
> [  150.162295] pci 0000:53:00.0: BAR 2: no space for [mem size 0x400000000
> 64bit pref]
> [  150.162299] pci 0000:53:00.0: BAR 2: failed to assign [mem size 0x400000000
> 64bit pref]
> [  150.162304] pci 0000:53:00.0: BAR 9: no space for [mem size 0x3e00000000
> 64bit pref]
> [  150.162308] pci 0000:53:00.0: BAR 9: failed to assign [mem size 0x3e00000000
> 64bit pref]
> [  150.162313] pci 0000:53:00.0: BAR 0: no space for [mem size 0x01000000 64bit
> pref]
> [  150.162316] pci 0000:53:00.0: BAR 0: failed to assign [mem size 0x01000000
> 64bit pref]
> [  150.162321] pci 0000:53:00.0: BAR 7: no space for [mem size 0x1f000000 64bit
> pref]
> [  150.162325] pci 0000:53:00.0: BAR 7: failed to assign [mem size 0x1f000000
> 64bit pref]
> [  150.162329] pci 0000:53:00.0: BAR 6: assigned [mem 0xbb800000-0xbb9fffff
> pref]
> [  150.162336] pci 0000:53:00.0: BAR 2: no space for [mem size 0x400000000
> 64bit pref]
> [  150.162340] pci 0000:53:00.0: BAR 2: failed to assign [mem size 0x400000000
> 64bit pref]
> [  150.162345] pci 0000:53:00.0: BAR 0: no space for [mem size 0x01000000 64bit
> pref]
> [  150.162348] pci 0000:53:00.0: BAR 0: failed to assign [mem size 0x01000000
> 64bit pref]
> [  150.162352] pci 0000:53:00.0: BAR 6: assigned [mem 0xbb800000-0xbb9fffff
> pref]
> [  150.162357] pci 0000:53:00.0: BAR 9: no space for [mem size 0x3e00000000
> 64bit pref]
> [  150.162361] pci 0000:53:00.0: BAR 9: failed to assign [mem size 0x3e00000000
> 64bit pref]
> [  150.162365] pci 0000:53:00.0: BAR 7: no space for [mem size 0x1f000000 64bit
> pref]
> [  150.162369] pci 0000:53:00.0: BAR 7: failed to assign [mem size 0x1f000000
> 64bit pref]
> [  150.162374] pci 0000:52:01.0: PCI bridge to [bus 53-54]
> [  150.162382] pci 0000:52:01.0:   bridge window [mem 0xbb800000-0xbb9fffff]
> [  150.162418] pcieport 0000:52:01.0: vgaarb: pci_notify
> [  150.162426] pcieport 0000:52:01.0: runtime IRQ mapping not provided by arch
> [  150.162545] pcieport 0000:52:01.0: saving config space at offset 0x0
> (reading 0x4fa48086)
> [  150.162559] pcieport 0000:52:01.0: saving config space at offset 0x4
> (reading 0x100143)
> [  150.162565] pcieport 0000:52:01.0: saving config space at offset 0x8
> (reading 0x6040000)
> [  150.162570] pcieport 0000:52:01.0: saving config space at offset 0xc
> (reading 0x10008)
> [  150.162574] pcieport 0000:52:01.0: saving config space at offset 0x10
> (reading 0x0)
> [  150.162579] pcieport 0000:52:01.0: saving config space at offset 0x14
> (reading 0x0)
> [  150.162584] pcieport 0000:52:01.0: saving config space at offset 0x18
> (reading 0x545352)
> [  150.162589] pcieport 0000:52:01.0: saving config space at offset 0x1c
> (reading 0x200000f0)
> [  150.162594] pcieport 0000:52:01.0: saving config space at offset 0x20
> (reading 0xbb90bb80)
> [  150.162598] pcieport 0000:52:01.0: saving config space at offset 0x24
> (reading 0x1fff1)
> [  150.162603] pcieport 0000:52:01.0: saving config space at offset 0x28
> (reading 0x0)
> [  150.162607] pcieport 0000:52:01.0: saving config space at offset 0x2c
> (reading 0x0)
> [  150.162612] pcieport 0000:52:01.0: saving config space at offset 0x30
> (reading 0x0)
> [  150.162616] pcieport 0000:52:01.0: saving config space at offset 0x34
> (reading 0x40)
> [  150.162621] pcieport 0000:52:01.0: saving config space at offset 0x38
> (reading 0x0)
> [  150.162625] pcieport 0000:52:01.0: saving config space at offset 0x3c
> (reading 0x300ff)
> [  150.162766] pcieport 0000:52:01.0: vgaarb: pci_notify
> [  150.162856] i915 0000:53:00.0: vgaarb: pci_notify
> [  150.162868] i915 0000:53:00.0: runtime IRQ mapping not provided by arch
> [  150.163121] i915 0000:53:00.0: vgaarb: pci_notify

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07154EB66
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiFPUk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFPUkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 16:40:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11845DE56
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 13:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 925BAB82604
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 20:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0F0C3411B;
        Thu, 16 Jun 2022 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655412022;
        bh=RLfSRAEzc/5v/sXDyQjHRxK4Fv+TRgIkXH6XRsJD4Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ewpf2GleVol1wdCbqZKQ2rkVdUbLtQfbta2QHhIle5uJbcSqK4tiuOP96LLVIrpg9
         0CXDgtKBCzVM+BGcYYQqirpqkmwELCtkaSC3CEGG6v3QpUkphww59RsJlYVTXuT1j5
         6wMbksmT5+kkpGMcIIz16wMA3SHnRhSuuU6PXXdiUEr298aTVGP8rb719OCZC0c0WO
         ndnZt+O3e77sDfisFSGk2tzbvQBdT5Ec/hq6V17iZMvf13e5X5xeAeb2fewqAqDmZ7
         m/9FBf7lxfdn3Azp488ETglfXKy+27OqwozULFr0RFccZJF0zZZ+K7EsE7i2W11dIb
         ZIzuDYUBIGg/Q==
Date:   Thu, 16 Jun 2022 15:40:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: Re: pci=no_e820 report for vmware fusion
Message-ID: <20220616204020.GA1137352@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B1241E1-6C7E-42CF-9690-1F47E9F3A6B2@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 16, 2022 at 08:12:28AM -0400, Benjamin Coddington wrote:
> My VMWare Fusion linux VM's display stopped working after an update, with:
> 
> [.558514] vmwgfx 0000:00:0f.0: vgaarb: deactivate vga console
> [.559964] Console: switching to colour dummy device 80x25
> [.583703] vmwgfx 0000:00:0f.0: [drm] FIFO at 0x00000000c0000000 size is 8192
> kiB
> [.583783] vmwgfx 0000:00:0f.0: [drm] VRAM at 0x00000000e8000000 size is
> 131072 kiB
> [.583845] vmwgfx 0000:00:0f.0: [drm] Running on SVGA version 2.
> [.583863] vmwgfx 0000:00:0f.0: [drm] Capabilities: rect copy, cursor, cursor
> bypass, cursor bypass 2, 8bit emulation, alpha cursor, extended fifo,
> multimon, pitchlock, irq mask, display topology, gmr, traces, gmr2, screen
> object 2, command buffers, command buffers 2, gbobject, dx,
> [.583865] vmwgfx 0000:00:0f.0: [drm] DMA map mode: Caching DMA mappings.
> [.584003] vmwgfx 0000:00:0f.0: [drm] Legacy memory limits: VRAM = 4096 kB,
> FIFO = 256 kB, surface = 0 kB
> [.584006] vmwgfx 0000:00:0f.0: [drm] MOB limits: max mob size = 131072 kB,
> max mob pages = 98304
> [.584008] vmwgfx 0000:00:0f.0: [drm] Max GMR ids is 64
> [.584009] vmwgfx 0000:00:0f.0: [drm] Max number of GMR pages is 65536
> [.584010] vmwgfx 0000:00:0f.0: [drm] Maximum display memory size is 131072
> kiB
> [.619664] vmwgfx 0000:00:0f.0: [drm] Screen Target display unit initialized
> [.638401] vmwgfx 0000:00:0f.0: [drm] Fifo max 0xffffffff min 0xffffffff cap
> 0xffffffff
> [.638406] vmwgfx 0000:00:0f.0: [drm] FIFO memory is not usable. Driver
> failed to initialize.
> [.638407] [drm:vmw_request_device [vmwgfx]] *ERROR* Unable to initialize the
> device.
> 
> (There's also quite a lot of pci badness entries before this, left out
> for brevity).

The badness would definitely be interesting (the entire dmesg log), as
well as a dmesg log collected with "pci=no_e820".  I'll attach them to
this bugzilla [1].

Generally I expect PCI devices to work even if we reassign their BARs
before a driver claims them.  But apparently some do not, and I'm
always curious about which ones they are.

If you could confirm that Hans' revert [2] avoids the problem without
needing "pci=no_e820", that would be awesome, too.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216109
[2] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=dd104bcc2cf233234f82bfc4bd5b8ab32cdbf117

> I bisected the issue to:
> 4c5e242d3e93 x86/PCI: Clip only host bridge windows for E820 regions
> 
> and to confirm that was the problem I attempted a revert of that commit on
> v5.19-rc1.  The revert had a conflict which pointed me to this commit:
> fa6dae5d8208 x86/PCI: Add kernel cmdline options to use/ignore E820 reserved
> regions
> 
> So - I've added "pci=no_e820" to my kernel parameters, which allows vmwgfx
> to work properly again, and I'm reporting it here as requested in the commit
> adding that parameter.
> 
> I'm happy to provide more information if needed, or test.
> 
> Ben
> 

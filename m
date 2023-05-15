Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081487034C3
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 18:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbjEOQwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbjEOQvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 12:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CD18C;
        Mon, 15 May 2023 09:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 248166298E;
        Mon, 15 May 2023 16:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490EBC433A1;
        Mon, 15 May 2023 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684169504;
        bh=bPE6tiox0+6DYFmbI4QGtsVQa2DaVX/N5GVaQuozKI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r5lYF9P9/n/gsCAddF//yyaqmOhUFn8yhkNNIKkC11P6EixEI2iKTyl03mCckUz6f
         jhhxJh/c+fK44jKDuA9ifyIwidPJMmw4TQXNEwN8FC0WBQgEuUPWVbsuzhk8SglgV/
         Sj9y/5rPK+nJz+ucIdXaBQyzO9WqPZal7B6UpO+iCh82qP0DXw9mlRwdqMKOKY4HD/
         B3kh5/ZO+SUUpHz7s+xgMj0ngIwbYOtfh7ZcUefOZvd8IYoJBcWdOrY8gEUZa1qnfc
         yHw+Z8PE4938YrTDfF7gGQp4ZGL/iiH9BlO5SCs1c4/m+01RARk4kxuICrjmFOxPEu
         n479RmOkxMnUw==
Date:   Mon, 15 May 2023 11:51:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     robh@kernel.org, heiko@sntech.de, Will Deacon <will@kernel.org>,
        kw@linux.com, linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, bhelgaas@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
Message-ID: <ZGJjHnHNJPqvuqVC@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 13, 2023 at 07:40:12AM -0400, Peter Geis wrote:
> On Fri, May 12, 2023 at 9:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc ARM64 folks, in case you have abort handling tips; thread at:
> > https://lore.kernel.org/r/20230509153912.515218-1-vincenzopalazzodev@gmail.com]
> >
> > Pine64 RockPro64 panics while enumerating some PCIe devices.  Adding a
> > delay avoids the panic.  My theory is a PCIe Request Retry Status to a
> > Vendor ID config read causes an abort that we don't handle.
> >
> > > On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > >> ...
> > >> [    1.229856] SError Interrupt on CPU4, code 0xbf000002 -- SError
> > >> [    1.229860] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MANJARO-ARM
> > >> #1
> > >> [    1.229862] Hardware name: Pine64 RockPro64 v2.1 (DT)
> > >> [    1.229864] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=--)
> > >> [    1.229866] pc : rockchip_pcie_rd_conf+0xb4/0x270
> > >> [    1.229868] lr : rockchip_pcie_rd_conf+0x1b4/0x270
> > >> ...
> > >> [    1.229939] Kernel panic - not syncing: Asynchronous SError Interrupt
> > >> ...
> > >> [    1.229955]  nmi_panic+0x8c/0x90
> > >> [    1.229956]  arm64_serror_panic+0x78/0x84
> > >> [    1.229958]  do_serror+0x15c/0x160
> > >> [    1.229960]  el1_error+0x84/0x100
> > >> [    1.229962]  rockchip_pcie_rd_conf+0xb4/0x270
> > >> [    1.229964]  pci_bus_read_config_dword+0x6c/0xd0
> > >> [    1.229966]  pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
> > >> [    1.229968]  pci_scan_single_device+0xa4/0x144
> >
> > On Fri, May 12, 2023 at 12:46:21PM +0200, Vincenzo Palazzo wrote:
> > > ... Is there any way to tell the kernel "hey we need some more time
> > > here"?
> >
> > We enumerate PCI devices by trying to read the Vendor ID of every
> > possible device address (see pci_scan_slot()).  On PCIe, if a device
> > doesn't exist at that address, the Vendor ID config read will be
> > terminated with Unsupported Request (UR) status.  This is normal
> > and happens every time we enumerate devices.
> >
> > The crash doesn't happen every time we enumerate, so I don't think
> > this UR is the problem.  Also, if it *were* the problem, adding a
> > delay would not make any difference.
> 
> Is this behavior different if there is a switch device forwarding on
> the UR? On rk3399 switches are completely non-functional because of
> the panic, which is observed in the output of the dmesg in [2] with
> the hack patch enabled. Considering what you just described it looks
> like the forwarded UR for each non-existent device behind the switch
> is causing an serror.

I don't know exactly what the panic looks like, but I wouldn't expect
UR handling to be different when there's a switch.

pcie-rockchip-host.c does handle devices on the root bus (00)
differently than others because rockchip_pcie_valid_device() knows
that device 00:00 is the only device on the root bus.  That part makes
sense because 00:00 is built into the SoC.

I'm a little suspicious of the fact that rockchip_pcie_valid_device()
also enforces that bus 01 can only have a single device on it.  No
other *_pcie_valid_device() implementations enforce that.  It's true
that traditional PCIe devices can only implement device 00, but ARI
relaxes that by reusing the Device Number as extended Function Number
bits.

> > There *is* a way for a PCIe device to say "I need more time".  It does
> > this by responding to that Vendor ID config read with Request Retry
> > Status (RRS, aka CRS in older specs), which means "I'm not ready yet,
> > but I will be ready in the future."  Adding a delay would definitely
> > make a difference here, so my guess is this is what's happening.
> >
> > Most root complexes return ~0 data to the CPU when a config read
> > terminates with UR or RRS.  It sounds like rockchip does this for UR
> > but possibly not for RRS.
> >
> > There is a "RRS Software Visibility" feature, which is supposed to
> > turn the RRS into a special value (Vendor ID == 0x0001), but per [1],
> > rockchip doesn't support it (lspci calls it "CRSVisible").
> >
> > But the CPU load instruction corresponding to the config read has to
> > complete by reading *something* or else be aborted.  It sounds like
> > it's aborted in this case.  I don't know the arm64 details, but if we
> > could catch that abort and determine that it was an RRS and not a UR,
> > maybe we could fabricate the magic RRS 0x0001 value.
> >
> > imx6q_pcie_abort_handler() does something like that, although I think
> > it's for arm32, not arm64.  But obviously we already catch the abort
> > enough to dump the register state and panic, so maybe there's a way to
> > extend that?
> 
> Perhaps a hook mechanism that allows drivers to register with the
> serror handler and offer to handle specific errors before the generic
> code causes the system panic?
> 
> Very Respectfully,
> Peter Geis
> 
> [2] https://lore.kernel.org/linux-pci/CAMdYzYqn3L7x-vc+_K6jG0EVTiPGbz8pQ-N1Q1mRbcVXE822Yg@mail.gmail.com/
> 
> >
> > Bjorn
> >
> > [1] https://lore.kernel.org/linux-pci/CAMdYzYpOFAVq30N+O2gOxXiRtpoHpakFg3LKq3TEZq4S6Y0y0g@mail.gmail.com/
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees

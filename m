Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F6269F11D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBVJRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 04:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBVJRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 04:17:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFD37B57
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 01:17:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF97612AB
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 09:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11E2C4339B;
        Wed, 22 Feb 2023 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677057426;
        bh=gnKeMTCGF7fqj28dzyrDAKUQha+FDP4MmGfeioSV5m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4UflGsVUzKmS5hFO6J98ACrHz9RlUZqdy+5T60fe5JpA7q5wuvQ2h3IN1XZDNHU/
         Dgf4deMJA4cBZzbTKJZuSzUMFK3Zd2Kbl9ZQUmY+sHQl7+DsL2PXDlrmtKewbEPMhA
         SzpLuVWeSrq7pNTWSFaSRo7gGLOek1sFZdt/FdSYpjbeV5ojXHx2b14Hj8KzdBAult
         9XENvEWlK7WzdGSW0FlQBkNlyHlTzQv01LjD9lrn2Rq/TZKLVnIT3hls+YC075gEHx
         DeHsRdqLyLD4mDDH8c9L8v7PWHkh9VNWpT+yOyef4QgfwH482baejYdjzRuT/WOW9B
         H0rmQvsBLxOWg==
Received: by pali.im (Postfix)
        id B8B6272C; Wed, 22 Feb 2023 10:17:02 +0100 (CET)
Date:   Wed, 22 Feb 2023 10:17:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PING][PATCH v6 0/7] pci: Work around ASMedia ASM2824 PCIe link
 training failures
Message-ID: <20230222091702.yd7tpkb2kj7b75da@pali>
References: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk>
 <alpine.DEB.2.21.2302191849230.25434@angie.orcam.me.uk>
 <20230219194619.GA25088@wunner.de>
 <20230221214611.yfpsrzuupatzz2g5@pali>
 <20230222084033.GA31047@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222084033.GA31047@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 22 February 2023 09:40:33 Lukas Wunner wrote:
> On Tue, Feb 21, 2023 at 10:46:11PM +0100, Pali Rohár wrote:
> > On Sunday 19 February 2023 20:46:19 Lukas Wunner wrote:
> > > > On Sun, 5 Feb 2023, Maciej W. Rozycki wrote:
> > > > >  This is v6 of the change to work around a PCIe link training phenomenon
> > > > > where a pair of devices both capable of operating at a link speed above
> > > > > 2.5GT/s seems unable to negotiate the link speed and continues training
> > > > > indefinitely with the Link Training bit switching on and off repeatedly
> > > > > and the data link layer never reaching the active state.
> > > 
> > > Philipp is witnessing similar issues with a Pericom PI7C9X2G404EL
> > > switch below a Broadcom STB host controller:  On some rare occasions,
> > > when booting the system the link trains correctly at 5 GT/s and the
> > > switch is accessible without any issues.  But most of the time,
> > > the switch is inaccessible on boot.  The Broadcom STB host controller
> > > claims not to support Link Active Reporting, but in reality has a
> > > link status indicator in a custom register.  It indicates that the
> > > link is up, the link trains to 2.5 GT/s but the switch is inaccessible.
> > 
> > This is interesting. Do you know which layer it indicates that is up?
> > I can image that PCIe physical layer or data link layer is up but
> > PCIe transaction layer not yet up and so sending config requests fail.
> > Existence of custom register may explain that it indicates different
> > "link up" meaning.
> 
> drivers/pci/controller/pcie-brcmstb.c defines the following bits:
> 
> #define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK           0x80
> #define  PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK      0x20
> #define  PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK      0x10
> #define  PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK    0x40
> 
> And brcm_pcie_link_up() checks that both DL_ACTIVE and PHYLINKUP are set.
> 
> A public spec for the Broadcom STB PCIe controller does not seem to exist,
> so I do not know what the register bits mean exactly.

Ok, so then this is question for Broadcom. Without spec we probably
cannot do anything.

> 
> > > Due to a quirk of the Broadcom STB host controller, ECAM access to
> > > the inaccessible switch raises an unhandled CPU exception and thus
> > > causes a kernel panic, making the issue difficult to debug.
> > 
> > Is this ARM Cortex A53 core and unhandled exception is asynchronous one
> > with syndrome 0xbf000002?
> 
> It's a Cortex A72 and yes the exception looks like this:
> 
> SError Interrupt on CPU1, code 0x00000000bf000002 -- SError

This is core specific exception and for A53 it means AXI Slave Error.
I guess that on A72 it could mean too. But generally for Aarch64 they
are not defined.

> I was wondering why we're not checking in the exception handler whether
> the accessed address is in ECAM space, and just return from the handler
> since such exceptions could be handled by returning "all ones" in
> software from the PCI core.

We are not checking them because it is asynchronous exception. You do
not know who, when and why caused this exception. Exception may come
also after executing lot of other instructions. It is non-recoverable
fatal exception and it means something like internal core error. The
only reasonable thing to do is to reset CPU.

CPU should not receive AXI Slave Error under non-fatal condition and it
is basically bug in that PCIe controller that it sends such thing to
the CPU core. PCIe controller should for ECAM load/store operations
always returns AXI Slave OK response and on error it should set all-ones
in data part.

The proper way is to find out if PCIe controller does not have some
hidden or debug register which allows to disable sending these errors.
IIRC DesignWare has it, so there is big chance that Broadcom has it too.
But for example Cadence does not have it (yet).

> Then again, perhaps there's a method to stop the controller from
> raising an exception on ECAM access to an inaccessible device.
> If such a method exists (e.g. some register bit), that would
> obviously be preferred.

Other way is map ECAM address memory space in strong ordering mode.
It would cause CPU core to wait during executing of load / store
operation after they completely finish and then AXI Slave Error is
reported as synchronous exception as Data Abort, which is possible.
On ARMv7 it was possible by marking mapping as Device. On ARMv8 it
should be possible too, but on A53 it is unimplemented. Maybe possible
on A72? But it is kind like a hack to workaround total mess.

I will send separate email to Broadcom people who already helped with
one of their PCIe controller in the past. Maybe there is hidden register
debug bit which can turn it off.

> 
> > > The switch works fine 100% when plugged into a TI Sitara AM64 board
> > > (contains a DesignWare-derived PCIe host controller).
> > 
> > It is really DesignWare? I had an impression that TI uses PCIe IPs from
> > Cadence, not from DesignWare. And Cadence controllers behave in some
> > cases different from Designware controllers.
> 
> You're right, I was mistaken, it's indeed a Cadence.
> 
> 
> > > Next step is to hook up
> > > a Teledyne T28 analyzer to see what's going on.
> > 
> > Can you use Teledyne T28 for debugging this issue? Because this is
> > something which can finally show what is happing there.
> 
> Yes it should be possible to debug this, the analyzer is capable of
> logging the link training sequence and present it in a Wireshark-esque
> interface.
> 
> Thanks,
> 
> Lukas

The main issue is that nobody had analyzer for doing it, it is not a
cheap device.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3747E9D3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 01:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhLXARW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 19:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhLXARW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 19:17:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34474C061401;
        Thu, 23 Dec 2021 16:17:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DCA99CE2208;
        Fri, 24 Dec 2021 00:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA228C36AE9;
        Fri, 24 Dec 2021 00:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640305038;
        bh=Lsn+SJr4zh4UngfpfSCZSK7Cx8HFzr3Btzb07JER74A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e8qfm14ZXBBPAovJ7Lz14Jh2N+BIwWPCrhp/J9Oq4q1kzmOhI5czSBRUuDSY9eB05
         XmyMFIn+ynDw3MZVqQJvZw1/EK2Ogf6yiSdGzXMdEQQ71ms3TRmssK17Fz/xVrkr6z
         Tw2kg1cFq6raVDqB0eT1W9+ksOqB1nQG+AB4qjVpn8JWwAzkIr4/lsfJngbvJ7VTXt
         StH7OChZ66aECg/QqxF+TcgthAYl9ITz8khtIeW91b+UxelJ8wIRvCgKvMVBANMwPU
         fWSNQ9av2ealcc6u+40b6oB6agt9wIrXo+adjmU4Kv6GGcVI+zahYSIpJvdFThBV4t
         D5qTkU5rIxtjg==
Date:   Thu, 23 Dec 2021 18:17:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v4] ACPI: Move sdei_init and ghes_init ahead to
 handle platform errors earlier
Message-ID: <20211224001716.GA1324143@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d415145-01bc-ce57-fd00-91ca63090caa@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Rafael, question about HEST/GHES/SDEI init]

On Thu, Dec 23, 2021 at 04:11:11PM +0800, Shuai Xue wrote:
> 在 2021/12/22 AM7:17, Bjorn Helgaas 写道:
> > On Thu, Dec 16, 2021 at 09:34:56PM +0800, Shuai Xue wrote:
> >> On an ACPI system, ACPI is initialised very early from a subsys_initcall(),
> >> while SDEI is not ready until a subsys_initcall_sync().
> >>
> >> The SDEI driver provides functions (e.g. apei_sdei_register_ghes,
> >> apei_sdei_unregister_ghes) to register or unregister event callback for
> >> dispatcher in firmware. When the GHES driver probing, it registers the
> >> corresponding callback according to the notification type specified by
> >> GHES. If the GHES notification type is SDEI, the GHES driver will call
> >> apei_sdei_register_ghes to register event call.
> >>
> >> When the firmware emits an event, it migrates the handling of the event
> >> into the kernel at the registered entry-point __sdei_asm_handler. And
> >> finally, the kernel will call the registered event callback and return
> >> status_code to indicate the status of event handling. SDEI_EV_FAILED
> >> indicates that the kernel failed to handle the event.
> >>
> >> Consequently, when an error occurs during kernel booting, the kernel is
> >> unable to handle and report errors until the GHES driver is initialized by
> >> device_initcall(), in which the event callback is registered. All errors
> >> that occurred before GHES initialization are missed and there is no chance
> >> to report and find them again.
> >>
> >> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> >> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> >> the estatus memory pool. On the other hand, ghes_init() relies on
> >> sdei_init() to detect the SDEI version and the framework for registering
> >> and unregistering events.
> > 
> >> By the way, I don't figure out why acpi_hest_init is called in
> >> acpi_pci_root_init, it don't rely on any other thing. May it could
> >> be moved further, following acpi_iort_init in acpi_init.

> >> sdei_init() relies on ACPI table which is initialized
> >> subsys_initcall(): acpi_init(), acpi_bus_init(), acpi_load_tables(),
> >> acpi_tb_laod_namespace().  May it should be also moved further,
> >> after acpi_load_tables.

> >> In this patch, move sdei_init and ghes_init as far ahead as
> >> possible, right after acpi_hest_init().
> > 
> > I'm having a hard time figuring out the reason for this patch.
> > 
> > Apparently the relevant parts are sdei_init() and ghes_init().
> > Today they are executed in that order:
> > 
> >   subsys_initcall_sync(sdei_init);
> >   device_initcall(ghes_init);
> > 
> > After this patch, they would be executed in the same order, but called
> > explicitly instead of as initcalls:
> > 
> >   acpi_pci_root_init()
> >   {
> >     acpi_hest_init();
> >     sdei_init();
> >     ghes_init();
> >     ...
> > 
> > Explicit calls are certainly better than initcalls, but that doesn't
> > seem to be the reason for this patch.
> > 
> > Does this patch fix a bug?  If so, what is the bug?
> 
> Yes. When the kernel booting, the console logs many times from firmware
> before GHES drivers init:
> 
> 	Trip in MM PCIe RAS handle(Intr:910)
>   	Clean PE[1.1.1] ERR_STS:0x4000100 -> 0 INT_STS:F0000000
> 	Find RP(98:1.0)
> 	--Walk dev(98:1.0) CE:0 UCE:4000
> 	...
> 	ERROR:   sdei_dispatch_event(32a) ret:-1
> 	--handler(910) end
> 
> This is because the callback function has not been registered yet.
> Previously reported errors will be overwritten by new ones. Therefore,
> all errors that occurred before GHES initialization are missed
> and there is no chance to report and find them again.
> 
> > You say that currently "errors that occur before GHES initialization
> > are missed".  Isn't that still true after this patch?  Does this patch
> > merely reduce the time before GHES initialization?  If so, I'm
> > dubious, because we have to tolerate an arbitrary amount of time
> > there.
> 
> After this patch, there are still errors missing. As you mentioned,
> we have to tolerate it until the software reporting capability is built.
> 
> Yes, this patch merely reduce the time before GHES initialization.

It's not a bug that errors that happen before the callback are lost.
At least, it's not a *Linux* bug.  It might be a poor design of the
firmware error reporting interface.

If the only point of this patch is to reduce the time before GHES
initialization, the commit log should clearly say that.

> The boot dmesg before this patch:
> 
> 	[    3.688586] HEST: Table parsing has been initialized.
> 	...
> 	[   33.204340] calling  sdei_init+0x0/0x120 @ 1
> 	[   33.208645] sdei: SDEIv1.0 (0x0) detected in firmware.
> 	...
> 	[   36.005390] calling  ghes_init+0x0/0x11c @ 1
> 	[   36.190021] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> 
> 
> After this patch, the boot dmesg like bellow:
> 
> 	[    3.688664] HEST: Table parsing has been initialized.
> 	[    3.688691] sdei: SDEIv1.0 (0x0) detected in firmware.
> 	[    3.694557] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.

[Tangent: I think this GHES message is confusing.  What "APEI bit"
does this refer to?  The only bits I remember are the Flags bits in
HEST Error Source Descriptor Entries, e.g., ACPI v6.3, sec 18.3.2.

"WHEA _OSC" means nothing to me, and I didn't find anything useful
with grep, other than that "WHEA" might be an obsolete name for what
we now call "APEI".

I don't think there's anything in _OSC that mentions "firmware first."

I don't remember anything in the spec about a way to *enable* Firmware
First Error Handling needing (I'm looking at ACPI v6.3, sec 18.4).

I think the "firmware first" information is useless to the OS -- as
far as I can tell, the spec says nothing about anything the OS should
do based on the FIRMWARE_FIRST bits.]

> As we can see, the initialization of GHES is advanced by 33 seconds.
> So, in my opinion, this patch is necessary, right?
> (It should be noted that the effect of optimization varies with the platform.)

> >> -device_initcall(ghes_init);
> > 
> >>  void __init acpi_pci_root_init(void)
> >>  {
> >>  	acpi_hest_init();
> >> +	sdei_init();
> >> +	ghes_init();
> > 
> > What's the connection between PCI, SDEI, and GHES?  As far as I can
> > tell, SDEI and GHES are not PCI-specific, so it doesn't seem like they
> > should be initialized here in acpi_pci_root_init().
> 
> The only reason is that acpi_hest_init() is initialized here.
> 
> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> the estatus memory pool. On the other hand, ghes_init() relies on
> sdei_init() to detect the SDEI version and the framework for registering
> and unregistering events. The dependencies are as follows
> 
> 	ghes_init() => acpi_hest_init()
> 	ghes_init() => sdei_init()
> 
> I don't figure out why acpi_hest_init() is called in
> acpi_pci_root_init(), it don't rely on any other thing.
> I am wondering that should we moved all of them further? e.g.
> following acpi_iort_init() in acpi_init().

I don't know why acpi_hest_init() is called from acpi_pci_root_init().
It looks like HEST can support error sources other than PCI (IA-32
Machine Checks, NMIs, GHES, etc.)  It was added by 415e12b23792
("PCI/ACPI: Request _OSC control once for each root bridge (v3)");
maybe Rafael remembers why.

Seem like acpi_hest_init(), sdei_init(), and ghes_init() should all go
somewhere else, but I don't know where.  Maybe somewhere in
acpi_init()?

Bjorn

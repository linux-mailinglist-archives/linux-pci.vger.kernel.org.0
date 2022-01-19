Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28134941F1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 21:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiASUnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 15:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiASUnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 15:43:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABDC061574;
        Wed, 19 Jan 2022 12:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9A5AB81B40;
        Wed, 19 Jan 2022 20:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEBAC004E1;
        Wed, 19 Jan 2022 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642624981;
        bh=MYdffHsoiG3EHyAMjktxM2ofz/n5wkMwONpV0Nte2Cc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WNEtlRC2A1ACqYqANxnXl4w6LgJIsbTg1+FcDOru2xLG/04GiIHhpXHiypVxqPqoJ
         mgcBHAhLy7od99+LxMNNv0llAle2tjK8UbIPaMXkc1j5TbFePbGhMpm6MeQKubXHqP
         q6auDJ5MTnQPEi97UJDA6N3JyFcgWxVTcnxzoeHNEA+paE5ZT1Z1x0MIDETEHSGyDF
         7U9Inogrtr0C5hTG1r+dD1yIN8zvQu1PONjkiNS91KFeY69YhQcCW8qJ6w/1wuESLK
         svzdACsj7hCprWHtEZ7tr0PAICJpBvecPba5jGB6ezFwQiN1lhbVj1ti85tdDwWH7o
         GR/6nrncDXW7A==
Date:   Wed, 19 Jan 2022 14:42:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, lenb@kernel.org,
        rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] ACPI: Move sdei_init and ghes_init ahead to handle
 platform errors earlier
Message-ID: <20220119204259.GA962224@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e57cc874-dacd-912d-4282-3cb6b1b77323@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 02:40:11PM +0800, Shuai Xue wrote:
> [+to Rafael, question about HEST/GHES/SDEI init]
> 
> Hi, Bjorn,
> 
> Thank you for your comments and quick reply.
> 
> 在 2022/1/19 AM6:49, Bjorn Helgaas 写道:
> > On Sun, Jan 16, 2022 at 04:43:10PM +0800, Shuai Xue wrote:
> >> On an ACPI system, ACPI is initialised very early from a
> >> subsys_initcall(), while SDEI is not ready until a
> >> subsys_initcall_sync(). This patch is to reduce the time before GHES
> >> initialization.
> >>
> >> The SDEI driver provides functions (e.g. apei_sdei_register_ghes(),
> >> apei_sdei_unregister_ghes()) to register or unregister event callback
> >> for dispatcher in firmware. When the GHES driver probing, it registers
> >> the corresponding callback according to the notification type specified
> >> by GHES. If the GHES notification type is SDEI, the GHES driver will
> >> call apei_sdei_register_ghes() to register event call.
> >>
> >> When the firmware emits an event, it migrates the handling of the event
> >> into the kernel at the registered entry-point __sdei_asm_handler. And
> >> finally, the kernel will call the registered event callback and return
> >> status_code to indicate the status of event handling. SDEI_EV_FAILED
> >> indicates that the kernel failed to handle the event.
> >>
> >> Consequently, when an error occurs during kernel booting, the kernel is
> >> unable to handle and report errors until the GHES driver is initialized
> >> by device_initcall(), in which the event callback is registered.  For
> >> example, when the kernel booting, the console logs many times from
> >> firmware before GHES drivers init in our platform:
> >>
> >> 	Trip in MM PCIe RAS handle(Intr:910)
> >>   	Clean PE[1.1.1] ERR_STS:0x4000100 -> 0 INT_STS:F0000000
> >> 	Find RP(98:1.0)
> >> 	--Walk dev(98:1.0) CE:0 UCE:4000
> >> 	...
> >> 	ERROR:   sdei_dispatch_event(32a) ret:-1
> >> 	--handler(910) end
> > 
> > If I understand correctly, the firmware noticed an error, tried to
> > report it to the kernel, and is complaining because the kernel isn't
> > ready to handle it yet.  And the reason for this patch is to reduce
> > these complaints from the firmware.
> 
> My thoughts exactly :)
> 
> > That doesn't seem like a very good reason for this patch.  There is
> > *always* a window before the kernel is ready to handle events from the
> > firmware.
> 
> Yes, there is always a window. But if we could do better in kernel that
> reduces the window by 90% (from 33 seconds to 3 second), why not?
> 
> > Why is the firmware noticing these errors in the first place?  If
> > you're seeing these complaints regularly, my guess is that either you
> > have some terrible hardware or (more likely) the firmware isn't
> > clearing some expected error condition correctly.  For example, maybe
> > the Unsupported Request errors that happen while enumerating PCIe
> > devices are being reported.
> >
> > If you register the callback function, the kernel will now start
> > seeing these error reports.  What happens then?  Does the kernel log
> > the errors somewhere?  Is that better than the current situation where
> > the firmware logs them?
> 
> Yep, it is a hardware issue. The firmware only logs in console
> (ttyAMA0) and we can not see it in kernel side. After the kernel
> starts seeing these error reports, we could see EDAC/ghes and
> efi/cper detailed logs in dmesg. We did not notice the problem until
> we check the console log, which inspired us to reduce the window
> when kernel startup, so that we can see the message clearly and
> properly. I think the intuition is to check the log of dmesg, not
> the console.

> > However, I DO think that:
> > 
> >   - Removing acpi_hest_init() from acpi_pci_root_init(), and
> > 
> >   - Converting ghes_init() and sdei_init() from initcalls to explicit
> >     calls
> > 
> > are very good reasons to do something like this patch because HEST is
> > not PCI-specific, and IMO, explicit calls are better than initcalls
> > because initcall ordering is implicit and not well-defined within a
> > level.
> 
> Haha, if the above reasons still don't convince you, I would like to
> accept yours :) Should we do it in one patch or separate it into two
> patches?

IMO, this can be done in one patch, but this would probably go via
Rafael.

> >> -static int __init ghes_init(void)
> >> +void __init ghes_init(void)
> >>  {
> >>  	int rc;
> >>  
> >>  	if (acpi_disabled)
> >> -		return -ENODEV;
> >> +		return;
> >>  
> >>  	switch (hest_disable) {
> >>  	case HEST_NOT_FOUND:
> >> -		return -ENODEV;
> >> +		pr_info(GHES_PFX "HEST is not found!\n");
> > 
> > I don't know whether this "HEST is not found" message is
> > worthwhile or not.  I don't think lack of an HEST is an error, and
> > users may be alarmed.  But this is an ACPI thing, so up to you and
> > Rafael.
> 
> If we explicit call ghes_init(), we can't tell if ghes is
> initialized successfully based on the return value of initcall. So I
> add a info message.

When ghes_init() is an initcall and you return -ENODEV for the
HEST_NOT_FOUND case, I don't think we log any message about that, do
we?  do_one_initcall() will capture and return the -ENODEV, but the
caller (do_initcall_level()) just ignores it.

> >> @@ -1495,8 +1494,7 @@ static int __init ghes_init(void)
> >>  	else
> >>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
> >>  
> >> -	return 0;
> >> +	return;
> >>  err:
> >> -	return rc;
> >> +	ghes_disable = 1;
> > 
> > Why do you set ghes_disable here?  As far as I can tell, we will never
> > look at it again.  The places we do look at it are:
> > 
> >   - ghes_init(): earlier in this function, so we've already done that,
> > 
> >   - acpi_hest_init(): we've already called that, too, and
> > 
> >   - acpi_bus_osc_negotiate_platform_control(): called from
> >     acpi_bus_init(), which we've already called.
> 
> I add it for future potential usage. Thank you for pointing it out.
> If you think it is not necessary, I will delete it in next version.

I think it is not necessary to save information that will never be
used.  If you need it in the future, you can add it and the reason
will be obvious.

Bjorn

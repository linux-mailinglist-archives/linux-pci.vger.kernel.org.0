Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E576495247
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376957AbiATQYj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 20 Jan 2022 11:24:39 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:38688 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376968AbiATQYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 11:24:36 -0500
Received: by mail-qt1-f173.google.com with SMTP id j16so2633949qtr.5;
        Thu, 20 Jan 2022 08:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K4LYhqSWqSNuiVXiClJzV7bn+HnGpoOT567DraNrN9c=;
        b=jmf8w+gGCtZwIGjfWXWxkLO4N+cY1knFKloNzcN9tbk8pTgiU85M8kMW9jVPrRyLnO
         x0ko5QLqNSPoXedXolbTzhdmkfUM/b+2Bw89LcDKg3VGCnKCuyWX80nQWntIwncAiOWE
         BJDapPY5ghjAQDOk4pBEvWykapzIVu70x0DlgYfGQwqnLeg5jh/Q+wXvLZi4T2aPPWI/
         ndk/D5vvmNY3q3s1/m5PJ/tmJgidgAcDTfHvYdKjd4HjguaaBlQYyFgsGubvrVsGCdXG
         VxGrVp+RcIkpAIfiVSvjMrReAGn2IjXkvIxJl53FtD25/eZBq+Jco8D+7dx6m5dGvoCB
         DUKg==
X-Gm-Message-State: AOAM53281bAkz6NNtwqtun28edgSoBDck23hrraeWiPdMWyRWEjBGP+5
        Su4A36AlD0J0uTM0u69xSRU4mHF88LrkKlUhL+o=
X-Google-Smtp-Source: ABdhPJwGcK5RjXPVqFEqsR1iHUpWItJCutLCW24ebFjYzfQGKAYGBWGmBy2x8T9ANApcM7Kj7NYYGbeMVFgKGkY0zww=
X-Received: by 2002:ac8:578d:: with SMTP id v13mr14866971qta.472.1642695875395;
 Thu, 20 Jan 2022 08:24:35 -0800 (PST)
MIME-Version: 1.0
References: <e57cc874-dacd-912d-4282-3cb6b1b77323@linux.alibaba.com> <20220119204259.GA962224@bhelgaas>
In-Reply-To: <20220119204259.GA962224@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jan 2022 17:24:24 +0100
Message-ID: <CAJZ5v0j34en1bCZamSGA9XgC-VZRgLgiA89o060_FAWWf21Byw@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: Move sdei_init and ghes_init ahead to handle
 platform errors earlier
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        luanshi <zhangliguang@linux.alibaba.com>,
        zhuo.song@linux.alibaba.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 9:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 19, 2022 at 02:40:11PM +0800, Shuai Xue wrote:
> > [+to Rafael, question about HEST/GHES/SDEI init]
> >
> > Hi, Bjorn,
> >
> > Thank you for your comments and quick reply.
> >
> > 在 2022/1/19 AM6:49, Bjorn Helgaas 写道:
> > > On Sun, Jan 16, 2022 at 04:43:10PM +0800, Shuai Xue wrote:
> > >> On an ACPI system, ACPI is initialised very early from a
> > >> subsys_initcall(), while SDEI is not ready until a
> > >> subsys_initcall_sync(). This patch is to reduce the time before GHES
> > >> initialization.
> > >>
> > >> The SDEI driver provides functions (e.g. apei_sdei_register_ghes(),
> > >> apei_sdei_unregister_ghes()) to register or unregister event callback
> > >> for dispatcher in firmware. When the GHES driver probing, it registers
> > >> the corresponding callback according to the notification type specified
> > >> by GHES. If the GHES notification type is SDEI, the GHES driver will
> > >> call apei_sdei_register_ghes() to register event call.
> > >>
> > >> When the firmware emits an event, it migrates the handling of the event
> > >> into the kernel at the registered entry-point __sdei_asm_handler. And
> > >> finally, the kernel will call the registered event callback and return
> > >> status_code to indicate the status of event handling. SDEI_EV_FAILED
> > >> indicates that the kernel failed to handle the event.
> > >>
> > >> Consequently, when an error occurs during kernel booting, the kernel is
> > >> unable to handle and report errors until the GHES driver is initialized
> > >> by device_initcall(), in which the event callback is registered.  For
> > >> example, when the kernel booting, the console logs many times from
> > >> firmware before GHES drivers init in our platform:
> > >>
> > >>    Trip in MM PCIe RAS handle(Intr:910)
> > >>    Clean PE[1.1.1] ERR_STS:0x4000100 -> 0 INT_STS:F0000000
> > >>    Find RP(98:1.0)
> > >>    --Walk dev(98:1.0) CE:0 UCE:4000
> > >>    ...
> > >>    ERROR:   sdei_dispatch_event(32a) ret:-1
> > >>    --handler(910) end
> > >
> > > If I understand correctly, the firmware noticed an error, tried to
> > > report it to the kernel, and is complaining because the kernel isn't
> > > ready to handle it yet.  And the reason for this patch is to reduce
> > > these complaints from the firmware.
> >
> > My thoughts exactly :)
> >
> > > That doesn't seem like a very good reason for this patch.  There is
> > > *always* a window before the kernel is ready to handle events from the
> > > firmware.
> >
> > Yes, there is always a window. But if we could do better in kernel that
> > reduces the window by 90% (from 33 seconds to 3 second), why not?
> >
> > > Why is the firmware noticing these errors in the first place?  If
> > > you're seeing these complaints regularly, my guess is that either you
> > > have some terrible hardware or (more likely) the firmware isn't
> > > clearing some expected error condition correctly.  For example, maybe
> > > the Unsupported Request errors that happen while enumerating PCIe
> > > devices are being reported.
> > >
> > > If you register the callback function, the kernel will now start
> > > seeing these error reports.  What happens then?  Does the kernel log
> > > the errors somewhere?  Is that better than the current situation where
> > > the firmware logs them?
> >
> > Yep, it is a hardware issue. The firmware only logs in console
> > (ttyAMA0) and we can not see it in kernel side. After the kernel
> > starts seeing these error reports, we could see EDAC/ghes and
> > efi/cper detailed logs in dmesg. We did not notice the problem until
> > we check the console log, which inspired us to reduce the window
> > when kernel startup, so that we can see the message clearly and
> > properly. I think the intuition is to check the log of dmesg, not
> > the console.
>
> > > However, I DO think that:
> > >
> > >   - Removing acpi_hest_init() from acpi_pci_root_init(), and
> > >
> > >   - Converting ghes_init() and sdei_init() from initcalls to explicit
> > >     calls
> > >
> > > are very good reasons to do something like this patch because HEST is
> > > not PCI-specific, and IMO, explicit calls are better than initcalls
> > > because initcall ordering is implicit and not well-defined within a
> > > level.
> >
> > Haha, if the above reasons still don't convince you, I would like to
> > accept yours :) Should we do it in one patch or separate it into two
> > patches?
>
> IMO, this can be done in one patch, but this would probably go via
> Rafael.

Yes, that would make sense IMO.

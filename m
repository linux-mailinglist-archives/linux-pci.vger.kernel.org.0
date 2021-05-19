Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351BC3894A2
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbhESR3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 13:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242522AbhESR3k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 May 2021 13:29:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91299610A2;
        Wed, 19 May 2021 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621445299;
        bh=bA4Stah1HCjZh88A5SXnso641+/xsmALqMYhpYKD3qM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WeXbmHC18+7nhK1KF+FWohkdeV4cRRsBClb+aYV2QfPVRzyhcCIGYK0wsSVezAe2B
         T0rOj2xydvj9fkaIHYquiKq+4XgBlwIMHedZ3rlPg2Xi4jIUFCVYoq+WXsXO7u4k/E
         6JhO9ePxCl7odsL5b9m6+4hcoKWQx+AGbfm5e6RHVSsRuaz3u0Ixgb/UssovjKpaFA
         dT9fXhZByvi4NxhpVczoZpl/8ILumjsoVBqvcQMk0In+9uvHoYTiK0hRErc86tYGVM
         wMzR6APU+TZ8j3lGlUWVQgCmt1qb44UO2cDPWOhyLasPy/6N0dpfdm8oHXg6TukC9/
         nyfNQU0x8ebXg==
Date:   Wed, 19 May 2021 12:28:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210519172818.GA46184@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ddea02fc6d37f7c444a1e90c9f03d7656ffe957.camel@yandex.ru>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 07, 2021 at 05:08:42PM +0300, Konstantin Kharlamov wrote:
> On Fri, 2021-05-07 at 08:30 -0500, Bjorn Helgaas wrote:
> > On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> > > On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > > longer being detected, and dmesg having errors like:
> > > > > 
> > > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > > (config space inaccessible)
> > > > > 
> > > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > > powers off does not get powered on back on resume.

> > For example, "With s2idle, the machine isn't suspended via ACPI, so
> > the AML code which powers the controller off isn't executed."  AFAICT
> > that isn't actually a required, documented property of s2idle, but
> > rather it reaches into the internal implementation.

> > The code comment "If suspend mode is s2idle, power won't get restored
> > on resume" is similar.  !pm_suspend_via_firmware() tells us that
> > platform firmware won't be invoked.  But the connection between *that*
> > and "power won't get restored" is unexplained.
> 
> Sorry, I can't comment anything regarding AML and power management
> in general since I am really new to all of this. However, regarding
> the usage of the `pm_suspend_via_firmware()`: yeah, I also think it
> is unclear what this does, and I was thinking about adding a wrapper
> function something like `is_s2idle()` to the suspend.h, which would
> simply call `pm_suspend_via_firmware` internally.

No, that's not my point at all.  I don't really care whether the
interface is called pm_suspend_via_firmware() or is_s2idle().

What I don't like about this is that it's all just unexplained magic,
as was the original quirk.

IIUC, the quirk is applied by pci_pm_suspend_noirq() *after* it puts
the device in a low-power state.  Here's my uninformed speculation
about what happens:

  - On suspend, pci_pm_suspend_noirq() puts device in low-power state.
    My *guess* is this means D0 or D3hot for s2idle, and D3cold for
    everything else.  [Do we have sufficient debug to find out what
    these states are?]

  - pci_pm_suspend_noirq() does pci_fixup_suspend_late fixups,
    including quirk_apple_poweroff_thunderbolt().

  - quirk_apple_poweroff_thunderbolt() runs the magic SXIO/SXFP/SXLF
    methods, which apparently turn off more power.

  - On resume, pci_pm_resume_noirq() brings the device back to D0.

    If we're resuming from standby, S2RAM, or STD, I speculate the
    device is in D3cold, so this involves running AML that seems to
    undo whatever SXIO/SXFP/SXLF did.

    If we're resuming from s2idle, I speculate the device is in D0 or
    D3hot, and we run different AML (or maybe no AML at all), and we
    *don't* undo the effects of SXIO/SXFP/SXLF, so the device doesn't
    work.

If the above is anything like what's happening, we should be able to
skip SXIO/SXFP/SXLF based on the current power state of the device.
E.g., if the device is in D0 or D3hot, we should not use
SXIO/SXFP/SXLF to yank power.

That would seem more connected to the observable state of the device
than using pm_suspend_via_firmware(), which relies on the connection
between s2idle and PM_SUSPEND_FLAG_FW_SUSPEND (which is not at all
obvious) and the power state of the device while in s2idle (also not
obvious).

Bjorn

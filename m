Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7053D37662F
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 15:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhEGNbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 09:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234545AbhEGNbE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 09:31:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE136143F;
        Fri,  7 May 2021 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620394204;
        bh=jDI2Bu7CUpnqevg3zWlNP1RkgW/z27jhkmXyGiyoB3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XYO0wBl1jMfeYjHkRoscjlABQS3e1mCVZRKy3PMMCqM7niOajPHHAC+bVCqA9jd/5
         tjYnJhzfHfyCJ+svdE7kBxG2RmG5uuovGDx6q/syNzmreeHBd0cItP+IRjUKo5C/HD
         TFfIgIoIKrXKItriITc9y1dw4VknPYHn+LSNVOX9h0dKTmPw2PcXSDFTENktGTA4fU
         Aije5cNPbHpAsNaRJgMI3HKaiBoiBKJ9Dv2v6YQt43mfNohkfdalur1DlKeBsErBA8
         xKMGuiwpnSSOd8u0pCb21SW6MA+kuTOcg/2Urdl3aoWPgI0wh24Onq1IIwgyCRmSiV
         JLzBy+Nw3ezhg==
Date:   Fri, 7 May 2021 08:30:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210507133002.GA1499665@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506220738.GA2150@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > longer being detected, and dmesg having errors like:
> > > 
> > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> > > 
> > > and a stacktrace. The reason turned out that the hw that the quirk
> > > powers off does not get powered on back on resume.
> > 
> > quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> > ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> > "power is automatically restored before resume," so there must be
> > something special about s2idle that prevents the power-on.
> 
> With s2idle, the machine isn't suspended via ACPI, so the AML code
> which powers the controller off isn't executed.  The dance to prepare
> the controller for power-off consequently isn't necessary but rather
> harmful.
> 
> To get the same power savings as with ACPI suspend, the controller
> needs to be powered off via runtime suspend.  I posted patches for
> that back in 2016.  I'm using them on my laptop, they need some
> polishing and rebasing before I can repost them due to massive
> changes that have happened in the thunderbolt driver in the meantime.
> Without these patches, the controller sucks 1.5W of power in s2idle.
> 
> > Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> > something that wasn't tested back then, or is this problem connected
> > to an s2idle change since then?  Can we identify a commit that
> > introduced this problem?  That would help with backporting or stable
> > tags.
> 
> Yes I believe the quirk predates the introduction of s2idle by a couple
> of years.

In an ideal world, we would know which commit introduced s2idle and
hence the possibility of hitting this bug, and we would add a Fixes:
tag for that commit so we could connect this fix with it.

Apart from that, what I don't like about this (and about the original
1df5172c5c25) is that there's no connection to a spec or to documented
behavior of the device or of suspend/resume.

For example, "With s2idle, the machine isn't suspended via ACPI, so
the AML code which powers the controller off isn't executed."  AFAICT
that isn't actually a required, documented property of s2idle, but
rather it reaches into the internal implementation.

The code comment "If suspend mode is s2idle, power won't get restored
on resume" is similar.  !pm_suspend_via_firmware() tells us that
platform firmware won't be invoked.  But the connection between *that*
and "power won't get restored" is unexplained.

> > > Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks for looking at this!

Bjorn

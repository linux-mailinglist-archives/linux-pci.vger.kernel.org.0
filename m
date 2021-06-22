Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558043B055A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFVNAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 09:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231236AbhFVNAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 09:00:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69C9F6135D;
        Tue, 22 Jun 2021 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624366684;
        bh=MsIXue48g+U6sIDtLdK3UXNuqIBbcFzvvUz0rBjHvdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hx90C9IPTtx7kgLWBWoSFbt7+kMMuLb/zAQr7ZmFTRobqkFoDXc46UIF6Jq84+fOh
         4zyLTs50YFs76pdDT6h8JNdeEjxyv43X4TMUCDUdAFPT7/rOmu/1rCXvqePZ9SSMcq
         03x2UO/EV6yIRA9m3QK8zqs5DyQe09SW3HCNU8ENtbDLAQkH/S/1i0SQoMFn1lfKSh
         WDQHd8vPlP1WUZH0uYAxqUuG58bqcWyB1eoUUGk6OYM5G55JTfAjGux9mpTPKm8JGn
         BF8YeToGeGlDVYn09BgcjSjU7IDfeLqIyADaifhjXxBxshj5Tz1l0VVPSIOBlpJe2U
         WejcNj3yZlnmQ==
Date:   Tue, 22 Jun 2021 07:58:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael <phyre@rogers.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 213481] e1000e
 hardware failure due to PCI patch in all kernels 5.10.36+ with Intel I219-V]
Message-ID: <20210622125802.GA3323179@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gkETL83rm71LiJ8sed=UFn00_Sss8wJ20-+KQiJR0hew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 02:21:06PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 22, 2021 at 12:02 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > FYI.  Looks like 4514d991d992 ("PCI: PM: Do not read power state in
> > pci_enable_device_flags()") appeared in v5.13-rc1, so it would be nice
> > to fix before v5.13.
> 
> I think let's revert it for now and revisit.

Sounds good.

> Do you want me to push the revert?

Sure, it'd be great if you could.  I'm traveling and don't have as
much time as usual this week.  Thanks!

> > https://bugzilla.kernel.org/show_bug.cgi?id=213481
> >
> > Initial report:
> >
> >   On the 4.19 kernel, this works perfect.  It also works perfectly in
> >   Windows.  If I reboot into 4.19, there is no problem with networking,
> >   however in 5.10, there is ZERO network connectivity.  The link NEVER
> >   comes up.  You can't assign an IP address to the interface.
> >
> >
> > From comment #2:
> >
> >   If I revert commit 4514d991d99211f225d83b7e640285f29f0755d0 (
> >   https://github.com/torvalds/linux/commit/4514d991d99211f225d83b7e640285f29f0755d0)
> >   from the 5.10.36 kernel, I do NOT have this hardware failure
> >   message.  This commit relates to PCI power state.
> >
> >   It would appear something about this change that the e1000e driver
> >   is not handling properly on this system, causing the card to not
> >   work.
> >
> >   As mentioned this is in current kernel versions (5.13, 5.11, and
> >   5.10.36+).  Given that this is a regression, a breaking change for
> >   the usability of these cards, and we know exactly what causes it for
> >   a hopefully easy fix, I've upped the severity.

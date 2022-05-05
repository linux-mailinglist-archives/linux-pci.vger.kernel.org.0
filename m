Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109B051BEB4
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359201AbiEEMCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 08:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiEEMCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 08:02:08 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC94854F9A;
        Thu,  5 May 2022 04:58:28 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id e12so7171256ybc.11;
        Thu, 05 May 2022 04:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdpkfPpjlgj+BjtkQkQRFzNPoUnYFAkYolYnzJCRfGg=;
        b=WS9wYLWRQjRbPba/RC0Ugqw9UAU4RcCkCsdBpbHzI5dX3dg40gJ4v7IKbK9u3HC34N
         QBZ8bRrdeRdYP1z/7fUmVVfxYxF7towx5IhPt7GDDH0EanOyQj4j6D3pmrKIFMZViPLi
         TX91+FXmXrRf0jpqR0bOqmLOsbjQO8QODS5Nt7xy0YFTmoKyfjUsAV9b8gBQ5tcCieWg
         eDCk0IWXvPLqcykTYVgsSv1uorCBiAYk9vtWcmrBwzIO7I41uMb7UwqmGpUz7e/RI2eA
         4g4niS6TJ+DraarLfyCLRki+aPIEhlBx2xVtxuGtYmPkJpL2HlgjotseWUFl8JPzpU9V
         qvnQ==
X-Gm-Message-State: AOAM530chs80aB1rHKqCRH0tGXyrzBh6wpXv5jOWCokGNHOa4VEdtuST
        Plcg3HrjSedUuickx6qqf0jwAWFV7GSwjAQ627wCL4WW
X-Google-Smtp-Source: ABdhPJzik3aLC1FIebu4+vOjKc8Q7bVB0QF3GEbyurQXIQeWK+r2oHOfyjQdhBmQeBK/u3Vjnem9d+vlMvL9iufFdZU=
X-Received: by 2002:a25:3795:0:b0:648:fa25:5268 with SMTP id
 e143-20020a253795000000b00648fa255268mr22539195yba.153.1651751908074; Thu, 05
 May 2022 04:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <4419002.LvFx2qVVIh@kreacher> <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
 <YnKrcFSjLr+W+myL@dev-arch.thelio-3990X> <2650302.mvXUDI8C0e@kreacher> <YnLVgOqGOPaSrC7G@dev-arch.thelio-3990X>
In-Reply-To: <YnLVgOqGOPaSrC7G@dev-arch.thelio-3990X>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 May 2022 13:58:17 +0200
Message-ID: <CAJZ5v0i85XEjMKOPrHGCqgW526eqVDH_26mMsmZBJOj0dtStoA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI devices
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 4, 2022 at 9:35 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 08:00:33PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, May 4, 2022 6:36:00 PM CEST Nathan Chancellor wrote:
> > > On Wed, May 04, 2022 at 02:59:17PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, May 3, 2022 at 7:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > There are some issues related to changing power states of PCI
> > > > > > devices, mostly related to carrying out unnecessary actions in some
> > > > > > places, and the code is generally hard to follow.
> > > > > >
> > > > > >  1. pci_power_up() has two callers, pci_set_power_state() and
> > > > > >     pci_pm_default_resume_early().  The latter updates the current
> > > > > >     power state of the device right after calling pci_power_up()
> > > > > >     and it restores the entire config space of the device right
> > > > > >     after that, so pci_power_up() itself need not read the
> > > > > >     PCI_PM_CTRL register or restore the BARs after programming the
> > > > > >     device into D0 in that case.
> > > > > >
> > > > > >  2. It is generally hard to get a clear view of the pci_power_up()
> > > > > >     code flow, especially in some corner cases, due to all of the
> > > > > >     involved PCI_PM_CTRL register reads and writes occurring in
> > > > > >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> > > > > >     some of which are redundant.
> > > > > >
> > > > > >  3. The transitions from low-power states to D0 and the other way
> > > > > >     around are unnecessarily tangled in pci_raw_set_power_state()
> > > > > >     which causes it to use a redundant local variable and makes it
> > > > > >     rather hard to follow.
> > > > > >
> > > > > > To address the above shortcomings, make the following changes:
> > > > > >
> > > > > >  a. Remove the code handling transitions into D0
> > > > > >     from pci_raw_set_power_state() and rename it as
> > > > > >     pci_set_low_power_state().
> > > > > >
> > > > > >  b. Add the code handling transitions into D0 directly
> > > > > >     to pci_power_up() and to a new wrapper function
> > > > > >     pci_set_full_power_state() calling it internally that is
> > > > > >     only used in pci_set_power_state().
> > > > > >
> > > > > >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> > > > > >     and make it work in the same way for transitions from any
> > > > > >     low-power states (transitions from D1 and D2 are handled
> > > > > >     slightly differently before the change).
> > > > > >
> > > > > >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> > > > > >     register read confirming the power state change into
> > > > > >     pci_set_full_power_state() to avoid doing that in
> > > > > >     pci_pm_default_resume_early() unnecessarily.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > >
> > > > > This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> > > > > states of PCI devices") causes my AMD-based system to fail to fully
> > > > > boot. As far as I can tell, this might be NVMe related, which might make
> > > > > getting a full log difficult, as journalctl won't have anywhere to save
> > > > > it. I see:
> > > > >
> > > > > nvme nvme0: I/O 8 QID 0 timeout, completion polled
> > > > >
> > > > > then shortly afterwards:
> > > > >
> > > > > nvme nvme0: I/O 24 QID 0 timeout, completion polled
> > > > > nvme nvme0: missing or invalid SUBNQN field
> > > > >
> > > > > then I am dropped into an emergency shell.
> > > >
> > > > Thanks for the report!
> > > >
> > > > > This is a log from the previous commit, which may give some hints about
> > > > > the configuration of this particular system.
> > > > >
> > > > > https://gist.github.com/nathanchance/8a56f0939410cb187896e904c72e41e7/raw/b47b2620bdd32d43c7a3b209fcfd9e3d4668f058/good-boot.log
> > > > >
> > > > > If there is any additional debugging information I can provide or
> > > > > patches I can try, please let me know!
> > > >
> > > > Please see what happens if the "if (dev->current_state == PCI_D0)"
> > > > check and the following "return 0" statement in pci_power_up() are
> > > > commented out.
> > >
> > > If I understand you correctly, this? Unfortunately, that does not help.
> >
> > Thanks for testing.
> >
> > Please check if the patch below makes any difference.
>
> Unfortunately, there is still no difference. Even worse, I thought I
> might be able to get some information from the emergency shell but I
> don't think the HID driver is loaded yet so my keyboard does not work. I
> am not sure of how to get any further information from the problematic
> kernel; if anyone has any ideas, I am happy to test them! I am more than
> happy to continue to test patches or provide information, I just don't
> want to be a waste of time :)

It's not a waste of time if you run tests I ask for.

Anyway, I'm going to change the approach, because we're looking for a
subtle change in behavior that breaks your system and there are quite
a few of these in the problematic patch.

I'll post a new series of patches to replace the commits dropped by
Bjorn later today.

Thanks!

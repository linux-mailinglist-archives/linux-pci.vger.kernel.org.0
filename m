Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F199751A01D
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiEDNDF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiEDNDE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 09:03:04 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC703BFBF;
        Wed,  4 May 2022 05:59:28 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id f38so2233591ybi.3;
        Wed, 04 May 2022 05:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmvxIQHG/ljLt51DjNy57CzPAA1TYfJjkUMDlKRN2cw=;
        b=SfjjF1dfuEKuRJMWiDZvsj94oyQ0i+I3oOECAT+stn1MnUhZRhDjizIDBibra7sN00
         DJy1I347O5t54FAyuZ0gkLt5XfITqcKgkxi5aa+78E5xEhFv0HFh/oiaYrO4Yzv8LGf9
         uApgEeoLrvNEutl0ZluIcIUGwXR87rXKjefJgFmmQQJrKRa+8TXhjleNWnSl+MnTpOqq
         Jis9meyBZCE9k/UyqSxKFgf6aXFgrIYO2zuzx9CJUjZHVWB7ZPO6NgmZyAnqhertr63X
         7T+2vzXOpt0crXgvoOKa71bVjssawjhMruTTKL5goxc+X8p6XDWHbW67aIDHI/9+3cMe
         FyeA==
X-Gm-Message-State: AOAM531vXSJO8DITv5b9o+tCxMoR2VnX5qDuSD4/R5LgIThCKpvt5j4/
        I4eb+7d4y3KMGWSs5NFd4bIFlh0IstzvUFYrr1B21oZ39L8=
X-Google-Smtp-Source: ABdhPJzXVZ/1w3GPYeCO2dkamDxMnp8QXC2QHFPATCMzTrRgP9tKaW861v6nF7Uy5dyU4a+K22nPQzaM4JHk+ZqMOW8=
X-Received: by 2002:a05:6902:100e:b0:649:7385:5e68 with SMTP id
 w14-20020a056902100e00b0064973855e68mr11693394ybt.622.1651669167783; Wed, 04
 May 2022 05:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher>
 <5838942.lOV4Wx5bFT@kreacher> <3687697.kQq0lBPeGt@kreacher> <YnFtjzGYwe28tVAA@dev-arch.thelio-3990X>
In-Reply-To: <YnFtjzGYwe28tVAA@dev-arch.thelio-3990X>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 May 2022 14:59:17 +0200
Message-ID: <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI devices
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, May 3, 2022 at 7:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Rafael,
>
> On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are some issues related to changing power states of PCI
> > devices, mostly related to carrying out unnecessary actions in some
> > places, and the code is generally hard to follow.
> >
> >  1. pci_power_up() has two callers, pci_set_power_state() and
> >     pci_pm_default_resume_early().  The latter updates the current
> >     power state of the device right after calling pci_power_up()
> >     and it restores the entire config space of the device right
> >     after that, so pci_power_up() itself need not read the
> >     PCI_PM_CTRL register or restore the BARs after programming the
> >     device into D0 in that case.
> >
> >  2. It is generally hard to get a clear view of the pci_power_up()
> >     code flow, especially in some corner cases, due to all of the
> >     involved PCI_PM_CTRL register reads and writes occurring in
> >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> >     some of which are redundant.
> >
> >  3. The transitions from low-power states to D0 and the other way
> >     around are unnecessarily tangled in pci_raw_set_power_state()
> >     which causes it to use a redundant local variable and makes it
> >     rather hard to follow.
> >
> > To address the above shortcomings, make the following changes:
> >
> >  a. Remove the code handling transitions into D0
> >     from pci_raw_set_power_state() and rename it as
> >     pci_set_low_power_state().
> >
> >  b. Add the code handling transitions into D0 directly
> >     to pci_power_up() and to a new wrapper function
> >     pci_set_full_power_state() calling it internally that is
> >     only used in pci_set_power_state().
> >
> >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> >     and make it work in the same way for transitions from any
> >     low-power states (transitions from D1 and D2 are handled
> >     slightly differently before the change).
> >
> >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> >     register read confirming the power state change into
> >     pci_set_full_power_state() to avoid doing that in
> >     pci_pm_default_resume_early() unnecessarily.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> states of PCI devices") causes my AMD-based system to fail to fully
> boot. As far as I can tell, this might be NVMe related, which might make
> getting a full log difficult, as journalctl won't have anywhere to save
> it. I see:
>
> nvme nvme0: I/O 8 QID 0 timeout, completion polled
>
> then shortly afterwards:
>
> nvme nvme0: I/O 24 QID 0 timeout, completion polled
> nvme nvme0: missing or invalid SUBNQN field
>
> then I am dropped into an emergency shell.

Thanks for the report!

> This is a log from the previous commit, which may give some hints about
> the configuration of this particular system.
>
> https://gist.github.com/nathanchance/8a56f0939410cb187896e904c72e41e7/raw/b47b2620bdd32d43c7a3b209fcfd9e3d4668f058/good-boot.log
>
> If there is any additional debugging information I can provide or
> patches I can try, please let me know!

Please see what happens if the "if (dev->current_state == PCI_D0)"
check and the following "return 0" statement in pci_power_up() are
commented out.

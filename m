Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024351A59E
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 18:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiEDQjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiEDQjm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 12:39:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94C2DA85;
        Wed,  4 May 2022 09:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486F8B82794;
        Wed,  4 May 2022 16:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866ADC385A4;
        Wed,  4 May 2022 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651682163;
        bh=dK7q7nPy0C7TXwDvFGlFHBLcvJkYagL5iuU1SwZwUEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+qEAp9wvvYjGY3G6rPO1gIG9p21+rkwpON8Aqu7OFeYX0/htK+Ecy4pEwD6g/vgA
         m2D6FJi4wyAawscxf8prCDBPlfb2abE8gTNg1ya7RO2DAnBei7qBYYAF8VflK1o9td
         Buu5FvHWSAAlVdp62ipgAsy9deUOe6ZrcfNgOK4gN0O8rRgoIZ9L3emnVjlaWkU5sp
         ybJtyXed31dmNtEtpOayJNB1u6pBEDUgxU2pvjRDBK7WqcwDFs57/yahJ//FGZ/FzX
         36lcPfAgtrMrFjsgKUQIxO+cPHUdoMCd9ZKSXGmsmzlwRTotbOTs0EMtDgEr87dmNp
         +AtSjHAAQUflg==
Date:   Wed, 4 May 2022 09:36:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI
 devices
Message-ID: <YnKrcFSjLr+W+myL@dev-arch.thelio-3990X>
References: <4419002.LvFx2qVVIh@kreacher>
 <11975904.O9o76ZdvQC@kreacher>
 <5838942.lOV4Wx5bFT@kreacher>
 <3687697.kQq0lBPeGt@kreacher>
 <YnFtjzGYwe28tVAA@dev-arch.thelio-3990X>
 <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 02:59:17PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 3, 2022 at 7:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Rafael,
> >
> > On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There are some issues related to changing power states of PCI
> > > devices, mostly related to carrying out unnecessary actions in some
> > > places, and the code is generally hard to follow.
> > >
> > >  1. pci_power_up() has two callers, pci_set_power_state() and
> > >     pci_pm_default_resume_early().  The latter updates the current
> > >     power state of the device right after calling pci_power_up()
> > >     and it restores the entire config space of the device right
> > >     after that, so pci_power_up() itself need not read the
> > >     PCI_PM_CTRL register or restore the BARs after programming the
> > >     device into D0 in that case.
> > >
> > >  2. It is generally hard to get a clear view of the pci_power_up()
> > >     code flow, especially in some corner cases, due to all of the
> > >     involved PCI_PM_CTRL register reads and writes occurring in
> > >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> > >     some of which are redundant.
> > >
> > >  3. The transitions from low-power states to D0 and the other way
> > >     around are unnecessarily tangled in pci_raw_set_power_state()
> > >     which causes it to use a redundant local variable and makes it
> > >     rather hard to follow.
> > >
> > > To address the above shortcomings, make the following changes:
> > >
> > >  a. Remove the code handling transitions into D0
> > >     from pci_raw_set_power_state() and rename it as
> > >     pci_set_low_power_state().
> > >
> > >  b. Add the code handling transitions into D0 directly
> > >     to pci_power_up() and to a new wrapper function
> > >     pci_set_full_power_state() calling it internally that is
> > >     only used in pci_set_power_state().
> > >
> > >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> > >     and make it work in the same way for transitions from any
> > >     low-power states (transitions from D1 and D2 are handled
> > >     slightly differently before the change).
> > >
> > >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> > >     register read confirming the power state change into
> > >     pci_set_full_power_state() to avoid doing that in
> > >     pci_pm_default_resume_early() unnecessarily.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> > states of PCI devices") causes my AMD-based system to fail to fully
> > boot. As far as I can tell, this might be NVMe related, which might make
> > getting a full log difficult, as journalctl won't have anywhere to save
> > it. I see:
> >
> > nvme nvme0: I/O 8 QID 0 timeout, completion polled
> >
> > then shortly afterwards:
> >
> > nvme nvme0: I/O 24 QID 0 timeout, completion polled
> > nvme nvme0: missing or invalid SUBNQN field
> >
> > then I am dropped into an emergency shell.
> 
> Thanks for the report!
> 
> > This is a log from the previous commit, which may give some hints about
> > the configuration of this particular system.
> >
> > https://gist.github.com/nathanchance/8a56f0939410cb187896e904c72e41e7/raw/b47b2620bdd32d43c7a3b209fcfd9e3d4668f058/good-boot.log
> >
> > If there is any additional debugging information I can provide or
> > patches I can try, please let me know!
> 
> Please see what happens if the "if (dev->current_state == PCI_D0)"
> check and the following "return 0" statement in pci_power_up() are
> commented out.

If I understand you correctly, this? Unfortunately, that does not help.

Cheers,
Nathan

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1e22dc5187e7..9f7a463107f3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1235,8 +1235,10 @@ int pci_power_up(struct pci_dev *dev)
 	}
 
 	/* There's nothing more to do if current_state is D0 at this point. */
+#if 0
 	if (dev->current_state == PCI_D0)
 		return 0;
+#endif
 
 	/*
 	 * Program the device into PCI_D0 by forcing the entire word to 0 (this

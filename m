Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C1536920
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiE0XJ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 19:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbiE0XJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 19:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CC128142;
        Fri, 27 May 2022 16:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 417B561A25;
        Fri, 27 May 2022 23:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D241C385A9;
        Fri, 27 May 2022 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653692965;
        bh=1rzN+bAWacln+c9+oIr/WfPrvgFyPswcn+/x5ki1D8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XQfOP1oBjn+bSTPwmvl9rp7HhYMlS0BRHzG91S8KF+qoR4NBBiNOeOSNYYo1GL3DM
         d7ojVNwW8tc/QBvqrQERHd88uZVeeICoUAcnfcKOJDqwIcjJB0kracHA/ImhsPamQU
         EWwReyPcUISEC5iOsKaObv5kF+h7HBGNIuzkxwhfFWMjHKWTpjlsFjkEzYZ7PEEOyU
         SpTGgEhanhmpPC9XCuU62htqF7YB2F8chg59pJj8P9BN4oUHKDn7nVluw08Dyaa1i5
         M8Cii+iOfK3fvf6Mlk6AIziqN4tbQrYJR6yxJ2m5jWd/xVvHVM2Eo9sCgJ8XvJktkY
         bfT3FZDlc9UuA==
Date:   Fri, 27 May 2022 18:09:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v1 06/11] PCI/PM: Write 0 to PMCSR in pci_power_up() in
 all cases
Message-ID: <20220527230923.GA513506@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527225148.GA511276@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 27, 2022 at 05:51:48PM -0500, Bjorn Helgaas wrote:
> On Fri, May 27, 2022 at 08:52:17PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 26, 2022 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Thu, May 26, 2022 at 11:54:22AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, May 05, 2022 at 08:10:43PM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Make pci_power_up() write 0 to the device's PCI_PM_CTRL register in
> > > > > order to put it into D0 regardless of the power state returned by
> > > > > the previous read from that register which should not matter.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/pci/pci.c |   11 +++--------
> > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > >
> > > > > Index: linux-pm/drivers/pci/pci.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/pci/pci.c
> > > > > +++ linux-pm/drivers/pci/pci.c
> > > > > @@ -1230,15 +1230,10 @@ int pci_power_up(struct pci_dev *dev)
> > > > >     }
> > > > >
> > > > >     /*
> > > > > -    * If we're (effectively) in D3, force entire word to 0. This doesn't
> > > > > -    * affect PME_Status, disables PME_En, and sets PowerState to 0.
> > > > > +    * Force the entire word to 0. This doesn't affect PME_Status, disables
> > > > > +    * PME_En, and sets PowerState to 0.
> > > > >      */
> > > > > -   if (state == PCI_D3hot)
> > > > > -           pmcsr = 0;
> > > > > -   else
> > > > > -           pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> > > > > -
> > > > > -   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> > > > > +   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > > >
> > > > Can you reassure me why this is safe and useful?
> > > >
> > > > This is a 16-bit write that includes (PCIe r6.0, sec 7.5.2.2):
> > > >
> > > >   0x0003 PowerState     RW
> > > >   0x0004                RsvdP
> > > >   0x0008 No_Soft_Reset  RO
> > > >   0x00f0                RsvdP
> > > >   0x0100 PME_En         RW/RWS
> > > >   0x1e00 Data_Select    RW, VF ROZ
> > > >   0x6000 Data_Scale     RO, VF ROZ
> > > >   0x8000 PME_Status     RW1CS
> > > >
> > > > We intend to set PowerState to 0 (D0), apparently intend to clear
> > > > PME_En, and PME_Status is "write 1 to clear" to writing 0 does
> > > > nothing, so those look OK.
> > > >
> > > > But the RsvdP fields are reserved for future RW bits and should be
> > > > preserved, and it looks like clearing Data_Select could potentially
> > > > break the Data Register power consumption reporting (which I don't
> > > > think we support today).
> > > >
> > > > It seems like maybe we should do this instead:
> > > >
> > > >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL,
> > > >                         pmcsr & ~PCI_PM_CTRL_STATE_MASK)
> > > >
> > > > to just unconditionally clear PowerState?
> > >
> > > Or I guess this, since we want to clear PME_En as well?
> > >
> > >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr &
> > >                         ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE));
> > 
> > Yes.
> > 
> > Also, this patch actually only makes a difference if the device is
> > going into D0 from D1 or D2, because we have always written 0 to the
> > PMCSR during transitions from D3hot.
> > 
> > It is inconsistent and confusing to do different things depending on
> > the initial power state here and the code is simpler when 0 is written
> > regardless.
> 
> I agree that depending on the initial power state is confusing (it
> confused me :)).
> 
> What would you think of replacing this patch with the one below?

Well, I don't know why I sent this, since I had already sent the pull
request.  Not thinking clearly, I guess.  Anyway, your original patch
is now upstream.  Sorry for the distraction.

Bjorn

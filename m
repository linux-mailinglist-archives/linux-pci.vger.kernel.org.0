Return-Path: <linux-pci+bounces-20737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361EAA28BD0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CA1167A26
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C612EBEA;
	Wed,  5 Feb 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBQxkeON"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA67083D;
	Wed,  5 Feb 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762631; cv=none; b=tmrGgC6mfY6ZAk3EvQ3AvHjFxJEjFvJs/nVwmmbGiA6gmjMh6UwR+GB9/OGEXtDwK0i3ExG+KuZoM7lipNlSEvAiDJYjh+Mmla7E4mFoU3nNOWEx4I9GxIn/h5/ul8pX2XxqdJKJDP7ZlqmaGGpcmy8U0wLf2usLc/G9nLHBiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762631; c=relaxed/simple;
	bh=B6k4QAJLDUjryyKjlAgB+oDtHou0O0lXrrg8YSYtedQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R7Ic1xEAmB5st9bPkZm/b73c1lgiOBIPjOVpvvN4W9DCcV/anYRn5IUtsXxOl/mTIwcPOBz8DrllyehCW5d2/3gZaxHj86I8e8Gv3TG3n4/mEcohEAynqUPhiaZwXOIZRcGwlGEfUxSOMbV+X9rKwL3F1ozYw5vwcYENH7k+VbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBQxkeON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1461EC4CED1;
	Wed,  5 Feb 2025 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738762630;
	bh=B6k4QAJLDUjryyKjlAgB+oDtHou0O0lXrrg8YSYtedQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OBQxkeONvcr2vp3s4gZVJNwDke/0VT1Q6KYvksz7G43Ndfpvb7hKWl7bj7BHUta1U
	 DrqpwyPuTX45nhkfEjtkJicqKtDSx4SOjomlHgFc7BKY7zsD+cUOnESCYNfujpUqJ0
	 HaOqNP9ilb4lA88ECvdWOvdak1ywkkAyr1l8q234KOegb5j1hSLg0jfDEAgMOP4KH6
	 M8QUYGLXh65wn5W/0Ci8f8U1WT8JbxQW7UeUqcBemFF8ECcMGhW2EGVYK5bUcPtObX
	 S/2kQKunZy5RmvL+rsCasO2NpbQiA+MD4VmxvnI96+PTfhTUYF3ypVRpUUihayHm9a
	 fQErmFVrcqzZQ==
Date: Wed, 5 Feb 2025 07:37:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] PCI/ASPM: Fix L1SS saving
Message-ID: <20250205133707.GA910099@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167dfe31-89cb-6135-aafc-ece0cb234daa@linux.intel.com>

On Wed, Feb 05, 2025 at 10:38:24AM +0200, Ilpo Järvinen wrote:
> On Tue, 4 Feb 2025, Bjorn Helgaas wrote:
> 
> > [+cc Rafael]
> > 
> > On Fri, Jan 31, 2025 at 05:29:13PM +0200, Ilpo Järvinen wrote:
> > > The commit 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in
> > > pci_save_aspm_l1ss_state()") aimed to perform L1SS config save for both
> > > the Upstream Port and its upstream bridge when handling an Upstream
> > > Port, which matches what the L1SS restore side does. However,
> > > parent->state_saved can be set true at an earlier time when the
> > > upstream bridge saved other parts of its state. 
> > 
> > So I guess the scenario is that we got here because some driver called
> > pci_save_state(pdev):
> > 
> >   pci_save_state
> >     dev->state_saved = true                <--
> >     pci_save_pcie_state
> >       pci_save_aspm_l1ss_state
> >         if (pcie_downstream_port(pdev))
> >           return
> >         # save pdev L1SS state here
> >         if (parent->state_saved)           <--
> >           return
> >         # save parent L1SS state here
> > 
> > and the problem is that we previously called pci_save_state(parent),
> > which set "parent->state_saved = true" but did not save its L1SS state
> > because pci_save_aspm_l1ss_state() is a no-op for Downstream Ports,
> > right?
> 
> Yes! An unfortunate interaction between those two checks.
> 
> > But I would think this would be a very common situation because
> > pcie_portdrv_probe() calls pci_save_state() for Downstream Ports when
> > pciehp, AER, PME, etc, are enabled, and this would happen before the
> > pci_save_state() calls from Endpoint drivers.
> > 
> > So I'm a little surprised that this didn't blow up for everybody
> > immediately.  Is there something that makes this unusual?
> 
> I agree it should be very common and was quite surprised that -next
> did not catch it. What I recall though is you modified the patch while 
> applying it by adding those Downstream Port checks so the fix 
> patch's Tested-by was for different code from what got applied (and it 
> would have been caught would the original author have tested also the 
> modified commit).

Sigh, that makes sense, it's probably my fault, sorry.  I apologize
for messing this up and causing all this extra work.

I applied this to pci/for-linus yesterday, so it should make it for
v6.14-rc2.

> Unfortunately, I cannot think of anything that would be so unusual to 
> warrant not detecting it earlier. Maybe it was just the holiday period 
> causing less testing and lower level of awareness in general? The machine 
> doesn't always hang because of the problem as was the case with Niklāvs,
> so it might have occurred but went unnoticed if it occurred for a device 
> that is not critical.
> 
> > > Then later when
> > > attempting to save the L1SS config while handling the Upstream Port,
> > > parent->state_saved is true in pci_save_aspm_l1ss_state() resulting in
> > > early return and skipping saving bridge's L1SS config because it is
> > > assumed to be already saved. Later on restore, junk is written into
> > > L1SS config which causes issues with some devices.
> > > 
> > > Remove parent->state_saved check and unconditionally save L1SS config
> > > also for the upstream bridge from an Upstream Port which ought to be
> > > harmless from correctness point of view. With the Upstream Port check
> > > now present, saving the L1SS config more than once for the bridge is no
> > > longer a problem (unlike when the parent->state_saved check got
> > > introduced into the fix during its development).
> > > 
> > > Fixes: 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()")
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219731
> > > Reported-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
> > > Tested-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/pcie/aspm.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index e0bc90597dca..da3e7edcf49d 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -108,9 +108,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > >  	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> > >  	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> > >  
> > > -	if (parent->state_saved)
> > > -		return;
> > > -
> > >  	/*
> > >  	 * Save parent's L1 substate configuration so we have it for
> > >  	 * pci_restore_aspm_l1ss_state(pdev) to restore.
> > > 
> > > base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
> > > -- 
> > > 2.39.5
> > > 
> > 
> 
> -- 
>  i.



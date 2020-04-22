Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3511B50D1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDVXVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 19:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgDVXVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 19:21:30 -0400
Received: from localhost (mobile-166-175-187-227.mycingular.net [166.175.187.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529712076C;
        Wed, 22 Apr 2020 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587597689;
        bh=eQWN3pP46KHM49RJh6DB+rLU7u/InpAf2XNNJk3Uh0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZlR+o4j/dIfsKlG85ZyM/YXf5IjN3j5mL315OQtJva0g0unK7gSvSEvf93zO6/i9D
         RXsaegX5CNyrsxE8zkl9PnrDZXu5bGH8raTLZ40pfFSDEBdGUpy9GmQDya+o6RsQrc
         KS9fX0bRBoDa5BlL1cBbNhSkocIzs8LGohDtrQaQ=
Date:   Wed, 22 Apr 2020 18:21:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, Roy Spliet <nouveau@spliet.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: Unrecoverable AER error when resuming from RAM (hda regression
 in 5.7-rc2)
Message-ID: <20200422232127.GA24666@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8sinxlfz.wl-tiwai@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 22, 2020 at 11:25:04PM +0200, Takashi Iwai wrote:
> On Wed, 22 Apr 2020 22:50:28 +0200,
> Bjorn Helgaas wrote:
> > ...
> > I feel like this UR issue could be a PCI core issue or maybe some sort
> > of misuse of PCI power management, but I can't seem to get traction on
> > it.
> > 
> > > Then the display freezes and the system basically falls apart (can't 
> > > even sudo reboot -f, need to use magic sysrq).
> > > 
> > > I bisected this to "ALSA: hda: Skip controller resume if not needed". 
> > > Setting snd_hda_intel.power_save=0 resolves the issue.
> > 
> > FWIW, the complete citation is c4c8dd6ef807 ("ALSA: hda: Skip
> > controller resume if not needed"),
> > https://git.kernel.org/linus/c4c8dd6ef807, which first appeared in
> > v5.7-rc2.
> 
> Yes, and I posted the fix patch right now:
>   https://lore.kernel.org/r/20200422203744.26299-1-tiwai@suse.de
> 
> The possible cause was the tricky resume code that both HD-audio
> controller (the parent PCI device) and the codec devices used.
> 
> At least the patch above seems working for the reporter's machine.
> Now we need a bit more testing before merging, but it looks promising,
> so far.

Great, I'm glad you figured something out because I sure wasn't
getting anywhere!

Maybe this is a tangent, but I can't figure out what
snd_power_change_state() is doing.  It *looks* like it's supposed to
change the PCI power state, but I gave up trying to figure out where
it actually touches the device.

It seems like sound has more magic in power management than other
device types, which makes me wonder if we're not providing the right
interfaces or something.

Bjorn

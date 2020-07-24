Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955B22C824
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXOfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 10:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXOfv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 10:35:51 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3082065C;
        Fri, 24 Jul 2020 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595601351;
        bh=L7/MwNAWCUFGl5PPjS4I/NXskBIhuh/a8szTHPAtB2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=evvrI1BGgtE+SPkmfhvSpzy6GLmEfaY0aSMDB9mfPSAxpEbjPPEZaef/LG/UBN+r1
         8qLDaag77ZA8ppddFZbsFWU7TXPA2EdzAelblCXO2loDBPVbtbbAnfR+RcaRNO4wO2
         xle9Sz+cT1LnAaOZqG37Pb02PUlPprfbBv/AHLf4=
Date:   Fri, 24 Jul 2020 09:35:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
Message-ID: <20200724143549.GA1516749@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724095751.GU1375436@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 12:57:51PM +0300, Mika Westerberg wrote:
> On Thu, Jul 23, 2020 at 10:30:58PM +0200, Karol Herbst wrote:
> > On Wed, Jul 22, 2020 at 11:25 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Tue, Jul 21, 2020 at 01:37:12PM -0500, Patrick Volkerding wrote:
> > > > On 7/21/20 10:27 AM, Mika Westerberg wrote:
> > > > > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > > > >> Sure thing. Also, feel free to let me know if you'd like access to one of the
> > > > >> systems we saw breaking with this patch - I'm fairly sure I've got one of them
> > > > >> locally at my apartment and don't mind setting up AMT/KVM/SSH
> > > > > Probably no need for remote access (thanks for the offer, though). I
> > > > > attached a test patch to the bug report:
> > > > >
> > > > >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> > > > >
> > > > > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > > > > anyone would have time to try it out.
> > > >
> > > >
> > > > Hi Mika,
> > > >
> > > > I can confirm that this patch applied to 5.4.52 fixes the issue with
> > > > hybrid graphics on the Thinkpad X1 Extreme gen2.
> > >
> > > Great, thanks for testing!
> > 
> > yeah, works on the P1G2 as well.
> 
> Thanks for testing!
> 
> Since we have the revert queued for this release cycle, I think I will
> send an updated version of "PCI/PM: Assume ports without DLL Link Active
> train links in 100 ms" after v5.9-rc1 is released that has this
> workaround in place.
> 
> (I'm continuing my vacation so will be offline next week).

Sounds fine, sorry for interrupting your vacation!

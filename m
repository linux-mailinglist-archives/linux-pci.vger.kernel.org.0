Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0531947633D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhLOU1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 15:27:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33942 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhLOU1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 15:27:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBF97B8212D;
        Wed, 15 Dec 2021 20:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38935C36AE3;
        Wed, 15 Dec 2021 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639600025;
        bh=6STA8726cMv+Duxbu+Wzez636LPBUdJAClqIlVR6PD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RB6iglQmhGkjcRL0PdT2zhyTEeXfSURjjlw/7eT4pm+T+o8gQTcG5jYxRo9iS4lfY
         dUznQIzQ/6G/v+0dUqKft/oOqNI9Nli0+9BSgrRkzHMCXgX8N4wPq7Eol+2lkBRSoh
         CUDXr+HKXwTJIbd9sjWpXzLE4LVxRYujGYkSr9cSl3mT/11rh8oqz/czSG4FEFam3U
         OUtn1bB7nSX+IeUyLToTHR92WayMrNO9a1sAkFG0un/4owzeQF9WYQu6yX/lWo1Rua
         2Et4KwQQ0oxtLq+A+qx0299AE1+xCdcFxoPuUMCwTc45uJC2YYoqWBXT8UaVzwqd5f
         pjhCh5bzNTLNw==
Date:   Wed, 15 Dec 2021 14:27:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatxjain@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>, gwendal@google.com
Subject: Re: [PATCH] pci/quirks: Add quirk for Bayhub O2 SD controller
Message-ID: <20211215202703.GA708007@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1rQgfUP7jDKK+Gu80EyxQJpUDGz+=4LgjSfJUi77s_AeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 10:15:02AM -0800, Rajat Jain wrote:
> On Wed, Dec 15, 2021 at 10:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Dec 07, 2021 at 04:09:48PM -0800, Rajat Jain wrote:
> > > This particular SD controller from O2 / Bayhub only allows dword
> > > accesses to its LTR max latency registers:
> > > https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf
> >
> > What happens if we use a non-dword access?  Unsupported Request?
> > Invalid data returned?  Writes ignored?
> 
> Invalid data values are read / written.
> 
> > I guess word accesses must not cause PCIe errors, since we still do
> > them in pci_save_ltr_state() and pci_restore_ltr_state() even with
> > this patch.
> 
> Yes, that is correct.
> 
> > The app note says 0x234 (Max Latency registers), 0x248 (L1 PM
> > Substates Control 1), and 0x24c (L1 PM Substates Control 2) are all
> > broken, but the patch only mentions 0x234.
> >
> > I guess for 0x248 and 0x24c (the L1 PM Substates Control registers),
> > we're just lucky because those are dword registers, and all current
> > users already do dword accesses.
> 
> Yes, that is right.
> 
> > What if we instead changed pci_save_ltr_state() and
> > pci_restore_ltr_state() to do a single dword access instead of two
> > word accesses?  That kind of sweeps it under the rug, but we're
> > already doing that for 0x248 and 0x24c.
> 
> Yes, that is what I had in mind originally, and actually I'd prefer
> that too. I was afraid you might disagree :-). It sounds like we're on
> the same page though, so should I send a patch with that approach?

I think so.  I don't *like* papering over it, but the quirk only
compensates for one situation (pci_save_ltr_state() and
pci_restore_ltr_state()).  Any other places where we might read/write
the LTR values will still fail.  We don't have any other places yet,
but if/when we get ASPM L1.2 figured out, I think we will.

If we had a quirk mechanism for filtering config accesses to certain
devices, that would be ideal, but I don't think we have that.  If you
squint hard enough, aer_inject.c has something like that, but it's not
general purpose.

> > If we did that, we shouldn't need a quirk at all, but the hardware bug
> > is still lurking, and we should add a comment about it somewhere.
> 
> I can add a comment in pci_save_ltr_state() / pci_restore_ltr_state().

Maybe also in pcie_aspm_cap_init() for the L1 PM part.  Just a
one-liner should be enough.  All the details will be in the commit log
and the app note.

Bjorn

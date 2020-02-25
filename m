Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EE16EECF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 20:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgBYTPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 14:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgBYTPX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 14:15:23 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5122082F;
        Tue, 25 Feb 2020 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582658121;
        bh=me4bSWBpM9FpbQ7Hs5/OQBsgbx4rxsqreuBOjJJ2QUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MEMBlK3ME6vljTGBdu9jyyZWwo+dkSGozqRIa4I2vEpJDdDdkSHGZjgnqPeSlNaTE
         oXmpLbjTq9TSXk6Ls582/gNiUWv7PDnQjPY/Wh8CwRDzTpareneRzkkhvNDGB/2G4M
         +FTLIRtV9CNfPxUBBxqM2XlnLry4a9tdUpk0FH9w=
Date:   Tue, 25 Feb 2020 13:15:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Michael ." <keltoiboy@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Message-ID: <20200225191519.GA172914@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 04:03:32PM +0100, Ulf Hansson wrote:
> On Sat, 22 Feb 2020 at 17:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
> > > [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
> > > thread, [2] for problem report and the patch Michael tested]
> > >
> > > On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
> > > > Bjorn and Dominik.
> > > > I am happy to let you know the patch did the trick, it compiled well
> > > > on 5.4-rc4 and my friends in the CC list have tested the modified
> > > > kernel and confirmed that both slots are now working as they should.
> > > > As a group of dedicated Toughbook users and Linux users please accept
> > > > our thanks your efforts and assistance is greatly appreciated.
> > > >
> > > > Now that we know this patch works what kernel do you think it will be
> > > > released in? Will it make 5.4 or will it be put into 5.5 development
> > > > for further testing?
> > >
> > > That patch was not intended to be a fix; it was just to test my guess
> > > that the quirk might be related.
> > >
> > > Removing the quirk solved the problem *you're* seeing, but the quirk
> > > was added in the first place to solve some other problem, and if we
> > > simply remove the quirk, we may reintroduce the original problem.
> > >
> > > So we have to look at the history and figure out some way to solve
> > > both problems.  I cc'd some people who might have insight.  Here are
> > > some commits that look relevant:
> > >
> > >   5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
> > >   03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
> > >
> > >
> > > [1] https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
> > > [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
> >
> > I guess this problem is still unfixed?  I hate the fact that we broke
> > something that used to work.
> >
> > Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
> > we skip it for Toughbooks?  Or maybe we limit the quirk to the
> > machines where it was originally needed?
> 
> Both options seems reasonable to me. Do you have time to put
> together a patch?

I don't really have time, and I'm not sure which way is best.  In
general I like to avoid quirks, so I would lean toward applying the
quirk only on the machines that we know need it.  But I'm not sure how
to identify those.

Bjorn

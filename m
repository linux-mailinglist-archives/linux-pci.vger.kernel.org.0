Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B713CDF3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgAOURl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 15:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAOURl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 15:17:41 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1632064C;
        Wed, 15 Jan 2020 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579119460;
        bh=FVWkWszGL3z65oDZ4FHtyBm3OoqEBpNNOugsgaGVLcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BLHu9wBt04iSEepGo7az9v2EnYpvKrX9foXUPvXTayGLx2Ad6en7FJuJwJtG6aObP
         jXP+jBB85xIdhP/gxzMPiKzr09s8QKjkoJmiKin1dVYtsHJ1L95fPgfg2cQGyWxM6t
         Zcczu26mh0R5zjUQWmR2QyDuJT0T/zwp3YnPo4ik=
Date:   Wed, 15 Jan 2020 14:17:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
Message-ID: <20200115201738.GA190184@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Onw1JgtAYiJgkdL55pe5UdVaJ7j-Tmj3THikWEs-nbkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 12:26:32PM -0500, Alex Deucher wrote:
> On Wed, Jan 15, 2020 at 12:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > > > We've root caused the issue and clarified the quirk.
> > > > This also adds a new quirk for a new GPU.
> > > >
> > > > Alex Deucher (2):
> > > >   pci: Clarify ATS quirk
> > > >   pci: add ATS quirk for navi14 board (v2)
> > > >
> > > >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> > > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > >
> > > I propose the following, which I intend to be functionally identical.
> > > It just doesn't repeat the pci_info() and pdev->ats_cap = 0.
> >
> > Applied to pci/misc for v5.6, thanks!
> 
> Can we add this to stable as well?

Done!  Do you want it in v5.5?  It's pretty localized so looks pretty
low-risk.

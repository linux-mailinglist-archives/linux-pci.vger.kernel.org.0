Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17F46C4A2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhLGUeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhLGUeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 15:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E8C061574;
        Tue,  7 Dec 2021 12:30:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C19B6B81DD1;
        Tue,  7 Dec 2021 20:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B158C341C3;
        Tue,  7 Dec 2021 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638909034;
        bh=vcoC+Uyri7g9qycwRWUHoUG2kf9GeTBEOaheV4ro89g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UObvtOcdnqtp3lRabJHPBO9zvAXJ1d/8eNBRjpZ6otbLk5LnSEQzlSDTGpRZLGxxH
         13iT+3dRgQ8IOisWDu4P3YUC0pWIUffuoPYDmPtWatVLhy4/J4l92Hj2Zyzbkwparv
         1ZG1oK5E7RSnyns00W5SMNR7/1qrVs8Xs9GcVOtRdQyGDsf7erHvqUK/it3a/gW7i6
         ePaKGpU631QulUEhArFq7OhH+gqcp4gx/lKk/r3oR3ub4oofGrqCdE+i0DKw0AS8Em
         QWLrJXx0lbjJP9WAOu89mvdBmBPonky0RPbtTDWYiJoXIS6HDfoEjygJ2OGXjyjbAX
         5o/RtIrwiImZA==
Date:   Tue, 7 Dec 2021 14:30:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: Re: [PATCH v3 0/3] PCI: apple: Assorted #PERST fixes
Message-ID: <20211207203032.GA74708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207101621.GA466@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 10:16:32AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Nov 30, 2021 at 11:56:32AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Nov 23, 2021 at 06:06:33PM +0000, Marc Zyngier wrote:
> > > Apologies for the rapid fire (I tend to be much more conservative when
> > > resending series), but given that this series has a direct impact on
> > > other projects (such as u-boot), I'm trying to converge as quickly as
> > > possible.
> > > 
> > > This series aims at fixing a number of issues for the recently merged
> > > Apple PCIe driver, all revolving around the mishandling of #PERST:
> > > 
> > > - we didn't properly drive #PERST, and we didn't follow the specified
> > >   timings
> > >   
> > > - the DT had the wrong polarity, which has impacts on the driver
> > >   itself
> > > 
> > > Hopefully, this should address all the issues reported so far.
> > > 
> > > * From v2:
> > >   - Fixed DT
> > >   - Fixed #PERST polarity in the driver
> > >   - Collected Pali's ack on patch #1
> > > 
> > > [1] https://lore.kernel.org/r/20211122104156.518063-1-maz@kernel.org
> > > 
> > > Marc Zyngier (3):
> > >   PCI: apple: Follow the PCIe specifications when resetting the port
> > >   arm64: dts: apple: t8103: Fix PCIe #PERST polarity
> > >   PCI: apple: Fix #PERST polarity
> > > 
> > >  arch/arm64/boot/dts/apple/t8103.dtsi |  7 ++++---
> > >  drivers/pci/controller/pcie-apple.c  | 12 +++++++++++-
> > >  2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > Hi Bjorn,
> > 
> > this series is v5.16-rcX material for PCI fixes, can you pick patches
> > 1,3 up please ?
> 
> Hi Bjorn,
> 
> Arnd acked patch 2, can we send the whole series upstream for one
> of the upcoming -rcX please ? It is fixing code that was merged
> in the last merge window.

I put all three of these on for-linus and will ask Linus to pull them
before -rc5.

I do have open questions about the PERST# timing, but we can update
this if needed.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CDB46B8A7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhLGKUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:20:15 -0500
Received: from foss.arm.com ([217.140.110.172]:56076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234945AbhLGKUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Dec 2021 05:20:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 633BD1042;
        Tue,  7 Dec 2021 02:16:44 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 125F83F73B;
        Tue,  7 Dec 2021 02:16:42 -0800 (PST)
Date:   Tue, 7 Dec 2021 10:16:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: Re: [PATCH v3 0/3] PCI: apple: Assorted #PERST fixes
Message-ID: <20211207101621.GA466@lpieralisi>
References: <20211123180636.80558-1-maz@kernel.org>
 <20211130115632.GA3355@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130115632.GA3355@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 11:56:32AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Nov 23, 2021 at 06:06:33PM +0000, Marc Zyngier wrote:
> > Apologies for the rapid fire (I tend to be much more conservative when
> > resending series), but given that this series has a direct impact on
> > other projects (such as u-boot), I'm trying to converge as quickly as
> > possible.
> > 
> > This series aims at fixing a number of issues for the recently merged
> > Apple PCIe driver, all revolving around the mishandling of #PERST:
> > 
> > - we didn't properly drive #PERST, and we didn't follow the specified
> >   timings
> >   
> > - the DT had the wrong polarity, which has impacts on the driver
> >   itself
> > 
> > Hopefully, this should address all the issues reported so far.
> > 
> > * From v2:
> >   - Fixed DT
> >   - Fixed #PERST polarity in the driver
> >   - Collected Pali's ack on patch #1
> > 
> > [1] https://lore.kernel.org/r/20211122104156.518063-1-maz@kernel.org
> > 
> > Marc Zyngier (3):
> >   PCI: apple: Follow the PCIe specifications when resetting the port
> >   arm64: dts: apple: t8103: Fix PCIe #PERST polarity
> >   PCI: apple: Fix #PERST polarity
> > 
> >  arch/arm64/boot/dts/apple/t8103.dtsi |  7 ++++---
> >  drivers/pci/controller/pcie-apple.c  | 12 +++++++++++-
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> Hi Bjorn,
> 
> this series is v5.16-rcX material for PCI fixes, can you pick patches
> 1,3 up please ?

Hi Bjorn,

Arnd acked patch 2, can we send the whole series upstream for one
of the upcoming -rcX please ? It is fixing code that was merged
in the last merge window.

Thanks,
Lorenzo

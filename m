Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7039C095
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFDTpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhFDTpQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:45:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88530613D2;
        Fri,  4 Jun 2021 19:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622835809;
        bh=6eGo5rHKLjQ67SvpFQQsRXcsLLxfc4LSt/MOWbd0qt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JpcuS6j9YKSAlhMZI2GCfaRaNAQF9Ch151havxRNdXums29UbPIaqlU0XpMPwo5Ke
         SMFxDGbk/QHoUG/RAEdC3mSGoKP+j+6WrZYQn0fLL0jzoVHYGgRm1NYXZfSc5LKJqm
         TrtcnyfLJQFvRidOGf4XZKBfucdEEA4o4+YuWALgWf9q4uyGrn1k8BiQVLr6ImRtfp
         9rwt6iFKoizqAuQKwpSXRc92H1W6NVkx619Ord6ifnilwkmK2Qtpmlp/1ALXMFX3Hd
         usukST4Ozi8GgspPzbSZi+IlvGj2RuV9Td1ou0gd3rqKfrB42lELUBUGvA3cLVGo+5
         GMhSvAE4/y5+w==
Date:   Fri, 4 Jun 2021 14:43:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        lorenzo.pieralisi@arm.com,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: ralink: pci: driver for Pcie controller in
 MT7621 SoCs
Message-ID: <20210604194328.GA2230062@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210531131845.ookvz7njj6yrkaeh@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 31, 2021 at 03:18:45PM +0200, Pali Rohár wrote:
> On Friday 21 May 2021 12:23:38 Thomas Bogendoerfer wrote:
> > On Wed, May 19, 2021 at 11:18:36PM +0200, Sergio Paracuellos wrote:
> > > On Wed, May 19, 2021 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > But most of the similar drivers are in drivers/pci/controller/, where
> > > > I think it's easier to keep them up to date with changes in the PCI
> > > > core.  Have you considered putting this one there?
> > > 
> > > Most pci drivers in 'arch/mips/pci' are still using PCI_LEGACY stuff.
> > > In contrast mt7621-pci is using current pci generic apis but even most
> > > of the code is generic enough, there is one remaining thing which
> > > depends on mips architecture which is the iocu region configuration
> > > which must be done in the driver itself. This is the only reason to
> > > move this driver into 'arch/mips/pci' instead of
> > > 'drivers/pci/controller/'. So... I am all ears to listen to
> > > suggestions for the proper place for this driver. Thomas, do you have
> > > any thoughts on this?
> > 
> > I tried to put a pci-xtalk driver into drivers/pci/controller, but
> > Lorenzo didn't want it there for being MIPS and not DT based. So this
> > one is DT based, but still MIPS. I'm perfectly fine putting this
> > driver into drivers/pci/controller/
> 
> In my personal opinion this driver could go into drivers/pci/controller/

I'm not sure exactly what "PCI_LEGACY" above refers to.

I don't see any direct #includes of arch/mips in the driver.  I do see
that it uses mips_cps_numiocu(), which is certainly MIPS-specific.

But we do have some things in drivers/pci/controller/ that only build
on certain arches, enforced mostly by Kconfig rules, so I think you
could do that.  We try to make so things can at least be *compiled* on
any arch, but I know that's not always possible.

So I think it would be useful to put this in drivers/pci/controller/
somewhere because it will make it easier to see common patterns and
refactoring opportunities.

Bjorn

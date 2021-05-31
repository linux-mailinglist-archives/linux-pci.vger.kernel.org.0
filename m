Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D367395BA2
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhEaNWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 09:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhEaNUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 09:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A890613A9;
        Mon, 31 May 2021 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622467128;
        bh=9m+RsYSeUlrNwVCa1+L4Xk+683fS4psBxLrB0mG/5kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IddtYeAKmYpnWsxBYWjTW17TjFLnwqDmdsAbNhb2MfEH9JJAHsaeNmnob0x5kXu50
         ULP6hdnTFC3LE9lupvlnBTeyMmoaO7pIzjZcOIgAp/UZ7vZnBONClaklbICM6Psamg
         ATqs3ORTWNaZrkN9VClKVX/DK8HuqiCW5uoV7SYdtL6TFPor4C7KviTf8rNRPOX0mS
         N27ytuQ0FVz+r942KzrKpn4MT+sz5PMy2HohMteceDGZptlL+BoNApEcbbbz70Zs9H
         wQBYuyWazVU2auXvDTH3TifxrgDUcX1qCOeJHIcrR3k6/C8z+8dY0q4fl7W7HelqOK
         Q8Y23p1D1wAMg==
Received: by pali.im (Postfix)
        id 2D398B84; Mon, 31 May 2021 15:18:46 +0200 (CEST)
Date:   Mon, 31 May 2021 15:18:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20210531131845.ookvz7njj6yrkaeh@pali>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210519203628.GA254894@bjorn-Precision-5520>
 <CAMhs-H-7Ocjp6JLKcS9_hMn77H=st8JBdLXgxc+yYiypFTjrvQ@mail.gmail.com>
 <20210521102338.GA6989@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521102338.GA6989@alpha.franken.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 May 2021 12:23:38 Thomas Bogendoerfer wrote:
> On Wed, May 19, 2021 at 11:18:36PM +0200, Sergio Paracuellos wrote:
> > On Wed, May 19, 2021 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > But most of the similar drivers are in drivers/pci/controller/, where
> > > I think it's easier to keep them up to date with changes in the PCI
> > > core.  Have you considered putting this one there?
> > 
> > Most pci drivers in 'arch/mips/pci' are still using PCI_LEGACY stuff.
> > In contrast mt7621-pci is using current pci generic apis but even most
> > of the code is generic enough, there is one remaining thing which
> > depends on mips architecture which is the iocu region configuration
> > which must be done in the driver itself. This is the only reason to
> > move this driver into 'arch/mips/pci' instead of
> > 'drivers/pci/controller/'. So... I am all ears to listen to
> > suggestions for the proper place for this driver. Thomas, do you have
> > any thoughts on this?
> 
> I tried to put a pci-xtalk driver into drivers/pci/controller, but
> Lorenzo didn't want it there for being MIPS and not DT based. So this
> one is DT based, but still MIPS. I'm perfectly fine putting this
> driver into drivers/pci/controller/

In my personal opinion this driver could go into drivers/pci/controller/

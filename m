Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0415B40FB60
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhIQPLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 11:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhIQPLQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 11:11:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B97A61216;
        Fri, 17 Sep 2021 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631891394;
        bh=vVYHpw21259JAe8ohVI/fRRsfMKpt2NkDlr6v0nyUzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OmrECiTp474jCVtgT0DBEi1S+5l8rLOwFZyxwtFAh/Iw4Ki90XBZOwmXp+2mih90H
         MpT0zf++l3LLalCxNNwGnQ1FLUW7fL7RfajR8OrRRb84A3cyEJBDY1Zndmwz9GTb7W
         /9q8JcfNuUseHabAaPL8bkk1lqLTEYOmVfmNOrqR31PUy7wnPnbYHDxhKUHecL0E4n
         gRjdX2nRvVzItkwtkriwfyS5XHnwCOX6MJ+zKfgLI1M7LYv2MC16sTZDXewRV5s2VT
         WmgwOY5+td6/yZuylMq46kru3g5Hk1zhrjFMJeu0mA8O8+Ji5uiMwQwkp/RuT0SVN8
         QIZotvvgnblPg==
Date:   Fri, 17 Sep 2021 10:09:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hisashi T Fujinaka <htodd@twofifty.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
Message-ID: <20210917150952.GA1716923@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5518a29-efe7-1d84-1671-4dc170f6bc53@twofifty.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 15, 2021 at 04:46:54PM -0700, Hisashi T Fujinaka wrote:
> On Wed, 15 Sep 2021, Bjorn Helgaas wrote:
> 
> > On Wed, Sep 15, 2021 at 09:16:47AM -0700, Hisashi T Fujinaka wrote:
> > > On Wed, 15 Sep 2021, Heiner Kallweit wrote:

> > > > In an earlier mail in this thread was stated that subvendor id is unknown.
> > > > Checking here https://pcisig.com/membership/member-companies?combine=1dcf
> > > > it says: Beijing Sinead Technology Co., Ltd.
> > > 
> > > Huh. I didn't realize there was an official list beyond pciids.ucw.cz.
> > > 
> > > In any case, that's who you need to talk to about the unlisted (to
> > > Linux) vendor ID and also the odd VPD data.
> > 
> > https://pci-ids.ucw.cz/ is definitely unofficial in the sense that it
> > is basically crowd-sourced data, not the "official" Vendor IDs
> > controlled by the PCI SIG.
> > 
> > I submitted an addition to https://pci-ids.ucw.cz/
> > 
> > Bjorn
> 
> Just for my edumacation, do they keep track of device IDs, subvendor IDs
> (which are probably just the same as vendor IDs), and subdevice IDs in
> the PCI SIG? Or even the branding strings?

The PCI SIG does not manage Device IDs.  That's the responsibility of
the vendor.

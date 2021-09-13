Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3583C40A19A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 01:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhIMXhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 19:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236470AbhIMXhI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 19:37:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 268C160F3A;
        Mon, 13 Sep 2021 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631576152;
        bh=7NmCjM09hjITgsbY7kEN6xD1YHYZzkbMudE0ux1Yh/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=acLDhSeRjJ2skiOKLQLk0MDoxLx/Sq2sD7YYIuHbduKpV+ob4t6eZDN0LfTLxMk7g
         KrJg8PAvjsRgBvNqucMm76IHDbkBJDxZi43QKdT8hmULH5dDqLDa5Mox9h/HKoPHou
         t9rMncr2p1UFhyXo/lW2BZ3a720bzZUPCFTzH4pXQkGHl4CzYDgqXXua7KdqWG/lQT
         vL/ES1i2iYv6COjxJUW8BxJLk1zUIrMjxUZXReaAI18vvbU7UsKzfel788Y5GQVfiG
         Qv8UCC7TJ4tLxZeYHC232/t1HdwrW0tWxZ8RhXUde6ywg14b7aFZB8jD5ljlqIiqMm
         mzGctAo2gCjfg==
Date:   Mon, 13 Sep 2021 18:35:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210913233550.GA1380326@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8e8186-741e-a92f-9507-448d574ae7ca@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 10:59:05PM +0200, Heiner Kallweit wrote:
> On 13.09.2021 22:32, Dave Jones wrote:
> > On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:
> > 
> >  > > This didn't help I'm afraid :(
> >  > > It changed the VPD warning, but that's about it...
> >  > > 
> >  > > [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
> >  > > [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)                                                                                           
> >  > > [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
> >  > > 
> >  > With this patch there's no VPD access to this device any longer. So this can't be
> >  > the root cause. Do you have any other PCI device that has VPD capability?
> >  > -> Capabilities: [...] Vital Product Data
> > 
> > 
> > 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
> >         Subsystem: Device 1dcf:030a
> > 	...
> > 	        Capabilities: [e0] Vital Product Data
> >                 Unknown small resource type 06, will not decode more.
> > 
> 
> The stall being discussed would have been prevented by the VPD tag
> verification in pci_vpd_size(). It seems that now random data is
> interpreted as VPD tags what results in VPD access to an address
> that makes the device stall.

It's possible we need to validate more.  But that's not the solution
to the current problem.

> I do not really follow Linus' argumentation that VPD shouldn't be
> accessed during boot because other slow "VPD-like" devices are
> accessed too, e.g. DDR SPD via I2C.

I do.  If we don't *need* it during boot, there's no reason to read it
then.  It only slows down boot.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C293C2BBC
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jul 2021 01:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGIXqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 19:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhGIXqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 19:46:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46DF3613BC;
        Fri,  9 Jul 2021 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625874196;
        bh=rWYYHfcOSsh0+iRHRkiaPEjeYRspao8067seJfDvmTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y2EMvkM9O5dFAayo85pBHP/mtYjIFpyHdRxAJXIpEdD51R+GE2mwuA2QnbyT/7Ais
         p1H8blEx358/42mlk6e6bsspojOWfttNM87lCKgTlgal4BCw39EbxMNBMeV3zDp/tf
         LY6FkPWOqc6Ssr6tZotabvroaDZIj9Nl3NXIGAUhbPFnwUNtn9J6QsMX7DwDeF38f7
         dE7xOnnyB20xgbo1+49eA+OPHVz7hX7fyGlIKwsh7FS8aZxXSHCqR3nD3HRkYtO4Hx
         Sy3yS/vy3EzR2BsbnMRzAh33Umf3O2MWWfeSgHzEkbXfdkYvb2MLe6WQvpqz81a0Ay
         I3X7VhGwFzQ8Q==
Date:   Fri, 9 Jul 2021 18:43:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
Message-ID: <20210709234314.GA1181719@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709231529.GA3270116@roeck-us.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 04:15:29PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Apr 01, 2021 at 09:12:52PM +0800, Kai-Heng Feng wrote:
> > Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> > can't get the BAR it needs:
> > [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> > [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> > ...
> > [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> > [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> > 
> > However, the root bus has two contiguous regions that can contain the
> > child resource requested.
> > 
> > Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> > for host bridges, since host bridge don't have _SRS. So do that
> > accordingly to make child resource can be contained. This change makes
> > the graphics works on the system in question.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> With this patch in place, I can no longer boot the ppc:sam460ex
> qemu emulation from nvme. I see the following boot error:
> 
> nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
> nvme nvme0: Removing after probe failure status: -19

Thanks for the report and bisection!

I'll try to get this reverted before v5.14-rc1.

Bjorn

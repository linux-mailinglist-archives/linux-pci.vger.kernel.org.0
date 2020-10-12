Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2A28C50E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390923AbgJLW71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 18:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390913AbgJLW6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 18:58:50 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B272220757;
        Mon, 12 Oct 2020 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602543530;
        bh=NWsyNct0GmVBs7ZwzumnjCoCSbN1JUhv8GgJ2U37Pzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sQ8EN4l4oq1X6i3Wl7a3p5khaIA7hMZZDNrBb2pLa7Pz+Elveuma7o8i1F31Q79E6
         YjK/PF3iEGMMVwiyUJ4t0ZGBjZgwXcx5Y7lqD9+4KVbIff9DNaXDTBtoiP5djrFCD3
         Io5ERCSJoqjkKvyAdLKfKJwUA+Bmf6X5tIUKonuk=
Date:   Mon, 12 Oct 2020 17:58:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "seanvk.dev@oregontracks.org" <seanvk.dev@oregontracks.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v8 11/14] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201012225848.GA3754175@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d2cf35723265ce189ba2053fe4c347a816e9a4.camel@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 11:51:39PM +0000, Kelley, Sean V wrote:
> On Fri, 2020-10-09 at 15:07 -0700, Sean V Kelley wrote:

> So I tested the following out, including your moving flr to aer.c:
> 
> - Renamed flr_on_rciep() to flr_on_rc() for RC devices (RC_END and
> RC_EC)
> 
> - Moved check on dev->rcec into aer_root_reset() including the FLR.
> 
> - Reworked pci_walk_bridge() to drop extra dev argument and check
> locally for the bridge->rcec. Maybe should also check on type when
> checking on bridge->rcec.
> 
> Note I didn't use the check on aer_cap existence because I think you
> had added that for simply being able to skip over for the non-native
> case and I handle that with the single goto at the beginning which
> takes you to the FLR.

Right.  Well, my thinking was that "root" would be a device with the
AER Root Error Command and Root Error Status registers, i.e., a Root
Port or RCEC.  IIUC that basically means the APEI case where firmware
gives us an error record.

Isn't the existing v5.9 code buggy in that it unconditionally pokes
these registers?  I think the APEI path can end up here, and firmware
probably has not granted us control over AER.

Somewhat related question: I'm a little skeptical about the fact that
aer_root_reset() currently does:

  - clear ROOT_PORT_INTR_ON_MESG_MASK
  - do reset
  - clear PCI_ERR_ROOT_STATUS
  - enable ROOT_PORT_INTR_ON_MESG_MASK

In the APEI path all this AER register manipulation must be done by
firmware before passing the error record to the OS.  So in the native
case where the OS does own the AER registers, why can't the OS do that
manipulation in the same order, i.e., all before doing the reset?

> So this is rough, compiled, tested with AER injections but that's it...

I couldn't actually apply the patch below because it seems to be
whitespace-damaged, but I think I like it.

  - It would be nice to be able to just call pcie_flr() and not have
    to add flr_on_rc().  I can't remember why we need the
    pcie_has_flr() / pcie_flr() dance.  It seems racy and ugly, but I
    have a vague recollection that there actually is some reason for
    it.

  - I would *rather* consolidate the AER register updates and test for
    the non-native case once instead of treating it like a completely
    separate path with a "goto".  But maybe not possible.  Not a big
    deal either way.

  - Getting rid of the extra "dev" argument to pci_walk_bridge() is a
    great side-effect.  I didn't even notice that.

  - If we can simplify that "state == pci_channel_io_frozen" case as
    this does, that is a *big* deal because there are other patches
    just waiting to touch that reset and it will be much simpler if
    there's only one reset_subordinate_devices() call there.

If you do work this up, I'd really appreciate it if you can start with
my pci/err branch so I don't have to re-do all the tweaks I've already
done:

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/err

Bjorn

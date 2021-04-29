Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05736F1CB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhD2VRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 17:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237285AbhD2VRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 17:17:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C156360FD9;
        Thu, 29 Apr 2021 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619731008;
        bh=iI1Cr2GzIf7YA7GumpZkFW/2VbvFnoFLnzC8z8mRNKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnchjAA6GziUnzoBeNHpUlEcohzDVs2nTAFnHhLu28eybm0NEtjlH0pw7X1mk0Pyo
         oWiTS9gTTXvieqXhe716ZRqzYeKqMv3BRbeSjKDF8fK9bW285EUxkPgBd7Z7Qmfoe2
         tsHRtD0VcOb3ZnJs+PHEMlkCjfuCIb/345m5SORnuNuQy8/RgkNRvzik7LYNu9/xal
         TkUs3LT4sCMRFhJaChszPvnkPJLJTyQAMx7cLCrP5OAqmHlWV6C5owFZy4bgSW3gTS
         yw0BSeuAPw930+zPEVqBHK4qDj3xNWkbyNcCX4sxxhHtiTCVNzy97LklysfiwZ8Mbc
         v5OufhKesSyvA==
Date:   Fri, 30 Apr 2021 06:16:41 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210429211641.GB26517@redsun51.ssa.fujisawa.hgst.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <20210429193648.GA26517@redsun51.ssa.fujisawa.hgst.com>
 <20210429201603.GA18851@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429201603.GA18851@wunner.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 10:16:03PM +0200, Lukas Wunner wrote:
> On Fri, Apr 30, 2021 at 04:36:48AM +0900, Keith Busch wrote:
> > On Sun, Mar 28, 2021 at 10:52:00AM +0200, Lukas Wunner wrote:
> > > Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> > > link upon an error and attempts to re-enable it when instructed by the
> > > DPC driver.
> > > 
> > > A slot which is both DPC- and hotplug-capable is currently brought down
> > > by pciehp once DPC is triggered (due to the link change) and brought up
> > > on successful recovery.  That's undesirable, the slot should remain up
> > > so that the hotplugged device remains bound to its driver.  DPC notifies
> > > the driver of the error and of successful recovery in pcie_do_recovery()
> > > and the driver may then restore the device to working state.
> > 
> > This is a bit strange. The PCIe spec says DPC capable ports suppress
> > Link Down events specifically because it will confuse hot-plug
> > surprise ports if you don't do that. I'm specifically looking at the
> > "Implementation Note" in PCIe Base Spec 5.0 section 6.10.2.4.
> 
> I suppose you mean 6.2.10.4?

Oops, yes.
 
>    "Similarly, it is recommended that a Port that supports DPC not
>     Set the Hot-Plug Surprise bit in the Slot Capabilities register.
>     Having this bit Set blocks the reporting of Surprise Down errors,
>     preventing DPC from being triggered by this important error,
>     greatly reducing the benefit of DPC."
> 
> The way I understand this, DPC isn't triggered on Surprise Down if
> the port supports surprise removal.

Hm, that might be correct, but not sure. I thought the intention was
surprise down doesn't trigger on link down if it was because of DPC.

> However what this patch aims to fix is the Link Down seen by pciehp
> which is caused by DPC containing (other) errors.

AER will take links down through the Secondary Bus Reset too, but that's
not a problem there. The pciehp_reset_slot() suppresses the event. Can
DPC use that?

> It seems despite the above-quoted recommendation against it, vendors
> do ship ports which support both DPC and surprise removal.
> 
> 
> > Do these ports have out-of-band Precense Detect capabilities? If so, we
> > can ignore Link Down events on DPC capable ports as long as PCIe Slot
> > Status PDC isn't set.
> 
> Hm, and what about ports with in-band Presence Detect?

That can't be distinguishable from an actual device swap in that case.
Suppressing the removal could theoretically bring-up a completely
different device as if it were the same one. The NVMe driver replays
known device's security keys on initialization. Hot-swap attack?

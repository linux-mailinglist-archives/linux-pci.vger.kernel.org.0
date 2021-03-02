Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5432B260
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhCCB6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:58:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344186AbhCBRcP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Mar 2021 12:32:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6491C64F1B;
        Tue,  2 Mar 2021 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614702762;
        bh=DvfHPt3qgERw1Tx3HMUyjao2cas8sxMi68hfOaXTFEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FE3nWeAUhM3mbih1ijdn8Dos+tRqMDIbrNwaASaXx1nAXfDYE+1jrPrUPCkllEL4v
         qDVuNRR10fVxzqQgOE8NIbGMku2P1sh56O5AIUx8wfwiATCKisjo8FUZK3qUNDW2oF
         AgG/PEFx43+uzKOc2plpsAa5LfYTJFk9JBxfZXNSj6UycfERXMMSfTZHiw/VWYkkeb
         n6CaTRmiZlA46mmHdckOpXP5XU3FMod/moTUz1tV0YuE0TR9M/+VHjkfr6AE9SKIeg
         liwuliQFQcb8PbRqH8FQ96Gpfzia3FkzZpyPexj/dqu4tfghYBcGy1wqm6ob/Wy09z
         ALowwH8ExvYEQ==
Date:   Tue, 2 Mar 2021 10:32:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>
Subject: Re: PME while runtime suspend
Message-ID: <20210302163240.GA422825@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi-mmwYa4CqTtaNW3X8RrMzE8F0QchzqkB4SQ0QHCQvPVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 02, 2021 at 03:52:05PM +0100, Loic Poulain wrote:
> Hi Bjorn,
> 
> On Fri, 26 Feb 2021 at 23:22, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rafael, Dave (author of 42eca2302146), Vaibhav, linux-pm]
> >
> > On Fri, Feb 26, 2021 at 11:37:12AM +0100, Loic Poulain wrote:
> > > Hi Bjorn,
> > >
> > > Trying to support runtime suspend in a driver, which puts the device
> > > in D3hot and wait either for host/driver initiated resume
> > > (runtime_get), or device initiated resume (PME).
> > >
> > > But, given that old change: 42eca2302146 ("PCI: Don't touch card regs
> > > after runtime suspend D3")
> > >
> > > PME that was enabled from pci_finish_runtime_suspend() is not enabled
> > > anymore for almost all drivers in case of runtime-suspend. The only
> > > way to enable this is by calling pci_wake_from_d3() from the PCI device
> > > driver's runtime_suspend() callback, but this function fails if the
> > > device wake_up is not enabled, which makes sense since it targets
> > > system-wide sleep wake-up (and wake-up is user/distro policy).
> > >
> > > So is there a proper way to allow PME while the device is runtime
> > > suspended, without having to tell the user to enabled 'unrelated' wake_up
> > > capability?
> >
> > pci_pm_runtime_suspend() calls pci_finish_runtime_suspend(), which
> > enables wake-up, unless "pci_dev->state_saved".  IIUC we should be
> > enabling wake-up unless the driver has called pci_save_state() itself.
> >
> > So I infer that your driver does call pci_save_state() and the PCI
> > core does not enable wake-up.  Right?
> 
> Right.
> 
> > Why does your driver call pci_save_state()?  In most cases I don't
> > think drivers should need to do that themselves because the PCI core
> > will do it for them.  E.g., see Vaibhav's recent eb6779d4c505 ("e1000:
> > use generic power management") [1]
> 
> Thanks for the pointer, I was storing the PCI state in order to
> restore it when the device is crashing and lose its PCI context. But I
> can do that one time once the device is initialized. I've applied the
> same changes as you pointed, and it works as expected.

Great, thanks for letting us know!  It's always nice when you can
*remove* code and things work better!

Bjorn

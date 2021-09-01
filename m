Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153D3FE4F2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbhIAV3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 17:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343833AbhIAV3s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 17:29:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C39860FDC;
        Wed,  1 Sep 2021 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630531731;
        bh=UR8lRt7r5o1AdrnpSQeDaU1+qPZXgI977j2FUJlT5pI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lgxt5eRS3ECJoAMKA2RyAKvXWFa3U8qaakjuzwQKaGZ35pFh1pkV8+mSk4t4VKeWJ
         nv+CiSl9H6e++YiwBKSGuYP87n2UZcBM6fNLp/JQHBiplq+UIIq3OAzRM6pgCe+lrB
         w65aVYjlKNfBNTXaGf/49FF/3n7wInexL/Er9GI0Dio4f0KeF4pSejoMbJjEp6/rEj
         YM3Jk3BdcjSQAh6e6E1t/l1PyRW9tHg12unyFEwXNuzIWJ31Bvrwv7/yp8DfBFzmwm
         EJ9qrLwPgJWQt/GeVJmZgv828/RwRc1tlikqtTppOA5I9TeNjPIZX0aJSd6Q2wlmQU
         +nC7NgNjjKJeA==
Date:   Wed, 1 Sep 2021 16:28:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     stuart hayes <stuart.w.hayes@gmail.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210901212850.GA242902@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901054818.GA7877@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 01, 2021 at 07:48:18AM +0200, Lukas Wunner wrote:
> On Tue, Aug 31, 2021 at 04:58:01PM -0500, Bjorn Helgaas wrote:
> > I just think it's
> > conceivable that one might *want* portdrv to not claim an intermediate
> > switch like that.
> 
> It's possible to manually unbind portdrv from the device via sysfs
> (because portdrv is a driver).  In that case the port will not restore
> config space upon an error-induced reset and any devices downstream
> of the port will be inaccessible after the reset.
> 
> That's the only possible way to screw this up I think.
> And it requires deliberate, manual action.  One *could* argue that's
> not correct and the kernel shouldn't allow the incorrect behavior
> in the first place.  The behavior follows from portdrv being a driver,
> instead of its functionality being baked into the PCI core.

Right.  I do think the overall PCI design would be significantly
cleaner if the portdrv functionality were baked into the PCI core
instead of being a driver.

> > Or maybe you don't have portdrv configured at all.  Do we still
> > save/restore config space for suspend/resume of the switch?
> 
> We do, because the PCI core takes care of that.  E.g. on resume
> from system sleep:
> 
>   pci_pm_resume_noirq()
>     pci_pm_default_resume_early()
>       pci_restore_state()
> 
> However after an error-induced reset, it's the job of the device
> driver's ->slot_reset() callback to restore config space.
> That's a design decision that was made back in 2005 when EEH
> was introduced.  See Documentation/PCI/pci-error-recovery.rst:
> 
>   It is important for the platform to restore the PCI config space
>   to the "fresh poweron" state, rather than the "last state". After
>   a slot reset, the device driver will almost always use its standard
>   device initialization routines, and an unusual config space setup
>   may result in hung devices, kernel panics, or silent data corruption.
> 
> I guess it would be possible to perform certain tasks such as
> pci_restore_state() centrally in report_slot_reset() instead
> (in drivers/pci/pcie/err.c) and alleviate each driver from doing that.
> 
> One has to bear in mind though that a device may require specific
> steps before pci_restore_state() is called.  E.g. in the case of
> portdrv, spurious hotplug DLLSC events need to be acknowledged
> first:
> 
> https://patchwork.ozlabs.org/project/linux-pci/patch/251f4edcc04c14f873ff1c967bc686169cd07d2d.1627638184.git.lukas@wunner.de/

As far as I know, pci_restore_state() only restores things specified
by the PCIe spec.  It doesn't restore any device-specific state, so
I'm a little hesitant about inserting device-specific things in the
middle of that flow.  I know you're solving a real problem with that
patch, and I don't have any better suggestions, but it will take me a
while to assimilate this.

Thanks for all your analysis; it is very helpful!

> If portdrv isn't configured at all, AER and DPC support cannot be
> configured either (because they depend on PCIEPORTBUS), and it's the
> reset performed by AER or DPC which necessitates calling pci_restore_state().
> 
> If a port supports none of portdrv's services, portdrv still binds to
> the port and is thus able to restore config space if a reset is performed
> at a port further upstream.  That's because of ...
> 
> 	if (!capabilities)
> 		return 0;
> 
> ... in pcie_port_device_register().  So that should be working correctly.
> 
> Thanks,
> 
> Lukas

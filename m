Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFE3D2DB7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGVTvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 15:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhGVTvT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 15:51:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1E9D60EB5;
        Thu, 22 Jul 2021 20:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626985913;
        bh=5iqFA1lbsFotnXbfFAiYSt65yYKjjlDAwbAuyjAOQ5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZfEx455Y0eIwzhbtcoCKkmYj6q44ydHpWJRGYwR7G/XutImK6W1CAwjjq3MQ0KtN
         4aV0enap51LvQJiDC+6KNnKnqE1XYc/9jorSXpbPVO0hgFE5Mb8ZL98Qh/J/LCY98w
         AkHsz+Hxy4D4xFjDiDu7P3MjgQuRipMQi2YVmNby0iBSvGBX6V0CmrXY3mfHTjTIvt
         aXbzBYg0BcNI9uKzHNDAOAkrzA2QcAaIf0C7r+Ocp2WThVKyiWTxP28bYVikueQofs
         1y+QXElAcdwKdWGInaRKmaq4oqp06mBcR698NvQP5fdzN/emL+BigDG6aN9hnmmrRZ
         9/3+FYCker6BQ==
Received: by pali.im (Postfix)
        id 906A3805; Thu, 22 Jul 2021 22:31:51 +0200 (CEST)
Date:   Thu, 22 Jul 2021 22:31:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210722203151.heytxzup2uti4noi@pali>
References: <20210514200549.431275-1-marek.vasut@gmail.com>
 <20210717173334.GA2232818@bjorn-Precision-5520>
 <20210719085953.GA17481@lpieralisi>
 <20210719172340.vvtnddbli2vgxndi@pali>
 <62e8d92a-806b-15fb-672d-2519d5a2fa4b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62e8d92a-806b-15fb-672d-2519d5a2fa4b@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 19 July 2021 20:39:13 Marek Vasut wrote:
> On 7/19/21 7:23 PM, Pali Rohár wrote:
> 
> [...]
> 
> > > > > The R-Car PCIe controller is capable of handling L0s/L1 link states.
> > > > > While the controller can enter and exit L0s link state, and exit L1
> > > > > link state, without any additional action from the driver, to enter
> > > > > L1 link state, the driver must complete the link state transition by
> > > > > issuing additional commands to the controller.
> > > > > 
> > > > > The problem is, this transition is not atomic. The controller sets
> > > > > PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> > > > > the PCIe card, but then the controller enters some sort of inbetween
> > > > > state. The driver must detect this condition and complete the link
> > > > > state transition, by setting L1IATN bit in PMCTLR and waiting for
> > > > > the link state transition to complete.
> > > > > 
> > > > > If a PCIe access happens inside this window, where the controller
> > > > > is between L0 and L1 link states, the access generates a fault and
> > > > > the ARM 'imprecise external abort' handler is invoked.
> > 
> > And if PCIe MMIO access does not happen, what fixes this issue?
> 
> Then you have no problem because you don't hit this fault.

When controller stucks in some "unknown" state you have a problem. And
it does not matter if you are doing MMIO or not. If controller is in
Recovery or Configuration state then endpoint card cannot send neither
interrupt nor memory read / write messages to system.

Driver for endpoint card does not have to do active polling to check if
something in endpoint card happened. It can just wait for interrupt and
then do some stuff (which is IIRC preferred design if events are not too
frequent). And in this case card is in dead state and you have this
problem, right?

> > In this
> > patch is implemented only arm32 external abort hook handler (which is
> > called only when PCIe MMIO access happens and aborts).
> 
> Yes, for the aarch64 rcar the same fix is implemented in atf (see below).
> 
> > > > > Just like other PCI controller drivers, here we hook the fault handler,
> > > > > perform the fixup to help the controller enter L1 link state, and then
> > > > > restart the instruction which triggered the fault. Since the controller
> > > > > is in L1 link state now, the link can exit from L1 link state to L0 and
> > > > > successfully complete the access.
> > 
> > Link cannot directly goes to L0 from L1. It first goes to Recovery state
> > and in this state card can "disconnect" or reset...
> > 
> > What would happen if PCIe MMIO access is issued when link is not in some
> > L* state? (This can be manually triggered by PCIe Hot Reset - toggling
> > Secondary Bus Reset bit in Bridge Control register on parent PCIe Bridge
> > device) Is R-Car working in this case and does not crash?
> 
> This seems to be exactly the situation the commit message describes -- the
> controller is stuck between L states and needs manual register write to
> proceed.

No, I asked what happen when is *not* in L state. Commit message does
not describe it.

So what happen if you try to do MMIO e.g. during Hot Reset state? (This
state can be easily "forced", so easy to test) Does it crash too (and
therefore needs some other "hack")? Or it is working fine without any
crash? Read operation in most cases returns all-ones and write just do
nothing (as write has no response).

> [...]
> 
> > > > To be clear, I'm not objecting to the patch.  It's a hardware problem
> > > > and we should work around it as best we can.
> > 
> > I'm not sure if current API of hook_fault_code or rather whole usage of
> > it is prepared to expand into more and more drivers. Last time I looked
> > at this arm32 part, it was possible to register only one callback from
> > driver. So extending usage of this hook API can result that two drivers
> > start fighting who register it earlier...
> 
> There doesn't seem to be much ongoing HW development on the arm32 r-car, so
> I don't expect this list of hooks to grow much on this platform.

For R-Car it then fine. This was just general comment as arm32 is still
actively developed platform.

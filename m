Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E53FCF63
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhHaV67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 17:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhHaV67 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 17:58:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF5D560F46;
        Tue, 31 Aug 2021 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630447083;
        bh=9AAkpEaNY1prpXufEqhSyxiP7dv2In0i3i8yXV8B4AM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oDP39/M/4gyVssrMQf74uYWLKKOrC4hvymVVYXA7uEpSt0/TlyMmpl6pls/tBXRbU
         jiUjjCKmpcYczBiXktzz1/xVd2R9G87OtzHt5a9ejFm3bCaY26CboogamiBzX9vxBO
         WEb8ugi6twn4GKni8GFyJgFMAeq41YrFD550aOd0L5gaKdSWkLwgnxpxXd26raRwvo
         09r6bFBAznH7dnfoIrp0BEEyd48EWMPfaJhCXksnXRKUX+oRGkY1Y1qkSsah3CA0Ud
         jBCggD7iU8ZBXOB0HHlWdMolnGbF8faUUSlC5Up0KFInKJPK7YpyQw614GVw1WsiAG
         buEYhCP9RwO4g==
Date:   Tue, 31 Aug 2021 16:58:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Krzysztof Wilczy??ski <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210831215801.GA152955@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e31bae7-d7c7-d40a-9782-c59dcaf83798@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:44PM -0500, stuart hayes wrote:
> On 8/31/2021 2:20 PM, Bjorn Helgaas wrote:
> > On Wed, May 26, 2021 at 08:12:04PM -0500, stuart hayes wrote:
> > > ...
> > > I made the patch because it was causing the config space for a downstream
> > > port to not get restored when a DPC event occurred, and all the NVMe drives
> > > under it disappeared.  I found that myself, though--I'm not aware of anyone
> > > else reporting the issue.
> > 
> > This niggles at me.  IIUC the problem you're reporting is that portdrv
> > didn't claim a port because portdrv incorrectly assumed the port
> > supported bandwidth notification interrupts.  That's all fine, and I
> > think this is a good fix.
> > 
> > But why should it matter whether portdrv claims the port?  What if
> > CONFIG_PCIEPORTBUS isn't even enabled?  I guess CONFIG_PCIE_DPC
> > wouldn't be enabled then either.
> > 
> > In your situation, you have CONFIG_PCIEPORTBUS=y and (I assume)
> > CONFIG_PCIE_DPC=y.  I guess you must have two levels of downstream
> > ports, e.g.,
> > 
> >    Root Port -> Switch Upstream Port -> Switch Downstream Port -> NVMe
> > 
> > and portdrv claimed the Root Port and you enabled DPC there, but it
> > didn't claim the Switch Downstream Port?
> 
> That's correct.  On the system I was using, there was another layer of
> upstream/downstream ports, but I don't think that matters... I had:
> 
> Root Port -> Switch Upstream Port (portdrv claimed) -> Switch Downstream
> Port (portdrv did NOT claim) -> Switch Upstream Port (portdrv claimed) ->
> Switch Downstream Port (portdrv claimed) -> NVMe
> 
> > The failure to restore config space because portdrv didn't claim the
> > port seems wrong to me.
> 
> When a DCP event is triggered on the root port, the downstream devices get
> reset, and portdrv is what restores the switch downstream port's config
> space (in pcie_portdrv_slot_reset).
> 
> So if portdrv doesn't claim the downstream port, the config space doesn't
> get restored at all, so it won't forward anything to subordinate buses, and
> everything below the port disappears once the DPC event happens.

Right.  That's what I assumed was happening.  I just think it's
conceivable that one might *want* portdrv to not claim an intermediate
switch like that.  Maybe that switch doesn't support any of the
portdrv services.

Or maybe you don't have portdrv configured at all.  Do we still
save/restore config space for suspend/resume of the switch?  I guess
this would probably have to be putting the switch into D3cold, since
the device should preserve its config space in D3hot.

I think this kind of functionality ought to be built into the PCI core
instead of being in the portdrv.

> I'm not really sure how else it would recover from a DPC event, I guess.

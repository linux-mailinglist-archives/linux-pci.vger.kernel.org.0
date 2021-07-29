Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59EC3DAE63
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 23:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhG2VeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 17:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234129AbhG2VeN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 17:34:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3958260F0F;
        Thu, 29 Jul 2021 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627594449;
        bh=YUqO8u7XrSHhWU16RRsV0A3MhW+JcCoETSe9LAKKVIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K1mPvzSA8mQbGi4I0FBf2Vcz84vP8HotNwI4GndEk79OnXsuydBl0MOiqv5wCGT0s
         M7HbF9wcDv4aPIm7QUCuIPKqEPRnqWt4Dzbp+r+4+DDJiRwJwHX9mayxMwHEUD59jA
         FyJhSDPwM8CmxyDUuxOb4OgjYr0RUsW5G+/0JAKcStX7lPArWkDXmkAlQMPBBmSjiG
         iJ+dwxNv6vMYi7BYp1mXR+0Op2V0YAi5h/04+so9TDYYxKPQ9RjabE5gzbhYLVcJbT
         LQFl54GP84XgyC5sxiXqmlHi3M0xIxBPVaAH342rUvG2xVIqw+ZNqC9B9DXNqF8Q0i
         QSBgWET36833Q==
Date:   Thu, 29 Jul 2021 16:34:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Marcin Bachry <hegel666@gmail.com>,
        prike.liang@amd.com, shyam-sundar.s-k@amd.com
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Message-ID: <20210729213407.GA993416@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729213026.GA992249@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 29, 2021 at 04:09:50PM -0500, Limonciello, Mario wrote:
> > On 7/29/2021 16:06, Bjorn Helgaas wrote:
> > > On Thu, Jul 29, 2021 at 03:42:58PM -0500, Limonciello, Mario wrote:
> > > > On 7/29/2021 15:39, Bjorn Helgaas wrote:
> > > > > On Wed, Jul 21, 2021 at 10:58:58PM -0400, Alex Deucher wrote:
> > > > > > From: Marcin Bachry <hegel666@gmail.com>
> > > > > > 
> > > > > > Renoir needs a similar delay.
> > > > > > 
> > > > > > [Alex: I talked to the AMD USB hardware team and the
> > > > > >    AMD windows team and they are not aware of any HW
> > > > > >    errata or specific issues.  The HW works fine in
> > > > > >    windows.  I was told windows uses a rather generous
> > > > > >    default delay of 100ms for PCI state transitions.]
> > > > > > 
> > > > > > Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> > > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > 
> > > > > Added stable tag and applied to pci/pm for v5.15, thanks!
> > > > 
> > > > Thanks Bjorn!
> > > > 
> > > > Given how small/harmless this is and 5.14 isn't cut yet, any chance this
> > > > could still make one of the -rcX rather than wait for 5.14.1 instead?
> > > 
> > > Done.
> > 
> > Thanks!
> > 
> > > What's the rest of the story here?  Aare we working around a defect in
> > > these XHCI controllers?  A defect in Linux?  Obviously nobody wants to
> > > have to add a quirk for every new Device ID.  It's not like this
> > > should be hard to figure out for your hardware guys in the lab, and if
> > > it turns out to be a Linux problem, we should fix it so everybody
> > > benefits.
> > 
> > Maybe you missed the embedded message from Alex above.  We had a discussion
> > with our internal team that works with Windows on this, and they told us the
> > default delay is significantly more generous on Windows.
> 
> I did see Alex's message, but it didn't answer the question of whether
> this is a hardware defect or a Linux defect.  "It works fine in
> Windows" doesn't mean the hardware conforms to the spec.
> 
> PCIe r5.0, sec 5.3.1.4 says "... System Software must allow a minimum
> recovery time following a D3Hot → D0 transition of at least 10 ms (see
> Section 7.9.17), prior to accessing the Function."
> 
> If the hardware isn't ready in 10ms, I'd claim that's a hardware
> defect.
> 
> If Linux isn't waiting the 10ms, I'd claim that's a Linux defect.
> 
> If things work by waiting 100ms, that's nice, but what's the point of
> specs if we have to increase the time and penalize everybody just to
> accommodate some oddball device?

10ms after hitting "send" it occurred to me that since all of these
quirks are for AMD devices, we could just make the quirk generic so we
wait 100ms for *all* AMD devices.  Then AMD boxes would resume a
little slower than everybody else, but some of the maintenance burden
would go away.

I'm only half joking, and I would take that patch if you sent it.

Bjorn

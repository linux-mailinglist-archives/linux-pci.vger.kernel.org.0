Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B258420054
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJCGme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 02:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJCGmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 02:42:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1841561B2C;
        Sun,  3 Oct 2021 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633243244;
        bh=q9rseHbfMkCOtuOdC8dHz19BTSOJHk4goi5YKRUsEnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL/lBnswr3SxpuaWGHxuu4GyLyFYqX9Ttm8PpYNzXxIq8Qdv4VXAI5J09Bd4e0aYw
         VYoRTCEjo4vx5ZFzfJAuQ9n6HXvRZmT5NXUE7T4WML7FvzcBIG5DQhnWO/18If46CY
         8q8X4w3NgFqdxl6/xg1CZcZeXW2mon10BQ/vs6h0=
Date:   Sun, 3 Oct 2021 08:40:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YVlQZ1+b7NlsDegb@kroah.com>
References: <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org>
 <YVg/F10PCFNOtCnL@kroah.com>
 <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
 <20211002142138-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002142138-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 02, 2021 at 02:40:55PM -0400, Michael S. Tsirkin wrote:
> On Sat, Oct 02, 2021 at 07:20:22AM -0700, Andi Kleen wrote:
> > 
> > On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> > > On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> > > > > >    Do you have a list of specific drivers and kernel options that you
> > > > > > feel you now "trust"?
> > > > > For TDX it's currently only virtio net/block/console
> > > > > 
> > > > > But we expect this list to grow slightly over time, but not at a high rate
> > > > > (so hopefully <10)
> > > > Well there are already >10 virtio drivers and I think it's reasonable
> > > > that all of these will be used with encrypted guests. The list will
> > > > grow.
> > > What is keeping "all" drivers from being on this list?
> > 
> > It would be too much work to harden them all, and it would be pointless
> > because all these drivers are never legitimately needed in a virtualized
> > environment which only virtualize a very small number of devices.
> > 
> > >   How exactly are
> > > you determining what should, and should not, be allowed?
> > 
> > Everything that has had reasonable effort at hardening can be added. But if
> > someone proposes to add a driver that should trigger additional scrutiny in
> > code review. We should also request them to do some fuzzing.
> 
> Looks like out of tree modules get a free pass then.

That's not good.  As we already know if a module is in or out of the
tree, you all should be banning all out-of-tree modules if you care
about these things.  That should be very easy to do if you care.

> > How would user space know what drivers have been hardened? This is really
> > something that the kernel needs to determine. I don't think we can outsource
> > it to anyone else.
> 
> IIUC userspace is the distro. It can also do more than a binary on/off,
> e.g. it can decide "only virtio", "no out of tree drivers".
> A distro can also ship configs with a specific features
> enabled/disabled. E.g. I can see where some GPU drivers will be
> included by some distros since they are so useful, and excluded
> by others since they are so big and hard to audit.
> I don't see how the kernel can reasonably make a stand here.
> Is "some audit and some fuzzing" a good policy? How much is enough?

Agreed, that is why the policy for this should be in userspace.

> Well if userspace sets the policy then I'm not sure we also want
> a kernel one ... but if yes I'd like it to be in a central
> place so whoever is building the kernel can tweak it easily
> and rebuild, without poking at individual drivers.

And here I thought the requirement was that no one could rebuild their
kernel as it was provided by someone else.

Again, these requirements seem contradicting, but as no one has actually
pointed me at the real list of them, who knows what they are?

thanks,

greg k-h

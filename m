Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614A41FC94
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhJBOpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 10:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhJBOpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 10:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDE8161A38;
        Sat,  2 Oct 2021 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633185845;
        bh=RVXCE1KtXB8pEGemhZzbi1pw9kaZh7HJ77HnqA+Npns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmKcktd/wdJOAcwgKPmcihqF52yuGkwO6RKYCQVgvR3byomenOLbvq2VfDP6EjvI0
         plksHABi/Z/OXC4bfqZU2y4MUj4nw/JE7r+MlNbFWxMgZ3xVT+GKw6RNwYkpMQ3q5H
         Df6XaN3sMEBBNp5q2PWkokq4AYxKlEzAikICkvoM=
Date:   Sat, 2 Oct 2021 16:44:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <YVhwMJyJeAb8iEFL@kroah.com>
References: <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org>
 <YVg/F10PCFNOtCnL@kroah.com>
 <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 02, 2021 at 07:20:22AM -0700, Andi Kleen wrote:
> 
> On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> > On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> > > > >    Do you have a list of specific drivers and kernel options that you
> > > > > feel you now "trust"?
> > > > For TDX it's currently only virtio net/block/console
> > > > 
> > > > But we expect this list to grow slightly over time, but not at a high rate
> > > > (so hopefully <10)
> > > Well there are already >10 virtio drivers and I think it's reasonable
> > > that all of these will be used with encrypted guests. The list will
> > > grow.
> > What is keeping "all" drivers from being on this list?
> 
> It would be too much work to harden them all, and it would be pointless
> because all these drivers are never legitimately needed in a virtualized
> environment which only virtualize a very small number of devices.

Why would you not want to properly review and fix up all kernel drivers?
That feels like you are being lazy.

What exactly are you meaning by "harden"?  Why isn't it automated?  Who
is doing this work?  Where is it being done?

Come on, you have a small number of virtio drivers, to somehow say that
they are now divided up into trusted/untrusted feels very very odd.

Just do the real work here, everyone will benefit, including yourself.

> >   How exactly are
> > you determining what should, and should not, be allowed?
> 
> Everything that has had reasonable effort at hardening can be added. But if
> someone proposes to add a driver that should trigger additional scrutiny in
> code review. We should also request them to do some fuzzing.

You can provide that fuzzing right now, why isn't syzbot running on
these interfaces today?

And again, what _exactly_ do you all mean by "hardening" that has
happened?  Where is that documented and who did that work?

> > And why not just put all of that into userspace and have it pick and
> > choose?  That should be the end-goal here, you don't want to encode
> > policy like this in the kernel, right?
> 
> How would user space know what drivers have been hardened? This is really
> something that the kernel needs to determine. I don't think we can outsource
> it to anyone else.

It would "know" just as well as you know today in the kernel.  There is
no difference here.

Just do the real work here, and "harden" all of the virtio drivers
please.  What prevents that?

> Also BTW of course user space can still override it, but really the defaults
> should be a kernel policy.
> 
> There's also the additional problem that one of the goals of confidential
> guest is to just move existing guest virtual images into them without much
> changes. So it's better for such a case if as much as possible of the policy
> is in the kernel. But that's more a secondary consideration, the first point
> is really the important part.

Where exactly are all of these "goals" and "requirements" documented and
who is defining them and forcing them on us without actually doing any
of the work involved?

thanks,

greg k-h

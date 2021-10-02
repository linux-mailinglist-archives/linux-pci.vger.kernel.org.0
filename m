Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598E841FDC0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhJBSmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 14:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233799AbhJBSmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 14:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633200064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ST0KR7EU4N0YWDaDZLrBL4QmpL0x0hJwSn6j1QI0rBo=;
        b=WFcS156LyoF6LU39OH2UscFA4SumAoQCbj5BeH3OAsEiu5ZeyqIhWWLSY2qcxPuLBMH5Wp
        D/66XOvgXqYB3o5UWKIil99XS5MCFoSlRHHSbtbySYVijEUkpZ4H2Ewc/Kg9qCoK9SJy5j
        5g7SpcoSjsClczL0sKyK6kGkHt1Ur6M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-fwmmrVQfNACoCqOoQSYUdw-1; Sat, 02 Oct 2021 14:41:03 -0400
X-MC-Unique: fwmmrVQfNACoCqOoQSYUdw-1
Received: by mail-ed1-f69.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso13357821edv.13
        for <linux-pci@vger.kernel.org>; Sat, 02 Oct 2021 11:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ST0KR7EU4N0YWDaDZLrBL4QmpL0x0hJwSn6j1QI0rBo=;
        b=npiKjhwgt2JvFG1GRMEeW8HI3yGOZ2mpAYRTVjlhzAkgibm0IWbhX6bgj2MPQF0Dp+
         U7L2FoDtdhvxXqnklLdSIHocx1YN9mlhrmBK/+ANSjhN7Qvo4aCKhpNLdAuSvfW5X9el
         h3sHA96THnAfGCTi7LZ9MDqZRBz2gBjgwDnJFj4gA0IWiLtAdCVT/b5KMNs8lC4Ad4Qu
         ul2MgnL3g5MpaL0hgYpPPx2Rc/I4XE2iKdR9XhgubQwSbvudOeJs/kJg6TnHrxmMuVSH
         Gk7bLhr2MHvWMkOzJb+qeAKb9w4fYHHUpFreBoNCpBgyIfn9GiHb3G69HEPz0aDyW1Ii
         n32w==
X-Gm-Message-State: AOAM5308JI+9ljJigwfvhE46WdMnGei1ia4ZiDtFaepvJYe7dXzwvFSS
        rfMvXCf8tGksp33+o/J6WOryO6oogLHT7X6KWZ2u7vDynQ7Et8vUe+zpRggUwJPiYstpD5EXZlJ
        rlsP9WMiZ9E0fXl5smoc3
X-Received: by 2002:a50:da8d:: with SMTP id q13mr5838519edj.198.1633200062590;
        Sat, 02 Oct 2021 11:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGpM5OHPmCsSpi/pPXyOIbm5UqYLz0NOB9b8PBSBu07W665C9nUJCeC1Y0L2Zy/zB57lHbAA==
X-Received: by 2002:a50:da8d:: with SMTP id q13mr5838496edj.198.1633200062359;
        Sat, 02 Oct 2021 11:41:02 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id a23sm4866108edv.33.2021.10.02.11.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:41:01 -0700 (PDT)
Date:   Sat, 2 Oct 2021 14:40:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20211002142138-mutt-send-email-mst@kernel.org>
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
> 
> >   How exactly are
> > you determining what should, and should not, be allowed?
> 
> Everything that has had reasonable effort at hardening can be added. But if
> someone proposes to add a driver that should trigger additional scrutiny in
> code review. We should also request them to do some fuzzing.

Looks like out of tree modules get a free pass then.
Which is exactly the reverse of what it should be,
people who spent the time to get their drivers into the kernel
expect that if kernel decides to change some API their
driver is automatically updated. This was always the social
contract, was it not?

> It's a bit similar to someone trying to add a new syscall interface. That
> also triggers much additional scrutiny for good reasons and people start
> fuzzing it.
> 
> 
> >    How can
> > drivers move on, or off, of it over time?
> 
> Adding something is submitting a patch to the allow list.
> 
> I'm not sure the "off" case would happen, unless the driver is completely
> removed, or maybe it has some unfixable security problem. But that is all
> rather unlikely.
> 
> 
> > 
> > And why not just put all of that into userspace and have it pick and
> > choose?  That should be the end-goal here, you don't want to encode
> > policy like this in the kernel, right?
> 
> How would user space know what drivers have been hardened? This is really
> something that the kernel needs to determine. I don't think we can outsource
> it to anyone else.

IIUC userspace is the distro. It can also do more than a binary on/off,
e.g. it can decide "only virtio", "no out of tree drivers".
A distro can also ship configs with a specific features
enabled/disabled. E.g. I can see where some GPU drivers will be
included by some distros since they are so useful, and excluded
by others since they are so big and hard to audit.
I don't see how the kernel can reasonably make a stand here.
Is "some audit and some fuzzing" a good policy? How much is enough?

> Also BTW of course user space can still override it, but really the defaults
> should be a kernel policy.

Well if userspace sets the policy then I'm not sure we also want
a kernel one ... but if yes I'd like it to be in a central
place so whoever is building the kernel can tweak it easily
and rebuild, without poking at individual drivers.

> There's also the additional problem that one of the goals of confidential
> guest is to just move existing guest virtual images into them without much
> changes. So it's better for such a case if as much as possible of the policy
> is in the kernel.

If it's e.g. the kernel command line then we can set that
when building the kernel right? No need for a dedicated interface
just for this ...

> But that's more a secondary consideration, the first point
> is really the important part.
> 
> 
> -Andi


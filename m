Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8141E5FA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 04:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351207AbhJACV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 22:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJACV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 22:21:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41200C06176C
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 19:20:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so1738130pjb.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1v7bfhbOYS9QQdwJ+dS1BX8nNt2lEyswi+C4uaCxgo=;
        b=MCfltqqpgRZMipzrqKNzE4TCzkTYOE432mzaARuP6ZAPdOOvgGLlpUvdiffi7khzpY
         r5ytcuFoPT7QP1M4OkD8d4AAlvn+vL0MyimnfkqRJhaR81vcmlu24dPrEc+YtKAlQybA
         7uURmtuUtHfa/Nr7Epu3ozIGiZBUv0ryceNZpKerlCXqf9QNQpSj9B83sEeRR3HGje2V
         ccammWBDCWeMLsP2DpIOuH4BWPqRZiqqTRMGUl6o6QVUfFIn9+Kh4TihdfnVd9FVq5xA
         pfY/wl98KGZ2b/jqHOnCN5/hR5tIVmL9HTa0U3Dihde1AMTPm61wVlHLUYFEkJnvJlU6
         RSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1v7bfhbOYS9QQdwJ+dS1BX8nNt2lEyswi+C4uaCxgo=;
        b=wbZS6HXj9bRzXKmOi3nh9co9Cbc24i3EUhYMmdRTrDiiLnAG8FsXDLlZlfhlEKbs5i
         D3qrgR4z4r0rHqBpqKXh0/dh21cdn4gnOlfA+IiWshq2fRZ/4SlC+hug3zq/ZVYToJBu
         cIEiOwQB9kCchsw2Lr83Hfu99vAWtcYGwdLareug124wtwX7QpAIn6frPFApH5Ko6UYa
         z+4AOiT2vvwbXG2IDwPNp9/svCgMyY2IlkL5CDW09wCN66LK0SFpsj/BtGCm3yYFgDkQ
         54x8msUgqGG9ZDWF94JVaYPCRIUyxJ3yZg5pKtuRvw7aban7IOQsSnklhSLVHW72hiEq
         QfTg==
X-Gm-Message-State: AOAM531kwqRgw336dDvpRbpBEFUa91pmZymSMOH42lwGDAITMAGDT+M6
        Z0OIqsLXY5wmQad4w9ZXOLdmWj7/PuNa6JKVH9oUSg==
X-Google-Smtp-Source: ABdhPJw3+LICXsBfSEFCKXlafRA7xXZxwrcD4LdHbM7zaf1EyXu36rjRKL9bEqMGIfW1AeETHE+7h0w47T6Gie9PJI0=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr5975436plo.4.1633054814608; Thu, 30 Sep
 2021 19:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org> <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu> <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu> <20210930115243-mutt-send-email-mst@kernel.org>
 <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com> <20210930204447.GA482974@rowland.harvard.edu>
 <CAPcyv4j8DvsMYppRtm=+JQWc7nJGoXeAGGz9U150x0p_KekqcA@mail.gmail.com> <20211001014114.GB489012@rowland.harvard.edu>
In-Reply-To: <20211001014114.GB489012@rowland.harvard.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Sep 2021 19:20:04 -0700
Message-ID: <CAPcyv4iRo0Hd=_3jAScb5KUEJp3bU=QrWM8FYeb94SzO4gqgJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 6:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Sep 30, 2021 at 01:52:59PM -0700, Dan Williams wrote:
> > On Thu, Sep 30, 2021 at 1:44 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 12:23:36PM -0700, Andi Kleen wrote:
> > > >
> > > > > I don't think the current mitigations under discussion here are about
> > > > > keeping the system working. In fact most encrypted VM configs tend to
> > > > > stop booting as a preferred way to handle security issues.
> > > >
> > > > Maybe we should avoid the "trusted" term here. We're only really using it
> > > > because USB is using it and we're now using a common framework like Greg
> > > > requested. But I don't think it's the right way to think about it.
> > > >
> > > > We usually call the drivers "hardened". The requirement for a hardened
> > > > driver is that all interactions through MMIO/port/config space IO/MSRs are
> > > > sanitized and do not cause memory safety issues or other information leaks.
> > > > Other than that there is no requirement on the functionality. In particular
> > > > DOS is ok since a malicious hypervisor can decide to not run the guest at
> > > > any time anyways.
> > > >
> > > > Someone loading an malicious driver inside the guest would be out of scope.
> > > > If an attacker can do that inside the guest you already violated the
> > > > security mechanisms and there are likely easier ways to take over the guest
> > > > or leak data.
> > > >
> > > > The goal of the device filter mechanism is to prevent loading unhardened
> > > > drivers that could be exploited without them being themselves malicious.
> > >
> > > If all you want to do is prevent someone from loading a bunch of
> > > drivers that you have identified as unhardened, why not just use a
> > > modprobe blacklist?  Am I missing something?
> >
> > modules != drivers (i.e. multi-driver modules are a thing) and builtin
> > modules do not adhere to modprobe policy.
> >
> > There is also a desire to be able to support a single kernel image
> > across hosts and guests. So, if you were going to say, "just compile
> > all unnecessary drivers as modules" that defeats the common kernel
> > image goal. For confidential computing the expectation is that the
> > necessary device set is small. As you can see in the patches in this
> > case it's just a few lines of PCI ids and a hack to the virtio bus to
> > achieve the goal of disabling all extraneous devices by default.
>
>
>
> If your goal is to prevent some unwanted _drivers_ from operating --
> or all but a few desired drivers, as the case may be -- why extend
> the "authorized" API to all _devices_?  Why not instead develop a
> separate API (but of similar form) for drivers?
>
> Wouldn't that make more sense?  It corresponds a lot more directly
> with what you say you want to accomplish.

This was v1. v1 was NAKd [1] [2]:

[1]: https://lore.kernel.org/all/YQwpa+LAYt7YZ5dh@kroah.com/
[2]: https://lore.kernel.org/all/YQzDqm6FOezM6Rnu@kroah.com/

> What would you do in the theoretical case where two separate drivers
> can manage the same device, but one of them is desired (or hardened)
> and the other isn't?

Allow for user override, just like we do today for new_id, remove_id,
bind, and unbind  when default driver policy is insufficient.

echo 1 > /sys/bus/$bus/devices/$device/authorized
echo $device > /sys/bus/$bus/drivers/$desired_driver/bind

The device filter is really only necessary to bootstrap until you can
run override policy scripts. The driver firewall approach was overkill
in that regard.

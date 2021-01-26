Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF1303E7F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 14:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403987AbhAZNPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 08:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391822AbhAZNP2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 08:15:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBE0D23109;
        Tue, 26 Jan 2021 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611666885;
        bh=I+PJVVy+p71fOk1d2W2fgs0ZzyoFssXRaxBknCEuU9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckH13UiKseOEBzYiXokGL5W569sPy+tbzE5uMSbI2XQ0GUioI/MxqwrBzWl20x3CI
         BPc2FzdONotL82KwGE/UXw1nhODcVpbeK1PHRZhZUBjzcpkNu47f1S+T5vIbTW8CRw
         bvkF/3tZO2SxQktj0k2C1vOSGWX0aNE5Ie5u6w6cj61Z7CI/v62dq48M6i+WED+g1T
         2RDpjI5viFgKSp0HHblWqStssGFNyEznbJKHts01l3CvJ7veQYkJQCSBnyQ6SNr2H0
         XqdyyGs5y2C4yyuFphUHAs8zebZJMF3cris73SQITX38QOEHrCWTloWtvxB0CZjw8G
         pKkxFr7N6WlcQ==
Date:   Tue, 26 Jan 2021 15:14:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
Subject: Re: [PATCH] pci-driver: Add driver load messages
Message-ID: <20210126131441.GG1053290@unreal>
References: <20210126063935.GC1053290@unreal>
 <20210126125446.1118325-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126125446.1118325-1-prarit@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
>   Leon Romanovsky <leon@kernel.org> wrote:
> > On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
> > > There are two situations where driver load messages are helpful.
> > >
> > > 1) Some drivers silently load on devices and debugging driver or system
> > > failures in these cases is difficult.  While some drivers (networking
> > > for example) may not completely initialize when the PCI driver probe() function
> > > has returned, it is still useful to have some idea of driver completion.
> >
> > Sorry, probably it is me, but I don't understand this use case.
> > Are you adding global to whole kernel command line boot argument to debug
> > what and when?
> >
> > During boot:
> > If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
> > If device fails, you should get an error from that device (fix the
> > device to return an error), or something immediately won't work and
> > you won't see it in sysfs.
> >
>
> What if there is a panic during boot?  There's no way to get to sysfs.
> That's the case where this is helpful.

How? If you have kernel panic, it means you have much more worse problem
than not-supported device. If kernel panic was caused by the driver, you
will see call trace related to it. If kernel panic was caused by
something else, supported/not supported won't help here.

>
> > During run:
> > We have many other solutions to get debug prints during run, for example
> > tracing, which is possible to toggle dynamically.
> >
> > Right now, my laptop will print 34 prints on boot and endless amount during
> > day-to-day usage.
> >
> > ➜  kernel git:(rdma-next) ✗ lspci |wc -l
> > 34
> >
> > >
> > > 2) Storage and Network device vendors have relatively short lives for
> > > some of their hardware.  Some devices may continue to function but are
> > > problematic due to out-of-date firmware or other issues.  Maintaining
> > > a database of the hardware is out-of-the-question in the kernel as it would
> > > require constant updating.  Outputting a message in the log would allow
> > > different OSes to determine if the problem hardware was truly supported or not.
> >
> > And rely on some dmesg output as a true source of supported/not supported and
> > making this ABI which needs knob in command line. ?
>
> Yes.  The console log being saved would work as a true source of load
> messages to be interpreted by an OS tool.  But I see your point about the
> knob below...

You will need much more stronger claim than the above if you want to proceed
ABI path through dmesg prints.

>
> >
> > >
> > > Add optional driver load messages from the PCI core that indicates which
> > > driver was loaded, on which slot, and on which device.
> >
> > Why don't you add simple pr_debug(..) without any knob? You will be able
> > to enable/disable it through dynamic prints facility.
>
> Good point.  I'll wait for more feedback and submit a v2 with pr_debug.

Just to be clear, none of this can be ABI and any kernel print can
be changed or removed any minute without any announcement.

Thanks

>
> P.
>
> >
> > Thanks
>

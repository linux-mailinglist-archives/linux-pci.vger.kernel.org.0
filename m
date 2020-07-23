Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620D222B5C5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGWSez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 14:34:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55418 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727047AbgGWSez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2020 14:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595529294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olbIwyK8DRt1gFVVe5q9trGHC9PIx/LTdvtHrFCIQy0=;
        b=RMRI2hMogpBWCqtgnrMfBZMIoYhRoiz4DwvAkt6wse1FkxET2mzAhAHez417EgF6zISVQB
        tO7mIr6aTSLpCgDCh23N2Qz1JIQ1qs9/aIY/dmzxU+FstFBd346iFW5y8ZPbPDA4drf3Bj
        aEtp3PBZgrpTveu/KpAtfqm2a4uX/q0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-WANa1xDPMWO_XSOxC50rTA-1; Thu, 23 Jul 2020 14:34:51 -0400
X-MC-Unique: WANa1xDPMWO_XSOxC50rTA-1
Received: by mail-io1-f71.google.com with SMTP id m26so3446658ioc.6
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2020 11:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olbIwyK8DRt1gFVVe5q9trGHC9PIx/LTdvtHrFCIQy0=;
        b=JvNztbgO2BriODNkWgTchuGmWRRk7Ceskk0bhiYUne04sWGLuAyi/7G66WTebJDwIG
         MTsC/FUvhqZ6gtsZtWa+Kez70rameueibfTCfYR4HU4lT+RogsByT3C9ndUqa0P+2QSP
         p2orojpRrxIzQjTRIXXYe+75QDhIN1Wt2ONP+Ji2VIW2+AVFvD3TxlVmNKVKwEK2uURs
         TKQkOaMN5AGaXd0lpCytx9hvg+ZVitOghSkeWMfORxnP1TCiUus0UTIj73nvg/6VRUZ3
         2svtwjAC6uoxLTT3ZHa9CnpMhEHXCPxTFS9f0dL4Oc76zvm6MxYRfhtL0iYxudHoByUp
         m27w==
X-Gm-Message-State: AOAM533sZ0+kbmAYbnimBdqXddQkLqDeMSoQGflg7Rm3yVjJxrFTFdWO
        A3xBEQ+tlo0tbdtpJoRZEIRc/CTJRGkcu6McGLxMC8NFHNz6Cvav0AoRvzuteeo5mg30tsJqo36
        NtjDBE0VjG9sjQcGIOK0bBThlPfT9YeCX6PeT
X-Received: by 2002:a6b:bc41:: with SMTP id m62mr6012372iof.95.1595529290788;
        Thu, 23 Jul 2020 11:34:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdMTY617GsTq+0lxD6oRmrpHOfTbKSGk06sg0cdo+bSbyjp/MbnZQe9aM6Zhenuq8vZ9tx5TSoByCMImxrw60=
X-Received: by 2002:a6b:bc41:: with SMTP id m62mr6012345iof.95.1595529290486;
 Thu, 23 Jul 2020 11:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200722215048.GL220876@anatevka.americas.hpqcorp.net> <20200723000012.GA1325359@bjorn-Precision-5520>
In-Reply-To: <20200723000012.GA1325359@bjorn-Precision-5520>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 24 Jul 2020 02:34:39 +0800
Message-ID: <CACPcB9f_cD4RFA_H002LPVaAqrDh_81fjEkM2HGekdWVa+V_BQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>, Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>, jroedel@suse.de,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Khalid Aziz <khalid@gonehiking.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 8:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jul 22, 2020 at 03:50:48PM -0600, Jerry Hoemann wrote:
> > On Wed, Jul 22, 2020 at 10:21:23AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jul 22, 2020 at 10:52:26PM +0800, Kairui Song wrote:
>
> > > > I think I didn't make one thing clear, The PCI UR error never arrives
> > > > in kernel, it's the iLo BMC on that HPE machine caught the error, and
> > > > send kernel an NMI. kernel is panicked by NMI, I'm still trying to
> > > > figure out why the NMI hanged kernel, even with panic=-1,
> > > > panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
> > > > NMI by shutdown the devices in right order, that's also a solution.
>
> ACPI v6.3, chapter 18, does mention NMIs several times, e.g., Table
> 18-394 and sec 18.4.  I'm not familiar enough with APEI to know
> whether Linux correctly supports all those cases.  Maybe this is a
> symptom that we don't?
>
> > > I'm not sure how much sympathy to have for this situation.  A PCIe UR
> > > is fatal for the transaction and maybe even the device, but from the
> > > overall system point of view, it *should* be a recoverable error and
> > > we shouldn't panic.
> > >
> > > Errors like that should be reported via the normal AER or ACPI/APEI
> > > mechanisms.  It sounds like in this case, the platform has decided
> > > these aren't enough and it is trying to force a reboot?  If this is
> > > "special" platform behavior, I'm not sure how much we need to cater
> > > for it.
> >
> > Are these AER errors the type processed by the GHES code?
>
> My understanding from ACPI v6.3, sec 18.3.2, is that the Hardware
> Error Source Table may contain Error Source Descriptors of types like:
>
>   IA-32 Machine Check Exception
>   IA-32 Corrected Machine Check
>   IA-32 Non-Maskable Interrupt
>   PCIe Root Port AER
>   PCIe Device AER
>   Generic Hardware Error Source (GHES)
>   Hardware Error Notification
>   IA-32 Deferred Machine Check
>
> I would naively expect PCIe UR errors to be reported via one of the
> PCIe Error Sources, not GHES, but maybe there's some reason to use
> GHES.
>
> The kernel should already know how to deal with the PCIe AER errors,
> but we'd have to add new device-specific code to handle things
> reported via GHES, along the lines of what Shiju is doing here:
>
>   https://lore.kernel.org/r/20200722104245.1060-1-shiju.jose@huawei.com
>
> > I'll note that RedHat runs their crash kernel with:  hest_disable.
> > So, the ghes code is disabled in the crash kernel.
>
> That would disable all the HEST error sources, including the PCIe AER
> ones as well as GHES ones.  If we turn off some of the normal error
> handling mechanisms, I guess we have to expect that some errors won't
> be handled correctly.


Hi, that's true, hest_disable is added by default to reduce memory
usage in special cases.
But even if I remove hest_disable and have GHES enabled, but the
hanging issue still exists, from the iLO console log, it's still
sending an NMI to kernel, and kernel hanged.

The NMI won't hang the kernel for 100 percent, sometime it will just
panic and reboot and sometimes it hangs. This behavior didn't change
after/before enabled the GHES.

Maybe this is a "special platform behavior". I'm also not 100 percent
sure if/how we can cover this in a good way for now.
I'll try to figure how the NMI actually hanged the kernel and see if
it could be fixed in other ways.

-- 
Best Regards,
Kairui Song


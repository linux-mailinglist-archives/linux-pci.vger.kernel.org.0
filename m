Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E374B75BB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 21:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiBORJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 12:09:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiBORJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 12:09:39 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B911ACD7;
        Tue, 15 Feb 2022 09:09:29 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id j12so35870115ybh.8;
        Tue, 15 Feb 2022 09:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJg+8ODLSufI3YJAkdNmRKsDBXNNQeuaQZl515K2Cg0=;
        b=CLwrFui3vXLy0KnztE6pgFcZnRP1t5PU3k5bVcF0cLARq6ogCwQ+7VT8KpFZH7wjyU
         GcJKrs+21rjaAnBtyJ1wSwpRI3jfaHw41uOLa0gRXHYY9gMObP5HmBIBtWoUz+x2k3X9
         AZDCXU4XHZ6uv8r4PObxu0gQWXu4b8jmadznigwjKJ82A0QSDjvA02GMZCXcHM8D+o3z
         5g9wE9Ev2eJoWTOejvatnGCliYo6ryEgagkY3s/RnnO8eRXLAnz/m/1stePJj8AQrK8D
         XthPjz0LDHu+25ihOiNbu9VX0IIlfRyzbGLVn+eyaqypf0ZQwWpmHGhX5p3dyqH8fKBd
         hCCw==
X-Gm-Message-State: AOAM532XQaZAovB8/S0gzefBz8x6YuqvHu58OX5s3QFlLpoefGIzirN2
        8VEqHqPR+BDq/TPNbQCHYW9fCFuLHJPURCz0uhQ=
X-Google-Smtp-Source: ABdhPJzMObvzFyK2JDA1fz4991a3kpJmlz6YK+5txcVkUYOdgEEjXW3+czvppRdqGKQmpYG047qtCup1MpOfjrGDyp8=
X-Received: by 2002:a25:fc0d:: with SMTP id v13mr4593644ybd.272.1644944966645;
 Tue, 15 Feb 2022 09:09:26 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p6hATV8TOcJ9Qi2rMwVi=y_9+tQu6KhDkAm6Y8=cQ_xoA@mail.gmail.com>
 <20220215150939.GA106706@bhelgaas>
In-Reply-To: <20220215150939.GA106706@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 18:09:15 +0100
Message-ID: <CAJZ5v0i6+EMMGuKckhtTdt7TgC3LbofW7oS7B5=McSNjEh1yKA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 4:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Feb 14, 2022 at 08:23:05AM +0800, Kai-Heng Feng wrote:
> > On Thu, Feb 10, 2022 at 5:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > > On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > > > > > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > > > > > combination causes AER message flood and drags the system performance
> > > > > > down.
> > > > > >
> > > > > > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > > > > > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > > > > > is enabled regardless of _OSC:
> > > > > > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > > > > ...
> > > > > > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> > > > > >
> > > > > > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > > > > > disable PCIe features accordingly to resolve the issue.
> > > > >
> > > > > At least for some versions of this hardare, I recall ACPI is unaware of
> > > > > any devices in the VMD domain; the platform can not see past the VMD
> > > > > endpoint, so I throught the driver was supposed to always let the VMD
> > > > > domain use OS native support regardless of the parent's ACPI _OSC.
> > > >
> > > > This is orthogonal to whether or not ACPI is aware of the VMD domain
> > > > or the devices in it.
> > > >
> > > > If the platform firmware does not allow the OS to control specific
> > > > PCIe features at the physical host bridge level, that extends to the
> > > > VMD "bus", because it is just a way to expose a hidden part of the
> > > > PCIe hierarchy.
> > >
> > > I don't understand what's going on here.  Do we understand the AER
> > > message flood?  Are we just papering over it by disabling AER?
> >
> > To be more precise, AER is disabled by the platform vendor in BIOS to
> > paper over the issue.
> > The only viable solution for us is to follow their settings. We may
> > never know what really happens underneath.
> >
> > Disabling ASPM/AER/PME etc is a normal practice for ODMs unfortunately.
>
> OK.  So this patch actually has nothing in particular to do with AER.
> It's about making _OSC apply to *all* devices below a host bridge,
> even those below a VMD.

Right.

> This is slightly ambiguous because while "_OSC applies to the entire
> hierarchy originated by a PCI Host Bridge" (PCI Firmware spec r3.3,
> sec 4.5.1), vmd.c creates a logical view where devices below the VMD
> are in a separate hierarchy with a separate domain.

But from the HW perspective they still are in the same hierarchy below
the original host bridge.

> The interpretation that _OSC applies to devices below VMD should work,
> as long as it is possible for platform firmware to manage services
> (AER, pciehp, etc) for things below VMD without getting in the way of
> vmd.c.

vmd.c actually exposes things hidden by the firmware and the point of
the patch is to still let the firmware control them if it wants/needs
to IIUC.

> But I think one implication of this is that we cannot support
> hot-added VMDs.  For example, firmware that wants to manage AER will
> use _OSC to retain AER control.  But if the firmware doesn't know how
> VMDs work, it will not be able to handle AER for devices below the
> VMD.

Well, the firmware needs to know how stuff works to hide it in the
first place ...

> > > If an error occurs below a VMD, who notices and reports it?  If we
> > > disable native AER below VMD because of _OSC, as this patch does, I
> > > guess we're assuming the platform will handle AER events below VMD.
> > > Is that really true?  Does the platform know how to find AER log
> > > registers of devices below VMD?
> > >
> > > > The platform firmware does that through ACPI _OSC under the host
> > > > bridge device (not under the VMD device) which it is very well aware
> > > > of.

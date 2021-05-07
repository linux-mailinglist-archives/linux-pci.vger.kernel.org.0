Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621D537631E
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhEGJwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 05:52:31 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36805 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhEGJwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 05:52:31 -0400
Received: by mail-ot1-f41.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso7438757otn.3;
        Fri, 07 May 2021 02:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPQjQYzUmoFE08W4EXjrEIBArsoeb4wImA4z3QOLJK4=;
        b=a8rRioHVL402rz3kp7WibCDnTRVMD8kWCgz/NbsB9GBvbfEwZ9PjXSYmbODRcKael6
         IeaiyeRbaPl2kOjVcSDnOJhyxS4gaRX33ESfKZo+/l50+laM70k3D2SGqeaL3omuCd60
         MzVecu8HoQWGAUgNHl3B2TVuUc2MEVg+3sovrt4KvBmQX+B4WfQcxBYDhmEOGW9PkMUT
         /u+204zWUYcxYE28WMgZFIWdgFY1pdK4F2RsVe5JdZa+mIdFdYBSnpTqi/eTpApn8Izi
         Ik8ndxRZkjM256b7pVtoD0c55XLYcwqclVhSUSFGb271dNZ55MUkW/lyhxQQzC0BfR89
         nmJA==
X-Gm-Message-State: AOAM532xIZClBuVFBs9idmAYdgCnnl+POEy4ZtAFVYY2ubXaXd8yqFJf
        QW9AOsuT7f1LG482bCno5DTdEoTmOPEqIqtttDE=
X-Google-Smtp-Source: ABdhPJww/5gpmoprCGqfcImztgA/YFJ/Fn+PdS1VXroC+v07U330yHEV6eizGFwWYJAY79T+mRD5ir7LpZGheLqjs3E=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr7360464otb.260.1620381091931;
 Fri, 07 May 2021 02:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210506173820.21876-1-Hi-Angel@yandex.ru> <20210506214842.GA1436993@bjorn-Precision-5520>
 <20210506220738.GA2150@wunner.de>
In-Reply-To: <20210506220738.GA2150@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 May 2021 11:51:20 +0200
Message-ID: <CAJZ5v0hFEX3doAPbDDix3oGpfCbSkWLgjPzNdvNLXyNRN+uqzQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on s2idle
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 7, 2021 at 12:07 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > longer being detected, and dmesg having errors like:
> > >
> > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> > >
> > > and a stacktrace. The reason turned out that the hw that the quirk
> > > powers off does not get powered on back on resume.
> >
> > quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> > ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> > "power is automatically restored before resume," so there must be
> > something special about s2idle that prevents the power-on.
>
> With s2idle, the machine isn't suspended via ACPI, so the AML code
> which powers the controller off isn't executed.  The dance to prepare
> the controller for power-off consequently isn't necessary but rather
> harmful.
>
> To get the same power savings as with ACPI suspend, the controller
> needs to be powered off via runtime suspend.

I'm not quite sure why runtime PM needs to be involved.

The controller suspend can happen in the system-wide suspend code path directly.

> I posted patches for
> that back in 2016.  I'm using them on my laptop, they need some
> polishing and rebasing before I can repost them due to massive
> changes that have happened in the thunderbolt driver in the meantime.
> Without these patches, the controller sucks 1.5W of power in s2idle.
>
> > Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> > something that wasn't tested back then, or is this problem connected
> > to an s2idle change since then?  Can we identify a commit that
> > introduced this problem?  That would help with backporting or stable
> > tags.
>
> Yes I believe the quirk predates the introduction of s2idle by a couple
> of years.
>
> > > Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>
> The patch looks fine to me.
>
> Thanks,
>
> Lukas

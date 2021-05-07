Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94996376777
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhEGPEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 11:04:16 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43999 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbhEGPEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 11:04:10 -0400
Received: by mail-oi1-f170.google.com with SMTP id j75so8939995oih.10;
        Fri, 07 May 2021 08:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMaqx0oP6vyp7kPXJFjX296lhoj8BNRa90P+Kbk4H/o=;
        b=kShqSKG//zCp6v/I3pLyw0n32QqVXjIR7zvuUBIp/bww4L8CI94ERIHwUQDI1uVO8S
         fFjhws+oCxfNZV0+503alY4W/J8gmzj8C88yFC1QYQnph4ZspGuKUOH/w19ILsEUFts0
         pLyuuwbVGyoIWRo7Up4tg8Oa78sNTcrcD9WEP99KUgXsV5vfSzt6hbghxUqla6KuH/8K
         C3eIj0rq7Zu/S35/Hhr6J9dlzeNt4ikMqjzQ2vOo+/Hu+ntZDB+kjf67jz525IC5bUKw
         +zDeAQRNQAld0WbSS1bNlYxk01V0CWQuGua+l7YR3IoRZHU0kDZAKUA+bg12Lclw+KrU
         iALg==
X-Gm-Message-State: AOAM533KTecpYX3qmLRiR2ic38M79ympF+DciHarAJha75AjwpAn6eTP
        g/nGOntIjhIAZaIMaco+JHWMq2oWGXCuPPnIv3c=
X-Google-Smtp-Source: ABdhPJyDOu90WOgTcRpBZND1O+fG9lDinkphjgOzTwQC0SK6h7jsNW54F6BOHWTdxGeAPNbojrWzpt1Jtz151uFecMI=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr7139531oib.69.1620399785223;
 Fri, 07 May 2021 08:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210506220738.GA2150@wunner.de> <20210507133002.GA1499665@bjorn-Precision-5520>
In-Reply-To: <20210507133002.GA1499665@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 May 2021 17:02:53 +0200
Message-ID: <CAJZ5v0hvjkiTExHo9=FZMTQCwuDeWgKoYwg9dU_mhBuF-6ifuQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on s2idle
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 7, 2021 at 3:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> > On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > longer being detected, and dmesg having errors like:
> > > >
> > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> > > >
> > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > powers off does not get powered on back on resume.
> > >
> > > quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> > > ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> > > "power is automatically restored before resume," so there must be
> > > something special about s2idle that prevents the power-on.
> >
> > With s2idle, the machine isn't suspended via ACPI, so the AML code
> > which powers the controller off isn't executed.  The dance to prepare
> > the controller for power-off consequently isn't necessary but rather
> > harmful.
> >
> > To get the same power savings as with ACPI suspend, the controller
> > needs to be powered off via runtime suspend.  I posted patches for
> > that back in 2016.  I'm using them on my laptop, they need some
> > polishing and rebasing before I can repost them due to massive
> > changes that have happened in the thunderbolt driver in the meantime.
> > Without these patches, the controller sucks 1.5W of power in s2idle.
> >
> > > Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> > > something that wasn't tested back then, or is this problem connected
> > > to an s2idle change since then?  Can we identify a commit that
> > > introduced this problem?  That would help with backporting or stable
> > > tags.
> >
> > Yes I believe the quirk predates the introduction of s2idle by a couple
> > of years.
>
> In an ideal world, we would know which commit introduced s2idle and
> hence the possibility of hitting this bug, and we would add a Fixes:
> tag for that commit so we could connect this fix with it.
>
> Apart from that, what I don't like about this (and about the original
> 1df5172c5c25) is that there's no connection to a spec or to documented
> behavior of the device or of suspend/resume.
>
> For example, "With s2idle, the machine isn't suspended via ACPI, so
> the AML code which powers the controller off isn't executed."  AFAICT
> that isn't actually a required, documented property of s2idle, but
> rather it reaches into the internal implementation.

I tend to agree, but not completely.

The substantial difference between s2idle and S2RAM is that with the
latter control is passed to the platform firmware at the end of the
suspend transition, but that part of the platform firmware is SMM
rather than AML and so this has no bearing on whether or not power is
removed from the controller by any AML code.

That said, the platform firmware code completing the S2RAM suspend
transition does remove power from various system components which may
(and probably does) include the Thunderbolt controller.

IOW, the s2idle path needs to actively power manage the controller in
order to achieve desirable results, whereas in the S2RAM case that
isn't strictly necessary due to the fundamental difference between the
two variants of system-wide suspend.

> The code comment "If suspend mode is s2idle, power won't get restored
> on resume" is similar.  !pm_suspend_via_firmware() tells us that
> platform firmware won't be invoked.  But the connection between *that*
> and "power won't get restored" is unexplained.

Right.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D336B969C5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfHTTvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 15:51:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44909 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTTvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 15:51:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id e24so6273264ljg.11
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2019 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzNzyloo9i11cwSWqzoRa5VsVEGBEuE5NJo1/qbNmdU=;
        b=W61t4DOK3Uj8lV5XFyW0NE60Y9enUIUr32qAr8pwKgzLPHV9jLGXgS9afWia7vOOj4
         t6XmFLGR9K47/AmPNbHetbT6Xd48VKMAiCg45TfPyZjpi9oCITvHUYNFGeIeTCaSQ/6w
         yl3hsQaMEkfxkA4zGLVgEWoGtDRay6PTU3pU/mvjpU8olEphHcf8vscgIpAUYpzNMbXw
         TsxS0zAJZzHrKTJwIyqNlv/z1Qxg8W9gTC1mXJr3LTkiuQt3GGyob3S2Mw1Mn/4bPbMP
         HQXPWO1QPylQTy0ojva7UE8mtJq/+o2QsuBhz3641x3FQWPU3o/XG8vKUnKBb8Aax21/
         5coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzNzyloo9i11cwSWqzoRa5VsVEGBEuE5NJo1/qbNmdU=;
        b=MddNCpWXqMiZrJYcXgipVR3POxZe9Tfa9B4TOT0fonE7IkI6V/k2XqfC0M6CUv33/O
         8/2ktaNpDN62RGb1ceh/EXFLtiyd2c87d/7Xl9fN1yxrmWra8IVNMT6hpUDgCVWJgV+6
         gYY3ocXOea3m6R7r628LDr3lwb4frMswTWK75/e6UidWyMQgrNDZaicU5HbUyvET06PN
         DW3rttbnNFnvPY6B91QXGO+T/x3lTzxULjXv7hx1xAXXUKwWOUDHbOCx91Xe/ZMfZqsS
         KeU7oOlztCA5Irb3ZGtQ8CJkI4U+mVrjvFWV46H+lUMYtJhK3ock8nmHgNXRReYA0tDI
         atRA==
X-Gm-Message-State: APjAAAWD5K4x+LRiILDMh1iOQ1DTWsPP4fwgI6B8n1bB8oD9pXzfNcYm
        OnYuWXH1M/XmwnHTB773r0kU9R2fIFF/HgI+G6pBkA==
X-Google-Smtp-Source: APXvYqz+E5hkUBwnb1fSXg/27DwgMmY0ZQIbe/YtCIpslPq8DiP6BGlUhtNHRjjLDdRUGaX8Ygxxa/phFetFVWRmrWg=
X-Received: by 2002:a2e:5bc6:: with SMTP id m67mr13699765lje.53.1566330705579;
 Tue, 20 Aug 2019 12:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
 <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com> <20190820103400.GY253360@google.com>
 <CACK8Z6HJBoJ_OkHEHY6oYtABDVwRx9eCh9GngHxGE63UPsOHig@mail.gmail.com> <20190820193252.GB14450@google.com>
In-Reply-To: <20190820193252.GB14450@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 20 Aug 2019 12:51:09 -0700
Message-ID: <CACK8Z6GuzQAoSnDD9chC9yXrPrc3FTtzkiDXMTXdY4MnePgj8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 12:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 20, 2019 at 12:05:01PM -0700, Rajat Jain wrote:
> > On Tue, Aug 20, 2019 at 3:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, May 23, 2019 at 10:05:35PM +0200, Heiner Kallweit wrote:
> > > > Background of this extension is a problem with the r8169 network driver.
> > > > Several combinations of board chipsets and network chip versions have
> > > > problems if ASPM is enabled, therefore we have to disable ASPM per default.
> > > > However especially on notebooks ASPM can provide significant power-saving,
> > > > therefore we want to give users the option to enable ASPM. With the new sysfs
> > > > attribute users can control which ASPM link-states are enabled/disabled.
> > > >
> > > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
> > > >  drivers/pci/pci.h                       |   8 +-
> > > >  drivers/pci/pcie/aspm.c                 | 180 +++++++++++++++++++++++-
> > > >  3 files changed, 193 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > > > index 8bfee557e..38fe358de 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > > @@ -347,3 +347,16 @@ Description:
> > > >               If the device has any Peer-to-Peer memory registered, this
> > > >               file contains a '1' if the memory has been published for
> > > >               use outside the driver that owns the device.
> > > > +
> > > > +What:                /sys/bus/pci/devices/.../power/aspm_link_states
> > > > +Date:                May 2019
> > > > +Contact:     Heiner Kallweit <hkallweit1@gmail.com>
> > > > +Description:
> > > > +             If ASPM is supported for an endpoint, then this file can be
> > > > +             used to enable / disable link states. A link state
> > > > +             displayed in brackets is enabled, otherwise it's disabled.
> > > > +             To control link states (case insensitive):
> > > > +             +state : enables a supported state
> > > > +             -state : disables a state
> > > > +             none : disables all link states
> > > > +             all : enables all supported link states
> > >
> > > IIUC this "aspm_link_states" file will contain things like this:
> > >
> > >   L0S L1 L1.1 L1.2                 # All states supported, all disabled
> > >   [L0S] L1                         # L0s enabled, L1 supported but disabled
> > >   [L0S] [L1]                       # L0s and L1 enabled
> > >   ...
> > >
> > > and the control is by writing things like this to it:
> > >
> > >   +L1                              # enables L1
> > >   +L1.1                            # enables L1.1
> > >   -L0S                             # disables L0s
> > >
> > > I know this file structure is similar to protocol handling in
> > > drivers/media/rc/rc-main.c, but Documentation/filesystems/sysfs.txt
> > > suggests single values in a file, and Greg recently pointed out that
> > > we screwed up some PCI AER stats [1].
> > >
> > > So I'm thinking maybe we should split this into several files, e.g.,
> > >
> > >   /sys/devices/pci*/.../power/aspm_l0s
> > >   /sys/devices/pci*/.../power/aspm_l1
> > >   /sys/devices/pci*/.../power/aspm_l1.1
> > >   /sys/devices/pci*/.../power/aspm_l1.2
> > >
> > > which would contain just 1/0 values, and we'd write 1/0 to
> > > enable/disable things.
> > >
> > > Since the L1 PM Substates control register has separate enable bits
> > > for PCI-PM L1.1 and L1.2, we might also want a way to manage those.
> > >
> > > Bjorn
> > >
> > > [1] https://lore.kernel.org/r/20190621072911.GA21600@kroah.com
> >
> > Sorry, this has been sitting on my plate for some time now. I'll work
> > on it and send out a patch later in this week.
>
> Don't worry, I cc'd you mostly as FYI because you're a recent
> contributor to aspm.c in this area, though I wouldn't complain about
> AER stats sysfs patches either :)
>

May be we're digressing now, but I'd like to point out that there is
atleast one more file in ASPM that potentially violates the "1 value
per file" rule:

rajatja@rajat2:/sys/module/pcie_aspm/parameters$ cat policy
[default] performance powersave powersupersave
rajatja@rajat2:/sys/module/pcie_aspm/parameters$

... although I would argue in this case that it makes it much clear
what are the allowable values to write, and which is the current
selected one.

Thanks,

Rajat


> Bjorn

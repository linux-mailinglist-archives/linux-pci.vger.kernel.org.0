Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC49D103983
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfKTMGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 07:06:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34344 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKTMGj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 07:06:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id l202so22292064oig.1;
        Wed, 20 Nov 2019 04:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElT7EJNqtwpJJU4QjMYGJbxkB5AWzSyGEgl7I/cinCY=;
        b=hr58LFCDCSzTnyNwpoB7s6lVEQK1tD0HPWHIS2n6GAB5ej72KyYoWxDVPuG6sNHjvs
         +i4tXFgQDVRylOpu3hf2FssZKNbIqbCsa+E3BEmzYRP7vTR0cSph3tIUaYZykugeOW7P
         t90QAVn3U8koe1EJuWLYgSdBZuN4mMCyj80HpBMtqiBu84H0j+QJ2IBZwEhnD8rQIrck
         HV9KWTgi7j6l0PYBDAA74o09F2kZquV3ek0kCoNwOj4Fqfsxc0Pvc0mZoWxsux38nqHW
         HC3GbzvFznH8A1mjyj8cu9E5jHkPsW4KnCfqyBuEE+DyDbe5pENwkX16vE9xfYgW75Ue
         HiuQ==
X-Gm-Message-State: APjAAAVuz/wWxvyOS57hTEz4oFSryCNSqyIZ23j8fGWrhg4ZHQnRPkbS
        T4KZbAWVlIqDB/GGVyH3dtzEMreRSc4rHPhnuwE=
X-Google-Smtp-Source: APXvYqxheneYqbQjWsEAfSkE2ZQbClubvVZBCaL5vjr7E9PZ5SxHyJLeCYrf4NpLC+8pv/qSSK7clExZOkJduiPveC8=
X-Received: by 2002:aca:c753:: with SMTP id x80mr2352248oif.115.1574251597887;
 Wed, 20 Nov 2019 04:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com>
In-Reply-To: <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 13:06:26 +0100
Message-ID: <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > >

[cut]

> > > >
> > > > Oh, so does it look like we are trying to work around AML that tried
> > > > to work around some problematic behavior in Linux at one point?
> > >
> > > Yes, it looks like so if I read the ASL right.
> >
> > OK, so that would call for a DMI-based quirk as the real cause for the
> > issue seems to be the AML in question, which means a firmware problem.
> >
>
> And I disagree as this is a linux specific workaround and windows goes
> that path and succeeds. This firmware based workaround was added,
> because it broke on Linux.

Apparently so at the time it was added, but would it still break after
the kernel changes made since then?

Moreover, has it not become harmful now?  IOW, wouldn't it work after
removing the "Linux workaround" from the AML?

The only way to verify that I can see would be to run the system with
custom ACPI tables without the "Linux workaround" in the AML in
question.

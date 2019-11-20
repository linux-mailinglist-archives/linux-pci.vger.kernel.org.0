Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B571039A3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 13:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfKTMLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 07:11:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40115 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfKTMLs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 07:11:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so20978679otq.7;
        Wed, 20 Nov 2019 04:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeFNReHTu2Z/wmOhc+6rykSX19PAp/KecxFvBbcF5xE=;
        b=HRXYhe8xWVyZOKnpqhh6cQn0NPCw7hjOT/kpVG+1tq6BiNldAuT/qZyRyFhdx4T/qh
         SKPc+B7f85cCBJccdQfSD31PU8iGI0X55hS7ucRcDgTQtzclrKI/JUdxJtmtNIBO/IFt
         AKjTQz8JFqR+2myxJmzcbY26xqLfakNrsjq3vu1NgXt5tjWK4XwB8/gOfYnfDspDyXzb
         9gPkP2tielZFwLUMGPj9LbNKxVufi2o4azvh8mdpiHYeKQAs8NA2c5fFDlsmKOv4Z1Ay
         9UUva97FlsCFqgHdBXf6LNY5I20xyUqKzohPUFUfD5Y8vdixh0fmtcCc7oPnVE5TiszY
         3oIA==
X-Gm-Message-State: APjAAAW+bGnF0NwosqqSNelUtTigiDCUqK7l01onjt7k7giyrIn0PNVg
        I9N/ziIaupqann+ug66QAEsAazrKf+1FaGzq7s4=
X-Google-Smtp-Source: APXvYqyrkRK0kaVt5Z4vrt370dqRdCmzFhxyhg+9v0spLlBL7ZERizh4DCBBV+SYsNe6NGTAKOmu24BP4l9rb4a+3xk=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr1670717otn.167.1574251907511;
 Wed, 20 Nov 2019 04:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com> <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 13:11:36 +0100
Message-ID: <CAJZ5v0hYLrmFup61kzQL_rUuRy9yb+3L-BdRUGfSKqkGpm-utw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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

On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
>
> [cut]
>
> > > > >
> > > > > Oh, so does it look like we are trying to work around AML that tried
> > > > > to work around some problematic behavior in Linux at one point?
> > > >
> > > > Yes, it looks like so if I read the ASL right.
> > >
> > > OK, so that would call for a DMI-based quirk as the real cause for the
> > > issue seems to be the AML in question, which means a firmware problem.
> > >
> >
> > And I disagree as this is a linux specific workaround and windows goes
> > that path and succeeds. This firmware based workaround was added,
> > because it broke on Linux.
>
> Apparently so at the time it was added, but would it still break after
> the kernel changes made since then?
>
> Moreover, has it not become harmful now?  IOW, wouldn't it work after
> removing the "Linux workaround" from the AML?
>
> The only way to verify that I can see would be to run the system with
> custom ACPI tables without the "Linux workaround" in the AML in
> question.

Or running it with acpi_rev_override as suggested by Mika, which
effectively would be the same thing.

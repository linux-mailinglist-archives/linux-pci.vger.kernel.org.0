Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC0DECFF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 15:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfJUNCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 09:02:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbfJUNCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:02:36 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5ED7C057F31
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 13:02:35 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id k53so14065315qtk.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 06:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MATzqi2DYgY3f2a3E6niPS64+EAt9PrYf2/3XZiaaBU=;
        b=O52vfQgrDaUahJZ2hWZ5X72VwWW4Lq54bKoLwfDPB/NTVHvVwVIM66GOVNvAAk7Bbn
         WgPh5gJ9Uc+Y7woPv4R9UHctA4KEpQ4Q7kBDyW3D10DTjNREdc5ZDphcReAgKPbKC9Gv
         tS3IJPWdQf5jUq/+vngrPccaJ5tt7nmPs6dLdflUursF/+JIeqWawaRhvTjFRw0vpRPT
         1V7A+MQHu5u/EcGsqqvNTr3A9zEGGVKSdUwvsr5677jTjIy+8iMw9OLXWyC/rXNnALHW
         tRlT8SaaKJmAI0Ybt0sED7Z07gmXzFEsXnFIvI/hhQWyDasp1zfAHw8QkL1FOFlCP+R6
         Z9hw==
X-Gm-Message-State: APjAAAXxcFAQfd/UIrl8qCARJRzxCa9ewdmN4qLa+kvb0DcamvPn4oaQ
        efpL1MX2kCpjM3IfOv5uxr1hfw8cDsCoLtM873zTP6LCX9N0HxF91cyvUdZzp50Z49VQy9QYzaM
        T5/ADiLbhXpHEIMF43Te5FJfBibx/fVzzkiQZ
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22922008qkj.102.1571662954918;
        Mon, 21 Oct 2019 06:02:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhj+jJSrLfQkuYBSA3fMA/d8Rx0RQ7EY47UhYO+DdxvK1frDIPrR+k9EvVDJ33OZEmDSuD4GzUm4UQE4AVqWs=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22921978qkj.102.1571662954620;
 Mon, 21 Oct 2019 06:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191016144449.24646-1-kherbst@redhat.com> <20191021114017.GY2819@lahna.fi.intel.com>
 <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com> <20191021120611.GB2819@lahna.fi.intel.com>
In-Reply-To: <20191021120611.GB2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 15:02:23 +0200
Message-ID: <CACO55tvYEvPHwFLDmLOQ_BCiNw7ZRA7dun9P=KdLb4bvYTtrcg@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 2:06 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Mon, Oct 21, 2019 at 02:00:46PM +0200, Karol Herbst wrote:
> > On Mon, Oct 21, 2019 at 1:40 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > Hi Karol,
> > >
> > > Sorry for commenting late, I just came back from vacation.
> > >
> > > On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > > states.
> > > >
> > > > v2: convert to pci_dev quirk
> > > >     put a proper technical explanation of the issue as a in-code comment
> > > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > >
> > > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: nouveau@lists.freedesktop.org
> > > > ---
> > > >  drivers/pci/pci.c    | 11 ++++++++++
> > > >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> > >
> > > I may be missing something but why you can't do this in the nouveau
> > > driver itself?
> >
> > What do you mean precisely? Move the quirk into nouveau, but keep the
> > changes to pci core?
>
> No, just block runtime PM from the device in nouveau driver.

but that's not what the patch does. It only skips the PCI PM reg
write, but still let the ACPI method be invoked to put the device into
D3cold

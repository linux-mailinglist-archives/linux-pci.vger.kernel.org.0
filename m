Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B123760A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFFOIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 10:08:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43243 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfFFOIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 10:08:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so1628287oif.10;
        Thu, 06 Jun 2019 07:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=is207UjVgxaXozD/+8EpeZcuEMx2bCfP7n7mgdpO3zA=;
        b=jr3eMcCabdaXlZAZM2t4/X/u3JJlLT1OtTSJB2fynEnoMzG21Fs8IFFeJIRWEH3BZz
         VixEV/cPSPLOkQ6WIqGOP1QaJdUW25mkfTVpRVIIBPxRujyoAGX/KAqTNy4M2ohkAnfz
         gHkbYjROpPTegRzjp8EOv86Fi7xWpJxC14ShfSY4FsFw2TRtdc9hQejnMfjomOA1Dkh7
         KtU+ix7L1yOUbU/JXEIZfUrN4QEmMGjrAduZL0O9sa1ZdxQ+Tmorj3rTDfuDpFM/W66z
         Zh9BO5ahlEwVp3hdXDUU4Eu8jPEC6qTtlnOrPU6YwRgetyP1Wbx1SnJTjY+Zbid8J4GV
         TWkQ==
X-Gm-Message-State: APjAAAWp62kL6cjwbOPrWiKAKW08k/wTqZiU0p2LomJgOu396+S3JHjm
        5DbxOCagjBzUlZjTMsagq5j90nJawilaX0KF9iU=
X-Google-Smtp-Source: APXvYqxueRcq45zH/rbHRw2OtTPWH/adogZQu55V96VfPrjInNbvMDIJaxSviEGUviKLS4660lrFJ7TTfu7AdVCNI6Y=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr124639oib.57.1559830103548;
 Thu, 06 Jun 2019 07:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-4-mika.westerberg@linux.intel.com> <CAJZ5v0iGu8f6H68082RGDmDCQsmQZNTULLwnb5JzpKA7m1QvVA@mail.gmail.com>
 <20190606112640.GA2781@lahna.fi.intel.com> <20190606134419.GL2781@lahna.fi.intel.com>
In-Reply-To: <20190606134419.GL2781@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jun 2019 16:08:11 +0200
Message-ID: <CAJZ5v0gHTVPNc_LJzPCOLZpHU=wsbYQs__WabOQHmu8GPCChag@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 6, 2019 at 3:44 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Jun 06, 2019 at 02:26:40PM +0300, Mika Westerberg wrote:
> > On Thu, Jun 06, 2019 at 10:54:40AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 5, 2019 at 4:58 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > Intel Ice Lake has an interated Thunderbolt controller which means that
> > >
> > > integrated
> >
> > Right :)
> >
> > > > the PCIe topology is extended directly from the two root ports (RP0 and
> > > > RP1). Power management is handled by ACPI power resources that are
> > > > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > > > controller.
> > > >
> > > > The topology with the power resources (marked with []) looks like:
> > > >
> > > >   Host bridge
> > > >       |
> > > >       +- RP0 ---\
> > > >       +- RP1 ---|--+--> [TBT]
> > > >       +- NHI --/   |
> > > >       |            |
> > > >       |            v
> > > >       +- xHCI --> [D3C]
> > > >
> > > > Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
> > > > returns either TBT or D3C or both.
> > > >
> > > > Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> > > > since the TBT power resource is still on when the root ports are runtime
> > > > suspended their dev->current_state is set to D3hot. When NHI is runtime
> > > > suspended TBT is finally turned off but state of the root ports remain
> > > > to be D3hot.
> > >
> > > It looks like this problem will affect all ACPI devices using power
> > > resources and _PR3 in general, so fixing it just for PCI is not
> > > sufficient IMO.
> >
> > Fair enough.
> >
> > > An alternative approach may be to set the state of a device that
> > > dropped its references to power resources listed in _PR3 to D3cold
> > > even though those power resources may be physically "on" at that time.
> > > Everything else (including this patch AFAICS) will be racy this way or
> > > another.
> >
> > OK, thanks for the comment. I'll try to look into this approach then.
>
> One additional question.
>
> How about the other direction when shared power resource(s) gets turned
> on? We would need to wake up all the sharing devices so that their state
> gets restored back from D0uninitialized.

That isn't necessary IMO as long as the device are not accessed.  If
the kernel thinks that a given device is in D3cold and doesn't access
it, then it really doesn't matter too much what state the device is in
physically.  On the first access the device should be reinitialized
anyway.

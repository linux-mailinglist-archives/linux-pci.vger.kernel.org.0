Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363DBE007F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfJVJQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 05:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388385AbfJVJQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 05:16:27 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73B0737E79
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2019 09:16:26 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id s3so16099379qkd.6
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2019 02:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NaftjpZ7q0/7FUFVe9FC7tfQH1ZMRLJsGxSpJEAYR0=;
        b=jgx4fetu3Z0FqYsjWDnA9NW+bUGD7NEKCVldWkL/SyAyW9IJn53zNeLypy0fUzZdCW
         xe5HmokFKXkVWw3YxWMLnPgYeskyS0ThkQUXUnXCGQ2ReOB1Jq11H6O8VEYGUf68qeaa
         gr+CH9g9rZuM1iQiwNH4caOyycpEDVsNUz+iEBu4ZYWMjrX8Sr2EHRRkNTUMcy+ECCeP
         iQ/uIYeLrGPlz49O7ghtscH5EDAa5vuJvHwCRx98gzGKCIthDK2vY6yR9Sc63SnfgSta
         SL8Im4wQ/l5QSAW7pq9SLduvYidCIb0aU685OKQB81HTQXYex1oPYgwynfgD4uDVR0Yz
         3WiA==
X-Gm-Message-State: APjAAAW7tmOegnxLGsvvHgxgzBg6IshrJROUYD0myIi0jXjYCxrdSTaz
        g8cn4IGGpGJYTvazvSP5IFwoENGTLzi+1dfvTxF5K8SOSBtaMFdSpVfmN3qItD8tIKCRq1Ds7FS
        YyD7Vna9Mgc6gJDZgk+vbcagI5wPJF1TmoNEf
X-Received: by 2002:ac8:664b:: with SMTP id j11mr2246841qtp.137.1571735785693;
        Tue, 22 Oct 2019 02:16:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxh+htVaSt1EHk6f2pMjctNRL+6dMevykS1gSHbmTJ7kc2awbIl5sahcS8cpGCaPnstRND7kRjzMbWgqOesrio=
X-Received: by 2002:ac8:664b:: with SMTP id j11mr2246814qtp.137.1571735785316;
 Tue, 22 Oct 2019 02:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com> <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
 <20191021140852.GM2819@lahna.fi.intel.com> <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
 <20191021154606.GT2819@lahna.fi.intel.com> <CACO55tsGhvG1qapRkdu_j7R534cFa5o=Gv2s4VZDrWUrxjBFwA@mail.gmail.com>
In-Reply-To: <CACO55tsGhvG1qapRkdu_j7R534cFa5o=Gv2s4VZDrWUrxjBFwA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 22 Oct 2019 11:16:14 +0200
Message-ID: <CACO55ts7hivYgN7=3bcAjWx2h8FfbR5UiKiOOExYY9m-TGRNfw@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I think there is something I totally forgot about:

When there was never a driver bound to the GPU, and if runtime power
management gets enabled on that device, runtime suspend/resume works
as expected (I am not 100% sure on if that always works, but I will
recheck that).
In the past I know that at some point I "bisected" the nouveau driver
to figure out what actually breaks it and found out that some script
executed with the help of an on-chip engine (signed script, signed
firmware, both vbios provided) makes it break. Debugging the script
lead me to the PCIe link speed changes done inside the script breaking
it.

But as "reverting" the speed change didn't make it work reliably
again, I think I need to get back on that and check if it's something
else. I will try to convert the script into C or python code to make
it more accessible to debug and hopefully I'll find something I
overlooked the last time.

On Mon, Oct 21, 2019 at 6:40 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Mon, Oct 21, 2019 at 5:46 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Mon, Oct 21, 2019 at 04:49:09PM +0200, Karol Herbst wrote:
> > > On Mon, Oct 21, 2019 at 4:09 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2019 at 03:54:09PM +0200, Karol Herbst wrote:
> > > > > > I really would like to provide you more information about such
> > > > > > workaround but I'm not aware of any ;-) I have not seen any issues like
> > > > > > this when D3cold is properly implemented in the platform.  That's why
> > > > > > I'm bit skeptical that this has anything to do with specific Intel PCIe
> > > > > > ports. More likely it is some power sequence in the _ON/_OFF() methods
> > > > > > that is run differently on Windows.
> > > > >
> > > > > yeah.. maybe. I really don't know what's the actual root cause. I just
> > > > > know that with this workaround it works perfectly fine on my and some
> > > > > other systems it was tested on. Do you know who would be best to
> > > > > approach to get proper documentation about those methods and what are
> > > > > the actual prerequisites of those methods?
> > > >
> > > > Those should be documented in the ACPI spec. Chapter 7 should explain
> > > > power resources and the device power methods in detail.
> > >
> > > either I looked up the wrong spec or the documentation isn't really
> > > saying much there.
> >
> > Well it explains those methods, _PSx, _PRx and _ON()/_OFF(). In case of
> > PCIe device you also want to check PCIe spec. PCIe 5.0 section 5.8 "PCI
> > Function Power State Transitions" has a picture about the supported
> > power state transitions and there we can find that function must be in
> > D3hot before it can be transitioned into D3cold so if the _OFF() for
> > example blindly assumes that the device is in D0 when it is called, it
> > is a bug in the BIOS.
> >
> > BTW, where can I find acpidump of such system?
>
> I am sure it's uploaded somewhere already. But it's not an issue of
> just one system. It's essentially hitting every single laptop with a
> skylake or kaby lake CPU + Nvidia GPU. I didn't see any system where
> it's actually working right now (and we are pestering nvidia about
> this issue for over a year already with no solution)
>
> I've attached an acpidump from my system.

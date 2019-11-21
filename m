Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB81105174
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKULcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 06:32:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36589 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKULcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 06:32:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id f10so2620315oto.3;
        Thu, 21 Nov 2019 03:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3k4Aw80bkAO/6lAcOnkrOVE0ZhJFwvrlGzBabrShVQ=;
        b=Kv1F6bEUhx6XQilNyRp5ccDX97+jKHY04dGPtgnXkkNmN1nLCsZet1HBp6NxiFTCog
         LFD0D3/jhQrn3W+nMSAx+K7SiH3b7BUp6boLA4Uils2pfjlE4o3TCsknqqVYMD80hAw7
         BgDVuUgWkXW8nOUM/tAavm4mCsW1TeHPJdU2VqLKkwazZ27TFUIrsjssF3fNVThU0pJ5
         z1qjBToEZMIIYuTX9F8ubmlrBHK+Bxvn4ujWxg5FuoMCbvgzUJW6nWLHA1u1F2dzaXfj
         lT85jmnalnuQ5yGCQPiD0paYorzZqOJvKqVsibm9e8jPhpJEuFcMbPpupdgK2n30PZq2
         srpQ==
X-Gm-Message-State: APjAAAXqIg6oIv7uJUPnZvBy0m/fv6zw9IXiur2wEVxHpIDmdM6TuYmt
        N3ph8zTqmHJE/KZz1+H9V+mLPUHvkRiGQdB9FTY=
X-Google-Smtp-Source: APXvYqyCvKoq/cebzpfoCwlOfAUaYaxdKEecqatFjILqmn5JZJGCEgUqfxdBRzz6K72JW/bHFhwWpS917aNaWsJQbzY=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr5838389otf.118.1574335929309;
 Thu, 21 Nov 2019 03:32:09 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <20191120162306.GM11621@lahna.fi.intel.com>
 <CACO55tsvTG2E7_3nn1sTdPQXzxaZA96k+gmSBBXjPvei6v=kxg@mail.gmail.com>
 <20191121101423.GQ11621@lahna.fi.intel.com> <CAJZ5v0hAgz4Fu=83AJE2PYUsi+Jk=Lrr4MNp5ySA9yY=3wr5rg@mail.gmail.com>
 <20191121111739.GT11621@lahna.fi.intel.com>
In-Reply-To: <20191121111739.GT11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 12:31:57 +0100
Message-ID: <CAJZ5v0h=c2d6G04kPnLzTLZ6Xn8bLfg3=F73Dz+o6fQ3w4tfPQ@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
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

On Thu, Nov 21, 2019 at 12:17 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 12:03:52PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 21, 2019 at 11:14 AM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 10:36:31PM +0100, Karol Herbst wrote:
> > > > with the branch and patch applied:
> > > > https://gist.githubusercontent.com/karolherbst/03c4c8141b0fa292d781badfa186479e/raw/5c62640afbc57d6e69ea924c338bd2836e770d02/gistfile1.txt
> > >
> > > Thanks for testing. Too bad it did not help :( I suppose there is no
> > > change if you increase the delay to say 1s?
> >
> > Well, look at the original patch in this thread.
> >
> > What it does is to prevent the device (GPU in this particular case)
> > from going into a PCI low-power state before invoking AML to power it
> > down (the AML is still invoked after this patch AFAICS), so why would
> > that have anything to do with the delays?
>
> Yes, I know what it does :) I was just thinking that maybe it's still
> the link that does not come up when we go back to D0 I guess that's not
> the case here.

I'm not sure why that would be related to putting the device into,
say, PCI D3 before invoking AML to remove power from it.  If it is not
in PCI D3 at this point, the AML still runs and still removes power
from it IIUC, so on the way back the situation is the same regardless:
the device has no power which (again) needs to be restored by AML.
That (in principle) should not depend on what happened to the device
before it lost power.

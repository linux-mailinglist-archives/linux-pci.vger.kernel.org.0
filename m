Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF6C24D4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfI3QF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 12:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QF1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 12:05:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6ED985362
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 16:05:26 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id k14so31145690iot.14
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 09:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Jo3uapkJwME3KNEX03kTFMW4ezdDySvqiZtAQI5QuE=;
        b=TycUkxefpN7zFw/fj3hbJRcyqfNpy6DR14QbIYyvdnE73wV6xBF5av1+bFE53b5qlw
         Ze1a07wSj4Un2loj4HqQ+maI+6O9uOVZk39QLauUOHSMjO6slJWXAQ6pyx7W6RaExvL7
         x7d11TZFBwxx3ykHKcGhS4YToCx+YirCj9JH2JomTSXuhDZXrzw58Njcx4FZibxz5Lr+
         Lw0LDjys6LGxIg+3PBFg8PAfKGJuilXyUpz31V5IE7sea+WNtMZGwj5oJ7eYPypqqzmu
         dTUTyNMAIZDelHes0PKRbbZ987SiwcDvNtP8gfOzEpndgDqBmdOd/SpQum4zmOkBULym
         ieTw==
X-Gm-Message-State: APjAAAVklGvHwQ5rmM0begcBypgAyIDWElNRB3NVqJIAqFgj3Xwd/jk7
        pKyHpj/pHxlWcF5Id5SUJj0prmiInWofgo4DgOawSfRho/DOCAl5pNoBOOovUrRPOTc9F1ofGKm
        uWmVPHdf7opjTxAXK8lGd/H0iUtF9Tw4cOFVd
X-Received: by 2002:a5d:9a17:: with SMTP id s23mr21659738iol.171.1569859526157;
        Mon, 30 Sep 2019 09:05:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypngOWw3ZSLYDhxUEQ9NgyFEx9J+foY40JfzIJvF4e6vjzQEx3SO7djN0Th8o3+JHT5FzrewlaBaaAcXyAtrE=
X-Received: by 2002:a5d:9a17:: with SMTP id s23mr21659711iol.171.1569859525882;
 Mon, 30 Sep 2019 09:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com> <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com>
In-Reply-To: <20190930092934.GT2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 30 Sep 2019 18:05:14 +0200
Message-ID: <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

still happens with your patch applied. The machine simply gets shut down.

dmesg can be found here:
https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt

If there are no other things to try out, I will post the updated patch shortly.

On Mon, Sep 30, 2019 at 11:29 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Sep 30, 2019 at 11:15:48AM +0200, Karol Herbst wrote:
> > On Mon, Sep 30, 2019 at 10:05 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi Karol,
> > >
> > > On Fri, Sep 27, 2019 at 11:53:48PM +0200, Karol Herbst wrote:
> > > > > What exactly is the serious issue?  I guess it's that the rescan
> > > > > doesn't detect the GPU, which means it's not responding to config
> > > > > accesses?  Is there any timing component here, e.g., maybe we're
> > > > > missing some delay like the ones Mika is adding to the reset paths?
> > > >
> > > > When I was checking up on some of the PCI registers of the bridge
> > > > controller, the slot detection told me that there is no device
> > > > recognized anymore. I don't know which register it was anymore, though
> > > > I guess one could read it up in the SoC spec document by Intel.
> > > >
> > > > My guess is, that the bridge controller fails to detect the GPU being
> > > > here or actively threw it of the bus or something. But a normal system
> > > > suspend/resume cycle brings the GPU back online (doing a rescan via
> > > > sysfs gets the device detected again)
> > >
> > > Can you elaborate a bit what kind of scenario the issue happens (e.g
> > > steps how it reproduces)? It was not 100% clear from the changelog. Also
> > > what the result when the failure happens?
> > >
> >
> > yeah, I already have an updated patch in the works which also does the
> > rework Bjorn suggested. Had no time yet to test if I didn't mess it
> > up.
> >
> > I am also thinking of adding a kernel parameter to enable this
> > workaround on demand, but not quite sure on that one yet.
>
> Right, I think it would be good to figure out the root cause before
> adding any workarounds ;-) It might very well be that we are just
> missing something the PCIe spec requires but not implemented in Linux.
>
> > > I see there is a script that does something but unfortunately I'm not
> > > fluent in Python so can't extract the steps how the issue can be
> > > reproduced ;-)
> > >
> > > One thing that I'm working on is that Linux PCI subsystem misses certain
> > > delays that are needed after D3cold -> D0 transition, otherwise the
> > > device and/or link may not be ready before we access it. What you are
> > > experiencing sounds similar. I wonder if you could try the following
> > > patch and see if it makes any difference?
> > >
> > > https://patchwork.kernel.org/patch/11106611/
> >
> > I think I already tried this path. The problem isn't that the device
> > isn't accessible too late, but that it seems that the device
> > completely falls off the bus. But I can retest again just to be sure.
>
> Yes, please try it and share full dmesg if/when the failure still happens.

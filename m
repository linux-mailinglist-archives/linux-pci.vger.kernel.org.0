Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A471F1E18
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgFHRDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbgFHRDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 13:03:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1DC08C5C3
        for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2020 10:03:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p70so15932627oic.12
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2020 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgQYxvFZWg8R3Nlegrpw6Fmx8zeh+1Yrh8H37pzF9NY=;
        b=bLhMddbsGCNRw0hSzT5j2w5p2YPFaoPVJF3QZXzvZEB8C8j7v2yRtntrqmMnR7/aEc
         y7ZPyWU1jDno4pmlLLhJFwjJvsFZSBNEwVv5DEyRqxcb+1Ky3fSWchIJXMSHwBVtSfKu
         rwnChBaVdQq21YU6h7eNL+kRHUlw23HMT2CHSxEyp5xpenPbb1Bz8srah+OC/R835z57
         aSLpbQmSlU4mCeF8WZeZorz4fkbZ0lOBw2X6Axq2Pd/k9ulEHCD4VYkPeMA20kduUFdf
         00pGq8oeE+r1rV3/BEHt5RfXDOlxXlAvv06g7QFP7oWbK4kKsKHSN/OQ5L8iPB+tZWE9
         rTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgQYxvFZWg8R3Nlegrpw6Fmx8zeh+1Yrh8H37pzF9NY=;
        b=nUqgBwf3nUD3oPLl7TYc7QOOCFzBI98UBysiaGFez6H1N6YUgWqHWgMZFTQk5gPukO
         0kR14cawahj1DlMWJzlsWuQLbLCrEQrdvSbgs5wBBF7ZYcQLzqSaEQGD8ZOhWtrCxMxC
         UwE5op1H/3ftEtN1DG9hH2nWDd9xLy09XgXCeFcqQVdSmHljgEyXT43rIueRf+RzONjr
         932dB4EwMUXRPa3qOyM88oPjWtkxLzt3t4qf5hVzKII1n32xtOHOBVCRsMtfQIkyAOiR
         jrIsneRGvxi5uBbgjNr87EmXz4zCiDNiefXdVkJE4Ac280/3b755YsYx2Sbtn6RBIXgs
         GZ4w==
X-Gm-Message-State: AOAM533arp/K8P6RZiT/J6gsYQOrxOCeimyT53nvDuYeKO2RjQI6WOdL
        0ApAVOHe0jiqAgurIF7mdGxX/IM2QowUOsCUVzFhzg==
X-Google-Smtp-Source: ABdhPJylmML4PJZou/Aw5cNLGCyODpu2esWkIXC7TxPuc3Cb+/aSd5WlPFKxUC2AVP0CRcqxh9Xz6sLxnkDzYK/vMgc=
X-Received: by 2002:aca:da56:: with SMTP id r83mr260756oig.106.1591635830100;
 Mon, 08 Jun 2020 10:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520> <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com> <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com> <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com> <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
In-Reply-To: <20200607113632.GA49147@kroah.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Mon, 8 Jun 2020 10:03:38 -0700
Message-ID: <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > I feel a lot of resistance to the proposal, however, I'm not hearing
> > any realistic solutions that may help us to move forward. We want to
> > go with a solution that is acceptable upstream as that is our mission,
> > and also helps the community, however the behemoth task of "inspect
> > all drivers and fix them" before launching a product is really an
> > unfair ask I feel :-(. Can you help us by suggesting a proposal that
> > does not require us to trust a driver equally for internal / external
> > devices?
>
> I have no idea why you feel you have to "inspect all drivers" other than
> the fact that for some reason _you_ do not feel they are secure today.
>
> What type of "assurance" are you, or anyone else going to be able to
> provide for any kernel driver that would meet such a "I feel good now"
> level?  Have you done that work for any specific driver already so that
> you can show us what you mean by this effort?  Perhaps it's as simple as
> "oh look, this tool over here runs 'clean' on the source code, all is
> good!", or not, I really have no idea.

I think there's a disconnect somewhere in this discussion... maybe
we're just approaching this with different assumptions?

I think you recognize the potential for driver vulnerabilities when
binding to new or potentially hostile devices that may be spoofing
DID/VID/class/etc than then go on to abuse driver trust or the driver
using unvalidated inputs from the device to crash or run arbitrary
code on the target system.

Yes such drivers should be fixed, no doubt.  But without lots of
fuzzing (we're working on this) and testing we'd like to avoid
exposing that attack surface at all.

I think your suggestion to disable driver binding once the initial
bus/slot devices have been bound will probably work for this
situation.  I just wanted to be clear that without some auditing,
fuzzing, and additional testing, we simply have to assume that drivers
are *not* secure and avoid using them on untrusted devices until we're
fairly confident they can handle them (whether just misbehaving or
malicious), in combination with other approaches like IOMMUs of
course.  And this isn't because we don't trust driver authors or
kernel developers to dtrt, it's just that for many devices (maybe USB
is an exception) I think driver authors haven't had to consider this
case much, and so I think it's prudent to expect bugs in this area
that we need to find & fix.

Thanks,
Jesse

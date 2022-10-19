Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06086046A1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJSNQJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 19 Oct 2022 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJSNPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 09:15:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227351DC825;
        Wed, 19 Oct 2022 06:01:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z8so11563187qtv.5;
        Wed, 19 Oct 2022 06:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3neje0k7T3cx7D7C9HLG6iO3ovR2451tT9bBWNpd1HI=;
        b=U4j1tiVNLgBom3Fbg9Ja6CyfAQ5ADhndxt/jZWqsvacNYnrp6dOU5t2RthWZryJtwq
         RTSuxnWLtFWPzTbWKoZvDA60lJT8nfxbTuXhjgYNRc02MZ4FD01NjA/q8c6br7Zgq7Ew
         ys1qJhAOStddz7ablFkr3vAwTLPOI8n7Tj/4JwDv6XqTfvXUuhgwNufPkE2UafkCGFr6
         Eq/THjOHSWHtkPAsGiR1ATuR/NA+5dJ6v/gRp5tCxL4pfBBDU98+PQo9oMJGPDOF+8ET
         tla4SYItiwWyv0aGt6upZT1tlOMrLxDo0MtM0ckzC2Y7TIXDt/q3PovNs+eNKnIjXKg9
         SHwQ==
X-Gm-Message-State: ACrzQf0ynKggrsI/aw5Qj8Mg5GfemhvuCyCQ5j2+46MTe24ko3S1+uhb
        wtKabWxdgwuyAOCt6xx+bx0YqYzleCjJKeFYZ+U=
X-Google-Smtp-Source: AMsMyM5AXDZhR6X0SfzaRw+VO5tHTbxkxUczN5nB/2Y/zue0gU7uIAIrZQUDwIWkE8nim4szWBMx9SDfRMrdJB6x0YA=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr6319785qtb.494.1666184414930; Wed, 19
 Oct 2022 06:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <12097002.O9o76ZdvQC@kreacher> <Y0+7Ug9Yh6J6uHVr@intel.com>
 <CAJZ5v0gKW9S29xS2+qkcopzYtZKTcM=ZT-Jjc4fnEJfu=oYKaw@mail.gmail.com> <Y0/sGveKPjuUWOhO@intel.com>
In-Reply-To: <Y0/sGveKPjuUWOhO@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 15:00:01 +0200
Message-ID: <CAJZ5v0gdcVSOPkfs0yzfubpU9EXu02n2u8Pau7sE=yrZ-mvDEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in acpi_get_pci_dev()
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 2:22 PM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Oct 19, 2022 at 01:35:26PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Oct 19, 2022 at 11:02 AM Ville Syrjälä
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Tue, Oct 18, 2022 at 07:34:03PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()") failed
> > > > to reference count the device returned by acpi_get_pci_dev() as
> > > > expected by its callers which in some cases may cause device objects
> > > > to be dropped prematurely.
> > > >
> > > > Add the missing get_device() to acpi_get_pci_dev().
> > > >
> > > > Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> > >
> > > FYI this (and the rtc-cmos regression discussed in
> > > https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/)
> > > took down the entire Intel gfx CI.
> >
> > Sorry for the disturbance.
> >
> > > I've applied both fixes into our fixup branch and things are looking much
> > > healthier now.
> >
> > Thanks for letting me know.
> >
> > I've just added the $subject patch to my linux-next branch as an
> > urgent fix and the other one has been applied to the RTC tree.
> >
> > > This one caused i915 selftests to eat a lot of POISON_FREE
> > > in the CI. While bisecting it locally I didn't have
> > > poisoning enabled so I got refcount_t undeflows instead.
> >
> > Unfortunately, making no mistakes is generally hard to offer.
> >
> > If catching things like this early is better, what about pulling my
> > bleeding-edge branch, where all of my changes are staged before going
> > into linux-next, into the CI?
>
> Pretty sure we don't have the resources to become the CI for
> everyone. So testing random trees is not really possible. And
> the alternative of pulling random trees into drm-tip is probably
> a not a popular idea either. We used to pull in the sound tree
> since it's pretty closely tied to graphics, but I think we
> stopped even that because it eneded up pulling the whole of
> -rc1 in at random points in time when we were't expecting it.

I see.

> Ideally each subsystem would have its own CI, or there should
> be some kernel wide thing. But I suppose the progress towards
> something like that is glacial.

Well, I definitely cannot afford a dedicated CI just for my tree and I
haven't got any useful information from KernlCI yet (even though hey
pull and test my linux-next branch on a regular basis).

KernelCI seems to be focusing on different set of hardware, so to speak.

> That said, we do test linux-next to some degree. And looks like
> at least one of these could have been caught a bit earlier through
> that. Unfortunately no one is really keeping an eye on that so
> things tend to slip through. Probably need to figure out something
> to make better use of that.

I think it could also be possible to contribute to KernelCI to get
more useful x86 coverage from it.

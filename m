Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D825A3A0467
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhFHTdj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 15:33:39 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45882 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbhFHTbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 15:31:41 -0400
Received: by mail-ot1-f47.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso8436050oto.12;
        Tue, 08 Jun 2021 12:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ch6et4pRDmjQu3/wx//Nno/PiXeFVqKzlKJOh5RAdw=;
        b=CCM1gEXhXdZU9EDaznCvj0n80ur+jNxqZWogR6TWSkkpmOoqNf63l0fhABSOhgtArf
         MzwVEMPdE6DkAZBsxTVoB8bTWia/oOn2yuSBSDD82M7tdwu3jg9z1Ga5HqhmryiT2Pt/
         VmscsJeuPph2wZtW/N4YgyVFRN4reJ7Zvyc1QsJCIBDf8pWi0yWwCC6p+aY06dfziZk7
         rZYogS2VLp45EOuov6KJF25J+eXMuDhRm3ZQ66CymgM+o13L4ESn20TxVCOBUPY1PBcj
         Ci5J8wAk8jrYNP8pg01bPpAeMSKUFTtIeEULWxOl9VfTrUFTEAYuL9TpiuzJdQo9rYpd
         1FzQ==
X-Gm-Message-State: AOAM530SwCZF5CHAvWz02BZBlkc03RC9psb+7P9a12uWVkrvfjASzE8V
        BHDJaSPcBZ1wNNnRI3V1kut1CPzXDr19EDZnmR8=
X-Google-Smtp-Source: ABdhPJxbXahRMIfcVSD5nzbjhh013HKWq+iV+0qweZYEr2yE2NDZDif1Oi6rmb5cd+YkvJFHx9G+ZXjDACXzfw79J8k=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr748109otb.206.1623180576837;
 Tue, 08 Jun 2021 12:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
 <CAPcyv4hZTrf8a-Ga6yWxMqeg7xy=p5_m6CXKssXY-eKG9otsqA@mail.gmail.com> <CAPcyv4hBVK+ndxGdJykFiTihNKbaBidmmcVh71mvOhkouwZj+w@mail.gmail.com>
In-Reply-To: <CAPcyv4hBVK+ndxGdJykFiTihNKbaBidmmcVh71mvOhkouwZj+w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 21:29:25 +0200
Message-ID: <CAJZ5v0g6HTC4D8b_3M8CpWef5Ro9VLHE3rSZKf5gWWZ9EVLF7g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] cxl/acpi: Local definition of ACPICA infrastructure
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 8, 2021 at 8:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Jun 7, 2021 at 10:03 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Jun 7, 2021 at 5:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > The recently released CXL specification change (ECN) for the CXL Fixed
> > > > Memory Window Structure (CFMWS) extension to the CXL Early Discovery
> > > > Table (CEDT) enables a large amount of functionality. It defines the
> > > > root of a CXL memory topology and is needed for all OS flows for CXL
> > > > provisioning CXL memory expanders. For ease of merging and tree
> > > > management add the new ACPI definition locally (drivers/cxl/acpi.h) in
> > > > such a way that they will not collide with the eventual arrival of the
> > > > definitions through the ACPICA project to their final location
> > > > (drivers/acpi/actbl1.h).
> > >
> > > I've just applied the ACPICA series including this change which can be
> > > made available as a forward-only branch in my tree, if that helps.
> >
> > Yes, please, that would be my preference. When I created this patch
> > the concern was that a stable branch was possibly weeks away.
>
> Rafael, I see "4a2c1dcfaf59 ACPICA: Add the CFMWS structure definition
> to the CEDT table" in your tree, I can safely assume that commit will
> not rebase at this point?

Yes, please.

> I'll likely rewind your acpica branch to
> that point and merge there to avoid carrying any unrelated follow-on
> commits.

Sure.

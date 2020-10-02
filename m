Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA782814B1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgJBOKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 10:10:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33274 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgJBOKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 10:10:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so1355180oie.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2020 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMMaAptiKzg1HnJTx7p6PufJCG2MBS2nifEpRjWbry4=;
        b=Fl/+O7/4axj8UXkdRNipn26NdUW3B5ABq+wv/ZYleCs7cCY2IfHFnOhmEVilTt8P2z
         XunuRRYv6VSgXTUuSLYLwNlQqB5WM2KOrsY4yu8mUZW7xku1faKfjLtY302js/OZy2OJ
         cuXbTyplpWg/m4ELUW1cDrr1GEjJaQI7601LpJATbvdBCtZPwW9NiTT6W3KNVF2CQaZo
         qtErf/RLjxpw1mdKQI29Wzz9kYH+oD/tWFAmOlcbUG1XCgP7hPwBkAEzMbedjtJ9bGPX
         3SHCgT1TuqFIwjojhl+KWkYQJrX9eBqL009Iz50Jtedu/BQsBKZRfqHkD0QvjGV7flWT
         TJ+w==
X-Gm-Message-State: AOAM532DTTntJKz9vVHzdkc1SuU6E5r9MohT1eDUPff7EN91ipCIUHme
        ROpGsuvPG/HZjwbxH6U2IPwdQwdH+UkLfteqoFg=
X-Google-Smtp-Source: ABdhPJyHxrxb8cnZpflF5lTZ+KNfBk84ajusgdA/Yb6aSvy5lIta/yn9s7FVhnhopZjZHIhTGqBCcfKybYQ8aA3aov8=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr1408456oid.110.1601647842170;
 Fri, 02 Oct 2020 07:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PoDdSeOxGgr5TzVwTTJmLb7BapXyG0KDs92P=wXzTNfg@mail.gmail.com>
 <20200922065434.GA19668@wunner.de> <CADnq5_MfkojHbquHq4Le6ioSFOY9XdaNBapAEmyOgf0CGMTaUg@mail.gmail.com>
 <20200923121509.GA25329@wunner.de> <20201002065726.GA22967@wunner.de>
In-Reply-To: <20201002065726.GA22967@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 16:10:29 +0200
Message-ID: <CAJZ5v0hob=i1LLPQej0TOt9fBtXCv6peyCjdqLM0U2W8J3wWkg@mail.gmail.com>
Subject: Re: Enabling d3 support on hotplug bridges
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 2, 2020 at 8:57 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, Sep 23, 2020 at 02:15:09PM +0200, Lukas Wunner wrote:
> > I've just taken a look at the ACPI dumps provided by Michal Rostecki
> > and Arthur Borsboom in the Gitlab bugs linked below.  The topology
> > looks like this:
> >
> > 00:01.1        Root Port         [\_SB.PCI0.GPP0]
> >   01:00.0      Switch Upstream   [\_SB.PCI0.GPP0.SWUS]
> >     02:00.0    Switch Downstream [\_SB.PCI0.GPP0.SWUS.SWDS]
> >       03:00.0  dGPU              [\_SB.PCI0.GPP0.SWUS.SWDS.VGA]
> >       03:00.1  dGPU Audio        [\_SB.PCI0.GPP0.SWUS.SWDS.HDAU]
> >
> > The Root Port is hotplug-capable but is not suspended because we only
> > allow that for Thunderbolt hotplug ports or root ports with Microsoft's
> > HotPlugSupportInD3 _DSD property.  However, that _DSD is not present
> > in the ACPI dumps and the Root Port is obviously not a Thunderbolt
> > port either.
>
> I took another, closer look at the ACPI tables and couldn't find anything
> specific about the Root Port or the GPU below, save for Power Resources
> and corresponding _PS0 / _PS3 methods in the Root Port's namespace.
>
> If a hotplug port is explicitly power manageable by ACPI through these
> methods, it should be safe to suspend it to D3.  I wouldn't be surprised
> if that's what Windows does.  So I've just submitted a patch to whitelist
> such ports for D3.  It has been tested successfully by two users with
> affected laptops:
>
> https://lore.kernel.org/linux-pci/cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de/

This looks reasonable to me.

Please feel free a Reviewed-by from me to the patch pointed to by the
link above.

Cheers!

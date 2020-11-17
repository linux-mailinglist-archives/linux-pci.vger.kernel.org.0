Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45D2B6ACA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgKQQ5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 11:57:40 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:35263 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKQQ5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 11:57:39 -0500
Received: by mail-ot1-f49.google.com with SMTP id n11so20124324ota.2;
        Tue, 17 Nov 2020 08:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NLRFj8nHCygasEBHceubBbH3HeMeHr99Ml1bGtCW9o=;
        b=N5aNtxPcylGbM7jh2INd3qvaC2FQvMEQJUNcoC2Isb+oovuuhULsTKJfVzNgjVu1oa
         //h7p7GWTg9wbRmD8/8aCuycjv5fxjsnGkD2s3j2TyjRVLII3ZN0XKFbW8VHUznWgmT2
         af1Q/U5SLoPQug9airMTihl8382tk5lfCGm9uiH60lDHgiWHA7AaY251NTHCBpw6K9Ul
         /KGo3Iqz3i8hYy0VW64EGqmY5MMDYFUdRXllWQiIC/pI40bARewAIqGe5dgoaDljvS1/
         +D+GNtn8hrpRmcfLy6fVcwVn4BrF65wyUVyOvIlC5zuCCllheJyqhWXl2QTzEOZCsY56
         BGbg==
X-Gm-Message-State: AOAM531yvQqzPpk50ipQrIXigzHWbqhnqZX3g2YSSSL2MSxRE+xkts1V
        p93PizmXCLRHpdeJ5u5ZTD0eERFf26GXHs7cvdo=
X-Google-Smtp-Source: ABdhPJzociPk59c3aEW92lx5PQkRb0ADhjgmmggbLMdVyRcJQxet3/KWpklyWaGp1kYUDAKDDMgxsfmnnXhX+JFoXo8=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr3851962otu.206.1605632258611;
 Tue, 17 Nov 2020 08:57:38 -0800 (PST)
MIME-Version: 1.0
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com> <20201117163817.GA1397220@bjorn-Precision-5520>
In-Reply-To: <20201117163817.GA1397220@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 17:57:27 +0100
Message-ID: <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 5:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to Rafael, author of the commit you mentioned,
> +cc Mika, Kai Heng, Lukas, linux-pm, linux-kernel]
>
> On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
> > More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
> > ("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").
> >
> > Reason given: "avoid breakage on systems where ACPI-based wake-up is
> > known to fail for some devices"
> > Unfortunately the commit message doesn't mention any affected  devices
> > or systems.

Even if it did that, it wouldn't have been a full list almost for sure.

We had received multiple problem reports related to that, most likely
because the ACPI PM in BIOSes at that time was tailored for
system-wide PM transitions only.

> > With Runtime PM disabled e.g. the PHY on network devices may remain
> > powered up even with no cable plugged in, affecting battery lifetime
> > on mobile devices. Currently we have to rely on the respective distro
> > or user to enable Runtime PM via sysfs (echo auto > power/control).
> > Some devices work around this restriction by calling pm_runtime_allow
> > in their probe routine, even though that's not recommended by
> > https://www.kernel.org/doc/Documentation/power/pci.txt
> >
> > Disabling Runtime PM per default seems to be a big hammer, a quirk
> > for affected devices / systems may had been better. And we still
> > have the option to disable Runtime PM for selected devices via sysfs.
> >
> > So, to cut a long story short: Wouldn't it be time to remove this
> > restriction?
>
> I don't know the history of this, but maybe Rafael or the others can
> shed some light on it.

The systems that had those problems 10 years ago would still have
them, but I expect there to be more systems where runtime PM can be
enabled by default for PCI devices without issues.

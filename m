Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67623E7C73
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhHJPhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 11:37:53 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41616
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243361AbhHJPhw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Aug 2021 11:37:52 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 18F9F3F0A1
        for <linux-pci@vger.kernel.org>; Tue, 10 Aug 2021 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628609849;
        bh=V4JCrLtO4cRvhqN1sG1W5Ma2FLvhmCKkVeREp756lBA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NHGnd8yj29JBgnvB3oWve0BipQxHbotTVZFJxJFqAFIlnb8dY7lJ+5zzNYQthgz3m
         zVWBnXur64Ow7A6zR6xvr/FUyiFITTRR1MnVIfGpHAJX09PpQZ4/dbzzHgbNvT6yw2
         vmckRdDpI0/x8yo8edlEiS1b52ZYcRbH+ByVeGSPgzxWP7ZX+Ojilq+TbpjFuWS38V
         SbPEyohwhnsfRlE5NnGWgC3KDrWcKgZPQsQ+nGrLoqEvh4ZxZBmgA51mmEzfx7qIIg
         LweWZ/FVG4mYiPtsgv0jFvjQa73Xcew3UfLFh9xxMMw0TrCxUttYvYMQTkkLsH0Utw
         rlJd6ygHGkZhQ==
Received: by mail-ed1-f70.google.com with SMTP id v11-20020a056402348bb02903be68e116adso3053882edc.14
        for <linux-pci@vger.kernel.org>; Tue, 10 Aug 2021 08:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4JCrLtO4cRvhqN1sG1W5Ma2FLvhmCKkVeREp756lBA=;
        b=iUpnRR8DM7J1/fZKqTJNe4DJPlMUiTHixXDsOQ+ohuIoDCb6ikjXVeghlvwgukgXv4
         G/nx51haRku3cGIZKD6Vn8uED+gnpUUhY7VjPd+wm9X3qx17/SNset2k/0xtWgXhVQLv
         nybDPDNciXX6IZejGghBfn2kuc+oCHaDhJjv396yvZ6LkAU/ZFlIvC9nYyOFpCMFw5ig
         WEy//WWmN/6o7b5cqxGioK+ss4pJbWNWJMr+0LhpTauVuEuTvW6XstFDREq4AbCpZd+F
         OPiWhSLYHiGsCQchVeDoI5unR5VlAjG4bSc29eVL68mcwMHiZUpRBSvEle0OloYCLLy3
         BXHg==
X-Gm-Message-State: AOAM531LTKZolwq+0lcTRJIfvwQcjT7obcCFL5HaaJ2/Ahe5rLuseGDa
        DbXalQe0FjWV7reHoGnnvzRa0uJsrDH2WB8Y65i2FEtVmMD5l+7fnfsxmaFgKRBxFbmpG9QHlv1
        1Q+tjfQxR+xFiTVoQE96yISSQmBnlLO8tLxobJN8+cKKWaxgG7tGQrw==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr8750047ejs.230.1628609847566;
        Tue, 10 Aug 2021 08:37:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO79SEXR3fza5J1CuMJKz2W4dwLasWiXGBGugj43FtUB/yk1977ekIs7BvIay+TLOvqYt8fvr4BN9qEwlT2oo=
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr8749848ejs.230.1628609844666;
 Tue, 10 Aug 2021 08:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com> <20210809094731.GA16595@wunner.de>
 <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com> <20210809150005.GA6916@wunner.de>
In-Reply-To: <20210809150005.GA6916@wunner.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 10 Aug 2021 23:37:12 +0800
Message-ID: <CAAd53p7qm=K99xO1n0Pwmn020Q7_iDj2S6-QGjeRjP0CpSphTg@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 9, 2021 at 11:00 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> [cc += Rafael]
>
> On Mon, Aug 09, 2021 at 06:40:41PM +0800, Kai-Heng Feng wrote:
> > On Mon, Aug 9, 2021 at 5:47 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, Aug 09, 2021 at 12:24:12PM +0800, Kai-Heng Feng wrote:
> > > > Some platforms cannot detect ethernet hotplug once its upstream port is
> > > > runtime suspended because PME isn't enabled in _OSC.
> > >
> > > If PME is not handled natively, why does the NIC runtime suspend?
> > > Shouldn't this be fixed in the NIC driver by keeping the device
> > > runtime active if PME cannot be used?
> >
> > That means we need to fix every user of pci_dev_run_wake(), or fix the
> > issue in pci_dev_run_wake() helper itself.
>
> If PME is not granted to the OS, the only consequence is that the PME
> port service is not instantiated at the root port.  But PME is still
> enabled for downstream devices.  Maybe that's a mistake?  I think the
> ACPI spec is a little unclear what to do if PME control is *not* granted.
> It only specifies what to do if PME control is *granted*:

So do you prefer to just disable runtime PM for the downstream device?

>
>    "If the OS successfully receives control of this feature, it must
>     handle power management events as described in the PCI Express Base
>     Specification."
>
>    "If firmware allows the OS control of this feature, then in the context
>     of the _OSC method it must ensure that all PMEs are routed to root port
>     interrupts as described in the PCI Express Base Specification.
>     Additionally, after control is transferred to the OS, firmware must not
>     update the PME Status field in the Root Status register or the PME
>     Interrupt Enable field in the Root Control register. If control of this
>     feature was requested and denied or was not requested, firmware returns
>     this bit set to 0."
>
> Perhaps something like the below is appropriate, I'm not sure.
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 091b4a4..7e64185 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3099,7 +3099,7 @@ void pci_pm_init(struct pci_dev *dev)
>         }
>
>         pmc &= PCI_PM_CAP_PME_MASK;
> -       if (pmc) {
> +       if (pmc && pci_find_host_bridge(dev->bus)->native_pme) {
>                 pci_info(dev, "PME# supported from%s%s%s%s%s\n",
>                          (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
>                          (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
>
>

I think this will also prevent non-root port devices from using PME.

[snipped]

> >
> > I think PME IRQ and D3cold are different things here.
> > The root port of the affected NIC doesn't support D3cold because
> > there's no power resource.
>
> If a bridge is runtime suspended to D3, the hierarchy below it is
> inaccessible, which is basically the same as if it's put in D3cold,
> hence the name pci_dev_check_d3cold().  That function allows a device
> to block an upstream bridge from runtime suspending because the device
> is not allowed to go to D3cold.  The function specifically checks whether
> a device is PME-capable from D3cold.  The NIC claims it's capable but
> the PME event has no effect because PME control wasn't granted to the
> OS and firmware neglected to set PME Interrupt Enable in the Root Control
> register.  We could check for this case and block runtime PM of bridges
> based on the rationale that PME polling is needed to detect wakeup.

So for this case, should we prevent the downstream devices from
runtime suspending, or let it suspend but keep the root port active in
order to make pci_pme_list_scan() work?

Kai-Heng

>
> Thanks,
>
> Lukas

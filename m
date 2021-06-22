Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DC3B042F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFVMXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 08:23:36 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39649 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFVMXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 08:23:36 -0400
Received: by mail-oi1-f176.google.com with SMTP id m137so23527335oig.6;
        Tue, 22 Jun 2021 05:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZYDZKvqn5RUIF5RdEqesk2HyugkV5KHruVqM1pBjnQ=;
        b=ih/L7mckemXNVVirFTUoIDoy+PaU5yxoBpEynOikjb0IYBORjDnZSPWTFxNkafKeOc
         w0suU34gZKVwUhZWSbddAsQNGyaEkwQ1TMSrB7RSR2gtS0Wfisyh1DL4jEkbF96fc76j
         VygQEzcUfCsZVs/VKZiVwDWpGAlYLAii/ViMLrNh5heHaaqz6rJOn0TZDD+UAy89qc6k
         55e6t6h4olJ5uU7dfNjr7fS7y8Osnd0kIOB1qkN3iTWTUKHBS//LOpPLXZq69hd+SBpa
         UkIN8CuLUS48L2teZ/8Gga3+wq63dyTvRpQUpRiIKYRwGWVfCnXvzMfefa97OtHz6CZl
         +YZw==
X-Gm-Message-State: AOAM532DtlJDT+zZ1CDF+mnZyGBB0uKqb0pqUmXDeu/FjLMPpUjgR9NF
        LJuOiWCFjlY8G44x4LUpwd1ZLeybP7z1o3qhBZw=
X-Google-Smtp-Source: ABdhPJyLsZOI1aSRXzpQfGzAVUpFHDUXhxWlEc/a8ulGsQ0/wesWKrBLi8PmY5ghpoON+k/VTYOBPvumZEsSFtmYSPc=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr2847505oia.157.1624364479311;
 Tue, 22 Jun 2021 05:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210621220249.GA3306177@bjorn-Precision-5520>
In-Reply-To: <20210621220249.GA3306177@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 14:21:06 +0200
Message-ID: <CAJZ5v0gkETL83rm71LiJ8sed=UFn00_Sss8wJ20-+KQiJR0hew@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 213481] e1000e
 hardware failure due to PCI patch in all kernels 5.10.36+ with Intel I219-V]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael <phyre@rogers.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 12:02 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> FYI.  Looks like 4514d991d992 ("PCI: PM: Do not read power state in
> pci_enable_device_flags()") appeared in v5.13-rc1, so it would be nice
> to fix before v5.13.

I think let's revert it for now and revisit.

Do you want me to push the revert?

> https://bugzilla.kernel.org/show_bug.cgi?id=213481
>
> Initial report:
>
>   On the 4.19 kernel, this works perfect.  It also works perfectly in
>   Windows.  If I reboot into 4.19, there is no problem with networking,
>   however in 5.10, there is ZERO network connectivity.  The link NEVER
>   comes up.  You can't assign an IP address to the interface.
>
>
> From comment #2:
>
>   If I revert commit 4514d991d99211f225d83b7e640285f29f0755d0 (
>   https://github.com/torvalds/linux/commit/4514d991d99211f225d83b7e640285f29f0755d0)
>   from the 5.10.36 kernel, I do NOT have this hardware failure
>   message.  This commit relates to PCI power state.
>
>   It would appear something about this change that the e1000e driver
>   is not handling properly on this system, causing the card to not
>   work.
>
>   As mentioned this is in current kernel versions (5.13, 5.11, and
>   5.10.36+).  Given that this is a regression, a breaking change for
>   the usability of these cards, and we know exactly what causes it for
>   a hopefully easy fix, I've upped the severity.

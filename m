Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362F651E1B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 00:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFXWUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 18:20:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33134 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFXWUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 18:20:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id f80so11024202oib.0;
        Mon, 24 Jun 2019 15:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2mdj71OojvPofZElDA3A0qbxcCan0Gcd6RJ7oQb2rg=;
        b=LgDpIeDj2w9bJ1yoOEsam4nLZOGjutw/qb6JzKt+Artj50DG+px7jEyjkLj7BOX5Ua
         NHPrDdr4HAQqdX+d1ufA2N0I0kRxKfsWI1ULlUXzYkzgmYmmEX8dheNgo+uodJK/zlQ9
         DShe0xXP2O68QhF1oL2sLYYDTsDQEcPCnCu7dFeiiYAOcjJBvjfG3sVz7uyST6LgRMrg
         u1IX2fngxb4Zsic/8ep5Wzp/hBqL3tUGOLnJGlIRIN2n+rsFGCEKBD/bXuguQJweQJjh
         GyqUUc+9fyubnFukEoZri5HykTSWA2gZrK2quECdK94KMjGbErQR7eGWHuSF9uEuHfMJ
         YAFg==
X-Gm-Message-State: APjAAAWgMRMAuQbuZLoDCwUDJ+LmWJpT1zuUVndQJFfG80CIkuM0yQJZ
        8hIrlhvHek1R5nWGRdO0dEnm+t0ekW/prPTDHNKNEVog
X-Google-Smtp-Source: APXvYqxnYN3S5xvkVR/2yGjsDmezNKCQ49nSrTtq5aqk54tjvTYd48k6PRBqiDqHPJTyJ2mrqkZT9zdO/Q1vaEKLqqQ=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr12597021oih.103.1561414837894;
 Mon, 24 Jun 2019 15:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <1668247.RaJIPSxJUN@kreacher> <9906d02b-8c77-f2c8-7168-93ea444b950e@nvidia.com>
 <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jun 2019 00:20:26 +0200
Message-ID: <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 24, 2019 at 11:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> > Hi Rafael,
> >
> > On 13/06/2019 22:59, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > > attempted to avoid a problem with devices whose drivers want them to
> > > stay in D0 over suspend-to-idle and resume, but it did not go as far
> > > as it should with that.
> > >
> > > Namely, first of all, the power state of a PCI bridge with a
> > > downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
> > > sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
> > > transactions on its secondary bus), but that is not actively enforced
> > > during system-wide PM transitions, so use the skip_bus_pm flag
> > > introduced by commit d491f2b75237 for that.
> > >
> > > Second, the configuration of devices left in D0 (whatever the reason)
> > > during suspend-to-idle need not be changed and attempting to put them
> > > into D0 again by force is pointless, so explicitly avoid doing that.
> > >
> > > Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > I have noticed a regression in both the mainline and -next branches on
> > one of our boards when testing suspend. The bisect is point to this
> > commit and reverting on top of mainline does fix the problem. So far I
> > have not looked at this in close detail but kernel log is showing ...
>
> Can you please collect a log like that, but with dynamic debug in
> pci-driver.c enabled?
>
> Note that reverting this commit is rather out of the question, so we
> need to get to the bottom of the failure.

I suspect that there is a problem with the pm_suspend_via_firmware()
check which returns 'false' on the affected board, but the platform
actually removes power from devices left in D0 during suspend.

I guess it would be more appropriate to check something like
pm_suspend_no_platform() which would return 'true' in the
suspend-to-idle patch w/ ACPI.

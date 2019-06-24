Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376E551D2C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 23:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfFXVhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 17:37:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38147 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfFXVhm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 17:37:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so15108612oth.5;
        Mon, 24 Jun 2019 14:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xCtwElI364QfKnvdzlikQ/i499dYfxJ/Sd4Q5QDxdU=;
        b=Dfo8gtevVSgYatIgNihgM55byAc8Kx/LYOIKR3zR6wqR97K2koVR5lMqFEu0nVX62j
         VpA9NyTtnr+jZoHmY5g6SsSrMmqG7Emvv9RFoVQ7HVPIyC7Y654WBbL/IAvqPHyRSYPX
         6qkJA3jyg/KjiBM26RnUCNmSdFwFJ7F2KTKFDz5AC6P1quF64OcimBPCd8q9i8h/ML3m
         WvdGbpR3KOynoHJ9IxsQ/5K/th56QEWZb8lTPpYVcH/et8M8lvM5vGITg97C/iFIAxIx
         RsQs9tBpLWhSpHSipQXesoemjFW/rUOkOTxBxQPksN/Avd+1JF/pY3Ew4KDN795P5YaQ
         J4iQ==
X-Gm-Message-State: APjAAAXRJ9UwGrwBYVPCHrbLawqtVvak3D6pbyBb8aQdAfQUsqgTxZWV
        FXzKfGmbP+Kb7pxdfEYY47LuSb6QhljEWLbCMTg=
X-Google-Smtp-Source: APXvYqznIEskFZ/msbmZ5zgcdAacqjQRCqt0+T6G2DQyg5VVAEKPzXzDGsXHatUOQbKr/LPm9qYgtfMQFo7mD7oVqhA=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr2331359oto.167.1561412261402;
 Mon, 24 Jun 2019 14:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <1668247.RaJIPSxJUN@kreacher> <9906d02b-8c77-f2c8-7168-93ea444b950e@nvidia.com>
In-Reply-To: <9906d02b-8c77-f2c8-7168-93ea444b950e@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jun 2019 23:37:29 +0200
Message-ID: <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
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

On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Rafael,
>
> On 13/06/2019 22:59, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > attempted to avoid a problem with devices whose drivers want them to
> > stay in D0 over suspend-to-idle and resume, but it did not go as far
> > as it should with that.
> >
> > Namely, first of all, the power state of a PCI bridge with a
> > downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
> > sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
> > transactions on its secondary bus), but that is not actively enforced
> > during system-wide PM transitions, so use the skip_bus_pm flag
> > introduced by commit d491f2b75237 for that.
> >
> > Second, the configuration of devices left in D0 (whatever the reason)
> > during suspend-to-idle need not be changed and attempting to put them
> > into D0 again by force is pointless, so explicitly avoid doing that.
> >
> > Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> I have noticed a regression in both the mainline and -next branches on
> one of our boards when testing suspend. The bisect is point to this
> commit and reverting on top of mainline does fix the problem. So far I
> have not looked at this in close detail but kernel log is showing ...

Can you please collect a log like that, but with dynamic debug in
pci-driver.c enabled?

Note that reverting this commit is rather out of the question, so we
need to get to the bottom of the failure.

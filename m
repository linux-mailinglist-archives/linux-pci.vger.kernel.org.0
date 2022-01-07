Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462E84871B2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 05:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbiAGEKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 23:10:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40948
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346030AbiAGEKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 23:10:18 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6263140027
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 04:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641528610;
        bh=QJzzNLVJdeEzMCALhcgJhqj9s9pIDKzQHnLx0JleHBo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qdp6xoWKoeXqjSsZ0HuHFI9OPS6/G+0ybtjpyozCkR8E/B29RLinTEg80YSrdukGN
         e/ChbWnwvsYSLE1T+YtblJe3fOlCJ3guIW9LCnYbE+hkE2BxOsNIcHmzeskPuS+pgJ
         1okormY2TS38JvyMAzD8ZcIlI9Xx7k6UkrlnFszVJFBsndAsTAt6+Ytl9/KsMcohsC
         fMCtimYDa1JHTZ3pHcwOeDRb+rMI/P9MLIDzz6LKLYRySJb2OQVFSQZng3Cfcs8AYI
         Jx91nf2nvMyfWBwzmYPQGggMDCrwWv1gsdXvjl06DV7vOFcIq7N2wROrkxRPX4vTjB
         gRKuuNEWeN6Hg==
Received: by mail-oi1-f200.google.com with SMTP id y74-20020aca4b4d000000b002c6fd8df444so3178657oia.22
        for <linux-pci@vger.kernel.org>; Thu, 06 Jan 2022 20:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJzzNLVJdeEzMCALhcgJhqj9s9pIDKzQHnLx0JleHBo=;
        b=uIWIvnns4098kzdtPsiM1cHmHz3lC5uNuxJNQttYc4Ra+9GJEnDaDRW1RmLcLSImb+
         HlokhWlJzFN8DvDHI3rphmrU9pvWct/LoK/AjErMLZOCWSVBCvgZzy5cOvSRfS5gRsaz
         KZVmZxJqCes9U4HhPzFfUcpP0KdNvfZOuTjV91fOBQN26CYw9vVQpq9XwcAvXVcfngX8
         r/A5tACnPbT8PiIYGIAJfcxCAAPqHYM+G7rL+aQwuuBxLitgUC3YeAKGm9oU9H0iniFm
         IxjyObUVkV13h2H0eHkwx7BOXgLRhrd1L/uqpvVpaYPcqyTkdThO8WkPN+WqJyT7wxKM
         +x/Q==
X-Gm-Message-State: AOAM531XU9ndKs5DfwfwLcgvxyS7N2FlanVdVSyET9hytROMOwRnYgtq
        zrqcM5v3l8yLKFyn1BWr9hAFZDYsgwHXaiz5GffDbmYCBZ/yiujZ3bYnEqKWvRREP1EaikitrT+
        hl69DUyonNYNVrGL2UXPQ3dIZ1tttI0Kj/GnSq07W5aKxLR2Hw1BNVw==
X-Received: by 2002:aca:ad05:: with SMTP id w5mr8392355oie.41.1641528609020;
        Thu, 06 Jan 2022 20:10:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdEZ+rc2MIn8zBEdFL3Rf+HORQPJPpZcxVwALWgc4hSR4ldGxWOKbcmjv6XPDtRqm6MF+zOMoe66faNt/pcF0=
X-Received: by 2002:aca:ad05:: with SMTP id w5mr8392338oie.41.1641528608746;
 Thu, 06 Jan 2022 20:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20220105060643.822111-1-kai.heng.feng@canonical.com> <20220105201226.GA218998@bhelgaas>
In-Reply-To: <20220105201226.GA218998@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 7 Jan 2022 12:09:57 +0800
Message-ID: <CAAd53p5V9gCCc6v9Wdo-bONYfASnhtyGHVPPb6vOneft2XewQQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 6, 2022 at 4:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 05, 2022 at 02:06:41PM +0800, Kai-Heng Feng wrote:
> > The Thunderbolt root ports may constantly spew out uncorrected errors
> > from AER service:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
>
> No timestamps needed here; they don't add to understanding the
> problem.

Got it. Will remove it for later iteration.

>
> > The link may not be reliable on external facing ports, so don't enable
> > AER on those ports.
>
> I'm not sure what you want to accomplish here.  If the errors are
> legitimate and the result of some hardware issue like a bad cable, why
> should we ignore them?  If they're caused by a software problem, we
> should figure that out and fix it.
>
> Does this occur on a specific instance of possibly flaky hardware?

Only from root ports of thunderbolt devices.

The error occurs as soon as the root port is runtime suspended to D3cold.

Runtime suspend the AER service can resolve the issue. I wonder if
it's the right thing to do here?
D3cold should also mean the PCI link is gone, disabling AER seems to
be a reasonable approach.

Kai-Heng

>
> You mention a spew of errors; do you think this is a single error that
> we fail to clear correctly?  Or is it really many separate errors?
>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index bda630889f955..d464d00ade8f2 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -219,7 +219,8 @@ static int get_port_device_capability(struct pci_dev *dev)
> >
> >  #ifdef CONFIG_PCIEAER
> >       if (dev->aer_cap && pci_aer_available() &&
> > -         (pcie_ports_native || host->native_aer)) {
> > +         (pcie_ports_native || host->native_aer) &&
> > +         !dev->external_facing) {
> >               services |= PCIE_PORT_SERVICE_AER;
> >
> >               /*
> > --
> > 2.33.1
> >

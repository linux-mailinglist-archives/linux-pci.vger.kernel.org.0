Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120264817FD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhL3BAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 20:00:45 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47836
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233799AbhL3BAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 20:00:44 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BFB753F1B0
        for <linux-pci@vger.kernel.org>; Thu, 30 Dec 2021 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640826043;
        bh=uoZ4j3DJAFFGqNYQHJEg8ZOm+0DP9sQ76r9xPfmb/n8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q5vXY2rnWzmN4UhpmM4EvxkVIOtSAoQ0dKUvuQMz9++z0TDlqA4NHm0nh05GlQgbN
         XXKwbYY/5H71KqCeVsSiOrVrZo5+3F38WAHTyp6tAV0uBSQTmZ+yaUAyH5H2idWauJ
         f1sW3+FfKYKv6PUbUE+grZjikHNj0iduAQOU9vxaKvz37jvfvbx4kKldDXkIJEIn1S
         q1tOCZdYxW1FnpI85IkL+AsPuy1DmCbcarHFy5bob2zEAYYlUvjfyF49hdhjdwh8+O
         LweK+j0wIOX9BCNOXzWeihRtISckoUEheJ977GU8wrH7wd8X7goqM04PcJjL7fvhxM
         5lxjngHiXLG8g==
Received: by mail-ot1-f70.google.com with SMTP id c22-20020a9d67d6000000b00567f3716bdbso7125575otn.11
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 17:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoZ4j3DJAFFGqNYQHJEg8ZOm+0DP9sQ76r9xPfmb/n8=;
        b=uVFXcC5Hg9Z6BbR2WeH2b/k5x8gw2dZtWvwK3veAzkXHnDagyxsJvnBqAE1Hf7xo4j
         vZzqjpG3xIwfdm7tedwF7HxJrRruzdx+ZoCRBU4jrI7RJTWxqrIzFREhMwZXAD7QEGsw
         wBCCTWeYdYnwhrE5M9999EaomIWKgqF9sYFBvabnoGk140NUFRT8LlBlDnOr3KFxqugx
         Jv82atV4sP3JXNBRe0X3rBD5VyvBZA1vCmSOTKrCwTyuFe8o9xiMxwoflEe5mgOGqwuG
         bv+etU+mTumKei17RLxr05/0GNGCBh31Y3sOzZv5nACAvfFiisOoN6J7amNu/BeGKjMu
         UM0w==
X-Gm-Message-State: AOAM532kUNNHh8TfqzsTck+yHtHb7NheoPsq/XdOJBA65ekZYIs4MaNQ
        xZcyYqAdDmGsIPIzcRM1ZvNfem5HTno1/pvZT0ihuM5AixqEM3R8iq0EsO/ZqkZAJm5NZEGoDQm
        icvJ4MBjSlIohdbCkZa9BdHy0iNNVzKgEmuuR8SSjz6IBLSB1bZYYng==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr20131514ota.11.1640826042558;
        Wed, 29 Dec 2021 17:00:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAdp50c/5EObs0tj1fNIcnnRPPx3ss2Ad4obTPVF8kRFOvNAW6kNtQ60X8aCLALrxPfVtjUBNOOVyzgjPgjoE=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr20131496ota.11.1640826042302;
 Wed, 29 Dec 2021 17:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20211224081914.345292-2-kai.heng.feng@canonical.com> <20211229201814.GA1699315@bhelgaas>
In-Reply-To: <20211229201814.GA1699315@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 30 Dec 2021 09:00:30 +0800
Message-ID: <CAAd53p74bHYmQJzKuriDrRWpJwXivfYCfNCsUjC47d1WKUZ=gQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: wwan: iosm: Keep device at D0 for s2idle case
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     m.chetan.kumar@intel.com, linuxwwan@intel.com,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 30, 2021 at 4:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Vaibhav]
>
> On Fri, Dec 24, 2021 at 04:19:14PM +0800, Kai-Heng Feng wrote:
> > We are seeing spurious wakeup caused by Intel 7560 WWAN on AMD laptops.
> > This prevent those laptops to stay in s2idle state.
> >
> > From what I can understand, the intention of ipc_pcie_suspend() is to
> > put the device to D3cold, and ipc_pcie_suspend_s2idle() is to keep the
> > device at D0. However, the device can still be put to D3hot/D3cold by
> > PCI core.
> >
> > So explicitly let PCI core know this device should stay at D0, to solve
> > the spurious wakeup.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/net/wwan/iosm/iosm_ipc_pcie.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > index d73894e2a84ed..af1d0e837fe99 100644
> > --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > @@ -340,6 +340,9 @@ static int __maybe_unused ipc_pcie_suspend_s2idle(struct iosm_pcie *ipc_pcie)
> >
> >       ipc_imem_pm_s2idle_sleep(ipc_pcie->imem, true);
> >
> > +     /* Let PCI core know this device should stay at D0 */
> > +     pci_save_state(ipc_pcie->pci);
>
> This is a weird and non-obvious way to say "this device should stay at
> D0".  It's also fairly expensive since pci_save_state() does a lot of
> slow PCI config reads.

Yes, so I was waiting for feedback from IOSM devs what's the expected
PCI state for the s2idle case.

Dave, can you drop it from netdev until IOSM devs confirm this patch is correct?

Kai-Heng

>
> >       return 0;
> >  }
> >
> > --
> > 2.33.1
> >

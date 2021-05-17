Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8460C386CFF
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbhEQWfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhEQWfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 18:35:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ABFC061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 15:34:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i9so11074505lfe.13
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgpuCsOSUBV3Eod5u/L5h9ty2mrWMwDC6F3vhbFSf60=;
        b=wAOQIczqkDdlETvak5EvYYQnQISdpoDFDrNw3w4KVj9a73RgMotcrBBjvvch69IarY
         xuVnSSBpiJmKeCJpJVH2DVY2MSzsNWyF226gSXZ7UdC9sInM6ChijBL68lqlhD9B1eS+
         QM8+WaV899sFOPSXg0Rg2cvc5Jl6CQBgwAU1kefg803u5Dh3t/ycxn//RFSB3MPM/B7e
         MxtOeEHjNAzJLU9zzU1jdVquDfyVGYeYi+YT56mS4nIxu983RpP2iDcrVL7dnFXgMwXY
         /lra8zKQZGKb1k10GNkrKdklomg7fpFrmNxgSQGIKxBnjJBbpUct786CS+emv3jdK2Ay
         iLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgpuCsOSUBV3Eod5u/L5h9ty2mrWMwDC6F3vhbFSf60=;
        b=P7RQ8aaZfD16uedzUVY7UOhIeBAdZBxEuO7VXaPfVz5Cioste3VYhBycCMZc9zadQa
         evz/6pKHuLTZ9momsoKVsEyI08RAmM4+2vGjt/fcBQRmcGUI9qqKP8GBXKGBwhnru1dT
         QF8aN6AMIYHaoKnCbJtI/XTVlM1t/71mar3W1d66GqR6u3gd2qBexQgNCIZgMgAJfsBE
         ijIupyla4QuXwdoighs3S3ugeGitD8Yr9AU1bHBQZPUfmABfNWSB5kG+EdaoCzwgcFJA
         vYL7HPzj+WwIYmwZoZ+jE1+fe5OKbRz5HtujgwIg0qG2/DbDwVpVFmgi36MRWVQdCyb1
         M0iQ==
X-Gm-Message-State: AOAM5318TH2G5oa8MzeMEZ/wxujzlOsRZKQxSfAvx8rgEj3zjqXuB/Kj
        s8MEJAcyat67JQjyHiXXl/WTGzfmjn43Dkrw+hM9SA==
X-Google-Smtp-Source: ABdhPJycOgSIygCCsQ9RTP7He8agC6DS3w5rteb8NWwZS9A6rEdre2eCc+7lN8owTCOFDHwtTlOCaoky3MX+7QZB5Zg=
X-Received: by 2002:a19:ca15:: with SMTP id a21mr1432826lfg.487.1621290872794;
 Mon, 17 May 2021 15:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 17 May 2021 15:33:56 -0700
Message-ID: <CACK8Z6E=4Eeo-hAdXOxJLxUr57hGZbAf-YL6e6XZmoyfj2XGfQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Target PM state is D3cold if the upstream bridge
 is power manageable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Kai]

Hi,

I don't understand the power management very well, so pardon my
ignorance but I have a question.

On Mon, May 10, 2021 at 3:30 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> ASMedia xHCI controller only supports PME from D3cold:
>
> 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>   ...
>   Capabilities: [78] Power Management version 3
>           Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>           Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> Now, if the controller is part of a Thunderbolt device for instance, it
> is connected to a PCIe switch downstream port. When the hierarchy then
> enters D3cold as a result of s2idle cycle pci_target_state() returns D0
> because the device does not support PME from the default target_state
> (D3hot). So what happens is that the whole hierarchy is left into D0
> breaking power management.at suspend time or resume time

Can you please provide a small call stack, when this issue is seen?
(I'm primarily trying to understand whether the issue is breaking
suspend, or the suspend is fine, but resume is broken?)

>
> For this reason choose target_state to be D3cold if there is a upstream
> bridge that is power manageable.

It seems to me that the goal of pci_target_state() is to find the
lowest power state that a device can be put into, from which device
can still generate PME (if needed). So I'm curious why it starts with
target_state = PCI_D3hot in the first place? Wouldn't starting with
PCI_D3cold will always be better (regardless of parent bridge
capabilities)?

And then I came across the commit 8feaec33b986 ("PCI / PM: Always
check PME wakeup capability for runtime wakeup support"), which
addresses the same device that this patch addresses, and 1 excerpt
from the commit log that stood out:
============================================================
    In addition, change wakeup flag passed to pci_target_state() from false
    to true, because we want to find the deepest state *different from D3cold*
    that the device can still generate PME#. In this case, it's D0 for the
    device in question.
============================================================

So, does returning D3Cold from this function break any other
assumption somewhere?

Thanks,
Rajat


> The reasoning here is that the upstream
> bridge will be also placed into D3 making the effective power state of
> the device in question to be D3cold.
>
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Tested-by: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..e3f3b9010762 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2578,8 +2578,19 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>                 return target_state;
>         }
>
> -       if (!dev->pm_cap)
> +       if (!dev->pm_cap) {
>                 target_state = PCI_D0;
> +       } else {
> +               struct pci_dev *bridge;
> +
> +               /*
> +                * If the upstream bridge can be put to D3 then it means
> +                * that our target state is D3cold instead of D3hot.
> +                */
> +               bridge = pci_upstream_bridge(dev);
> +               if (bridge && pci_bridge_d3_possible(bridge))
> +                       target_state = PCI_D3cold;
> +       }
>
>         /*
>          * If the device is in D3cold even though it's not power-manageable by
> --
> 2.30.2
>

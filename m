Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40693AB3CD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFQMlt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 08:41:49 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36729 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFQMlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 08:41:47 -0400
Received: by mail-ot1-f42.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5978518otl.3;
        Thu, 17 Jun 2021 05:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhY/o2lkyTZvpmtTr29N4IyPEt6H6zLjqA0Gyj8zRkI=;
        b=epQqEi0wBD3Njgpg7OU7X4/Nhre7xHa5WfZkrBv4n9AmZNrPlx/kzDiEtjMa/3TJap
         cewTufpKkQ0daT+w/eLLP0P1doR4VUv/+8q89Yc/8t/lwNNuaHB8Kh63pO1ZXa4L6nuY
         QlHQnnpXiIYzfdDUmAP+bhGrb1GHdVfUqcBEjqx0jYeZUryRLsNDCYghP7h7yi7oz8FG
         c7qxC6CDvY62uRi9NxWzrdDxjmNukC6sGP3lOcSkhb8u3nGr9ODfIB8OuhZEfHNctIOR
         ZxHlnPQUmpFUO9yrQ73qLvBDj3xn2q3HYSaPP61kgW8kjYIhNuQ15Z3w86psF1Um7jXj
         jiOQ==
X-Gm-Message-State: AOAM531AzRXvsJ4XXiaMyEwa8IVFObhfe+jcDsdb8Dtc/bUwq3gy4Oa8
        VigtifKtDdfgwCmUwqXCrNXJSO2lJN2bpsF80fw=
X-Google-Smtp-Source: ABdhPJx3dx6w3I1QneY4PCPeyEMNS6j9t3Islecd1mhR4aST8mK5R8rH4pxMDo3GQq0/E7QSG/Jyn84YBcMBgUu3HiA=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr4370408otq.321.1623933580099;
 Thu, 17 Jun 2021 05:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210617123653.58640-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20210617123653.58640-1-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:39:28 +0200
Message-ID: <CAJZ5v0jGU0R1u3xSOhkf=y0pDr=KBMebLAzhcCem3mKgYBZ49A@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/PM: Target PM state is D3hot if device can only
 generate PME from D3cold
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 17, 2021 at 2:36 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Some PCIe devices only support PME (Power Management Event) from D3cold.
> One example is ASMedia xHCI controller:
>
> 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>   ...
>   Capabilities: [78] Power Management version 3
>           Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>           Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> With such devices, if it has wake enabled, the kernel selects lowest
> possible power state to be D0 in pci_target_state(). This is problematic
> because it prevents the root port it is connected to enter low power
> state too which makes the system consume more energy than necessary.
>
> The problem in pci_target_state() is that it only accounts the "current"
> device state, so when the bridge above it (a root port for instance) is
> transitioned into D3hot the device transitions into D3cold. This is
> because when the root port is first transitioned into D3hot then the
> ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
> the root port and the device are in D3cold). If the root port is kept in
> D3hot it still means that the device below it is still effectively in
> D3cold as no configuration messages pass through. Furthermore the
> implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
> expect to be transitioned into D3cold soon after its link transitions
> into L2/L3 Ready state.
>
> Taking the above into consideration, instead of forcing the device stay
> in D0 we modify pci_target_state() to return D3hot in this special case
> and make __pci_enable_wake() to enable PME too in this case.
>
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

All of my comments have been addressed, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> The previous version of the patch is here:
>
> https://lore.kernel.org/linux-pm/20210616150516.28242-1-mika.westerberg@linux.intel.com/
>
> Changes from the previous version:
>
>   * Dropped redundant test in pci_target_state().
>
>  drivers/pci/pci.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..043c5c304308 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2485,7 +2485,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
>         if (enable) {
>                 int error;
>
> -               if (pci_pme_capable(dev, state))
> +               /*
> +                * Enable PME if device is capable from given state.
> +                * Special case is device that can only generate PME
> +                * from D3cold then we enable PME too.
> +                */
> +               if (pci_pme_capable(dev, state) ||
> +                   (state == PCI_D3hot && pci_pme_capable(dev, PCI_D3cold)))
>                         pci_pme_active(dev, true);
>                 else
>                         ret = 1;
> @@ -2595,6 +2601,14 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>                  * PME#.
>                  */
>                 if (dev->pme_support) {
> +                       /*
> +                        * Special case if device supports only PME from
> +                        * D3cold but not from D3hot we still return D3hot.
> +                        */
> +                       if (target_state == PCI_D3hot &&
> +                               (dev->pme_support & (1 << PCI_D3cold)))
> +                               return target_state;
> +
>                         while (target_state
>                               && !(dev->pme_support & (1 << target_state)))
>                                 target_state--;
> --
> 2.30.2
>

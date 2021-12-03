Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC974678F8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381277AbhLCOEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 09:04:02 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44729 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352843AbhLCOEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 09:04:02 -0500
Received: by mail-oi1-f173.google.com with SMTP id be32so5911496oib.11;
        Fri, 03 Dec 2021 06:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqRgFTDUNv+vk88WWxS+gLyfj0EmvwrZNO1+l4H+s28=;
        b=xFFVK+AwaRAwx0mVsO7+qitJHMPOYBdgFbH/KEfsSRUHJGf23R0BtV8z2/jiz/yelV
         Vn9ueimuhgmlyqL8HkMGA3oOeZSt5YwmJJizE2pG58GzW/qmg9js0vXsyA1eZppVvsBt
         D5+jyZOdtkMs1r5APFW4A+maBAjmrBxR/7ER4qMYQZQYqVNiuNp99nJqU9GGWH6w/qny
         cA97jAwwqoCh57919Gd7ovqn+zD2V32HugpkmuRrTNYZo15jZbpbot/1S3eSVXCclXPK
         zxI4/dJgvANCTTOiXq3tp0B25V204HTyrVIIpnHAtxuUUSXoTg/L10bRhRhvJHYv2EF3
         LVrw==
X-Gm-Message-State: AOAM531vhxnGw+1Nb9RNGU9Nip7Pmxta3PLLHZSodzM/UcYkg6V+nnwB
        y6BwKFdcUlYzwkGyuNEP1475aAORRI0YB/Y0LXs=
X-Google-Smtp-Source: ABdhPJyPrO3jM6MZMOz7vxO0EJn/Cia/2T6cQ8bgT83DHbGR/GRB4cWEnuf82PvmzLDs3OeZr9pvRtA3OCUxKCNRqWE=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr9914172oiw.154.1638540037639;
 Fri, 03 Dec 2021 06:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Dec 2021 15:00:25 +0100
Message-ID: <CAJZ5v0j=Et0NraqrPvEH6i_uUxyZ=gUW4CmXQKtPRiuXrLaKTQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 3, 2021 at 4:16 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> combination causes AER message flood and drags the system performance
> down.
>
> The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> is enabled regardless of _OSC:
> [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> ...
> [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
>
> Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> disable PCIe features accordingly to resolve the issue.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215027
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - Use a new helper function.
>
> v2:
>  - Use pci_find_host_bridge() instead of open coding.
>
>  drivers/pci/controller/vmd.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a45e8e59d3d48..691765e6c12aa 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -661,6 +661,21 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>         return 0;
>  }
>
> +/*
> + * Since VMD is an aperture to regular PCIe root ports, only allow it to
> + * control features that the OS is allowed to control on the physical PCI bus.
> + */

I'd put the comment inside the function, but nevertheless

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> +static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> +                                      struct pci_host_bridge *vmd_bridge)
> +{
> +       vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> +       vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> +       vmd_bridge->native_aer = root_bridge->native_aer;
> +       vmd_bridge->native_pme = root_bridge->native_pme;
> +       vmd_bridge->native_ltr = root_bridge->native_ltr;
> +       vmd_bridge->native_dpc = root_bridge->native_dpc;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>         struct pci_sysdata *sd = &vmd->sysdata;
> @@ -798,6 +813,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>                 return -ENODEV;
>         }
>
> +       vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +                                  to_pci_host_bridge(vmd->bus->bridge));
> +
>         vmd_attach_resources(vmd);
>         if (vmd->irq_domain)
>                 dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> --
> 2.32.0
>

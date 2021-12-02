Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA24667B7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 17:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359366AbhLBQVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 11:21:00 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46653 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359360AbhLBQVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 11:21:00 -0500
Received: by mail-oi1-f175.google.com with SMTP id s139so83640oie.13;
        Thu, 02 Dec 2021 08:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq/YsP4B8aOPtGNOL/5xcSdESCXdsQckUG9RYj9ftAs=;
        b=Dzmm0t4jEtZ+LYYbGrr2KOxvqfK2jedyjea/LKfQGYxyZmL4V6Vp8HSmobFd8WmTey
         EA1mkjGM9FvDDjWVb+xaosjAO2Os4PmApO+PoQCsfz0ZuVifmkD1OebmsRSNu1YUe1zy
         i0r32SptSeKMkWkK/Sw/OGP0KR1dThTel9s+y4uOQjHOKtNccnhwlgqhnYqf3VweF/j0
         K/EHicrd6pla6fG7PqywkYkdXtTMiHA8M9wdfv3163S5r4RN1cCko1bQi654JUMHdRyC
         4xE2lgjgrp5L61Jgn3a8Q0LXe5P1xqHLCHg904P9PVyHE3kS2nOFHKuTVwVg2Pr+TKF+
         LT8Q==
X-Gm-Message-State: AOAM5306M0DBoUyZvF40lnAczz7RkfBvo76j4wyvSyvp81wywmzwBbXZ
        9s44NyrZSo4KJPh42TbDFsw79g8VW78m+kKYiHM=
X-Google-Smtp-Source: ABdhPJznXOxt4pGds4V359+qQWbXYupzvtZ30NRG/ULmogT4vFwGWTS0kJU1zxW0zOAP7cjZFvZVSLoSxoLNukd7s68=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr5109369oil.166.1638461857185;
 Thu, 02 Dec 2021 08:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20211202030450.1355821-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211202030450.1355821-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Dec 2021 17:17:25 +0100
Message-ID: <CAJZ5v0hpEy46Vh83dQ_orG=jW+a1b2+kipRLQOVOnvhjN0j03g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Thu, Dec 2, 2021 at 4:05 AM Kai-Heng Feng
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
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use pci_find_host_bridge() instead of open coding.
>
>  drivers/pci/controller/vmd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a45e8e59d3d48..acf847cb825c0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -671,6 +671,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>         resource_size_t offset[2] = {0};
>         resource_size_t membar2_offset = 0x2000;
>         struct pci_bus *child;
> +       struct pci_host_bridge *root_bridge, *vmd_bridge;
>         int ret;
>
>         /*
> @@ -798,6 +799,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>                 return -ENODEV;
>         }
>
> +       vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> +
> +       root_bridge = pci_find_host_bridge(vmd->dev->bus);
> +
> +       vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> +       vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> +       vmd_bridge->native_aer = root_bridge->native_aer;
> +       vmd_bridge->native_pme = root_bridge->native_pme;
> +       vmd_bridge->native_ltr = root_bridge->native_ltr;
> +       vmd_bridge->native_dpc = root_bridge->native_dpc;

One more, arguably minor, thing: I would put the above copying into a
separate function and call it here and I would add a comment
explaining why it is done next to it, like

/*
 * Since VMD is an aperture to regular PCIe root ports, only allow it to control
 * features that the OS is allowed to control on the physical PCI bus.
 */
vmd_copy_host_bridge_flags(to_pci_host_bridge(vmd->bus->bridge),
pci_find_host_bridge(vmd->dev->bus));

> +
>         vmd_attach_resources(vmd);
>         if (vmd->irq_domain)
>                 dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> --
> 2.32.0
>

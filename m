Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C067046503F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350560AbhLAOrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 09:47:13 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46954 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350719AbhLAOoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 09:44:21 -0500
Received: by mail-ot1-f48.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so5199462oto.13;
        Wed, 01 Dec 2021 06:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ed/ZcCSR+4sJXjgWKobu/vSzvVTBSgkCNvP/E+sGc34=;
        b=ZnxK66YcosTZ/M3SlJj1J1dxXuRAVnk0feQapOk/6XuQGvtPLomMcEf/Lw7Z8SLdpE
         kQ1Y1gydrFRpAOwPUP/pFAXZYI59W5fP8AI8ccR/10+QTAMu4r6gtaTudxntpYb5LNS/
         n4R2R+FCDGpzAPXd7wFARYWlIWhWr8uTtoCNQiPLAQ4DXRIKq2Ydg+3op7fuhhZ5RcLz
         LgOu3JeS+idC9nTSLXYEU2rCOSHMxtDVjwA/6UsD1EdgczdVrZxDnFdqIf8f6EE+jvgV
         fjXuFsCvTKFLX0yxDX0KAxrAIakJHytm8MeA7CTbj3JeNs5N8flRrPWmtG0nBAtiD2L5
         Gkfw==
X-Gm-Message-State: AOAM531NiUeqEczO0fOcjncJhFf/7LJsCEphvcUrR4CIUhPwiImfsYSr
        t7jfbA0Cyl60z6eGXzLm0lAvfdpG7ZbomcaTLjo=
X-Google-Smtp-Source: ABdhPJxp6TilHl0+OEDr77mPSoLcvUkS0xfcqLlnOeV8gwqQPAQ7V3osdNMQRxGpaXfwgjoTqV06EsoMdJQnFolzgaM=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr6239258otu.254.1638369660021;
 Wed, 01 Dec 2021 06:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20211201062423.1313114-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211201062423.1313114-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 15:40:49 +0100
Message-ID: <CAJZ5v0jQUc8NyNYiGpx0ayEPXJR-TS4fy832+2fBGgKLmdWjtg@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Honor ACPI _OSC on PCIe features
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

On Wed, Dec 1, 2021 at 7:25 AM Kai-Heng Feng
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
>  drivers/pci/controller/vmd.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a45e8e59d3d48..8298862417e84 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -670,7 +670,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>         LIST_HEAD(resources);
>         resource_size_t offset[2] = {0};
>         resource_size_t membar2_offset = 0x2000;
> -       struct pci_bus *child;
> +       struct pci_bus *child, *bus;
> +       struct pci_host_bridge *root_bridge, *vmd_bridge;
>         int ret;
>
>         /*
> @@ -798,6 +799,21 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>                 return -ENODEV;
>         }
>
> +       vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> +
> +       bus = vmd->dev->bus;
> +       while (bus->parent)
> +               bus = bus->parent;

What about using pci_fimd_host_bridge() here?

LGTM otherwise.

> +
> +       root_bridge = to_pci_host_bridge(bus->bridge);
> +
> +       vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> +       vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> +       vmd_bridge->native_aer = root_bridge->native_aer;
> +       vmd_bridge->native_pme = root_bridge->native_pme;
> +       vmd_bridge->native_ltr = root_bridge->native_ltr;
> +       vmd_bridge->native_dpc = root_bridge->native_dpc;
> +
>         vmd_attach_resources(vmd);
>         if (vmd->irq_domain)
>                 dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> --
> 2.32.0
>

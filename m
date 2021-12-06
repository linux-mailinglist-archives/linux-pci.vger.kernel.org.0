Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D96E46AE49
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 00:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376866AbhLFXPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 18:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376764AbhLFXPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 18:15:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDCC061746;
        Mon,  6 Dec 2021 15:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CA78B8111B;
        Mon,  6 Dec 2021 23:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBE2C004DD;
        Mon,  6 Dec 2021 23:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638832343;
        bh=N+sG/ua5ywere0oxAo3CtHcnOnnRgW8/3YFg1XGB34w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofP9EOSc5wGmI30zOggT2vYNOWGnUJNY8GUgpe6+QvFYywQ64dcCQkWpaVPHhGNGw
         DrIlQx2fvLi8h5YfGxdVYF52ux60Dx9rPceHpQ2tdg1bE/UkCaOIGTv0acyLbpY3Xo
         LkM/pUzpwMZv8zTMe5x618AWU7OWp+5Xfqxa6084Epq7vvZwyor/Zu2CT2nxepnTSb
         f+RBYC+rGx5cVdzaXYNJCEoZFN6ixecWm2QtFDYx/1zZSia8DyX1gHnVUYFsHlHlRP
         jJlgllKI2mcu89nKRtI5fsOW3dStqep7jRtWjrbUYWixU+bKt1qwN1qbHiGFRDYhS/
         T/Zs++NObJhqw==
Date:   Mon, 6 Dec 2021 15:12:18 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Message-ID: <20211206231218.GA3843138@dhcp-10-100-145-180.wdc.com>
References: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
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

At least for some versions of this hardare, I recall ACPI is unaware of
any devices in the VMD domain; the platform can not see past the VMD
endpoint, so I throught the driver was supposed to always let the VMD
domain use OS native support regardless of the parent's ACPI _OSC.

 
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
>  	return 0;
>  }
>  
> +/*
> + * Since VMD is an aperture to regular PCIe root ports, only allow it to
> + * control features that the OS is allowed to control on the physical PCI bus.
> + */
> +static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> +				       struct pci_host_bridge *vmd_bridge)
> +{
> +	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> +	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> +	vmd_bridge->native_aer = root_bridge->native_aer;
> +	vmd_bridge->native_pme = root_bridge->native_pme;
> +	vmd_bridge->native_ltr = root_bridge->native_ltr;
> +	vmd_bridge->native_dpc = root_bridge->native_dpc;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -798,6 +813,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		return -ENODEV;
>  	}
>  
> +	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +				   to_pci_host_bridge(vmd->bus->bridge));
> +
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> -- 
> 2.32.0
> 

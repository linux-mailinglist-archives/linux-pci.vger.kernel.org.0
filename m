Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3272281E29
	for <lists+linux-pci@lfdr.de>; Sat,  3 Oct 2020 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBWSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 18:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgJBWSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 18:18:32 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A808E20738;
        Fri,  2 Oct 2020 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601677112;
        bh=TeaOlavbFwonn5/j6s0DjJIppzCiC0RaB2IS2y4buCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yPEHRKayaHjV6+rIyUEnCb+VEYV1ScYIyiuV7wRRav2vUtgwb3LmuPV+MqchhhTQP
         EBAnDIxed69EYzgigOjXcYJM67BxwOehdQhw4qZDAiqAz7uXqvaOFfSQjJrmtynnb+
         nWque0qDnwNfZ2hKxqojknZQGo8Kk+fQJY9BpEuw=
Date:   Fri, 2 Oct 2020 17:18:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, jonathan.derrick@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
Message-ID: <20201002221830.GA2822405@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930082455.25613-2-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
> BIOS may not be able to program ASPM for links behind VMD, prevent Intel
> SoC from entering deeper power saving state.

It's not a question of BIOS not being *able* to configure ASPM.  I
think BIOS could do it, at least in principle, if it had a driver for
VMD.  Actually, it probably *does* include some sort of VMD code
because it sounds like BIOS can assign some Root Ports to appear
either as regular Root Ports or behind the VMD.

Since this issue is directly related to the unusual VMD topology, I
think it would be worth a quick recap here.  Maybe something like:

  VMD is a Root Complex Integrated Endpoint that acts as a host bridge
  to a secondary PCIe domain.  BIOS can reassign one or more Root
  Ports to appear within a VMD domain instead of the primary domain.

  However, BIOS may not enable ASPM for the hierarchies behind a VMD,
  ...

(This is based on the commit log from 185a383ada2e ("x86/PCI: Add
driver for Intel Volume Management Device (VMD)")).

But we still have the problem that CONFIG_PCIEASPM_DEFAULT=y means
"use the BIOS defaults", and this patch would make it so we use the
BIOS defaults *except* for things behind VMD.

  - Why should VMD be a special case?

  - How would we document such a special case?

  - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
    SoC power state problem?

  - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?

Link to previous discussion for the archives:
https://lore.kernel.org/r/49A36179-D336-4A5E-8B7A-A632833AE6B2@canonical.com

> So enable ASPM for links behind VMD to increase battery life.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/controller/vmd.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f69ef8c89f72..058fdef9c566 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -417,6 +417,22 @@ static int vmd_find_free_domain(void)
>  	return domain + 1;
>  }
>  
> +static const struct pci_device_id vmd_mobile_bridge_tbl[] = {
> +	{ PCI_VDEVICE(INTEL, 0x9a09) },
> +	{ PCI_VDEVICE(INTEL, 0xa0b0) },
> +	{ PCI_VDEVICE(INTEL, 0xa0bc) },
> +	{ }
> +};
> +
> +static int vmd_enable_aspm(struct device *dev, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> +
> +	return 0;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -603,8 +619,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * and will fail pcie_bus_configure_settings() early. It can instead be
>  	 * run on each of the real root ports.
>  	 */
> -	list_for_each_entry(child, &vmd->bus->children, node)
> +	list_for_each_entry(child, &vmd->bus->children, node) {
> +		if (pci_match_id(vmd_mobile_bridge_tbl, child->self))
> +			device_for_each_child(&child->self->dev, NULL, vmd_enable_aspm);

Wouldn't something like this be sufficient?

  list_for_each_entry(dev, &child->devices, bus_list)
    vmd_enable_aspm(dev);

>  		pcie_bus_configure_settings(child);
> +	}
>  
>  	pci_bus_add_devices(vmd->bus);
>  
> -- 
> 2.17.1
> 

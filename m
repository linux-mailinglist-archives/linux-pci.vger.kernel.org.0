Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A412C72B6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgK1VuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387702AbgK1UYu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 15:24:50 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F4A221FF;
        Sat, 28 Nov 2020 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606595049;
        bh=E49hKc+1y6WaIR/Qb6drfyORL/uB/ZiPhHUqAJ719KU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vmwtmNgQNK2nXsoGGnNi1czXRcUDlthO2xuuZzDmNFUGMVeAlVlR3BAGZwzKb9c+4
         F1IqQ+Thro6qy4k3L14Zr5vjkfKrQ6ylBURMvkaIBf3ULCDNuO6Jyhjby1CcgQzzWc
         6IWVYFetXgeJKe8qD0jztCVLjTHTk0WcRgrA6vOc=
Date:   Sat, 28 Nov 2020 14:24:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/5] PCI/DPC: Ignore devices with no AER Capability
Message-ID: <20201128202408.GA906784@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45dc5ef5-bfb4-6c0b-88c7-55a904f82965@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 06:01:57PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Downstream Ports may support DPC regardless of whether they support AER
> > (see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
> > "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
> > the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
> > depends on the AER Capability.
> > 
> > dpc_probe() previously failed if:
> > 
> >    !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
> >    !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law
> > 
> > so it succeeded if:
> > 
> >    pcie_aer_is_native() || pcie_ports_dpc_native
> > 
> > Fail dpc_probe() if the device has no AER Capability.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > ---
> >   drivers/pci/pcie/dpc.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index e05aba86a317..ed0dbc43d018 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
> >   	int status;
> >   	u16 ctl, cap;
> > +	if (!pdev->aer_cap)
> > +		return -ENOTSUPP;
> Don't we check aer_cap support in drivers/pci/pcie/portdrv_core.c ?
> 
> We don't enable DPC service, if AER service is not enabled. And AER
> service is only enabled if AER capability is supported.
> 
> So dpc_probe() should not happen if AER capability is not supported?

I don't think that's always true.  If I'm reading this right, we have
this:

  get_port_device_capability(...)
  {
  #ifdef CONFIG_PCIEAER
    if (dev->aer_cap && ...)
      services |= PCIE_PORT_SERVICE_AER;
  #endif

    if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
        pci_aer_available() &&
        (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
      services |= PCIE_PORT_SERVICE_DPC;
  }

and in the case where:

  - CONFIG_PCIEAER=y
  - booted with "pcie_ports=dpc-native" (pcie_ports_dpc_native is true)
  - "dev" has no AER capability
  - "dev" has DPC capability

I think we do enable PCIE_PORT_SERVICE_DPC.

> 206 static int get_port_device_capability(struct pci_dev *dev)
> ...
> ...
> 251         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> 252             host->native_dpc &&
> 253             (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
> 254                 services |= PCIE_PORT_SERVICE_DPC;
> 255
> 
> > +
> >   	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> >   		return -ENOTSUPP;
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

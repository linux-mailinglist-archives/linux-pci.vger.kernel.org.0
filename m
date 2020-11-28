Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07B2C715B
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgK1V4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391367AbgK1VyB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 16:54:01 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4125320857;
        Sat, 28 Nov 2020 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606600400;
        bh=cb7v+yyp8V0gUPgw13jOGxbQanmZsArHbf9RhiLHmkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=v/I6BXQISl6Ls7lROR48qKflb9h8GOYNGn01hBKIQPrdztEdaDhr5HlS+t27DcZiJ
         F1tVSOJ7zOgvAqv/wdpRPqgzienFknj8JPkuEaK9ruE4kjEs3lHZ5CkLluihUBP5zy
         d/ur7M3eZOJF8fMdp7O/v/O1UxTISSiv7FqsZZK0=
Date:   Sat, 28 Nov 2020 15:53:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/5] PCI/DPC: Ignore devices with no AER Capability
Message-ID: <20201128215318.GA924062@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a7c9e6-8916-2c14-4968-a963266e6c53@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 28, 2020 at 01:49:46PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 11/28/20 12:24 PM, Bjorn Helgaas wrote:
> > On Wed, Nov 25, 2020 at 06:01:57PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> > > On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > Downstream Ports may support DPC regardless of whether they support AER
> > > > (see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
> > > > "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
> > > > the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
> > > > depends on the AER Capability.
> > > > 
> > > > dpc_probe() previously failed if:
> > > > 
> > > >     !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
> > > >     !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law
> > > > 
> > > > so it succeeded if:
> > > > 
> > > >     pcie_aer_is_native() || pcie_ports_dpc_native
> > > > 
> > > > Fail dpc_probe() if the device has no AER Capability.
> > > > 
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Olof Johansson <olof@lixom.net>
> > > > ---
> > > >    drivers/pci/pcie/dpc.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > > index e05aba86a317..ed0dbc43d018 100644
> > > > --- a/drivers/pci/pcie/dpc.c
> > > > +++ b/drivers/pci/pcie/dpc.c
> > > > @@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
> > > >    	int status;
> > > >    	u16 ctl, cap;
> > > > +	if (!pdev->aer_cap)
> > > > +		return -ENOTSUPP;
> > > Don't we check aer_cap support in drivers/pci/pcie/portdrv_core.c ?
> > > 
> > > We don't enable DPC service, if AER service is not enabled. And AER
> > > service is only enabled if AER capability is supported.
> > > 
> > > So dpc_probe() should not happen if AER capability is not supported?
> > 
> > I don't think that's always true.  If I'm reading this right, we have
> > this:
> > 
> >    get_port_device_capability(...)
> >    {
> >    #ifdef CONFIG_PCIEAER
> >      if (dev->aer_cap && ...)
> >        services |= PCIE_PORT_SERVICE_AER;
> >    #endif
> > 
> >      if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> >          pci_aer_available() &&
> >          (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> >        services |= PCIE_PORT_SERVICE_DPC;
> >    }
> > 
> > and in the case where:
> > 
> >    - CONFIG_PCIEAER=y
> >    - booted with "pcie_ports=dpc-native" (pcie_ports_dpc_native is true)
> >    - "dev" has no AER capability
> >    - "dev" has DPC capability
> > 
> > I think we do enable PCIE_PORT_SERVICE_DPC.
> Got it. But further looking into it, I am wondering whether
> we should keep this dependency? Currently we just use it to
> dump the error information. Do we need to create dependency
> between DPC and AER (which is functionality not dependent) just
> to see more details about the error?

That's a good question, but I don't really want to get into the actual
operation of the AER and DPC drivers in this series, so maybe
something we should explore later.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1444726B0B3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgIOWRq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 18:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgIOWRc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 18:17:32 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01AC420732;
        Tue, 15 Sep 2020 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600208243;
        bh=TiL/JMlMqT49tuRdge+1NxOAcYMYi4Y5lNoE7DePQAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NU3iPv9OYHXounV/bCT5Jp7m75pCoNe7psbtLwsC5bY0zE0OKc+28Dvruz40Znyws
         w7q+VWk1b0g6rYA9qjdunlqvjX9ykSDdx5/QyRX9neT37sHck45XVpUM/tNjaVZwH6
         ve1JnB5oCpMi8gSNJuNat3hHV+kgjbcoMsgIwAkE=
Date:   Tue, 15 Sep 2020 17:17:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v8 1/5] PCI: Conditionally initialize host bridge
 native_* members
Message-ID: <20200915221721.GA1437311@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e9c26fb-97e9-4bda-e374-7c6bea9077eb@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 13, 2020 at 01:49:26PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 9/10/20 2:00 PM, Kuppuswamy, Sathyanarayanan wrote:
> > On 9/10/20 12:49 PM, Bjorn Helgaas wrote:
> > > On Fri, Jul 24, 2020 at 08:58:52PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
> > > > struct pci_host_bridge PCIe specific native_* members to "1" is
> > > > incorrect. So protect the PCIe specific member initialization
> > > > with CONFIG_PCIEPORTBUS.
> > > 
> > > s/initialing/initializing/
> > will fix it in next version.
> > > 
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > ---
> > > >   drivers/pci/probe.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 2f66988cea25..a94b97564ceb 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> > > >        * may implement its own AER handling and use _OSC to prevent the
> > > >        * OS from interfering.
> > > >        */
> > > > +#ifdef CONFIG_PCIEPORTBUS
> > > >       bridge->native_aer = 1;
> > > >       bridge->native_pcie_hotplug = 1;
> > > > -    bridge->native_shpc_hotplug = 1;
> > > >       bridge->native_pme = 1;
> > > >       bridge->native_ltr = 1;
> > > 
> > > native_ltr isn't dependent on PCIEPORTBUS either, is it?  It's only
> > > used for ASPM.
> > Agreed. I was confused due to a comment in include/linux/pci.h
> > 
> >   unsigned int    native_ltr:1;           /* OS may use PCIe LTR */

> Currently there is no code dependency between LTR and CONFIG_PCIEPORTBUS.
> 
> But I am wondering whether its correct to move LTR code under
> CONFIG_PCIEPORTBUS?. As per PCIe spec v5.0 sec 7.8.2, LTR is a
> optional PCIe extended capability. So why is not moved under
> drivers/pci/pcie/*. What is the criteria for code to be placed under
> drivers/pci/pcie/*

Some folks think drivers/pci/pcie/ should not exist, and I tend to
agree, but it's a fair bit of churn to remove it.  We do have quite a
bit of PCIe extended capability support in drivers/pci -- ats.c,
iov.c, vc.c.

There's no need to move LTR under CONFIG_PCIEPORTBUS because
CONFIG_PCIEPORTBUS enables portdrv, and AFAIK there's nothing
LTR-related that relies on portdrv.

The stuff currently in drivers/pci/pcie is mostly just portdrv and
services that depend on it.  aspm.c and ptm.c are exceptions and
really should be in drivers/pci.

> > > >       bridge->native_dpc = 1;
> > > > +#endif
> > > > +    bridge->native_shpc_hotplug = 1;
> > > >       device_initialize(&bridge->dev);
> > > >   }
> > > > -- 
> > > > 2.17.1
> > > > 
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

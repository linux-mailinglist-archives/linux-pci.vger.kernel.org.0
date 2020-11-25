Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D22C4911
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKYU2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 15:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgKYU2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 15:28:13 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDC9206F7;
        Wed, 25 Nov 2020 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606336092;
        bh=hyXKeeasxrDp6vKBWDh3TGV40ypskaL2JdeURSZGnTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mbv6RXVWDyhDCstwak09zATUCLmCp2jm+RlQpPp0TT2AxsT49i4wwuosrcx5A1LS/
         MpimQQMu1cLch6OLqcEmnSWLxshCdrRgg630SbNJF0h+03b/S0ekddhMqDj65GwJj0
         QQpwLEoMmjDcmPehqwGdSo6YvwFNdkLQUG7IyrfU=
Date:   Wed, 25 Nov 2020 14:28:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
Subject: Re: [PATCH v11 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
Message-ID: <20201125202810.GA674732@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 07:57:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
> pcie_ports_native is set only if user requests native handling
> of PCIe capabilities via pcie_port_setup command line option.
> User input takes precedence over _OSC based control negotiation
> result. So consider the _OSC negotiated result only if
> pcie_ports_native is unset.
> 
> Also, since struct pci_host_bridge ->native_* members caches the
> ownership status of various PCIe capabilities, use them instead
> of distributed checks for pcie_ports_native.

> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..ccd5e0ce5605 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int services = 0;
>  
> -	if (dev->is_hotplug_bridge &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> +	if (dev->is_hotplug_bridge && host->native_pcie_hotplug) {

This is a nit, but I think this and similar checks should be reordered
so we do the most generic test first, i.e.,

  if (host->native_pcie_hotplug && dev->is_hotplug_bridge)

Logically there's no point in looking at the device things if we
don't have native control.

>  		services |= PCIE_PORT_SERVICE_HP;
>  
>  		/*
> @@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	if (dev->aer_cap && pci_aer_available() && host->native_aer) {

Can't we clear host->native_aer when pci_aer_available() returns
false?  I'd like to have all the checks about whether we have native
control to be in one place instead of being scattered.  Something like
this above:

  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
  if (!pci_aer_available())
    host_bridge->native_aer = 0;

So this test would become:

  if (host->native_aer && dev->aer_cap)

>  		services |= PCIE_PORT_SERVICE_AER;
>  
>  		/*
> @@ -238,8 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 * Event Collectors can also generate PMEs, but we don't handle
>  	 * those yet.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> -	    (pcie_ports_native || host->native_pme)) {
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT && host->native_pme) {
>  		services |= PCIE_PORT_SERVICE_PME;

Also here:

  if (host->native_pme && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)

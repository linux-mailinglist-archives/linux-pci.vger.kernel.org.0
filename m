Return-Path: <linux-pci+bounces-42802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E063CAE867
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 01:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9BDC300CD6E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A522A7E6;
	Tue,  9 Dec 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvAsh6JU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4492116E0;
	Tue,  9 Dec 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765240205; cv=none; b=aIP6tKdDVjeNcjn8ODzguVIzrgT046auoLYqlvr2vI6Sdxj72dveTYXe74RXE+Bi9w4AfhyCf0gb2RMqV6qCAHzCzDOpyXrC9A1U6RVcqLRHRgjPAihJA0I1pr2G/VCItCZYENqJtA70wbzMU/OJQmCVFd6/bF24CsDnRfsJA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765240205; c=relaxed/simple;
	bh=uIOnczQcgxSPWkCuGxpR2EJBZFJat5++OZeHgYLg25c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ViFtH0QcKiKNQ3kXCI5prjwK3sZxwnr1HKcqS0TaLfrE7dy1owT+2Vz7HfzsFiR9pY5cbYiXYUrjlpiyUCj9DXkDoazsLsrn4WRz/qlYiwegQyNo9wG3IQjwDpyUx76Xm/evjiBxyxp5u4NaChkLbo3QnxGxxt5gkAK6p1G0tu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvAsh6JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C65C4CEF1;
	Tue,  9 Dec 2025 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765240205;
	bh=uIOnczQcgxSPWkCuGxpR2EJBZFJat5++OZeHgYLg25c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lvAsh6JUxWIoQPIZ4dUQxqBgSVCiADgkM2sGNAy8vgwUoo6j2yIjRtXJ5lAieGs2G
	 sQoSlAgSbjg2at6jWPazX24oAXLxfK62aYGT5YHhiBvCK31tL5si1+9AicHzL5g6ST
	 3Sh3p+WMGt0nxXCezY2tKk4yA+QQ2R/VtMWFp0Hhxl9K+37tv61/Y5Cr+HM6MKK3zP
	 Fwj4/sEkGKTe74+w3F7jGAGbgwta73pT0tT6DneccMu86Idrog/O2Pj91cS3428iNb
	 aODwIDk05Fy63EpGvtmJIdut1kUUwnCGjb3mG9+9Ok4wUx88sFC/43+8vH8iDgEoUU
	 Z2+5n2F0H50qg==
Date: Mon, 8 Dec 2025 18:30:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Darshit Shah <darnshah@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>, darnir@gnu.org,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH] drivers/pci: Allow attaching AER to non-RP devices that
 support MSI
Message-ID: <20251209003003.GA3436550@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128122053.35909-1-darnshah@amazon.de>

On Fri, Nov 28, 2025 at 12:20:53PM +0000, Darshit Shah wrote:
> Previously portdrv tried to prevent non-Root Port (RP) and non-Root
> Complex Event Collector (RCEC) devices from enabling AER capability.
> This was done because some switches enable AER but do not support MSI.
> Hence, trying to initialize the AER IRQ for such devices would fail and
> Linux would fail to claim the switch port entirely.

The d8d2b65a940b commit log could have been clearer.

Some switches advertise an AER capability, but they can't generate AER
interrupts, regardless of whether they support MSI.  Only RPs and
RCECs can generate AER interrupts.

> However, it is possible to have switches upstream of an endpoint that
> support MSI and AER. Without AER capability being enabled on such
> a switch, portdrv will refuse to enable the DPC capability as well,
> preventing a PCIe error on an endpoint from being handled by the switch.
> 
> Allow enabling the AER service on non-RP, non-RCEC devices if they still
> support both AER and MSI. This allows switches upstream of an endpoint
> to generate and handle DPC events.
> Fixes: d8d2b65a940b ("PCI/portdrv: Allow AER service only for Root Ports & RCECs")
> Signed-off-by: Darshit Shah <darnshah@amazon.de>
> ---
>  drivers/pci/pcie/portdrv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index d1b68c18444f..41326bbcd295 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -237,8 +237,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> +	if ((dev->msi_cap || pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>  	    dev->aer_cap && pci_aer_available() &&
>  	    (pcie_ports_native || host->native_aer))
>  		services |= PCIE_PORT_SERVICE_AER;
> -- 
> 2.47.3
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 


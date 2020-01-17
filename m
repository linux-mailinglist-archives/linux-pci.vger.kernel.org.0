Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA47414125E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 21:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgAQUlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 15:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgAQUlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 15:41:17 -0500
Received: from localhost (187.sub-174-234-133.myvzw.com [174.234.133.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00EBA2072E;
        Fri, 17 Jan 2020 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579293677;
        bh=X+HN8JA8Xxvdsg8uqHSGhQAuKo7DGP04S09Aa7FL/CU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zAbWCcjEPpYO5qaR8+LvWr1qAZhtcTHoGqsK0nGWhln0iZrm3FZgs3CuVsZtWRldg
         KpjorYVAZaj58XfKaPP1ud7QblYwtxOBpVVIBkoARr2QUQbZZGOO/GiEmFW3vvqV9f
         SDYFyuEb+ipV5kw195W6N9YLcRQOvHzoEodTb1aM=
Date:   Fri, 17 Jan 2020 14:41:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v12 8/8] PCI/ACPI: Enable EDR support
Message-ID: <20200117204115.GA126492@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15c5467ab8d52ede096b598e14c1beae1ce8e48.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 02:44:02PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, sec 4.5.1, OS must implement following steps
> to enable/use EDR feature.
> 
> 1. OS can use bit 7 of _OSC Control Field to negotiate control over
> Downstream Port Containment (DPC) configuration of PCIe port. After _OSC
> negotiation, firmware will Set this bit to grant OS control over PCIe
> DPC configuration and Clear it if this feature was requested and denied,
> or was not requested.
> 
> 2. Also, if OS supports EDR, it should expose its support to BIOS by
> setting bit 7 of _OSC Support Field. And if OS sets bit 7 of _OSC
> Control Field it must also expose support for EDR by setting bit 7 of
> _OSC Support Field.

> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -253,10 +253,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	/*
>  	 * With dpc-native, allow Linux to use DPC even if it doesn't have
>  	 * permission to use AER.
> +	 * If EDR support is enabled in OS, then even if AER is not handled in
> +	 * OS, DPC service can be enabled.

Can you clarify this comment?  It talks about AER, but the code you
added:

  (IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc)

doesn't have anything to do with AER.

>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
> +	    (pci_aer_available() &&
> +	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))))
>  		services |= PCIE_PORT_SERVICE_DPC;

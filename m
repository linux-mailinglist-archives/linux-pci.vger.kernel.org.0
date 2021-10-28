Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9190143E855
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJ1Sd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:33:28 -0400
Received: from foss.arm.com ([217.140.110.172]:58164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1Sd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E6051063;
        Thu, 28 Oct 2021 11:31:00 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC3E3F5A1;
        Thu, 28 Oct 2021 11:30:59 -0700 (PDT)
Date:   Thu, 28 Oct 2021 19:30:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 12/14] PCI: aardvark: Set PCI Bridge Class Code to PCI
 Bridge
Message-ID: <20211028183054.GA4746@lpieralisi>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-13-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012164145.14126-13-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 06:41:43PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Aardvark controller has something like config space of a Root Port
> available at offset 0x0 of internal registers - these registers are used
> for implementation of the emulated bridge.
> 
> The default value of Class Code of this bridge corresponds to a RAID Mass
> storage controller, though. (This is probably intended for when the
> controller is used as Endpoint.)
> 
> Change the Class Code to correspond to a PCI Bridge.
> 
> Add comment explaining this change.
> 
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-aardvark.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 289cd45ed1ec..801657e7da93 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -513,6 +513,26 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  	reg = (PCI_VENDOR_ID_MARVELL << 16) | PCI_VENDOR_ID_MARVELL;
>  	advk_writel(pcie, reg, VENDOR_ID_REG);
>  
> +	/*
> +	 * Change Class Code of PCI Bridge device to PCI Bridge (0x600400),
> +	 * because the default value is Mass storage controller (0x010400).
> +	 *
> +	 * Note that this Aardvark PCI Bridge does not have compliant Type 1
> +	 * Configuration Space and it even cannot be accessed via Aardvark's
> +	 * PCI config space access method. Something like config space is
> +	 * available in internal Aardvark registers starting at offset 0x0
> +	 * and is reported as Type 0. In range 0x10 - 0x34 it has totally
> +	 * different registers.

Is the RP enumerated as a PCI device with type 0 header ?

> +	 *
> +	 * Therefore driver uses emulation of PCI Bridge which emulates
> +	 * access to configuration space via internal Aardvark registers or
> +	 * emulated configuration buffer.
> +	 */
> +	reg = advk_readl(pcie, PCIE_CORE_DEV_REV_REG);
> +	reg &= ~0xffffff00;
> +	reg |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;
> +	advk_writel(pcie, reg, PCIE_CORE_DEV_REV_REG);

I remember Bjorn commenting on something similar in the past - he may
have some comments on whether this change is the right thing to do.

Lorenzo

>  	/* Disable Root Bridge I/O space, memory space and bus mastering */
>  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>  	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> -- 
> 2.32.0
> 

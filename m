Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72734853FF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiAEOBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 09:01:42 -0500
Received: from foss.arm.com ([217.140.110.172]:44758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235724AbiAEOBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 09:01:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E258B1FB;
        Wed,  5 Jan 2022 06:01:39 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E18D13F5A1;
        Wed,  5 Jan 2022 06:01:38 -0800 (PST)
Date:   Wed, 5 Jan 2022 14:01:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, tsbogend@alpha.franken.de,
        bhelgaas@google.com, arnd@arndb.de, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: mt7621: Convert driver into 'bool'
Message-ID: <20220105140132.GA7208@lpieralisi>
References: <20211203192454.32624-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203192454.32624-1-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 08:24:54PM +0100, Sergio Paracuellos wrote:
> Driver is not ready yet to be compiled as a module since it depends on some
> MIPS not exported symbols. We have the following current problems:
> 
> Building mips:allmodconfig ... failed
> --------------
> Error log:
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> 
> Temporarily move from 'tristate' to 'bool' until a better solution is ready.
> 
> Also RALINK is redundant because SOC_MT7621 already depends on it. Hence,
> simplify condition.
> 
> Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver").
> Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v3:
>  - Adjust subject to follow convention:
>     s/PCI: mt7621: Kconfig:/PCI: mt7621:/
> Changes in v2:
>  - Add Guenter's 'Reviewed-and-tested-by'.
>  - s/after/until
>  drivers/pci/controller/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 93b141110537..7fc5135ffbbf 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -332,8 +332,8 @@ config PCIE_APPLE
>  	  If unsure, say Y if you have an Apple Silicon system.
>  
>  config PCIE_MT7621
> -	tristate "MediaTek MT7621 PCIe Controller"
> -	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> +	bool "MediaTek MT7621 PCIe Controller"
> +	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
>  	select PHY_MT7621_PCI
>  	default SOC_MT7621
>  	help
> -- 
> 2.33.0
> 

Hi Sergio,

I believe this is still to be pulled in some tree, just asking for
confirmation, please let me know and I will queue it.

Thanks,
Lorenzo

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775EF461D58
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbhK2SMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 13:12:15 -0500
Received: from foss.arm.com ([217.140.110.172]:44266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245151AbhK2SKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 13:10:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940AC1063;
        Mon, 29 Nov 2021 10:06:57 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994453F5A1;
        Mon, 29 Nov 2021 10:06:56 -0800 (PST)
Date:   Mon, 29 Nov 2021 18:06:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: mt7621: declare 'mt7621_pci_ops' static
Message-ID: <20211129180653.GB26780@lpieralisi>
References: <20211117152952.12271-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117152952.12271-1-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 04:29:52PM +0100, Sergio Paracuellos wrote:
> Sparse complains about 'mt7621_pci_ops' symbol is not declared and asks if
> it should be declared as 'static' instead. Sparse is right. Hence declare
> symbol as static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/mt7621, thanks.

Lorenzo

> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index b60dfb45ef7b..4138c0e83513 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -148,7 +148,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
>  	return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
>  }
>  
> -struct pci_ops mt7621_pci_ops = {
> +static struct pci_ops mt7621_pci_ops = {
>  	.map_bus	= mt7621_pcie_map_bus,
>  	.read		= pci_generic_config_read,
>  	.write		= pci_generic_config_write,
> -- 
> 2.33.0
> 

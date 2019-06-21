Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA814EFD8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 22:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFUUIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 16:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUUIu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 16:08:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3524720673;
        Fri, 21 Jun 2019 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561147729;
        bh=AN0vpG2KBuc/fVCklXR8c1Pz5Joougr0bod/vOlROHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2U833aO9vq7b8WUyV4aFXVud1ZYYJp/yHpkCVnTDf/1ox7RHLVEr+KNr5XdLHdM/L
         5R9vvD60BXVZIYCNNIhlzanqGZ10zfP8bP0HctPYDwbsIWn9vDAQ5/tj2wQGFyxHrz
         wwkghX8HdMF/fG1fgIcGjTVrV5Ej1HkzPi8lLv/w=
Date:   Fri, 21 Jun 2019 15:08:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] arm64: pci: acpi: Preserve PCI resources
 configuration when asked by ACPI
Message-ID: <20190621200848.GE127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
 <20190615002359.29577-4-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615002359.29577-4-benh@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  arm64: PCI: Preserve firmware configuration when necessary

On Sat, Jun 15, 2019 at 10:23:59AM +1000, Benjamin Herrenschmidt wrote:
> When _DSM #5 returns 0 for a host bridge, we need to claim the existing
> resources rather than reassign everything.

Use imperative mood.  I'd remove the reference to _DSM #5.  This patch
does not directly reference _DSM, and it's conceivable a kernel
command line parameter or other mechanism could set
host->preserve_config.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm64/kernel/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1419b1b4e9b9..a2c608a3fc41 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
> +	struct pci_host_bridge *hb;
>  
>  	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
> @@ -193,6 +194,16 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> +	hb = pci_find_host_bridge(bus);
> +
> +	/* If ACPI tells us to preserve the resource configuration, claim now */
> +	if (hb->preserve_config)
> +		pci_bus_claim_resources(bus);
> +
> +	/*
> +	 * Assign whatever was left unassigned. If we didn't claim above, this will
> +	 * reassign everything.

Wrap the comment so it fits in 80 columns (unless local arch/arm64 style
allows wider lines, but I don't see any other wide lines in the file).

This series generally looks good to me.

> +	 */
>  	pci_assign_unassigned_root_bus_resources(bus);
>  
>  	list_for_each_entry(child, &bus->children, node)
> -- 
> 2.17.1
> 

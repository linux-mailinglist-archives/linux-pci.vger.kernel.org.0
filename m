Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBEF31E0EB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Feb 2021 21:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhBQU6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 15:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232099AbhBQU6i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Feb 2021 15:58:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E6C564E45;
        Wed, 17 Feb 2021 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613595477;
        bh=7pHEq2BmxC1gbjH40hnPqBffasILhh3nRLnjPDHvUMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bVtRqR19JxQ/dgzSkLuiq7vcYpRC8N7EVw5Qlqs0uKkRiWg/CAOhnjXB1HTTRFc87
         6a/dWeZpiw3BRPlPeTQ6E0gJEvAcMqmqkEtsFKITjLtKa7Gkz1nPf8ifCEd7aiGTzw
         bN6NkpoR02j5395kawShvXfz1w1RCF9Pb1Onm80xv0htQCHtKCDozptQp4WTPe+Ak6
         znn7fZZV/QQ4Rrp37ZYobcK3ez5Tw9Lw0tBi/Vk35AT4hSCxiEB3vfhdwko6xGQwAv
         dz022dwSxdfuQEhbqJucjREx1JQiRZjujTpxIUo3Zaw6Y9syhEHY5fbrio5UL7+SbM
         VK176gBhlX2aQ==
Date:   Wed, 17 Feb 2021 14:57:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Fix erroneous early return from an iterator
Message-ID: <20210217205755.GA911403@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210216205935.3112661-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 16, 2021 at 08:59:35PM +0000, Krzysztof Wilczyński wrote:
> Function cdns_pcie_host_map_dma_ranges() iterates over a PCIe host
> bridge DMA ranges using the resource_list_for_each_entry() iterator.
> 
> With every iteration it calls cdns_pcie_host_bar_config() on each entry
> in the list, and performs error checking following execution of said
> function.
> 
> Normally, should there be an error, the iteration would be interrupted
> and the function would terminate returning an error, but following the
> merge commit 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
> that also had to resolve a merge conflict of the pcie-cadence-host.c
> file, where an if-statement involved in the error handling has been
> unintentionally altered causing a return statement to be outside of the
> code block, and thus an undesired early return takes place on first
> iteration.
> 
> Fix the if-statement and move the return statement inside the correct
> code block so that the error checking works correctly, and to prevent
> undesired early return.
> 
> Fixes: 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Ouch, I really botched that merge, sorry!

> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 811c1cb2e8de..1cb7cfc75d6e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -321,9 +321,10 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>  		err = cdns_pcie_host_bar_config(rc, entry);
> -		if (err)
> +		if (err) {
>  			dev_err(dev, "Fail to configure IB using dma-ranges\n");
> -		return err;
> +			return err;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.30.0
> 

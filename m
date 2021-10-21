Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F212F4366F3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhJUQAc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 12:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhJUQAb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 12:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7965B611F2;
        Thu, 21 Oct 2021 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634831895;
        bh=L8SsVdAZqmcgc/l54J3ELRGN7EmFDhRqTkhV3QJ2iKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g68FH0cq70aXjdoLx1elPMm198APq1afbrCj255hNtE16R57d8oXEDmN7iTTXrpTW
         b9j+sr38KKZXJI8hErEfOfBkZPSwM8wXM+XVw9Ans7H1LmqDGws8Bt061fGGwjpKr5
         yY9n9zmu1e5y2pboT41A4tSMKzkRUNymNPE6ftIrcIpAvU3vm2pmgwtlEFfgjJxoQO
         DBWNCZFk3Wo6qxHitCTMYnAUlXtiQ9ceUqtvEAQPjO9jx/20veksxxDjZ8NrxEsq5h
         NtwIwY2i9gGtMiQQrZFGkXwUnTo51SirTAeX5kW80tDOcCXgxQWlpwVHGfdXNMfXkS
         MytNmg154KS0A==
Received: by pali.im (Postfix)
        id 20E5C85E; Thu, 21 Oct 2021 17:58:13 +0200 (CEST)
Date:   Thu, 21 Oct 2021 17:58:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:PCI DRIVER FOR AARDVARK (Marvell Armada 3700)" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 11/25] PCI: aardvark: Remove redundant error
 fabrication when device read fails
Message-ID: <20211021155812.qwihgqo6dk73433w@pali>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
 <cbf7437d33551cd267135d2ed2a33bb789369e85.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbf7437d33551cd267135d2ed2a33bb789369e85.1634825082.git.naveennaidu479@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 21 October 2021 20:37:36 Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error. There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> The host controller drivers sets the error response values (~0) and
> returns an error when faulty hardware read occurs. But the error
> response value (~0) is already being set in PCI_OP_READ and
> PCI_USER_READ_CONFIG whenever a read by host controller driver fails.
> 
> Thus, it's no longer necessary for the host controller drivers to
> fabricate any error response.
> 
> This helps unify PCI error response checking and make error check
> consistent and easier to find.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/pci/controller/pci-aardvark.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 596ebcfcc82d..1af772c76d06 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -893,10 +893,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	u32 reg;
>  	int ret;
>  
> -	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> -		*val = 0xffffffff;
> +	if (!advk_pcie_valid_device(pcie, bus, devfn))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> -	}
>  
>  	if (pci_is_root_bus(bus))
>  		return pci_bridge_emul_conf_read(&pcie->bridge, where,
> @@ -920,7 +918,6 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			*val = CFG_RD_CRS_VAL;
>  			return PCIBIOS_SUCCESSFUL;
>  		}
> -		*val = 0xffffffff;
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
> @@ -955,16 +952,13 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			*val = CFG_RD_CRS_VAL;
>  			return PCIBIOS_SUCCESSFUL;
>  		}
> -		*val = 0xffffffff;
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
>  	/* Check PIO status and get the read result */
>  	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
> -	if (ret < 0) {
> -		*val = 0xffffffff;
> +	if (ret < 0)
>  		return PCIBIOS_SET_FAILED;
> -	}
>  
>  	if (size == 1)
>  		*val = (*val >> (8 * (where & 3))) & 0xff;
> -- 
> 2.25.1
> 

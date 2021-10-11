Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA9429681
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhJKSKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJKSKx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 14:10:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F72C60EB4;
        Mon, 11 Oct 2021 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633975733;
        bh=znvt7lXTrjz8Q7uFKJ50VwboQPdEorWs9uuIA7tBazI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzTduaqzuCsLQPm6VXtRH2KVlfxrgwAeezXN8LIoJto9GnO4HarUxbwIRF+OXLcgG
         CwjE9u/52RytsnFKZXPva+CQiHJKAq/NFa2ZmAqb/yFosQ/JPVq21eChF9PyUjT+c+
         JXeH2y/MI9mOL2FudCVWGv25ImJZ9uCWOIBxZTkYR0gb04FM/UPGgaPr1I9bbli7KU
         QNwiHCeyh2xqZhtEF3dAb6yC1vqU3uVrehkvxsEL/KNcAfrkS5RKkiabqdcMlRVqI7
         5k6FV2b6Czrb9x0v2JiS1x71z3B1jTS3qqvG6HzllevLVtGJEuQbPnQYLvVV7st0us
         g4NT/kEUJrdGg==
Received: by pali.im (Postfix)
        id 0B6BB7C9; Mon, 11 Oct 2021 20:08:50 +0200 (CEST)
Date:   Mon, 11 Oct 2021 20:08:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:PCI DRIVER FOR AARDVARK (Marvell Armada 3700)" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/22] PCI: aardvark: Use SET_PCI_ERROR_RESPONSE() when
 device not found
Message-ID: <20211011180850.hgp4ctykvus37fx7@pali>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <f423dc9cc90e345680d289d5df7ff469e9b89c60.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f423dc9cc90e345680d289d5df7ff469e9b89c60.1633972263.git.naveennaidu479@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 11 October 2021 23:26:33 Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
> read occurs.
> 
> This helps unify PCI error response checking and make error check
> consistent and easier to find.
> 
> Compile tested only.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 596ebcfcc82d..dc2f820ef55f 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -894,7 +894,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	int ret;
>  
>  	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> -		*val = 0xffffffff;
> +		SET_PCI_ERROR_RESPONSE(val);

Hello! Now I'm looking at this macro, and should not it depends on
"size" argument? If doing 8-bit or 16-bit read operation then should not
it rather sets only low 8 bits or low 16 bits to ones?

>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -920,7 +920,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			*val = CFG_RD_CRS_VAL;
>  			return PCIBIOS_SUCCESSFUL;
>  		}
> -		*val = 0xffffffff;
> +		SET_PCI_ERROR_RESPONSE(val);
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
> @@ -955,14 +955,14 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			*val = CFG_RD_CRS_VAL;
>  			return PCIBIOS_SUCCESSFUL;
>  		}
> -		*val = 0xffffffff;
> +		SET_PCI_ERROR_RESPONSE(val);
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
>  	/* Check PIO status and get the read result */
>  	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
>  	if (ret < 0) {
> -		*val = 0xffffffff;
> +		SET_PCI_ERROR_RESPONSE(val);
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
> -- 
> 2.25.1
> 

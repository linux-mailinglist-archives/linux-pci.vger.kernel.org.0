Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF15DE911
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfJUKLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 06:11:41 -0400
Received: from [217.140.110.172] ([217.140.110.172]:47886 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUKLl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 06:11:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD65A1650;
        Mon, 21 Oct 2019 03:11:17 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 260223F718;
        Mon, 21 Oct 2019 03:11:16 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:11:15 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 1/3] PCI: rcar: Move the inbound index check
Message-ID: <20191021101114.GL47056@e119886-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809175741.7066-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 07:57:39PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Since the $idx variable value is stored across multiple calls to
> rcar_pcie_inbound_ranges() function, and the $idx value is used to
> index registers which are written, subsequent calls might cause
> the $idx value to be high enough to trigger writes into nonexistent
> registers.
> 
> Fix this by moving the $idx value check to the beginning of the loop.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> V2: New patch
> V3: Adjust the check to idx >= MAX_NR_INBOUND_MAPS - 1
> ---
>  drivers/pci/controller/pcie-rcar.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index f6a669a9af41..56a6433eb70b 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1048,6 +1048,10 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>  	mask &= ~0xf;
>  
>  	while (cpu_addr < cpu_end) {
> +		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
> +			dev_err(pcie->dev, "Failed to map inbound regions!\n");
> +			return -EINVAL;
> +		}
>  		/*
>  		 * Set up 64-bit inbound regions as the range parser doesn't
>  		 * distinguish between 32 and 64-bit types.
> @@ -1067,11 +1071,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>  		pci_addr += size;
>  		cpu_addr += size;
>  		idx += 2;
> -
> -		if (idx > MAX_NR_INBOUND_MAPS) {
> -			dev_err(pcie->dev, "Failed to map inbound regions!\n");
> -			return -EINVAL;
> -		}
>  	}
>  	*index = idx;
>  
> -- 
> 2.20.1
> 

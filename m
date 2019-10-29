Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604D8E874A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfJ2Lhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:37:55 -0400
Received: from foss.arm.com ([217.140.110.172]:51030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbfJ2Lhz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 07:37:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7891F1;
        Tue, 29 Oct 2019 04:37:54 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB83D3F71E;
        Tue, 29 Oct 2019 04:37:53 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:37:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4 1/2] PCI: rcar: Move the inbound index check
Message-ID: <20191029113749.GA1635@e121166-lin.cambridge.arm.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026182659.2390-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 26, 2019 at 08:26:58PM +0200, marek.vasut@gmail.com wrote:
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
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> V2: New patch
> V3: Adjust the check to idx >= MAX_NR_INBOUND_MAPS - 1
> V4: Rebase on next/master
> ---
>  drivers/pci/controller/pcie-rcar.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied both patches to pci/rcar, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index e45bb2a7bfa5..b2a5c3e94245 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1049,6 +1049,10 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
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
> @@ -1068,11 +1072,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
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
> 2.23.0
> 

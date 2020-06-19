Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5516A20075A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgFSK40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 06:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732362AbgFSK4V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 06:56:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE88A2070A;
        Fri, 19 Jun 2020 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592564181;
        bh=lV1+A7bMoEGDBQ8uA1/9V3ySmJlveKx+p0zRy9lWR3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgwsv5aJtotabI2+zSJ7wHUq4N42CoxNVJGMzfX6UzU/YPThQpKRVLnDN3UAmzTs6
         WqxQaGQU3ToNaal7MfirJJD9yTzcqKrpte1lJ+tNmAQ/K6PZQlzN26lcuP6LKpdQRB
         B4hu1N48nRwqYrGhx9ZW9IszvzcwExuuKUUY6a1Y=
Received: by pali.im (Postfix)
        id 9E2FD820; Fri, 19 Jun 2020 12:56:18 +0200 (CEST)
Date:   Fri, 19 Jun 2020 12:56:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Indicate error in 'val' when config read
 fails
Message-ID: <20200619105618.aksoivu4gb5ex3s3@pali>
References: <20200601130315.18895-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601130315.18895-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo! Could you please review this patch?

On Monday 01 June 2020 15:03:15 Pali Rohár wrote:
> Most callers of config read do not check for return value. But most of the
> ones that do, checks for error indication in 'val' variable.
> 
> This patch updates error handling in advk_pcie_rd_conf() function. If PIO
> transfer fails then 'val' variable is set to 0xffffffff which indicates
> failture.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

I should add credit for Bjorn as he found this issue

Reported-by: Bjorn Helgaas <helgaas@kernel.org>

> ---
>  drivers/pci/controller/pci-aardvark.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 53a4cfd7d377..783a7f1f2c44 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -691,8 +691,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	advk_writel(pcie, 1, PIO_START);
>  
>  	ret = advk_pcie_wait_pio(pcie);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		*val = 0xffffffff;
>  		return PCIBIOS_SET_FAILED;
> +	}
>  
>  	advk_pcie_check_pio_status(pcie);
>  
> -- 
> 2.20.1
> 

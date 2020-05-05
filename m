Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181A51C53DB
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 13:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgEELE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 07:04:28 -0400
Received: from foss.arm.com ([217.140.110.172]:37252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 07:04:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B66030E;
        Tue,  5 May 2020 04:04:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AF6F3F305;
        Tue,  5 May 2020 04:04:26 -0700 (PDT)
Date:   Tue, 5 May 2020 12:04:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linus.walleij@linaro.org, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: v3-semi: Fix a memory leak in some error handling
 paths in 'v3_pci_probe()'
Message-ID: <20200505110423.GC13446@e121166-lin.cambridge.arm.com>
References: <20200418081637.1585-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418081637.1585-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 18, 2020 at 10:16:37AM +0200, Christophe JAILLET wrote:
> IF we fails somewhere in 'v3_pci_probe()', we need to free 'host'.
> Use the managed version of 'pci_alloc_host_bridge()' to do that easily.
> The use of managed resources is already widely used in this driver.
> 
> Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Fixes could be older than this commit, but this is as far as git can go.
> 
> There is also a 'clk_prepare_enable()' which looks un-ballanced. I don't
> know if it can be an issue.
> 
> Compile tested only.
> ---
>  drivers/pci/controller/pci-v3-semi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/v3-semi, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index bd05221f5a22..ddcb4571a79b 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -720,7 +720,7 @@ static int v3_pci_probe(struct platform_device *pdev)
>  	int irq;
>  	int ret;
>  
> -	host = pci_alloc_host_bridge(sizeof(*v3));
> +	host = devm_pci_alloc_host_bridge(dev, sizeof(*v3));
>  	if (!host)
>  		return -ENOMEM;
>  
> -- 
> 2.20.1
> 

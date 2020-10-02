Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE142811DA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgJBL5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 07:57:41 -0400
Received: from foss.arm.com ([217.140.110.172]:33818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387768AbgJBL5l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 07:57:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748CE1063;
        Fri,  2 Oct 2020 04:57:40 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A82793F70D;
        Fri,  2 Oct 2020 04:57:39 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:57:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: loongson: simplify the return expression of
 loongson_pci_probe()
Message-ID: <20201002115737.GD23640@e121166-lin.cambridge.arm.com>
References: <20200921131054.92797-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131054.92797-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 09:10:54PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/controller/pci-loongson.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied to pci/loongson, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 719c19fe2..48169b1e3 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -183,7 +183,6 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	struct pci_host_bridge *bridge;
>  	struct resource *regs;
> -	int err;
>  
>  	if (!node)
>  		return -ENODEV;
> @@ -222,11 +221,7 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  	bridge->ops = &loongson_pci_ops;
>  	bridge->map_irq = loongson_map_irq;
>  
> -	err = pci_host_probe(bridge);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return pci_host_probe(bridge);
>  }
>  
>  static struct platform_driver loongson_pci_driver = {
> -- 
> 2.23.0
> 

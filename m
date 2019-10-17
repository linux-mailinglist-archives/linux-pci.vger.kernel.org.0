Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE682DA9BE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408820AbfJQKTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 06:19:17 -0400
Received: from [217.140.110.172] ([217.140.110.172]:38226 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2408801AbfJQKTP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 06:19:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D311BC0;
        Thu, 17 Oct 2019 03:18:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F40F3F718;
        Thu, 17 Oct 2019 03:18:45 -0700 (PDT)
Date:   Thu, 17 Oct 2019 11:18:43 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: mvebu_pcie_map_registers __iomem fix
Message-ID: <20191017101843.GC9589@e121166-lin.cambridge.arm.com>
References: <20191015161148.4413-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015161148.4413-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 05:11:48PM +0100, Ben Dooks (Codethink) wrote:
> Fix the return type of mvebu_pcie_map_registers in the
> error path to have __iomem on it. Fixes the following
> sparse warning:
> 
> drivers/pci/controller/pci-mvebu.c:716:31: warning: incorrect type in return expression (different address spaces)
> drivers/pci/controller/pci-mvebu.c:716:31:    expected void [noderef] <asn:2> *
> drivers/pci/controller/pci-mvebu.c:716:31:    got void *
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/controller/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/misc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index ed032e9a3156..153a64676bc9 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -713,7 +713,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
>  
>  	ret = of_address_to_resource(np, 0, &regs);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return (void __iomem *)ERR_PTR(ret);
>  
>  	return devm_ioremap_resource(&pdev->dev, &regs);
>  }
> -- 
> 2.23.0
> 

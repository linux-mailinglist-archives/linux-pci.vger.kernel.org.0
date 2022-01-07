Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF0487BE0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiAGSPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 13:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiAGSPR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 13:15:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8536C061574;
        Fri,  7 Jan 2022 10:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D06EB82691;
        Fri,  7 Jan 2022 18:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22F6C36AE0;
        Fri,  7 Jan 2022 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641579314;
        bh=KfKL7MpIagRPKLIHPgNwkikE/2lMY8PB5xDuLTe0wq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mhBz42H2UAPIGguatoTXJE2rOt0/4Z7LOduZe+kz2f1tnbd8pqDPrxgfK/UzY74Xz
         DqTajoP7bxiOJKBmRgB0C4pb1p7m1VfNT8v+HObunVhXScMvkLXABD/IpdGkFuqlh1
         /HngyplPvbyq42ccCvYJ12N74RASq8POxrgumpcT/WLz7ygpx5tA3N3iD16OmiytTW
         Tmm4yONtjXlFAl5LcsXzx/2dYknPbcoGY/uI2fD92OK3v+2T3E2pgL+DNa1b8KNWUm
         x+kWjvmB+VkTRfvb064eHDIb32gknnEVuAcNgubdhQk5kihbThOYxIZeELObVslb+A
         4nY8wchxB8ghQ==
Date:   Fri, 7 Jan 2022 12:15:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] PCI: mvebu: Check that PCI bridge specified in DT
 has function number zero
Message-ID: <20220107181512.GA390598@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125124605.25915-4-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 25, 2021 at 01:45:53PM +0100, Pali Rohár wrote:
> Driver cannot handle PCI bridges at non-zero function address. So add
> appropriate check. Currently all in-tree kernel DTS files set PCI bridge
> function to zero.

Why can the driver not handle bridges at non-zero function addresses?
The PCI spec allows that, doesn't it?  Is this a hardware limitation?

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-mvebu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 6197f7e7c317..08274132cdfb 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -864,6 +864,11 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  	port->devfn = of_pci_get_devfn(child);
>  	if (port->devfn < 0)
>  		goto skip;
> +	if (PCI_FUNC(port->devfn) != 0) {
> +		dev_err(dev, "%s: invalid function number, must be zero\n",
> +			port->name);
> +		goto skip;
> +	}
>  
>  	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM,
>  				 &port->mem_target, &port->mem_attr);
> -- 
> 2.20.1
> 

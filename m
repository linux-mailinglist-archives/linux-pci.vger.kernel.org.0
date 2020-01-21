Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03C14427F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAUQwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 11:52:15 -0500
Received: from foss.arm.com ([217.140.110.172]:45822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgAUQwP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jan 2020 11:52:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E985328;
        Tue, 21 Jan 2020 08:52:15 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F2653F6C4;
        Tue, 21 Jan 2020 08:52:13 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:52:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix error handling when "num-viewport" DT
 property is not populated
Message-ID: <20200121165208.GA21742@e121166-lin.cambridge.arm.com>
References: <20200121115734.7047-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121115734.7047-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 21, 2020 at 05:27:34PM +0530, Kishon Vijay Abraham I wrote:
> Fix error handling when "num-viewport" DT property is not populated.
> 
> Fixes: 23284ad677a94 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> Cc: stable@vger.kernel.org # v5.2+
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/keystone, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index dbe31589eb61..2c127c321080 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1357,7 +1357,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		ret = of_property_read_u32(np, "num-viewport", &num_viewport);
>  		if (ret < 0) {
>  			dev_err(dev, "unable to read *num-viewport* property\n");
> -			return ret;
> +			goto err_get_sync;
>  		}
>  
>  		/*
> -- 
> 2.17.1
> 

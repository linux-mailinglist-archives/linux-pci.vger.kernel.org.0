Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E403CC00F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389980AbfJDQFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 12:05:23 -0400
Received: from foss.arm.com ([217.140.110.172]:49120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389794AbfJDQFX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 12:05:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8989215AB;
        Fri,  4 Oct 2019 09:05:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CBEE3F68E;
        Fri,  4 Oct 2019 09:05:21 -0700 (PDT)
Date:   Fri, 4 Oct 2019 17:05:20 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Yurii Monakov <monakov.y@gmail.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191004160519.GV42880@e119886-lin.cambridge.arm.com>
References: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:
> PCIe window memory start address should be incremented by OB_WIN_SIZE
> megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
> 
> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index af677254a072..f19de60ac991 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  				   lower_32_bits(start) | OB_ENABLEN);
>  		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
>  				   upper_32_bits(start));
> -		start += OB_WIN_SIZE;
> +		start += OB_WIN_SIZE * SZ_1M;

This looks fine, however are the earlier lines still correct?

        val = ilog2(OB_WIN_SIZE);
        ks_pcie_app_writel(ks_pcie, OB_SIZE, val);

Thanks,

Andrew Murray

>  	}
>  
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> -- 
> 2.17.1
> 

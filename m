Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A6120359
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLPLIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:08:25 -0500
Received: from foss.arm.com ([217.140.110.172]:50240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfLPLIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:08:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28881FB;
        Mon, 16 Dec 2019 03:08:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298DB3F6CF;
        Mon, 16 Dec 2019 03:08:24 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:08:22 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Yurii Monakov <monakov.y@gmail.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH] PCI: keystone: Link training retries initiation
Message-ID: <20191216110821.GR24359@e119886-lin.cambridge.arm.com>
References: <20191007114159.61ad83ea@monakov-y.office.kontur-niirs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007114159.61ad83ea@monakov-y.office.kontur-niirs.ru>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 07, 2019 at 11:41:59AM +0300, Yurii Monakov wrote:
> ks_pcie_stop_link function never cleared LTSSM_EN_VAL bit so
> link training was never triggered more than once after startup.
> In configurations where link can be unstable during early boot,
> for example, under low temperature, it will never be established.
> 
> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index f19de60ac991..ea8e7ebd8c4f 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -510,7 +510,7 @@ static void ks_pcie_stop_link(struct dw_pcie *pci)
>  	/* Disable Link training */
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
>  	val &= ~LTSSM_EN_VAL;
> -	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);

Oh yeah, that doesn't look right to me. Good spot. Thanks for this!

> +	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);

As far as I can work out, this bug existed from the beginning - can
you please resend with this tag?

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")

Can you also update the commit subject to emphasise it's a bug fix,
e.g. PCI: keystone: Fix ... or similar.

Thanks,

Andrew Murray

>  }
>  
>  static int ks_pcie_start_link(struct dw_pcie *pci)
> -- 
> 2.17.1
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D181005D3
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 13:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKRMqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 07:46:36 -0500
Received: from foss.arm.com ([217.140.110.172]:34064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKRMqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 07:46:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFC611FB;
        Mon, 18 Nov 2019 04:46:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AD853F6C4;
        Mon, 18 Nov 2019 04:46:35 -0800 (PST)
Date:   Mon, 18 Nov 2019 12:46:33 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: Use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <20191118124632.GN43905@e119886-lin.cambridge.arm.com>
References: <1574076646-51621-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574076646-51621-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 07:30:46PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
> 
> drivers/pci/controller/dwc/pcie-kirin.c:141:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> drivers/pci/controller/dwc/pcie-kirin.c:177:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index c19617a..5b2131f 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -138,10 +138,7 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
>  		return PTR_ERR(kirin_pcie->apb_sys_clk);
> 
>  	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
> -	if (IS_ERR(kirin_pcie->pcie_aclk))
> -		return PTR_ERR(kirin_pcie->pcie_aclk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
>  }
> 
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,

Thanks for these patches. Though if you resend these next time you ought
to put them in a single patch series with a cover letter.

I'm not sure on the views of maintainers for other parts of the kernel
however for PCI this type of change has previously been rejected, see:

https://lkml.org/lkml/2019/5/31/535

I guess coccicheck isn't aware of this.

Thanks,

Andrew Murray

> --
> 2.7.4
> 

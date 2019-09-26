Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF5BEE77
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfIZJ3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 05:29:36 -0400
Received: from foss.arm.com ([217.140.110.172]:43458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfIZJ3g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 05:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6491000;
        Thu, 26 Sep 2019 02:29:36 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE2383F67D;
        Thu, 26 Sep 2019 02:29:35 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:29:34 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Subject: Re: [PATCH] PCI: mobiveil: Fix csr_read/write build issue
Message-ID: <20190926092933.GC9720@e119886-lin.cambridge.arm.com>
References: <20190925142121.56607-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925142121.56607-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 10:21:21PM +0800, Kefeng Wang wrote:
> The riscv has csr_read/write macro, see arch/riscv/include/asm/csr.h,
> the same function naming will cause build error, rename them to
> __csr_read/write to fix it.
> 
> drivers/pci/controller/pcie-mobiveil.c:238:69: error: macro "csr_read" passed 3 arguments, but takes just 1
>  static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> 
> drivers/pci/controller/pcie-mobiveil.c:253:80: error: macro "csr_write" passed 4 arguments, but takes just 2
>  static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
> 
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Minghuan Lian <Minghuan.Lian@nxp.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Fixes: bcbe0d9a8d93 ("PCI: mobiveil: Unify register accessors")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a45a6447b01d..7ba1138c3667 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -235,7 +235,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> +static u32 __csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
>  {
>  	void *addr;
>  	u32 val;
> @@ -250,7 +250,7 @@ static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
>  	return val;
>  }
>  
> -static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
> +static void __csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
>  {
>  	void *addr;
>  	int ret;
> @@ -264,12 +264,12 @@ static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
>  
>  static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
>  {
> -	return csr_read(pcie, off, 0x4);
> +	return __csr_read(pcie, off, 0x4);
>  }
>  
>  static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
>  {
> -	csr_write(pcie, val, off, 0x4);
> +	__csr_write(pcie, val, off, 0x4);
>  }

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Though I'd be just as happy if the csr_[read,write][l,] functions were renamed
to mobiveil_csr_[read,write][l,].

>  
>  static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
> -- 
> 2.20.1
> 

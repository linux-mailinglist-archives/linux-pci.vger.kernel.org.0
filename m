Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB1188970
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 16:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgCQPuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 11:50:35 -0400
Received: from foss.arm.com ([217.140.110.172]:39862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQPue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 11:50:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A67830E;
        Tue, 17 Mar 2020 08:50:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AE3F3F52E;
        Tue, 17 Mar 2020 08:50:33 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:50:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com
Subject: Re: [PATCH] PCI: mobiveil: fix different address space warnings of
 sparse
Message-ID: <20200317155015.GA30120@e121166-lin.cambridge.arm.com>
References: <20200317145125.3682-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317145125.3682-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 10:51:25PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Fix the sparse warnings below:
> 
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:44:49: warning: incorrect type in return expression (different address spaces)
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:44:49:    expected void *
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:44:49:    got void [noderef] <asn:2> *
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:48:41: warning: incorrect type in return expression (different address spaces)
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:48:41:    expected void *
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:48:41:    got void [noderef] <asn:2> *
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:106:34: warning: incorrect type in argument 1 (different address spaces)
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:106:34:    expected void [noderef] <asn:2> *addr
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:106:34:    got void *[assigned] addr
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:121:35: warning: incorrect type in argument 1 (different address spaces)
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:121:35:    expected void [noderef] <asn:2> *addr
> drivers/pci/controller/mobiveil/pcie-mobiveil.c:121:35:    got void *[assigned] addr
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index 23ab904989ea..62ecbaeb0a60 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -36,7 +36,8 @@ static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
>  	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
>  }
>  
> -static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
> +static void __iomem *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie,
> +					     u32 off)
>  {
>  	if (off < PAGED_ADDR_BNDRY) {
>  		/* For directly accessed registers, clear the pg_sel field */
> @@ -97,7 +98,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
>  
>  u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
>  {
> -	void *addr;
> +	void __iomem *addr;
>  	u32 val;
>  	int ret;
>  
> @@ -113,7 +114,7 @@ u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
>  void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
>  			       size_t size)
>  {
> -	void *addr;
> +	void __iomem *addr;
>  	int ret;
>  
>  	addr = mobiveil_pcie_comp_addr(pcie, off);
> -- 
> 2.17.1
> 

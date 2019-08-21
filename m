Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B268980D2
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHUQ72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 12:59:28 -0400
Received: from foss.arm.com ([217.140.110.172]:33672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfHUQ72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 12:59:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E70337;
        Wed, 21 Aug 2019 09:59:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0933F718;
        Wed, 21 Aug 2019 09:59:26 -0700 (PDT)
Date:   Wed, 21 Aug 2019 17:59:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, l.subrahmanya@mobiveil.co.in,
        leoyang.li@nxp.com
Subject: Re: [PATCHv7] PCI: mobiveil: Fix the CPU base address setup in
 inbound window
Message-ID: <20190821165922.GA3915@e121166-lin.cambridge.arm.com>
References: <20190713141129.32249-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713141129.32249-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 13, 2019 at 10:11:29PM +0800, Hou Zhiqiang wrote:
> The current code erroneously sets-up the CPU base address with
> parameter 'pci_addr', which is passed to initialize the PCI
> base address of the inbound window, and the upper 32-bit of the
> CPU base address of the inbound window is not initialized. This
> results in the current code only support 1:1 inbound window
> with limitation that the base address must be < 4GB.
> 
> This patch introduces a new parameter 'u64 cpu_addr' to initialize
> both lower 32-bit and upper 32-bit of the CPU base address to make
> it can support non 1:1 inbound window and fix the base address must
> be < 4GB limitation.
> 
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V7:
>  - This patch is #25 of V6 patches, rewrote the changelog.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied to pci/mobiveil for v5.4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 672e633..a45a644 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -88,6 +88,7 @@
>  #define  AMAP_CTRL_TYPE_MASK		3
>  
>  #define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
> +#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
>  #define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
>  #define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
>  #define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
> @@ -462,7 +463,7 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  }
>  
>  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> -			       u64 pci_addr, u32 type, u64 size)
> +			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
>  	u32 value;
>  	u64 size64 = ~(size - 1);
> @@ -482,7 +483,10 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
>  	csr_writel(pcie, upper_32_bits(size64),
>  		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
>  
> -	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> +	csr_writel(pcie, lower_32_bits(cpu_addr),
> +		   PAB_PEX_AMAP_AXI_WIN(win_num));
> +	csr_writel(pcie, upper_32_bits(cpu_addr),
> +		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
>  
>  	csr_writel(pcie, lower_32_bits(pci_addr),
>  		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
> @@ -624,7 +628,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>  
>  	/* memory inbound translation window */
> -	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> +	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>  
>  	/* Get the I/O and memory ranges from DT */
>  	resource_list_for_each_entry(win, &pcie->resources) {
> -- 
> 2.9.5
> 

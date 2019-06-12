Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5742C1A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440218AbfFLQXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 12:23:53 -0400
Received: from foss.arm.com ([217.140.110.172]:56684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440150AbfFLQXx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 12:23:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F33442B;
        Wed, 12 Jun 2019 09:23:51 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEDCC3F73C;
        Wed, 12 Jun 2019 09:23:49 -0700 (PDT)
Date:   Wed, 12 Jun 2019 17:23:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 18/20] PCI: mobiveil: Disable IB and OB windows set by
 bootloader
Message-ID: <20190612162347.GF15747@redmoon>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-19-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412083635.33626-19-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:37:00AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Disable all inbound and outbound windows before set up the windows
> in kernel, in case transactions match the window set by bootloader.

There must be no PCI transactions ongoing at bootloader<->OS handover.

The bootloader needs fixing and this patch should be dropped, the host
bridge driver assumes the host bridge state is disabled, it will
program the bridge apertures from scratch with no ongoing transactions,
anything deviating from this behaviour is a bootloader bug and a recipe
for disaster.

Lorenzo

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V5:
>  - No functionality change.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 8dc87c7a600e..411e9779da12 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -565,6 +565,24 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pcie, int idx)
> +{
> +	u32 val;
> +
> +	val = csr_readl(pcie, PAB_PEX_AMAP_CTRL(idx));
> +	val &= ~(1 << AMAP_CTRL_EN_SHIFT);
> +	csr_writel(pcie, val, PAB_PEX_AMAP_CTRL(idx));
> +}
> +
> +static void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pcie, int idx)
> +{
> +	u32 val;
> +
> +	val = csr_readl(pcie, PAB_AXI_AMAP_CTRL(idx));
> +	val &= ~(1 << WIN_ENABLE_SHIFT);
> +	csr_writel(pcie, val, PAB_AXI_AMAP_CTRL(idx));
> +}
> +
>  static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>  {
>  	phys_addr_t msg_addr = pcie->pcie_reg_base;
> @@ -585,6 +603,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> +	int i;
> +
> +	/* Disable all inbound/outbound windows */
> +	for (i = 0; i < pcie->apio_wins; i++)
> +		mobiveil_pcie_disable_ob_win(pcie, i);
> +	for (i = 0; i < pcie->ppio_wins; i++)
> +		mobiveil_pcie_disable_ib_win(pcie, i);
>  
>  	/* setup bus numbers */
>  	value = csr_readl(pcie, PCI_PRIMARY_BUS);
> -- 
> 2.17.1
> 

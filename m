Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7280139007
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 12:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAML1A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 06:27:00 -0500
Received: from foss.arm.com ([217.140.110.172]:38050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAML1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 06:27:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65CB213D5;
        Mon, 13 Jan 2020 03:26:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A263F6C4;
        Mon, 13 Jan 2020 03:26:58 -0800 (PST)
Date:   Mon, 13 Jan 2020 11:26:57 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 07/12] PCI: mobiveil: Make mobiveil_host_init() can be
 used to re-init host
Message-ID: <20200113112655.GM42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-8-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-8-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:46:03AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Make the mobiveil_host_init() function can be used to re-init

Perhaps reword to "Allow the mobiveil_host_init() function to be
used to ...

> host controller's PAB and GPEX CSR register block, as NXP
> integrated Mobiveil IP has to reset and then re-init the PAB
> and GPEX CSR registers upon hot-reset.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V9:
>  - No change
> 
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 19 ++++++++++++-------
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  1 +
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 3cd93df6fe6e..9bc3da036720 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -221,18 +221,23 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>  	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
>  }
>  
> -static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
>  {
>  	struct root_port *rp = &pcie->rp;
>  	struct pci_host_bridge *bridge = rp->bridge;
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
>  
> -	/* setup bus numbers */
> -	value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
> -	value &= 0xff000000;
> -	value |= 0x00ff0100;
> -	mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	pcie->ib_wins_configured = 0;
> +	pcie->ob_wins_configured = 0;

This works so long as the number of bridge->windows never reduces. I
think this assumption holds true.

Thanks,

Andrew Murray

> +
> +	if (!reinit) {
> +		/* setup bus numbers */
> +		value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
> +		value &= 0xff000000;
> +		value |= 0x00ff0100;
> +		mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	}
>  
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
> @@ -569,7 +574,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  	 * configure all inbound and outbound windows and prepare the RC for
>  	 * config access
>  	 */
> -	ret = mobiveil_host_init(pcie);
> +	ret = mobiveil_host_init(pcie, false);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize host\n");
>  		return ret;
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 95d2e7c809b8..37116c2a19fe 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -166,6 +166,7 @@ struct mobiveil_pcie {
>  };
>  
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
>  bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
>  int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
>  void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
> -- 
> 2.17.1
> 

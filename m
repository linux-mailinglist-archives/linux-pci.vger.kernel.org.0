Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595CF138FFE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 12:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMLWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 06:22:05 -0500
Received: from foss.arm.com ([217.140.110.172]:38004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgAMLWF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 06:22:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31E013D5;
        Mon, 13 Jan 2020 03:22:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0499C3F6C4;
        Mon, 13 Jan 2020 03:22:04 -0800 (PST)
Date:   Mon, 13 Jan 2020 11:22:02 +0000
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
Subject: Re: [PATCHv9 06/12] PCI: mobiveil: Add callback function for link up
 check
Message-ID: <20200113112201.GL42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-7-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-7-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:45:57AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The platforms, in which the Mobiveil GPEX is integrated,
> may have their specific mechanism to check link up status.
> This patch is to enable these platforms to implement theirs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V9:
>  - New patch splited from the #1 of V8 patches to make it easy to review.
> 
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c | 3 +++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index 2773f823c9ea..b9ed2d95641c 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -125,6 +125,9 @@ void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
>  
>  bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
>  {
> +	if (pcie->ops->link_up)
> +		return pcie->ops->link_up(pcie);
> +
>  	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
>  		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;

On the previous patch I suggested that we don't mix up the link_up logic
with the logic that decides which function to call. In this case the link_up
logic is trivial. So this is probably OK.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 18d85806a7fc..95d2e7c809b8 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -148,6 +148,10 @@ struct root_port {
>  	struct pci_host_bridge *bridge;
>  };
>  
> +struct mobiveil_pab_ops {
> +	int (*link_up)(struct mobiveil_pcie *pcie);
> +};
> +
>  struct mobiveil_pcie {
>  	struct platform_device *pdev;
>  	void __iomem *csr_axi_slave_base;	/* root port config base */
> @@ -157,6 +161,7 @@ struct mobiveil_pcie {
>  	int ppio_wins;
>  	int ob_wins_configured;		/* configured outbound windows */
>  	int ib_wins_configured;		/* configured inbound windows */
> +	const struct mobiveil_pab_ops *ops;
>  	struct root_port rp;
>  };
>  
> -- 
> 2.17.1
> 

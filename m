Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC878167D33
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 13:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBUMPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 07:15:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBUMPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 07:15:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF9630E;
        Fri, 21 Feb 2020 04:15:09 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3EB43F68F;
        Fri, 21 Feb 2020 04:15:06 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:15:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, catalin.marinas@arm.com, will.deacon@arm.com,
        Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 02/13] PCI: mobiveil: Move the host initialization
 into a function
Message-ID: <20200221121501.GA12711@e121166-lin.cambridge.arm.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:33PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Move the host initialization related operations into a new
> routine such that it can be reused by other incoming platform's
> PCIe host driver, in which the Mobiveil GPEX is integrated.
> 
> Change the subject and change log slightly.
> Change the function mobiveil_pcie_host_probe to static.
> Add back the comments that was lost in v9.

I removed the paragraph above since it is a leftover and
does not belong in the commit log.

Lorenzo

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V10:
>  - Refined the subject and change log.
>  - Changed the mobiveil_pcie_host_probe() to a static function.
>  - Added back the lost comments.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 39 +++++++++++++++-----------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index d4de560cd711..01df04ea5b48 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -873,27 +873,15 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> -static int mobiveil_pcie_probe(struct platform_device *pdev)
> +static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
> -	struct mobiveil_pcie *pcie;
> +	struct mobiveil_root_port *rp = &pcie->rp;
> +	struct pci_host_bridge *bridge = rp->bridge;
> +	struct device *dev = &pcie->pdev->dev;
>  	struct pci_bus *bus;
>  	struct pci_bus *child;
> -	struct pci_host_bridge *bridge;
> -	struct device *dev = &pdev->dev;
> -	struct mobiveil_root_port *rp;
>  	int ret;
>  
> -	/* allocate the PCIe port */
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> -	if (!bridge)
> -		return -ENOMEM;
> -
> -	pcie = pci_host_bridge_priv(bridge);
> -	rp = &pcie->rp;
> -	rp->bridge = bridge;
> -
> -	pcie->pdev = pdev;
> -
>  	ret = mobiveil_pcie_parse_dt(pcie);
>  	if (ret) {
>  		dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
> @@ -956,6 +944,25 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int mobiveil_pcie_probe(struct platform_device *pdev)
> +{
> +	struct mobiveil_pcie *pcie;
> +	struct pci_host_bridge *bridge;
> +	struct device *dev = &pdev->dev;
> +
> +	/* allocate the PCIe port */
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	pcie->rp.bridge = bridge;
> +
> +	pcie->pdev = pdev;
> +
> +	return mobiveil_pcie_host_probe(pcie);
> +}
> +
>  static const struct of_device_id mobiveil_pcie_of_match[] = {
>  	{.compatible = "mbvl,gpex40-pcie",},
>  	{},
> -- 
> 2.17.1
> 

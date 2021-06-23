Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93F33B1B7F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhFWNsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 09:48:47 -0400
Received: from foss.arm.com ([217.140.110.172]:35622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhFWNsr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 09:48:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A04ED1;
        Wed, 23 Jun 2021 06:46:29 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90BBA3F718;
        Wed, 23 Jun 2021 06:46:28 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:46:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/7] PCI: imx6: Move i.MX8MQ controller instance check to
 correct case statement
Message-ID: <20210623134623.GA14289@lpieralisi>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510141509.929120-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 04:15:03PM +0200, Lucas Stach wrote:
> While the i.MX8MQ case falls through to the i.MX7D case, it's quite confusing
> to have the i.MX8MQ specific controller instance check in that statement.
> Move it to the 8MQ case.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hi Lucas,

it looks like some of the patches in this series need a respin,
therefore I will mark it as "Changes Requested" unless there
are some patches I can cherry pick - please let me know your plan.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0cf1333c0440..46b5f070939e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1060,11 +1060,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		if (IS_ERR(imx6_pcie->pcie_aux))
>  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
>  					     "pcie_aux clock source missing or invalid\n");
> -		fallthrough;
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
>  
> +		fallthrough;
> +	case IMX7D:
>  		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
>  									    "pciephy");
>  		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> -- 
> 2.29.2
> 

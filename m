Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3143EB5D9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhHMM4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 08:56:14 -0400
Received: from foss.arm.com ([217.140.110.172]:53358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239978AbhHMM4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 08:56:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 225A51042;
        Fri, 13 Aug 2021 05:55:47 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07B313F718;
        Fri, 13 Aug 2021 05:55:44 -0700 (PDT)
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in
 probe
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20210813113338.GA30697@kili>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
Date:   Fri, 13 Aug 2021 13:55:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813113338.GA30697@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-13 12:33, Dan Carpenter wrote:
> If devm_regulator_get_optional() returns an error pointer, then we
> should return it to the user.  The current code makes an exception
> for -ENODEV that will result in an error pointer dereference on the
> next line when it calls regulator_enable().  Remove the exception.

Doesn't this break the apparent intent of the regulator being optional, 
though?

Robin.

> Fixes: e1229e884e19 ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 20cef2e06f66..2d0ffd3c4e16 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -225,9 +225,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	/* DON'T MOVE ME: must be enable before PHY init */
>   	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>   	if (IS_ERR(rockchip->vpcie3v3))
> -		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> -			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> -					"failed to get vpcie3v3 regulator\n");
> +		return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> +				     "failed to get vpcie3v3 regulator\n");
>   
>   	ret = regulator_enable(rockchip->vpcie3v3);
>   	if (ret) {
> 

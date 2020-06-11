Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3AC1F6298
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFKHfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 03:35:11 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:56288 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgFKHfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 03:35:11 -0400
Received: from [192.168.1.5] (212-5-158-114.ip.btc-net.bg [212.5.158.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 6254ECFF7;
        Thu, 11 Jun 2020 10:35:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1591860906; bh=aiqBHTY8ZPxp5JouTm8Ngv3wTrmfhGm7s2gTLjEFSx8=;
        h=Subject:To:Cc:From:Date:From;
        b=dZj3xWSXccc198xS9g5MVVlz1PdQpRk3Q7znQWDLD2LBPDmW05qC9AtYlHZvUy86h
         wxBz2JQ2yaxKs2+S0Pou3mc+qas1Me/UpFjqOCH0HD6AXGjlsMjk6o0dPTV5jY2d18
         xRuJb3y0aWlEEhnZymkqSAcML5ieHYIN2rL+GevLdzPk05FnY2rQj2ieLZPbdb2IXd
         jrWyL226HQsBGlOM61lWIN4n+zjbGnnX0cNoZpQaox1oeSq8fGQHbXY8045XKJV9f5
         uMMvI64zw/DWmUgWnDz0GGGsmYUO9l2xg+BvAuou5ehuKFE5y5rMowe6eSOSGqqweZ
         WA0iZ/DXGDHKA==
Subject: Re: [PATCH v6 11/12] PCI: qcom: Add Force GEN1 support
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
 <20200610160655.27799-12-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <a2e85e3e-0b4e-5a9b-4b35-b37de6d64bd8@mm-sol.com>
Date:   Thu, 11 Jun 2020 10:34:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610160655.27799-12-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

Sorry that I didn't make this comment earlier.

The subject and description are misleading. The patch itself is not
forcing anything (the DT is filling the gen to 1), so please fix that.

On 6/10/20 7:06 PM, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add Force GEN1 support needed in some ipq8064 board that needs to limit
> some PCIe line to gen1 for some hardware limitation. This is set by the
> max-link-speed binding and needed by some soc based on ipq8064. (for
> example Netgear R7800 router)
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 259b627bf890..c40921589122 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define PCIE20_PARF_SYS_CTRL			0x00
> @@ -99,6 +100,8 @@
>  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
>  #define SLV_ADDR_SPACE_SZ			0x10000000
>  
> +#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
> +
>  #define DEVICE_TYPE_RC				0x4
>  
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> @@ -195,6 +198,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_ops *ops;
> +	int gen;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -395,6 +399,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	/* wait for clock acquisition */
>  	usleep_range(1000, 1500);
>  
> +	if (pcie->gen == 1) {
> +		val = readl(pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
> +		val |= PCI_EXP_LNKSTA_CLS_2_5GB;
> +		writel(val, pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
> +	}
>  
>  	/* Set the Max TLP size to 2K, instead of using default of 4K */
>  	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
> @@ -1397,6 +1406,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> +	if (pcie->gen < 0)
> +		pcie->gen = 2;
> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
>  	pcie->parf = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pcie->parf)) {
> 

-- 
regards,
Stan

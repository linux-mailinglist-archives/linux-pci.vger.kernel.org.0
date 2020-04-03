Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADC19D2E7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbgDCJBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:01:08 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:49533 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgDCJBI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:01:08 -0400
Received: from [192.168.1.4] (212-5-158-241.ip.btc-net.bg [212.5.158.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id A4673CFB0;
        Fri,  3 Apr 2020 12:01:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1585904465; bh=XlPPAmhstG/r8uQst4kUmOIq26pF12Vho8l1S5UqRUI=;
        h=Subject:To:Cc:From:Date:From;
        b=PT1YeIlPmjcT/MMFYSXxhK6MEa0u/rHW/38RL00YVsdt+xXtK90TAdpVTunjfB3YG
         U+iQan+H/8+Ug8PuXKx5fLRu57nZtPhQ6d5RAxzjNksxihD0OZXUsypaMqHRboWQe2
         V/w8qCSg4sTLJsEOLLgoGg2lrnot5ycLJNJiOOW8npQyBEYYdyzy6npThl0euzP6HK
         ccmaJ1mPZb1KzhiARYV/JdV8pXjPw/A8M4uGkBIbMxYeqj5/Wz1I4h2e8cxRuJvrkh
         uB0Ed4OW5w24xPwCaMEwFaHOu4UY+6yATvMpHzgMfVI8mOpAF5QFjgezvwmcFrQxXg
         g+IQ9J7R5oj0A==
Subject: Re: [PATCH v2 10/10] PCIe: qcom: add Force GEN1 support
To:     Ansuel Smith <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-11-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <8e0ada17-c858-59d2-8d5c-5129e7625f33@mm-sol.com>
Date:   Fri, 3 Apr 2020 12:01:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402121148.1767-11-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On 4/2/20 3:11 PM, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add Force GEN1 support needed in some ipq806x board
> that needs to limit some pcie line to gen1 for some
> hardware limitation.
> This is set by the max-link-speed dts entry and needed
> by some soc based on ipq806x. (for example Netgear R7800
> router)
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8047ac7dc8c7..2212e9498b91 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> +#include "../../pci.h"

This looks suspiciously (even ugly), but I saw that the other users of
of_pci_get_max_link_speed is doing the same.

Bjorn H. : do you know why the prototype is there? Perhaps it must be in
linux/of_pci.h.

>  #include "pcie-designware.h"
>  
>  #define PCIE20_PARF_SYS_CTRL			0x00
> @@ -99,6 +100,8 @@
>  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
>  #define SLV_ADDR_SPACE_SZ			0x10000000
>  
> +#define PCIE20_LNK_CONTROL2_LINK_STATUS2        0xA0

tabs instead of spaces and hex numbers should be lower-case

> +
>  #define DEVICE_TYPE_RC				0x4
>  
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> @@ -199,6 +202,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_ops *ops;
> +	bool force_gen1;

could you rename this and make it int:

	int gen;

>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -441,6 +445,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  
>  	/* wait for clock acquisition */
>  	usleep_range(1000, 1500);

add a blank line here

> +	if (pcie->force_gen1) {

	if (pcie->gen == 1) {

> +		writel_relaxed((readl_relaxed(
> +		  pcie->pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2) | 1),
> +		  pcie->pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
> +	}

why you are using writel/readl_relaxed ?

Also could you split the line to two:

	val = read()
	write(val | 1, address)

>  
>  
>  	/* Set the Max TLP size to 2K, instead of using default of 4K */
> @@ -1440,6 +1449,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	ret = of_pci_get_max_link_speed(pdev->dev.of_node);> +	if (ret == 1)
> +		pcie->force_gen1 = true;

drop this, handle ret < 0 and default to generation 2

	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
	if (pcie->gen < 0)
		pcie->gen = 2;

> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
>  	pcie->parf = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pcie->parf)) {
> 

-- 
regards,
Stan

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8514218EFA0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 07:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCWGGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 02:06:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCWGGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2020 02:06:35 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1jGGEC-0008Et-Tp; Mon, 23 Mar 2020 07:06:24 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1jGGE8-0002sT-HS; Mon, 23 Mar 2020 07:06:20 +0100
Date:   Mon, 23 Mar 2020 07:06:20 +0100
From:   Philipp Zabel <pza@pengutronix.de>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] pcie: qcom: add missing reset for ipq806x
Message-ID: <20200323060620.GA1617@pengutronix.de>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-5-ansuelsmth@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:00:25 up 32 days, 13:30, 45 users,  load average: 1.03, 0.51,
 0.25
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On Fri, Mar 20, 2020 at 07:34:47PM +0100, Ansuel Smith wrote:
> Add missing ext reset used by ipq806x soc in
> pcie qcom driver
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 596731b54728..ecc22fd27ea6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -95,6 +95,7 @@ struct qcom_pcie_resources_2_1_0 {
>  	struct reset_control *ahb_reset;
>  	struct reset_control *por_reset;
>  	struct reset_control *phy_reset;
> +	struct reset_control *ext_reset;
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
>  };
>  
> @@ -272,6 +273,10 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->por_reset))
>  		return PTR_ERR(res->por_reset);
>  
> +	res->ext_reset = devm_reset_control_get(dev, "ext");

Please use devm_reset_control_get_exclusive() instead.

> +	if (IS_ERR(res->ext_reset))
> +		return PTR_ERR(res->ext_reset);
> +
>  	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
>  	return PTR_ERR_OR_ZERO(res->phy_reset);
>  }
> @@ -285,6 +290,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
>  	reset_control_assert(res->axi_reset);
>  	reset_control_assert(res->ahb_reset);
>  	reset_control_assert(res->por_reset);
> +	reset_control_assert(res->ext_reset);
>  	reset_control_assert(res->phy_reset);
>  	clk_disable_unprepare(res->iface_clk);
>  	clk_disable_unprepare(res->core_clk);
> @@ -301,18 +307,18 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	u32 val;
>  	int ret;
>  
> +	ret = reset_control_assert(res->ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert ahb reset\n");
> +		return ret;
> +	}
> +
>  	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot enable regulators\n");
>  		return ret;
>  	}
>  
> -	ret = reset_control_assert(res->ahb_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot assert ahb reset\n");
> -		goto err_assert_ahb;
> -	}
> -

This change is not described in the commit message.

regards
Philipp

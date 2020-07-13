Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1F21CF22
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 08:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgGMGEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 02:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgGMGEa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 02:04:30 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D0C2075D;
        Mon, 13 Jul 2020 06:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594620269;
        bh=2atuB8aZhPPsAa97doguEGb426FUovZ+elviGsOi3o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0V+eJwrv/h7RwYhJn6GRcyKZbOCAnsumurOHUhd0l/9fe7xXuhqJ6OEpzfJ5qqNq
         pbbxcm+ziRHHDSiL0QI7ZNWVJDz1rp1+1awKBVivm7yO6LAHyyr7pmeY7muNaaS59y
         IIV66d04UPDSuZ3WuGCRBZYh8oili9lnGrE/9QVQ=
Date:   Mon, 13 Jul 2020 11:34:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, mturquette@baylibre.com,
        sboyd@kernel.org, svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, mgautam@codeaurora.org,
        smuthayy@codeaurora.org, varada@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: Re: [PATCH 6/9] phy: qcom-qmp: Add compatible for ipq8074 pcie gen3
 qmp phy
Message-ID: <20200713060425.GC34333@vkoul-mobl>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
 <1593940680-2363-7-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593940680-2363-7-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05-07-20, 14:47, Sivaprakash Murugesan wrote:
> ipq8074 has two pcie ports, one gen2 and one gen3 ports. with phy
> support already available for gen2 pcie ports add support for pcie gen3
> port phy.
> 
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h | 137 ++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.c       | 172 +++++++++++++++++++++++++++++-
>  2 files changed, 307 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h b/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> new file mode 100644
> index 000000000000..bb567673d9b5
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> @@ -0,0 +1,137 @@
> +/* SPDX-License-Identifier: GPL-2.0*

Trailing * at the end, it would make sense to split the spdx and
copyright parts to two single lines

> @@ -2550,8 +2707,16 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  
>  	init.ops = &clk_fixed_rate_ops;
>  
> -	/* controllers using QMP phys use 125MHz pipe clock interface */
> -	fixed->fixed_rate = 125000000;
> +	/*
> +	 * controllers using QMP phys use 125MHz pipe clock interface unless
> +	 * other frequency is specified in dts
> +	 */
> +	ret = of_property_read_u32(np, "clock-output-rate",
> +				   (u32 *)&fixed->fixed_rate);

is this cast required?

> +	if (ret)
> +		fixed->fixed_rate = 125000000;
> +
> +	dev_info(qmp->dev, "fixed freq %lu\n", fixed->fixed_rate);

debug?

-- 
~Vinod

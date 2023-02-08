Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1A68F3B7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBHQre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 11:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjBHQrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 11:47:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBEE3B0F8;
        Wed,  8 Feb 2023 08:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC4861739;
        Wed,  8 Feb 2023 16:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D0DC433EF;
        Wed,  8 Feb 2023 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874851;
        bh=R1EhtcU+fclNZFQL8u7Brp4bwbZEsKYX6uSdRHsHv2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6bWjigrlotYRUIqlBf8CTuKUZCDW3AGSsDqyFp0kwvWC8JQRu3AlgZpFaAjcANgY
         +7xrcdOVda0QADEWQmcdrstkLl3RUmnw6HTlO/+3VXa2n86Tff4UWmGuw4cjysRWyc
         L4HiEDCK5VRqocjXbIEJpIdhYzGrErw31zK2EbkEbZKesAuCUQIFPObo61tkkXdh6A
         7CzGXoDejf9KxH8Ze6wqa5LGVZNhff8HSn6o8W6M2h8xc33zdAiSy9+bFHT+qA6xbf
         3z0LubwWlERJ8GYylBIAwRsvEljLm+KYWoCp3DDBq/ucxQtXLg9u6LUAOxypVkXzRS
         JJrUpwUXaJ3IQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPnc7-0005yV-DZ; Wed, 08 Feb 2023 17:48:08 +0100
Date:   Wed, 8 Feb 2023 17:48:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v8 08/11] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y+PSR6DKUeoreGJL@hovoldconsulting.com>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
 <20230206212619.3218741-9-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206212619.3218741-9-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 11:26:16PM +0200, Abel Vesa wrote:
> Add the SM8550 both g4 and g3 configurations. In addition, there is a
> new "lane shared" table that needs to be configured for g4, along with
> the No-CSR list of resets. The no-CSR allows resetting the PHY without
> actually dropping the PHY configuration. The no-CSR needs to be
> deasserted only after the PHY has been configured and the PLL has
> stabilized.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

> @@ -2370,6 +2690,12 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	if (ret)
>  		return ret;
>  
> +	ret = reset_control_deassert(qmp->nocsr_reset);
> +	if (ret) {
> +		dev_err(qmp->dev, "no-csr reset deassert failed\n");
> +		goto err_disable_pipe_clk;
> +	}
> +
>  	/* Pull PHY out of reset state */
>  	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>  
> @@ -2503,6 +2829,13 @@ static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to get resets\n");
>  
> +	if (cfg->has_nocsr_reset) {
> +		qmp->nocsr_reset = devm_reset_control_get_exclusive(dev, "phy_nocsr");
> +		if (IS_ERR(qmp->nocsr_reset))
> +			return dev_err_probe(dev, PTR_ERR(qmp->nocsr_reset),
> +						"failed to get no-CSR reset\n");

Nit: You're still using uppercase CSR here and lowercase elsewhere.

> +	}
> +
>  	return 0;
>  }

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

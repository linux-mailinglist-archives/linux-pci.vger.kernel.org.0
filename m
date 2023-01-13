Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6D669BE0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 16:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjAMPX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 10:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAMPXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 10:23:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD781411;
        Fri, 13 Jan 2023 07:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E60A5620D1;
        Fri, 13 Jan 2023 15:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13542C433D2;
        Fri, 13 Jan 2023 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673622943;
        bh=/i225Z+ElpatprCFkJPY3vtqP6zLi6PlpzzoTbD8vGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2CAlnM+iUK9asyhy0Gf5t68f1LGrghaMnoz/OAA1VMTrsqAdjN5VRrJzesZfUWGh
         SxGRfEQsiJOrcIPn2iOu+lzaLy9UacyWY17hoPyABR//K9oSiFo7doYMOB5hRA60HY
         YjajUD72zljgv1/R+NqcAgWFdOEGl57GpVsPW3imHpicGHJgJj0w/QeTtlj8amzW9D
         aaD79kcbjBogov+62Ya9jxEA4xr7VOix4+XhJzzRyN3bGSWBRaRy43kJUkEv9aTJq0
         3gTTPgy+LJ59O2CbQlp8fxujyQz6S5Z10Bn56S/xnkGEEKvnKtvfGLVeY3ZC1+9EUL
         Tcyizu/CByvsQ==
Date:   Fri, 13 Jan 2023 16:15:34 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 04/21] PCI: tegra194: Handle errors in BPMP response
Message-ID: <Y8F1ljVyVST+aSu4@lpieralisi>
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013183854.21087-5-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 14, 2022 at 12:08:37AM +0530, Vidya Sagar wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * None
> 
> V2:
> * None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 685aee378c93..ae7e0d8f693b 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1260,6 +1260,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
>  	struct mrq_uphy_response resp;
>  	struct tegra_bpmp_message msg;
>  	struct mrq_uphy_request req;
> +	int err;
>  
>  	/*
>  	 * Controller-5 doesn't need to have its state set by BPMP-FW in
> @@ -1282,7 +1283,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
>  	msg.rx.data = &resp;
>  	msg.rx.size = sizeof(resp);
>  
> -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
> @@ -1291,6 +1298,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>  	struct mrq_uphy_response resp;
>  	struct tegra_bpmp_message msg;
>  	struct mrq_uphy_request req;
> +	int err;
>  
>  	memset(&req, 0, sizeof(req));
>  	memset(&resp, 0, sizeof(resp));
> @@ -1310,7 +1318,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>  	msg.rx.data = &resp;
>  	msg.rx.size = sizeof(resp);
>  
> -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;

I wonder whether you can embed the return value check within
the function itself.

Lorenzo

> +
> +	return 0;
>  }
>  
>  static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> -- 
> 2.17.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

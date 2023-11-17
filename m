Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443687EEE7C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 10:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjKQJ2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 04:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjKQJ2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 04:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EBD50;
        Fri, 17 Nov 2023 01:28:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74961C433C9;
        Fri, 17 Nov 2023 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700213312;
        bh=ZX0N0YRfurTksQtzQygd2NK0hlDqDUR1ikwue/w14p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iU4VqXu6H3CvY0u3kBRaUx6Jt6Yb5b+SV4bP0ImTboSXeF8mDRqpMtH+4eA8G+2OY
         qaoSIiXrHRMpJaYHqySGvXQPgIWzY/OZAVUy6cpDBKSbhL+/atEmyhzYdBh2zK2dk8
         ZpK88VJQCCljdhKPTkvy87/1TGiBXWQkbV/ziDm5cTX9Aq4G5Ec/De5tSwjeovVj5Z
         dCOxbWRLioaizrXYkHERkA5h5nQjqrDUqJcvV/AjHYMfXsOqeaUQ0u9Cqs0hkFIjXG
         BYLJc62xYU1BB4eRULE4uVLKCELNr2ufOxfcNEEtbAPmcSP2J6NzragR2DuGu26jV4
         gg5QlLL/OhBVQ==
Date:   Fri, 17 Nov 2023 14:58:25 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 6/6] PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast
 warning
Message-ID: <20231117092825.GH250770@thinkpad>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114055456.2231990-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:54:56PM +0900, Yoshihiro Shimoda wrote:
> When building with clang 18 with adding -Wvoid-pointer-to-enum-cast,
> the following error happens:
> 
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: error: cast to smaller integer type 'enum dw_pcie_device_mode' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>   439 |         rcar->mode = (enum dw_pcie_device_mode)of_device_get_match_data(&rcar->pdev->dev);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To fix this issue, use uintptr_t instead.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 70492f562e48..a1eb10e878f1 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -436,7 +436,7 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  /* Common */
>  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	rcar->mode = (enum dw_pcie_device_mode)of_device_get_match_data(&rcar->pdev->dev);
> +	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
>  
>  	switch (rcar->mode) {
>  	case DW_PCIE_RC_TYPE:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

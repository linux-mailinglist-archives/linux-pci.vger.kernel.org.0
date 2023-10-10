Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890027BF9C0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJJLax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJJLaw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 07:30:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620EDA9;
        Tue, 10 Oct 2023 04:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCA1C433C8;
        Tue, 10 Oct 2023 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696937451;
        bh=vpxVsYgigz79QkMnts0jLZSQQUrAIIbXt0b40apxg5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyDmm3WK7AW9IADS89YU3HzE64thlFQHbHwSz21z3rKFRSvZZlymQNVx5AjEFvvKj
         vM+wbZqFgF5wh0tvJBo3ia+Hy0yPUbk9wc9YHUiKiBxBESo3NGwfwxFwg1UkZWlqIh
         rL4DdI7mgNqBPDVn2ogba3BE858/7EDy+M1AxGOIzURWI7Kl3Y0VuBmrS0OOBRGo8M
         i3AftHKKJ1seKU2Iwyq62B95+yUROuxiGYVCP7hxVfhUSTG6AxF0b8or9vcaff/wPY
         +kUaJ48RMkxfMCpBtduhM2heOGzHKXkZl6htUB7w9NCuz4zo6ah/Rxy+bZtAzPehpn
         J8d0lB2LnKdVA==
Date:   Tue, 10 Oct 2023 17:00:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v21 12/16] PCI: add T_PVPERL macro
Message-ID: <20231010113036.GF4884@thinkpad>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-13-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922065331.3806925-13-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 03:53:27PM +0900, Yoshihiro Shimoda wrote:
> According to the PCI Express Card Electromechanical Specification,
> Power stable to PERST# inactive interval is 100 ms as minimum.
> So, add the macro to use PCIe controller drivers.
> 

"Add a macro so that the PCIe controller drivers can make use of it."

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/pci.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 39a8932dc340..5ecbcf041179 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,9 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +/* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
> +#define PCIE_T_PVPERL_MS		100
> +
>  /*
>   * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
>   * Recommends 1ms to 10ms timeout to check L2 ready.
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

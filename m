Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C447EF083
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbjKQKcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345901AbjKQKci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:32:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A911F;
        Fri, 17 Nov 2023 02:32:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91603C433C7;
        Fri, 17 Nov 2023 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700217155;
        bh=P6HQZRDDmwp9Crnk93EhFdo2cPR9sDDh+Congk5Ouuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyPo0qh4XK7WbIugX2QTAFDdhDPTrz0IqKR7j1oKpwZj/bdj4KOBsEHyllUQPKWnx
         TXlsqzMUkQEaVR0sh8D7k02T6uirj1bcY2Z1+8Cc+EAuNfWZKVoi5kvw+/dxiJuaAh
         5h9QLiJP+CpSicZezXlGfzYYgsLeqf+/Eha60VVgLPPOpN5l7axbdocGG/yg+DvgsI
         km8UD/hHi5+4IfF0/gLNEV5UaXxXnc96/8xwXgyf7Hayfa4D14hh1zEzbYpY2dfG+M
         pMmnP4p0aaYX7FERpqsfhHZ2N2R/uOpReT3b+6kXxXGMXjJoJ/LK7dcpinuTFbAb26
         2lk8+rqxm/lTQ==
Date:   Fri, 17 Nov 2023 16:02:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: qcom: Clean up ASPM comment
Message-ID: <20231117103227.GM250770@thinkpad>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-5-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114135553.32301-5-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:55:51PM +0100, Johan Hovold wrote:
> Break up the newly added ASPM comment so that it fits within the soft 80
> character limit and becomes more readable.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I think we discussed (80column soft limit for comments) in the past, but I don't
think breaking here makes the comment more readable.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 21523115f6a4..a6f08acff3d4 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -969,7 +969,10 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
>  {
> -	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
> +	/*
> +	 * Downstream devices need to be in D0 state before enabling PCI PM
> +	 * substates.
> +	 */
>  	pci_set_power_state(pdev, PCI_D0);
>  	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C94F94CE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiDHL6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiDHL6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 07:58:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFCA7DE39;
        Fri,  8 Apr 2022 04:56:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA6411FB;
        Fri,  8 Apr 2022 04:56:41 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93CA43F5A1;
        Fri,  8 Apr 2022 04:56:39 -0700 (PDT)
Date:   Fri, 8 Apr 2022 12:56:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Remove unnecessary MSI enable reg save
 and restore
Message-ID: <YlAi9/OehFyQx5jy@lpieralisi>
References: <20211226074910.2722-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226074910.2722-1-jszhang@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Vidya]

On Sun, Dec 26, 2021 at 03:49:10PM +0800, Jisheng Zhang wrote:
> The integrated MSI Receiver enable register is always initialized in
> dw_pcie_setup_rc() which is also called in resume code path, so we
> don't need to save/restore the enable register during suspend/resume.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 ---------
>  1 file changed, 9 deletions(-)

Need an ACK from Nvidia folks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 904976913081..678898985319 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -186,8 +186,6 @@
>  #define N_FTS_VAL					52
>  #define FTS_VAL						52
>  
> -#define PORT_LOGIC_MSI_CTRL_INT_0_EN		0x828
> -
>  #define GEN3_EQ_CONTROL_OFF			0x8a8
>  #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT	8
>  #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
> @@ -2189,9 +2187,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>  	if (!pcie->link_state)
>  		return 0;
>  
> -	/* Save MSI interrupt vector */
> -	pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
> -					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
>  	tegra_pcie_downstream_dev_to_D0(pcie);
>  	tegra_pcie_dw_pme_turnoff(pcie);
>  	tegra_pcie_unconfig_controller(pcie);
> @@ -2223,10 +2218,6 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>  	if (ret < 0)
>  		goto fail_host_init;
>  
> -	/* Restore MSI interrupt vector */
> -	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
> -			   pcie->msi_ctrl_int);
> -
>  	return 0;
>  
>  fail_host_init:
> -- 
> 2.34.1
> 

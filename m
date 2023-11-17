Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6A57EF0A0
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjKQKf1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQKf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:35:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC34418B;
        Fri, 17 Nov 2023 02:35:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3A5C433C9;
        Fri, 17 Nov 2023 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700217322;
        bh=DLM6836wYt4uvikX01TUYZVBmM4WKBU/bmWufq2YISA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0PKcw7PWObtfG1yWocKN58tAziCxedm3mlHLGCDinBXNJhPPNyYggXYv0/q6SHH1
         5cmhS2FbHPjcR2aBXf/Q5e6AUVhCrgSVsMWFLHgY6vYGm3NbHk4x7Ey/EpFHr2bmB3
         WOnOL1EP+haLVmzDj7kooCKdNuXNe+VUdhsebZ5/4zCfXbNr6x2/+R6ef384I2sYLj
         L/EmaHnoMev3x37cc3Kak1AfLRTp1K3tTIiS0EyZpZyzTmzRebuHUwVzVP5C3GHvX5
         bC/sJEK/MlN7igw5tJw01ANQvWlX1MfS2GTbvb6l7W4+Kw5S9mNJwQW9ez+BDRzKDs
         Psw3T/GQdZ5Sg==
Date:   Fri, 17 Nov 2023 16:05:14 +0530
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
Subject: Re: [PATCH 5/6] PCI/ASPM: Clean up disable link state parameter
Message-ID: <20231117103514.GN250770@thinkpad>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114135553.32301-6-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:55:52PM +0100, Johan Hovold wrote:
> Replace the current 'sem' parameter to the __pci_disable_link_state()
> helper with a more descriptive 'locked' parameter, which indicates
> whether a pci_bus_sem read lock is already held.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

>  drivers/pci/pcie/aspm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 8cf8cc2d6bba..19b7256d2dc9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1041,7 +1041,7 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
>  	return bridge->link_state;
>  }
>  
> -static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
> +static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked)
>  {
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> @@ -1060,7 +1060,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  		return -EPERM;
>  	}
>  
> -	if (sem)
> +	if (!locked)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	if (state & PCIE_LINK_STATE_L0S)
> @@ -1082,7 +1082,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  		link->clkpm_disable = 1;
>  	pcie_set_clkpm(link, policy_to_clkpm_state(link));
>  	mutex_unlock(&aspm_lock);
> -	if (sem)
> +	if (!locked)
>  		up_read(&pci_bus_sem);
>  
>  	return 0;
> @@ -1090,7 +1090,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  {
> -	return __pci_disable_link_state(pdev, state, false);
> +	return __pci_disable_link_state(pdev, state, true);
>  }
>  EXPORT_SYMBOL(pci_disable_link_state_locked);
>  
> @@ -1105,7 +1105,7 @@ EXPORT_SYMBOL(pci_disable_link_state_locked);
>   */
>  int pci_disable_link_state(struct pci_dev *pdev, int state)
>  {
> -	return __pci_disable_link_state(pdev, state, true);
> +	return __pci_disable_link_state(pdev, state, false);
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

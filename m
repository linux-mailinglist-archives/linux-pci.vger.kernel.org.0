Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507AE7EF04D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjKQK2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKQK2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:28:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634BD11D;
        Fri, 17 Nov 2023 02:28:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AD4C433C8;
        Fri, 17 Nov 2023 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700216888;
        bh=DlGPovd5Ji3X3LmJ8EC4SZ9ZhjACfDlTqlNOcokqiWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7yEe6hI4JR1hQuXudAl3ONSROyJUeJkX0BwAXQhpApZo2PbXQM0S/fX8D0g0LFyZ
         8JCWNdVCCo4nyJZq1e3dmgC24zgfC/fhtC3FrIkof1TMWI0S2PeB0x69fpJ/jXTRN6
         VYc3IbVyaZYKhif4nJBuAqSbdr3XWU/p8zb/Pgm8a0pap5nGcmexubht0b3tw7Vtqk
         J1cq2zgTyEmVsU9Se6x0jhy7I3SSMB0RrhvhGCqzjC20LYJp8xuib/81JoFkQbhdUR
         xe4kO9mrFE3htgtJuqeBiQ9Iu+N5z9Uyb4aDrRgqgq4FMQZy41o1U3nFyEywW4TX+n
         KVERVM9r8vOPw==
Date:   Fri, 17 Nov 2023 15:58:00 +0530
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
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 1/6] PCI/ASPM: Add locked helper for enabling link state
Message-ID: <20231117102800.GJ250770@thinkpad>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114135553.32301-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:55:48PM +0100, Johan Hovold wrote:
> Add a helper for enabling link states that can be used in contexts where
> a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> 
> This helper will be used to fix a couple of potential deadlocks where
> the current helper is called with the lock already held, hence the CC
> stable tag.
> 
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> Cc: stable@vger.kernel.org	# 6.3
> Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

With the Kdoc comment fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++++++++----------
>  include/linux/pci.h     |  3 +++
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 50b04ae5c394..8cf8cc2d6bba 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1109,17 +1109,7 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> -/**
> - * pci_enable_link_state - Clear and set the default device link state so that
> - * the link may be allowed to enter the specified states. Note that if the
> - * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> - * touch the LNKCTL register. Also note that this does not enable states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> - *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> - */
> -int pci_enable_link_state(struct pci_dev *pdev, int state)
> +static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  {
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> @@ -1136,7 +1126,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  		return -EPERM;
>  	}
>  
> -	down_read(&pci_bus_sem);
> +	if (!locked)
> +		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_default = 0;
>  	if (state & PCIE_LINK_STATE_L0S)
> @@ -1157,12 +1148,48 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
>  	pcie_set_clkpm(link, policy_to_clkpm_state(link));
>  	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> +	if (!locked)
> +		up_read(&pci_bus_sem);
>  
>  	return 0;
>  }
> +
> +/**
> + * pci_enable_link_state - Clear and set the default device link state so that
> + * the link may be allowed to enter the specified states. Note that if the
> + * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> + * touch the LNKCTL register. Also note that this does not enable states
> + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + */
> +int pci_enable_link_state(struct pci_dev *pdev, int state)
> +{
> +	return __pci_enable_link_state(pdev, state, false);
> +}
>  EXPORT_SYMBOL(pci_enable_link_state);
>  
> +/**
> + * pci_enable_link_state - Clear and set the default device link state so that
> + * the link may be allowed to enter the specified states. Note that if the
> + * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> + * touch the LNKCTL register. Also note that this does not enable states
> + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + *
> + * Context: Caller holds pci_bus_sem read lock.
> + */
> +int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
> +{
> +	lockdep_assert_held_read(&pci_bus_sem);
> +
> +	return __pci_enable_link_state(pdev, state, true);
> +}
> +EXPORT_SYMBOL(pci_enable_link_state_locked);
> +
>  static int pcie_aspm_set_policy(const char *val,
>  				const struct kernel_param *kp)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..dea043bc1e38 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1829,6 +1829,7 @@ extern bool pcie_ports_native;
>  int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
> +int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1839,6 +1840,8 @@ static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
> +static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
> +{ return 0; }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

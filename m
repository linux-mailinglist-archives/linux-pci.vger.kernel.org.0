Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976ED5A23FD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbiHZJQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiHZJQr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 05:16:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6053CC88A8;
        Fri, 26 Aug 2022 02:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DBD77CE2E55;
        Fri, 26 Aug 2022 09:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87F1C433C1;
        Fri, 26 Aug 2022 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661505402;
        bh=X2+MwXb5hmUbzFe1/y+LSxmPvQZ8LKGLND0rLtgtVwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3C1YGSStrLqrAm6uKx5pURvLzadBJoT+z5xW0Dj1QwrTcMV/kyBxnHCSddsbuR3S
         EyTVN1f9NH2SkPrkMjjk37nSa5m0jt8V/0Aq6Qz8PNJTrm5gEUM+orj+ge05ccBofk
         7no+ddE0NfIhI7rJir4ftm9FDrz18sm4aldx2d7CK9ivr8HIscHSalK0/WRQql27sm
         JZYAztEjAOd7Ja1iJ3l/wvru8X1PSoH50hgtoxkS3m907XN5dc60K36wIbiPQPktM6
         RX30zvQZqg1bsmA8dAPqegiYpmkiBUbQ4yf+SEOYZFzchyPQm48aGaXIvotyN2BwBo
         KjkXzJKxnpY5w==
Date:   Fri, 26 Aug 2022 11:16:33 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/3] PCI/ASPM: Add pci_enable_default_link_state()
Message-ID: <YwiPcbXWKPegwaZt@lpieralisi>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
 <20220301041943.2935892-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301041943.2935892-2-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 08:19:41PM -0800, David E. Box wrote:
> From: Michael Bottini <michael.a.bottini@linux.intel.com>
> 
> Add pci_enable_default_link_state() to allow devices to change the default
> BIOS configured states. Clears the BIOS default settings then sets the new
> states and reconfigures the link under the semaphore. Also add
> PCIE_LINK_STATE_ALL macro for convenience for callers that want to enable
> all link states.
> 
> Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  V6
>   - No change
>  V5
>   - Rename to pci_enable_default_link_state and model after
>     pci_disable_link_state() as suggested by Bjorn.
>   - Add helper PCIE_LINK_STATE_ALL which sets bits for all links states and
>     clock pm.
>   - Clarify commit language to indicate the function changes the default
>     link states (not ASPM policy).
>  V4
>   - Refactor vmd_enable_apsm() to exit early, making the lines shorter
>     and more readable. Suggested by Christoph.
>  V3
>   - No changes
>  V2
>   - Use return status to print pci_info message if ASPM cannot be enabled.
>   - Add missing static declaration, caught by lkp@intel.com
>  
> 
>  drivers/pci/pcie/aspm.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  7 ++++++
>  2 files changed, 61 insertions(+)

This requires Bjorn's ACK, delegated to him in patchwork.

Lorenzo

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc..b2752851b1ba 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1132,6 +1132,60 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> +/**
> + * pci_enable_default_link_state - Clears and sets the default device link state
> + * so that the link may be allowed to enter the specified states. Note that
> + * if the BIOS didn't grant ASPM control to the OS, this does nothing because
> + * we can't touch the LNKCTL register. Also note that this does not enable
> + * states disabled by pci_disable_link_state(). Returns 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + */
> +int pci_enable_default_link_state(struct pci_dev *pdev, int state)
> +{
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> +
> +	if (!link)
> +		return -EINVAL;
> +	/*
> +	 * A driver requested that ASPM be enabled on this device, but
> +	 * if we don't have permission to manage ASPM (e.g., on ACPI
> +	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
> +	 * the _OSC method), we can't honor that request.
> +	 */
> +	if (aspm_disabled) {
> +		pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
> +		return -EPERM;
> +	}
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +	link->aspm_default = 0;
> +	if (state & PCIE_LINK_STATE_L0S)
> +		link->aspm_default |= ASPM_STATE_L0S;
> +	if (state & PCIE_LINK_STATE_L1)
> +		/* L1 PM substates require L1 */
> +		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> +	if (state & PCIE_LINK_STATE_L1_1)
> +		link->aspm_default |= ASPM_STATE_L1_1;
> +	if (state & PCIE_LINK_STATE_L1_2)
> +		link->aspm_default |= ASPM_STATE_L1_2;
> +	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> +	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +
> +	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> +	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pci_enable_default_link_state);
> +
>  static int pcie_aspm_set_policy(const char *val,
>  				const struct kernel_param *kp)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8253a5413d7c..fd710afe0209 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1641,10 +1641,15 @@ extern bool pcie_ports_native;
>  #define PCIE_LINK_STATE_L1_2		BIT(4)
>  #define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)
>  #define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
> +#define PCIE_LINK_STATE_ALL		(PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
> +					 PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
> +					 PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
> +					 PCIE_LINK_STATE_L1_2_PCIPM)
>  
>  #ifdef CONFIG_PCIEASPM
>  int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> +int pci_enable_default_link_state(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1653,6 +1658,8 @@ static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  { return 0; }
> +static inline int pci_enable_default_link_state(struct pci_dev *pdev, int state)
> +{ return 0; }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> -- 
> 2.25.1
> 
> 

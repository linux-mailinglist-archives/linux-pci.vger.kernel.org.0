Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7E5A2D0C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiHZRCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 13:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbiHZRBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 13:01:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4930C12EB;
        Fri, 26 Aug 2022 10:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74CA0B83212;
        Fri, 26 Aug 2022 17:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D71C433C1;
        Fri, 26 Aug 2022 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661533292;
        bh=P+Nqzk9XTOjDZaK+xvsvyoi6cnmGLm6n083Ph31mhw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WRUDRwrNLpGUIte3tDVVrorSinqxSpBK2tXaq5gF2JJKJq5j+KErXAhFUa7htmM4t
         Xelyma5TaqZB2uZHdrnc1IN11YeOlK4W2N3P1dbfwQBRwDysjb2vjVrH7oItsK46di
         CN0mFQFLlHLCtaWFB17MwsGIZot35TAul+1KuU5NDrOS+Cp0Ksy49Ar4R+pRKl4Syz
         IxglAb7bWhbrq8H+WV9D6ZBVuoCPRsGaoQgI7lVLDnx3URJFIJetgAv260PghDXqJ5
         usL0DStnobKRp+gSJJkkuyGLTwJXdjlnOspZdFTjRjXKmnicFKJaReVPI30vnaZOwJ
         IVEgk60KYKI4g==
Date:   Fri, 26 Aug 2022 12:01:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/3] PCI/ASPM: Add pci_enable_default_link_state()
Message-ID: <20220826170130.GA2933762@bhelgaas>
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

With minor changes below,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> + * pci_enable_default_link_state - Clears and sets the default device link state
> + * so that the link may be allowed to enter the specified states. Note that
> + * if the BIOS didn't grant ASPM control to the OS, this does nothing because
> + * we can't touch the LNKCTL register. Also note that this does not enable
> + * states disabled by pci_disable_link_state(). Returns 0 or a negative errno.

"Clear and set" to match imperative mood of similar comments.

Similarly "Return 0 or ...".

> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + */
> +int pci_enable_default_link_state(struct pci_dev *pdev, int state)

I think "pci_enable_link_state()" would be a better name since
"default" isn't relevant to the caller and it would be more parallel
with pci_disable_link_state().

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

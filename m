Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E814729874
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFILt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFILtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 07:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C201A2;
        Fri,  9 Jun 2023 04:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF1365737;
        Fri,  9 Jun 2023 11:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7F5C433D2;
        Fri,  9 Jun 2023 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686311362;
        bh=8m5SdlBC7FRvkgWHZjLAbuvPA0s4TaAdUTFNpUQF9dw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jeffyEdTEmeL1RFHQJ2xngOj718ZhYtjLJxGAuszORuYSyvR0MjDxGppJVsMtHKRx
         ZitOvwyDCM+Qz+ewskbsszRKKh9+Ar5fJvCNUbEr77qyKcvKapkfrxRwOlh+G1TUrb
         lPv8WORks+LlFmRCWnFC2QMqvlAig1v1zA+OFztJULMK32D42nnkW4YJB3oxYGST/T
         AJFVMkpZevv9VTjDonrD1V9yY/dGSj4dWr/RBThdQjiG69/Ca1tS6bEzM3k02ll52k
         tTLVtPmktP9qvO7Pp9y7LBzOGLzK7rOqDqgtoeognpZnb4YAKsWfvL76BjCfMhG04F
         bas2KaB6haLJw==
Date:   Fri, 9 Jun 2023 06:49:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhiren Chen <zhiren.chen@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Message-ID: <20230609114920.GA1242120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609023038.61388-1-zhiren.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm]

On Fri, Jun 09, 2023 at 10:30:38AM +0800, Zhiren Chen wrote:
> From: Zhiren Chen <Zhiren.Chen@mediatek.com>
> 
> The platform_pci_choose_state function and other low-level platform
> interfaces used by PCI power management processing did not take into
> account non-ACPI-supported platforms. This shortcoming can result in
> limitations and issues.
> 
> For example, in embedded systems like smartphones, a PCI device can be
> shared by multiple processors for different purposes. The PCI device and
> some of the processors are controlled by Linux, while the rest of the
> processors runs its own operating system.
> When Linux initiates system-level sleep, if it does not consider the
> working state of the shared PCI device and forcefully sets the PCI device
> state to D3, it will affect the functionality of other processors that
> are currently using the PCI device.
> 
> To address this problem, an interface should be created for PCI devices
> that don't support ACPI to enable accurate reporting of the power state
> during the PCI PM handling process.
> 
> Signed-off-by: Zhiren Chen <Zhiren.Chen@mediatek.com>
> ---
>  drivers/pci/pci.c   | 24 ++++++++++++++++++++++++
>  drivers/pci/pci.h   | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ede93222bc1..9f03406f3081 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1014,6 +1014,9 @@ static void pci_restore_bars(struct pci_dev *dev)
>  
>  static inline bool platform_pci_power_manageable(struct pci_dev *dev)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->is_manageable)
> +		return dev->platform_pm_ops->is_manageable(dev);
> +
>  	if (pci_use_mid_pm())
>  		return true;
>  
> @@ -1023,6 +1026,9 @@ static inline bool platform_pci_power_manageable(struct pci_dev *dev)
>  static inline int platform_pci_set_power_state(struct pci_dev *dev,
>  					       pci_power_t t)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->set_state)
> +		return dev->platform_pm_ops->set_state(dev, t);
> +
>  	if (pci_use_mid_pm())
>  		return mid_pci_set_power_state(dev, t);
>  
> @@ -1031,6 +1037,9 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
>  
>  static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->get_state)
> +		return dev->platform_pm_ops->get_state(dev);
> +
>  	if (pci_use_mid_pm())
>  		return mid_pci_get_power_state(dev);
>  
> @@ -1039,12 +1048,18 @@ static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
>  
>  static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->refresh_state)
> +		dev->platform_pm_ops->refresh_state(dev);
> +
>  	if (!pci_use_mid_pm())
>  		acpi_pci_refresh_power_state(dev);
>  }
>  
>  static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->choose_state)
> +		return dev->platform_pm_ops->choose_state(dev);
> +
>  	if (pci_use_mid_pm())
>  		return PCI_POWER_ERROR;
>  
> @@ -1053,6 +1068,9 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>  
>  static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->set_wakeup)
> +		return dev->platform_pm_ops->set_wakeup(dev, enable);
> +
>  	if (pci_use_mid_pm())
>  		return PCI_POWER_ERROR;
>  
> @@ -1061,6 +1079,9 @@ static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
>  
>  static inline bool platform_pci_need_resume(struct pci_dev *dev)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->need_resume)
> +		return dev->platform_pm_ops->need_resume(dev);
> +
>  	if (pci_use_mid_pm())
>  		return false;
>  
> @@ -1069,6 +1090,9 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
>  
>  static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->bridge_d3)
> +		return dev->platform_pm_ops->bridge_d3(dev);
> +
>  	if (pci_use_mid_pm())
>  		return false;
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..85154470c083 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -71,6 +71,42 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>   */
>  #define PCI_RESET_WAIT		1000	/* msec */
>  
> +/**
> + * struct pci_platform_pm_ops - Firmware PM callbacks
> + *
> + * @is_manageable: returns 'true' if given device is power manageable by the
> + *                 platform firmware
> + *
> + * @set_state: invokes the platform firmware to set the device's power state
> + *
> + * @get_state: queries the platform firmware for a device's current power state
> + *
> + * @choose_state: returns PCI power state of given device preferred by the
> + *                platform; to be used during system-wide transitions from a
> + *                sleeping state to the working state and vice versa
> + *
> + * @set_wakeup: enables/disables wakeup capability for the device
> + *
> + * @need_resume: returns 'true' if the given device (which is currently
> + *		suspended) needs to be resumed to be configured for system
> + *		wakeup.
> + *
> + * @bridge_d3: return 'true' if given device supoorts D3 when it is a bridge
> + *
> + * @refresh_state: refresh the given device's power state
> + *
> + */
> +struct pci_platform_pm_ops {
> +	bool (*is_manageable)(struct pci_dev *dev);
> +	int (*set_state)(struct pci_dev *dev, pci_power_t state);
> +	pci_power_t (*get_state)(struct pci_dev *dev);
> +	pci_power_t (*choose_state)(struct pci_dev *dev);
> +	int (*set_wakeup)(struct pci_dev *dev, bool enable);
> +	bool (*need_resume)(struct pci_dev *dev);
> +	bool (*bridge_d3)(struct pci_dev *dev);
> +	void (*refresh_state)(struct pci_dev *dev);
> +};
> +
>  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);
> @@ -96,6 +132,10 @@ void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
>  
> +static inline void pci_set_platform_pm(struct pci_dev *dev, struct pci_platform_pm_ops *ops)
> +{
> +	dev->platform_pm_ops = ops;
> +}
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
>  	/* Wait 100 ms before the system can be put into a sleep state. */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60b8772b5bd4..a0171f1abf2f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -327,6 +327,7 @@ struct pci_dev {
>  	void		*sysdata;	/* Hook for sys-specific extension */
>  	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
> +	struct pci_platform_pm_ops *platform_pm_ops;
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
>  	unsigned short	vendor;
> -- 
> 2.17.0
> 

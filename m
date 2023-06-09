Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5172917C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjFIHrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbjFIHrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 03:47:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC71FEC
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 00:47:00 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0BB5B6606F22;
        Fri,  9 Jun 2023 08:46:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686296819;
        bh=Ow3W2me1f5YoI52olM2P9SUfk7htTgMfpdeVgqJ32Eo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jL2F+rK8cqvE9UcfQAkWEjDNzy99R/BmHpUF5gt7RTrL3Tn/YbYnx9A09Kr8cqPwv
         YAOExz+kkerViH09jhEj3hYlGE1GEFRb08L5uD8JRAsS5ugr8ahCQ9aJcEfpXRItLd
         NpOwq6K31JLoNfd3V6WGPWg/DR3bpDt72Z9oFgqwJH8TXfJivfYDao3zJBcsU4QWhy
         sZTFoTqKtGp2ZWGUoHXNoWbrFfv/Atf+chUb/P6BzYhB3WY6ePTgPT2rexeECzzgr7
         DQkHXklYN+LRFps4sgoAf5XREjB2xUptauCTJSMlzfpXypiD8fBRqJVJVysbptqtEU
         Y+bC5nvPeVpjg==
Message-ID: <328e1ad6-26c3-8a65-005c-b7d6f059535e@collabora.com>
Date:   Fri, 9 Jun 2023 09:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Content-Language: en-US
To:     Zhiren Chen <zhiren.chen@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org
References: <20230609023038.61388-1-zhiren.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609023038.61388-1-zhiren.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 09/06/23 04:30, Zhiren Chen ha scritto:
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
>   drivers/pci/pci.c   | 24 ++++++++++++++++++++++++
>   drivers/pci/pci.h   | 40 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci.h |  1 +
>   3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ede93222bc1..9f03406f3081 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1014,6 +1014,9 @@ static void pci_restore_bars(struct pci_dev *dev)
>   
>   static inline bool platform_pci_power_manageable(struct pci_dev *dev)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->is_manageable)
> +		return dev->platform_pm_ops->is_manageable(dev);
> +
>   	if (pci_use_mid_pm())
>   		return true;
>   
> @@ -1023,6 +1026,9 @@ static inline bool platform_pci_power_manageable(struct pci_dev *dev)
>   static inline int platform_pci_set_power_state(struct pci_dev *dev,
>   					       pci_power_t t)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->set_state)
> +		return dev->platform_pm_ops->set_state(dev, t);
> +
>   	if (pci_use_mid_pm())
>   		return mid_pci_set_power_state(dev, t);
>   
> @@ -1031,6 +1037,9 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
>   
>   static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->get_state)
> +		return dev->platform_pm_ops->get_state(dev);
> +
>   	if (pci_use_mid_pm())
>   		return mid_pci_get_power_state(dev);
>   
> @@ -1039,12 +1048,18 @@ static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
>   
>   static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->refresh_state)
> +		dev->platform_pm_ops->refresh_state(dev);
> +
>   	if (!pci_use_mid_pm())
>   		acpi_pci_refresh_power_state(dev);
>   }
>   
>   static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->choose_state)
> +		return dev->platform_pm_ops->choose_state(dev);
> +
>   	if (pci_use_mid_pm())
>   		return PCI_POWER_ERROR;
>   
> @@ -1053,6 +1068,9 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>   
>   static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->set_wakeup)
> +		return dev->platform_pm_ops->set_wakeup(dev, enable);
> +
>   	if (pci_use_mid_pm())
>   		return PCI_POWER_ERROR;
>   
> @@ -1061,6 +1079,9 @@ static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
>   
>   static inline bool platform_pci_need_resume(struct pci_dev *dev)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->need_resume)
> +		return dev->platform_pm_ops->need_resume(dev);
> +
>   	if (pci_use_mid_pm())
>   		return false;
>   
> @@ -1069,6 +1090,9 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
>   
>   static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>   {
> +	if (dev->platform_pm_ops && dev->platform_pm_ops->bridge_d3)
> +		return dev->platform_pm_ops->bridge_d3(dev);
> +
>   	if (pci_use_mid_pm())
>   		return false;
>   
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..85154470c083 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -71,6 +71,42 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>    */
>   #define PCI_RESET_WAIT		1000	/* msec */
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
>   void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>   void pci_refresh_power_state(struct pci_dev *dev);
>   int pci_power_up(struct pci_dev *dev);
> @@ -96,6 +132,10 @@ void pci_bridge_d3_update(struct pci_dev *dev);
>   void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
>   int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
>   
> +static inline void pci_set_platform_pm(struct pci_dev *dev, struct pci_platform_pm_ops *ops)

pci_set_platform_pm_ops()

Anyway ... can you please also show an user of this mechanism? I would imagine that
the user would be pcie-mediatek-gen3?

Please send a patch that implements usage of those platform_pm_ops in the same
series as this one.

Thanks,
Angelo

> +{
> +	dev->platform_pm_ops = ops;
> +}
>   static inline void pci_wakeup_event(struct pci_dev *dev)
>   {
>   	/* Wait 100 ms before the system can be put into a sleep state. */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60b8772b5bd4..a0171f1abf2f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -327,6 +327,7 @@ struct pci_dev {
>   	void		*sysdata;	/* Hook for sys-specific extension */
>   	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
>   	struct pci_slot	*slot;		/* Physical slot this device is in */
> +	struct pci_platform_pm_ops *platform_pm_ops;
>   
>   	unsigned int	devfn;		/* Encoded device & function index */
>   	unsigned short	vendor;


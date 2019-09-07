Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89741AC936
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 22:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395271AbfIGUex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 16:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395270AbfIGUex (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 16:34:53 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711CC20863;
        Sat,  7 Sep 2019 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567888492;
        bh=JhvII6MYtVL9JiZJbLLIaaUwRG/8s657QXnu0VsUWwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzb6OzZ170CP2G5Rod7pP5QYpaAD6qVb28M0/kg7P/HqmEuADL/QoTGpADJFELbnN
         DKPC3cO7z8tvuC17rx2VLEs521yIhkhDxTStcKfwSj1Q1rbZVfaVE88Cdm53PQEyz8
         mjKt4Uw7kxWVLEt/9tkRxhFmFD0aY5ZKf2coOW2c=
Date:   Sat, 7 Sep 2019 15:34:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG
 and related code
Message-ID: <20190907203448.GS103977@google.com>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
 <4096ba95-b132-fc0d-8516-85352e87d82a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4096ba95-b132-fc0d-8516-85352e87d82a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 31, 2019 at 10:18:28PM +0200, Heiner Kallweit wrote:
> Now that we have sysfs attributes for enabling/disabling the individual
> ASPM link states, this debug code isn't needed any longer.

I think this removes some sysfs files, doesn't it?  Since this patch
doesn't remove any documentation, I assume there wasn't any?  IIRC we
had a little discussion on the mailing list about whether these files
were used by anybody, and the conclusion was "not really".  It'd be
nice to cite that discussion here if you can dig it up.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v5:
> - rebased to latest pci/next
> ---
>  drivers/pci/pci-sysfs.c  |   3 --
>  drivers/pci/pci.h        |   8 ---
>  drivers/pci/pcie/Kconfig |   7 ---
>  drivers/pci/pcie/aspm.c  | 105 ---------------------------------------
>  4 files changed, 123 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 687240f55..acba3aff0 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1314,7 +1314,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	int retval;
>  
>  	pcie_vpd_create_sysfs_dev_files(dev);
> -	pcie_aspm_create_sysfs_dev_files(dev);
>  #ifdef CONFIG_PCIEASPM
>  	/* update visibility of attributes in this group */
>  	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
> @@ -1328,7 +1327,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	return 0;
>  
>  error:
> -	pcie_aspm_remove_sysfs_dev_files(dev);
>  	pcie_vpd_remove_sysfs_dev_files(dev);
>  	return retval;
>  }
> @@ -1404,7 +1402,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  {
>  	pcie_vpd_remove_sysfs_dev_files(dev);
> -	pcie_aspm_remove_sysfs_dev_files(dev);
>  	if (dev->reset_fn) {
>  		device_remove_file(&dev->dev, &dev_attr_reset);
>  		dev->reset_fn = 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9dc3e3673..b3d3da257 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -533,14 +533,6 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #endif
>  
> -#ifdef CONFIG_PCIEASPM_DEBUG
> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> -#else
> -static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
> -static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> -#endif
> -
>  #ifdef CONFIG_PCIE_ECRC
>  void pcie_set_ecrc_checking(struct pci_dev *dev);
>  void pcie_ecrc_get_policy(char *str);
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 362eb8cfa..a2e862d4e 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -79,13 +79,6 @@ config PCIEASPM
>  
>  	  When in doubt, say Y.
>  
> -config PCIEASPM_DEBUG
> -	bool "Debug PCI Express ASPM"
> -	depends on PCIEASPM
> -	help
> -	  This enables PCI Express ASPM debug support. It will add per-device
> -	  interface to control ASPM.
> -
>  choice
>  	prompt "Default ASPM policy"
>  	default PCIEASPM_DEFAULT
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ce3425125..67a142251 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1182,111 +1182,6 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  	NULL, 0644);
>  
> -#ifdef CONFIG_PCIEASPM_DEBUG
> -static ssize_t link_state_show(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct pci_dev *pci_device = to_pci_dev(dev);
> -	struct pcie_link_state *link_state = pci_device->link_state;
> -
> -	return sprintf(buf, "%d\n", link_state->aspm_enabled);
> -}
> -
> -static ssize_t link_state_store(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t n)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pcie_link_state *link, *root = pdev->link_state->root;
> -	u32 state;
> -
> -	if (aspm_disabled)
> -		return -EPERM;
> -
> -	if (kstrtouint(buf, 10, &state))
> -		return -EINVAL;
> -	if ((state & ~ASPM_STATE_ALL) != 0)
> -		return -EINVAL;
> -
> -	down_read(&pci_bus_sem);
> -	mutex_lock(&aspm_lock);
> -	list_for_each_entry(link, &link_list, sibling) {
> -		if (link->root != root)
> -			continue;
> -		pcie_config_aspm_link(link, state);
> -	}
> -	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> -	return n;
> -}
> -
> -static ssize_t clk_ctl_show(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct pci_dev *pci_device = to_pci_dev(dev);
> -	struct pcie_link_state *link_state = pci_device->link_state;
> -
> -	return sprintf(buf, "%d\n", link_state->clkpm_enabled);
> -}
> -
> -static ssize_t clk_ctl_store(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t n)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	bool state;
> -
> -	if (strtobool(buf, &state))
> -		return -EINVAL;
> -
> -	down_read(&pci_bus_sem);
> -	mutex_lock(&aspm_lock);
> -	pcie_set_clkpm_nocheck(pdev->link_state, state);
> -	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> -
> -	return n;
> -}
> -
> -static DEVICE_ATTR_RW(link_state);
> -static DEVICE_ATTR_RW(clk_ctl);
> -
> -static char power_group[] = "power";
> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
> -{
> -	struct pcie_link_state *link_state = pdev->link_state;
> -
> -	if (!link_state)
> -		return;
> -
> -	if (link_state->aspm_support)
> -		sysfs_add_file_to_group(&pdev->dev.kobj,
> -			&dev_attr_link_state.attr, power_group);
> -	if (link_state->clkpm_capable)
> -		sysfs_add_file_to_group(&pdev->dev.kobj,
> -			&dev_attr_clk_ctl.attr, power_group);
> -}
> -
> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
> -{
> -	struct pcie_link_state *link_state = pdev->link_state;
> -
> -	if (!link_state)
> -		return;
> -
> -	if (link_state->aspm_support)
> -		sysfs_remove_file_from_group(&pdev->dev.kobj,
> -			&dev_attr_link_state.attr, power_group);
> -	if (link_state->clkpm_capable)
> -		sysfs_remove_file_from_group(&pdev->dev.kobj,
> -			&dev_attr_clk_ctl.attr, power_group);
> -}
> -#endif
> -
>  static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
>  {
>  	struct pci_dev *parent = pdev->bus->self;
> -- 
> 2.23.0
> 
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8634599471
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfHVNFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 09:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfHVNFG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 09:05:06 -0400
Received: from localhost (unknown [12.166.174.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4AE2173E;
        Thu, 22 Aug 2019 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566479104;
        bh=frFwioCzDpph9Rpkhdz2o3ri7vb5AK70KIG8UOvZMZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULiZhu9iVDyUgDWzABvoPcHsx8/A2K1Sj6lybJbFaURZvpdOt6ts4heRB/3Br6CbY
         aQDhD0MmZM0UrEVHPrSbQX3E9FxmBpe4AvT6JgMo8lmVy2ZCZSxvQciiyru4Cpq2md
         4LHZ8sPCmGLrvcFqWTdFiLvZFqCN8t9c0L40g6Gs=
Date:   Thu, 22 Aug 2019 06:05:03 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: add sysfs attributes for controlling
 ASPM
Message-ID: <20190822130503.GD12941@kroah.com>
References: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
 <c75fe7ef-5045-fb53-047c-b7b06d4b7fe8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75fe7ef-5045-fb53-047c-b7b06d4b7fe8@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 08:18:41PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per default.
> However especially on notebooks ASPM can provide significant power-saving,
> therefore we want to give users the option to enable ASPM. With the new sysfs
> attributes users can control which ASPM link-states are enabled/disabled.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - use a dedicated sysfs attribute per link state
> - allow separate control of ASPM and PCI PM L1 sub-states
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>  drivers/pci/pci.h                       |   8 +-
>  drivers/pci/pcie/aspm.c                 | 263 +++++++++++++++++++++++-
>  3 files changed, 276 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 8bfee557e..38b565c30 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -347,3 +347,16 @@ Description:
>  		If the device has any Peer-to-Peer memory registered, this
>  	        file contains a '1' if the memory has been published for
>  		use outside the driver that owns the device.
> +
> +What		/sys/bus/pci/devices/.../power/aspm_l0s
> +What		/sys/bus/pci/devices/.../power/aspm_l1
> +What		/sys/bus/pci/devices/.../power/aspm_l1_1
> +What		/sys/bus/pci/devices/.../power/aspm_l1_2
> +What		/sys/bus/pci/devices/.../power/aspm_l1_1_pcipm
> +What		/sys/bus/pci/devices/.../power/aspm_l1_2_pcipm
> +What		/sys/bus/pci/devices/.../power/aspm_clkpm

Wait, there already is a "power" subdirectory for all devices in the
system, are you adding another one, or files to that already-created
directory?

> +date:		August 2019
> +Contact:	Heiner Kallweit <hkallweit1@gmail.com>
> +Description:	If ASPM is supported for an endpoint, then these files
> +		can be used to disable or enable the individual
> +		power management states.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f126f808..e51c91f38 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -525,17 +525,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> -#endif
> -
> -#ifdef CONFIG_PCIEASPM_DEBUG
> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> -#else
>  static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
>  #endif
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 149b876c9..e7dfcd1bd 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1275,38 +1275,297 @@ static ssize_t clk_ctl_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(link_state);
>  static DEVICE_ATTR_RW(clk_ctl);
> +#endif
> +
> +static const char power_group[] = "power";
> +
> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +
> +	if (pdev->has_secondary_link)
> +		parent = pdev;
> +
> +	return parent ? parent->link_state : NULL;
> +}
> +
> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
> +{
> +	struct pcie_link_state *link;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	link = aspm_get_parent_link(pdev);
> +
> +	return link && link->aspm_capable;
> +}
> +
> +static ssize_t aspm_attr_show_common(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf, int state)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	int val;
> +
> +	link = aspm_get_parent_link(pdev);
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&aspm_lock);
> +	val = !!(link->aspm_enabled & state);
> +	mutex_unlock(&aspm_lock);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);

For sysfs files, you never need to use snprintf() as you "know" the size
of the buffer is big, and you are just printing out a single number.  So
that can be cleaned up in all of these attribute files.

> +}
> +
> +static ssize_t aspm_l0s_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L0S);
> +}
> +
> +static ssize_t aspm_l1_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1);
> +}
> +
> +static ssize_t aspm_l1_1_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_1);
> +}
> +
> +static ssize_t aspm_l1_2_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_2);
> +}
> +
> +static ssize_t aspm_l1_1_pcipm_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_1_PCIPM);
> +}
> +
> +static ssize_t aspm_l1_2_pcipm_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_2_PCIPM);
> +}
> +
> +static ssize_t aspm_attr_store_common(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len, int state)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	bool state_enable;
> +
> +	if (aspm_disabled)
> +		return -EPERM;
> +
> +	link = aspm_get_parent_link(pdev);
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	if (!(link->aspm_capable & state))
> +		return -EOPNOTSUPP;
> +
> +	if (strtobool(buf, &state_enable) < 0)
> +		return -EINVAL;
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +
> +	if (state_enable)
> +		link->aspm_disable &= ~state;
> +	else
> +		link->aspm_disable |= state;
> +
> +	if (link->aspm_disable & ASPM_STATE_L1)
> +		link->aspm_disable |= ASPM_STATE_L1SS;
> +
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));

This function can't fail?

> +
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +
> +	return len;
> +}
> +
> +static ssize_t aspm_l0s_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t len)
> +{
> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L0S);
> +}
> +
> +static ssize_t aspm_l1_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1);
> +}
> +
> +static ssize_t aspm_l1_1_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1_1);
> +}
> +
> +static ssize_t aspm_l1_2_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1_2);
> +}
> +
> +static ssize_t aspm_l1_1_pcipm_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	return aspm_attr_store_common(dev, attr, buf, len,
> +				      ASPM_STATE_L1_1_PCIPM);
> +}
> +
> +static ssize_t aspm_l1_2_pcipm_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	return aspm_attr_store_common(dev, attr, buf, len,
> +				      ASPM_STATE_L1_2_PCIPM);
> +}
> +
> +static ssize_t aspm_clkpm_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	int val;
> +
> +	link = aspm_get_parent_link(pdev);
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&aspm_lock);
> +	val = link->clkpm_enabled;
> +	mutex_unlock(&aspm_lock);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t aspm_clkpm_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	bool state_enable;
> +
> +	if (aspm_disabled)
> +		return -EPERM;
> +
> +	link = aspm_get_parent_link(pdev);
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	if (!link->clkpm_capable)
> +		return -EOPNOTSUPP;
> +
> +	if (strtobool(buf, &state_enable) < 0)
> +		return -EINVAL;
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +
> +	link->clkpm_disable = !state_enable;
> +	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(aspm_l0s);
> +static DEVICE_ATTR_RW(aspm_l1);
> +static DEVICE_ATTR_RW(aspm_l1_1);
> +static DEVICE_ATTR_RW(aspm_l1_2);
> +static DEVICE_ATTR_RW(aspm_l1_1_pcipm);
> +static DEVICE_ATTR_RW(aspm_l1_2_pcipm);
> +static DEVICE_ATTR_RW(aspm_clkpm);
>  
> -static char power_group[] = "power";
>  void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link_state = pdev->link_state;
>  
> +	if (pcie_check_valid_aspm_endpoint(pdev)) {
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l0s.attr, power_group);
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1.attr, power_group);
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_1.attr, power_group);
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_2.attr, power_group);
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_1_pcipm.attr, power_group);
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_2_pcipm.attr, power_group);
> +		sysfs_add_file_to_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_clkpm.attr, power_group);

Huh?  First of, if you are ever in a driver, and you have to call a
sysfs_* function, you know something is wrong.

Why are you dynamically adding files to a group?  These should all be
statically allocated and then at creation time you can dynamically
determine if you need to show them or not.  Use the is_visable callback
for that.

> +	}
> +
>  	if (!link_state)
>  		return;
>  
> +#ifdef CONFIG_PCIEASPM_DEBUG
>  	if (link_state->aspm_support)
>  		sysfs_add_file_to_group(&pdev->dev.kobj,
>  			&dev_attr_link_state.attr, power_group);
>  	if (link_state->clkpm_capable)
>  		sysfs_add_file_to_group(&pdev->dev.kobj,
>  			&dev_attr_clk_ctl.attr, power_group);

Same here.

> +#endif
>  }
>  
>  void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link_state = pdev->link_state;
>  
> +	if (pcie_check_valid_aspm_endpoint(pdev)) {
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l0s.attr, power_group);
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1.attr, power_group);
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_1.attr, power_group);
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_2.attr, power_group);
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_1_pcipm.attr, power_group);
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_l1_2_pcipm.attr, power_group);
> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
> +			&dev_attr_aspm_clkpm.attr, power_group);

And then you never have to do this type of messy logic at all.

Ick.

> +	}
> +
>  	if (!link_state)
>  		return;
>  
> +#ifdef CONFIG_PCIEASPM_DEBUG
>  	if (link_state->aspm_support)
>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>  			&dev_attr_link_state.attr, power_group);
>  	if (link_state->clkpm_capable)
>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>  			&dev_attr_clk_ctl.attr, power_group);

And you get to drop this nonsense as well.

thanks,

greg k-h

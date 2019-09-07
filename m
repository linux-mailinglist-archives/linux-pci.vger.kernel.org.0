Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED74AC932
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfIGUc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 16:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfIGUc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 16:32:26 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0BA20863;
        Sat,  7 Sep 2019 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567888344;
        bh=x/9mK4p4qK/EHCRhMbYcKlzOQWq/GBkZ1KV9ICu1kHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TojeVR9Mrcy5mTJg4mf0aUFO4BHiQraysULB3B72cIqoW0JxexBPXCVpNRMerKIFZ
         BZcsowN9syrTY/rkBYr6/9putkcFxbi009B0ui2W0KKCX9JyOeyhzHeqkopLBnpR2l
         gAMHxkEfzN/S3SNjW+AvvH4Q7kodH3PzF4Q6O77M=
Date:   Sat, 7 Sep 2019 15:32:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
Message-ID: <20190907203220.GR103977@google.com>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
 <8783b887-2e30-43f0-d462-96f8fbb18ae2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8783b887-2e30-43f0-d462-96f8fbb18ae2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 31, 2019 at 10:20:47PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per default.
> However especially on notebooks ASPM can provide significant power-saving,
> therefore we want to give users the option to enable ASPM. With the new
> sysfs attributes users can control which ASPM link-states are
> enabled/disabled.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2:
> - use a dedicated sysfs attribute per link state
> - allow separate control of ASPM and PCI PM L1 sub-states
> v3:
> - statically allocate the attribute group
> - replace snprintf with printf
> - base on top of "PCI: Make pcie_downstream_port() available outside of access.c"
> v4:
> - add call to sysfs_update_group because is_visible callback returns false
>   always at file creation time
> - simplify code a little
> v5:
> - rebased to latest pci/next
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>  drivers/pci/pci-sysfs.c                 |   7 +
>  drivers/pci/pci.h                       |   4 +
>  drivers/pci/pcie/aspm.c                 | 184 ++++++++++++++++++++++++
>  4 files changed, 208 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 8bfee557e..49249a165 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -347,3 +347,16 @@ Description:
>  		If the device has any Peer-to-Peer memory registered, this
>  	        file contains a '1' if the memory has been published for
>  		use outside the driver that owns the device.
> +
> +What		/sys/bus/pci/devices/.../aspm/aspm_l0s
> +What		/sys/bus/pci/devices/.../aspm/aspm_l1
> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1
> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2
> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1_pcipm
> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2_pcipm
> +What		/sys/bus/pci/devices/.../aspm/aspm_clkpm
> +date:		August 2019

Other entries use "What:" and "Date:" (add colon and capitalize).

There are no examples in *this* file, but in
Documentation/ABI/testing/sysfs-bus-pci-drivers-ehci_hcd,
the "What:" is not repeated for each file in the group.

> +Contact:	Heiner Kallweit <hkallweit1@gmail.com>
> +Description:	If ASPM is supported for an endpoint, then these files
> +		can be used to disable or enable the individual
> +		power management states.

Please mention the specific details here, e.g., "write 1 to enable, 0
to disable".

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 868e35109..687240f55 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1315,6 +1315,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  
>  	pcie_vpd_create_sysfs_dev_files(dev);
>  	pcie_aspm_create_sysfs_dev_files(dev);
> +#ifdef CONFIG_PCIEASPM
> +	/* update visibility of attributes in this group */
> +	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
> +#endif

Isn't there a way to do this in drivers/pci/pcie/aspm.c somehow,
without using sysfs_update_group()?  There are only three callers of
it in the tree, and I'd be surprised if ASPM is unique enough to have
to be the fourth.

>  	if (dev->reset_fn) {
>  		retval = device_create_file(&dev->dev, &dev_attr_reset);
> @@ -1571,6 +1575,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pcie_dev_attr_group,
>  #ifdef CONFIG_PCIEAER
>  	&aer_stats_attr_group,
> +#endif
> +#ifdef CONFIG_PCIEASPM
> +	&aspm_ctrl_attr_group,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 44b80186d..9dc3e3673 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -659,4 +659,8 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
>  }
>  #endif
>  
> +#ifdef CONFIG_PCIEASPM
> +extern const struct attribute_group aspm_ctrl_attr_group;
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f044ae4d1..ce3425125 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1287,6 +1287,190 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>  }
>  #endif
>  
> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)

I know the ASPM code is pretty confused, but I don't think "parent
link" really makes sense.  "Parent" implies a parent/child
relationship, but a link doesn't have a parent or a child; it only has
an upstream end and a downstream end.

Anyway, any given PCIe device has either zero or one link associated
with it, so something like "aspm_get_link()" would be unambiguous all
by itself.

> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +
> +	if (pcie_downstream_port(pdev))
> +		parent = pdev;
> +
> +	return parent ? parent->link_state : NULL;
> +}
> +
> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)

Maybe "pcie_is_aspm_dev()" or similar?  I think we may want to include
more than just endpoints (see below).  "Check" in function names is a
pet peeve of mine because it doesn't tell us whether it's a pure
function (as this is) or it has side effects, and it doesn't give a
hint about what the sense of the return value is.

> +{
> +	struct pcie_link_state *link;
> +
> +	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)

Do you intend to exclude other Upstream Ports like Legacy Endpoints,
Upstream Switch Ports, and PCIe-to-PCI/PCI-X Bridges?  They also have
a link leading to them, so we might want them to have knobs as well.
Or if we don't want the knobs, a comment about why not would be
useful.

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

I'm not a huge fan of "!!".  There are several uses in this file, but
I think this:

  enabled = link->aspm_enabled & state;
  ...
  return sprintf(buf, "%d\n", enabled ? 1 : 0);

is clearer.

> +	mutex_unlock(&aspm_lock);
> +
> +	return sprintf(buf, "%d\n", val);
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
> +	if (state_enable) {
> +		link->aspm_disable &= ~state;
> +		/* need to enable L1 for sub-states */
> +		if (state & ASPM_STATE_L1SS)
> +			link->aspm_disable &= ~ASPM_STATE_L1;
> +	} else {
> +		link->aspm_disable |= state;
> +	}
> +
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +
> +	return len;
> +}
> +
> +#define ASPM_ATTR(_f, _s)						\
> +static ssize_t aspm_##_f##_show(struct device *dev,			\
> +			struct device_attribute *attr, char *buf)	\
> +{ return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_##_s); }	\
> +									\
> +static ssize_t aspm_##_f##_store(struct device *dev,			\
> +				 struct device_attribute *attr,		\
> +				 const char *buf, size_t len)		\
> +{ return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_##_s); }
> +
> +ASPM_ATTR(l0s, L0S)
> +ASPM_ATTR(l1, L1)
> +ASPM_ATTR(l1_1, L1_1)
> +ASPM_ATTR(l1_2, L1_2)
> +ASPM_ATTR(l1_1_pcipm, L1_1_PCIPM)
> +ASPM_ATTR(l1_2_pcipm, L1_2_PCIPM)
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
> +	return sprintf(buf, "%d\n", val);
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
> +
> +static struct attribute *aspm_ctrl_attrs[] = {
> +	&dev_attr_aspm_l0s.attr,
> +	&dev_attr_aspm_l1.attr,
> +	&dev_attr_aspm_l1_1.attr,
> +	&dev_attr_aspm_l1_2.attr,
> +	&dev_attr_aspm_l1_1_pcipm.attr,
> +	&dev_attr_aspm_l1_2_pcipm.attr,
> +	&dev_attr_aspm_clkpm.attr,
> +	NULL
> +};
> +
> +static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
> +					   struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return pcie_check_valid_aspm_endpoint(pdev) ? a->mode : 0;
> +}
> +
> +const struct attribute_group aspm_ctrl_attr_group = {
> +	.name = "aspm",
> +	.attrs = aspm_ctrl_attrs,
> +	.is_visible = aspm_ctrl_attrs_are_visible,
> +};
> +
>  static int __init pcie_aspm_disable(char *str)
>  {
>  	if (!strcmp(str, "off")) {
> -- 
> 2.23.0
> 
> 
> 

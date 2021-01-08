Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE32EEAA0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 01:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbhAHA6E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 19:58:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbhAHA6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 19:58:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2388E23731;
        Fri,  8 Jan 2021 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610067443;
        bh=l5q1r62X0KTV/fGKQgwEiB+79JiRcXwrMc65RhIfXig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OxJoKncTIHTE4edrSdXncpDR0NufuBj7UdEI/3i7y6cC/7K7E4WCzwFtfbCNcc7js
         LzlE1NuRSjtnegpm92Cl0NdBV5hZEzvZcop7sMW4h7BpOYvBsMd/kKg9vtV/eTF+S7
         tITsczeb1M553eWhHN22kfvgGwzYUv7lYspN5Hk+AktzvudHg+WIBG8q64J4J1A1VL
         +dRmtaxlXaSbSUfReUetQR+HkkB0ePz1Dm+xMVkn75GQPAK7dStwHT2reyg75yyGpJ
         v69zn5TLloAV/bpSSSPXEVDgr1CAh4sAjXuce4K3GGrvI3EqgI4I+182Rl+EtnFXDd
         eS09WjT2fOcoA==
Date:   Thu, 7 Jan 2021 18:57:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH mlx5-next 1/4] PCI: Configure number of MSI-X vectors for
 SR-IOV VFs
Message-ID: <20210108005721.GA1403391@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103082440.34994-2-leon@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Don]

This patch does not actually *configure* the number of vectors, so the
subject is not quite accurate.  IIUC, this patch adds a sysfs file
that can be used to configure the number of vectors.  The subject
should mention the sysfs connection.

On Sun, Jan 03, 2021 at 10:24:37AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This function is applicable for SR-IOV VFs because such devices allocate
> their MSI-X table before they will run on the targeted hardware and they
> can't guess the right amount of vectors.

This sentence doesn't quite have enough context to make sense to me.
Per PCIe r5.0, sec 9.5.1.2, I think PFs and VFs have independent MSI-X
Capabilities.  What is the connection between the PF MSI-X and the VF
MSI-X?

The MSI-X table sizes should be determined by the Table Size in the
Message Control register.  Apparently we write a VF's Table Size
before a driver is bound to the VF?  Where does that happen?

"Before they run on the targeted hardware" -- do you mean before the
VF is passed through to a guest virtual machine?  You mention "target
VM" below, which makes more sense to me.  VFs don't "run"; they're not
software.  I apologize for not being an expert in the use of VFs.

Please mention the sysfs path in the commit log.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 16 +++++++
>  drivers/pci/iov.c                       | 57 +++++++++++++++++++++++++
>  drivers/pci/msi.c                       | 30 +++++++++++++
>  drivers/pci/pci-sysfs.c                 |  1 +
>  drivers/pci/pci.h                       |  1 +
>  include/linux/pci.h                     |  8 ++++
>  6 files changed, 113 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 25c9c39770c6..30720a9e1386 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -375,3 +375,19 @@ Description:
>  		The value comes from the PCI kernel device state and can be one
>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>  		The file is read only.
> +
> +What:		/sys/bus/pci/devices/.../vf_msix_vec
> +Date:		December 2020
> +Contact:	Leon Romanovsky <leonro@nvidia.com>
> +Description:
> +		This file is associated with the SR-IOV VFs. It allows overwrite
> +		the amount of MSI-X vectors for that VF. This is needed to optimize
> +		performance of newly bounded devices by allocating the number of
> +		vectors based on the internal knowledge of targeted VM.

s/allows overwrite/allows configuration of/
s/for that/for the/
s/amount of/number of/
s/bounded/bound/

What "internal knowledge" is this?  AFAICT this would have to be some
user-space administration knowledge, not anything internal to the
kernel.

> +		The values accepted are:
> +		 * > 0 - this will be number reported by the PCI VF's PCIe MSI-X capability.

s/PCI// (it's obvious we're talking about PCI here)
s/PCIe// (MSI-X is not PCIe-specific, and there's no need to mention
it at all)

> +		 * < 0 - not valid
> +		 * = 0 - will reset to the device default value
> +
> +		The file is writable if no driver is bounded.

From the code, it looks more like this:

  The file is writable if the PF is bound to a driver that supports
  the ->sriov_set_msix_vec_count() callback and there is no driver
  bound to the VF.

Please wrap all of this to fit in 80 columns like the rest of the file.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4afd4ee4f7f0..0f8c570361fc 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -31,6 +31,7 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
>  	return (dev->devfn + dev->sriov->offset +
>  		dev->sriov->stride * vf_id) & 0xff;
>  }
> +EXPORT_SYMBOL(pci_iov_virtfn_devfn);
> 
>  /*
>   * Per SR-IOV spec sec 3.3.10 and 3.3.11, First VF Offset and VF Stride may
> @@ -426,6 +427,62 @@ const struct attribute_group sriov_dev_attr_group = {
>  	.is_visible = sriov_attrs_are_visible,
>  };
> 
> +#ifdef CONFIG_PCI_MSI
> +static ssize_t vf_msix_vec_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int numb = pci_msix_vec_count(pdev);
> +
> +	if (numb < 0)
> +		return numb;
> +
> +	return sprintf(buf, "%d\n", numb);
> +}
> +
> +static ssize_t vf_msix_vec_store(struct device *dev,
> +				 struct device_attribute *attr, const char *buf,
> +				 size_t count)
> +{
> +	struct pci_dev *vf_dev = to_pci_dev(dev);
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_set_msix_vec_count(vf_dev, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(vf_msix_vec);
> +#endif
> +
> +static struct attribute *sriov_vf_dev_attrs[] = {
> +#ifdef CONFIG_PCI_MSI
> +	&dev_attr_vf_msix_vec.attr,
> +#endif
> +	NULL,
> +};
> +
> +static umode_t sriov_vf_attrs_are_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	if (dev_is_pf(dev))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group sriov_vf_dev_attr_group = {
> +	.attrs = sriov_vf_dev_attrs,
> +	.is_visible = sriov_vf_attrs_are_visible,
> +};
> +
>  int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>  {
>  	return 0;
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3162f88fe940..0bcd705487d9 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -991,6 +991,36 @@ int pci_msix_vec_count(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_msix_vec_count);
> 
> +/**
> + * pci_set_msix_vec_count - change the reported number of MSI-X vectors.

Drop period at end, as other kernel doc in this file does.

> + * This function is applicable for SR-IOV VFs because such devices allocate
> + * their MSI-X table before they will run on the targeted hardware and they
> + * can't guess the right amount of vectors.
> + * @dev: VF device that is going to be changed.
> + * @numb: amount of MSI-X vectors.

Rewrite the "such devices allocate..." part based on the questions in
the commit log.  Same with "targeted hardware."

s/amount of/number of/
Drop periods at end of parameter descriptions.

> + **/
> +int pci_set_msix_vec_count(struct pci_dev *dev, int numb)
> +{
> +	struct pci_dev *pdev = pci_physfn(dev);
> +
> +	if (!dev->msix_cap || !pdev->msix_cap)
> +		return -EINVAL;
> +
> +	if (dev->driver || !pdev->driver ||
> +	    !pdev->driver->sriov_set_msix_vec_count)
> +		return -EOPNOTSUPP;
> +
> +	if (numb < 0)
> +		/*
> +		 * We don't support negative numbers for now,
> +		 * but maybe in the future it will make sense.
> +		 */
> +		return -EINVAL;
> +
> +	return pdev->driver->sriov_set_msix_vec_count(dev, numb);

So we write to a VF sysfs file, get here and look up the PF, call a PF
driver callback with the VF as an argument, the callback (at least for
mlx5) looks up the PF from the VF, then does some mlx5-specific magic
to the PF that influences the VF somehow?

Help me connect the dots here.  Is this required because of something
peculiar to mlx5, or is something like this required for all SR-IOV
devices because of the way the PCIe spec is written?

> +}
> +EXPORT_SYMBOL(pci_set_msix_vec_count);
> +
>  static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>  			     int nvec, struct irq_affinity *affd, int flags)
>  {
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index fb072f4b3176..0af2222643c2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1557,6 +1557,7 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
>  	&sriov_dev_attr_group,
> +	&sriov_vf_dev_attr_group,
>  #endif
>  	&pci_bridge_attr_group,
>  	&pcie_dev_attr_group,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5c59365092fa..46396a5da2d9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -502,6 +502,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>  void pci_restore_iov_state(struct pci_dev *dev);
>  int pci_iov_bus_range(struct pci_bus *bus);
>  extern const struct attribute_group sriov_dev_attr_group;
> +extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
>  static inline int pci_iov_init(struct pci_dev *dev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b32126d26997..1acba40a1b1b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -856,6 +856,8 @@ struct module;
>   *		e.g. drivers/net/e100.c.
>   * @sriov_configure: Optional driver callback to allow configuration of
>   *		number of VFs to enable via sysfs "sriov_numvfs" file.
> + * @sriov_set_msix_vec_count: Driver callback to change number of MSI-X vectors
> + *              exposed by the sysfs "vf_msix_vec" entry.
>   * @err_handler: See Documentation/PCI/pci-error-recovery.rst
>   * @groups:	Sysfs attribute groups.
>   * @driver:	Driver model structure.
> @@ -871,6 +873,7 @@ struct pci_driver {
>  	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
>  	void (*shutdown)(struct pci_dev *dev);
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
> +	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	const struct pci_error_handlers *err_handler;
>  	const struct attribute_group **groups;
>  	struct device_driver	driver;
> @@ -1464,6 +1467,7 @@ struct msix_entry {
>  int pci_msi_vec_count(struct pci_dev *dev);
>  void pci_disable_msi(struct pci_dev *dev);
>  int pci_msix_vec_count(struct pci_dev *dev);
> +int pci_set_msix_vec_count(struct pci_dev *dev, int numb);

This patch adds the pci_set_msix_vec_count() definition in pci/msi.c
and a call in pci/iov.c.  It doesn't need to be declared in
include/linux/pci.h or exported.  It can be declared in
drivers/pci/pci.h.

>  void pci_disable_msix(struct pci_dev *dev);
>  void pci_restore_msi_state(struct pci_dev *dev);
>  int pci_msi_enabled(void);
> @@ -2402,6 +2406,10 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #endif
> 
> +#ifdef CONFIG_PCI_IOV
> +int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id);
> +#endif

pci_iov_virtfn_devfn() is already declared in this file.

>  /* Provide the legacy pci_dma_* API */
>  #include <linux/pci-dma-compat.h>
> 
> --
> 2.29.2
> 

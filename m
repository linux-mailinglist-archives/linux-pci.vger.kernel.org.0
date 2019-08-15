Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC198F25E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfHORha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 13:37:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:59366 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731817AbfHORha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 13:37:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 10:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="201286210"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2019 10:37:29 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 171EE5806A0;
        Thu, 15 Aug 2019 10:37:29 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v3 4/4] PCI/IOV: Move sysfs SR-IOV functions to iov.c
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com, gregkh@linuxfoundation.org
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-5-skunberg.kelsey@gmail.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <59c7fc35-656e-e388-6ca5-e4e7ac2b01b3@linux.intel.com>
Date:   Thu, 15 Aug 2019 10:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815153352.86143-5-skunberg.kelsey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/15/19 8:33 AM, Kelsey Skunberg wrote:
> The sysfs SR-IOV functions are for an optional feature and will be better
> organized to keep with the feature's code. Move the sysfs SR-IOV functions
> to /pci/iov.c.
>
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>   drivers/pci/iov.c       | 168 ++++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci-sysfs.c | 173 ----------------------------------------
>   drivers/pci/pci.h       |   2 +-
>   3 files changed, 169 insertions(+), 174 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9b48818ced01..b335db21c85e 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -240,6 +240,174 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
>   	pci_dev_put(dev);
>   }
>   
> +static ssize_t sriov_totalvfs_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
> +}
> +
> +static ssize_t sriov_numvfs_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
> +}
> +
> +/*
> + * num_vfs > 0; number of VFs to enable
> + * num_vfs = 0; disable all VFs
> + *
> + * Note: SRIOV spec does not allow partial VF
> + *	 disable, so it's all or none.
> + */
> +static ssize_t sriov_numvfs_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +	u16 num_vfs;
> +
> +	ret = kstrtou16(buf, 0, &num_vfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (num_vfs > pci_sriov_get_totalvfs(pdev))
> +		return -ERANGE;
> +
> +	device_lock(&pdev->dev);
> +
> +	if (num_vfs == pdev->sriov->num_VFs)
> +		goto exit;
> +
> +	/* is PF driver loaded w/callback */
> +	if (!pdev->driver || !pdev->driver->sriov_configure) {
> +		pci_info(pdev, "Driver does not support SRIOV configuration via sysfs\n");
> +		ret = -ENOENT;
> +		goto exit;
> +	}
> +
> +	if (num_vfs == 0) {
> +		/* disable VFs */
> +		ret = pdev->driver->sriov_configure(pdev, 0);
> +		goto exit;
> +	}
> +
> +	/* enable VFs */
> +	if (pdev->sriov->num_VFs) {
> +		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
> +			 pdev->sriov->num_VFs, num_vfs);
> +		ret = -EBUSY;
> +		goto exit;
> +	}
> +
> +	ret = pdev->driver->sriov_configure(pdev, num_vfs);
> +	if (ret < 0)
> +		goto exit;
> +
> +	if (ret != num_vfs)
> +		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
> +			 num_vfs, ret);
> +
> +exit:
> +	device_unlock(&pdev->dev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t sriov_offset_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->offset);
> +}
> +
> +static ssize_t sriov_stride_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->stride);
> +}
> +
> +static ssize_t sriov_vf_device_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
> +}
> +
> +static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
> +}
> +
> +static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool drivers_autoprobe;
> +
> +	if (kstrtobool(buf, &drivers_autoprobe) < 0)
> +		return -EINVAL;
> +
> +	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RO(sriov_totalvfs);
> +static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> +static DEVICE_ATTR_RO(sriov_offset);
> +static DEVICE_ATTR_RO(sriov_stride);
> +static DEVICE_ATTR_RO(sriov_vf_device);
> +static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> +		   sriov_drivers_autoprobe_store);
> +
> +static struct attribute *sriov_dev_attrs[] = {
> +	&dev_attr_sriov_totalvfs.attr,
> +	&dev_attr_sriov_numvfs.attr,
> +	&dev_attr_sriov_offset.attr,
> +	&dev_attr_sriov_stride.attr,
> +	&dev_attr_sriov_vf_device.attr,
> +	&dev_attr_sriov_drivers_autoprobe.attr,
> +	NULL,
> +};
> +
> +static umode_t sriov_attrs_are_visible(struct kobject *kobj,
> +				       struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	if (!dev_is_pf(dev))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group sriov_dev_attr_group = {
> +	.attrs = sriov_dev_attrs,
> +	.is_visible = sriov_attrs_are_visible,
> +};
> +
>   int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   {
>   	return 0;
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5bb301efec98..868e35109284 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -548,151 +548,6 @@ static ssize_t devspec_show(struct device *dev,
>   static DEVICE_ATTR_RO(devspec);
>   #endif
>   
> -#ifdef CONFIG_PCI_IOV
> -static ssize_t sriov_totalvfs_show(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
> -}
> -
> -
> -static ssize_t sriov_numvfs_show(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
> -}
> -
> -/*
> - * num_vfs > 0; number of VFs to enable
> - * num_vfs = 0; disable all VFs
> - *
> - * Note: SRIOV spec doesn't allow partial VF
> - *       disable, so it's all or none.
> - */
> -static ssize_t sriov_numvfs_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
> -	u16 num_vfs;
> -
> -	ret = kstrtou16(buf, 0, &num_vfs);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (num_vfs > pci_sriov_get_totalvfs(pdev))
> -		return -ERANGE;
> -
> -	device_lock(&pdev->dev);
> -
> -	if (num_vfs == pdev->sriov->num_VFs)
> -		goto exit;
> -
> -	/* is PF driver loaded w/callback */
> -	if (!pdev->driver || !pdev->driver->sriov_configure) {
> -		pci_info(pdev, "Driver doesn't support SRIOV configuration via sysfs\n");
> -		ret = -ENOENT;
> -		goto exit;
> -	}
> -
> -	if (num_vfs == 0) {
> -		/* disable VFs */
> -		ret = pdev->driver->sriov_configure(pdev, 0);
> -		goto exit;
> -	}
> -
> -	/* enable VFs */
> -	if (pdev->sriov->num_VFs) {
> -		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
> -			 pdev->sriov->num_VFs, num_vfs);
> -		ret = -EBUSY;
> -		goto exit;
> -	}
> -
> -	ret = pdev->driver->sriov_configure(pdev, num_vfs);
> -	if (ret < 0)
> -		goto exit;
> -
> -	if (ret != num_vfs)
> -		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
> -			 num_vfs, ret);
> -
> -exit:
> -	device_unlock(&pdev->dev);
> -
> -	if (ret < 0)
> -		return ret;
> -
> -	return count;
> -}
> -
> -static ssize_t sriov_offset_show(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	return sprintf(buf, "%u\n", pdev->sriov->offset);
> -}
> -
> -static ssize_t sriov_stride_show(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	return sprintf(buf, "%u\n", pdev->sriov->stride);
> -}
> -
> -static ssize_t sriov_vf_device_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
> -}
> -
> -static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
> -					    struct device_attribute *attr,
> -					    char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
> -}
> -
> -static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
> -					     struct device_attribute *attr,
> -					     const char *buf, size_t count)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	bool drivers_autoprobe;
> -
> -	if (kstrtobool(buf, &drivers_autoprobe) < 0)
> -		return -EINVAL;
> -
> -	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
> -
> -	return count;
> -}
> -
> -static DEVICE_ATTR_RO(sriov_totalvfs);
> -static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> -static DEVICE_ATTR_RO(sriov_offset);
> -static DEVICE_ATTR_RO(sriov_stride);
> -static DEVICE_ATTR_RO(sriov_vf_device);
> -static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> -		   sriov_drivers_autoprobe_store);
> -#endif /* CONFIG_PCI_IOV */
> -
>   static ssize_t driver_override_store(struct device *dev,
>   				     struct device_attribute *attr,
>   				     const char *buf, size_t count)
> @@ -1691,34 +1546,6 @@ static const struct attribute_group pci_dev_hp_attr_group = {
>   	.is_visible = pci_dev_hp_attrs_are_visible,
>   };
>   
> -#ifdef CONFIG_PCI_IOV
> -static struct attribute *sriov_dev_attrs[] = {
> -	&dev_attr_sriov_totalvfs.attr,
> -	&dev_attr_sriov_numvfs.attr,
> -	&dev_attr_sriov_offset.attr,
> -	&dev_attr_sriov_stride.attr,
> -	&dev_attr_sriov_vf_device.attr,
> -	&dev_attr_sriov_drivers_autoprobe.attr,
> -	NULL,
> -};
> -
> -static umode_t sriov_attrs_are_visible(struct kobject *kobj,
> -				       struct attribute *a, int n)
> -{
> -	struct device *dev = kobj_to_dev(kobj);
> -
> -	if (!dev_is_pf(dev))
> -		return 0;
> -
> -	return a->mode;
> -}
> -
> -static const struct attribute_group sriov_dev_attr_group = {
> -	.attrs = sriov_dev_attrs,
> -	.is_visible = sriov_attrs_are_visible,
> -};
> -#endif /* CONFIG_PCI_IOV */
> -
>   static const struct attribute_group pci_dev_attr_group = {
>   	.attrs = pci_dev_dev_attrs,
>   	.is_visible = pci_dev_attrs_are_visible,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 61bbfd611140..7e3c6c8ae6f9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -455,7 +455,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>   resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>   void pci_restore_iov_state(struct pci_dev *dev);
>   int pci_iov_bus_range(struct pci_bus *bus);
> -
> +extern const struct attribute_group sriov_dev_attr_group;
>   #else
>   static inline int pci_iov_init(struct pci_dev *dev)
>   {

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


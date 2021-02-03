Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB530DE11
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhBCPY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 10:24:57 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34027 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhBCPY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 10:24:56 -0500
Received: by mail-wr1-f48.google.com with SMTP id g10so24823523wrx.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 07:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EstoSS3tvMVZyTXWQIL14jQcnlvYjp87Dy6dOXG1BHc=;
        b=s3zfF5wVZGVgbbzAAQqQxrnysEpNIiztZWOKm6v91beQxAZe8K3MBwKeFpCeH+5Jgu
         vIqF+yl4zyuK2+tEp/7vxJSog/FCaSXwnbwFWYClgJHGBXqtr+jON8cpBssOLp48E0+r
         607lNz0oV6C3BAQo3UKZEhwuJwwEcybO3nGSWFHegItH3TMtg32SdU1/Xkr+GeClK2JQ
         kDZ6oa8Im0VN4uCX4lTKJDoHi8tix1w8C/4EuqufEFnq7i1LxXtP0i5sUlMO0v/IQkjt
         AFfU9HNKWkIczk0dlrMZPQbL+y7qvXrRru+yN0vZXCVs/SMyIXdXTBncQ0hhY54Mqero
         alSg==
X-Gm-Message-State: AOAM530LZfyHzm5ENMZqhJOSsC8+obfS61m9LESn1S997FbYtzLDEhJA
        I+TxqkjhSAvcLOmMm0SlxIQ=
X-Google-Smtp-Source: ABdhPJxkTUPWiQOR7Bbjz2yWy46KzlgBPE4Fw613az+lTtjH2jokXls8tOgYC8ikRHW3PktIBJ4qrA==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr4078743wru.220.1612365852226;
        Wed, 03 Feb 2021 07:24:12 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k4sm4493433wrm.53.2021.02.03.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:24:11 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:24:10 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI/VPD: Let PCI sysfs core code handle VPD
 binary attribute
Message-ID: <YBrAGpuXD/akcNN2@rocinante>
References: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
 <7703024f-8882-9eec-a122-599871728a89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7703024f-8882-9eec-a122-599871728a89@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

Thank you for working on this and for cleaning this up!

On 21-02-03 09:50:13, Heiner Kallweit wrote:
> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
> there's nothing that keeps us from using a static attribute.
> This allows to use PCI sysfs core code for handling the attribute.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci-sysfs.c | 54 ++++++++++++++++++++++++++++++-----------
>  drivers/pci/pci.h       |  2 --
>  drivers/pci/vpd.c       | 54 -----------------------------------------
>  3 files changed, 40 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index fb072f4b3..ed2ded167 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -255,6 +255,25 @@ static ssize_t ari_enabled_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(ari_enabled);
>  
> +static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> +			struct bin_attribute *bin_attr, char *buf,
> +			loff_t off, size_t count)
> +{
> +	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_read_vpd(dev, off, count, buf);
> +}
> +
> +static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t off, size_t count)
> +{
> +	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_write_vpd(dev, off, count, buf);
> +}
> +static BIN_ATTR_RW(vpd, 0);
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -621,6 +640,11 @@ static struct attribute *pci_dev_attrs[] = {
>  	NULL,
>  };
>  
> +static struct bin_attribute *pci_dev_bin_attrs[] = {
> +	&bin_attr_vpd,
> +	NULL,
> +};
> +
>  static struct attribute *pci_bridge_attrs[] = {
>  	&dev_attr_subordinate_bus_number.attr,
>  	&dev_attr_secondary_bus_number.attr,
> @@ -1323,20 +1347,10 @@ static DEVICE_ATTR(reset, 0200, NULL, reset_store);
>  
>  static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  {
> -	int retval;
> -
> -	pcie_vpd_create_sysfs_dev_files(dev);
> -
> -	if (dev->reset_fn) {
> -		retval = device_create_file(&dev->dev, &dev_attr_reset);
> -		if (retval)
> -			goto error;
> -	}
> -	return 0;
> +	if (!dev->reset_fn)
> +		return 0;
>  
> -error:
> -	pcie_vpd_remove_sysfs_dev_files(dev);
> -	return retval;
> +	return device_create_file(&dev->dev, &dev_attr_reset);
>  }
>  
>  int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
> @@ -1409,7 +1423,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  
>  static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  {
> -	pcie_vpd_remove_sysfs_dev_files(dev);
>  	if (dev->reset_fn) {
>  		device_remove_file(&dev->dev, &dev_attr_reset);
>  		dev->reset_fn = 0;
> @@ -1523,8 +1536,21 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	return 0;
>  }
>  
> +static umode_t pci_dev_bin_attrs_visible(struct kobject *kobj,
> +					 struct bin_attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	if (a == &bin_attr_vpd && !pdev->vpd)
> +		return 0;
> +
> +	return a->attr.mode;
> +}
> +
>  static const struct attribute_group pci_dev_group = {
>  	.attrs = pci_dev_attrs,
> +	.bin_attrs = pci_dev_bin_attrs,
> +	.is_bin_visible = pci_dev_bin_attrs_visible,
>  };
>  
>  const struct attribute_group *pci_dev_groups[] = {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ef7c46613..d6ad1a3e2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -143,8 +143,6 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
>  
>  int pci_vpd_init(struct pci_dev *dev);
>  void pci_vpd_release(struct pci_dev *dev);
> -void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
> -void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev);
>  
>  /* PCI Virtual Channel */
>  int pci_save_vc_state(struct pci_dev *dev);
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 2096530ce..a33a8fd7e 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -21,7 +21,6 @@ struct pci_vpd_ops {
>  
>  struct pci_vpd {
>  	const struct pci_vpd_ops *ops;
> -	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
>  	struct mutex	lock;
>  	unsigned int	len;
>  	u16		flag;
> @@ -397,59 +396,6 @@ void pci_vpd_release(struct pci_dev *dev)
>  	kfree(dev->vpd);
>  }
>  
> -static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
> -			     struct bin_attribute *bin_attr, char *buf,
> -			     loff_t off, size_t count)
> -{
> -	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> -
> -	return pci_read_vpd(dev, off, count, buf);
> -}
> -
> -static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
> -			      struct bin_attribute *bin_attr, char *buf,
> -			      loff_t off, size_t count)
> -{
> -	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> -
> -	return pci_write_vpd(dev, off, count, buf);
> -}
> -
> -void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
> -{
> -	int retval;
> -	struct bin_attribute *attr;
> -
> -	if (!dev->vpd)
> -		return;
> -
> -	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
> -	if (!attr)
> -		return;
> -
> -	sysfs_bin_attr_init(attr);
> -	attr->size = 0;
> -	attr->attr.name = "vpd";
> -	attr->attr.mode = S_IRUSR | S_IWUSR;
> -	attr->read = read_vpd_attr;
> -	attr->write = write_vpd_attr;
> -	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
> -	if (retval) {
> -		kfree(attr);
> -		return;
> -	}
> -
> -	dev->vpd->attr = attr;
> -}
> -
> -void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
> -{
> -	if (dev->vpd && dev->vpd->attr) {
> -		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
> -		kfree(dev->vpd->attr);
> -	}
> -}
> -
>  int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
>  {
>  	int i;
> -- 
> 2.30.0
> 

This looks so much better now.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof

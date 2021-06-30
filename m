Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA653B88B8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 20:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhF3Svg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 14:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhF3Svg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 14:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625078946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7k/PuUEJUYD23vYMA+b7KP7vFZOVZ6LB7hS0+bFhwA=;
        b=N/OaU64HE9eELMeaaQAldfogSejLkSBhBUOkRb7weOdSS/FNWFd/ifEKjVNBNNCaOIcnpL
        IfA4P4pj9b5FUeLS76tMjWVQFINaN1JVqwPumzPIXYQZ+OQEd5N/o7u1qegXvgKHa8IaNZ
        kNc/YQAwDl39UFv/g2AxKSurMEeBRYQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-8Y57RCR5MaCcE8DvGCQBrA-1; Wed, 30 Jun 2021 14:49:05 -0400
X-MC-Unique: 8Y57RCR5MaCcE8DvGCQBrA-1
Received: by mail-oi1-f197.google.com with SMTP id m21-20020a0568080f15b029023dd486bf36so1502080oiw.15
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 11:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7k/PuUEJUYD23vYMA+b7KP7vFZOVZ6LB7hS0+bFhwA=;
        b=gHNlfzEIC8dKli9RsxaKYRjAQ0sRHeamy1SO3hrqpU5F1dKVZHyiohWwEVkX2u6o4t
         HG5x9vc2XKXUrfqWzqvk7Fj5ZsBSSDEXeNmCfCdUFhfpYbUthfUSz2ggoOAnKNi8voRc
         sW8gTh2UtBnNlnVJuPxqUfwXS9eWaLtCrp8x5Ugbq4v60iIB8SJ5vR6Gv3TfbLB7nU6A
         iEO2cUauwFJa1n9NRwosnmpETjuZ+YLCrfbwoDRXBUyZls0apf1Z26pFwAXcZ35x1jQK
         jkyK1NkWOhoCVv56an4+5O8ASemsP4ElZAfK5F//AvLu73JUCmjwC1l6xp9yFBBDUU5R
         kUWA==
X-Gm-Message-State: AOAM533/KpxWIigYgeRYTzqwKn+RyykPr7xV/9Y0y/YZWLDCHbkp2Q0Y
        vcYCUuLGLa/tDxWGfzJjBy34+zYPYebfjbhUO8VXCf9DU4GB3d7u8DkL5pIz9l98zMVqJd6cIlP
        BJRdzqsSfILGK233wWlgk
X-Received: by 2002:aca:d842:: with SMTP id p63mr4322085oig.114.1625078944265;
        Wed, 30 Jun 2021 11:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPCeqzYEVgzgnZy5ofU3Xmt7DoqSGAtcXmtqVZIpxXE56OueN2gTOg104/xWU9Gm/lgN/QBg==
X-Received: by 2002:aca:d842:: with SMTP id p63mr4322069oig.114.1625078944120;
        Wed, 30 Jun 2021 11:49:04 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id t69sm3746055oih.19.2021.06.30.11.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:49:03 -0700 (PDT)
Date:   Wed, 30 Jun 2021 12:49:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210630124902.58f51766.alex.williamson@redhat.com>
In-Reply-To: <20210629160104.2893-5-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
        <20210629160104.2893-5-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Jun 2021 21:31:00 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
> 
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
>  drivers/pci/pci-sysfs.c                 | 102 ++++++++++++++++++++++++
>  drivers/pci/pci.c                       |   1 +
>  3 files changed, 122 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2..43f4e33c7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,25 @@ Description:
>  		child buses, and re-discover devices removed earlier
>  		from this part of the device tree.
>  
> +What:		/sys/bus/pci/devices/.../reset_method
> +Date:		March 2021
> +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> +Description:
> +		Some devices allow an individual function to be reset
> +		without affecting other functions in the same slot.
> +
> +		For devices that have this support, a file named
> +		reset_method will be present in sysfs. Initially reading
> +		this file will give names of the device supported reset
> +		methods and their ordering. After write, this file will
> +		give names and ordering of currently enabled reset methods.
> +		Writing the name or comma separated list of names of any of
> +		the device supported reset methods to this file will set
> +		the reset methods and their ordering to be used when
> +		resetting the device. Writing empty string to this file
> +		will disable ability to reset the device and writing
> +		"default" will return to the original value.
> +
>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
>  Contact:	Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 316f70c3e..6713af211 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1334,6 +1334,107 @@ static const struct attribute_group pci_dev_rom_attr_group = {
>  	.is_bin_visible = pci_dev_rom_attr_is_visible,
>  };
>  
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len = 0;
> +	int i, idx;
> +
> +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		idx = pdev->reset_methods[i];
> +		if (idx)

Given the new encoding, shouldn't this be:

	if (!idx)
		break;

For example if we had [1, 0, 2,...] (which should be impossible) then
__pci_reset_function_locked() would stop at the first zero, but the
logic here would cause sysfs to print "device_specific,flr".

> +			len += sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
> +					     pci_reset_fn_methods[idx].name);
> +	}
> +
> +	if (len)
> +		len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t reset_method_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int i, n;
> +	char *name, *options;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
> +
> +	if (count >= (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "")) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		memset(pdev->reset_methods, 0, PCI_NUM_RESET_METHODS);

If options were initialized to NULL, this could be a goto before the
memcpy below.

> +		return count;
> +	}
> +
> +	if (sysfs_streq(buf, "default")) {
> +		pci_init_reset_methods(pdev);
> +		return count;
> +	}
> +
> +	options = kstrndup(buf, count, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	n = 0;

nit, initialize in declaration.  Looks like @i could also be scoped
within the below loop.

> +
> +	while ((name = strsep(&options, ",")) != NULL) {
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name = strim(name);
> +
> +		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> +				reset_methods[n++] = i;
> +				break;
> +			}
> +		}
> +
> +		if (i == PCI_NUM_RESET_METHODS) {
> +			kfree(options);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> +
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> +	kfree(options);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(reset_method);
> +
> +static struct attribute *pci_dev_reset_method_attrs[] = {
> +	&dev_attr_reset_method.attr,
> +	NULL,
> +};
> +
> +static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
> +						    struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	if (!pci_reset_supported(pdev))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group pci_dev_reset_method_attr_group = {
> +	.attrs = pci_dev_reset_method_attrs,
> +	.is_visible = pci_dev_reset_method_attr_is_visible,
> +};
> +
>  static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> @@ -1491,6 +1592,7 @@ const struct attribute_group *pci_dev_groups[] = {
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 90f0b35e6..db4e035cf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5198,6 +5198,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
>  		else if (rc != -ENOTTY)
>  			break;
>  	}
> +
>  	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
>  }
>  

Do this cleanup where it was introduced in patch 2/  Thanks,

Alex


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4483C8423
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 13:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhGNMCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNMCm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 08:02:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D19C06175F;
        Wed, 14 Jul 2021 04:59:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w15so2105220pgk.13;
        Wed, 14 Jul 2021 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BYAB0IcsIwM15U87TPked3FMLOx8gHDrWRUXhvAMX6s=;
        b=Gufl/RwhzJ5LxDX9O9h23x6IyjJfJOsdRBrThWLFRUQEpYpWnyYv9U/0fDGtAzucI+
         AQZCZTxDT71GTt9rakmmyCZZfPfVYBeK3MpDcAyEr+Cme8PlExajcePe9mYGVrBJxABH
         fCfoFUUmCzyE4rVur6psK6+h45Ct8plwcUcPP+gJNGkE3aA8i7vvC1Wke3Pc5Sjb/9PH
         shyeXTWTPgk5K6q9GU9pUxA0cbEOihndSAQmYlkMUrVZNdaKQNGkHOXxcCzrxYCbZFMX
         lRCjGkQj6UIQtbH43VPYdlJP2ngKOho+v7FohpGP8D6L3GdbhRW8qDd6w9TaC/WHc+PJ
         EbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYAB0IcsIwM15U87TPked3FMLOx8gHDrWRUXhvAMX6s=;
        b=I00f37j/dmkKbW5g0X4XwQcIYD1SfSMBgdEo4GmEKrQTQDKy0IXpYyiKEhVw7Fgrid
         IvOejHc/ANQxrsyxAgZxJ1X94H+/YYKgg5yuJB3+CfOEYe0NSGyi+46yRgDI4pUrl3Fy
         OJjp/gXjIIuq0iaXegT3r/2WNulr3ujuhQdxdR3PQgJhyBdiPuz7F1ZQhrephhf4LV4o
         9uy6ehGcs7Pt1/73NOWMwGvjlyCWVMMnhbd/+KXTYJwSt8dPU4660Oc6/fGUL+YIqc5g
         mIHukeYiBI/sM571ecmSnn88W7Rq2x6yGkKupNHVyPkxhstUwzZoPN90j14oLWkZjdp2
         cqig==
X-Gm-Message-State: AOAM531V8XKOiT22asdC6KmrjDb4B/SXOjqlHdNyXC7DvFPf40KljItN
        3DAF/MnXFt2UPuarkhYhO0M=
X-Google-Smtp-Source: ABdhPJyt2AhECgFQf7u1LRvs/w4wkAonRtMrS76/76coZWeyWQZKmvZgWIQecPDnB8q6uQYWLAe/1A==
X-Received: by 2002:a65:6404:: with SMTP id a4mr9330265pgv.175.1626263989620;
        Wed, 14 Jul 2021 04:59:49 -0700 (PDT)
Received: from localhost ([152.57.175.214])
        by smtp.gmail.com with ESMTPSA id d2sm5715445pjo.50.2021.07.14.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:59:49 -0700 (PDT)
Date:   Wed, 14 Jul 2021 17:29:43 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v9 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210714115943.sxld7obcmzvf6k56@archlinux>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-5-ameynarkhede03@gmail.com>
 <20210711165056.GA30721@raphael-debian-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711165056.GA30721@raphael-debian-dev>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/11 04:51PM, Raphael Norwitz wrote:
> On Mon, Jul 05, 2021 at 07:51:34PM +0530, Amey Narkhede wrote:
> > Add reset_method sysfs attribute to enable user to query and set user
> > preferred device reset methods and their ordering.
> >
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>
> Just some spacing NITs.
>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
> >  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index ef00fada2..43f4e33c7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -121,6 +121,25 @@ Description:
> >  		child buses, and re-discover devices removed earlier
> >  		from this part of the device tree.
> >
> > +What:		/sys/bus/pci/devices/.../reset_method
> > +Date:		March 2021
> > +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> > +Description:
> > +		Some devices allow an individual function to be reset
> > +		without affecting other functions in the same slot.
> > +
> > +		For devices that have this support, a file named
> > +		reset_method will be present in sysfs. Initially reading
> > +		this file will give names of the device supported reset
> > +		methods and their ordering. After write, this file will
> > +		give names and ordering of currently enabled reset methods.
> > +		Writing the name or comma separated list of names of any of
> > +		the device supported reset methods to this file will set
> > +		the reset methods and their ordering to be used when
> > +		resetting the device. Writing empty string to this file
> > +		will disable ability to reset the device and writing
> > +		"default" will return to the original value.
> > +
> >  What:		/sys/bus/pci/devices/.../reset
> >  Date:		July 2009
> >  Contact:	Michael S. Tsirkin <mst@redhat.com>
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 316f70c3e..8a740e211 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1334,6 +1334,108 @@ static const struct attribute_group pci_dev_rom_attr_group = {
> >  	.is_bin_visible = pci_dev_rom_attr_is_visible,
> >  };
> >
> > +static ssize_t reset_method_show(struct device *dev,
>
> Nit: spaces on the following two lines. "struct device_attribute *attr"
> and "char *buf" should be in line with "struct device *dev"
>
Not sure what happened when creating the patches but on my editor spaces
seems to consistent as you suggested here. For some reason git
format-patch is acting weird.

Thanks,
Amey
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	ssize_t len = 0;
> > +	int i, idx;
> > +
> > +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> > +		idx = pdev->reset_methods[i];
> > +		if (!idx)
> > +			break;
> > +
> > +		len += sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
> > +				     pci_reset_fn_methods[idx].name);
> > +	}
> > +
> > +	if (len)
> > +		len += sysfs_emit_at(buf, len, "\n");
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t reset_method_store(struct device *dev,
>
> Nit: spaces on the following two lines
>
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int n = 0;
> > +	char *name, *options = NULL;
> > +	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
> > +
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	if (sysfs_streq(buf, "")) {
> > +		pci_warn(pdev, "All device reset methods disabled by user");
> > +		goto set_reset_methods;
> > +	}
> > +
> > +	if (sysfs_streq(buf, "default")) {
> > +		pci_init_reset_methods(pdev);
> > +		return count;
> > +	}
> > +
> > +	options = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!options)
> > +		return -ENOMEM;
> > +
> > +	while ((name = strsep(&options, ",")) != NULL) {
> > +		int i;
> > +
> > +		if (sysfs_streq(name, ""))
> > +			continue;
> > +
> > +		name = strim(name);
> > +
> > +		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> > +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> > +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> > +				reset_methods[n++] = i;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (i == PCI_NUM_RESET_METHODS) {
> > +			kfree(options);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
> > +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> > +
> > +set_reset_methods:
> > +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> > +	kfree(options);
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(reset_method);
> > +
> > +static struct attribute *pci_dev_reset_method_attrs[] = {
> > +	&dev_attr_reset_method.attr,
> > +	NULL,
> > +};
> > +
> > +static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
>
> Nit: ditto - spacing.
>
> > +						    struct attribute *a, int n)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> > +
> > +	if (!pci_reset_supported(pdev))
> > +		return 0;
> > +
> > +	return a->mode;
> > +}
> > +
> > +static const struct attribute_group pci_dev_reset_method_attr_group = {
> > +	.attrs = pci_dev_reset_method_attrs,
> > +	.is_visible = pci_dev_reset_method_attr_is_visible,
> > +};
> > +
> >  static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>
> Nit: spacing following line.
>
> >  			   const char *buf, size_t count)
> >  {
> > @@ -1491,6 +1593,7 @@ const struct attribute_group *pci_dev_groups[] = {
> >  	&pci_dev_config_attr_group,
> >  	&pci_dev_rom_attr_group,
> >  	&pci_dev_reset_attr_group,
> > +	&pci_dev_reset_method_attr_group,
> >  	&pci_dev_vpd_attr_group,
> >  #ifdef CONFIG_DMI
> >  	&pci_dev_smbios_attr_group,
> > --
> > 2.32.0
> >
> >

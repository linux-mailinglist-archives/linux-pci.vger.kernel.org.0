Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AF3ADA44
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 15:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhFSOBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhFSOBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 10:01:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E4C061574;
        Sat, 19 Jun 2021 06:59:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i4so2425953plt.12;
        Sat, 19 Jun 2021 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JOA4qP4JI0hXa0maTyHwjdZvQ2VJl7saerJeP6fXVIg=;
        b=USsqFbZKFskCwaBXraaW0fEZKiUbY5R3meq1J7KCjUQefiWzFMoqa24Ws+Pu/0ndVs
         0j4ucgeoC1jvV3hn1kRq3rpZ8Kw7rBvakVLnG4oEtwKpw2ANyjLbty3A4/IE9O9xCP3e
         dw8QNd1a2UQ/qklvcatKb+dxTCSMUeLCi2yct7AbwrC7r8HlvuwGT/QXkv/Py5WKa7pb
         aBFzisVau8220RCOCblnlWN4tozFJW6NWTZ+OgNpq5nBK7IZzTQ5LxYnGOKXGFWms8zQ
         phwAlU7c8fj/XE0waEToTSNi+QJ3xeT3v7equ3yg5gD1sr6SK/U4i62mjwzk7Bs0hL+4
         mQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JOA4qP4JI0hXa0maTyHwjdZvQ2VJl7saerJeP6fXVIg=;
        b=s7fSN/qmPoAvbD1NjA/XYmN+4QQ71TbyX3ghva5Jpxe7uFk7aO58bOPlAvI6Sq210T
         aat/JSFFS+inXj9TDVENoZn7k04NnDFCcvOowV87pJQXAHjoi+3HhQIub7YO/w4k0TCD
         iLZcIG4k7VAs18pHRXEHf9ZlggMwmMnjj41/nW8ZVPl8huXZ5tTvnmrKNyNvaetkpwrl
         gSxABfYBNFcUALKdDjFQnf9TNQrb3ECtSFgk0EHGgaGaMl0xT5bHlsLWq6Wi5JlhxZZu
         4kyG4Bh3waTT17KRkSecQDtdenuvlOJv6vSA4xcnwiFxfIEcs4yTAb/iygWxlnMVzEwZ
         D0wQ==
X-Gm-Message-State: AOAM5331Qz0iQVJAHyNPjBcPyWvs9z3ClosnWTCO+89fFV6iF5DuzYQq
        DKR+jZWD/BRO1HP3KU9sKw8=
X-Google-Smtp-Source: ABdhPJyhfm2TdOXVlAeY5d74lvWjnOsFImjOAJruFiJ36r04CFLpbjyZ3n1UWGFbD6zRlCHU0zh0IA==
X-Received: by 2002:a17:902:7b8a:b029:109:7bdb:ed9 with SMTP id w10-20020a1709027b8ab02901097bdb0ed9mr9346603pll.73.1624111163760;
        Sat, 19 Jun 2021 06:59:23 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id n5sm8275613pgf.35.2021.06.19.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 06:59:23 -0700 (PDT)
Date:   Sat, 19 Jun 2021 19:29:20 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210619135920.h42gp5ie5c2eutfq@archlinux>
References: <20210608054857.18963-5-ameynarkhede03@gmail.com>
 <20210618200045.GA3141153@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618200045.GA3141153@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > Add reset_method sysfs attribute to enable user to
> > query and set user preferred device reset methods and
> > their ordering.
>
> Rewrap to fill 75 columns (also apply to other patches if applicable,
> e.g., 3/8 looks like it could use it).
>
> 2/8 looks like it's missing a blank line between paragraphs.
>
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  16 ++++
> >  drivers/pci/pci-sysfs.c                 | 118 ++++++++++++++++++++++++
> >  2 files changed, 134 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index ef00fada2..cf6dbbb3c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -121,6 +121,22 @@ Description:
> >  		child buses, and re-discover devices removed earlier
> >  		from this part of the device tree.
> >
> > +What:		/sys/bus/pci/devices/.../reset_method
> > +Date:		March 2021
> > +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> > +Description:
> > +		Some devices allow an individual function to be reset
> > +		without affecting other functions in the same slot.
> > +		For devices that have this support, a file named reset_method
> > +		will be present in sysfs. Reading this file will give names
> > +		of the device supported reset methods and their ordering.
> > +		Writing the name or comma separated list of names of any of
> > +		the device supported reset methods to this file will set the
> > +		reset methods and their ordering to be used when resetting
> > +		the device. Writing empty string to this file will disable
> > +		ability to reset the device and writing "default" will return
> > +		to the original value.
>
> Rewrap to fill or add a blank line if "For devices ..." is supposed to
> start a new paragraph.
>
> My guess is you intend reading to show the *currently enabled* reset
> methods, not the entire "supported" set?  So if a user has disabled
> one of them, it no longer appears when you read the file?
>
> > +
> >  What:		/sys/bus/pci/devices/.../reset
> >  Date:		July 2009
> >  Contact:	Michael S. Tsirkin <mst@redhat.com>
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 316f70c3e..52def79aa 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1334,6 +1334,123 @@ static const struct attribute_group pci_dev_rom_attr_group = {
> >  	.is_bin_visible = pci_dev_rom_attr_is_visible,
> >  };
> >
> > +static ssize_t reset_method_show(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	ssize_t len = 0;
> > +	int i, prio;
> > +
> > +	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
> > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > +			if (prio == pdev->reset_methods[i]) {
> > +				len += sysfs_emit_at(buf, len, "%s%s",
> > +						     len ? "," : "",
> > +						     pci_reset_fn_methods[i].name);
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (i == PCI_RESET_METHODS_NUM)
> > +			break;
> > +	}
>
> I'm guessing that if you adopt the alternate reset_methods[] encoding,
> this nested loop becomes a single loop and "prio" goes away?
>
> > +	if (len)
> > +		len += sysfs_emit_at(buf, len, "\n");
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t reset_method_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	u8 reset_methods[PCI_RESET_METHODS_NUM];
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	u8 prio = PCI_RESET_METHODS_NUM;
> > +	char *name, *options;
> > +	int i;
>
> Reorder decls with to_pci_dev(dev) first, then in order of use.
>
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	options = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!options)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Initialize reset_method such that 0xff indicates
> > +	 * supported but not currently enabled reset methods
> > +	 * as we only use priority values which are within
> > +	 * the range of PCI_RESET_FN_METHODS array size
> > +	 */
> > +	for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > +		reset_methods[i] = pdev->reset_methods[i] ? 0xff : 0;
>
> I'm hoping the 0xff trick goes away with the alternate encoding?
>
> > +	if (sysfs_streq(options, "")) {
> > +		pci_warn(pdev, "All device reset methods disabled by user");
> > +		goto set_reset_methods;
> > +	}
>
> I think you can get this case out of the way early with no kstrndup(),
> no goto, etc.
>
> > +	if (sysfs_streq(options, "default")) {
> > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > +		goto set_reset_methods;
> > +	}
>
> If you use pci_init_reset_methods() here, you can also get this case
> out of the way early.
>
The problem with alternate encoding is we won't be able to know if
one of the reset methods was disabled previously. For example,

# cat reset_methods
flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
# echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
# cat reset_methods
bus

Now if an user wants to enable flr

# echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
OR
# echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]

either they need to write "default" first then flr or we will need to
reprobe reset methods each time when user writes to reset_method attribute.


> > +	while ((name = strsep(&options, ",")) != NULL) {
> > +		if (sysfs_streq(name, ""))
> > +			continue;
> > +
> > +		name = strim(name);
> > +
> > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > +			if (reset_methods[i] &&
> > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > +				reset_methods[i] = prio--;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (i == PCI_RESET_METHODS_NUM) {
> > +			kfree(options);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (reset_methods[0] &&
> > +	    reset_methods[0] != PCI_RESET_METHODS_NUM)
> > +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
>
> Is there a specific reason for this warning?  Is it just telling the
> user that he might have shot himself in the foot?  Not sure that's
> necessary.
>
I think generally presence of device specific reset method means other
methods are potentially broken. Is it okay to skip this?

> > +set_reset_methods:
> > +	kfree(options);
> > +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
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
> > +						    struct attribute *a, int n)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> > +
> > +	if (!pci_reset_supported(pdev))
> > +		return 0;
>
> I think this _is_visible method is executed only once, at
> device_add()-time.  That means if a device doesn't support any resets
> at that time, "reset_method" will not be visible, and there will be no
> way to ever enable a reset method at run-time.  I assume that's OK;
> just double-checking.
>
Correct. Its similar to exisitng reset_fn bitfield which is removed in this
patch series.
[...]

Thanks,
Amey

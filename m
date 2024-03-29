Return-Path: <linux-pci+bounces-5428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D0B8926C2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41BCB22230
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9EF13E05E;
	Fri, 29 Mar 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="OS9tJmmx"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542613E3F3
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751415; cv=none; b=C6kYYkMSThHneDMLvVnRibl+4+GtZK2NSH5FLteN+hg2a67jAsGbNXAwvOIWly9fAZ5N3+n9RPa/wIEVpjxPGV/AXNK1iE72atEx7HAoH8ajo+j8KQM8mWtz5LJj4IpqDMeTL5ibwpZcVMX3R01r4qdRqWOAQA+mNRBClnSzjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751415; c=relaxed/simple;
	bh=cwaycXfA0ZAAP7U9saaOBL8fX5l7G9H9EOB6M53oEMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFES4bWkkAN6c+JuxVnjRvqxFGKpxYFMQP7pP2PTqKKi9DZ2A3bioj2aXw65m5YUIthUHBXZt3bKweVLInLvz6WIvpqupePwtUJ41lsNQE4VdSmWCAM6Nw5jXFrMlguHRMZGwtu3aGjqZKL+LGbQiCl/d9Vz4vWta2+Fil7HKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=OS9tJmmx; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id A71D0285ED2; Fri, 29 Mar 2024 23:23:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1711751002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KvNgwKQQZ3MeLhOI4nqQyuge7hEHssy9YydnzIThtk=;
	b=OS9tJmmxsFeKfKf8wi1X6fG/KXkA84NVTb25Vb47RKYBwWhpxDaobs1epLixKDVL5NvXQH
	fvKzOSdStjDnmDRwcSJTuCVsmX+4EswlQyVsBh2HxtKzcFG8F1l1aXwOKuNooYMB8M2Pkr
	Xp7WNrAU9HOM2D4JcABhs4zGSN4YkAg=
Date: Fri, 29 Mar 2024 23:23:22 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: linux-cxl@vger.kernel.org, y-goto@fujitsu.com,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Message-ID: <mj+md-20240329.221545.11188.nikam@ucw.cz>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>

Hello!

> This patch adds a function to output the link status of the CXL1.1 device
> when it is connected.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. The value of that register is outputted
> to sysfs, and based on that, displays the link status information.

> diff --git a/lib/access.c b/lib/access.c
> index 7d66123..bc75a84 100644
> --- a/lib/access.c
> +++ b/lib/access.c
[...]
> @@ -268,3 +269,31 @@ pci_get_string_property(struct pci_dev *d, u32 prop)
>  
>    return NULL;
>  }
> +
> +#define OBJNAMELEN 1024
> +#define OBJBUFSIZE 64
> +int
> +get_rcd_sysfs_obj_file(struct pci_dev *d, char *object, char *result)
> +{
> +#ifdef PCI_HAVE_PM_LINUX_SYSFS
> +  char namebuf[OBJNAMELEN];
> +  int n = snprintf(namebuf, OBJNAMELEN, "%s/devices/%04x:%02x:%02x.%d/%s",
> +		   pci_get_param(d->access, "sysfs.path"),
> +       d->domain, d->bus, d->dev, d->func, object);
> +  if (n < 0 || n >= OBJNAMELEN){
> +    d->access->error("Failed to get filename");
> +    return -1;
> +    }
> +  int fd = open(namebuf, O_RDONLY);
> +  if(fd < 0)
> +    return -1;
> +  n = read(fd, result, OBJBUFSIZE);
> +  if (n < 0 || n >= OBJBUFSIZE){
> +    d->access->error("Failed to read the file");
> +    return -1;
> +  }
> +  return 0;
> +#else
> +  return -1;
> +#endif
> +}

This really is not the right place to read from sysfs. The libpci should provide
a backend-indepenent interface for reading this information and the sysfs
back-end (lib/sysfs.c) should provide one implementation of this interface.

I think that we can easily extend pci_fill_info() and add another PCI_FILL_xxx
flag for CXL RCD properties, which will be available in struct pci_dev (beware
that new fields have to be added _after_ all public fields to keep ABI compatibility).

> @@ -1445,6 +1515,9 @@ cap_express(struct device *d, int where, int cap)
>    cap_express_dev(d, where, type);
>    if (link)
>      cap_express_link(d, where, type);
> +  else if (type == PCI_EXP_TYPE_ROOT_INT_EP)
> +    cap_express_link_rcd(d);
> +   
>    if (slot)
>      cap_express_slot(d, where);
>    if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ROOT_EC)

Does it make sense to look up CXL RCD information for all PCIe devices of type
PCI_EXP_TYPE_ROOT_INT_EP? Shouldn't it be done only for devices with the CXL
capability?

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe


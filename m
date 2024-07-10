Return-Path: <linux-pci+bounces-10073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961592D191
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79B72865D3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190EE19149E;
	Wed, 10 Jul 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwlfmMxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBB19149D
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614494; cv=none; b=jD6F93gBdNB6SHWPOHjXOieyP9JtfL4Ut9YhxeFcG5M063cUlbULGzdEo6h85NV5Lmi0SNG39u9uBMn7lCNJfjZ72zq0HE6pq1q/Cs+Iw2gwRTGcq4I2ennKdmUkLTWlvfNDWahkBUPtxTAXU7bo4z/SMiDxSeAtXs7tqvFXZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614494; c=relaxed/simple;
	bh=vCETmodMEdDHEJwZMFmoty0smE5wU/UkBqql1Zvvvfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dF9gIZpebhvN1sZaOCVQ6t72sF5AvSLJ3JXWJVA2Qdx2qJhn3b6TmEYim3HtDtFbqGmRD4G/W41Ys3/0v9VRpgues88Bnrz9vX6f8L4XMdOQxwB8KGKAvJVQjGwHzfb4RigJWfxQy+0IiQWh2dUepEKT4XzAJ/UxoHAUxaia+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwlfmMxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F38C32781;
	Wed, 10 Jul 2024 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720614493;
	bh=vCETmodMEdDHEJwZMFmoty0smE5wU/UkBqql1Zvvvfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kwlfmMxZJNZnrECmYKDnnyO+x2nj4TTZTTj4eOUAuDnOfMEaCn6KL+EFUu6wZYom/
	 GmIdKss+WZG4KD5TVAfeB8hnIBnYs48dr/o74c8V44uinc6pfq8rJQEF+4UfuxfAKj
	 8YPRREJ4XdlBlm3WBnR/3BPgofvxKeagiOTTxApdDJ/Cikm6fcHKjyTjD9pM3wG6k9
	 a2KYYe59lP3gaBMKXVBeMMM7YW7M9sU9fxBNpkpAV/KGLOfUVky+5uAtkvmx8cztdE
	 Gam4rZVq5R/g08+Am43rBYfAdW389+KOJSDSjFMKduayP24zURMh9l+DPlASD8Ohv3
	 17qTALeyIeiQg==
Date: Wed, 10 Jul 2024 07:28:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v1] Export PBEC Data register into sysfs
Message-ID: <20240710122811.GA241615@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>

Note subject line convention for drivers/pci (use "git log --oneline
drivers/pci/pci-sysfs.c")

On Wed, Jun 26, 2024 at 01:43:30PM +0900, Kobayashi,Daisuke wrote:
> This proposal aims to add a feature that outputs PCIe device power 
> consumption information to sysfs.
> 
> This feature can be implemented by adding support for PBEC (Power 
> Budgeting Extended Capability) output to the PCIe driver. PBEC is 
> defined in the PCIe specification(7.8.1) and is a standard method for
> obtaining device power consumption information.

s/This feature can be implemented by adding support/Add support/

(To change this to imperative mood and say what the patch actually
*does*, as opposed to what *could* be done.)

Include spec revision, e.g., "PCIe r6.0, sec 7.8.1"

> PCIe devices can significantly impact the overall power consumption of
> a system. However, obtaining PCIe device power consumption information 
> has traditionally been difficult. This is because the 'lspci' command, 
> which is a standard tool for displaying information about PCI devices, 
> cannot access PBEC information. `lspci` is a standard tool for displaying
> information about PCI devices.

lspci detail isn't really necessary here.  Maybe lspci *could* be
extended to display PBEC information, but that's a separate project.
It looks like the Data/Data Select issue might mean lspci would have
to get the info from the kernel, e.g., from this sysfs file, to avoid
synchronization issues.

> The PBEC Data register changes depending on the value of the PBEC Data 
> Select register. To obtain all PBEC Data register values defined in the 
> device, obtain the value of the PBEC Data register while changing the 
> value of the PBEC Data Select register.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/pci/pci-sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..b13d30da38a1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>  
> +static ssize_t pbec_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	size_t len = 0;
> +	int i, pos;
> +	u32 data;
> +
> +	if (!pci_is_pcie(pci_dev))
> +		return 0;

Unnecessary.  Already covered by pcie_dev_attrs_are_visible().

> +	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
> +	if (!pos)
> +		return 0;
> +
> +	for (i = 0; i < 0xff; i++) {
> +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
> +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
> +		if (!data)
> +			break;
> +		len += sysfs_emit_at(buf, len, "%04x\n", data);
> +	}
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(pbec);

Needs a more descriptive name, I think.  Also some documentation in
Documentation/ABI/.

>  static ssize_t max_link_speed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  	&dev_attr_current_link_width.attr,
>  	&dev_attr_max_link_width.attr,
>  	&dev_attr_max_link_speed.attr,
> +	&dev_attr_pbec.attr,
>  	NULL,
>  };
>  
> -- 
> 2.44.0
> 


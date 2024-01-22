Return-Path: <linux-pci+bounces-2449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA148377C6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 00:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615AF1F244C3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591224E1A0;
	Mon, 22 Jan 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwICVcvb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDA3984A;
	Mon, 22 Jan 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966654; cv=none; b=mz970picJTHYMjVf4WWpwppdK6EOky+HNxDw1uVi1pJXBwXK/8sq9Xi3eNHCXTAjguJbax16l4v+5vQW7aNB9nf4W0bZxZWxYTuVIU8C0+oJC5nw21p/QKNjGXe1FErv5yU6spUdQxdMao0gC6edH8WXvRPS/pB2drdHeJ/6r8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966654; c=relaxed/simple;
	bh=bFI9taIrnXtbiXPEufAdPBtLCLiLu4UVHc3GG4nClhw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S8cw2/zMnfohoMyFdn5tUUQCGzxNKWlMu1yTy37Ir83CWSz24ujcq42+9m+pIhmoURowwmUFuIlKHGcoxqo+IkigqtPMLo/Vgri1oPKMZZOHGietzRbgpJKzLEvdy93j/tPKyiUzBtn/GR3sP5db554S+8ZWzPq01JnNxuuzvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwICVcvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57147C43394;
	Mon, 22 Jan 2024 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705966653;
	bh=bFI9taIrnXtbiXPEufAdPBtLCLiLu4UVHc3GG4nClhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OwICVcvbQxSLC8jasEM24VJKS3vTz+1LDb+FcmZZDLCW7bpfPqjxs0dEHl4ACIFjn
	 YcnhQuWeJ/IJc/q28szM0TWGQ2E3A4jDGh0jegpsrwaXzNjlLY5EmlP3VhwQt5djZ8
	 dvYklSc8kUb/da5OKZgd/+PCthhVLxNI17WlTaUY+1ed1duP4ZsD+t6TNvaHa+Q6Yd
	 hWr+An7oFQQaV3KzfoIrZ2Xq9oh/FzyCS20dGjuQe0/x/KbqjnqYo+10pPWqvmrG2U
	 81dQwoBE36+Ox3tW3E4UlIrVQ7fohxhRc+OO/N1D6fwteHL8r16J3lcy3OXjEp8PJx
	 o2wSyCnzhnk/A==
Date: Mon, 22 Jan 2024 17:37:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
	Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <20240122233731.GA291870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105062217.349645-4-Jiqian.Chen@amd.com>

On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> There is a need for some scenarios to use gsi sysfs.
> For example, when xen passthrough a device to dumU, it will
> use gsi to map pirq, but currently userspace can't get gsi
> number.
> So, add gsi sysfs for that and for other potential scenarios.

Isn't GSI really an ACPI-specific concept?

I don't know enough about Xen to know why it needs the GSI in
userspace.  Is this passthrough brand new functionality that can't be
done today because we don't expose the GSI yet?

How does userspace use the GSI?  I see "to map pirq", but I think we
should have more concrete details about exactly what is needed and how
it is used before adding something new in sysfs.

Is there some more generic kernel interface we could use
for this?

s/dumU/DomU/ ?  (I dunno, but https://www.google.com/search?q=xen+dumu
suggests it :))

> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  drivers/acpi/pci_irq.c  |  1 +
>  drivers/pci/pci-sysfs.c | 11 +++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 630fe0a34bc6..739a58755df2 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  		kfree(entry);
>  		return 0;
>  	}
> +	dev->gsi = gsi;
>  
>  	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
>  	if (rc < 0) {
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..c51df88d079e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -71,6 +71,16 @@ static ssize_t irq_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(irq);
>  
> +static ssize_t gsi_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sysfs_emit(buf, "%u\n", pdev->gsi);
> +}
> +static DEVICE_ATTR_RO(gsi);
> +
>  static ssize_t broken_parity_status_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -596,6 +606,7 @@ static struct attribute *pci_dev_attrs[] = {
>  	&dev_attr_revision.attr,
>  	&dev_attr_class.attr,
>  	&dev_attr_irq.attr,
> +	&dev_attr_gsi.attr,
>  	&dev_attr_local_cpus.attr,
>  	&dev_attr_local_cpulist.attr,
>  	&dev_attr_modalias.attr,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index dea043bc1e38..0618d4a87a50 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -529,6 +529,8 @@ struct pci_dev {
>  
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> +
> +	unsigned int	gsi;
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> -- 
> 2.34.1
> 
> 


Return-Path: <linux-pci+bounces-7542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9D8C6EB8
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 00:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FB6284AFA
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC43FB1B;
	Wed, 15 May 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u24GfXM+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9E2A8D7;
	Wed, 15 May 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715812983; cv=none; b=kDMWLZBLoc26pgEZNw01UmVYQjsBvygApwNdOM3s75IhfzP1UqJBnUsIhoTaDNAu/8Rj99+z5NXlnucqvphTFy4aqMMhFeWMNoB6Wh3w93mB+r7eqjdw4qPy2yu5HT+kytwVxgifsP1ZVajEK2Qor/mBVQh7OzCN4LcaqeGv7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715812983; c=relaxed/simple;
	bh=3B2QPX/ga/0AMCH1IWm6CBpgkx7uEqSubo5omjdhkDk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jgbp6HAEzZcF7fG46BlXlgoQUf9hMYbdoIEiuVDQc139M40kUfeFKlXZf1VMCXSPwaVLLtovvDHnGBoFuZiymOdew1Um1FT8SCqp+6jCqTcB1XLRg2sKPGQ/X0gnAZDEQ+Xfg5lHfqR7QWoHRWXBlY2q1886+m/jw9g7wxXqZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u24GfXM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AB4C116B1;
	Wed, 15 May 2024 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715812983;
	bh=3B2QPX/ga/0AMCH1IWm6CBpgkx7uEqSubo5omjdhkDk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=u24GfXM+55qXQfRDSHTj7tOt/UBYWn8d03ITH9yqoUOUz0DE9ym3wps5ouvjLqkD8
	 a1Yo1fBSyHCnYd7/XXMFHpIEPBIlWziMzzM617W3iH/CCwKUbob/SfKDQQFBCqO+I5
	 cSJWq9JMkxCPG2hywt13urQRLcmrXjnr3+trK26+x7qCWykCHZ7DonYu1hNcxrGY5N
	 LeewcLRKzPkQ2dRgR1wnQn16N4UnhjQowcp7q9e7ariyXbSrCx8sXBgnvGYt5vdlzW
	 qGUA4tymb2FEjFyBe28qFtit/JYt+Ib2P9ldeKMU/6Tj02VYyi33wFsIzhcqI7c4wD
	 sgEZAyaSOmU4A==
Date: Wed, 15 May 2024 15:42:59 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jiqian Chen <Jiqian.Chen@amd.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
    xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
    Huang Rui <Ray.Huang@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v7 2/2] xen/privcmd: Add new syscall to get
 gsi from dev
In-Reply-To: <20240515065011.13797-3-Jiqian.Chen@amd.com>
Message-ID: <alpine.DEB.2.22.394.2405151537430.2544314@ubuntu-linux-20-04-desktop>
References: <20240515065011.13797-1-Jiqian.Chen@amd.com> <20240515065011.13797-3-Jiqian.Chen@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 May 2024, Jiqian Chen wrote:
> In PVH dom0, it uses the linux local interrupt mechanism,
> when it allocs irq for a gsi, it is dynamic, and follow
> the principle of applying first, distributing first. And
> the irq number is alloced from small to large, but the
> applying gsi number is not, may gsi 38 comes before gsi 28,
> it causes the irq number is not equal with the gsi number.
> And when passthrough a device, QEMU will use device's gsi
> number to do pirq mapping, but the gsi number is got from
> file /sys/bus/pci/devices/<sbdf>/irq, irq!= gsi, so it will
> fail when mapping.
> And in current linux codes, there is no method to get gsi
> for userspace.
> 
> For above purpose, record gsi of pcistub devices when init
> pcistub and add a new syscall into privcmd to let userspace
> can get gsi when they have a need.
> 
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  drivers/xen/privcmd.c              | 28 ++++++++++++++++++++++
>  drivers/xen/xen-pciback/pci_stub.c | 38 +++++++++++++++++++++++++++---
>  include/uapi/xen/privcmd.h         |  7 ++++++
>  include/xen/acpi.h                 |  2 ++
>  4 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 67dfa4778864..5953a03b5cb0 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -45,6 +45,9 @@
>  #include <xen/page.h>
>  #include <xen/xen-ops.h>
>  #include <xen/balloon.h>
> +#ifdef CONFIG_ACPI
> +#include <xen/acpi.h>
> +#endif
>  
>  #include "privcmd.h"
>  
> @@ -842,6 +845,27 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
>  	return rc;
>  }
>  
> +static long privcmd_ioctl_gsi_from_dev(struct file *file, void __user *udata)
> +{
> +	struct privcmd_gsi_from_dev kdata;
> +
> +	if (copy_from_user(&kdata, udata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +#ifdef CONFIG_ACPI
> +	kdata.gsi = pcistub_get_gsi_from_sbdf(kdata.sbdf);
> +	if (kdata.gsi == -1)
> +		return -EINVAL;
> +#else
> +	kdata.gsi = -1;

Should we return an error instead, like -EINVAL, to make the behavior
more similar to the CONFIG_ACPI case?


> +#endif
> +
> +	if (copy_to_user(udata, &kdata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_XEN_PRIVCMD_EVENTFD
>  /* Irqfd support */
>  static struct workqueue_struct *irqfd_cleanup_wq;
> @@ -1529,6 +1553,10 @@ static long privcmd_ioctl(struct file *file,
>  		ret = privcmd_ioctl_ioeventfd(file, udata);
>  		break;
>  
> +	case IOCTL_PRIVCMD_GSI_FROM_DEV:
> +		ret = privcmd_ioctl_gsi_from_dev(file, udata);
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 2b90d832d0a7..4b62b4d377a9 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -56,6 +56,9 @@ struct pcistub_device {
>  
>  	struct pci_dev *dev;
>  	struct xen_pcibk_device *pdev;/* non-NULL if struct pci_dev is in use */
> +#ifdef CONFIG_ACPI
> +	int gsi;
> +#endif
>  };
>  
>  /* Access to pcistub_devices & seized_devices lists and the initialize_devices
> @@ -88,6 +91,9 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
>  
>  	kref_init(&psdev->kref);
>  	spin_lock_init(&psdev->lock);
> +#ifdef CONFIG_ACPI
> +	psdev->gsi = -1;
> +#endif
>  
>  	return psdev;
>  }
> @@ -220,6 +226,25 @@ static struct pci_dev *pcistub_device_get_pci_dev(struct xen_pcibk_device *pdev,
>  	return pci_dev;
>  }
>  
> +#ifdef CONFIG_ACPI
> +int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
> +{
> +	struct pcistub_device *psdev;
> +	int domain = sbdf >> 16;
> +	int bus = (sbdf >> 8) & 0xff;
> +	int slot = (sbdf >> 3) & 0x1f;
> +	int func = sbdf & 0x7;

you can use PCI_DEVFN PCI_SLOT PCI_FUNC pci_domain_nr instead of open
coding.


> +
> +	psdev = pcistub_device_find(domain, bus, slot, func);
> +
> +	if (!psdev)
> +		return -1;
> +
> +	return psdev->gsi;
> +}
> +EXPORT_SYMBOL_GPL(pcistub_get_gsi_from_sbdf);
> +#endif
> +
>  struct pci_dev *pcistub_get_pci_dev_by_slot(struct xen_pcibk_device *pdev,
>  					    int domain, int bus,
>  					    int slot, int func)
> @@ -367,14 +392,20 @@ static int pcistub_match(struct pci_dev *dev)
>  	return found;
>  }
>  
> -static int pcistub_init_device(struct pci_dev *dev)
> +static int pcistub_init_device(struct pcistub_device *psdev)
>  {
>  	struct xen_pcibk_dev_data *dev_data;
> +	struct pci_dev *dev;
>  #ifdef CONFIG_ACPI
>  	int gsi, trigger, polarity;
>  #endif
>  	int err = 0;
>  
> +	if (!psdev)
> +		return -EINVAL;
> +
> +	dev = psdev->dev;
> +
>  	dev_dbg(&dev->dev, "initializing...\n");
>  
>  	/* The PCI backend is not intended to be a module (or to work with
> @@ -448,6 +479,7 @@ static int pcistub_init_device(struct pci_dev *dev)
>  		dev_err(&dev->dev, "Fail to get gsi info!\n");
>  		goto config_release;
>  	}
> +	psdev->gsi = gsi;
>  
>  	if (xen_initial_domain() && xen_pvh_domain()) {
>  		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
> @@ -495,7 +527,7 @@ static int __init pcistub_init_devices_late(void)
>  
>  		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
>  
> -		err = pcistub_init_device(psdev->dev);
> +		err = pcistub_init_device(psdev);
>  		if (err) {
>  			dev_err(&psdev->dev->dev,
>  				"error %d initializing device\n", err);
> @@ -565,7 +597,7 @@ static int pcistub_seize(struct pci_dev *dev,
>  		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
>  
>  		/* don't want irqs disabled when calling pcistub_init_device */
> -		err = pcistub_init_device(psdev->dev);
> +		err = pcistub_init_device(psdev);
>  
>  		spin_lock_irqsave(&pcistub_devices_lock, flags);
>  
> diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
> index 8b8c5d1420fe..220e7670a113 100644
> --- a/include/uapi/xen/privcmd.h
> +++ b/include/uapi/xen/privcmd.h
> @@ -126,6 +126,11 @@ struct privcmd_ioeventfd {
>  	__u8 pad[2];
>  };
>  
> +struct privcmd_gsi_from_dev {
> +	__u32 sbdf;
> +	int gsi;
> +};
> +
>  /*
>   * @cmd: IOCTL_PRIVCMD_HYPERCALL
>   * @arg: &privcmd_hypercall_t
> @@ -157,5 +162,7 @@ struct privcmd_ioeventfd {
>  	_IOW('P', 8, struct privcmd_irqfd)
>  #define IOCTL_PRIVCMD_IOEVENTFD					\
>  	_IOW('P', 9, struct privcmd_ioeventfd)
> +#define IOCTL_PRIVCMD_GSI_FROM_DEV				\
> +	_IOC(_IOC_NONE, 'P', 10, sizeof(struct privcmd_gsi_from_dev))
>  
>  #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
> diff --git a/include/xen/acpi.h b/include/xen/acpi.h
> index 9b50027113f3..0bf5f4884456 100644
> --- a/include/xen/acpi.h
> +++ b/include/xen/acpi.h
> @@ -83,4 +83,6 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  						  int *gsi_out,
>  						  int *trigger_out,
>  						  int *polarity_out);
> +
> +int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
>  #endif	/* _XEN_ACPI_H */
> -- 
> 2.34.1
> 


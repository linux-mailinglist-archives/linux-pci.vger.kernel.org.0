Return-Path: <linux-pci+bounces-13287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F397C1F0
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 00:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE9283B6E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730A1CB300;
	Wed, 18 Sep 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzZSG7rb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF6178CF6;
	Wed, 18 Sep 2024 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726699748; cv=none; b=U6vSbkOj8P8325kpWK5jOl6esJlfPuwnHx2UjJr3FsA5EA/FTceWOlHPSJdjJesPqURSD0K5h5wDuDWYpMnt2zRRJQaTwvttBN9ej1xUXEfBeW43ZGMJLNaWIhhPvPhb9kvHdtxTtnV0icxeT0hxTHkLaU5hzfWLxwmnX00tKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726699748; c=relaxed/simple;
	bh=EescuExRYeQnLOB8teX05hRRk6mAd/XsRJvQhRYTdKw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OhLqsi9mhDR0haHm9vjkq4PcUydpz642xGsA1FNVYOVwTZ9OBH5jUd1O6iEZWiIXTDsNRRzCU0lRcmJN4LST373QDCIWTyAZMmvNzQvE0B+BD11xDSrsrfm2Zn+eyb8lghkyUjZsWE/JtbMv4hd93LMoAUdg/tb8PsqAuU0EOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzZSG7rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B557C4CEC2;
	Wed, 18 Sep 2024 22:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726699747;
	bh=EescuExRYeQnLOB8teX05hRRk6mAd/XsRJvQhRYTdKw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MzZSG7rbfe5bLhkOAJ2/+E5WO5Z3/dcyrwBl/LjU68XsM+ADZkmsH5VB6DTZAU4eU
	 1O5l2vmicBqwvOfLIBsGGcyJOlDEuO9hh5swyIQnfst/+8VkITAueKiUcJfeYnu/u0
	 lCCcBe2MZLzLsEf9/JC+qUbTSoXLJQt4i5Dotzcak4moBdHzIzoipUvRadx1vWXA8R
	 WAR2A80bMAhWRXAxu2o+lOMHjghOktLWdTwSXfwsw+ydOW0RXKkjJVBlfS2OtUgGlq
	 AZIxF32pwQHGHEQDFuW4A83hLx9YP0qccXdLrzNnWEMMETec/F4j6Gy93ujSflLi/N
	 jm3oCysPKjuKQ==
Date: Wed, 18 Sep 2024 15:49:04 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jiqian Chen <Jiqian.Chen@amd.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, xen-devel@lists.xenproject.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-acpi@vger.kernel.org, Huang Rui <ray.huang@amd.com>
Subject: Re: [KERNEL PATCH v9 3/3] xen/privcmd: Add new syscall to get gsi
 from dev
In-Reply-To: <20240912092352.1602724-4-Jiqian.Chen@amd.com>
Message-ID: <alpine.DEB.2.22.394.2409181522080.1417852@ubuntu-linux-20-04-desktop>
References: <20240912092352.1602724-1-Jiqian.Chen@amd.com> <20240912092352.1602724-4-Jiqian.Chen@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Sep 2024, Jiqian Chen wrote:
> On PVH dom0, when passthrough a device to domU, QEMU and xl tools
> want to use gsi number to do pirq mapping, see QEMU code
> xen_pt_realize->xc_physdev_map_pirq, and xl code
> pci_add_dm_done->xc_physdev_map_pirq, but in current codes, the gsi
> number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
> wrong, because irq is not equal with gsi, they are in different
> spaces, so pirq mapping fails.
> And in current linux codes, there is no method to get gsi
> for userspace.
> 
> For above purpose, record gsi of pcistub devices when init
> pcistub and add a new syscall into privcmd to let userspace
> can get gsi when they have a need.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v8->v9 changes:
> Changed the syscall name from "IOCTL_PRIVCMD_GSI_FROM_DEV" to "IOCTL_PRIVCMD_PCIDEV_GET_GSI". Also changed the other functions name.
> Changed the macro wrapping "pcistub_get_gsi_from_sbdf" from "CONFIG_XEN_ACPI" to "CONFIG_XEN_PCIDEV_BACKEND" to fix compile errors reported by CI robot.
> Changed the parameter gsi of struct privcmd_pcidev_get_gsi from int to u32.
> 
> v7->v8 changes:
> In function privcmd_ioctl_gsi_from_dev, return -EINVAL when not confige CONFIG_XEN_ACPI.
> Used PCI_BUS_NUM PCI_SLOT PCI_FUNC instead of open coding.
> 
> v6->v7 changes:
> Changed implementation to add a new parameter "gsi" to struct pcistub_device and set gsi when pcistub initialize device. Then when userspace wants to get gsi and pass sbdf, we can return that gsi.
> 
> v5->v6 changes:
> Changed implementation to add a new syscall to translate irq to gsi, instead adding a new gsi sysfs node, because the pci Maintainer didn't allow to add that sysfs node.
> 
> v3->v5 changes:
> No.
> 
> v2->v3 changes:
> Suggested by Roger: Abandoned previous implementations that added new syscall to get gsi from irq and changed to add a new sysfs node for gsi, then userspace can get gsi number from sysfs node.
> ---
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406090826.whl6Cb7R-lkp@intel.com/
> ---
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405171113.T431PC8O-lkp@intel.com/
> ---
>  drivers/xen/privcmd.c              | 30 +++++++++++++++++++++++
>  drivers/xen/xen-pciback/pci_stub.c | 38 +++++++++++++++++++++++++++---
>  include/uapi/xen/privcmd.h         |  7 ++++++
>  include/xen/acpi.h                 |  9 +++++++
>  4 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 9563650dfbaf..1ed612d21543 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -46,6 +46,9 @@
>  #include <xen/page.h>
>  #include <xen/xen-ops.h>
>  #include <xen/balloon.h>
> +#ifdef CONFIG_XEN_ACPI
> +#include <xen/acpi.h>
> +#endif
>  
>  #include "privcmd.h"
>  
> @@ -844,6 +847,29 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
>  	return rc;
>  }
>  
> +static long privcmd_ioctl_pcidev_get_gsi(struct file *file, void __user *udata)
> +{
> +#ifdef CONFIG_XEN_ACPI
> +	int rc;
> +	struct privcmd_pcidev_get_gsi kdata;
> +
> +	if (copy_from_user(&kdata, udata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	rc = pcistub_get_gsi_from_sbdf(kdata.sbdf);
> +	if (rc < 0)
> +		return rc;
> +
> +	kdata.gsi = rc;
> +	if (copy_to_user(udata, &kdata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	return 0;
> +#else
> +	return -EINVAL;
> +#endif
> +}
> +
>  #ifdef CONFIG_XEN_PRIVCMD_EVENTFD
>  /* Irqfd support */
>  static struct workqueue_struct *irqfd_cleanup_wq;
> @@ -1543,6 +1569,10 @@ static long privcmd_ioctl(struct file *file,
>  		ret = privcmd_ioctl_ioeventfd(file, udata);
>  		break;
>  
> +	case IOCTL_PRIVCMD_PCIDEV_GET_GSI:
> +		ret = privcmd_ioctl_pcidev_get_gsi(file, udata);
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 8ce27333f54b..2ea8e4075adc 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -56,6 +56,9 @@ struct pcistub_device {
>  
>  	struct pci_dev *dev;
>  	struct xen_pcibk_device *pdev;/* non-NULL if struct pci_dev is in use */
> +#ifdef CONFIG_XEN_ACPI
> +	int gsi;
> +#endif
>  };
>  
>  /* Access to pcistub_devices & seized_devices lists and the initialize_devices
> @@ -88,6 +91,9 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
>  
>  	kref_init(&psdev->kref);
>  	spin_lock_init(&psdev->lock);
> +#ifdef CONFIG_XEN_ACPI
> +	psdev->gsi = -1;
> +#endif
>  
>  	return psdev;
>  }
> @@ -220,6 +226,25 @@ static struct pci_dev *pcistub_device_get_pci_dev(struct xen_pcibk_device *pdev,
>  	return pci_dev;
>  }
>  
> +#ifdef CONFIG_XEN_PCIDEV_BACKEND


This breaks configurations without CONFIG_ACPI and with
CONFIG_XEN_PCIDEV_BACKEND.

Also there should be no dependency between PCIDEV_BACKEND and
pcistub_get_gsi_from_sbdf.

I think we should solve the build issues this way:

- privcmd_ioctl_pcidev_get_gsi should have:
#if defined(CONFIG_XEN_ACPI) && defined(CONFIG_XEN_PCI_STUB)

- here we should have #ifdef CONFIG_XEN_ACPI as you had before


As far as I can tell the above should be able to address all valid
combinations.



> +int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
> +{
> +	struct pcistub_device *psdev;
> +	int domain = (sbdf >> 16) & 0xffff;
> +	int bus = PCI_BUS_NUM(sbdf);
> +	int slot = PCI_SLOT(sbdf);
> +	int func = PCI_FUNC(sbdf);
> +
> +	psdev = pcistub_device_find(domain, bus, slot, func);
> +
> +	if (!psdev)
> +		return -ENODEV;
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
>  #ifdef CONFIG_XEN_ACPI
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
> @@ -452,6 +483,7 @@ static int pcistub_init_device(struct pci_dev *dev)
>  		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
>  		if (err)
>  			goto config_release;
> +		psdev->gsi = gsi;
>  	}
>  #endif
>  
> @@ -494,7 +526,7 @@ static int __init pcistub_init_devices_late(void)
>  
>  		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
>  
> -		err = pcistub_init_device(psdev->dev);
> +		err = pcistub_init_device(psdev);
>  		if (err) {
>  			dev_err(&psdev->dev->dev,
>  				"error %d initializing device\n", err);
> @@ -564,7 +596,7 @@ static int pcistub_seize(struct pci_dev *dev,
>  		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
>  
>  		/* don't want irqs disabled when calling pcistub_init_device */
> -		err = pcistub_init_device(psdev->dev);
> +		err = pcistub_init_device(psdev);
>  
>  		spin_lock_irqsave(&pcistub_devices_lock, flags);
>  
> diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
> index 8b8c5d1420fe..8e2c8fd44764 100644
> --- a/include/uapi/xen/privcmd.h
> +++ b/include/uapi/xen/privcmd.h
> @@ -126,6 +126,11 @@ struct privcmd_ioeventfd {
>  	__u8 pad[2];
>  };
>  
> +struct privcmd_pcidev_get_gsi {
> +	__u32 sbdf;
> +	__u32 gsi;
> +};
> +
>  /*
>   * @cmd: IOCTL_PRIVCMD_HYPERCALL
>   * @arg: &privcmd_hypercall_t
> @@ -157,5 +162,7 @@ struct privcmd_ioeventfd {
>  	_IOW('P', 8, struct privcmd_irqfd)
>  #define IOCTL_PRIVCMD_IOEVENTFD					\
>  	_IOW('P', 9, struct privcmd_ioeventfd)
> +#define IOCTL_PRIVCMD_PCIDEV_GET_GSI				\
> +	_IOC(_IOC_NONE, 'P', 10, sizeof(struct privcmd_pcidev_get_gsi))
>  
>  #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
> diff --git a/include/xen/acpi.h b/include/xen/acpi.h
> index 3bcfe82d9078..393a73bfda24 100644
> --- a/include/xen/acpi.h
> +++ b/include/xen/acpi.h
> @@ -91,4 +91,13 @@ static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  }
>  #endif
>  
> +#ifdef CONFIG_XEN_PCIDEV_BACKEND
> +int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
> +#else
> +static inline int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
> +{
> +	return -1;
> +}
> +#endif
> +
>  #endif	/* _XEN_ACPI_H */
> -- 
> 2.34.1
> 


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8845FE82
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 13:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbhK0MY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 07:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350336AbhK0MW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 07:22:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304BBC061759;
        Sat, 27 Nov 2021 04:19:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7028B817AC;
        Sat, 27 Nov 2021 12:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7ABC53FD0;
        Sat, 27 Nov 2021 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638015550;
        bh=v6cCbFsUaTs35lV3J39VrlxzpN4Ut/NUM1MEfSTMplw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZtbtKGAnoVlLX4tE4ModMhO06m1PHZQCuTu75qa0IoSGHjtUpUPMjqaEfk+adnz4
         JTmJ0MCn3KBX0gZ6cjmArspA8IUAJa2u+MlWUnA89pSiRO7N8HzL1Jw6tts/GS5Zsn
         Z0XMvgJcTXvYsK4PuDxRpQsJvTT78N0AIoq6TjQo=
Date:   Sat, 27 Nov 2021 13:19:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
Message-ID: <YaIiPISLr7VokL8P@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232734.708730446@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

No changelog?

Anyway, why do we care about the number of decriptors?


> ---
>  include/linux/msi.h |    3 +++
>  kernel/irq/msi.c    |   18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -156,6 +156,7 @@ enum msi_desc_filter {
>   * msi_device_data - MSI per device data
>   * @lock:		Spinlock to protect register access
>   * @properties:		MSI properties which are interesting to drivers
> + * @num_descs:		The number of allocated MSI descriptors for the device
>   * @attrs:		Pointer to the sysfs attribute group
>   * @platform_data:	Platform-MSI specific data
>   * @list:		List of MSI descriptors associated to the device
> @@ -166,6 +167,7 @@ enum msi_desc_filter {
>  struct msi_device_data {
>  	raw_spinlock_t			lock;
>  	unsigned long			properties;
> +	unsigned int			num_descs;
>  	const struct attribute_group    **attrs;
>  	struct platform_msi_priv_data	*platform_data;
>  	struct list_head		list;
> @@ -208,6 +210,7 @@ static inline unsigned int msi_get_virq(
>  
>  void msi_lock_descs(struct device *dev);
>  void msi_unlock_descs(struct device *dev);
> +unsigned int msi_device_num_descs(struct device *dev);
>  
>  struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
>  struct msi_desc *msi_next_desc(struct device *dev);
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -82,6 +82,7 @@ int msi_add_msi_desc(struct device *dev,
>  	desc->pci = init_desc->pci;
>  
>  	list_add_tail(&desc->list, &dev->msi.data->list);
> +	dev->msi.data->num_descs++;
>  	return 0;
>  }
>  
> @@ -109,6 +110,7 @@ int msi_add_simple_msi_descs(struct devi
>  		list_add_tail(&desc->list, &list);
>  	}
>  	list_splice_tail(&list, &dev->msi.data->list);
> +	dev->msi.data->num_descs += ndesc;
>  	return 0;
>  
>  fail:
> @@ -142,6 +144,7 @@ void msi_free_msi_descs_range(struct dev
>  			continue;
>  		list_del(&desc->list);
>  		free_msi_entry(desc);
> +		dev->msi.data->num_descs--;
>  	}
>  }
>  
> @@ -157,6 +160,21 @@ bool msi_device_has_property(struct devi
>  	return !!(dev->msi.data->properties & prop);
>  }
>  
> +/**
> + * msi_device_num_descs - Query the number of allocated MSI descriptors of a device
> + * @dev:	The device to read from
> + *
> + * Note: This is a lockless snapshot of msi_device_data::num_descs
> + *
> + * Returns the number of MSI descriptors which are allocated for @dev
> + */
> +unsigned int msi_device_num_descs(struct device *dev)
> +{
> +	if (dev->msi.data)
> +		return dev->msi.data->num_descs;

As this number can change after it is read, what will callers do with
it?

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6092607F2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 03:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgIHBN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 21:13:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbgIHBN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 21:13:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FC5753C85791B4F4BF2;
        Tue,  8 Sep 2020 09:13:54 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 09:13:45 +0800
Subject: Re: [PATCH] PCI: Fix race condition between block_cfg_access and
 msi_enabled/msix_enabled
To:     <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1599476765-47123-1-git-send-email-yangyicong@hisilicon.com>
CC:     <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <637a6bc5-3d97-b5b5-c9c7-2c75a4867965@hisilicon.com>
Date:   Tue, 8 Sep 2020 09:13:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1599476765-47123-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+cc linux-pci as I forgot.


On 2020/9/7 19:06, Yicong Yang wrote:
> Previously we use bit field for block_cfg_access and
> msi_enabled/msix_enabled, which is non-atomic and they may race
> each other as they share the same memory region. A race condition
> is met between driver bind vs FLR through sysfs:
>
> for driver bind side in thread 1:
> ...
> device_lock()
> ...
>   ->probe()
>     pci_alloc_irq_vectors_affinity()
>       __pci_enable_msi_range()
>         msi_capability_init()
>           dev->msi_enabled=1 <---set here
>     request_irq(pci_irq_vector(),...)
>
> when echo 1 > reset in thread 2:
> pci_reset_function()
>   pci_dev_lock()
>     pci_cfg_access_lock()
>       dev->block_cfg_access=1 <---may overwrite msi_enabled bit
>     device_lock()
>
> The msi_enabled bit may be overwritten to 0 and will trigger the WARN
> assert in pci_irq_vector(). A similar issue has been addressed in
> commit 44bda4b7d26e ("PCI: Fix is_added/is_busmaster race condition").
>
> Move the block_cfg_access to the pci_dev->priv_flags and use atomic
> bit operations to avoid the race condition.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/access.c | 20 ++++++++++----------
>  drivers/pci/pci.h    | 11 +++++++++++
>  include/linux/pci.h  |  1 -
>  3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 4693569..5826962 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -208,9 +208,9 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  {
>  	do {
>  		raw_spin_unlock_irq(&pci_lock);
> -		wait_event(pci_cfg_wait, !dev->block_cfg_access);
> +		wait_event(pci_cfg_wait, !pci_dev_is_cfg_access_blocked(dev));
>  		raw_spin_lock_irq(&pci_lock);
> -	} while (dev->block_cfg_access);
> +	} while (pci_dev_is_cfg_access_blocked(dev));
>  }
>  
>  /* Returns 0 on success, negative values indicate error. */
> @@ -223,7 +223,7 @@ int pci_user_read_config_##size						\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
>  	raw_spin_lock_irq(&pci_lock);				\
> -	if (unlikely(dev->block_cfg_access))				\
> +	if (unlikely(pci_dev_is_cfg_access_blocked(dev)))				\
>  		pci_wait_cfg(dev);					\
>  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
>  					pos, sizeof(type), &data);	\
> @@ -242,7 +242,7 @@ int pci_user_write_config_##size					\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
>  	raw_spin_lock_irq(&pci_lock);				\
> -	if (unlikely(dev->block_cfg_access))				\
> +	if (unlikely(pci_dev_is_cfg_access_blocked(dev)))				\
>  		pci_wait_cfg(dev);					\
>  	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
>  					pos, sizeof(type), val);	\
> @@ -271,9 +271,9 @@ void pci_cfg_access_lock(struct pci_dev *dev)
>  	might_sleep();
>  
>  	raw_spin_lock_irq(&pci_lock);
> -	if (dev->block_cfg_access)
> +	if (pci_dev_is_cfg_access_blocked(dev))
>  		pci_wait_cfg(dev);
> -	dev->block_cfg_access = 1;
> +	pci_dev_block_cfg_access(dev, true);
>  	raw_spin_unlock_irq(&pci_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_lock);
> @@ -292,10 +292,10 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
>  	bool locked = true;
>  
>  	raw_spin_lock_irqsave(&pci_lock, flags);
> -	if (dev->block_cfg_access)
> +	if (pci_dev_is_cfg_access_blocked(dev))
>  		locked = false;
>  	else
> -		dev->block_cfg_access = 1;
> +		pci_dev_block_cfg_access(dev, true);
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	return locked;
> @@ -318,9 +318,9 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	 * This indicates a problem in the caller, but we don't need
>  	 * to kill them, unlike a double-block above.
>  	 */
> -	WARN_ON(!dev->block_cfg_access);
> +	WARN_ON(!pci_dev_is_cfg_access_blocked(dev));
>  
> -	dev->block_cfg_access = 0;
> +	pci_dev_block_cfg_access(dev, false);
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	wake_up_all(&pci_cfg_wait);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 73740dd..1cf3122 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -410,6 +410,7 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  
>  /* pci_dev priv_flags */
>  #define PCI_DEV_ADDED 0
> +#define PCI_DEV_BLOCK_CFG_ACCESS 1	/* Config space access blocked */
>  
>  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>  {
> @@ -421,6 +422,16 @@ static inline bool pci_dev_is_added(const struct pci_dev *dev)
>  	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
>  }
>  
> +static inline void pci_dev_block_cfg_access(struct pci_dev *dev, bool block)
> +{
> +	assign_bit(PCI_DEV_BLOCK_CFG_ACCESS, &dev->priv_flags, block);
> +}
> +
> +static inline bool pci_dev_is_cfg_access_blocked(struct pci_dev *dev)
> +{
> +	return test_bit(PCI_DEV_BLOCK_CFG_ACCESS, &dev->priv_flags);
> +}
> +
>  #ifdef CONFIG_PCIEAER
>  #include <linux/aer.h>
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8355306..4ffb588 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -406,7 +406,6 @@ struct pci_dev {
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
>  	unsigned int	no_msi:1;		/* May not use MSI */
>  	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
> -	unsigned int	block_cfg_access:1;	/* Config space access blocked */
>  	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
>  	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
>  	unsigned int	msi_enabled:1;


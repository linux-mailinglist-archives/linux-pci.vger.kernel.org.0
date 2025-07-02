Return-Path: <linux-pci+bounces-31269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62045AF5A7E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CB1486A2D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE129286409;
	Wed,  2 Jul 2025 14:06:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0D283FD6;
	Wed,  2 Jul 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465192; cv=none; b=ed8XdHsjphd3+yX72KlpjTAOPlFgbLDg2/5exCQcWOHg7U77BK60pKang/GA48sztCvMk8EDj0K100wORNjSrcIpgNACxNab4Lh+Lp04U8adwHSu2FISd+A4TUvNhvQyndCeF/uCiZyY5U6TbcJd4ldCbZn89zXY9DbgEl7Y5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465192; c=relaxed/simple;
	bh=rXyo8ORdVakXK3X9Qi3/z2DRpIcRtRQbRD9iDzu8h4o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7D/OVimjLVYEr/wlRDUPDzZEeTQEp12jQz5ki/NckLMpDQPTs32XCWwy3uewgKxvOIlZkLCfXAUg28bCwZ6seDMeb0PgmhTth7yIZ//GiZ6fhEImTxWhkprNZTZdjUD5gU8JCDKKpxftNnzgL1e4WhNrA0scnv3AE+FJqKvtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXMBK1glKz6L5vy;
	Wed,  2 Jul 2025 22:06:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 42615140446;
	Wed,  2 Jul 2025 22:06:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 16:06:26 +0200
Date: Wed, 2 Jul 2025 15:06:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Sascha
 Bischoff" <sascha.bischoff@arm.com>, Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 28/31] irqchip/gic-v5: Add GICv5 ITS support
Message-ID: <20250702150624.00007ceb@huawei.com>
In-Reply-To: <20250626-gicv5-host-v6-28-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
	<20250626-gicv5-host-v6-28-48e046af4642@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 12:26:19 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> The GICv5 architecture implements Interrupt Translation Service
> (ITS) components in order to translate events coming from peripherals
> into interrupt events delivered to the connected IRSes.
> 
> Events (ie MSI memory writes to ITS translate frame), are translated
> by the ITS using tables kept in memory.
> 
> ITS translation tables for peripherals is kept in memory storage
> (device table [DT] and Interrupt Translation Table [ITT]) that
> is allocated by the driver on boot.
> 
> Both tables can be 1- or 2-level; the structure is chosen by the
> driver after probing the ITS HW parameters and checking the
> allowed table splits and supported {device/event}_IDbits.
> 
> DT table entries are allocated on demand (ie when a device is
> probed); the DT table is sized using the number of supported
> deviceID bits in that that's a system design decision (ie the
> number of deviceID bits implemented should reflect the number
> of devices expected in a system) therefore it makes sense to
> allocate a DT table that can cater for the maximum number of
> devices.
> 
> DT and ITT tables are allocated using the kmalloc interface;
> the allocation size may be smaller than a page or larger,
> and must provide contiguous memory pages.
> 
> LPIs INTIDs backing the device events are allocated one-by-one
> and only upon Linux IRQ allocation; this to avoid preallocating
> a large number of LPIs to cover the HW device MSI vector
> size whereas few MSI entries are actually enabled by a device.
> 
> ITS cacheability/shareability attributes are programmed
> according to the provided firmware ITS description.
> 
> The GICv5 partially reuses the GICv3 ITS MSI parent infrastructure
> and adds functions required to retrieve the ITS translate frame
> addresses out of msi-map and msi-parent properties to implement
> the GICv5 ITS MSI parent callbacks.
> 
> Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>

Hi Lorenzo,

It almost certainly doesn't matter, but there are a couple of release
paths in here where things don't happen in the same order as the
equivalent error tear down paths (i.e. not reverse of setup).

There may well be a good reason for that but I couldn't immediately
spot what it was.  Also a follow up similar to earlier comment about
the table sizing code not matching the comments above it. Same thing
going on here.

Jonathan


git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> new file mode 100644
> index 000000000000..cba632eb0273
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-v5-its.c

> +/*
> + * Function to check whether the device table or ITT table support
> + * a two-level table and if so depending on the number of id_bits
> + * requested, determine whether a two-level table is required.
> + *
> + * Return the 2-level size value if a two level table is deemed
> + * necessary.
> + */
> +static bool gicv5_its_l2sz_two_level(bool devtab, u32 its_idr1, u8 id_bits, u8 *sz)
> +{
> +	unsigned int l2_bits, l2_sz;
> +
> +	if (devtab && !FIELD_GET(GICV5_ITS_IDR1_DT_LEVELS, its_idr1))
> +		return false;
> +
> +	if (!devtab && !FIELD_GET(GICV5_ITS_IDR1_ITT_LEVELS, its_idr1))
> +		return false;
> +
> +	/*
> +	 * Pick an L2 size that matches the pagesize; if a match
> +	 * is not found, go for the smallest supported l2 size granule.

Similar to before, this description is confusing.  If Page size is 64K
and 16 + 4 are supported we choose 16 which is not he smallest
supported (4 is).  The condition the comment refers to only applies
if only larger than pagesized things are supported.

> +	 *
> +	 * This ensures that we will always be able to allocate
> +	 * contiguous memory at L2.
> +	 */
> +	switch (PAGE_SIZE) {
> +	case SZ_64K:
> +		if (GICV5_ITS_IDR1_L2SZ_SUPPORT_64KB(its_idr1)) {
> +			l2_sz = GICV5_ITS_DT_ITT_CFGR_L2SZ_64k;
> +			break;
> +		}
> +		fallthrough;
> +	case SZ_16K:
> +		if (GICV5_ITS_IDR1_L2SZ_SUPPORT_16KB(its_idr1)) {
> +			l2_sz = GICV5_ITS_DT_ITT_CFGR_L2SZ_16k;
> +			break;
> +		}
> +		fallthrough;
> +	case SZ_4K:
> +		if (GICV5_ITS_IDR1_L2SZ_SUPPORT_4KB(its_idr1)) {
> +			l2_sz = GICV5_ITS_DT_ITT_CFGR_L2SZ_4k;
> +			break;
> +		}
> +		if (GICV5_ITS_IDR1_L2SZ_SUPPORT_16KB(its_idr1)) {
> +			l2_sz = GICV5_ITS_DT_ITT_CFGR_L2SZ_16k;
> +			break;
> +		}
> +		if (GICV5_ITS_IDR1_L2SZ_SUPPORT_64KB(its_idr1)) {
> +			l2_sz = GICV5_ITS_DT_ITT_CFGR_L2SZ_64k;
> +			break;
> +		}
> +
> +		l2_sz = GICV5_ITS_DT_ITT_CFGR_L2SZ_4k;
> +		break;
> +	}
> +
> +	l2_bits = gicv5_its_l2sz_to_l2_bits(l2_sz);
> +
> +	if (l2_bits > id_bits)
> +		return false;
> +
> +	*sz = l2_sz;
> +
> +	return true;
> +}



> +/*
> + * Register a new device in the device table. Allocate an ITT and
> + * program the L2DTE entry according to the ITT structure that
> + * was chosen.
> + */
> +static int gicv5_its_device_register(struct gicv5_its_chip_data *its,
> +				     struct gicv5_its_dev *its_dev)
> +{
> +	u8 event_id_bits, device_id_bits, itt_struct, itt_l2sz;
> +	phys_addr_t itt_phys_base;
> +	bool two_level_itt;
> +	u32 idr1, idr2;
> +	__le64 *dte;
> +	u64 val;
> +	int ret;
> +
> +	device_id_bits = devtab_cfgr_field(its, DEVICEID_BITS);
> +
> +	if (its_dev->device_id >= BIT(device_id_bits)) {
> +		pr_err("Supplied DeviceID (%u) outside of Device Table range (%u)!",
> +		       its_dev->device_id, (u32)GENMASK(device_id_bits - 1, 0));
> +		return -EINVAL;
> +	}
> +
> +	dte = gicv5_its_devtab_get_dte_ref(its, its_dev->device_id, true);
> +	if (!dte)
> +		return -ENOMEM;
> +
> +	if (FIELD_GET(GICV5_DTL2E_VALID, le64_to_cpu(*dte)))
> +		return -EBUSY;
> +
> +	/*
> +	 * Determine how many bits we need, validate those against the max.
> +	 * Based on these, determine if we should go for a 1- or 2-level ITT.
> +	 */
> +	event_id_bits = order_base_2(its_dev->num_events);
> +
> +	idr2 = its_readl_relaxed(its, GICV5_ITS_IDR2);
> +
> +	if (event_id_bits > FIELD_GET(GICV5_ITS_IDR2_EVENTID_BITS, idr2)) {
> +		pr_err("Required EventID bits (%u) larger than supported bits (%u)!",
> +		       event_id_bits,
> +		       (u8)FIELD_GET(GICV5_ITS_IDR2_EVENTID_BITS, idr2));
> +		return -EINVAL;
> +	}
> +
> +	idr1 = its_readl_relaxed(its, GICV5_ITS_IDR1);
> +
> +	/*
> +	 * L2 ITT size is programmed into the L2DTE regardless of
> +	 * whether a two-level or linear ITT is built, init it.
> +	 */
> +	itt_l2sz = 0;
> +
> +	two_level_itt = gicv5_its_l2sz_two_level(false, idr1, event_id_bits,
> +						  &itt_l2sz);
> +	if (two_level_itt)
> +		ret = gicv5_its_create_itt_two_level(its, its_dev, event_id_bits,
> +						     itt_l2sz,
> +						     its_dev->num_events);
> +	else
> +		ret = gicv5_its_create_itt_linear(its, its_dev, event_id_bits);
> +	if (ret)
> +		return ret;
> +
> +	itt_phys_base = two_level_itt ? virt_to_phys(its_dev->itt_cfg.l2.l1itt) :
> +					virt_to_phys(its_dev->itt_cfg.linear.itt);
> +
> +	itt_struct = two_level_itt ? GICV5_ITS_DT_ITT_CFGR_STRUCTURE_TWO_LEVEL :
> +				     GICV5_ITS_DT_ITT_CFGR_STRUCTURE_LINEAR;
> +
> +	val = FIELD_PREP(GICV5_DTL2E_EVENT_ID_BITS, event_id_bits)	|
> +	      FIELD_PREP(GICV5_DTL2E_ITT_STRUCTURE, itt_struct)		|
> +	      (itt_phys_base & GICV5_DTL2E_ITT_ADDR_MASK)		|
> +	      FIELD_PREP(GICV5_DTL2E_ITT_L2SZ, itt_l2sz)		|
> +	      FIELD_PREP(GICV5_DTL2E_VALID, 0x1);
> +
> +	its_write_table_entry(its, dte, val);
> +
> +	ret = gicv5_its_device_cache_inv(its, its_dev);
> +	if (ret) {
> +		gicv5_its_free_itt(its_dev);
> +		its_write_table_entry(its, dte, 0);

If it makes no difference, unwind in reverse order of setup so swap the
two lines above.

> +		return ret;
> +	}
> +
> +	return 0;
> +}

> +static struct gicv5_its_dev *gicv5_its_alloc_device(struct gicv5_its_chip_data *its, int nvec,
> +						    u32 dev_id)
> +{
> +	struct gicv5_its_dev *its_dev;
> +	void *entry;
> +	int ret;
> +
> +	its_dev = gicv5_its_find_device(its, dev_id);
> +	if (!IS_ERR(its_dev)) {
> +		pr_err("A device with this DeviceID (0x%x) has already been registered.\n",
> +		       dev_id);
> +
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	its_dev = kzalloc(sizeof(*its_dev), GFP_KERNEL);
> +	if (!its_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	its_dev->device_id = dev_id;
> +	its_dev->num_events = nvec;
> +
> +	ret = gicv5_its_device_register(its, its_dev);
> +	if (ret) {
> +		pr_err("Failed to register the device\n");
> +		goto out_dev_free;
> +	}
> +
> +	gicv5_its_device_cache_inv(its, its_dev);
> +
> +	its_dev->its_node = its;
> +
> +	its_dev->event_map = (unsigned long *)bitmap_zalloc(its_dev->num_events, GFP_KERNEL);
> +	if (!its_dev->event_map) {
> +		ret = -ENOMEM;
> +		goto out_unregister;
> +	}
> +
> +	entry = xa_store(&its->its_devices, dev_id, its_dev, GFP_KERNEL);
> +	if (xa_is_err(entry)) {
> +		ret = xa_err(entry);
> +		goto out_bitmap_free;
> +	}
> +
> +	return its_dev;
> +
> +out_bitmap_free:
> +	bitmap_free(its_dev->event_map);
> +out_unregister:
> +	gicv5_its_device_unregister(its, its_dev);
> +out_dev_free:
> +	kfree(its_dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static int gicv5_its_msi_prepare(struct irq_domain *domain, struct device *dev,
> +				 int nvec, msi_alloc_info_t *info)
> +{
> +	u32 dev_id = info->scratchpad[0].ul;
> +	struct msi_domain_info *msi_info;
> +	struct gicv5_its_chip_data *its;
> +	struct gicv5_its_dev *its_dev;
> +
> +	msi_info = msi_get_domain_info(domain);
> +	its = msi_info->data;
> +
> +	guard(mutex)(&its->dev_alloc_lock);
> +
> +	its_dev = gicv5_its_alloc_device(its, nvec, dev_id);
> +	if (IS_ERR(its_dev))
> +		return PTR_ERR(its_dev);
> +
> +	its_dev->its_trans_phys_base = info->scratchpad[1].ul;
> +	info->scratchpad[0].ptr = its_dev;
> +
> +	return 0;
> +}
> +
> +static void gicv5_its_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *info)
> +{
> +	struct gicv5_its_dev *its_dev = info->scratchpad[0].ptr;
> +	struct msi_domain_info *msi_info;
> +	struct gicv5_its_chip_data *its;
> +
> +	msi_info = msi_get_domain_info(domain);
> +	its = msi_info->data;
> +
> +	guard(mutex)(&its->dev_alloc_lock);
> +
> +	if (WARN_ON_ONCE(!bitmap_empty(its_dev->event_map, its_dev->num_events)))
> +		return;
> +
> +	gicv5_its_device_unregister(its, its_dev);
> +	bitmap_free(its_dev->event_map);
> +	xa_erase(&its->its_devices, its_dev->device_id);

I was expecting this to be in reverse order of what happens in *msi_prepare (and *msi_alloc under
that). That would give the order

	xa_erase();
	bitmap_free();
	gicv5_its_device_unregister();
	kfree(its_dev);

If there is a reason for this ordering it might be good to add a comment calling it out.

 
> +	kfree(its_dev);
> +}



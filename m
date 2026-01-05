Return-Path: <linux-pci+bounces-44006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B95CF36AF
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FDC730CCD01
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4CE33438F;
	Mon,  5 Jan 2026 12:01:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEE330B36;
	Mon,  5 Jan 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614478; cv=none; b=o/sROj4P/5grmQTjFze9f8h6b5chzAjIOBqU1969+Z/steqRsekwiaZqMnfVUmSItT0X5uGtKNs81Vozh8CQOKkJNTzZHGwFDSUT3Li3DQfAL4vxu2sQ+M9dbPj2waZFGdddrGSGnS01QRq3YFRljdcz0hZt+FSgX1tNbFvyR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614478; c=relaxed/simple;
	bh=4ynjMxk0roEk3a96iXXrcKZGWIGR6B/H8t/ixLIN/Bc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdqIV7EvwarQD9Rhzuvcq1EG/M/i8YDN8ZWyhJwDSvVLOrGfCd3s1LPTw+kAtx/Nq63UGa7x+ZxDVASvqoQtj3b3egBnViJGUzJLiLzwBVZcBexPf7RBH9tsccJV2oIruCIwS9VihIQynleWGnJprUSLqHzxUBvEuxQ76vt97VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlCYw6g49zHnH7t;
	Mon,  5 Jan 2026 20:01:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 17D0240565;
	Mon,  5 Jan 2026 20:01:11 +0800 (CST)
Received: from localhost (10.48.157.23) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 12:01:09 +0000
Date: Mon, 5 Jan 2026 12:01:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc
 Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] irqdomain: Add parent field to struct
 irqchip_fwid
Message-ID: <20260105120108.00002016@huawei.com>
In-Reply-To: <20251218-gicv5-host-acpi-v2-3-eec76cd1d40b@kernel.org>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
	<20251218-gicv5-host-acpi-v2-3-eec76cd1d40b@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:14:29 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> The GICv5 driver IRQ domain hierarchy requires adding a parent field to
> struct irqchip_fwid so that core code can reference a fwnode_handle parent
> for a given fwnode.
> 
> Add a parent field to struct irqchip_fwid and update the related kernel API
> functions to initialize and handle it.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
Hi Lorenzo,

Happy new year.

> ---
>  include/linux/irqdomain.h | 30 ++++++++++++++++++++++++++----
>  kernel/irq/irqdomain.c    | 14 +++++++++++++-
>  2 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 62f81bbeb490..b9df84b447a1 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -257,7 +257,8 @@ static inline void irq_domain_set_pm_device(struct irq_domain *d, struct device
>  
>  #ifdef CONFIG_IRQ_DOMAIN
>  struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
> -						const char *name, phys_addr_t *pa);
> +						const char *name, phys_addr_t *pa,
> +						struct fwnode_handle *parent);
>  
>  enum {
>  	IRQCHIP_FWNODE_REAL,
> @@ -267,18 +268,39 @@ enum {
>  
>  static inline struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
>  {
> -	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL);
> +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, NULL);
> +}
> +
> +static inline
> +struct fwnode_handle *irq_domain_alloc_named_fwnode_parent(const char *name,
> +							   struct fwnode_handle *parent)

The name of this makes me think it's allocating the named fwnode parent, rather that
the named fwnode + setting it's parent.

There aren't all that many calls to irq_domain_named_fwnode(), maybe to avoid challenge
of a new name, just add the parameter to all of them? (25ish)  Mind you the current
pattern for similar cases is a helper, so maybe not.

Or go with something similar to named and have

irq_domain_alloc_named_parented_fwnode()?

I'm not that bothered though if you think the current naming is the best we can do.

Jonathan

> +{
> +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, parent);
>  }




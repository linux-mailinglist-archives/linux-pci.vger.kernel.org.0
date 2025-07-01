Return-Path: <linux-pci+bounces-31201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935DAF03C5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966C44A5746
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269A283137;
	Tue,  1 Jul 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN/qjXx7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30628312D
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398153; cv=none; b=Ag71WDm2Vr2tmWhfEh8N6UDm1+YVDddQ5M1RGDGXMctl77YDpn/jKWa3X/TzWklG3IBqkfgK0OwOCMBv/lfLWjkbZTIeZt+bR9iJbfy5UBYxRv2dLi8DRbVF4/KWNVoZ/hn3fhjMrhgVPgjJ5oyYcS7LD5y/eW3WWPfXF3KT0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398153; c=relaxed/simple;
	bh=Der6lHkCC98no1Vn4NQll5rTYBWXTKnaq2KSJ3XTARI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTfYe2N4eNafgOIywa6oYVszSpHD2OvL8OTGPkpWhVf3P0xRhhkEWYDbb0/5ZsWMs5vDEGE2q/XAw9Vv4tfQgRpr5+eGEZ9wyh9XE8MibtqrDCJ1guJwDoANc3Imrplt4my9sgSONi8SpMVxNXv3kYn+isOUlmisgaYPaNi/5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN/qjXx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjTFqfwrz80T+KU/Vvx3G5r4It+9k632M4DI6S0TxZ8=;
	b=LN/qjXx7ejcFaIcbG0dsKU5WcOT+LAR5IhXrbBBY9uGp3sQoV87IwdxgKvmx2bt5dqp14B
	NP5/1QtbcepJ/o3/boMm9HtQDX2a4I3fT9lAdamTZqBoOi8o5OwxngiXSxqad80TFdBsfO
	IMMy4pjaLz+0UUl2xAB8W/o5a8DlK5Y=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-mz-sdWjcN6m3H3G6aERYtw-1; Tue, 01 Jul 2025 15:29:10 -0400
X-MC-Unique: mz-sdWjcN6m3H3G6aERYtw-1
X-Mimecast-MFC-AGG-ID: mz-sdWjcN6m3H3G6aERYtw_1751398149
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-739f2a86cc2so171887a34.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 12:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398149; x=1752002949;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjTFqfwrz80T+KU/Vvx3G5r4It+9k632M4DI6S0TxZ8=;
        b=cUqW7M0naUn2g9vKm0WL2nJN+76x4LprY20A7l1UaHJ+EjwyrOS67MUUyzio6FtLea
         bq5pCf/Dicf1jgwrt1szmG6FVuSTMZ/dP9bnv73Gk/FTO292LZZWl+PjLPqsBTqYRnNt
         ao52eRcO/qVgWjz/z4RDEGjBJaa39GKi/8r/2uwGxkW4m7DW4vJMHFkDEbOJp6shtToe
         BmAqQOnHVSezox/q2/GzIBSNPGnASmKkogu75cYzPAf3xW8Hb9XQ489RBCj/R3x/TgV7
         xPA3cbDG5r0cBJxbHHY3aAX07LKpzNZRotjYlgK/4XPZflOjvG4g5eqYW5a3NV+86oZ/
         nDCg==
X-Forwarded-Encrypted: i=1; AJvYcCWTzIbjrYGxAxaW86s9TzfkqQ8ysY/2h/jpKnVTx8vQQOlpluqRVAhir2/kc9covoMhKQi8Xbfypz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XsguKsXnjK2x8abXZFvhK/AwYWSuhuw8P6hzqOr5kcR+Qo7z
	e8X5Xi4tRVzT4MtZGMMkDSaTnaUP9DqJnsoRRnG1zd4Pn3P0FVe2kezrG06v3twG1+s/ikjCUPp
	MGDRISlXqALnCaHBEIxYqJZKtnXlDmHucYp5FwRdupb8cXe6ZpAGOh9g0zQAKUQ==
X-Gm-Gg: ASbGncvCtORmEPB7qfzuGb33Co/1Vnx6Kt+WtmXQGTi4YUIMOnvaAXANbgt9scZKNlC
	RgMdFVNO8xfBJIZJQNs0SU+kkC8cey3pWA5j0Qf/RF/7uCjdultIAVuwPfcMTFUT4x4L5E80e/7
	xKiyH32/xyAQ4ELWqDVLhBM2xps51aRAs+1p97q0kf5TShSbL2rsFhWz7zAXGEoSFS3ehF9qeLO
	LPvIC6yJF3jQ9o71cOMMbLZJBAfibOr6kcO2aGGdKg0subB9YYiOff8eEIOGlaajdy5EfnapWvS
	SMSDVX9w6y76lysRKHHVSz+5Wg==
X-Received: by 2002:a05:6808:2217:b0:401:f524:a97d with SMTP id 5614622812f47-40b7b0a8707mr1196642b6e.4.1751398149414;
        Tue, 01 Jul 2025 12:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAidfeboIYE5QUTm/6yW8HPYX8OflJWQclvBEIzO4DlJkq5XCLurirKOmJEIcC02wo+DFNcg==
X-Received: by 2002:a05:6808:2217:b0:401:f524:a97d with SMTP id 5614622812f47-40b7b0a8707mr1196629b6e.4.1751398149030;
        Tue, 01 Jul 2025 12:29:09 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322c1e25sm2242252b6e.20.2025.07.01.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:29:07 -0700 (PDT)
Date: Tue, 1 Jul 2025 13:29:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250701132905.67d29191.alex.williamson@redhat.com>
In-Reply-To: <3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 19:28:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d265de874b14b6..f4584ffacbc03d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -65,8 +65,16 @@ struct iommu_group {
>  	struct list_head entry;
>  	unsigned int owner_cnt;
>  	void *owner;
> +
> +	/* Used by the device_group() callbacks */
> +	u32 bus_data;
>  };
>  
> +/*
> + * Everything downstream of this group should share it.
> + */
> +#define BUS_DATA_PCI_UNISOLATED BIT(0)

NON_ISOLATED for consistency w/ enum from the previous patch?

...
> +struct iommu_group *pci_device_group(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct iommu_group *group;
> +	struct pci_dev *real_pdev;
> +
> +	if (WARN_ON(!dev_is_pci(dev)))
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Arches can supply a completely different PCI device that actually
> +	 * does DMA.
> +	 */
> +	real_pdev = pci_real_dma_dev(pdev);
> +	if (real_pdev != pdev) {
> +		group = iommu_group_get(&real_pdev->dev);
> +		if (!group) {
> +			/*
> +			 * The real_pdev has not had an iommu probed to it. We
> +			 * can't create a new group here because there is no way
> +			 * for pci_device_group(real_pdev) to pick it up.
> +			 */
> +			dev_err(dev,
> +				"PCI device is probing out of order, real device of %s is not probed yet\n",
> +				pci_name(real_pdev));
> +			return ERR_PTR(-EPROBE_DEFER);
> +		}
> +		return group;
> +	}
> +
> +	if (pdev->dev_flags & PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT)
> +		return iommu_group_alloc();
> +
> +	/* Anything upstream of this enforcing non-isolated? */
> +	group = pci_hierarchy_group(pdev);
>  	if (group)
>  		return group;
>  
> -	/* No shared group found, allocate new */
> -	return iommu_group_alloc();
> +	switch (pci_bus_isolated(pdev->bus)) {
> +	case PCIE_ISOLATED:
> +		/* Check multi-function groups and same-bus devfn aliases */
> +		group = pci_get_alias_group(pdev);
> +		if (group)
> +			return group;
> +
> +		/* No shared group found, allocate new */
> +		return iommu_group_alloc();

I'm not following how we'd handle a multi-function root port w/o
consistent ACS isolation here.  How/where does the resulting group get
the UNISOLATED flag set?

I think that's necessary for the look-back in pci_hierarchy_group(),
right?  Thanks,

Alex



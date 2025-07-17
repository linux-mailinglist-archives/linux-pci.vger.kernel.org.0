Return-Path: <linux-pci+bounces-32460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CEB096C0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970BF5804D0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC212AEF5;
	Thu, 17 Jul 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnIavw/L"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA721ABAE
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789852; cv=none; b=R91PXyvpTCLMhUeNosRlnYQHryqj4VNYe56GUMJj2PVDB/NsMrBnWH741QAOfPQ3BfQHuRir0jntcb5Z+xMxI3RsSaOCvsvO3GhxBQcnUhfwVkoC11Ze//2XEGVf9Sr1en19uACLFWw8QoMW2kEO3uQNvZM2PazxJWbKyzhu8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789852; c=relaxed/simple;
	bh=txFdG1TA1k7alMDI+822TkiUPrAEkZHjjc07gGexWaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpILomxO/vCzBWX6ZG0ay8VEKZ8GBooBdYdPk24Djwak6ADTOQSrkJ74cY0VqXKGWZ246Wm/GfwoGaCYQJM5/nw3vVwvNRWr0Pb3jf5r5wpc557CkDv+VzzJjQmOTAyeC9nQeQf+yWQ+sjHObjs0Y/ismq9ekQNSFDJYvXeSfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnIavw/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752789849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14qo4ckuSkp5wHkmhsPFGvb+FvEFS3eV6eZ9+5OrkLA=;
	b=VnIavw/L4rBcVpQjOJZ9JsO1RxEkplQBqqzsBW7hlL2oG6s19GNkl5AH3VMIJCTU8vMy6j
	7AA0AXKiPAmZbXsph25wR/Jw6T1qUO1TnkoBV+LVU8WsFsPLaWoJfzWeSlXqXJ3G+GIjRw
	PG7C1YPKDgwPzki1NlR8kKUs2KdygWw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-W-Ft5OowMmykX1TGZhz8yA-1; Thu, 17 Jul 2025 18:04:08 -0400
X-MC-Unique: W-Ft5OowMmykX1TGZhz8yA-1
X-Mimecast-MFC-AGG-ID: W-Ft5OowMmykX1TGZhz8yA_1752789848
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab401e333bso45330251cf.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 15:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752789848; x=1753394648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14qo4ckuSkp5wHkmhsPFGvb+FvEFS3eV6eZ9+5OrkLA=;
        b=WXqAlqaOB+rY34kfeg35D8wkM3trhkcAriWUJ4EI8kFQxFa3L+AGk7A7XyAnEQQwxh
         KvQdUDYzWKMObkD7DPVhPZ94A4dS+x0l7GJeFYx9gi+KZ/rM0PTaVQP2j66CXiYe8Hp+
         DMAvFvNPYSLmLFX8gNURl3ouJ9KxTVAEe8Lkm9MNnYd4C56lKuunQ3/kcPtoZ5yfgnJb
         AneLNIZH6Iy+BEK/0i/b7fjlfazGW6wTUzanur7j/g+wThRMPudjEdh+JLj2ghdqJD3c
         1k3XUHT+Eeo1390L6N4wwfff1b9TmZ76MwRzU63y4HLbmBnw455blcw8+MM4SMN2Ew6/
         J5zw==
X-Forwarded-Encrypted: i=1; AJvYcCV7JcqSs4QaGUQ2eO/yLkYTy648tckSytVJSaq843boJBKIV/0HrmTrW41ug/waQTIbGxgBbYm+Rzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XU5o/ikjJXgYkMZal/Eh/rW6peoJn+jbjBIoH7WrV7ZnY5aU
	mgqc7WnQ2fKLYGWduqP8GhHB4fSkQBNOyzAFg+fkoOh42UzFTTMcB6fO4FjDRLrOxhe6BGVLyyK
	ZhVI/4MjFOaSzs/MpbBcwqpx4fhk8QsvdtpIMj1hG/wm8ID7HrIpyeNcZr8cInw==
X-Gm-Gg: ASbGnctTXdzEVoKU8HmLL/GEEnVrqBJVfuPSO3hj88dYFQukBpXVL/rpO4kVQStaKgh
	1+taK5rI+Uh0x77vHi8mfJxsxNd0bnQl+H0I9ihtxNQ+0LcLacMb2IKIR0GlKEOI2dLxRsN+4wZ
	Tza0fEMD7F8ypkySY7cq43TeHjZfNGHP1gdIzdOCAuaPNsAZS3kurwfX1DJNlpHZ160VRNVHUvM
	tMq8KHheeAK8T/TWRQku5XGv05jUXrNHBozRL1xRmf6yYcomDCVYnbM2ppBEMrrkjQ3zxKAO50J
	LNuckbrfSv01TAex5YV09c1T1VsrV0Jym9Jo2r4f
X-Received: by 2002:a05:622a:4898:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4abb078731emr29333431cf.5.1752789847768;
        Thu, 17 Jul 2025 15:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1MD1NbNTtFtXk2nNvNPQWBDbPtpdcIJIB0sY9UfJlcgBx07gvMOxQw7v7ytGjpx3C6A55ZA==
X-Received: by 2002:a05:622a:4898:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4abb078731emr29332751cf.5.1752789847095;
        Thu, 17 Jul 2025 15:04:07 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb497fb35sm341791cf.15.2025.07.17.15.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:04:06 -0700 (PDT)
Message-ID: <3bf0f555-535d-4e47-8ff1-f31b561a188c@redhat.com>
Date: Thu, 17 Jul 2025 18:04:04 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] PCI: Add pci_reachable_set()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <5-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <5-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jason,
Hi!

general question below, that you may know given your efficient compute log below.

On 7/9/25 10:52 AM, Jason Gunthorpe wrote:
> Implement pci_reachable_set() to efficiently compute a set of devices on
> the same bus that are "reachable" from a starting device. The meaning of
> reachability is defined by the caller through a callback function.
> 
This comment made me review get_pci_alias_group(), which states in its description:
* Look for aliases to or from the given device for existing groups. DMA
  * aliases are only supported on the same bus, therefore the search
  * space is quite small

So why does it do the for loop:
   for_each_pci_dev(tmp) {

vs getting the pdev->bus->devices -- list of devices on that bus, and only
scan that smaller list, vs all pci devices on the system?


> This is a faster implementation of the same logic in
> pci_device_group(). Being inside the PCI core allows use of pci_bus_sem so
> it can use list_for_each_entry() on a small list of devices instead of the
> expensive for_each_pci_dev(). Server systems can now have hundreds of PCI
> devices, but typically only a very small number of devices per bus.
> 
> An example of a reachability function would be pci_devs_are_dma_aliases()
> which would compute a set of devices on the same bus that are
> aliases. This would also be useful in future support for the ACS P2P
> Egress Vector which has a similar reachability problem.
> 
> This is effectively a graph algorithm where the set of devices on the bus
> are vertexes and the reachable() function defines the edges. It returns a
> set of vertexes that form a connected graph.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Could we move this to just before patch 11 where it is used?
or could this be used to improve get_pci_alias_group() and get_pci_function_alias_group() ?

> ---
>   drivers/pci/search.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci.h  | 12 ++++++
>   2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a13fad53e44df9..dc816dc4505c6d 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -585,3 +585,93 @@ int pci_dev_present(const struct pci_device_id *ids)
>   	return 0;
>   }
>   EXPORT_SYMBOL(pci_dev_present);
> +
> +/**
> + * pci_reachable_set - Generate a bitmap of devices within a reachability set
> + * @start: First device in the set
> + * @devfns: The set of devices on the bus
> + * @reachable: Callback to tell if two devices can reach each other
> + *
> + * Compute a bitmap where every set bit is a device on the bus that is reachable
> + * from the start device, including the start device. Reachability between two
> + * devices is determined by a callback function.
> + *
> + * This is a non-recursive implementation that invokes the callback once per
> + * pair. The callback must be commutative:
> + *    reachable(a, b) == reachable(b, a)
> + * reachable() can form a cyclic graph:
> + *    reachable(a,b) == reachable(b,c) == reachable(c,a) == true
> + *
> + * Since this function is limited to a single bus the largest set can be 256
> + * devices large.
> + */
> +void pci_reachable_set(struct pci_dev *start, struct pci_reachable_set *devfns,
> +		       bool (*reachable)(struct pci_dev *deva,
> +					 struct pci_dev *devb))
> +{
> +	struct pci_reachable_set todo_devfns = {};
> +	struct pci_reachable_set next_devfns = {};
> +	struct pci_bus *bus = start->bus;
> +	bool again;
> +
> +	/* Assume devfn of all PCI devices is bounded by MAX_NR_DEVFNS */
> +	static_assert(sizeof(next_devfns.devfns) * BITS_PER_BYTE >=
> +		      MAX_NR_DEVFNS);
> +
> +	memset(devfns, 0, sizeof(devfns->devfns));
> +	__set_bit(start->devfn, devfns->devfns);
> +	__set_bit(start->devfn, next_devfns.devfns);
> +
> +	down_read(&pci_bus_sem);
> +	while (true) {
> +		unsigned int devfna;
> +		unsigned int i;
> +
> +		/*
> +		 * For each device that hasn't been checked compare every
> +		 * device on the bus against it.
> +		 */
> +		again = false;
> +		for_each_set_bit(devfna, next_devfns.devfns, MAX_NR_DEVFNS) {
> +			struct pci_dev *deva = NULL;
> +			struct pci_dev *devb;
> +
> +			list_for_each_entry(devb, &bus->devices, bus_list) {
> +				if (devb->devfn == devfna)
> +					deva = devb;
> +
> +				if (test_bit(devb->devfn, devfns->devfns))
> +					continue;
> +
> +				if (!deva) {
> +					deva = devb;
> +					list_for_each_entry_continue(
> +						deva, &bus->devices, bus_list)
> +						if (deva->devfn == devfna)
> +							break;
> +				}
> +
> +				if (!reachable(deva, devb))
> +					continue;
> +
> +				__set_bit(devb->devfn, todo_devfns.devfns);
> +				again = true;
> +			}
> +		}
> +
> +		if (!again)
> +			break;
> +
> +		/*
> +		 * Every new bit adds a new deva to check, reloop the whole
> +		 * thing. Expect this to be rare.
> +		 */
> +		for (i = 0; i != ARRAY_SIZE(devfns->devfns); i++) {
> +			devfns->devfns[i] |= todo_devfns.devfns[i];
> +			next_devfns.devfns[i] = todo_devfns.devfns[i];
> +			todo_devfns.devfns[i] = 0;
> +		}
> +	}
> +	up_read(&pci_bus_sem);
> +}
> +EXPORT_SYMBOL_GPL(pci_reachable_set);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 517800206208b5..2e629087539101 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -834,6 +834,10 @@ struct pci_dynids {
>   	struct list_head	list;	/* For IDs added at runtime */
>   };
>   
> +struct pci_reachable_set {
> +	DECLARE_BITMAP(devfns, 256);
> +};
> +
>   enum pci_bus_isolation {
>   	/*
>   	 * The bus is off a root port and the root port has isolated ACS flags
> @@ -1248,6 +1252,9 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>   struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
>   struct pci_dev *pci_get_base_class(unsigned int class, struct pci_dev *from);
>   
> +void pci_reachable_set(struct pci_dev *start, struct pci_reachable_set *devfns,
> +		       bool (*reachable)(struct pci_dev *deva,
> +					 struct pci_dev *devb));
>   enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus);
>   
>   int pci_dev_present(const struct pci_device_id *ids);
> @@ -2063,6 +2070,11 @@ static inline struct pci_dev *pci_get_base_class(unsigned int class,
>   						 struct pci_dev *from)
>   { return NULL; }
>   
> +static inline void
> +pci_reachable_set(struct pci_dev *start, struct pci_reachable_set *devfns,
> +		  bool (*reachable)(struct pci_dev *deva, struct pci_dev *devb))
> +{ }
> +
>   static inline enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus)
>   { return PCIE_NON_ISOLATED; }
>   



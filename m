Return-Path: <linux-pci+bounces-35719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18ADB4A104
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053BE4E27FE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA782EC0B4;
	Tue,  9 Sep 2025 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG/Qj//y"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC51C84AE
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394019; cv=none; b=TOXVXkrkICAuTRgaS5wP6mTPIC1c7XQmwYB9V0pdGWLJU0IHFK65OURgvkBR2o7flbKpBST/SG63vvxB1/Ap+US1WtFD+upVw6+Wtmbk5gNXqzvTg2KNxJarQxHkqNC+CcQCLXOYKtECAir5ymdLb1+MONXzXbacl/A0UH8XtGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394019; c=relaxed/simple;
	bh=1oxzIB+Bq27heH7UqJ7HD5sfAeymQ9opp8zaJLFAIQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkPM2s7ZCfqWd+8Z9BTkHgfciBH+ZLgSLNd8iyeXPLzVTaYdp8fAepEI0bMi/oyB/ZzEghqcnhewIzxR7guTu8NuQbf39I9h6hnc8HsPSKXlz7aCKY7AGVMiBDZnYHhF/7OH5aXK9XtoxwVlbQrdcA8kCSbfhwB77iGdWtBU9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG/Qj//y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757394014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6iQxBUowgZS1gNMSIU064JFfiN2wIaCl+0CSNLdzGc=;
	b=PG/Qj//yinAG03rvljA8Sr1zSnRnT0dDT80uq1jOZNvkM/il58OaUhmOOAzb7FFZ6ugbqE
	Cwna7qunTHhA3LShD2UI7DC32pYA3eoduLydaDWZ/ylg3Ia5lsH4SomCGWInHXgrR440AU
	LMxYO/tqkMNLxsb82iZfHzKbfaxSUDo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-xJkBBrhLNWSNOGay444Kdw-1; Tue, 09 Sep 2025 01:00:13 -0400
X-MC-Unique: xJkBBrhLNWSNOGay444Kdw-1
X-Mimecast-MFC-AGG-ID: xJkBBrhLNWSNOGay444Kdw_1757394012
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7211f13bc24so110440466d6.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 22:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394012; x=1757998812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6iQxBUowgZS1gNMSIU064JFfiN2wIaCl+0CSNLdzGc=;
        b=Rc+pFAIbXVdASnGpSvo106u6di4gy3Kc0VuEb3/L0cSN7+baLDbc2k9VYakXPQ0Jmt
         M6T/TiFTFFwShdr8mSmivFIUSZ3gP2XsfoxU0txaiV50aKWe/UjlwDEHIs3E4xU7YBdl
         dN17PIgox4RqR+uAouN5dUhA7aUvinlGxSFuQu6z9lu9VmHlgblcos/LSIa4DTmvqERT
         XEt29CWmC5yEnOcQQupnutwzLhbOeeVW+V1yN2vuir1JB85RJ+DAuUqKKRhTREapkd5F
         wxbqaMXfyztdR2FhrRmcMRmsvefsiXAytmVRO9aN4+xyNZWxV8hIDMuag8xjJ7APpIdQ
         9R4w==
X-Forwarded-Encrypted: i=1; AJvYcCX5uHZEXspdgHlwPoYjytWTg7XPiCBTmGi4n1hdbgK+vaY/8dc96XLyKEd3/srpf7aHBmCUlogZxPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+l0+m8sWeFn7pJcfZBCDEJlc00Cn4wE+epvdAPbPWktpS3AVi
	0UGKW+wVFqZ7+iWX8rhWfnXNmLMl8W6gPBh0GVXW1M6XHIYgXSZotmsfhh8qACQ6/UQd/cnd30p
	TvL8zcsOzGj8wglqNJLKtzlQcDu3IpH10y75l5irSzxEDOW8vWqFhoIVWBmR29g==
X-Gm-Gg: ASbGncuZ1DLnGOumYi4IcZAmK1ooLAyLyY/KwFVtqZp/D7WcVwWUFd531OSZwQBlOgJ
	0c3vh15cuHG2asSioK40r36EyD+GUOaxs+I6UJEgPGtzx4JubJ+Zj0Olln+dx9eTVTfrePXpFCm
	aeytEIFBn6wdQlJFVNKtjvJNbREe5noOqGZ5DEweaJdizlv54fLsOYKUZPRDAY7oNr+GMSqsZnM
	6LD+Xf0mwU/1aZvwRIR9mGulJMC5oRsBfx64R/BQZgtf9dUkLPmJYJ2dsr3s/FIYZVGGIS6MTzN
	UrP+rIBoLS4nT5YY4ox6FSQyswPba+h25Dn0oTNN
X-Received: by 2002:a05:6214:20a1:b0:749:a12b:2d58 with SMTP id 6a1803df08f44-749a12b2f2cmr61920056d6.60.1757394012314;
        Mon, 08 Sep 2025 22:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbhlr0VwTq4d+7yg1kvRuLY1QCWsGq5tYaJVVe3wMI23DU+9UPnzZF9LjoX5cUPqjAsHKB1w==
X-Received: by 2002:a05:6214:20a1:b0:749:a12b:2d58 with SMTP id 6a1803df08f44-749a12b2f2cmr61919636d6.60.1757394011771;
        Mon, 08 Sep 2025 22:00:11 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-725dda254d4sm118146646d6.8.2025.09.08.22.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:00:11 -0700 (PDT)
Message-ID: <9487fde9-ec40-4383-aafe-7ae0811830f5@redhat.com>
Date: Tue, 9 Sep 2025 01:00:08 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] iommu: Validate that pci_for_each_dma_alias()
 matches the groups
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
References: <7-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <7-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> Directly check that the devices touched by pci_for_each_dma_alias() match
> the groups that were built by pci_device_group(). This helps validate that
Do they have to match, as in equal, or be included ?

> pci_for_each_dma_alias() and pci_bus_isolated() are consistent.
> 
> This should eventually be hidden behind a debug kconfig, but for now it is
> good to get feedback from more diverse systems if there are any problems.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 76 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fc3c71b243a850..2bd43a5a9ad8d8 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1627,7 +1627,7 @@ static struct iommu_group *pci_hierarchy_group(struct pci_dev *pdev)
>    *     Once a PCI bus becomes non isolating the entire downstream hierarchy of
>    *     that bus becomes a single group.
>    */
> -struct iommu_group *pci_device_group(struct device *dev)
> +static struct iommu_group *__pci_device_group(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct iommu_group *group;
> @@ -1734,6 +1734,80 @@ struct iommu_group *pci_device_group(struct device *dev)
>   	WARN_ON(true);
>   	return ERR_PTR(-EINVAL);
>   }
> +
> +struct check_group_aliases_data {
> +	struct pci_dev *pdev;
> +	struct iommu_group *group;
> +};
> +
> +static void pci_check_group(const struct check_group_aliases_data *data,
> +			    u16 alias, struct pci_dev *pdev)
> +{
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(&pdev->dev);
> +	if (!group)
> +		return;
> +
> +	if (group != data->group)
> +		dev_err(&data->pdev->dev,
> +			"During group construction alias processing needed dev %s alias %x to have the same group but %u != %u\n",
> +			pci_name(pdev), alias, data->group->id, group->id);
> +	iommu_group_put(group);
> +}
> +
> +static int pci_check_group_aliases(struct pci_dev *pdev, u16 alias,
> +				   void *opaque)
> +{
> +	const struct check_group_aliases_data *data = opaque;
> +
> +	/*
> +	 * Sometimes when a PCIe-PCI bridge is performing transactions on behalf
> +	 * of its subordinate bus it uses devfn=0 on the subordinate bus as the
> +	 * alias. This means that 0 will alias with all devfns on the
> +	 * subordinate bus and so we expect to see those in the same group. pdev
> +	 * in this case is the bridge itself and pdev->bus is the primary bus of
> +	 * the bridge.
> +	 */
> +	if (pdev->bus->number != PCI_BUS_NUM(alias)) {
> +		struct pci_dev *piter = NULL;
> +
> +		for_each_pci_dev(piter) {
> +			if (pci_domain_nr(pdev->bus) ==
> +				    pci_domain_nr(piter->bus) &&
> +			    PCI_BUS_NUM(alias) == pdev->bus->number)
> +				pci_check_group(data, alias, piter);
> +		}
> +	} else {
> +		pci_check_group(data, alias, pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +struct iommu_group *pci_device_group(struct device *dev)
> +{
> +	struct check_group_aliases_data data = {
> +		.pdev = to_pci_dev(dev),
> +	};
> +	struct iommu_group *group;
> +
> +	if (!IS_ENABLED(CONFIG_PCI))
> +		return ERR_PTR(-EINVAL);
> +
> +	group = __pci_device_group(dev);
> +	if (IS_ERR(group))
> +		return group;
> +
> +	/*
> +	 * The IOMMU driver should use pci_for_each_dma_alias() to figure out
> +	 * what RIDs to program and the core requires all the RIDs to fall
> +	 * within the same group. Validate that everything worked properly.
> +	 */
> +	data.group = group;
> +	pci_for_each_dma_alias(data.pdev, pci_check_group_aliases, &data);
> +	return group;
> +}
>   EXPORT_SYMBOL_GPL(pci_device_group);
>   
>   /* Get the IOMMU group for device on fsl-mc bus */



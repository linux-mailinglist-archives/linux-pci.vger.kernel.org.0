Return-Path: <linux-pci+bounces-35716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2C2B4A084
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 06:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2954616D3D2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4902DECDD;
	Tue,  9 Sep 2025 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5keEwOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE632D9ED1
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391250; cv=none; b=pWrmOvKg54lJjysw93Zh/OoRruM8VgRWGn5VSgtP7sTrNsfd5DiHktVLGZe0kjMyPrnVId/Mdqgjw7ypnEWeatf6t/CovxfORT8G9GcRFZfpTpRvZljLANX/jbBV3RF0qnl4D0UY+f7xRot09nji5LSY5HLTuV6eEt4EN7AYnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391250; c=relaxed/simple;
	bh=E/H9pnraW+7ua0tMUmo3wg/oAHzkw3UX3IlBicYYufE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFAXDiW8csE0oMNg6s4jbODcVcO/lsG6hjrE2oZEPcoNV44j06shwbEt8wnWaw1AM1onqhu4H399uCPEEFUurpMKiv0z1gpnW+ixs+ELK0Bk6yHuLDIqhJ9o5j1APflUM+TfHWoh8+4tRivfA0LBTe8H9bqTMMfyBBfd1fbWwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5keEwOx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757391248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uji9nNxcvsGRbzvzjV33MTLr+v+OOoDbKZZMYb3ddSs=;
	b=f5keEwOxaWyYqCHialEH7gLHbnyJIWRWTChT9WHGwV7oRHXosp5pcawveAI5dkHpkIet75
	PRFSu1xpy8mrM9m1gYiTkMAx1fP2HV4L5vwa2dRPaZ5XaunSXCz4Wc1WJVhil2cldG7rKb
	C4tSkp4p1ycN4Q6idZ0nxjewdQwcYAw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-HzrVdwBoN52Gi5Lgi6QJsQ-1; Tue, 09 Sep 2025 00:14:04 -0400
X-MC-Unique: HzrVdwBoN52Gi5Lgi6QJsQ-1
X-Mimecast-MFC-AGG-ID: HzrVdwBoN52Gi5Lgi6QJsQ_1757391244
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-73b7a12ee87so57762536d6.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 21:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391244; x=1757996044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uji9nNxcvsGRbzvzjV33MTLr+v+OOoDbKZZMYb3ddSs=;
        b=oRY+AglBHuQb2saVT74pfWfl27hDQLOQNViWOZKW7fPy+fDdNLo621x24C5dxa8Aqy
         /s63icAAeHDhlEhKAoqbIfgKBSs0k4H+wPD8a8W9n+nZ3XstYK/iN1DVU8G2EwtecwGT
         C6+HJAL4fvni6ghjRqTV6Yd+QX9c7xWUtOjPSa3EfAFKNHGFV17Up/3wvq0EGSH5A6u7
         JtThafyEpRz4WLGuYi1M3NFo3a9jrghFZ+eVOT0MeIqa+ii0BJur+pOKxpBXGclUtDwa
         pAJuTjquuqt1Lz5g1k3erVMqcx6AsCY86gSdDqxOp8n6fk7+KxgJKPgvr9vaoQvbbHwT
         eI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2vAV8Y4973hi0JF0AzghSH3a5NJqe0foltRwg72nmzYwqhpfFeyYhNl0ZZ5QVOpERCJJGQ1P8Pfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9eIBo5LCFlvAzGSxl9WPDop3E/+DEe2UjtaaGAvfMQYIzRJl
	hNrD3thCEphoDKbsvm7T9XJd0uNj1BIo2Lf7f4olo/npX/s7u17QdKk3Sb7sXJ6cxdOP+BLHMuA
	YRjQP2DqrltDM6hQUjYix5zgtBZ1u9u0BrI6bvQUrn2C39c04Fi7EEdvFkfucSQ==
X-Gm-Gg: ASbGncvXloLuD8jNzQ6HqZTFG2Jq4vRjM7eOAXRQdJQRuDSjKlA+oJYvZImOoaq53rD
	678yyKlIBtw9D+G9rCGwIIGrLxv1aZ1txIMyFW2QLE8zSz7f8S1QoSOhLp27vnjAAAtSClo8Dbw
	8DU2oMZy3FmcV9HPe81hDmdhxP5W08K2LOuJSJE+NoLloFu71wHEUHA2+8fH0AA9likIYkTnBcF
	ocaAo81SiRlGi4dNikPNdS1ohjC1VOGUnC5j2EyCgqu+W1wX+mMiZ9DDaUNdx1nxd7XlKUz6h8N
	BNs22yMTujX2SFFCrFjqsa3JewmFfgX8dQtCqhgn
X-Received: by 2002:a0c:f119:0:b0:739:f004:a176 with SMTP id 6a1803df08f44-739f004a468mr96789166d6.39.1757391243834;
        Mon, 08 Sep 2025 21:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqbnFXoLCfV5gEI+Vm3UBakZRv0toqrGYVcWmnfwTKV3Pte3Ae3d0oOnvqNaHxADG912DziA==
X-Received: by 2002:a0c:f119:0:b0:739:f004:a176 with SMTP id 6a1803df08f44-739f004a468mr96788826d6.39.1757391243220;
        Mon, 08 Sep 2025 21:14:03 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b46660fbsm138221326d6.44.2025.09.08.21.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 21:14:02 -0700 (PDT)
Message-ID: <3634c854-f63f-4dc0-aa53-0b18c5a7ea1c@redhat.com>
Date: Tue, 9 Sep 2025 00:14:00 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
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
References: <3-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <3-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


one nit below...

On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> The current algorithm does not work if ACS is turned off, and it is not
> clear how this has been missed for so long. I think it has been avoided
> because the kernel command line options to target specific devices and
> disable ACS are rarely used.
> 
> For discussion lets consider a simple topology like the below:
> 
>                                 -- DSP 02:00.0 -> End Point A
>   Root 00:00.0 -> USP 01:00.0 --|
>                                 -- DSP 02:03.0 -> End Point B
> 
> If ACS is fully activated we expect 00:00.0, 01:00.0, 02:00.0, 02:03.0, A,
> B to all have unique single device groups.
> 
> If both DSPs have ACS off then we expect 00:00.0 and 01:00.0 to have
> unique single device groups while 02:00.0, 02:03.0, A, B are part of one
> multi-device group.
> 
> If the DSPs have asymmetric ACS, with one fully isolating and one
> non-isolating we also expect the above multi-device group result.
> 
> Instead the current algorithm always creates unique single device groups
> for this topology. It happens because the pci_device_group(DSP)
> immediately moves to the USP and computes pci_acs_path_enabled(USP) ==
> true and decides the DSP can get a unique group. The pci_device_group(A)
> immediately moves to the DSP, sees pci_acs_path_enabled(DSP) == false and
> then takes the DSPs group.
> 
> For root-ports a PCIe topology like:
>                                           -- Dev 01:00.0
>    Root  00:00.00 --- Root Port 00:01.0 --|
>                    |                      -- Dev 01:00.1
> 		  |- Dev 00:17.0
> 
> Previously would group [00:01.0, 01:00.0, 01:00.1] together if there is no
> ACS capability in the root port.
> 
> While ACS on root ports is underspecified in the spec, it should still
> function as an egress control and limit access to either the MMIO of the
> root port itself, or perhaps some other devices upstream of the root
> complex - 00:17.0 perhaps in this example.
> 
> Historically the grouping in Linux has assumed the root port routes all
> traffic into the TA/IOMMU and never bypasses the TA to go to other
> functions in the root complex. Following the new understanding that ACS is
> required for internal loopback also treat root ports with no ACS
> capability as lacking internal loopback as well.
> 
> The current algorithm has several issues:
> 
>   1) It implicitly depends on ordering. Since the existing group discovery
>      only goes in the upstream direction discovering a downstream device
>      before its upstream will cause the wrong creation of narrower groups.
> 
>   2) It assumes that if the path from the end point to the root is entirely
>      ACS isolated then that end point is isolated. This misses cross-traffic
>      in the asymmetric ACS case.
> 
>   3) When evaluating a non-isolated DSP it does not check peer DSPs for an
>      already established group unless the multi-function feature does it.
> 
>   4) It does not understand the aliasing rule for PCIe to PCI bridges
>      where the alias is to the subordinate bus. The bridge's RID on the
>      primary bus is not aliased. This causes the PCIe to PCI bridge to be
>      wrongly joined to the group with the downstream devices.
> 
> As grouping is a security property for VFIO creating incorrectly narrowed
> groups is a security problem for the system.
> 
> Revise the design to solve these problems.
> 
> Explicitly require ordering, or return EPROBE_DEFER if things are out of
> order. This avoids silent errors that created smaller groups and solves
> problem #1.
> 
> Work on busses, not devices. Isolation is a property of the bus, and the
> first non-isolated bus should form a group containing all devices
> downstream of that bus. If all busses on the path to an end device are
> isolated then the end device has a chance to make a single-device group.
> 
> Use pci_bus_isolation() to compute the bus's isolation status based on the
> ACS flags and technology. pci_bus_isolation() touches a lot of PCI
> internals to get the information in the right format.
> 
> Add a new flag in the iommu_group to record that the group contains a
> non-isolated bus. Any downstream pci_device_group() will see
> bus->self->iommu_group is non-isolated and unconditionally join it. This
> makes the first non-isolation apply to all downstream devices and solves
> problem #2
> 
> The bus's non-isolated iommu_group will be stored in either the DSP of
> PCIe switch or the bus->self upstream device, depending on the situation.
> When storing in the DSP all the DSPs are checked first for a pre-existing
> non-isolated iommu_group. When stored in the upstream the flag forces it
> to all downstreams. This solves problem #3.
> 
> Put the handling of end-device aliases and MFD into pci_get_alias_group()
> and only call it in cases where we have a fully isolated path. Otherwise
> every downstream device on the bus is going to be joined to the group of
> bus->self.
> 
> Finally, replace the initial pci_for_each_dma_alias() with a combination
> of:
> 
>   - Directly checking pci_real_dma_dev() and enforcing ordering.
>     The group should contain both pdev and pci_real_dma_dev(pdev) which is
>     only possible if pdev is ordered after real_dma_dev. This solves a case
>     of #1.
> 
>   - Indirectly relying on pci_bus_isolation() to report legacy PCI busses
>     as non-isolated, with the enum including the distinction of the PCIe to
>     PCI bridge being isolated from the downstream. This solves problem #4.
> 
> It is very likely this is going to expand iommu_group membership in
> existing systems. After all that is the security bug that is being
> fixed. Expanding the iommu_groups risks problems for users using VFIO.
> 
> The intention is to have a more accurate reflection of the security
> properties in the system and should be seen as a security fix. However
> people who have ACS disabled may now need to enable it. As such users may
> have had good reason for ACS to be disabled I strongly recommend that
> backporting of this also include the new config_acs option so that such
> users can potentially minimally enable ACS only where needed.
> 
> Fixes: 104a1c13ac66 ("iommu/core: Create central IOMMU group lookup/creation interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 279 ++++++++++++++++++++++++++++++++----------
>   include/linux/pci.h   |   3 +
>   2 files changed, 217 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2a47ddb01799c1..1874bbdc73b75e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -65,8 +65,16 @@ struct iommu_group {
>   	struct list_head entry;
>   	unsigned int owner_cnt;
>   	void *owner;
> +
> +	/* Used by the device_group() callbacks */
> +	u32 bus_data;
>   };
>   
> +/*
> + * Everything downstream of this group should share it.
> + */
> +#define BUS_DATA_PCI_NON_ISOLATED BIT(0)
> +
>   struct group_device {
>   	struct list_head list;
>   	struct device *dev;
> @@ -1484,25 +1492,6 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>   	return NULL;
>   }
>   
> -struct group_for_pci_data {
> -	struct pci_dev *pdev;
> -	struct iommu_group *group;
> -};
> -
> -/*
> - * DMA alias iterator callback, return the last seen device.  Stop and return
> - * the IOMMU group if we find one along the way.
> - */
> -static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
> -{
> -	struct group_for_pci_data *data = opaque;
> -
> -	data->pdev = pdev;
> -	data->group = iommu_group_get(&pdev->dev);
> -
> -	return data->group != NULL;
> -}
> -
>   /*
>    * Generic device_group call-back function. It just allocates one
>    * iommu-group per device.
> @@ -1534,57 +1523,31 @@ struct iommu_group *generic_single_device_group(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(generic_single_device_group);
>   
> -/*
> - * Use standard PCI bus topology, isolation features, and DMA alias quirks
> - * to find or create an IOMMU group for a device.
> - */
> -struct iommu_group *pci_device_group(struct device *dev)
> +static struct iommu_group *pci_group_alloc_non_isolated(void)
Maybe iommu_group_alloc_non_isolated() would be a better name, since that's all it does.

Ideally, iommu_group_alloc() would add a flag for isolated/not-isolated default tagging,
but that would involve more twiddling to other files, that doesn't seem worth the effort.
So the fcn rename will do.

>   {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct group_for_pci_data data;
> -	struct pci_bus *bus;
> -	struct iommu_group *group = NULL;
> -	u64 devfns[4] = { 0 };
> +	struct iommu_group *group;
>   
> -	if (WARN_ON(!dev_is_pci(dev)))
> -		return ERR_PTR(-EINVAL);
> +	group = iommu_group_alloc();
> +	if (IS_ERR(group))
> +		return group;
> +	group->bus_data |= BUS_DATA_PCI_NON_ISOLATED;
> +	return group;
> +}
>   
> -	/*
> -	 * Find the upstream DMA alias for the device.  A device must not
> -	 * be aliased due to topology in order to have its own IOMMU group.
> -	 * If we find an alias along the way that already belongs to a
> -	 * group, use it.
> -	 */
> -	if (pci_for_each_dma_alias(pdev, get_pci_alias_or_group, &data))
> -		return data.group;
> -
> -	pdev = data.pdev;
> -
> -	/*
> -	 * Continue upstream from the point of minimum IOMMU granularity
> -	 * due to aliases to the point where devices are protected from
> -	 * peer-to-peer DMA by PCI ACS.  Again, if we find an existing
> -	 * group, use it.
> -	 */
> -	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
> -		if (!bus->self)
> -			continue;
> -
> -		if (pci_acs_path_enabled(bus->self, NULL, PCI_ACS_ISOLATED))
> -			break;
> -
> -		pdev = bus->self;
> -
> -		group = iommu_group_get(&pdev->dev);
> -		if (group)
> -			return group;
> -	}
> +/*
> + * Return a group if the function has isolation restrictions related to
> + * aliases or MFD ACS.
> + */
> +static struct iommu_group *pci_get_function_group(struct pci_dev *pdev)
> +{
> +	struct iommu_group *group;
> +	DECLARE_BITMAP(devfns, 256) = {};
>   
>   	/*
>   	 * Look for existing groups on device aliases.  If we alias another
>   	 * device or another device aliases us, use the same group.
>   	 */
> -	group = get_pci_alias_group(pdev, (unsigned long *)devfns);
> +	group = get_pci_alias_group(pdev, devfns);
>   	if (group)
>   		return group;
>   
> @@ -1593,12 +1556,198 @@ struct iommu_group *pci_device_group(struct device *dev)
>   	 * slot and aliases of those funcions, if any.  No need to clear
>   	 * the search bitmap, the tested devfns are still valid.
>   	 */
> -	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
> +	group = get_pci_function_alias_group(pdev, devfns);
>   	if (group)
>   		return group;
>   
> -	/* No shared group found, allocate new */
> -	return iommu_group_alloc();
> +	/*
> +	 * When MFD's are included in the set due to ACS we assume that if ACS
> +	 * permits an internal loopback between functions it also permits the
> +	 * loopback to go downstream if a function is a bridge.
> +	 *
> +	 * It is less clear what aliases mean when applied to a bridge. For now
> +	 * be conservative and also propagate the group downstream.
> +	 */
> +	__clear_bit(pdev->devfn & 0xFF, devfns);
> +	if (!bitmap_empty(devfns, sizeof(devfns) * BITS_PER_BYTE))
> +		return pci_group_alloc_non_isolated();
> +	return NULL;
> +}
> +
> +/* Return a group if the upstream hierarchy has isolation restrictions. */
> +static struct iommu_group *pci_hierarchy_group(struct pci_dev *pdev)
> +{
> +	/*
> +	 * SRIOV functions may reside on a virtual bus, jump directly to the PFs
> +	 * bus in all cases.
> +	 */
> +	struct pci_bus *bus = pci_physfn(pdev)->bus;
> +	struct iommu_group *group;
> +
> +	/* Nothing upstream of this */
> +	if (pci_is_root_bus(bus))
> +		return NULL;
> +
> +	/*
> +	 * !self is only for SRIOV virtual busses which should have been
> +	 * excluded by pci_physfn()
> +	 */
> +	if (WARN_ON(!bus->self))
> +		return ERR_PTR(-EINVAL);
> +
> +	group = iommu_group_get(&bus->self->dev);
> +	if (!group) {
> +		/*
> +		 * If the upstream bridge needs the same group as pdev then
> +		 * there is no way for it's pci_device_group() to discover it.
> +		 */
> +		dev_err(&pdev->dev,
> +			"PCI device is probing out of order, upstream bridge device of %s is not probed yet\n",
> +			pci_name(bus->self));
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +	if (group->bus_data & BUS_DATA_PCI_NON_ISOLATED)
> +		return group;
> +	iommu_group_put(group);
> +	return NULL;
> +}
> +
> +/*
> + * For legacy PCI we have two main considerations when forming groups:
> + *
> + *  1) In PCI we can loose the RID inside the fabric, or some devices will use
> + *     the wrong RID. The PCI core calls this aliasing, but from an IOMMU
> + *     perspective it means that a PCI device may have multiple RIDs and a
> + *     single RID may represent many PCI devices. This effectively means all the
> + *     aliases must share a translation, thus group, because the IOMMU cannot
> + *     tell devices apart.
> + *
> + *  2) PCI permits a bus segment to claim an address even if the transaction
> + *     originates from an end point not the CPU. When it happens it is called
> + *     peer to peer. Claiming a transaction in the middle of the bus hierarchy
> + *     bypasses the IOMMU translation. The IOMMU subsystem rules require these
> + *     devices to be placed in the same group because they lack isolation from
> + *     each other. In PCI Express the ACS system can be used to inhibit this and
> + *     force transactions to go to the IOMMU.
> + *
> + *     From a PCI perspective any given PCI bus is either isolating or
> + *     non-isolating. Isolating means downstream originated transactions always
> + *     progress toward the CPU and do not go to other devices on the bus
> + *     segment, while non-isolating means downstream originated transactions can
> + *     progress back downstream through another device on the bus segment.
> + *
> + *     Beyond buses a multi-function device or bridge can also allow
> + *     transactions to loop back internally from one function to another.
> + *
> + *     Once a PCI bus becomes non isolating the entire downstream hierarchy of
> + *     that bus becomes a single group.
> + */
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
> +	if (group)
> +		return group;
> +
> +	switch (pci_bus_isolated(pci_physfn(pdev)->bus)) {
> +	case PCIE_ISOLATED:
> +		/* Check multi-function groups and same-bus devfn aliases */
> +		group = pci_get_function_group(pdev);
> +		if (group)
> +			return group;
> +
> +		/* No shared group found, allocate new */
> +		return iommu_group_alloc();
> +
> +	/*
> +	 * On legacy PCI there is no RID at an electrical level. On PCI-X the
> +	 * RID of the bridge may be used in some cases instead of the
> +	 * downstream's RID. This creates aliasing problems. PCI/PCI-X doesn't
> +	 * provide isolation either. The end result is that as soon as we hit a
> +	 * PCI/PCI-X bus we switch to non-isolated for the whole downstream for
> +	 * both aliasing and isolation reasons. The bridge has to be included in
> +	 * the group because of the aliasing.
> +	 */
> +	case PCI_BRIDGE_NON_ISOLATED:
> +	/* A PCIe switch where the USP has MMIO and is not isolated. */
> +	case PCIE_NON_ISOLATED:
> +		group = iommu_group_get(&pdev->bus->self->dev);
> +		if (WARN_ON(!group))
> +			return ERR_PTR(-EINVAL);
> +		/*
> +		 * No need to be concerned with aliases here since we are going
> +		 * to put the entire downstream tree in the bridge/USP's group.
> +		 */
> +		group->bus_data |= BUS_DATA_PCI_NON_ISOLATED;
> +		return group;
> +
> +	/*
> +	 * It is a PCI bus and the upstream bridge/port does not alias or allow
> +	 * P2P.
> +	 */
> +	case PCI_BUS_NON_ISOLATED:
> +	/*
> +	 * It is a PCIe switch and the DSP cannot reach the USP. The DSP's
> +	 * are not isolated from each other and share a group.
> +	 */
> +	case PCIE_SWITCH_DSP_NON_ISOLATED: {
> +		struct pci_dev *piter = NULL;
> +
> +		/*
> +		 * All the downstream devices on the bus share a group. If this
> +		 * is a PCIe switch then they will all be DSPs
> +		 */
> +		for_each_pci_dev(piter) {
> +			if (piter->bus != pdev->bus)
> +				continue;
> +			group = iommu_group_get(&piter->dev);
> +			if (group) {
> +				pci_dev_put(piter);
> +				if (WARN_ON(!(group->bus_data &
> +					      BUS_DATA_PCI_NON_ISOLATED)))
> +					group->bus_data |=
> +						BUS_DATA_PCI_NON_ISOLATED;
> +				return group;
> +			}
> +		}
> +		return pci_group_alloc_non_isolated();
> +	}
> +	default:
> +		break;
> +	}
> +	WARN_ON(true);
> +	return ERR_PTR(-EINVAL);
>   }
>   EXPORT_SYMBOL_GPL(pci_device_group);
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c36fff9d2254f8..fb9adf0562f8ef 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2093,6 +2093,9 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
>   #define no_pci_devices()	(1)
>   #define pci_dev_put(dev)	do { } while (0)
>   
> +static inline struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
> +{ return dev; }
> +
>   static inline void pci_set_master(struct pci_dev *dev) { }
>   static inline void pci_clear_master(struct pci_dev *dev) { }
>   static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }



Return-Path: <linux-pci+bounces-40354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB969C36731
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8000E4FF790
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5184C254B03;
	Wed,  5 Nov 2025 15:27:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33432E149
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356437; cv=none; b=ASPVCopvuX/cVs7+Sf/UX4pXFM8rppoW7ryHWUb748BO8MwvaZpfJT99m/xuT5gSw2XXue3VOn87EgSA+TEizCxWcJ2+pXc8fb3BWqWzZ4hlb6XnS747CMii6g+rPbaGxXVt/vog3qgiDuJfciEa5TweV474ylpymOewPxuqOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356437; c=relaxed/simple;
	bh=TDa1DdTRjz4h1URATHtFjAE0bvoyH8zjMAxoTfRq6ck=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxGMsCCKc1iRjOYOnqzJH1pM3GzxH2s6EWSJsB3wK85+oBiKDbcXKv5KglpCjGNu9h7RUFyPptKMxZAfyuRmjq1i6mO+4MXEC26hjv3NPhDiiSjCjXFkZ78zQLqCHeP5BHI1BPtV/UXIxDo6ZbIgH1zRXqdGXh/F6clcunr93FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1q1c75JzzHnGjs;
	Wed,  5 Nov 2025 23:27:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8856D1402A5;
	Wed,  5 Nov 2025 23:27:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 15:27:05 +0000
Date: Wed, 5 Nov 2025 15:27:04 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>
Subject: Re: [PATCH 3/6] PCI/IDE: Initialize an ID for all IDE streams
Message-ID: <20251105152704.00002741@huawei.com>
In-Reply-To: <20251105040055.2832866-4-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  4 Nov 2025 20:00:52 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe spec defines two types of streams - selective and link.  Each
> stream has an ID from the same bucket so a stream ID does not tell the
> type.  The spec defines an "enable" bit for every stream and required
> stream IDs to be unique among all enabled stream but there is no such
> requirement for disabled streams.
> 
> However, when IDE_KM is programming keys, an IDE-capable device needs
> to know the type of stream being programmed to write it directly to
> the hardware as keys are relatively large, possibly many of them and
> devices often struggle with keeping around rather big data not being
> used.
> 
> Walk through all streams on a device and initialise the IDs to some
> unique number, both link and selective.
> 
> The weakest part of this proposal is the host bridge ide_stream_ids_ida.
> Technically, a Stream ID only needs to be unique within a given partner
> pair. However, with "anonymous" / unassigned streams there is no convenient
> place to track the available ids. Proceed with an ida in the host bridge
> for now, but consider moving this tracking to be an ide_stream_ids_ida per
> device.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A small side discussion on whether a new type of cleanup helper makes
sense here for allocations that need to stash some data which is never
used except in __free. Bit of an odd corner case but could see something
similar for pool allocators (Which is kind of what we have here).

> ---
>  drivers/pci/pci.h       |   2 +
>  include/linux/pci-ide.h |   6 ++
>  include/linux/pci.h     |   1 +
>  drivers/pci/ide.c       | 133 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/remove.c    |   1 +
>  5 files changed, 143 insertions(+)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index d7fc741f3a26..33b3c54c62a1 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -35,8 +35,54 @@ static int sel_ide_offset(struct pci_dev *pdev,
>  				settings->stream_index, pdev->nr_ide_mem);
>  }
>  
> +static bool reserve_stream_index(struct pci_dev *pdev, u8 idx)
> +{
> +	int ret;
> +
> +	ret = ida_alloc_range(&pdev->ide_stream_ida, idx, idx, GFP_KERNEL);
> +	if (ret < 0)
> +		return false;
> +	return true;

	return ret >= 0; perhaps


> +}
> +
> +static bool reserve_stream_id(struct pci_host_bridge *hb, u8 id)
> +{
> +	int ret;
> +
> +	ret = ida_alloc_range(&hb->ide_stream_ids_ida, id, id, GFP_KERNEL);
> +	if (ret < 0)
> +		return false;
> +	return true;

	return ret >= 0;

> +}
> +
> +static bool claim_stream(struct pci_host_bridge *hb, u8 stream_id,
> +			 struct pci_dev *pdev, u8 stream_idx)
> +{
> +	dev_info(&hb->dev, "Stream ID %d active at init\n", stream_id);
> +	if (!reserve_stream_id(hb, stream_id)) {
> +		dev_info(&hb->dev, "Failed to claim %s Stream ID %d\n",
> +			 stream_id == PCI_IDE_RESERVED_STREAM_ID ? "reserved" :
> +								   "active",
> +			 stream_id);

Good to have a comment on why we carry on anyway.

> +		return false;
> +	}
> +
> +	/* No stream index to reserve in the Link IDE case */
> +	if (!pdev)
> +		return true;
> +
> +	if (!reserve_stream_index(pdev, stream_idx)) {
> +		pci_info(pdev, "Failed to claim active Selective Stream %d\n",
> +			 stream_idx);
Likewise. Why is this not an error.
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  void pci_ide_init(struct pci_dev *pdev)
>  {
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>  	u16 nr_link_ide, nr_ide_mem, nr_streams;
>  	u16 ide_cap;
>  	u32 val;
> @@ -83,6 +129,7 @@ void pci_ide_init(struct pci_dev *pdev)
>  		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
>  		int nr_assoc;
>  		u32 val;
> +		u8 id;
>  
>  		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
>  
> @@ -98,6 +145,51 @@ void pci_ide_init(struct pci_dev *pdev)
>  		}
>  
>  		nr_ide_mem = nr_assoc;
> +
> +		/*
> +		 * Claim Stream IDs and Selective Stream blocks that are already
> +		 * active on the device
> +		 */
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
> +		id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
> +		if ((val & PCI_IDE_SEL_CTL_EN) &&
> +		    !claim_stream(hb, id, pdev, i))
> +			return;
Related to above, I'm not sure why we just eat this problem with a print.

> +	}
> +
> +	/* Reserve link stream-ids that are already active on the device */
> +	for (u16 i = 0; i < nr_link_ide; ++i) {
> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 + i * PCI_IDE_LINK_BLOCK_SIZE;
> +		u8 id;
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_LINK_CTL_0, &val);
> +		id = FIELD_GET(PCI_IDE_LINK_CTL_ID, val);
> +		if ((val & PCI_IDE_LINK_CTL_EN) &&
> +		    !claim_stream(hb, id, NULL, -1))
> +			return;
> +	}


> @@ -301,6 +393,28 @@ void pci_ide_stream_release(struct pci_ide *ide)
>  }
>  EXPORT_SYMBOL_GPL(pci_ide_stream_release);
>  
> +struct pci_ide_stream_id {
> +	struct pci_host_bridge *hb;
> +	u8 stream_id;
> +};
> +
> +static struct pci_ide_stream_id *alloc_stream_id(struct pci_host_bridge *hb,
> +						 u8 stream_id,
> +						 struct pci_ide_stream_id *sid)

Doesn't feel like an allocation function to me. Maybe a rename if
it doesn't gain some allocation abilities later?

> +{
> +	if (!reserve_stream_id(hb, stream_id))
> +		return NULL;
> +
> +	*sid = (struct pci_ide_stream_id) {
> +		.hb = hb,
> +		.stream_id = stream_id,
> +	};
> +
> +	return sid;
> +}
> +DEFINE_FREE(free_stream_id, struct pci_ide_stream_id *,
> +	    if (_T) ida_free(&_T->hb->ide_stream_ids_ida, _T->stream_id))
> +
>  /**
>   * pci_ide_stream_register() - Prepare to activate an IDE Stream
>   * @ide: IDE settings descriptor
> @@ -313,6 +427,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  {
>  	struct pci_dev *pdev = ide->pdev;
>  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_ide_stream_id __sid;
>  	u8 ep_stream, rp_stream;
>  	int rc;
>  
> @@ -321,6 +436,13 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  		return -ENXIO;
>  	}
>  
> +	struct pci_ide_stream_id *sid __free(free_stream_id) =
> +		alloc_stream_id(hb, ide->stream_id, &__sid);

Given the use of __sid as magic storage, I wonder if this can
be a CLASS with that storage wrapped up alongside a flag
we clear to make the destructor a no op. Similar to what happens for
spin_lock_irqsave where we stash flags etc via __DEFINE_UNLOCK_GUARD() 

Would need something a little more complex than current retain_and_null_ptr()
as it would need to set _T.ptr = NULL rather that _T = NULL.


> +	if (!sid) {
> +		pci_err(pdev, "Setup fail: Stream ID %d in use\n", ide->stream_id);
> +		return -EBUSY;
> +	}
> +
>  	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
>  	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
>  	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> @@ -335,6 +457,9 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  
>  	ide->name = no_free_ptr(name);
>  
> +	/* Stream ID reservation recorded in @ide is now successfully registered */
> +	retain_and_null_ptr(sid);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_ide_stream_register);




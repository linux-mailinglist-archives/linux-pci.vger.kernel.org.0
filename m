Return-Path: <linux-pci+bounces-36034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E369B5522A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269C0188961C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F66313278;
	Fri, 12 Sep 2025 14:46:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDC30F929;
	Fri, 12 Sep 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688398; cv=none; b=LLb2ItO0pBMYTEZrT93Az9G41ucV70ZOM9vCxfpCrc5ZsyHJ/TWSXGy2OeXMkys4FXv7XW9l9YE7COMzTji6t9C4SgvBBnfJjHRQTwMNHHQYiUf6LySEC4Gdsj4AeJKn4v2dA33NU4uD8sfgrswNFH44uHkwYdeNbnHR5AH+Cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688398; c=relaxed/simple;
	bh=qpos8UYcYHeDsSyXUrLuKLKgAQxmNb6sTZWED5/xCu4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK0kPa5qYoMgDPb9xwvX6rrOmjZ17xpaKW50TJSgeRsXuEEsCGjbIlFJs2aRxkpom/hgd3Ns48ipcbHUTwI9kkfcWdvuWzpHEvz3SOFyBm2E1+u7l/aKP56uTW+RLe7emuzObb45L60T3chFIVYXoh9pjV1LMZEtNzW6mSVXGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNcfK2103z6D8bZ;
	Fri, 12 Sep 2025 22:45:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A187F1401F4;
	Fri, 12 Sep 2025 22:46:31 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:46:31 +0200
Date: Fri, 12 Sep 2025 15:46:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 01/16] cxl/regs: Add cxl_unmap_component_regs()
Message-ID: <20250912154629.00007db4@huawei.com>
In-Reply-To: <20250730214718.10679-2-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-2-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 16:47:03 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

Hi Ben,

Whilst I know there has been some discussion of whether it is appropriate
to enable this functionality without a full use case and definite confirmation
someone is going to use it, I'm loath to leave completely unread code
on list.  (you talk about this in the cover letter).

> In order to allocate the MSI/-X interrupt for CXL error isolation the
> PCIe portdrv driver needs to map the MMIO-space isolation capability
> register that contains the interrupt vector. The CXL core already
> provides a function to map registers in this space:
> cxl_map_component_regs(). The mappings given this function are managed

given to, or returned by?

> by devres. If the isolation registers are left mapped by the PCIe
> portdrv driver, the CXL driver will run into a devres conflict when it
> goes to map the same registers during probe.
> 
> Add cxl_unmap_component_regs() to be called from the PCIe portdrv
> driver. This function will unwind the devres allocations done by
> cxl_map_component_regs(), which will allow the PCIe portdrv driver to
> map the isolation capability register without conflicts.
> 
> Factor out the register mapping retrieval code in
> cxl_map_component_regs() to be reused by cxl_map/unmap_component_regs().
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/regs.c | 77 +++++++++++++++++++++++++++++++----------
>  drivers/cxl/cxl.h       |  3 ++
>  2 files changed, 62 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index b8e767a9571c..da8e668a3b70 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -201,40 +201,81 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
> -int cxl_map_component_regs(const struct cxl_register_map *map,
> +struct mapinfo {
> +	const struct cxl_reg_map *rmap;
> +	void __iomem **addr;
> +};
> +
> +static int cxl_get_mapinfo(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> -			   unsigned long map_mask)
> +			   unsigned long map_mask, struct mapinfo *info)
>  {
> -	struct device *host = map->host;
> -	struct mapinfo {
> -		const struct cxl_reg_map *rmap;
> -		void __iomem **addr;
> -	} mapinfo[] = {
> +	struct mapinfo mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
>  	};
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
> -		struct mapinfo *mi = &mapinfo[i];

Whilst the usefulness of this local variable is reduced I think
it is still justified and keeping it will reduce the churn
here somewhat.

> -		resource_size_t addr;
> -		resource_size_t length;
> -
> -		if (!mi->rmap->valid)
> +		if (!mapinfo[i].rmap->valid)
>  			continue;
> -		if (!test_bit(mi->rmap->id, &map_mask))
> +		if (!test_bit(mapinfo[i].rmap->id, &map_mask))
>  			continue;
> -		addr = map->resource + mi->rmap->offset;
> -		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
> -		if (!*(mi->addr))
> -			return -ENOMEM;
> +
> +		*info = mapinfo[i];
> +		return 0;

I'm struggling to see how this logic works.  We now only find the first
entry in mapinfo that is valid? The new cxl_map_component_regs()
doesn't seem to include a loop either so it's not that we enter here
multiple times.


I think this only works if only one bit is set in map_mask?
It is always called like that, but the function doesn't check it and
if we are going to always call it with BIT(X) then pass X in instead
that making it inherently only deal with a one hot bitmap.


>  	}
>  
> +	return -ENXIO;
> +}
> +
> +int cxl_map_component_regs(const struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
> +			   unsigned long map_mask)

Similarly I'd make this the bit position not the bitmap with
1 bit set.

> +{
> +	struct device *host = map->host;
> +	resource_size_t addr, length;
> +	struct mapinfo mi;
> +	int rc;
> +
> +	rc = cxl_get_mapinfo(map, regs, map_mask, &mi);
> +	if (rc)
> +		return rc;
> +
> +	addr = map->resource + mi.rmap->offset;
> +	length = mi.rmap->size;
> +	*mi.addr = devm_cxl_iomap_block(host, addr, length);
> +	if (!(*mi.addr))
> +		return -ENOMEM;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, "CXL");
>  
> +int cxl_unmap_component_regs(const struct cxl_register_map *map,
> +			     struct cxl_component_regs *regs,
> +			     unsigned long map_mask)
And this one.

> +{
> +	struct device *host = map->host;
> +	resource_size_t addr, length;
> +	struct mapinfo mi;
> +	int rc;
> +
> +	rc = cxl_get_mapinfo(map, regs, map_mask, &mi);
> +	if (rc)
> +		return rc;
> +
> +	if (!(*mi.addr))
> +		return 0;
> +
> +	addr = map->resource + mi.rmap->offset;
> +	length = mi.rmap->size;
> +
> +	devm_iounmap(host, *mi.addr);
> +	devm_release_mem_region(host, addr, length);

Add a little helper for devm_cxl_iounmap_block()
So that it clearly pairs with what happens in devm_cxl_iomap_block()


> +	return 0;
> +}



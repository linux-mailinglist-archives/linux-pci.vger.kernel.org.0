Return-Path: <linux-pci+bounces-13817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9489902BD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4EE1C20884
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912815A84D;
	Fri,  4 Oct 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVmSflaH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529115A849
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043900; cv=none; b=iXbScDddES8mv5ki2zKwtEakQN4Jrh/C+kMZPu0bcHkNgkdIjbkZtJZTdu+NvgSjr5/SQkhAezN0qEahtLo43+Ug1xWTjbgTIDfRw6cA2vGUdd7oZrX63gn7p3AxWY59oIM6PW97zJqKn6wF0b/PPsLdrh7ZEx9An/uodnvENTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043900; c=relaxed/simple;
	bh=FWmCeCiGAFTq+VGmLPUdXB6DgVd+vZC0Y9E51O19jhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELVnVARGlc6fmZ2qOUuHwMYUc5b544Iwdlzm46Ma1MMPiq6LkhKAmIaJ4Y/9EB78cxbOAk+OIH74SA4krurhx7kCzw/IkNMoSYfhPaHEMtmsXnzmcxTCQBNyVKhRuFxlRmOlW8DbE7+/N0KrLXin5dwcCzKSrjypWGWEMF/f2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVmSflaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCAFC4CEC6;
	Fri,  4 Oct 2024 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728043900;
	bh=FWmCeCiGAFTq+VGmLPUdXB6DgVd+vZC0Y9E51O19jhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVmSflaHNhts9CbbDUxcFcCtzN5T2IcrtuvAh6Qj/W3U9s9nKrUAvN9a2u3gAAgZN
	 N4rRixiaxQBYMNvfsGBysyKvp0u3u3I3/krsn//SPJfrAy/3dlxuKwaHZprFwUEX+U
	 ScqpHQegoSaZCdkoJ9EeZZqoTBHj4NsuLMxB5LEqNkQff3Rh04JkhZq8IafVox8D+m
	 km1XX/vKiLR0IYD4cGqa+gpaZHIpTfYRW11nGn+wS6RpbLuHwvY5MGC3wDdW+zTpdU
	 OxlDEiESZKgMQQhP/yGhxI3+lC5kU6rTHWgz4GawiFIbJmC/cbzPtQAf8Ju+svWeDX
	 F6T18MmFFI1jg==
Date: Fri, 4 Oct 2024 14:11:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v3 6/7] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
Message-ID: <Zv_bdtrQFSDulOkA@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-7-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 02:07:41PM +0900, Damien Le Moal wrote:
> Modify the endpoint test driver to use the functions pci_epc_mem_map()
> and pci_epc_mem_unmap() for the read, write and copy tests. For each
> test case, the transfer (dma or mmio) are executed in a loop to ensure
> that potentially partial mappings returned by pci_epc_mem_map() are
> correctly handled.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
>  1 file changed, 193 insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c2ed6eae53a..a73bc0771d35 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -317,91 +317,92 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>  static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  			      struct pci_epf_test_reg *reg)
>  {
> -	int ret;
> -	void __iomem *src_addr;
> -	void __iomem *dst_addr;
> -	phys_addr_t src_phys_addr;
> -	phys_addr_t dst_phys_addr;
> +	int ret = 0;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> -	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	struct pci_epc_map src_map, dst_map;
> +	u64 src_addr = reg->src_addr;
> +	u64 dst_addr = reg->dst_addr;
> +	size_t copy_size = reg->size;
> +	ssize_t map_size = 0;
> +	void *copy_buf = NULL, *buf;
>  
> -	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
> -	if (!src_addr) {
> -		dev_err(dev, "Failed to allocate source address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
> -			       reg->src_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map source address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		goto err_src_addr;
> -	}
> -
> -	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
> -	if (!dst_addr) {
> -		dev_err(dev, "Failed to allocate destination address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> -		ret = -ENOMEM;
> -		goto err_src_map_addr;
> -	}
> -
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
> -			       reg->dst_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map destination address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> -		goto err_dst_addr;
> -	}
> -
> -	ktime_get_ts64(&start);
>  	if (reg->flags & FLAG_USE_DMA) {
>  		if (epf_test->dma_private) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> -			goto err_map_addr;
> +			goto set_status;
>  		}
> -
> -		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 src_phys_addr, reg->size, 0,
> -						 DMA_MEM_TO_MEM);
> -		if (ret)
> -			dev_err(dev, "Data transfer failed\n");
>  	} else {
> -		void *buf;
> -
> -		buf = kzalloc(reg->size, GFP_KERNEL);
> -		if (!buf) {
> +		copy_buf = kzalloc(copy_size, GFP_KERNEL);
> +		if (!copy_buf) {
>  			ret = -ENOMEM;
> -			goto err_map_addr;
> +			goto set_status;
>  		}
> -
> -		memcpy_fromio(buf, src_addr, reg->size);
> -		memcpy_toio(dst_addr, buf, reg->size);
> -		kfree(buf);
> +		buf = copy_buf;
>  	}
> -	ktime_get_ts64(&end);
> -	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
> -				reg->flags & FLAG_USE_DMA);
>  
> -err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);

You are introducing an API where we need to do a while() loop around all
pci_epc_mem_map calls, because the API allows you to return a
map->pci_size that is smaller than the requested size.

What I don't understand is that the only driver that implements this API
is DWC PCIe EP, and that function currently never returns a map->pci_size
smaller than requested, so from just looking at this series by itself,
this API seems way too complicated for the only single implementer.

I think that you need to also include the patch that implements map_align()
for rk3399 in this series (without any other rk3399 patches), such that the
API actually makes sense.

Because without that patch, the API seems to be way more complicated than
it needs to be.



With this new API, it is a bit unfortunate that all EPF drivers will now
need do a while() loop around their map() calls, just because of rk3399.

The current map functions already return an -EINVAL if you try to map
something that is larger than the window size. Isn't the problem for rk3399
that the window size is just 1 MB. Can't you simply return -EINVAL if the
allocation (including the extra bytes needed for alignment) exceeds 1 MB?


By default, pcitest.sh uses these sizes for read write transfers:

echo "Read Tests"
echo

pcitest -r -s 1
pcitest -r -s 1024
pcitest -r -s 1025
pcitest -r -s 1024000
pcitest -r -s 1024001
echo

echo "Write Tests"
echo

pcitest -w -s 1
pcitest -w -s 1024
pcitest -w -s 1025
pcitest -w -s 1024000
pcitest -w -s 1024001

All that should be way smaller than 1 MB, including alignment.
Specifying something larger will (for many platforms) fail.


I understand that certain EPF drivers will need to map buffers larger
than that. But perhaps we can keep pci-epf-test.c simple, and introduce
the more complex logic in EPF drivers that actually need it?

E.g. introduce a PCI EP API, e.g. pci_epc_max_mapping_for_address(),
that given a PCI address, returns the largest buffer the EPC can map.

Simple drivers like pci-epf-test can then choose to only support the simple
case (no looping case), and return error (e.g. -EINVAL) for buffers larger
than pci_epc_max_mapping_for_address().

More complicated EPF drivers can then choose if they want to support only
the simple case (no looping case), but can also choose to support buffers
larger than pci_epc_max_mapping_for_address(), using looping (I assume that
each loop iteration will be able to map (at least) the same amount as the
first loop iteration).
The looping case and the non-looping case can even be implemented in their
separate function.

I personally, think that there is value in keeping pci-epf-test.c as simple
as possible, so that people can get familiar with the PCI endpoint framework.
More complicated logic can be found in other EPF drivers, e.g. pci-epf-ntb.c
and pci-epf-vntb.c.

Thoughts?


If we implement pci_epc_max_mapping_for_address(), and then the looping and
non-looping case in separate functions, perhaps we could even implement it
in pci-epf-test.c, as having more functions will help with the readability,
but with the patch as it looks right, I do feel like the readability gets
quite worse.


> +	while (copy_size) {
> +		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
> +				      src_addr, copy_size, &src_map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map source address\n");
> +			reg->status = STATUS_SRC_ADDR_INVALID;
> +			goto free_buf;
> +		}
> +
> +		ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
> +					   dst_addr, copy_size, &dst_map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map destination address\n");
> +			reg->status = STATUS_DST_ADDR_INVALID;
> +			pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no,
> +					  &src_map);
> +			goto free_buf;
> +		}
> +
> +		map_size = min_t(size_t, dst_map.pci_size, src_map.pci_size);
> +
> +		ktime_get_ts64(&start);
> +		if (reg->flags & FLAG_USE_DMA) {
> +			ret = pci_epf_test_data_transfer(epf_test,
> +					dst_map.phys_addr, src_map.phys_addr,
> +					map_size, 0, DMA_MEM_TO_MEM);
> +			if (ret) {
> +				dev_err(dev, "Data transfer failed\n");
> +				goto unmap;
> +			}
> +		} else {
> +			memcpy_fromio(buf, src_map.virt_addr, map_size);
> +			memcpy_toio(dst_map.virt_addr, buf, map_size);
> +			buf += map_size;
> +		}
> +		ktime_get_ts64(&end);
>  
> -err_dst_addr:
> -	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
> +		copy_size -= map_size;
> +		src_addr += map_size;
> +		dst_addr += map_size;
>  
> -err_src_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &dst_map);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &src_map);
> +		map_size = 0;
> +	}
>  
> -err_src_addr:
> -	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
> +	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start,
> +				&end, reg->flags & FLAG_USE_DMA);
>  
> -err:
> +unmap:
> +	if (map_size) {
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &dst_map);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &src_map);
> +	}
> +
> +free_buf:
> +	kfree(copy_buf);
> +
> +set_status:
>  	if (!ret)
>  		reg->status |= STATUS_COPY_SUCCESS;
>  	else
> @@ -411,82 +412,89 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  			      struct pci_epf_test_reg *reg)
>  {
> -	int ret;
> -	void __iomem *src_addr;
> -	void *buf;
> +	int ret = 0;
> +	void *src_buf, *buf;
>  	u32 crc32;
> -	phys_addr_t phys_addr;
> +	struct pci_epc_map map;
>  	phys_addr_t dst_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> -	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> +	u64 src_addr = reg->src_addr;
> +	size_t src_size = reg->size;
> +	ssize_t map_size = 0;
>  
> -	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> -	if (!src_addr) {
> -		dev_err(dev, "Failed to allocate address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> +	src_buf = kzalloc(src_size, GFP_KERNEL);
> +	if (!src_buf) {
>  		ret = -ENOMEM;
> -		goto err;
> +		goto set_status;
>  	}
> +	buf = src_buf;
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
> -			       reg->src_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		goto err_addr;
> -	}
> -
> -	buf = kzalloc(reg->size, GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> -		goto err_map_addr;
> -	}
> +	while (src_size) {
> +		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
> +					   src_addr, src_size, &map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map address\n");
> +			reg->status = STATUS_SRC_ADDR_INVALID;
> +			goto free_buf;
> +		}
>  
> -	if (reg->flags & FLAG_USE_DMA) {
> -		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
> -					       DMA_FROM_DEVICE);
> -		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> -			dev_err(dev, "Failed to map destination buffer addr\n");
> -			ret = -ENOMEM;
> -			goto err_dma_map;
> +		map_size = map.pci_size;
> +		if (reg->flags & FLAG_USE_DMA) {
> +			dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
> +						       DMA_FROM_DEVICE);
> +			if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> +				dev_err(dev,
> +					"Failed to map destination buffer addr\n");
> +				ret = -ENOMEM;
> +				goto unmap;
> +			}
> +
> +			ktime_get_ts64(&start);
> +			ret = pci_epf_test_data_transfer(epf_test,
> +					dst_phys_addr, map.phys_addr,
> +					map_size, src_addr, DMA_DEV_TO_MEM);
> +			if (ret)
> +				dev_err(dev, "Data transfer failed\n");
> +			ktime_get_ts64(&end);
> +
> +			dma_unmap_single(dma_dev, dst_phys_addr, map_size,
> +					 DMA_FROM_DEVICE);
> +
> +			if (ret)
> +				goto unmap;
> +		} else {
> +			ktime_get_ts64(&start);
> +			memcpy_fromio(buf, map.virt_addr, map_size);
> +			ktime_get_ts64(&end);
>  		}
>  
> -		ktime_get_ts64(&start);
> -		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 phys_addr, reg->size,
> -						 reg->src_addr, DMA_DEV_TO_MEM);
> -		if (ret)
> -			dev_err(dev, "Data transfer failed\n");
> -		ktime_get_ts64(&end);
> +		src_size -= map_size;
> +		src_addr += map_size;
> +		buf += map_size;
>  
> -		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
> -				 DMA_FROM_DEVICE);
> -	} else {
> -		ktime_get_ts64(&start);
> -		memcpy_fromio(buf, src_addr, reg->size);
> -		ktime_get_ts64(&end);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
> +		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
> -				reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start,
> +				&end, reg->flags & FLAG_USE_DMA);
>  
> -	crc32 = crc32_le(~0, buf, reg->size);
> +	crc32 = crc32_le(~0, src_buf, reg->size);
>  	if (crc32 != reg->checksum)
>  		ret = -EIO;
>  
> -err_dma_map:
> -	kfree(buf);
> -
> -err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
> +unmap:
> +	if (map_size)
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
>  
> -err_addr:
> -	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
> +free_buf:
> +	kfree(src_buf);
>  
> -err:
> +set_status:
>  	if (!ret)
>  		reg->status |= STATUS_READ_SUCCESS;
>  	else
> @@ -496,71 +504,79 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  			       struct pci_epf_test_reg *reg)
>  {
> -	int ret;
> -	void __iomem *dst_addr;
> -	void *buf;
> -	phys_addr_t phys_addr;
> +	int ret = 0;
> +	void *dst_buf, *buf;
> +	struct pci_epc_map map;
>  	phys_addr_t src_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> -	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> +	u64 dst_addr = reg->dst_addr;
> +	size_t dst_size = reg->size;
> +	ssize_t map_size = 0;
>  
> -	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> -	if (!dst_addr) {
> -		dev_err(dev, "Failed to allocate address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> +	dst_buf = kzalloc(dst_size, GFP_KERNEL);
> +	if (!dst_buf) {
>  		ret = -ENOMEM;
> -		goto err;
> +		goto set_status;
>  	}
> +	get_random_bytes(dst_buf, dst_size);
> +	reg->checksum = crc32_le(~0, dst_buf, dst_size);
> +	buf = dst_buf;
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
> -			       reg->dst_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> -		goto err_addr;
> -	}
> -
> -	buf = kzalloc(reg->size, GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> -		goto err_map_addr;
> -	}
> -
> -	get_random_bytes(buf, reg->size);
> -	reg->checksum = crc32_le(~0, buf, reg->size);
> -
> -	if (reg->flags & FLAG_USE_DMA) {
> -		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
> -					       DMA_TO_DEVICE);
> -		if (dma_mapping_error(dma_dev, src_phys_addr)) {
> -			dev_err(dev, "Failed to map source buffer addr\n");
> -			ret = -ENOMEM;
> -			goto err_dma_map;
> +	while (dst_size) {
> +		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
> +					   dst_addr, dst_size, &map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map address\n");
> +			reg->status = STATUS_DST_ADDR_INVALID;
> +			goto free_buf;
>  		}
>  
> -		ktime_get_ts64(&start);
> +		map_size = map.pci_size;
> +		if (reg->flags & FLAG_USE_DMA) {
> +			src_phys_addr = dma_map_single(dma_dev, buf, map_size,
> +						       DMA_TO_DEVICE);
> +			if (dma_mapping_error(dma_dev, src_phys_addr)) {
> +				dev_err(dev,
> +					"Failed to map source buffer addr\n");
> +				ret = -ENOMEM;
> +				goto unmap;
> +			}
> +
> +			ktime_get_ts64(&start);
> +
> +			ret = pci_epf_test_data_transfer(epf_test,
> +						map.phys_addr, src_phys_addr,
> +						map_size, dst_addr,
> +						DMA_MEM_TO_DEV);
> +			if (ret)
> +				dev_err(dev, "Data transfer failed\n");
> +			ktime_get_ts64(&end);
> +
> +			dma_unmap_single(dma_dev, src_phys_addr, map_size,
> +					 DMA_TO_DEVICE);
> +
> +			if (ret)
> +				goto unmap;
> +		} else {
> +			ktime_get_ts64(&start);
> +			memcpy_toio(map.virt_addr, buf, map_size);
> +			ktime_get_ts64(&end);
> +		}
>  
> -		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> -						 src_phys_addr, reg->size,
> -						 reg->dst_addr,
> -						 DMA_MEM_TO_DEV);
> -		if (ret)
> -			dev_err(dev, "Data transfer failed\n");
> -		ktime_get_ts64(&end);
> +		dst_size -= map_size;
> +		dst_addr += map_size;
> +		buf += map_size;
>  
> -		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
> -				 DMA_TO_DEVICE);
> -	} else {
> -		ktime_get_ts64(&start);
> -		memcpy_toio(dst_addr, buf, reg->size);
> -		ktime_get_ts64(&end);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
> +		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
> -				reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start,
> +				&end, reg->flags & FLAG_USE_DMA);
>  
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> @@ -568,16 +584,14 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  	 */
>  	usleep_range(1000, 2000);
>  
> -err_dma_map:
> -	kfree(buf);
> -
> -err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
> +unmap:
> +	if (map_size)
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
>  
> -err_addr:
> -	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
> +free_buf:
> +	kfree(dst_buf);
>  
> -err:
> +set_status:
>  	if (!ret)
>  		reg->status |= STATUS_WRITE_SUCCESS;
>  	else
> -- 
> 2.46.2
> 


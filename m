Return-Path: <linux-pci+bounces-27087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92DAA6CB0
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD9B1BC04BD
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0107F22AE6B;
	Fri,  2 May 2025 08:42:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D822AE6D;
	Fri,  2 May 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175324; cv=none; b=su46rkU+lKRD83XDsrYfCixwMq4EIVKIxaJ5rcf/hihehPPMwUz0ZVhaTtcbjX3luxRqoP4XD/XvvHU5crlWeDtpP/anHytygFEv2oVfs2GODwBvkq+rKfkhJrhWlc2aKV8PO3mjGTaMphvVxaU0j+YYH1UrNEuV0fzmRhdqCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175324; c=relaxed/simple;
	bh=P/tDpIjlaLLUMdrFjVAn6eBkwk3xBBEevAOjFD94nN4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb4gEvqQ5PlJQNRQbOfrfVrPrc07P9CMMV79bpR/C0AfTk76kuw2WnEvGjIgCXixqR9xObS5Yl6xeHGGHFfnaFzsihKa3+55GRlX2ApdV2yhvF1Ehzm94m6bdm2925YkNmvriXYuBWrhaDrDPVlv7GMlRrGMeg6BcXfpFLOCPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zpkmr0wN1z6K90T;
	Fri,  2 May 2025 16:37:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 028471400D9;
	Fri,  2 May 2025 16:41:59 +0800 (CST)
Received: from localhost (10.48.156.249) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 May
 2025 10:41:58 +0200
Date: Fri, 2 May 2025 09:41:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Erick Karanja <karanja99erick@gmail.com>
CC: <manivannan.sadhasivam@linaro.org>, <kw@linux.com>, <kishon@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <julia.lawall@inria.fr>
Subject: Re: [PATCH 1/2] PCI: endpoint: Replace manual mutex handling with
 scoped_guard()
Message-ID: <20250502094155.00003f74@huawei.com>
In-Reply-To: <49b27386eb57432d204153794bfd20f78aa72253.1746114596.git.karanja99erick@gmail.com>
References: <cover.1746114596.git.karanja99erick@gmail.com>
	<49b27386eb57432d204153794bfd20f78aa72253.1746114596.git.karanja99erick@gmail.com>
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

On Thu,  1 May 2025 18:56:11 +0300
Erick Karanja <karanja99erick@gmail.com> wrote:

In the patch name always mention which driver it is.


> This refactor replaces manual mutex lock/unlock with scoped_guard()
> in places where early exits use goto. Using scoped_guard()
> avoids error-prone unlock paths and simplifies control flow.

In this case that only works because you've replicated the other
unwinding coding in various error paths.  That's more error prone
so I'm not convinced this particular case is a good use of scoped cleanup.

> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 358 +++++++++----------
>  1 file changed, 166 insertions(+), 192 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 6643a88c7a0c..57ef522c3d07 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -323,57 +323,52 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
>  	if (buf_info->size < SZ_4K)
>  		return pci_epf_mhi_iatu_read(mhi_cntrl, buf_info);
>  
> -	mutex_lock(&epf_mhi->lock);
> -
> -	config.direction = DMA_DEV_TO_MEM;
> -	config.src_addr = buf_info->host_addr;
> +	scoped_guard(mutex, &epf_mhi->lock) {

I'd be tempted to use
guard(mutex)(&epf_mhi->lock); given your scope goes to the end
of the function.

That will reduce the diff and make it easier to spot any functional changes...

> +		config.direction = DMA_DEV_TO_MEM;
> +		config.src_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> +		ret = dmaengine_slave_config(chan, &config);
> +		if (ret) {
> +			dev_err(dev, "Failed to configure DMA channel\n");
> +			return ret;
> +		}
>  
> -	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> -				  DMA_FROM_DEVICE);
> -	ret = dma_mapping_error(dma_dev, dst_addr);
> -	if (ret) {
> -		dev_err(dev, "Failed to map remote memory\n");
> -		goto err_unlock;
> -	}
> +		dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> +					  DMA_FROM_DEVICE);
> +		ret = dma_mapping_error(dma_dev, dst_addr);
> +		if (ret) {
> +			dev_err(dev, "Failed to map remote memory\n");
> +			return ret;
> +		}
>  
> -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> -	if (!desc) {
> -		dev_err(dev, "Failed to prepare DMA\n");
> -		ret = -EIO;
> -		goto err_unmap;
> -	}
> +		desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> +						   DMA_DEV_TO_MEM,
> +						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +		if (!desc) {
> +			dev_err(dev, "Failed to prepare DMA\n");
> +			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);

In cases like this where is other cleanup to do the advantages of scoped
cleanup are greatly reduced.  I'm not sure it is a good idea here.



> +			return -EIO;
> +		}
>  
> -	desc->callback = pci_epf_mhi_dma_callback;
> -	desc->callback_param = &complete;
> +		desc->callback = pci_epf_mhi_dma_callback;
> +		desc->callback_param = &complete;
>  
> -	cookie = dmaengine_submit(desc);
> -	ret = dma_submit_error(cookie);
> -	if (ret) {
> -		dev_err(dev, "Failed to do DMA submit\n");
> -		goto err_unmap;
> -	}
> +		cookie = dmaengine_submit(desc);
> +		ret = dma_submit_error(cookie);
> +		if (ret) {
> +			dev_err(dev, "Failed to do DMA submit\n");
> +			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> +			return ret;
> +		}
>  
> -	dma_async_issue_pending(chan);
> -	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
> -	if (!ret) {
> -		dev_err(dev, "DMA transfer timeout\n");
> -		dmaengine_terminate_sync(chan);
> -		ret = -ETIMEDOUT;

This path previously hit the err_unmap condition and now it doesn't.
Why that functional change?

> +		dma_async_issue_pending(chan);
> +		ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
> +		if (!ret) {
> +			dev_err(dev, "DMA transfer timeout\n");
> +			dmaengine_terminate_sync(chan);
> +			ret = -ETIMEDOUT;

return -ETIMEDOUT;

> +		}
>  	}
> -
Even in good path were were previously unmapping and now we aren't.
> -err_unmap:
> -	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> -err_unlock:
> -	mutex_unlock(&epf_mhi->lock);
> -
>  	return ret;
return 0; //assuming no way to get here with ret set.

>  }
>  
> @@ -394,57 +389,52 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  	if (buf_info->size < SZ_4K)
>  		return pci_epf_mhi_iatu_write(mhi_cntrl, buf_info);
>  
> -	mutex_lock(&epf_mhi->lock);
> -
> -	config.direction = DMA_MEM_TO_DEV;
> -	config.dst_addr = buf_info->host_addr;
> +	scoped_guard(mutex, &epf_mhi->lock) {
> +		config.direction = DMA_MEM_TO_DEV;
> +		config.dst_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> +		ret = dmaengine_slave_config(chan, &config);
> +		if (ret) {
> +			dev_err(dev, "Failed to configure DMA channel\n");
> +			return ret;
> +		}
>  
> -	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> -				  DMA_TO_DEVICE);
> -	ret = dma_mapping_error(dma_dev, src_addr);
> -	if (ret) {
> -		dev_err(dev, "Failed to map remote memory\n");
> -		goto err_unlock;
> -	}
> +		src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> +					  DMA_TO_DEVICE);
> +		ret = dma_mapping_error(dma_dev, src_addr);
> +		if (ret) {
> +			dev_err(dev, "Failed to map remote memory\n");
> +			return ret;
> +		}
>  
> -	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> -					   DMA_MEM_TO_DEV,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> -	if (!desc) {
> -		dev_err(dev, "Failed to prepare DMA\n");
> -		ret = -EIO;
> -		goto err_unmap;
> -	}
> +		desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> +						   DMA_MEM_TO_DEV,
> +						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +		if (!desc) {
> +			dev_err(dev, "Failed to prepare DMA\n");
> +			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> +			return -EIO;
> +		}
>  
> -	desc->callback = pci_epf_mhi_dma_callback;
> -	desc->callback_param = &complete;
> +		desc->callback = pci_epf_mhi_dma_callback;
> +		desc->callback_param = &complete;
>  
> -	cookie = dmaengine_submit(desc);
> -	ret = dma_submit_error(cookie);
> -	if (ret) {
> -		dev_err(dev, "Failed to do DMA submit\n");
> -		goto err_unmap;
> -	}
> +		cookie = dmaengine_submit(desc);
> +		ret = dma_submit_error(cookie);
> +		if (ret) {
> +			dev_err(dev, "Failed to do DMA submit\n");
> +			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> +			return ret;
> +		}
>  
> -	dma_async_issue_pending(chan);
> -	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
> -	if (!ret) {
> -		dev_err(dev, "DMA transfer timeout\n");
> -		dmaengine_terminate_sync(chan);
> -		ret = -ETIMEDOUT;
> +		dma_async_issue_pending(chan);
> +		ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
> +		if (!ret) {
> +			dev_err(dev, "DMA transfer timeout\n");
> +			dmaengine_terminate_sync(chan);
> +			ret = -ETIMEDOUT;
return -EITMEDOUT;
Same issue with logic change to no unmap any more.

> +		}
>  	}
> -
> -err_unmap:
> -	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> -err_unlock:
> -	mutex_unlock(&epf_mhi->lock);
> -
>  	return ret;

return 0; if no way to get here without an error set

>  }
>  
> @@ -497,67 +487,59 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
>  	dma_addr_t dst_addr;
>  	int ret;
>  
> -	mutex_lock(&epf_mhi->lock);
> +	scoped_guard(mutex, &epf_mhi->lock) {
> +		config.direction = DMA_DEV_TO_MEM;
> +		config.src_addr = buf_info->host_addr;
>  
> -	config.direction = DMA_DEV_TO_MEM;
> -	config.src_addr = buf_info->host_addr;
> +		ret = dmaengine_slave_config(chan, &config);
> +		if (ret) {
> +			dev_err(dev, "Failed to configure DMA channel\n");
> +			return ret;
> +		}
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> +		dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> +					  DMA_FROM_DEVICE);
> +		ret = dma_mapping_error(dma_dev, dst_addr);
> +		if (ret) {
> +			dev_err(dev, "Failed to map remote memory\n");
> +			return ret;
> +		}
>  
> -	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> -				  DMA_FROM_DEVICE);
> -	ret = dma_mapping_error(dma_dev, dst_addr);
> -	if (ret) {
> -		dev_err(dev, "Failed to map remote memory\n");
> -		goto err_unlock;
> -	}
> +		desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> +						   DMA_DEV_TO_MEM,
> +						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +		if (!desc) {
> +			dev_err(dev, "Failed to prepare DMA\n");
> +			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> +			return -EIO;
> +		}
>  
> -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> -	if (!desc) {
> -		dev_err(dev, "Failed to prepare DMA\n");
> -		ret = -EIO;
> -		goto err_unmap;
> -	}
> +		transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> +		if (!transfer) {
> +			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> +			return -ENOMEM;
> +		}
>  
> -	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> -	if (!transfer) {
> -		ret = -ENOMEM;
> -		goto err_unmap;
> -	}
> +		transfer->epf_mhi = epf_mhi;
> +		transfer->paddr = dst_addr;
> +		transfer->size = buf_info->size;
> +		transfer->dir = DMA_FROM_DEVICE;
> +		memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
>  
> -	transfer->epf_mhi = epf_mhi;
> -	transfer->paddr = dst_addr;
> -	transfer->size = buf_info->size;
> -	transfer->dir = DMA_FROM_DEVICE;
> -	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
> +		desc->callback = pci_epf_mhi_dma_async_callback;
> +		desc->callback_param = transfer;
>  
> -	desc->callback = pci_epf_mhi_dma_async_callback;
> -	desc->callback_param = transfer;
> +		cookie = dmaengine_submit(desc);
> +		ret = dma_submit_error(cookie);
> +		if (ret) {
> +			dev_err(dev, "Failed to do DMA submit\n");
> +			kfree(transfer);
> +			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> +			return ret;
> +		}
>  
> -	cookie = dmaengine_submit(desc);
> -	ret = dma_submit_error(cookie);
> -	if (ret) {
> -		dev_err(dev, "Failed to do DMA submit\n");
> -		goto err_free_transfer;
> +		dma_async_issue_pending(chan);
>  	}
> -
> -	dma_async_issue_pending(chan);
> -
> -	goto err_unlock;
> -
> -err_free_transfer:
> -	kfree(transfer);
> -err_unmap:
> -	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> -err_unlock:
> -	mutex_unlock(&epf_mhi->lock);
> -
>  	return ret;
>  }
>  
> @@ -576,67 +558,59 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
>  	dma_addr_t src_addr;
>  	int ret;
>  
> -	mutex_lock(&epf_mhi->lock);
> +	scoped_guard(mutex, &epf_mhi->lock) {
> +		config.direction = DMA_MEM_TO_DEV;
> +		config.dst_addr = buf_info->host_addr;
>  
> -	config.direction = DMA_MEM_TO_DEV;
> -	config.dst_addr = buf_info->host_addr;
> +		ret = dmaengine_slave_config(chan, &config);
> +		if (ret) {
> +			dev_err(dev, "Failed to configure DMA channel\n");
> +			return ret;
> +		}
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> +		src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> +					  DMA_TO_DEVICE);
> +		ret = dma_mapping_error(dma_dev, src_addr);
> +		if (ret) {
> +			dev_err(dev, "Failed to map remote memory\n");
> +			return ret;
> +		}
>  
> -	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> -				  DMA_TO_DEVICE);
> -	ret = dma_mapping_error(dma_dev, src_addr);
> -	if (ret) {
> -		dev_err(dev, "Failed to map remote memory\n");
> -		goto err_unlock;
> -	}
> +		desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> +						   DMA_MEM_TO_DEV,
> +						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +		if (!desc) {
> +			dev_err(dev, "Failed to prepare DMA\n");
> +			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> +			return -EIO;
> +		}
>  
> -	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> -					   DMA_MEM_TO_DEV,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> -	if (!desc) {
> -		dev_err(dev, "Failed to prepare DMA\n");
> -		ret = -EIO;
> -		goto err_unmap;
> -	}
> +		transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> +		if (!transfer) {
> +			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> +			return -ENOMEM;
> +		}
>  
> -	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> -	if (!transfer) {
> -		ret = -ENOMEM;
> -		goto err_unmap;
> -	}
> +		transfer->epf_mhi = epf_mhi;
> +		transfer->paddr = src_addr;
> +		transfer->size = buf_info->size;
> +		transfer->dir = DMA_TO_DEVICE;
> +		memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
>  
> -	transfer->epf_mhi = epf_mhi;
> -	transfer->paddr = src_addr;
> -	transfer->size = buf_info->size;
> -	transfer->dir = DMA_TO_DEVICE;
> -	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
> +		desc->callback = pci_epf_mhi_dma_async_callback;
> +		desc->callback_param = transfer;
>  
> -	desc->callback = pci_epf_mhi_dma_async_callback;
> -	desc->callback_param = transfer;
> +		cookie = dmaengine_submit(desc);
> +		ret = dma_submit_error(cookie);
> +		if (ret) {
> +			dev_err(dev, "Failed to do DMA submit\n");
> +			kfree(transfer);
> +			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> +			return ret;
> +		}
>  
> -	cookie = dmaengine_submit(desc);
> -	ret = dma_submit_error(cookie);
> -	if (ret) {
> -		dev_err(dev, "Failed to do DMA submit\n");
> -		goto err_free_transfer;
> +		dma_async_issue_pending(chan);
>  	}
> -
> -	dma_async_issue_pending(chan);
> -
> -	goto err_unlock;
> -
> -err_free_transfer:
> -	kfree(transfer);
> -err_unmap:
> -	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> -err_unlock:
> -	mutex_unlock(&epf_mhi->lock);
> -
>  	return ret;
>  }
>  



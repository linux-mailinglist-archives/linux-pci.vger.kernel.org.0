Return-Path: <linux-pci+bounces-902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62838811D5D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E09AB20B85
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ED228387;
	Wed, 13 Dec 2023 18:50:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C7B2;
	Wed, 13 Dec 2023 10:50:37 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so43509995ad.1;
        Wed, 13 Dec 2023 10:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493437; x=1703098237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUHLJeGU6+UjC5LkcfAXXy2KoswBEi3GJA5lIhvI+9M=;
        b=bvqzQxiXngRDi33trmZYAJXkRDvb0r/ItA8LJ0boS2YA1Sc3MZQxmqCtAee4vICOUQ
         4bvUA7l3Qgca5ZvDLtblOuN+h284gShrlNK27nR4H0Nde4WFAuD5tr+g9LWxbihBAvAb
         nmzI63lXpI9dapsjjIHLP4z3U+eVuCLVYbr79ee7XQ4udo2v/GE01NZxlXg4BqO4W4uT
         R4azumciIBIPzIicLkNJOYwtj0s/cdFWti7PaIuFvCf1aCMcFkEq78QMq9jj7UvqeF6s
         yAvVd/92+w4HpAdLCvVBNQAuymjxxeLwoVqyWBpeJIbTg8hXDfWtnyrCMGYqMQanRY1R
         k50A==
X-Gm-Message-State: AOJu0YyHN1F8b51kmYgnoI9FnSgwAowQhYH5X844uwOPGswVIkvCJN+O
	j6WjmSzEXeEmStfU491zqqFcpFcyixuNDQ==
X-Google-Smtp-Source: AGHT+IE7bi/dSCSj+q7o4GR5ZZXqTEln/XJvsbXt6SM0IV85itWWICDzOtLY50CFeREAa4BuAslZ3g==
X-Received: by 2002:a17:902:d48b:b0:1d0:c3cc:376f with SMTP id c11-20020a170902d48b00b001d0c3cc376fmr5020796plg.46.1702493436606;
        Wed, 13 Dec 2023 10:50:36 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001c9c5a1b477sm10926978plg.169.2023.12.13.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:50:36 -0800 (PST)
Date: Thu, 14 Dec 2023 03:50:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] PCI: epf-mhi: Add support for DMA async read/write
 operation
Message-ID: <20231213185034.GC924726@rocinante>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-6-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127124529.78203-6-manivannan.sadhasivam@linaro.org>

Hello,

> The driver currently supports only the sync read/write operation i.e., it
> waits for the DMA transfer to complete before returning to the caller
> (MHI stack). But it is sub-optimal and defeats the actual purpose of using
> DMA.
> 
> So let's add support for DMA async read/write operation by skipping the DMA
> transfer completion and returning to the caller immediately. When the
> completion actually happens later, the driver will be notified using the
> DMA completion handler and in turn it will notify the caller using the
> newly introduced callback in "struct mhi_ep_buf_info".
> 
> Since the DMA completion handler is invoked from the interrupt context, a
> separate workqueue (epf_mhi->dma_wq) is used to notify the caller about the
> completion of the transfer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 231 ++++++++++++++++++-
>  1 file changed, 228 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 7214f4da733b..3d09a37e5f7c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -21,6 +21,15 @@
>  /* Platform specific flags */
>  #define MHI_EPF_USE_DMA BIT(0)
>  
> +struct pci_epf_mhi_dma_transfer {
> +	struct pci_epf_mhi *epf_mhi;
> +	struct mhi_ep_buf_info buf_info;
> +	struct list_head node;
> +	dma_addr_t paddr;
> +	enum dma_data_direction dir;
> +	size_t size;
> +};
> +
>  struct pci_epf_mhi_ep_info {
>  	const struct mhi_ep_cntrl_config *config;
>  	struct pci_epf_header *epf_header;
> @@ -124,6 +133,10 @@ struct pci_epf_mhi {
>  	resource_size_t mmio_phys;
>  	struct dma_chan *dma_chan_tx;
>  	struct dma_chan *dma_chan_rx;
> +	struct workqueue_struct *dma_wq;
> +	struct work_struct dma_work;
> +	struct list_head dma_list;
> +	spinlock_t list_lock;
>  	u32 mmio_size;
>  	int irq;
>  };
> @@ -418,6 +431,198 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  	return ret;
>  }
>  
> +static void pci_epf_mhi_dma_worker(struct work_struct *work)
> +{
> +	struct pci_epf_mhi *epf_mhi = container_of(work, struct pci_epf_mhi, dma_work);
> +	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
> +	struct pci_epf_mhi_dma_transfer *itr, *tmp;
> +	struct mhi_ep_buf_info *buf_info;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&epf_mhi->list_lock, flags);
> +	list_splice_tail_init(&epf_mhi->dma_list, &head);
> +	spin_unlock_irqrestore(&epf_mhi->list_lock, flags);
> +
> +	list_for_each_entry_safe(itr, tmp, &head, node) {
> +		list_del(&itr->node);
> +		dma_unmap_single(dma_dev, itr->paddr, itr->size, itr->dir);
> +		buf_info = &itr->buf_info;
> +		buf_info->cb(buf_info);
> +		kfree(itr);
> +	}
> +}
> +
> +static void pci_epf_mhi_dma_async_callback(void *param)
> +{
> +	struct pci_epf_mhi_dma_transfer *transfer = param;
> +	struct pci_epf_mhi *epf_mhi = transfer->epf_mhi;
> +
> +	spin_lock(&epf_mhi->list_lock);
> +	list_add_tail(&transfer->node, &epf_mhi->dma_list);
> +	spin_unlock(&epf_mhi->list_lock);
> +
> +	queue_work(epf_mhi->dma_wq, &epf_mhi->dma_work);
> +}
> +
> +static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
> +				       struct mhi_ep_buf_info *buf_info)
> +{
> +	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> +	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
> +	struct pci_epf_mhi_dma_transfer *transfer = NULL;
> +	struct dma_chan *chan = epf_mhi->dma_chan_rx;
> +	struct device *dev = &epf_mhi->epf->dev;
> +	DECLARE_COMPLETION_ONSTACK(complete);
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config config = {};
> +	dma_cookie_t cookie;
> +	dma_addr_t dst_addr;
> +	int ret;
> +
> +	mutex_lock(&epf_mhi->lock);
> +
> +	config.direction = DMA_DEV_TO_MEM;
> +	config.src_addr = buf_info->host_addr;
> +
> +	ret = dmaengine_slave_config(chan, &config);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure DMA channel\n");
> +		goto err_unlock;
> +	}
> +
> +	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> +				  DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(dma_dev, dst_addr);
> +	if (ret) {
> +		dev_err(dev, "Failed to map remote memory\n");
> +		goto err_unlock;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> +					   DMA_DEV_TO_MEM,
> +					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(dev, "Failed to prepare DMA\n");
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> +	if (!transfer) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	transfer->epf_mhi = epf_mhi;
> +	transfer->paddr = dst_addr;
> +	transfer->size = buf_info->size;
> +	transfer->dir = DMA_FROM_DEVICE;
> +	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
> +
> +	desc->callback = pci_epf_mhi_dma_async_callback;
> +	desc->callback_param = transfer;
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "Failed to do DMA submit\n");
> +		goto err_free_transfer;
> +	}
> +
> +	dma_async_issue_pending(chan);
> +
> +	goto err_unlock;
> +
> +err_free_transfer:
> +	kfree(transfer);
> +err_unmap:
> +	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
> +err_unlock:
> +	mutex_unlock(&epf_mhi->lock);
> +
> +	return ret;
> +}
> +
> +static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
> +					struct mhi_ep_buf_info *buf_info)
> +{
> +	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> +	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
> +	struct pci_epf_mhi_dma_transfer *transfer = NULL;
> +	struct dma_chan *chan = epf_mhi->dma_chan_tx;
> +	struct device *dev = &epf_mhi->epf->dev;
> +	DECLARE_COMPLETION_ONSTACK(complete);
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config config = {};
> +	dma_cookie_t cookie;
> +	dma_addr_t src_addr;
> +	int ret;
> +
> +	mutex_lock(&epf_mhi->lock);
> +
> +	config.direction = DMA_MEM_TO_DEV;
> +	config.dst_addr = buf_info->host_addr;
> +
> +	ret = dmaengine_slave_config(chan, &config);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure DMA channel\n");
> +		goto err_unlock;
> +	}
> +
> +	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
> +				  DMA_TO_DEVICE);
> +	ret = dma_mapping_error(dma_dev, src_addr);
> +	if (ret) {
> +		dev_err(dev, "Failed to map remote memory\n");
> +		goto err_unlock;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> +					   DMA_MEM_TO_DEV,
> +					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(dev, "Failed to prepare DMA\n");
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> +	if (!transfer) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	transfer->epf_mhi = epf_mhi;
> +	transfer->paddr = src_addr;
> +	transfer->size = buf_info->size;
> +	transfer->dir = DMA_TO_DEVICE;
> +	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
> +
> +	desc->callback = pci_epf_mhi_dma_async_callback;
> +	desc->callback_param = transfer;
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "Failed to do DMA submit\n");
> +		goto err_free_transfer;
> +	}
> +
> +	dma_async_issue_pending(chan);
> +
> +	goto err_unlock;
> +
> +err_free_transfer:
> +	kfree(transfer);
> +err_unmap:
> +	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
> +err_unlock:
> +	mutex_unlock(&epf_mhi->lock);
> +
> +	return ret;
> +}
> +
>  struct epf_dma_filter {
>  	struct device *dev;
>  	u32 dma_mask;
> @@ -441,6 +646,7 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
>  	struct device *dev = &epf_mhi->epf->dev;
>  	struct epf_dma_filter filter;
>  	dma_cap_mask_t mask;
> +	int ret;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
> @@ -459,16 +665,35 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
>  						   &filter);
>  	if (IS_ERR_OR_NULL(epf_mhi->dma_chan_rx)) {
>  		dev_err(dev, "Failed to request rx channel\n");
> -		dma_release_channel(epf_mhi->dma_chan_tx);
> -		epf_mhi->dma_chan_tx = NULL;
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_release_tx;
> +	}
> +
> +	epf_mhi->dma_wq = alloc_workqueue("pci_epf_mhi_dma_wq", 0, 0);
> +	if (!epf_mhi->dma_wq) {
> +		ret = -ENOMEM;
> +		goto err_release_rx;
>  	}
>  
> +	INIT_LIST_HEAD(&epf_mhi->dma_list);
> +	INIT_WORK(&epf_mhi->dma_work, pci_epf_mhi_dma_worker);
> +	spin_lock_init(&epf_mhi->list_lock);
> +
>  	return 0;
> +
> +err_release_rx:
> +	dma_release_channel(epf_mhi->dma_chan_rx);
> +	epf_mhi->dma_chan_rx = NULL;
> +err_release_tx:
> +	dma_release_channel(epf_mhi->dma_chan_tx);
> +	epf_mhi->dma_chan_tx = NULL;
> +
> +	return ret;
>  }
>  
>  static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
>  {
> +	destroy_workqueue(epf_mhi->dma_wq);
>  	dma_release_channel(epf_mhi->dma_chan_tx);
>  	dma_release_channel(epf_mhi->dma_chan_rx);
>  	epf_mhi->dma_chan_tx = NULL;

Looks good!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof


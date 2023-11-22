Return-Path: <linux-pci+bounces-76-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34127F3AC3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F27F1C20A57
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970B10F9;
	Wed, 22 Nov 2023 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DFXxYWSm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607D18E
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 16:37:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso30220265e9.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 16:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700613455; x=1701218255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuyaX9shJZ5hZBEcnsm0UTfJKmYlgRchXxT06l5DLIk=;
        b=DFXxYWSmCaN+fbsYIArbA84qrUYEHWUeEW3knH7v0g8L/5REFn0RkRiUdGVVY7fZ4m
         gIXrwbr8osox8DqvAOKxx51R5w5tgfeD71JxlzLzMAF2YI9V2E4WnZ3VspyEzn6vStRc
         m/YQNYjXdslKi7tzZHXn1fNNcwoYbWCYQkFQl9BR90IZWKHVPQUZLwSO0+sxnXB21JJr
         dez9ebwAAReSGht5j1j6buGw3ohAayq/7Sh+JFhkeUedzo2iExGMUI5a72orUwyzPRJk
         r2mQqc/IIyv4VSXF2Oe7/9rUiFl88LW4PjD3j0H5Z0vQD4Iu9Z/DysW41oI6KunEBSc8
         0TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700613455; x=1701218255;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuyaX9shJZ5hZBEcnsm0UTfJKmYlgRchXxT06l5DLIk=;
        b=rb7WByDtmgisg7Tm+3VpVO1oJPzfPkCUB9q1AmfgDJZQwM9tur5BvZvHCRPuzdfJ5q
         j9oKE/s89bkxocf5xXjHFfSXb+NB0T4PAQYcpLS1EB0Y+G/UEBCEpgbs/ckAZh68NyWG
         IChjWBS0RCh/WpWy3G940SvBLGGXfGO1xr+25S19cA2PlSNiU57kG0WvP0KtwgX5ECH6
         WO4jby3NMHupUNBuogSxcGunNe02rEfA2ecjy9x2cNDW6ezk363bsM7XqEWwnSdXIAwA
         aAVI/t+mXpaJ9dp6vJUVg7tS3EBFDLzZVIoMkyGap1lKMI1sFVW+4X39QpvPlEeaEDZP
         PmvA==
X-Gm-Message-State: AOJu0YwC0lAvZPMaZwBIGhD68goEpt/Yw4AbX0IcSfVCfpS16PrRr7YX
	VcIR24lNygil7Cg5xmFDRlCX5w==
X-Google-Smtp-Source: AGHT+IH7jbO4ZHSpLOjr7znwWkhrWYZHhKMNkEOuZT7N+0Itw7wmcY3hhySLKdHAz1x+zKEisE06uA==
X-Received: by 2002:a05:600c:3551:b0:40a:55a6:793a with SMTP id i17-20020a05600c355100b0040a55a6793amr620813wmq.21.1700613455472;
        Tue, 21 Nov 2023 16:37:35 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040651505684sm321506wmo.29.2023.11.21.16.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 16:37:34 -0800 (PST)
Message-ID: <7058922e-9a55-47a2-b6fa-ea1cdade937a@arista.com>
Date: Wed, 22 Nov 2023 00:37:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20231113212150.96410-1-dns@arista.com>
 <20231113212150.96410-2-dns@arista.com>
Cc: Daniel Stodden <dns@arista.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231113212150.96410-2-dns@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/23 21:21, Daniel Stodden wrote:
> A pci device hot removal may occur while stdev->cdev is held open. The
> call to stdev_release is then delivered during close or exit, at a
> point way past switchtec_pci_remove. Otherwise the last ref would
> vanish with the trailing put_device, just before return.
> 
> At that later point in time, the device layer has alreay removed
> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
> counted one. Therefore, in dma mode, the iowrite32 in stdev_release
> will cause a fatal page fault, and the subsequent dma_free_coherent,
> if reached, would pass a stale &stdev->pdev->dev pointer.
> 
> Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
> stdev_kill. Counting the stdev->pdev ref is now optional, but may
> prevent future accidents.
> 
> Signed-off-by: Daniel Stodden <dns@arista.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Just in case, duplicating on the patch.
With pci_dev_put(stdev->pdev) on stdev_create() err-path,

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  drivers/pci/switch/switchtec.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e69cac84b605..d8718acdb85f 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1251,13 +1251,6 @@ static void stdev_release(struct device *dev)
>  {
>  	struct switchtec_dev *stdev = to_stdev(dev);
>  
> -	if (stdev->dma_mrpc) {
> -		iowrite32(0, &stdev->mmio_mrpc->dma_en);
> -		flush_wc_buf(stdev);
> -		writeq(0, &stdev->mmio_mrpc->dma_addr);
> -		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
> -				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
> -	}
>  	kfree(stdev);
>  }
>  
> @@ -1301,7 +1294,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  		return ERR_PTR(-ENOMEM);
>  
>  	stdev->alive = true;
> -	stdev->pdev = pdev;
> +	stdev->pdev = pci_dev_get(pdev);
>  	INIT_LIST_HEAD(&stdev->mrpc_queue);
>  	mutex_init(&stdev->mrpc_mutex);
>  	stdev->mrpc_busy = 0;
> @@ -1587,6 +1580,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
>  	return 0;
>  }
>  
> +static void switchtec_exit_pci(struct switchtec_dev *stdev)
> +{
> +	if (stdev->dma_mrpc) {
> +		iowrite32(0, &stdev->mmio_mrpc->dma_en);
> +		flush_wc_buf(stdev);
> +		writeq(0, &stdev->mmio_mrpc->dma_addr);
> +		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
> +				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
> +		stdev->dma_mrpc = NULL;
> +	}
> +}
> +
>  static int switchtec_pci_probe(struct pci_dev *pdev,
>  			       const struct pci_device_id *id)
>  {
> @@ -1646,6 +1651,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
>  	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	dev_info(&stdev->dev, "unregistered.\n");
>  	stdev_kill(stdev);
> +	switchtec_exit_pci(stdev);
> +	pci_dev_put(stdev->pdev);
> +	stdev->pdev = NULL;
>  	put_device(&stdev->dev);
>  }
>  

Thanks,
             Dmitry



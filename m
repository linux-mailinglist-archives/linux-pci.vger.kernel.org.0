Return-Path: <linux-pci+bounces-283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78F7FF071
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126A4B21001
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B81482CD;
	Thu, 30 Nov 2023 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKyjaZ8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6538DE3;
	Thu, 30 Nov 2023 13:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3603C433CC;
	Thu, 30 Nov 2023 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701351789;
	bh=fw3gJfSYdWE1YZP1yNFEaglZ2RlsUN91tvYHZ5J95/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKyjaZ8c5DBE8c01g2c9o2qZ98ATXtdQ3ljOfcVXPDKV4GzGdehqmJAv6+S/iKETF
	 yN38THwrmNZFnBovrn2v1LFb+BubRA+cRF1vZO8cDIc+V3cGfilOe86O1i25W8Qp/H
	 gLN5DY+b58BSdVJGxCcJYnm4Ams5OnL8/Q7Xqyx8ZociKW89DN/40DgT24xZoMQ5Hv
	 05t3nBHjiymnGPoP7piE/eB996ss+/1bZQ/cAOKEseaIvhnZ+qh1xU7pacNzIB90aC
	 kGsM/Wtw9Z+hv6dgOBYQcB3jx4Y+Mzk2NuzVFsTTaucn2IsY9A4v6dhHovwbQMe5bj
	 jOoYEPiib0GZw==
Date: Thu, 30 Nov 2023 19:13:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
	yangyingliang@huawei.com
Subject: Re: [PATCH v2] NTB: fix possible name leak in ntb_register_device()
Message-ID: <20231130134301.GR3043@thinkpad>
References: <20231130122853.3736508-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130122853.3736508-1-yangyingliang@huaweicloud.com>

On Thu, Nov 30, 2023 at 08:28:53PM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If device_register() returns error in ntb_register_device(),
> the name allocated by dev_set_name() need be freed. As comment
> of device_register() says, it should use put_device() to give
> up the reference in the error path. So fix this by calling
> put_device(), then the name can be freed in kobject_cleanup().
> 
> Remove the outside put_device() in pci_vntb_probe() and return
> the error code.
> 
> Fixes: a1bd3baeb2f1 ("NTB: Add NTB hardware abstraction layer")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>    return the error code in the error path in pci_vntb_probe().
> ---
>  drivers/ntb/core.c                            | 8 +++++++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++------
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
> index 27dd93deff6e..d702bee78082 100644
> --- a/drivers/ntb/core.c
> +++ b/drivers/ntb/core.c
> @@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
>  
>  int ntb_register_device(struct ntb_dev *ntb)
>  {
> +	int ret;
> +
>  	if (!ntb)
>  		return -EINVAL;
>  	if (!ntb->pdev)
> @@ -120,7 +122,11 @@ int ntb_register_device(struct ntb_dev *ntb)
>  	ntb->ctx_ops = NULL;
>  	spin_lock_init(&ntb->ctx_lock);
>  
> -	return device_register(&ntb->dev);
> +	ret = device_register(&ntb->dev);
> +	if (ret)
> +		put_device(&ntb->dev);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(ntb_register_device);
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3f60128560ed..c6f07722cbac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1272,21 +1272,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(dev, "Cannot set DMA mask\n");
> -		return -EINVAL;
> +		return ret;

A patch should do only one thing at a time. You should not sneak changes like
this even though it is valid.

- Mani

>  	}
>  
>  	ret = ntb_register_device(&ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
> -		goto err_register_dev;
> +		return ret;
>  	}
>  
>  	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
>  	return 0;
> -
> -err_register_dev:
> -	put_device(&ndev->ntb.dev);
> -	return -EINVAL;
>  }
>  
>  static struct pci_device_id pci_vntb_table[] = {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


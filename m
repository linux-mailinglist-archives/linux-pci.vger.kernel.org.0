Return-Path: <linux-pci+bounces-273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BD7FEC0B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 10:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FEB1C20E58
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF83986A;
	Thu, 30 Nov 2023 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqGCFIUz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D83985D;
	Thu, 30 Nov 2023 09:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE3AC433C7;
	Thu, 30 Nov 2023 09:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701337260;
	bh=oEoYW2AT0/jNITVsryKbKyTT6q9EeChyDt1rulwgiAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqGCFIUzaoqzo1/kdBa76yEdfTAcAxiLWNEjheo07Rq1wWGMWhgwaFDKGAxELswxo
	 vfh7j6FzRjncJyFRi6N1lLgQnn7jc9/GELMXYAZwP5sLep3SAPmm0Iwa6QN0NeE0dT
	 JmH9asS7I3gZPB6FMeAQhd2w2MiCpI4X2cITdCq7R4c9mZ8NVszxVow4IonmbMTPvn
	 zcPiTfzpjP2ApMzZTa208Cvi6qOuR3pTD+G82H4/mDsVTP/FxF8eO2BC2YtonjEQp9
	 sLyCdlTH4WnQxctZP2Rnpqsjpy+mUw2e1fp1dwVWmJLBethEhCugXkC13VPf8cqcpO
	 Q3iXnvAgqhEOg==
Date: Thu, 30 Nov 2023 15:10:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
	yangyingliang@huawei.com
Subject: Re: [PATCH] NTB: fix possible name leak in ntb_register_device()
Message-ID: <20231130094051.GP3043@thinkpad>
References: <20231130021350.2733064-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130021350.2733064-1-yangyingliang@huaweicloud.com>

On Thu, Nov 30, 2023 at 10:13:50AM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If device_register() returns error in ntb_register_device(),
> the name allocated by dev_set_name() need be freed. As comment
> of device_register() says, it should use put_device() to give
> up the reference in the error path. So fix this by calling
> put_device(), then the name can be freed in kobject_cleanup().
> 
> Fixes: a1bd3baeb2f1 ("NTB: Add NTB hardware abstraction layer")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ntb/core.c                            | 8 +++++++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 6 +-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
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
> index 3f60128560ed..8e4ed188ad5c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1278,15 +1278,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = ntb_register_device(&ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
> -		goto err_register_dev;
> +		return -EINVAL;

Even though this is the existing behavior, you should return ret.

- Mani

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


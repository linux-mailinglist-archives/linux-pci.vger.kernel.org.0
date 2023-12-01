Return-Path: <linux-pci+bounces-316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A287780033F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 06:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54001281574
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 05:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E848BE1;
	Fri,  1 Dec 2023 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/hVKTS8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2F883B;
	Fri,  1 Dec 2023 05:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C478AC433C9;
	Fri,  1 Dec 2023 05:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701409693;
	bh=gE50s48VK4sHzTLhiSqdX19Brr3TXGaAuzOkGv1vWd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/hVKTS8Al69ohmDDaxiJjZvogAfV/1mShdd2PuVGw+5HUChl+1XCedBMuUoo6ZKW
	 CH68l91HTy+v76YR5XLJwUYTk0dpPsHR79wH0n40W/5LgAUlQHYroY2kFEvHG1EBXH
	 rvK38ExP2TYZiUIgRa8J3Qpah+LdK3cydK2nPwbRlfg1zq2xt32ACRUi/4N6SCdwKx
	 gHtxIpwDEpXI01VYDbfqfbWYQlKiNwWlRS2Ca4tcPerhhpU5kzftlUuZEFmUoqQFfu
	 cVHXCKofOXDCf+cKFHKMreDUz4U7fPVmHyo49emyQ1MJ2e+a6sgSyJu5BWsJJJj8Oo
	 /54DqQZa/kFPg==
Date: Fri, 1 Dec 2023 11:18:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
	yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] NTB: fix possible name leak in ntb_register_device()
Message-ID: <20231201054800.GE4009@thinkpad>
References: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>

On Fri, Dec 01, 2023 at 11:30:56AM +0800, Yang Yingliang wrote:
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

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
> index 3f60128560ed..2b7bc5a731dd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1278,15 +1278,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


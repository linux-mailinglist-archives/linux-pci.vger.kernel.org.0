Return-Path: <linux-pci+bounces-3580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E0E857A8F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9C11C21B90
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5B53395;
	Fri, 16 Feb 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olg9jtyM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570364D13F;
	Fri, 16 Feb 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080347; cv=none; b=ItH4LE8TVb9ifMmSGnks31wEUqPVam3Jxd8PWgygK0nqqHsCR85SWAD8vDnFw22ZOwFoG7NeEUT1UerRGza7w/K225TaT5mYSv3isxt2h5GNtG0OWE20/UUUNbqrr+hwgpK38Rw6ay8A3k4qFRR8UJaTYNHUor86MHZu4yU/Vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080347; c=relaxed/simple;
	bh=LpEdzatlMN1TBLSZkz+j9NyVGM389cIN4UKO0N2dGz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd+l/dH13Cpw8btEUFfdcU9oLI1vIHVIBLmPDIElWUMafoCS3mq7Sx+QxTHRunQNBbav5LEHLHE4lnU7xafsQWfoGlpccckPk5mMZB4N6fHu9YnSSEGvQ4QtDBMrqloHswyS0Uw3e30zfDWXq66w7+zeYiRGPZj8+nhazvoUMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olg9jtyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A47BC433F1;
	Fri, 16 Feb 2024 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708080346;
	bh=LpEdzatlMN1TBLSZkz+j9NyVGM389cIN4UKO0N2dGz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Olg9jtyMCMnhPK1WQrcsqODKIpj08UDPT0ppqRYngZcW1bgPZClbwc+eJTw9hX9YS
	 O9bl8WmxjBpCUTSmQ2jb2JR95Gmx2xv/eCWt1AP3vaONix1n4sS0QljyakQ1AwDHzr
	 3DxO+tgdP4f8e1XFpKU/9sZiPLgPeEMlUEZqszrxN4UOsgzvtvycMj0hBN9SiKK2uM
	 vk/x0UbCreUvvasenlikXDtcZj6NvHzf45DdychNhdIgn4ENpzU3G0J66qnyqU6vPf
	 Zyu7yauvHzMaW8mEw/w8oGI1ZjEIFbm/gsiUa3B0yUXK0sSt21mVbkTZkON2XynvPP
	 X+Ywh0kQuoamQ==
Date: Fri, 16 Feb 2024 16:15:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] NTB: fix possible name leak in ntb_register_device()
Message-ID: <20240216104539.GA2559@thinkpad>
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

Applied to pci/endpoint!

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
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA2800343
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 06:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38FDB20E41
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157D8BE2;
	Fri,  1 Dec 2023 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbvJ0qim"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086D883B;
	Fri,  1 Dec 2023 05:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7771C433C9;
	Fri,  1 Dec 2023 05:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701409723;
	bh=qJgojaxhpGpO59PJYfx8iH+rIWlzW3FC16UO04TzUaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbvJ0qimg4rTPSJaKq9/ZhvGOfPCTnx0KJ4FCuB4Bgqmwr4BzVne05YbdqKJJCi9n
	 K74q339dHMLFhqMK1KEx6i6DQbyC7id5nWG4RJ452JeYdIbv4FuLrkvbEZC8TKLU6i
	 wylkkcJ6j3avcb2lqBPBWUScWMSRQ1E4oC/SXyRgGREOQLP/PNSMwOC5XGLmOc9Jdg
	 lXNYtd6lTFMsWoJTSWg0hsF4hT5DG2YWhN/GFQxanliFhFmhZmUbPYL0VrhskWrbK5
	 L3bH3qxpvMGYjEDfXJ2mazvR8OEJmICbJnYAGUwvWYv53q+UtdWksS8MNOkBfzBhxE
	 yVI14kjlezwQw==
Date: Fri, 1 Dec 2023 11:18:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
	yangyingliang@huawei.com
Subject: Re: [PATCH 2/2] NTB: EPF: return error code in the error path in
 pci_vntb_probe()
Message-ID: <20231201054829.GF4009@thinkpad>
References: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
 <20231201033057.1399131-2-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201033057.1399131-2-yangyingliang@huaweicloud.com>

On Fri, Dec 01, 2023 at 11:30:57AM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If dma_set_mask_and_coherent() fails, return the error code instead
> of -EINVAL.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2b7bc5a731dd..c6f07722cbac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1272,7 +1272,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(dev, "Cannot set DMA mask\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	ret = ntb_register_device(&ndev->ntb);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-9908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D1929D01
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4919D1F2161F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F781D52D;
	Mon,  8 Jul 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naJtVH36"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A12EDF
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423354; cv=none; b=IV+dxyNx22UuX8Vloiwz8dj8FxOukpGiRY3NwuYu8CdBLm7rXanI0sdnA53NG4hCkShq4mSXVRoAINXQJpu1Hke8fvDvXLf2JoiM3ndrIKZKjVjTZM2Hk01XQAZjy5kYIpWGKW2WYzMNr5v37cZtBSChWgFDK0vM6FD33OWlUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423354; c=relaxed/simple;
	bh=idrcO3j6ZJtjys03L4/z16VLpQLwc7Vr6ABcCm9c4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIks/m4QKPs7FTbQTJj60YVtR549U2Ip/HhqcyXqiKMQl1zSTZpgBPXOvpBuGI2HrVMf/3U0ab+X0UNC4+1uRULH/nb/xicZgrskXKLQDaLhd8Fel84cGYstKl2r9sTN0o3aAWox3iBub2MuVZTAPdH3NZfNGZAxoQ1NL0EHPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=naJtVH36; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6a837e9a3so14291335ad.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720423351; x=1721028151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBYy4DFhtHluGvHK6v5yjGoMYZnZkSaBjiQQhAn19qs=;
        b=naJtVH36XF1jE7eLb7qFGnd0s0CnBklb/R39zYap08YrXaBuLp78z7BBvXdSrpE081
         dyGO9RSJQTN7tv8YG7K9z1n99aJgSvVw1cL8tswEV6SfYzr7hbU8wAVwUG0wJOgsBMvU
         At9CxJ5F/uAkyQVEupaqc0nejtYCzSKggO1r3eRIGfuTq7vPq2YwCdAuK7Xjr7xp40dM
         /9xgz9n1i8vgFDGwapEbewocYCDWiPAxhQ5ULRNn02BeqDeUyHH6jF9QmHWwdex98qN6
         uzsPXMlhc47SYLlmdC8sCIw7hBqcOi1M0t2TrbmsoG8nGj2PvapGR+s50K/dFCoSlwxK
         Psnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720423351; x=1721028151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBYy4DFhtHluGvHK6v5yjGoMYZnZkSaBjiQQhAn19qs=;
        b=PTwmkMi71Mbg5zmaAACPzxKwyTxZejb3Q3Q855YKKDWFwNdgV99GwSjKIhiRzqmgZ7
         Es3Z5py+A3Yptal+lZMuAFDajBIEPk8K+c6+Jhj/ibxvH+57cFMpQhsNvq/9BdBiKNBJ
         edPw36fD2XYvpVM9oi8kCOdLs0iJJ5h+PPpmnRjKWTEqQ3zUraHWfTE351DN46YvQOAp
         DKXUUQHp8VAUXV5x4mYrId4siBZ0gL1WOjGvwSPkY9nUbdEszq5nEmRmrd6Uk9rbQpsW
         ZBJb/VXSZ+rLwRiLS2AdXmFAz+IrjZ0AlftiaT4WFSBCvwUt+qyNYZy2nWNKdn1K4BCt
         kbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PfDwcja+Nw/RVXV0gN3TCnV59pwJCASXjIInoiMQWdZxn6euKIWxBC/84cUfW3WnNTSSLJLkPTqgvKTH7V9jCindORMUymBz
X-Gm-Message-State: AOJu0Yxj3PRXTKC+8AZJGcTj1WqSa/hIfj7vY/324wP9KZjS3ZbGKF+L
	brjN0l81rE8nt92mqYKSjwtLsmjZD9Xymu6WNxKzptQZ/Dl+pgqMroUWxymStg==
X-Google-Smtp-Source: AGHT+IFngwXllRFZcKK0nuNe7EQX8bnOyVP4qDVSraN9DPENqjrGFBeOrH4P+ZLdpGIK4/tpQ4aKPg==
X-Received: by 2002:a17:90a:f0d6:b0:2c9:8d5d:d175 with SMTP id 98e67ed59e1d1-2c99c825acbmr5927647a91.48.1720423351318;
        Mon, 08 Jul 2024 00:22:31 -0700 (PDT)
Received: from thinkpad ([120.56.204.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aab8e04sm7429684a91.56.2024.07.08.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:22:30 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:52:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708072226.GB3866@thinkpad>
References: <20240707183829.41519-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240707183829.41519-1-spasswolf@web.de>

On Sun, Jul 07, 2024 at 08:38:28PM +0200, Bert Karwatzki wrote:
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> 
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index e4735428814d..3bab78cc68f7 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> 
>  	pci_dev_assign_added(dev, true);
> 
> -	if (pci_is_bridge(dev)) {
> +	if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
>  		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
>  					      &dev->dev);
>  		if (retval)
> --
> 2.45.2
> 
> Just in case this is needed.
> 
> Bert Karwatzki
> 

-- 
மணிவண்ணன் சதாசிவம்


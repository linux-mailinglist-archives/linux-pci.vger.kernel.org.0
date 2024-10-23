Return-Path: <linux-pci+bounces-15115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A569AC7DC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 12:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30F41C22E49
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743E1A725A;
	Wed, 23 Oct 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMsd5aUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFA1A7273
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679127; cv=none; b=H0KxLuHbIPBqf/WBHYcv9wLlPhMp8ZYATGVWVFfRb/VvFNcCNxscyvOxsWpe/LcSWidMMjXfu/UAdWeULU6rioqvYSKhHHxHRhAsVHftN67Boz+wCClFiRaZioxv0Du8mFVd4hpzgTnKkioahVblduodHy027jLr5QudYZdn/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679127; c=relaxed/simple;
	bh=0u9U3x9S1WEac8fQPNG+3GXb0eQ1qOUpNFnMVkoSgk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtTfah7+04YUyu6Ry0RoRFaXsOXNHBRJvE+aND/MSu0fAJpj00eQ3cbrMcSJ3F5JdP8tOqoaip18mCj24uVxDUGdsk+c/T2LW/rACr7SI2xVWnRNvlwa1ZRuLr7JAXaMKftLPknghgG/GtSWIiOavgHDyCSksesRBLvDbK7tMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GMsd5aUd; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so51596747b3.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729679124; x=1730283924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLQzgkTG/61odQf+gfwtWdvRpz64tx2LO584eYEg/hk=;
        b=GMsd5aUd5MYSnhdaMXPTBim3BZz1l9PbO+jm7u0lhRDhC8TLAI7yXx+dslpGRrha0N
         Q4PYqEauVN42P+iLkHoVsYWz/koUi/vaxFGVVrkwXD2m/zztvNon8Vo4d0TJqTSkf9sz
         0YmSgV1JygjZo+5K8hya+aMswUKMm1XUU2tEpZjlhsAl3FTuhvXFCPG509g0J5xOg53Q
         gLkfxJnXifETJnPbXSe6ylIt8K43P6qaxooxSns8Wqe/YQWXbYgeYRvUNlRzGmzYER8x
         WwleqHPRrakbh/VZHpF9hMk4rLPu01hxW9II7ldEEsiJlgE/poRKsWX4IVFEeJKm4PNG
         eBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679124; x=1730283924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLQzgkTG/61odQf+gfwtWdvRpz64tx2LO584eYEg/hk=;
        b=TDl0+M//3wjjzpVooacc0gQAH6I444B+iP4V02J8K4ANVwMmg3BIUxDkD1x286MwGh
         fKApGPPqPFPAcVZLzqDfcFASRwSoe5GbKSCJ+V/hQnguAenb3sfjG+NFWpmUm1Per7DA
         wgcE5dGigwjLiHcC8wCVFBQ/S+Yv4PFxCeBZUeZ7iNpcSpLXQj8ytB4bN8rO+n/C7gl0
         pMOd5WCK2Egt1l9hlxqfBuxw20GZVkWhpsV1tPVzEF7aEHi8JXBBTPHeey0rIYfkN2Bf
         KHF+7PJwwfiem1QORmgWt2xjB0lJiwC/5X+ZEbs2sPfSElvz9oYHoW2ZRuMuKXr9NSLJ
         fcmA==
X-Forwarded-Encrypted: i=1; AJvYcCWi74I35ItxzWx/CrHLEHtbRUWKsyAwhjHpKlJp+VMFePBMCsN/Vq8DlCiDIokvSa/jzRXHKXTSN3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvZm9E3lRPJu5pCmkMsZCfKsRpTvoffi4so/QpMIeQFwFU7s6
	k4AWDnTfDFNTw0BE2OXmedV88END9Kwv6TSY8OgHBpUjbKGMOvw3VycdYoINy9c1412vGvb5eF1
	aYMAGuWfFq2ofbiEL96LAzziw0msP1qUwLqKHEQ==
X-Google-Smtp-Source: AGHT+IHLL+g2BzhFZIsy5wwKLD3/mEqk16bt1frt2e0fSm1Ty/z6Jd/fvtTrNXTRNjxgu8KYLqQG5AIZRsGA87U5qOs=
X-Received: by 2002:a05:690c:1a:b0:6e3:4436:56af with SMTP id
 00721157ae682-6e7f0fa38admr22854677b3.33.1729679124363; Wed, 23 Oct 2024
 03:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org> <20241022-pci-pwrctl-rework-v1-5-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-5-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 12:25:13 +0200
Message-ID: <CACMJSet1Zvm5-yHTxfnk43=g+DMyKUKSH0XzYkiAJDTvMr9C+A@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI/pwrctl: Remove pwrctl device without iterating
 over all children of pwrctl parent
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> There is no need to iterate over all children of the pwrctl device parent
> to remove the pwrctl device. Since the pwrctl device associated with the
> PCI device can be found using of_find_device_by_node() API, use it directly
> instead.
>
> If any pwrctl devices lying around without getting associated with the PCI
> devices, then those will be removed once their parent device gets removed.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/remove.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e4ce1145aa3e..3dd9b3024956 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -17,16 +17,16 @@ static void pci_free_resources(struct pci_dev *dev)
>         }
>  }
>
> -static int pci_pwrctl_unregister(struct device *dev, void *data)
> +static void pci_pwrctl_unregister(struct device *dev)
>  {
> -       struct device_node *pci_node = data, *plat_node = dev_of_node(dev);
> +       struct platform_device *pdev;
>
> -       if (dev_is_platform(dev) && plat_node && plat_node == pci_node) {
> -               of_device_unregister(to_platform_device(dev));
> -               of_node_clear_flag(plat_node, OF_POPULATED);
> -       }
> +       pdev = of_find_device_by_node(dev_of_node(dev));
> +       if (!pdev)
> +               return;
>
> -       return 0;
> +       of_device_unregister(pdev);
> +       of_node_clear_flag(dev_of_node(dev), OF_POPULATED);
>  }
>
>  static void pci_stop_dev(struct pci_dev *dev)
> @@ -34,8 +34,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>         pci_pme_active(dev, false);
>
>         if (pci_dev_is_added(dev)) {
> -               device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> -                                     pci_pwrctl_unregister);
> +               pci_pwrctl_unregister(&dev->dev);
>                 device_release_driver(&dev->dev);
>                 pci_proc_detach_device(dev);
>                 pci_remove_sysfs_dev_files(dev);
>
> --
> 2.25.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


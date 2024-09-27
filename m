Return-Path: <linux-pci+bounces-13591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0AF988023
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B55EB209C3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417E175D2C;
	Fri, 27 Sep 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDKxdHf1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542813B58B;
	Fri, 27 Sep 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425082; cv=none; b=uEFCmrusGj9uKDzFgvu78wXplx8VNqC51QQyPkFgSYO8UC0Xz00bn1zVVJKy/BPRiVqaj54wfrUI5Q33fP+6O7aYyjvUJkXL973KZZyHbF7JSFzxpHqHBwNqykjUN2Z4VFIikaWpdPkLHiHg2mUv4wY4x51A18tqnIqEnw6fZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425082; c=relaxed/simple;
	bh=XWQo208lHzRpbTiD3VJZgQ1YzqtPjGoCpGkZ2H9pyT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oW8j+trU14KzSVNh8fvMf9oD7jVm//o38mPwfp7vB3vMp/PVkS5khKHh81ffTMLeHQh9apbcam2yxhwXAwgzfxBkHZkKDwEWrhjfelswEAAVc7RvYrxfuuXb+XUtxBFsm/v9df43y3y1U5FrcDpZTtGsokozjjdkzV4VLwdnQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDKxdHf1; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e163e2a9fdso1090237b6e.2;
        Fri, 27 Sep 2024 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727425080; x=1728029880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wik+ChQqsJUQ9vegf6yc2qiPGCL4qopVw1Omly+OHW0=;
        b=TDKxdHf1xABk98a/6t2S9XzwvoN9gj12lkGxh9Upr/PGyBLMYchdTVJtJ82Z3mkvAZ
         BkxN3lFC1AdNQYsTUY+rS1uDHGiaWeiKqcM4yftRppEkcEQdqSNCeWMnkNiakAGh4rM0
         VUdhZfOMKHJeUo43HlozLpdXUsa7mU9fbcSJwaexZGkQcTxmNdtC026JjbOHTNqsXsyZ
         G1yh5z+dQHXTfv1bug4Db8kByg+ZiqCuqtYzXgfEf2mqEBu1rqy+0fywGd3Rk5OJHj7B
         MHLGmhDESVNVW3SywOm3olUKJZoj0GYdtXMDjElAmnraGeNajL3wmEcbhN9kslSICm9m
         BZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727425080; x=1728029880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wik+ChQqsJUQ9vegf6yc2qiPGCL4qopVw1Omly+OHW0=;
        b=evYz9QxZ0W58Tbbr0Z8uJxxN3aJH4sSo100mg7exz9XNJpeN9aGBjPHuYtgWa91sjd
         DDmYnsvZRdzqDGk4bWr1oL6fg821/HScyw6Im2FZASx56ESVT48cYUEovx3cpCmYhsfE
         NenueOpJJmwJPqRc6ZV3AU7flXEHvvFOo++vzYmNfv2LQjKljPoxnN+gBnD5DFQ7BQ0d
         D3zUfyOn52M+RWZydLioWPxTy1YK+sqP60kZfR9pMTD56wOa2ggR0quJJ1yKQr/TIiQn
         yjy2umUFVReGahGNDh00RcydOkefQo7/98zxj1eToXphu5mon08qxprUB4JuQHOkf5cl
         QdNA==
X-Forwarded-Encrypted: i=1; AJvYcCX8gN49OX5bdgKkaR4hNA7RQV+97LSZkNysXRRg7tSq/+NAyZmfCPOV6iFjnu5z89IcJx7EaTEJZrjn2DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTE4FPOWSoo9f6NTW3OwkmXHjriIS1mo8ITdM1lZLFS2VxMwIH
	d3wuqYKmFslNNtTV8gQdpkOIgCVdDW1jabKB/mDo/DVEzO1jAOhkFlYACKV2ko9jLgA5YDwTaL6
	lOeMu0su/zWjHEr4//HVurUfi/R4=
X-Google-Smtp-Source: AGHT+IGXhzWbBdeIrb0hJqpwNgrU0bjAQ6vyKaWNVNcd1bGRalu2iD6EKqCW4Qs5ETCMD0+1IwTEHcpL/v4onOi88xw=
X-Received: by 2002:a05:6808:f86:b0:3e2:9d3f:15fe with SMTP id
 5614622812f47-3e3939e7f79mr1404501b6e.45.1727425079995; Fri, 27 Sep 2024
 01:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901183221.240361-1-linux.amoon@gmail.com> <20240901183221.240361-2-linux.amoon@gmail.com>
In-Reply-To: <20240901183221.240361-2-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 27 Sep 2024 13:47:44 +0530
Message-ID: <CANAwSgSgwx0kuV-boF14_WXiPkE8KXxOWOfS2e_QOWMKgKSLnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 2 Sept 2024 at 00:03, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Refactor the clock handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for enabling and
> disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> the clock handling for the core clocks becomes much simpler.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Do you have any review comments on this series?

Thanks
-Anand

> ---
> v5: switch to use use devm_clk_bulk_get_all()? gets rid of hardcoding the
>     clock names in driver.
> v4: use dev_err_probe for error patch.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot.
> ---
> ---
>  drivers/pci/controller/pcie-rockchip.c | 65 +++-----------------------
>  drivers/pci/controller/pcie-rockchip.h |  7 ++-
>  2 files changed, 10 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index c07d7129f1c7..2777ef0cb599 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -127,29 +127,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>                                              "failed to get ep GPIO\n");
>         }
>
> -       rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
> -       if (IS_ERR(rockchip->aclk_pcie)) {
> -               dev_err(dev, "aclk clock not found\n");
> -               return PTR_ERR(rockchip->aclk_pcie);
> -       }
> -
> -       rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> -       if (IS_ERR(rockchip->aclk_perf_pcie)) {
> -               dev_err(dev, "aclk_perf clock not found\n");
> -               return PTR_ERR(rockchip->aclk_perf_pcie);
> -       }
> -
> -       rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
> -       if (IS_ERR(rockchip->hclk_pcie)) {
> -               dev_err(dev, "hclk clock not found\n");
> -               return PTR_ERR(rockchip->hclk_pcie);
> -       }
> -
> -       rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
> -       if (IS_ERR(rockchip->clk_pcie_pm)) {
> -               dev_err(dev, "pm clock not found\n");
> -               return PTR_ERR(rockchip->clk_pcie_pm);
> -       }
> +       rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
> +       if (rockchip->num_clks < 0)
> +               return dev_err_probe(dev, err, "failed to get clocks\n");
>
>         return 0;
>  }
> @@ -372,39 +352,11 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>         struct device *dev = rockchip->dev;
>         int err;
>
> -       err = clk_prepare_enable(rockchip->aclk_pcie);
> -       if (err) {
> -               dev_err(dev, "unable to enable aclk_pcie clock\n");
> -               return err;
> -       }
> -
> -       err = clk_prepare_enable(rockchip->aclk_perf_pcie);
> -       if (err) {
> -               dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
> -               goto err_aclk_perf_pcie;
> -       }
> -
> -       err = clk_prepare_enable(rockchip->hclk_pcie);
> -       if (err) {
> -               dev_err(dev, "unable to enable hclk_pcie clock\n");
> -               goto err_hclk_pcie;
> -       }
> -
> -       err = clk_prepare_enable(rockchip->clk_pcie_pm);
> -       if (err) {
> -               dev_err(dev, "unable to enable clk_pcie_pm clock\n");
> -               goto err_clk_pcie_pm;
> -       }
> +       err = clk_bulk_prepare_enable(rockchip->num_clks, rockchip->clks);
> +       if (err)
> +               return dev_err_probe(dev, err, "failed to enable clocks\n");
>
>         return 0;
> -
> -err_clk_pcie_pm:
> -       clk_disable_unprepare(rockchip->hclk_pcie);
> -err_hclk_pcie:
> -       clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -err_aclk_perf_pcie:
> -       clk_disable_unprepare(rockchip->aclk_pcie);
> -       return err;
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
>
> @@ -412,10 +364,7 @@ void rockchip_pcie_disable_clocks(void *data)
>  {
>         struct rockchip_pcie *rockchip = data;
>
> -       clk_disable_unprepare(rockchip->clk_pcie_pm);
> -       clk_disable_unprepare(rockchip->hclk_pcie);
> -       clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -       clk_disable_unprepare(rockchip->aclk_pcie);
> +       clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
>
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 6111de35f84c..bebab80c9553 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -11,6 +11,7 @@
>  #ifndef _PCIE_ROCKCHIP_H
>  #define _PCIE_ROCKCHIP_H
>
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
> @@ -299,10 +300,8 @@ struct rockchip_pcie {
>         struct  reset_control *pm_rst;
>         struct  reset_control *aclk_rst;
>         struct  reset_control *pclk_rst;
> -       struct  clk *aclk_pcie;
> -       struct  clk *aclk_perf_pcie;
> -       struct  clk *hclk_pcie;
> -       struct  clk *clk_pcie_pm;
> +       struct  clk_bulk_data *clks;
> +       int     num_clks;
>         struct  regulator *vpcie12v; /* 12V power supply */
>         struct  regulator *vpcie3v3; /* 3.3V power supply */
>         struct  regulator *vpcie1v8; /* 1.8V power supply */
> --
> 2.44.0
>


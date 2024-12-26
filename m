Return-Path: <linux-pci+bounces-19049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E317E9FC898
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 06:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F45C1882983
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE2D149DE8;
	Thu, 26 Dec 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUoidRrh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC7381B9;
	Thu, 26 Dec 2024 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735190808; cv=none; b=b7GGbWaTPB0rVC+fTwRxBtVLRbXY5xHP55+PHIjl0mj5b/T9n3NYtxdV1NvjqYbpwb/qZg4e/xhw2w1y+6AvhleQ89jvVZkV9iFjnpc2Ncsuf5oA8SOQBkJJV3DamGSne5nHPJkb40PwXNkf7Ygan+Vlyqxuu0vubpMYh4+om4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735190808; c=relaxed/simple;
	bh=LDCFcXvNC3E6yqWiSLsmVOpWvqSGm1aeQzPx9je/u1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIJXUULexrAR8vME64uXciK+qRXQZ1wNyk1DJOPrFq5QBhZx/FFTS4Gc9Ohi/g6x8+jt4i5WTnAjpqlApdpij6/rwj+JcGYQ1Os5p8asv6QGtZEf1vCRmKJp0r0K5R1hbjt7KJbuvxWNQmTr/obt+x1StQaE/79xAqVZiEuuKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUoidRrh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so10272322a12.1;
        Wed, 25 Dec 2024 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735190805; x=1735795605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+JDr1LaRapYlu+PHe/GJEFAnj4I7CbUPpdQPHNvTfI=;
        b=GUoidRrhN9JOLlje9zmkT0wf5CWzjIYhL+/xl5x7YQoIvOIl6//lL9SWZ/Uvi2GE6O
         pGLZFBWU8D5K7GqmiRA2+G3fzEsV3ty2I06W46zdvFjtPtDOq0rQXz6EUDtDvCZ5cTzf
         32fe0FQO2IrI279Wz4TgMEtQOTXryitBwzdhg1yjYjADYK/8mb+dG3gc/4lT+/HAw55t
         2PB53qTGrvevvPcjiUVYjLclng/MqljN9pPXp8W1Y9c2ZOrtNKFG4Dy9my4suswUS7ag
         3/h056qBPF2peXNiCINanHfwb1AaksX0nuju5ohMsmJiGfQDbN5/HO3OjmJ2rsE6/7++
         56IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735190805; x=1735795605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+JDr1LaRapYlu+PHe/GJEFAnj4I7CbUPpdQPHNvTfI=;
        b=ctnjiT6Bw+hAt5eV1XkFpwZowZfCGbDctVPvWowBNQZl2qJ6lCFN71/rEQB56tkkwe
         K84UnWdw1SR3GThQvvZfCfIUKEK/CrAkttShQbt9vZLcE/6IRAnpVZinNlvzuuEKuD8b
         qcaD6IhCgMA76WoPYrHLiiFRzFI+yhK8eoYnFY6ysghc8NWMxQH/QUiaGRYDZTM16aeP
         M7Xsrb5Fl+rC8ZE+hIqxV7x0TDayx75RDSHhjTTru/SI/mjS1MJS4UVi2WwwbdkNZ+Ig
         2/tWaAws5eKONy1ThisXI5LsChv+WnR6EgBz1PKizkNTcfDipqVayydkd23eDB7e1bBa
         ybPw==
X-Forwarded-Encrypted: i=1; AJvYcCWC/g0L1MnK7wZ6aMmOsRyIZOSCmSQrwh6bj/GN6C4JJepTl/Mk1Z5XhFP9DsdKGZhfooGzWRKxczZ2fJs=@vger.kernel.org, AJvYcCWscNqVYix9J1Z1XtgZFJkwwPC0HvJjvVIK3hEQMbC48iwUYY/1/xo/p/zqBqzAIAYX1RI4NUJBS3zJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9IWeOv+l/raATKifybQhwkgPotSMmL5ubJ8bvwN+o8vohNrF
	gsxGLvSP6FH3pEgqXADIZkWQhy/iHZNH2Asd8rmEJNAbQSwdA2UnMA+kEilmaZQPk5qPXStkEzf
	saZQLtjdwa4r9DrZGJPvHMBLUAlo=
X-Gm-Gg: ASbGncufi/vQAH1u1CFMY/y0CfUHiUbrChzjiTo0HPJd+n/Qmv0ekP0581X3hZTtGuN
	DyOo8hUIn9OY6QllcGLxhOHTES+fWlx1PDqEhaw==
X-Google-Smtp-Source: AGHT+IHQ7vKwTP1Zh5rdZtm6sAzdXA46Hbae0qn8v1s5EYWSFykwVcX3dLIMcWjb/pilCPy7xwAqCzbLwxMhQ5SdnJA=
X-Received: by 2002:a05:6402:5255:b0:5d4:75b:8ced with SMTP id
 4fb4d7f45d1cf-5d81de39845mr18362948a12.32.1735190804649; Wed, 25 Dec 2024
 21:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202151150.7393-1-linux.amoon@gmail.com> <20241202151150.7393-2-linux.amoon@gmail.com>
In-Reply-To: <20241202151150.7393-2-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Dec 2024 10:56:28 +0530
Message-ID: <CANAwSgRgnwszYSH4uS-u=52f0vQuB2_SGcfNak_Xipe4=gXPOg@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, 2 Dec 2024 at 20:42, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Currently, the driver acquires clks and prepare enable/disable unprepare
> the clks individually thereby making the driver complex to read.
> But this can be simplified by using the clk_bulk*() APIs.
> Use devm_clk_bulk_get_all() API to acquire all the clks and use
> clk_bulk_prepare_enable() to prepare enable clks
> and clk_bulk_disable_unprepare() APIs disable unprepare them in bulk.
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---

Gentle ping ?

Thanks
-Anand

> V11: None
> V10: None
> v9: Re write the commmit message.
> v8: Improve the description of the code changes in commit messagee.
>     Add Rb: Manivannan
> v7: Update the functional change in commmit message.
> v6: None.
> v5: switch to use use devm_clk_bulk_get_all()? gets rid of hardcoding the
>        clock names in driver.
> v4: use dev_err_probe for error patch.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot.
> ---
>  drivers/pci/controller/pcie-rockchip.c | 65 +++-----------------------
>  drivers/pci/controller/pcie-rockchip.h |  7 ++-
>  2 files changed, 10 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index b9ade7632e11..53aaba03aca6 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -129,29 +129,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>                 return dev_err_probe(dev, PTR_ERR(rockchip->perst_gpio),
>                                      "failed to get PERST# GPIO\n");
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
> @@ -375,39 +355,11 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
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
> @@ -415,10 +367,7 @@ void rockchip_pcie_disable_clocks(void *data)
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
> index a51b087ce878..f79c0a1cbbd0 100644
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
> @@ -321,10 +322,8 @@ struct rockchip_pcie {
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
> 2.47.0
>


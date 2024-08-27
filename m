Return-Path: <linux-pci+bounces-12257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8896021C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D241C20DAC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1A8289C;
	Tue, 27 Aug 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9G6+T5C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26A54648;
	Tue, 27 Aug 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741088; cv=none; b=B+fRLpIKnIMtx1DikO98IuJrS6NjRTO7iPFUPsPp6UBPVHJLCjB2dCu9hp2bLCV4/zyhq129tWW+Muvz+ik1RxIzh3K/V9OQzAdaRcxTVmUfj6n8WAzfYywDZzQshQTpeOVObw3K3/VrlUtMCD04IAxGYXfbjpi09xFoNkp79MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741088; c=relaxed/simple;
	bh=d3r+K9ehepIp31tyZBLaVR6oq9zv3m+pJT5jQhCqwvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJNWDdrQz4PT5m6W81V+YgzEvIw4kt0ULYoOSis7c5LD6r/BBOEPBEadxgoAnTIPq4VF6yVqU4Juj2J+IwM9aiM8FfYQUvpuCUx9+/lvJdq+bEz0j4Z12/on8puZzlyO4c21YqrociM7HtmGcN4PiW8Zom/OOli9685t4uEhesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9G6+T5C; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-273c8514254so3799324fac.0;
        Mon, 26 Aug 2024 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724741086; x=1725345886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zvlj3keYJ34ilC/pJA7FPtL/AD70/OYqmE5Y37ybs8Q=;
        b=A9G6+T5CUrlnM/Y/UzJpaWZZs7/Xv3hNJ1v96UVP8zNBNNUOo9Ts5PcMzBtoRBGX7o
         bsrBdEJo15+JJ9QXN18WSyb0pQEw0phak0kleWo+5Zb8/DhFjTZ8zqqyxzaSd6DeuqQH
         Coo2yvOOB7cDv0FNlqgBWq5XSgnPhBKLGol5VIMdGxrZXFYzCj9l3YfSaSf9/4QRYTf9
         iu0iqiZjBn5X0KMgIN3Duq6ggJ8CU5W+hODZ+Hy2wmmIIRO3ofIXZhDA1LLfgkpv8ZJp
         EC54oRB/Vhv4NDjbND2TJlHXgGs0D6AFdaZ9SyRU9BTO4YLkj86S1FIrm0H103VB4dZc
         cQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724741086; x=1725345886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvlj3keYJ34ilC/pJA7FPtL/AD70/OYqmE5Y37ybs8Q=;
        b=Zu+TGVGuAQJ0NGDTyVNXQa3fQe9BNGxPOxVs+8OgZLF9gElCNJad9WYg1F+OPAVKsE
         +tT/lvepF9Pjqbkg96luD9Y8zKIYEw4Lym0A8DCq5o93i0Wi/9iJmUdXl1DySLX9Lgxm
         OW+5Suki+Ny8gFItbPdznTCr8n/qsbTbq4jVXKxoXzX4gJdGakI/Eczn7+I89Yi+R1uc
         rF+uDvncQl+VuNPNjCBef+LujZg+OHv/6VE+dsqHrJPSdo2xeH1+9FRtfq9zY6s1WAgS
         tL/XHUjfD/SgzU4anVJv07CUR6Bg40pTyrEEM3SoB6JuLlpm+zDQ0cSfk7P/40xSAPse
         GHaA==
X-Forwarded-Encrypted: i=1; AJvYcCXMat+2HGIGHSvUcc5SHuPR0nzwXhfZViJ00MF069hUCmBBoP4+cbmIiz/nBS29TX3Lu0LvaNIak6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OTGO9lnBzzjA4OGCD8h9vKlpDXFh4xo89vdTWb1LktW5acrL
	TFCU94vW+D8YsmWS+OMAxNMMK6x+VqfQaIB2qOObjpwUrFZd6UfttDI1bbOQERTQeiu+68s4wA6
	ZpFYg94Si4P0KL9tV/7kfjwzdmoU=
X-Google-Smtp-Source: AGHT+IGtwXcURv4xMeSy/OWTYB/rHswx2C97j9/S+/NIOvI1MV5xSyxcIKbKSxuqQkzLBgsJMoQZS6EP+rmhixvdWMs=
X-Received: by 2002:a05:6870:568c:b0:268:952b:d2a4 with SMTP id
 586e51a60fabf-273e66a04e7mr14271575fac.32.1724741086578; Mon, 26 Aug 2024
 23:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827023914.2255103-1-bo.wu@vivo.com>
In-Reply-To: <20240827023914.2255103-1-bo.wu@vivo.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 27 Aug 2024 12:14:31 +0530
Message-ID: <CANAwSgQpu9NYugu_=PCVQGXiXCptxLT2Q1xQ5KqbwvkU0kfWDQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: armada8k: change to use devm_clk_get_enabled() helper
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Wu Bo <wubo.oduw@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Wu Bo,

On Tue, 27 Aug 2024 at 07:55, Wu Bo <bo.wu@vivo.com> wrote:
>
> Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
> cleaner and avoid calling clk_disable_unprepare()
>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 36 ++++++++--------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b5c599ccaacf..e7ef6c2641b8 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -284,23 +284,17 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>
>         pcie->pci = pci;
>
> -       pcie->clk = devm_clk_get(dev, NULL);
> +       pcie->clk = devm_clk_get_enabled(dev, NULL);
>         if (IS_ERR(pcie->clk))
> -               return PTR_ERR(pcie->clk);
> -
> -       ret = clk_prepare_enable(pcie->clk);
> -       if (ret)
> -               return ret;
> -
> -       pcie->clk_reg = devm_clk_get(dev, "reg");
> -       if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
> -               ret = -EPROBE_DEFER;
> -               goto fail;
> -       }
> -       if (!IS_ERR(pcie->clk_reg)) {
> -               ret = clk_prepare_enable(pcie->clk_reg);
> -               if (ret)
> -                       goto fail_clkreg;
> +               return dev_err_probe(dev, PTR_ERR(pcie->clk),
> +                               "could not enable clk\n");
> +
> +       pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
> +       if (IS_ERR(pcie->clk_reg)) {
> +               ret = dev_err_probe(dev, PTR_ERR(pcie->clk_reg),
> +                               "could not enable reg clk\n");
> +               if (ret == -EPROBE_DEFER)
> +                       goto out;
You can drop this check as dev_err_probe handle this inside
It will defer the enabling of clock.
>         }
>
>         /* Get the dw-pcie unit configuration/control registers base. */
> @@ -308,12 +302,12 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>         pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
>         if (IS_ERR(pci->dbi_base)) {
>                 ret = PTR_ERR(pci->dbi_base);
> -               goto fail_clkreg;
> +               goto out;
>         }
>
>         ret = armada8k_pcie_setup_phys(pcie);
>         if (ret)
> -               goto fail_clkreg;
> +               goto out;
>
>         platform_set_drvdata(pdev, pcie);
>
> @@ -325,11 +319,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>
>  disable_phy:
>         armada8k_pcie_disable_phys(pcie);
> -fail_clkreg:
> -       clk_disable_unprepare(pcie->clk_reg);
> -fail:
> -       clk_disable_unprepare(pcie->clk);
> -
> +out:
>         return ret;
>  }
>
Thanks
-Anand
> --
> 2.25.1
>
>


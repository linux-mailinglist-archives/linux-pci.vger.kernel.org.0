Return-Path: <linux-pci+bounces-11999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24A95B409
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 13:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DB9B21B02
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904731C93DA;
	Thu, 22 Aug 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZURnvNva"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764017A584;
	Thu, 22 Aug 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326769; cv=none; b=KnwEPPBpkmGmC51R5Y+eRKYmvxjAKMg74XJXUNP8craMcTARhMs3R2ahz2wS+4WSFMHCfT6bghR3wCBslrsnY1DN2UIZZ1PbuWXl7Sj8pZVYzdEBOUWDKYaE7Ed73EgrzE4ZpgJUQcACSKGXxIPcsB7MQ46vLNm4wyDoF2tKyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326769; c=relaxed/simple;
	bh=dPpAf2f8GYYIxADJv/jtNYiSKT9rmaEvZ5LE3eLI6QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/0qr3cqeUEa4mU3Ymvt7oJ9p65ozHfg0a9jXRiCM/Il2CEn/jlFBSUJqWY7ivJOSKziH3FVdnJ3pwBN0eapBCpqKRMlzR7OPIazrzrL5CMZSbVwvoNBQsTMJZCXUPZfCc14CPc/nODfMN4RC3hNhLxs6fGVtkSnzArizFEvFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZURnvNva; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5c324267aso439717eaf.0;
        Thu, 22 Aug 2024 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724326767; x=1724931567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gmjfksgEDmh9vuwfLcrudGOyf/12SvsWpQHttrw7Ot8=;
        b=ZURnvNvaIhyLofZTOD2sQYK+yOlguPzuJNcilu0PZjbfo5jgHJK1ugTiVL3eLvox7P
         GPen8lwbiRCDA1lHAcq7Zm7vYdoYg2PEHH4oluePpkjqVQQB7AoSDnyuEcGvJ25G7bA3
         jb/iT+QnhR6yr721kdyM/yjlxilXKP09me607+8MbgeKtRoccS4k4COWxIMcmtjAdYSd
         AfSMjrBcqw7ZxTEyqbuIkUn9+FoKvaUYyg72nI2m8Awu0z+EmRnY/VdInyTQDLZkR21t
         1MXBC6+8Dm0bUsLllW/teeVYUtC3Huw6K301dJVaLRmeSPpNJm+H6eoth/Aoku4I/1On
         M3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326767; x=1724931567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmjfksgEDmh9vuwfLcrudGOyf/12SvsWpQHttrw7Ot8=;
        b=QBFq8j0yq2Bot8ZiwMGssEr3PRaZ0G9Vhndt4COP1/OYGRyRb1IyfISDxu8kA+w7A8
         66uLQJHApx2PheJPrlnGb8JBZ0ndm+DqSpdfOxEjpPHsIFqiC37lMLn0MRkyytv/W1Sl
         E69qIRNRe3XJ01IpLQHIkDbae59+QyYwVoGyJgdS+3+HqxqQaMY+XrSQyr4UspDNNMmR
         b/P0HVnNoNjOqY8LTz2D0RvQ58xv6alm36Ne+6+uUplKgoQ2BX16zmlqxCNSFFC0NQ/W
         dIJkL5/gfAQLoBkR10HaDIH/0FHFLm1gxtMgbBLUP89yWUsU6S0xoDwnyf7TPma78kHa
         G9xg==
X-Forwarded-Encrypted: i=1; AJvYcCU30BwE8I8qKns3Jdn/XDxLuyDgoJIOz7zTeh4tE4mThVCfa1MRc38I3yFVWXJ5CZthgtpbPdSLroE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJq8nzz7CqZEsVKs5aks+0Hj4S8B/+GH/B0zKIHkb6EHbQAJB
	oswYkJBrdGJuXPr8sGPnb8kTp0ygJ96MUFTa+3cdocaCU8P41ZzPbgLHoVgk2XeaX7FT9h0Bqby
	ld2iWuVELuGTpN2V8MDToucrY61U=
X-Google-Smtp-Source: AGHT+IGycQLK5BHPohGjOdsl1/QhBeJTpPJvVnDeYLgwWgnP6LUzKuyzq1DZ1dz4PM12E5lNPXbXEuJC5eHHhOVQbMw=
X-Received: by 2002:a05:6870:3925:b0:270:2548:7d77 with SMTP id
 586e51a60fabf-2737ef0216emr5993446fac.16.1724326766867; Thu, 22 Aug 2024
 04:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822102952.1656027-1-bo.wu@vivo.com>
In-Reply-To: <20240822102952.1656027-1-bo.wu@vivo.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 22 Aug 2024 17:09:11 +0530
Message-ID: <CANAwSgS2-JnnpO0dZd2bLWuKOMpbzJWTL+0Qg=ogs_-RTe8rfg@mail.gmail.com>
Subject: Re: [PATCH] PCI: armada8k: change to use devm_clk_get_enabled() helpers
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Wu Bo <wubo.oduw@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Wu Bo,

On Thu, 22 Aug 2024 at 15:51, Wu Bo <bo.wu@vivo.com> wrote:
>
> Make the code cleaner and avoid call clk_disable_unprepare()
>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 29 ++++++----------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b5c599ccaacf..48009098fa6b 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -284,36 +284,25 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>
>         pcie->pci = pci;
>
> -       pcie->clk = devm_clk_get(dev, NULL);
> +       pcie->clk = devm_clk_get_enabled(dev, NULL);
>         if (IS_ERR(pcie->clk))
>                 return PTR_ERR(pcie->clk);
I feel you can use  return dev_err_probe(dev, PTR_ERR((pcie->clk);
>
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
> -       }
> +       pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
> +       if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER))
> +               return -EPROBE_DEFER;
>
  same here dev_err_probe(dev, PTR_ERR((pcie->clk_reg));

>         /* Get the dw-pcie unit configuration/control registers base. */
>         base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
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
> @@ -325,11 +314,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
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


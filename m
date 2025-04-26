Return-Path: <linux-pci+bounces-26811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47253A9DC41
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9403F4645CC
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BAB4315C;
	Sat, 26 Apr 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dA+4ELQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9C2BD04
	for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685089; cv=none; b=nLYQ6RqR1GJ8vJOAzvpzA7gMV9CDFT48endvKHCu9o2df1ynNGt6AcOw7fF0djSJn3KyW4KZyIIY5RODrJGOGNGnwqwkxskT0eU7m9LyOtTYqUmlwDhimc9B5/cjQRdtLQ0yUF6CG8veh+TpYSIovTLIMzGk4jOqn4GgmEo8zfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685089; c=relaxed/simple;
	bh=60hZ6uGFDsy739bKKXHOephdWCwWeqInkS68CK2zNsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzoejZE2ZbfdSbbsaU23LGmm6QvhRN1sJQUG+0WxsDGJMS7vt6h14C2GoSPB/lQWefN/UQQaq2MB94GNeba4F67q11RbSSXwF0kNp+1zOTBo9Ea/CJXSIEFrJ99Y/uaVFbIEUw1k4zYIMfmmHQk/ex5B3MUVBhk74Z4EvX2zOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dA+4ELQj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33e4fdb8so36336475ad.2
        for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745685087; x=1746289887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Frbgk8epMXu33rseJMhLh7pjks/wfIb6gug4Sy+yOUI=;
        b=dA+4ELQjZbu4/J26qFb16ns3pGbD9ltmZcX8RZ94Dn28TGRK2kR4BveXx7g/1ATiwe
         FEzYJHE9GMlP8gsXeJE0xjQcQ1MVF46A2KXFk1BiTevWHi/6BU7q7M+2LYX3lVXHmauS
         fzql3QsAfVgF0oRefNyFZbn5BZYmi5bQb+Qx4uH+Ym943ochc1J0FCr4eNJGKGs8byle
         +FTErt/j1TWWf0JxS5urRlC0uNZo/AQG2eArjI9HMgOOAKvcdaU5sYLinaSdBbye4r0w
         NO409PBPzWarmLKP191pvV844y2nXQMC5gBlDluiBKa6+ESF/WNJ6RPGppF6kF5jwLlY
         9KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745685087; x=1746289887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Frbgk8epMXu33rseJMhLh7pjks/wfIb6gug4Sy+yOUI=;
        b=KaMc2MbylBkHuiB2Qop6nsEuNHrGr0/omq+OaU6Vz7nbCQ03CIHRJCLKFBw77zVK9k
         rrpxDHjdi9e0P90echAB5CA23xXfFWDHFqouMurobde6k69ZwMY7s+i5nff354qrlZwM
         VTm5D/PHY/QNAgMAbMsftfKhmH8ZQrgr3W17Mh1WCy/bL4op8icFmFBO3AMe4oSoZp1M
         wXMZmgnhrb34viziLd0kDgm6D0EC76S8ElhfCCSkUj67jGWp+yx1SvFGg1d/pLaozm+X
         wTHGiXJu/7ZrPBeipVrvVySUwYLfKZ1HLJwfMkNclH4Smi/cpdv4sECJrkUSEkbndAa0
         bSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2wijpH7azIIThN2gOkWN+1QgLpxBF4IYdVx7+sREN8Y1HUJKnsf1sAIW7sd3hXrZPz0hzaWlnnvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7AjpMe0jsE//qgUTFA/QbuBvY0Q7Z7mUx2XU3mNHvGWz9q0g
	/ZeX7mXRu4XDJI+mqsKNv2FvvfZOTxJg4PshQxKQyrbtdUGK9flSmVCc4r2bnQ==
X-Gm-Gg: ASbGncvcDoIaej3fW2MWiNsv0iZZR/BsFpqb8ddAfama4SLhPeQ9bP5wYJW4bPvz3oT
	hQyPghzUq2HrZ55SiGtVdskEGsa8DOxDoMGYFKV5pxDLNNTy2TONF4SzWjFGocQtkZfLIi0suTI
	xjvJrieWD9UTUOCiPSdZyW/Pe6HMdvTAvUUpij6hk/waqE+OjE6JvsrkwFFlLd9vYtUlBnw6TTU
	9z3tKW3i0IDhT3s3PGbfYmcSQL3mfTrOG1MMnYzJwutGBPSIWlC/gEPTG6NEAIQbel9VMiOj7rx
	/CQCuHqnrA76EEK6/qHFk81veBl09tiSdFA8AX0W0i9cfGHM4PBI
X-Google-Smtp-Source: AGHT+IF6VUEmpTBmDZo5b6hBh4vSWZqVx3hBf1jF+ALj6XNykip/pCqBWItQlyV5zJXFq4smqjxuhA==
X-Received: by 2002:a17:903:244a:b0:220:faa2:c917 with SMTP id d9443c01a7336-22dbf62c39bmr97410935ad.34.1745685087383;
        Sat, 26 Apr 2025 09:31:27 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76c96sm51466445ad.38.2025.04.26.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:31:26 -0700 (PDT)
Date: Sat, 26 Apr 2025 22:01:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/3] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check
 from rockchip_pcie_link_up()
Message-ID: <hix7wmbkm2lccidzlq3tmpw4q7ul7z6s5gajzd36l6ts43ym6e@2435govdgcmo>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>

On Thu, Apr 17, 2025 at 08:35:09AM +0800, Shawn Lin wrote:
> Two mistakes here:
> 1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
> 2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat
> other states, for instance, L0S or L1 as link down which is obviously
> wrong.
> 
> Remove the check.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")

This is a stable candidate. But do not need to respin the series just for adding
the stable list.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> 
> Changes in v4:
> - add Niklas's review tag
> 
> Changes in v3: None
> Changes in v2:
> - add Fixes tag
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c624b7e..21dc99c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -44,7 +44,6 @@
>  #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>  #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
>  #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> -#define PCIE_L0S_ENTRY			0x11
>  #define PCIE_CLIENT_GENERAL_CONTROL	0x0
>  #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>  #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
> @@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>  	u32 val = rockchip_pcie_get_ltssm(rockchip);
>  
> -	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
> -	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
> +	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
>  		return 1;
>  
>  	return 0;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்


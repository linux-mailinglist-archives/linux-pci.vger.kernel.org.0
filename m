Return-Path: <linux-pci+bounces-23253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E5A58653
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B61663C3
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD01E104E;
	Sun,  9 Mar 2025 17:35:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A1DF42;
	Sun,  9 Mar 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541709; cv=none; b=HEJIGYFYUhMCCSEH+F91AhH8gTdnVc+PiTPi6jDKYBGQJ7cP5Rby+ngOwqoCP1WpOgAbs5Ql9vg4CpNhflbArmA/9cmvGHx1f99xTHQ9lX+dd4LC5bmdEzGyQfH0GewJbL+Ij9SaCzHp+YxXmogSIQzNqpanlxZngeT1jucYXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541709; c=relaxed/simple;
	bh=R1HcZEoim7RkU2s3cAzwwS4sVdwcrpbNQ3WffTXn9mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoHXbDrSEUYW5dWXNYKMAdsprGdn5S044XIPdQjDA5sj77/nlQNduqFTOsrlPkk5grPB8qBfhPDLxhM0QWD03/Qg8YFjEFDc9ezAQ4GTvpYWybuZJHF8tfTlkMGZPuli7dnXBFLxsUQdejH4bM0F5Pkk2HF8odzsCYIZ5V8qCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22113560c57so63609955ad.2;
        Sun, 09 Mar 2025 10:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541706; x=1742146506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqfgSnF+WviyCGuHYaz7kEPSmau08UBaZRQ3w6s7VbQ=;
        b=QSzdH+XdClwGTXW2tHGPFIJqyfDgrURJQqHHs+/IO1OCXLmOgkPOdKiMjlF1OolfB8
         v94lxQQYcw9EO4/oC7YZq6cqkZXC/RzVXijvdqW0geEnGKHzvyfPxweuolRDKYQxxSN7
         FDw+icyaxGScNpwKnMVDKWUNU7EfHu/u4na/EgrPtaadx3NK5IKJ23X5m00Hp/s6sCmW
         y72UPOgW2BWKCOni7swZSeIapvodUGvC/rVDF6NWwmgDTssl4J0CiDxUR57I60LRFhp2
         iPjHAb8nCzlI85/M+z9IeHerqY3NAIIuVVG7V1IyW5MQzePhjYcWRy9iaXbVRjLDt6zC
         JH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUESqf55HBvo4Y8LXQ22N6M3K1/Lupl+5TyTvSpOChS4mdOWuZX85imtpw0SgngepoYZ1zpneZQyczp@vger.kernel.org, AJvYcCVkQBe7Zkwa5b4OHO7FyMzNWjYHzq7NSCku4JzEVwURwaeYHeDI9qh7zWcJVHfpABYJnYrRtPi1EAIu@vger.kernel.org, AJvYcCXdDuWV0PbPrFNS9x1x/9TGVuabaSwwdrSbj0pSRkX6S3TDx4g2PoAfrcy/U4y3BrleHUGU41JgEgKYoUoK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1Ou6cg2CzJ+JHvsRW3++OgW5iuWZoxp0V49SAImmTw0FN84v
	XLXJjjxx8K7GawE6PmMWB4k+b9TOmx+T9OFAzi9CPFb21l6nX9CM
X-Gm-Gg: ASbGncvrytGIFcuxL4mn36/uvVKGG2kL4FH5hQyUyPaGdbMP/Q/8vOWMHGp5Zg3TvE/
	iBAGz7pFap1DTN5H+gJ0u9d0Ep7R1M7zk0OL8LNflXFyRmoLk/P/TgXhkHEnNkJ50+SSCXyaCkZ
	t0czd3rFQb3mU2axwGS88+Jb1r7an2H7vNLweUrboO6j9IrqfxZWqIlgEKl3LVe3FZW/pZ0VMs1
	bSxlanfuSpNDFfN700DxTlb6eYez8IvzYWnCdAtV9q9L5uxhZNvHfotRZp3IJ3qzhGvxzE7s2rq
	/GwTBZUCLbTl8VYzy2U3sgI4Pdw9jgPHnsQKuKEpe6SYPUnh/Yqwjgq+/fKj3BJ8Ce43h1FJBh1
	fzH8=
X-Google-Smtp-Source: AGHT+IHVZbyUWkJbEz7fVY1tLMRkANLMWGHI0dBoEjw74h/W7/m++eJqTOXwGGMJyEQB9vKsowPLBA==
X-Received: by 2002:a17:903:2445:b0:21f:52e:939e with SMTP id d9443c01a7336-2242899465emr214237965ad.28.1741541706127;
        Sun, 09 Mar 2025 10:35:06 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aa8a86sm62324315ad.240.2025.03.09.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:35:05 -0700 (PDT)
Date: Mon, 10 Mar 2025 02:35:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error
 path of probe.
Message-ID: <20250309173503.GB2564088@rocinante>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
 <20250224155025.782179-2-thippeswamy.havalige@amd.com>
 <20250304154608.5nmg4afotcp6hfym@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154608.5nmg4afotcp6hfym@thinkpad>

Hello,

[...]
> > The IRQ domain allocated for the PCIe controller is not freed if
> > resource_list_first_type returns NULL, leading to a resource leak.
> > 
> > This fix ensures properly cleaning up the allocated IRQ domain in the error
> > path.
> > 
> 
> Missing Fixes tag.

Done.

> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> > index 81e8bfae53d0..660b12fc4631 100644
> > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -583,8 +583,10 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
> >  		return err;
> >  
> >  	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> > -	if (!bus)
> > +	if (!bus) {
> > +		xilinx_cpm_free_irq_domains(port);
> 
> Why can't you use existing 'err_parse_dt' label? If the reason is the name, just
> change it to actual error case. Like, 'err_free_irq_domains'.

Done.

I took care of the review feedback and added missing "Fixes:" tag, and
changed the code to use an existing goto label.  Both changes are already
on the branch.

Thank you!

	Krzysztof


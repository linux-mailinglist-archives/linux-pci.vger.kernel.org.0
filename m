Return-Path: <linux-pci+bounces-22960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B200A4FD89
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A716C782
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DF207E04;
	Wed,  5 Mar 2025 11:24:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2011EB5D4
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173891; cv=none; b=r5UvJkt4fSTP8xubWUeJnKh0PFAYPOJADUunCgAsU+70EcEqTYlgQEonUdrMKX+7bSTm9mJqzhggAu5wnDeURGMC0gZsRsUAzLj7drfObhqV6fiSzjgNveLqFsx/mqQPlWDhldXBzsrNxU7KsFzRqvdZ7Pez0wuQNGKkMqX2j8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173891; c=relaxed/simple;
	bh=deq7DFb/tsyaPGEfda0+Vcn6lOwrwwjW5eMWO9WZ8ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJatbmYLWL2z1zAlSQPuEhU9otYUdmZ+sglm/DHNvmVAOMTOcGD8fjwu530uH6nEnOw/W4vu95c+s19t7Orm/QlNLty/8YNZkFpHZ9Sl2lsh9lZ4mkp+yTH7r6yGzUIYYaQgPsO08J7gEplhtDtARVo6VIb8g4Ik4fL4+F+UUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349bb8605so128012255ad.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 03:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173889; x=1741778689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTS1pJZ4JZ7TX/DTTQ3e6ShUkpSUBSfb+IAcp6hhnEQ=;
        b=fbudxuGXIEGt+lHw3gnKYMOa6dszK52P0KNRjGGqHOaL+HJcKvl3EOYPci7vEvBub6
         wpCqedas8TAND4Rq3fiw+KOsuX69FQPiw0BGjWuBA3RM9uVI+elDAVii4BU+lq9H+tG3
         a9qH5jozjI+PFKzQMGVgAbCna8t92EHYqbhNYWaX2bPAFrZ+uX6ruY3VeCZwFmW2IcJr
         f9rXldEM8Liymvh8GH/EeiX3IQhYn5FT09VYyGc0rzgHj8kZr1nJ//HOc3aHXC4en/so
         y7pPexhI+Wwnxey8fAwfeKyPUv9DFhUcp52/Nj66NRKK1hgVqXky9Nkzm6oo6FxJ6rqu
         hv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/RIg9fK7usitHM5ebXjaEbxegQZMRSsXbHPlqA+k9yuy6ko3+jLd1MkrF1qtFElwy99Jf+rmmBT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTfoJmPc2hhVni8lF9xuHzvMnNOQF4zf++SBrR7iMZtn/jKC7
	D2a53gkNw4i37SjJDyrgvj5lQ8NgsJGg/iiQayOlOV3YPRXDhAjq
X-Gm-Gg: ASbGncv156EKZl1nstBuH/8zQmfzzHTOTKGjErWITs5/fJ0OORhceDMaTy9K/TUk4dC
	CuJBs1wEgfR0y7uiwsSzPqrhNjpSrLu2vX2O3f27pfVuhdVspAma8jnZZDOwM215J9jwGsItfsd
	laRc2kjZ7lGxQ+gi7A+DzuSn4YIPsEPABXTkaWiR6npK5OuSPVq6920F449tgaYGrYIicmXAys3
	FENFpbyQXgYsqa+B+DhIiGBVYNkwDf8pR08zPW8kxXQAQ1rqcJxVGn9c0TnsSRtpPaHlr99SnY6
	3/JZPEofShJFWj8x8hk14toP5lDGOFTcduB/QiW15oLJ9Zadf3zLdBJOBNnhXw2w3VxG2yFEK11
	Yr0k=
X-Google-Smtp-Source: AGHT+IHnA+q8NV9qymXjZwhd5nrezIO064lRAkb3VThBXaEP1ccaVgEdEdqJycuGzeoPPewQDbGkTQ==
X-Received: by 2002:a17:902:dacf:b0:216:2426:767f with SMTP id d9443c01a7336-223f1d23893mr47021835ad.49.1741173888681;
        Wed, 05 Mar 2025 03:24:48 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223f5a435a6sm10228525ad.248.2025.03.05.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:24:47 -0800 (PST)
Date: Wed, 5 Mar 2025 20:24:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Zhang Zekun <zhangzekun11@huawei.com>, songxiaowei@hisilicon.com,
	wangbinghui@hisilicon.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v3 2/6] PCI: kirin: Tidy up _probe() related function
 with dev_err_probe()
Message-ID: <20250305112445.GF847772@rocinante>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-3-zhangzekun11@huawei.com>
 <20250305055431.ugiwvydrdw4rszte@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305055431.ugiwvydrdw4rszte@thinkpad>

Hello,

[...]
> >  	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
> >  	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
> > -	if (reg_val & PIPE_CLK_STABLE) {
> > -		dev_err(dev, "PIPE clk is not stable\n");
> > -		return -EINVAL;
> > -	}
> > +	if (reg_val & PIPE_CLK_STABLE)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "PIPE clk is not stable\n");
> 
> I guess this is a timeout issue, so -ETIMEDOUT.

I can update this directly on the branch.

[...]
> > -	if (!dev->of_node) {
> > -		dev_err(dev, "NULL node\n");
> > -		return -EINVAL;
> > -	}
> > +	if (!dev->of_node)
> > +		return dev_err_probe(dev, -EINVAL, "NULL node\n");
> 
> This check is pointless, so you should drop it.

Some other drivers are also doing this, I suppose, as a precaution.

> >  	data = of_device_get_match_data(dev);
> > -	if (!data) {
> > -		dev_err(dev, "OF data missing\n");
> > -		return -EINVAL;
> > -	}
> > +	if (!data)
> > +		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
> 
> -ENODATA

Almost all of the other drivers return -EINVAL in this case.

We can update this here, but I wonder if a follow-up patch to update other
drivers accordingly where it makes sense of course, would be better here?

Thoughts?

	Krzysztof


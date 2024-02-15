Return-Path: <linux-pci+bounces-3497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48F8565BA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21941F24696
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36912D74D;
	Thu, 15 Feb 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPZ7w0Yh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723EA129A73;
	Thu, 15 Feb 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006639; cv=none; b=RiJYA2eKFS8bDAo271NA0YeoICOj/tOWhWuNOAa+TFcaxWaKer8H3zPhSwKNUX4hCUcTkWt5x/dJ0a1bR1dIbu1j7S3W5eP0zlSgsK9w2Tz57hvaWGO6y33RxHr080Yhh64WnwWMHu+MpoRjx2K1SIHbZrPvLnc26LXCfVy0MpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006639; c=relaxed/simple;
	bh=4H+iR8aGxxFCoMFHwf2l19pGGIJ92Ffk8H4vV2vpgOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVh3qsH8Qyl1+iD6bFpemnJgORvJ/rAAQI++p2rF9IRojBU3aGkxikAVJDd4ZehgyMGYOoshmn+ItEwbqm6K2B2G55IM9OHH8oit0BjBxjcg2jBiBXXadLARzRsqa1s+C3OyF9zk1sML25XuB4a+KAyFVJ07rOQuS0cCsyWaqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPZ7w0Yh; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0bc402c8eso8967351fa.1;
        Thu, 15 Feb 2024 06:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708006635; x=1708611435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT54JnEJDGAg08CMMVH/+M305jfI2/9H3G2UVROz1uY=;
        b=BPZ7w0YhQz6C61dr+/8A9VqEfVVBCi6nn1ABmYgy0FnngET4+9ufp8lIqT2TmHu6MI
         3UgJkhFZja4GfPK2kOX7lXNSfojA61S8RgMjude30cbWPKbGeA7pY0DERyW1Nu2e6R6d
         XRXkqcp5L2B9ruVP6aqbfC0snq/hg+Qs3Y76H079YMKUNnPfrp7eGb8j5+KnmM0CO+QS
         VGmqeig+bL0keZ97QqwdNlidnSXBrSRrLy5EzlNQgzHHAXLB6c0nv3JTiwrnqJ7gw+YO
         vEbWo2ivuJ4WDzC/5TdAKiuzqtIkuBoevKQF/r5oMDyYolwtTE5/oNhRdvXxpZONNwvJ
         5iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006635; x=1708611435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT54JnEJDGAg08CMMVH/+M305jfI2/9H3G2UVROz1uY=;
        b=vfvlYasVIkHcKeFt9R0Z+jullCnwGfog0rOQibpKwaFJNM9pa1jYZJJriIDSeP1Pre
         Jll2TzaBIGwuMQL4x8HtGHI155H/K/3P6n1+AfgrxQlYwei+lWXhIP+h7vjSWSdMSmhA
         sAmk/NwvU9yS2WPCgxecsF4FvNgtW2tx2h8Lt6CvCnQPTSjdAd8TnYKMpONnGLc609QJ
         EJDCRtJMb9sx+W8fw02YRSrlBBH2r/Y7r1QaFx43lUDTwTOTKjs1UUGkryZ+uDTeg+go
         cPeqbqG/ZNTcFs58nJ0FNEKloE79bYJZkiTHn5BMNN1k4FSzI6dO7vRDta9sE1sv2QqR
         31mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkBqZ1yDmxnnJNJBLRVY2dKRaBwE3Zv9PCq1LH+LyOIxt3zPvpFZ3kfY/ax2CMSzijrWhsIEyYmtyGZeG37tkOZre3TuW+PS/5XbYP0KMDUTYV0iPsDcfE8N/r3CY78K9UbpPABDH
X-Gm-Message-State: AOJu0YzM5uYhdYZ0cEDHIevIiei0EU8AT5PU5yJUlFkPbEhJSRgRWbyR
	2/QZElyUlP4ZfF1rDPgc1LYBvEMKkNux8GmBNaqemcmiuQAJV8QN
X-Google-Smtp-Source: AGHT+IFy9AWKohqG+mIYkRHT7tZFmVtKV2bSHsT9yAz4d87mMpIAlFu0SJlWxeIGFp+RN+lqme1G4A==
X-Received: by 2002:a2e:9d10:0:b0:2d0:af40:7058 with SMTP id t16-20020a2e9d10000000b002d0af407058mr621746lji.14.1708006635324;
        Thu, 15 Feb 2024 06:17:15 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t17-20020a2e7811000000b002d0d0d06fcfsm290350ljc.103.2024.02.15.06.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:17:14 -0800 (PST)
Date: Thu, 15 Feb 2024 17:17:12 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Message-ID: <buqxbxlsngec2iz4oag7mfgva5cozk66ljfa6aatao6liepnzu@zlmtq2v2ib3m>
References: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>

On Thu, Feb 15, 2024 at 11:39:31AM +0100, Konrad Dybcio wrote:
> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Tested on Qualcomm SC8280XP CRD
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..abce6afceb91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		if (dw_pcie_link_up(pci))
>  			break;
>  
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(LINK_WAIT_MSLEEP_MAX);
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..3f145d6a8a31 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,8 +63,7 @@
>  
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_USLEEP_MIN		90000
> -#define LINK_WAIT_USLEEP_MAX		100000

> +#define LINK_WAIT_MSLEEP_MAX		100

Why do you use the _MAX suffix here? AFAICS any the timers normally
ensures the lower boundary value of the wait-duration, not the upper
one. So the more correct suffix would be _MIN. On the other hand, as
Alexander correctly noted, using fsleep() would be more suitable at
least from the maintainability point of view. Thus having a macro name
like LINK_WAIT_USLEEP_MIN or just LINK_WAIT_SLEEP_US would be more
appropriate. The later version is more preferable IMO.

-Serge(y)

>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> 
> ---
> base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
> change-id: 20240215-topic-pci_sleep-368108a1fb6f
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 


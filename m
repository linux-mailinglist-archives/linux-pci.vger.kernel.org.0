Return-Path: <linux-pci+bounces-28964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBCACDD91
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CD5188082D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345828ECCA;
	Wed,  4 Jun 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydSWUQ/K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E381E5B99
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039028; cv=none; b=FmazrD6risId9kuEYKchmou57xyLbfSJx8pmiKUYbIyoKOainXcvV+g0opxGtfI4Z2WjnJGnR2i4tYpmua44pbgSoNOzTgPGLLbbPasFV+UPn/h2+/vMwyjvaB8sOBGZvJql9n7o/zBo0wpocTLJl7zVDfZHjYajVRvEVK01ELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039028; c=relaxed/simple;
	bh=2qRhj+8PaD7KbS+ePJC+FIyfrnTKwmRG37BmkAjQGxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoorJXEEdNRrxnyP4mJA9A4SCpwR0SfBjQVzjE/jBSJ7nTMe6U3Xfjw8dbfXjGPHYwLiZmr6yH3HbkIRe6owmXv5wKg4IsJkWckbAwkbaDJJrfvL/Nzv4QZMJZrzZcYW5TzNxTVeEtKGzYecss9Rd6/8XJNsZX4HGOZkJSozONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydSWUQ/K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234d3261631so45756315ad.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749039025; x=1749643825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWB1gx1mno0s7eFeJEUn/nD76wT6cl2IYjc+kN6JYkw=;
        b=ydSWUQ/KtPdi38pFMGjiNI8vQAz1YrJGjTRYBMNh3lVcpKha+82Tjs8ieW1iO4QAXG
         rPsWxto21L/+D8WL+0hSrZwIZ8DOA4Ye5cjiaiasXD4i2MdYwu3KES33K3zT28/j/WMF
         OvSASVFNITGd9SKvtrrqFbIqtlmQi1jkxIRGnEzq0LBs2CXIdPx4J2iPb2dKxGacN8ul
         leSWL/EuTtK5bp366e/pvE3r5vC3soT7R8s5SRBUngxxRSGLgDaEqi2IMWQDly4mr3Nm
         4LEkqu0KfyTcfWAGQX8Zf1zaqqUMqIMuXx954eL2+yiHMG1Q0HNU6dhY+tBWRn94K5FG
         BzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039025; x=1749643825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB1gx1mno0s7eFeJEUn/nD76wT6cl2IYjc+kN6JYkw=;
        b=dWtluWWGkghHmi8elndmRHH74iK5mySW7fBd2x37ligoiP5X3bCoDi84Q1wsgTwYLj
         sJUOy41I9pu6VTTEMwbRcVz+keIe1tmVCW/xdDJue01IeiFG6ViPrX/9maJ1SZcnejMi
         VP6hYcAZIn2ICfdf0Dc30sAguhe82OyZydib6jcay7ZjWqgCdzIpk8nUzl6z0PFT91lj
         wi9AwAgi2re2ev2hujbLlmg3aqkG/MjayAL+O9EZa4BsZnXdUwW5sBOfSmn+i3+BIsFZ
         MXmZWSstrnfrDCGpUP0CNntVZ6NdD/Ulg+TjTaKqft92YCbfI1wjqXDgk1/WXK0yp9Q5
         nk0w==
X-Gm-Message-State: AOJu0Yz5beczpRWJXSq/eH9fQ4X+N/E7II/c34FJ1IpiGg/87oSv1B2O
	+49I71fgItlT7rixmMpucwn4eL4s5bwRYMZna4YXuScUgcN6RjeON9R2asCa9BUhFhidk/rhfIj
	1tbA=
X-Gm-Gg: ASbGncutoMx+zgyEtMLsk41mO22QGDespSERI+Trc1g7G+ZqJSHcc208JFibeK/QIbq
	aJeYQOYCaY2BcaWwxhUV+Y2YG8garol7j3wIiIBxC4X/NkRRa5q//1ldK+b3IQpmwiK9NIij+OU
	CkLanKjmqgJV2lse7dAMDlUYSUR6PmQLfWIhurUvZZeLiGgGx7+MQB9tOVntrAMVWEzInRrJEyo
	DNyGLsHANkmZU21AT5+JFbfR4K9gcurmSpDtBbXJ5MNrVawwnCqpDDwDEIHYK2mzmIYzA2bJamo
	PpFMbrnSdyRtY8WKJcQ24GyZXmiR2CiY3Ff0g4PLanIodgp3AbF5sty8NPU9RQ==
X-Google-Smtp-Source: AGHT+IG57XGK+U+lVqYG/JIjQeIC5Z3vtLCeEP/XJOi9Tpj75vDY8Loup1Fc3OWKbmi7pysssKLxpw==
X-Received: by 2002:a17:90b:4a10:b0:312:26d9:d5a7 with SMTP id 98e67ed59e1d1-3130cd2b40emr3886359a91.20.1749039025081;
        Wed, 04 Jun 2025 05:10:25 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3c0db6sm9661015a91.34.2025.06.04.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:10:24 -0700 (PDT)
Date: Wed, 4 Jun 2025 17:40:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] mailmap: Add a new entry for Manivannan Sadhasivam
Message-ID: <ejg4ds3igm3njxfhtjx7uoh557tzh3tw2ig3srixlvlyaj5man@rs3gx46dahmk>
References: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
 <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>

On Wed, Jun 04, 2025 at 05:38:31PM +0530, Manivannan Sadhasivam wrote:
> Map my Linaro e-mail address is going to bounce soon. So remap it to my

Err... s/Map my/My

- Mani

> kernel.org alias.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a885e2eefc69..1e87b388f41b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -458,6 +458,7 @@ Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
>  Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
>  Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
>  Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
> +Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
>  Manoj Basapathi <quic_manojbm@quicinc.com> <manojbm@codeaurora.org>
>  Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
>  Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்


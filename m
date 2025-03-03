Return-Path: <linux-pci+bounces-22785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF668A4CC5E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921713AD4DF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B22356C1;
	Mon,  3 Mar 2025 20:01:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913B2356C0;
	Mon,  3 Mar 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032060; cv=none; b=OIT0UhityM/yw2MeG1arjRVYEzNAL04vHzNFvf6e0Kt37GSGdZQDzk2Tae4II0hNaYvY2W8+E/dR6qAn3kKl+fXfvsm72drm3CprfMDEZhg1xys5MV2yDYe3ki96Tz8ot0VcNNrTT6NVWbokGViQA2Z9Dh3GkMscXurp8Xh9eZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032060; c=relaxed/simple;
	bh=tT37Gvv9uhcGOPTFEOztOSnc1eG43/eY83F51iOT7SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV8MSMjO1xO9M46AyUJcXgTYZL/277eBJf3/MCXjDyHhFc9Y/poq6Ot6YkMxLg1Ls0UexeuIk/2F8tT5JcY0rR6n5oZtAvGe++c82DG1B6yYCwkv+Lgx6+zbqr6zFX+iSC3Xv5Nu4sgXiR4wd96VKBoaeBRgv/NRzpnURCbFjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234daaf269so64641335ad.3;
        Mon, 03 Mar 2025 12:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032058; x=1741636858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVlIeIIYEUcXVpBH0ZR2aYcLcX0jlCTjHLmqUh5GcV4=;
        b=jR/GkN8J0QSmBTLMm8A7fp3k9elaO/VKw9pp0eZErqAz6BZAtPe70kWb4551qBdgk9
         xVtMoFmv9jgYMqI4zsCpr0O+21dYukOTFSp3zpE3Z5leyuJ2p5eoKHja6sfCjBfXXv9c
         TH4BNlfhwYLi3F8X+fBqWvFcU2vaJVL5wPiMo4mc846+EJpys4wIIS4AR3J6hyKwtwiH
         DkHTa29A4dcTdZbPeZ51kj3r7FzAfSgbaGFVOOdjXtn6BQctinRbampFAlV5dTiutupU
         QSqgMwoTxUJW78rvjzJytUt5YTEYvmibvkl7b0HUULHucr4y6tGcR6CV9MmcF4964lEK
         9oaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPiuppRt0HNU7j0zLoMMw4S+jzvn9YW71+TIEX0aGv/QbQ2OH3//gw9thNIYb+3hM8XbwYaTcTq8i@vger.kernel.org, AJvYcCWe+N0/NR6dC1Dm0raFD5uIpDSbh459OMoMUc9ppQucAjkjNdaPZD7b69wOPM24GnCON7F96a2ppmDjK9M=@vger.kernel.org, AJvYcCX2KuyQDdF2kV5Nj4nu2dB8MBDwpDxBFej24N40Ii25lagjVTKkmUA8irIt6SAlMpLcCb/4vSNUssLzlUa3XUWOZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/6MEZtwApFshed7fz2fAoo4iP+BlgGkowHo4zB03UIKcpYv7
	XjDVzs0ZwHPY3+1Fi75U+4pU5ZBAj47SFsx+V8/+eU90olC2HQMF
X-Gm-Gg: ASbGncsBsQdMaWYtWA7e4X7+1WeLjHEC0MH4zpvMm+DNKLEkY6gMt9gpwYAQoq7WNQL
	65Z0TWowMhEC12lAFxrnjkxTlCkxpdiyf42RRme2+908ASrzcSpb/Zs3cayKt05XKoqoBUGPjWt
	nj6XtyIhQk2Etq1dQxSCfa436TOB2GYU+FEqs+vwmQdFgKDIe86xHCzgVDMGACYw24PNbWZUPx2
	x3tP+K6kTwb/HBxErerWDobs6CCpY/ndSZRBCEdlOR454qWnLS1yW+u7HGNLwlhWmcZQ7N/Gh8/
	yiiIN30GodLeY4rxcvOwRaodfzjcNQciKH4S8EOXdcCWND7oH+B1xSA/Lqb5bdNDcTg9lknM9F+
	n8N4=
X-Google-Smtp-Source: AGHT+IGknxLLIXBeT5c31Vvl+cZh8b06bZmuGqUJWYc+uYhvP7flXlsd/7jPzf+IyTyzNISceBSJ8Q==
X-Received: by 2002:a05:6a00:2d1d:b0:736:4536:26cc with SMTP id d2e1a72fcca58-73645362c6fmr10629091b3a.23.1741032058394;
        Mon, 03 Mar 2025 12:00:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7363f2e8a34sm4076852b3a.168.2025.03.03.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:00:57 -0800 (PST)
Date: Tue, 4 Mar 2025 05:00:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hrishikesh Deleep <hrishikesh.d@samsung.com>
Cc: shradha.t@samsung.com, 18255117159@163.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, bhelgaas@google.com, cassel@kernel.org,
	fan.ni@samsung.com, jingoohan1@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com, nifan.cxl@gmail.com, pankaj.dubey@samsung.com,
	renyu.zj@linux.alibaba.com, robh@kernel.org, will@kernel.org,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <20250303200055.GA1881771@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250228114813epcas5p32127b99d3a0adf6900a104468b48768d@epcas5p3.samsung.com>
 <20250228114301.31739-1-hrishikesh.d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228114301.31739-1-hrishikesh.d@samsung.com>

Hello,

> Thanks for adding the support!
> 
> Tested the patch in one of our internal SoC with DesginWare PCIe controller. The patch works fine.

I assume this was for an entire series, not any specific patch.

> Tested-by: Hrishikesh Deleep <hrishikesh.d@samsung.com>

Thank you for testing!  I will add your tag to the current branch.

	Krzysztof


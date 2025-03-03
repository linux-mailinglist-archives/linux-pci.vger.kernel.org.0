Return-Path: <linux-pci+bounces-22782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E0A4CC2A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AD717463C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048122AE71;
	Mon,  3 Mar 2025 19:46:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088F1E7C25;
	Mon,  3 Mar 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031211; cv=none; b=Z2yuTEZ5YVzQhfMR3mgMFokKR9lLQl6DuFIK1jgP3aDKX1FHuz7UZF7Deu86xsz6UcFWxCZmALPiyrnjqGLUyEtuQe4OUWz6mDvxr3we7buK6AIuLTUruOovTgVjiPx82RTXxHp360Hn71EBZ0z2ri6smyTvJHdLOgj7upNLBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031211; c=relaxed/simple;
	bh=Ao8ukNGyO5FRpxXAyl7CTfc4UjJiCkXhlRi57KBMtQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smVAgGEanUASMcjB7nuShvVowgyhwoznBcUDB+Pc7ydu9kf1pQjyAn5Ft1E0IN8EY+oKrO24+VXQH9713bC3JhaejEsJt4g+6y7dJlOolZPs2OMPO7VBvwbkWxaxR8LWTVN8CPIoBokqgJI5xTecdwHkg2zSPBzhJhXMhXvvmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22398e09e39so33204795ad.3;
        Mon, 03 Mar 2025 11:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031210; x=1741636010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dek+FDPeZjeeIpsF2E44gvfK0e/oZIfm/67LelXRus=;
        b=nmB9gQU+OgeyqFTMadVuu+Y5SO0GNM/QnglWh01pg0eCurB1PL4/YRLCRfKg5kh8A5
         4yuS98HzJ/YrGoML7Bafcitb3acm0ZD+6JUD+1f6Zs5+77xdN2AQvwcx296ugOo0IOEK
         xZi5biSabIfXe6S0BIuAa5XzDh0zddU1DW+qFBiu4TBi6bTkpNGZz5itluYh94/D98vE
         YfkyguCzjJAQGNIBkO9xVuYfZevA1ay16l2Idy70xzFR1tmo6YcBnoUvNqRj3A4jV/9B
         B50r/Erw8AQtvlJt+eAgzc3izh6bZmPMcgxmSErcNTKy52PLfDPxJwNijPoJTp7GyIs3
         /muQ==
X-Forwarded-Encrypted: i=1; AJvYcCUubeZg5K75Io7D2NtiuB6wR/39bPPIHWyuGkaAvis4D0zUsYluVAqzDDzh9ev/6ugZjKc9OtkRR6+a@vger.kernel.org, AJvYcCXFpFpxR/JjkWX8WM8JqrPf8NiE52Iwdx95ydWj4NPEVMr5BX1J6YWez6lBBi+PcoxDTsJj9toM4yT+Y7bh96r4hA==@vger.kernel.org, AJvYcCXLIyWCszDshqMMlumnl2mdwA3/EYjKBkTFSxoo5kiAWJeF4RjX8sQJczcrLFWohVTYcW7FEVSN6+Cb/X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaR//r2RkGZbIYb/tLHnUbmikRT7y/31yxQwCwUzJS1CC3dO4L
	qrjMIoL9QSQR4n6OLMZCqo76CicmmqKGjKvD19FJiPXHSM9X8Rbv
X-Gm-Gg: ASbGncuCQELgoE3ndmT6joMfBFrdt3WUa8o+7Pxc9wiUomvQN1FNswtSD6nxEiaNxnQ
	fw2vYEb+3RbN5ncwv6d1CE3kwGG2V5IIOXld1Yw7n6z0tqrk2Bo9OUNudTbhPSEGlY7ROnE+D4N
	3ULiEhnrgR73XFWaX2IrpJJJYC4dwj13SIYBfrC7URK1BiU6LFY4BT3/q1P9XYV9P14XPSVmAy9
	ccakm34g/CLfFWlGUyA4u1ged1GtMBh9oGBoC5W6snHTXMVZUX5ZY4CX31UbdB0KOrUj4O7Wnvt
	evcHaBgKdmNNGdLwFmjMGkpBkqzTjKp3yQF3nyKFSHB2ycahabz3rOI4aNTb50AgKLJWbY/96m2
	oZmk=
X-Google-Smtp-Source: AGHT+IFb6LGLr6n2gvyZ7SSG3EPL8TvaZlZ1WJzOGXC85Bkw4k+sVACmwEySy6Gx9cQRP604zBwk+w==
X-Received: by 2002:aa7:98cf:0:b0:736:339b:8290 with SMTP id d2e1a72fcca58-736339b83admr10650834b3a.17.1741031209589;
        Mon, 03 Mar 2025 11:46:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a004026dsm9251122b3a.155.2025.03.03.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:46:48 -0800 (PST)
Date: Tue, 4 Mar 2025 04:46:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250303194647.GC1552306@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XrYxP_pZr6tFU8@debian>

Hello,

[...]
> > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > +{
> > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > +	struct device *dev = pci->dev;
> > +	struct debugfs_info *debugfs;
> > +	struct dentry *dir;
> > +	int ret;
> > +
> > +	/* Create main directory for each platform driver */
> > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > +	dir = debugfs_create_dir(dirname, NULL);
> > +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > +	if (!debugfs)
> > +		return -ENOMEM;
> > +
> > +	debugfs->debug_dir = dir;
> > +	pci->debugfs = debugfs;
> > +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > +	if (ret)
> > +		dev_dbg(dev, "RASDES debugfs init failed\n");
> 
> What will happen if ret != 0? still return 0? 

Given that callers of dwc_pcie_debugfs_init() check for errors,
this probably should correctly bubble up any failure coming from
dwc_pcie_rasdes_debugfs_init().

I made updates to the code directly on the current branch, have a look:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=1ff54f4cbaed9ec6994844967c36cf7ada4cbe5e

Let me know if this is OK with you.

Good catch, thank you!

	Krzysztof


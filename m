Return-Path: <linux-pci+bounces-22788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EBA4CCED
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C4A1895378
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D61F099D;
	Mon,  3 Mar 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUKLuSTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6711CA9;
	Mon,  3 Mar 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035047; cv=none; b=uClUfcaltGVy77w9kzaIDTVrEyqufbhf+A6L33mt6531IeT+/W44Dy1dWmJn7LwOSefvdxpIdB5wCsEhssJsESkUNoGrA4yTVD5dDDIKJYs6yDnqmpxs7R0X6JYqBPTLZ98YAW3SN200hfzi2vBACFa3OKzYQPI/wzuwoBs4ips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035047; c=relaxed/simple;
	bh=RKvL1Q2g46VN5bp/cUMDFTi+QQZE6l5UR/9YqkN1B50=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCgrQzbphZiHBmrUfXqvRyKduJjrZ5oWZ8APeqhrOV+jC6e1FJFF3xFyW7c+JF7gzlvKKVD8oegIES6RuSMaCeuB8oATZRrr1McHPbrhpsK5bauo7PdRsufI1m237iiv+lS0wmqW0RpPhiw6Ks6b7fNimJtykZnVHjcReFbiCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUKLuSTz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso7532274a91.1;
        Mon, 03 Mar 2025 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741035045; x=1741639845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DeBNmmMi2sz0NauGtZCPku7As8wMc8IwVYWILITKobE=;
        b=UUKLuSTzB+yQXVDASBAezzb7Nbxsslxhp2XhuWiT6wIsTVrQ001m3bdVvt0mydJ7m8
         RbMKSINGdWTSE1WhD7Lb6nTQEIs+J62oDTt7skaG14gJaQwF1ucSyZyaJ/dvympJNjI8
         v6vQK9zMmbI2m6w9l3CC4V6p+s6jImVlmqRD2e7UCl1imPe5NfvZlvE8BDTovvfmh7Nw
         Rn/6Rhi42nrLhy+w1UAs14ykxxTX9ACXMwJj8O+N5jZ2XwB5VLoH1AP+CAgussx0wpvZ
         LC+FT9Jo6zpGgT+dQ0nV2n5e5jXuxgqk3PLZDsas8A9Ld0R3Due4lB7nqwwj6sRsTpEh
         sWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741035045; x=1741639845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeBNmmMi2sz0NauGtZCPku7As8wMc8IwVYWILITKobE=;
        b=tRdPB1ScwY4dypDWWu+HWGZqbsrV6LneXA+67Id2Hk9h9+Eq/A3KO7DZyqp64ImZVh
         GnW0uzOEHDI5Fc5AsyI/DsMxNtQjwUFoLqYADLmSovMF0W3RAhUF0GiaoqxHMkS/FIg7
         mwfthfO7TdtjMi4VRUMnm9hlpwl+s4DcCSaRJIOjJzthn/jmPTHIJg7Ke1eIzdj+pJYe
         AFaWHiy5IXSih5oOXYeok9Sbvqe1p4bScOnrD3HII5LvPJUPKQEyR4nHkTqntUlkU7HS
         9p9JMil++9Ds2L/PFygyZ7eB2blzNY2pPN8Wk/nYWsBHLP6JO8ckxwKNPxL0cFqEqWoJ
         jPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0qIFpA7id/mUB52wAesH04IYqI4AmBDtyjIqbZcqdZYCBjfigl9F5U10+oUrjvFu5JpPeXaIP9IkW@vger.kernel.org, AJvYcCVy8WLRN69i5sksGHpk/ER/SZykfrAuCBHNHtg8H0cqTArjt1fAubmMG8bGVMD5pKPPt30NLoqNzAbsdYveoa2XPg==@vger.kernel.org, AJvYcCW1uBRW76YX0erlyb6dEdg4cJ7hrp0aMhuX7l4ZqkRYLZWalFITHu2vV20Scnp79UDLzCmBJcszZxf9BlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHrfd9ypfQKcrdFiXzRK6YnXvHIc/2Twtlfy/nYfSJ9M2Wook
	1/bbQWCTCHiYzjwNLtprZF/QZucs12C3nJ//pWN/yb+AjSw93eoe
X-Gm-Gg: ASbGncs4pJGLhBbVWgJz+UUuW+b56HApoFEvVLO04wesSwIXD+Pn99OW33bobmDwhuB
	D3wFNedaBgokHbnEg/1PnyuQRxGDF7i+cPo5ghXMOUAi33sc/4b+TY0RBdCt023DhvB/dppuawI
	7aLFWgto3EZrcJUzuYimNRZrE9lRvSPQIqoNPLIP4Q8fiEUaWl54W3dFreQhCQA92My4uwimSXQ
	uTmmghDJ7XPOrsFKX6850TLHCFO5uHg0wU0kt72b3zYIcTAsLE6NYT22xSeQnu+7dgO7QAme3+m
	wLYtSxjSrjm8ig6n6MBp5WmvmPKH7dwSTR3d6nEy
X-Google-Smtp-Source: AGHT+IGh1THqn567WjqVqxs2mA94q92PxAVet1ueAXS1LUHZPvR/E7EsrK6tGQWCWBCacVWMkBiPLw==
X-Received: by 2002:a17:90b:2e0f:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2ff33b88525mr982923a91.3.1741035045487;
        Mon, 03 Mar 2025 12:50:45 -0800 (PST)
Received: from debian ([2607:fb90:37e1:4bed:f057:b35a:e3e2:4c5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c603bsm82393025ad.121.2025.03.03.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:50:44 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Mar 2025 12:50:40 -0800
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <Z8YWILtSbQnvVqbF@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303194647.GC1552306@rocinante>

On Tue, Mar 04, 2025 at 04:46:47AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > +{
> > > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > > +	struct device *dev = pci->dev;
> > > +	struct debugfs_info *debugfs;
> > > +	struct dentry *dir;
> > > +	int ret;
> > > +
> > > +	/* Create main directory for each platform driver */
> > > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > +	dir = debugfs_create_dir(dirname, NULL);
> > > +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > +	if (!debugfs)
> > > +		return -ENOMEM;
> > > +
> > > +	debugfs->debug_dir = dir;
> > > +	pci->debugfs = debugfs;
> > > +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > +	if (ret)
> > > +		dev_dbg(dev, "RASDES debugfs init failed\n");
> > 
> > What will happen if ret != 0? still return 0? 
> 
> Given that callers of dwc_pcie_debugfs_init() check for errors,
> this probably should correctly bubble up any failure coming from
> dwc_pcie_rasdes_debugfs_init().
> 
> I made updates to the code directly on the current branch, have a look:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=1ff54f4cbaed9ec6994844967c36cf7ada4cbe5e
> 
> Let me know if this is OK with you.

It looks good to me.

Feel free to add,
Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
> 
> Good catch, thank you!
> 
> 	Krzysztof


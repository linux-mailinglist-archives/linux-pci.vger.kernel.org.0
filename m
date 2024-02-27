Return-Path: <linux-pci+bounces-4080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065A8689BF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B701F21763
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBE54773;
	Tue, 27 Feb 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAvCS9LG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172A53E3F
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018448; cv=none; b=HF8nOlXCV+8O2yeB1ochB3iFpFetMmTxvx8pzVlq/KpyIThAFZeHi81LrV0jVf2WPPb2j/8SiYwVk0W0QocGRwEUdjw4LB3E5p2H1owdQy8/BMoiF32Ic2dCYvn4zD9Dl1pvkJ/HS9lu9zTvQOmp1i2ysmA3n1Z5uzPdLUzWbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018448; c=relaxed/simple;
	bh=jFD+J/7osmXKpIC3TFgHsoSYx1D/6a4Vkb0pR6Tszwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBB+HbDdxJAPP4+APk4DnaCGpPD24kcPH35yzyVNIwpSkFfQjOO1no7Yf0xgwjeTvwI3bRB1WswFl8uC7z3XAuY0HkIRaOhrUQMb9c3GJsU6cLx8AH2weavt1v9La6L5QqtJYhJ4KHrpAHJhX8SxoI+yQ3GyQRo5LmFxswsTPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAvCS9LG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412aec2505dso737195e9.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 23:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709018445; x=1709623245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQ3ECuKh6c0xuGXZyTU0bxO9IeMYLwcYWqGnI4Uk05A=;
        b=XAvCS9LGhcW2MaquASW1wbA753N/w/TTJ3AYPFhinuL0pywxdvngxbRnRdxGwsAF4u
         XT3qzTR/gIEJqkbdeKbxxBtGzLvf2CNJKAlhq8PUHqZ/LF19gToKx9VXnxWLBSvitnGr
         15j+Wb16WDvUbpOHqAfIV+tvvRXCmG2j3y/iqwGb9XAM2M3J0ss7vq2+QGMDggsaF3vC
         puVdCDWcaVyNGC2TAuazFnuuqX+WWQp15M6XiaDsUJL3xqbADxzZxNX84A37JDVZsNnF
         Z7GEs/jgA4QG0mFm82kgbdo/1i3GeOESiboF280PJEFW1UVyymYn/QxVsqZQUXxab77R
         I3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018445; x=1709623245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ3ECuKh6c0xuGXZyTU0bxO9IeMYLwcYWqGnI4Uk05A=;
        b=F2SqW+nCpbymjhVqKrbblPa7+SjBqU1HqTx1A5LT1X/tDtIgyaSMd8lVF5+Ub00F24
         Pan4ZG0rIToYsdAVaF75uzBsKrn4Veq9YtWhFHmHgFr9HxClUM0prgP+d8UM4aFHtlMc
         SERXMhCQRI6UJ+qIJufCvMvY+OZfEqejbcrQkHPKRA3nN2IvFAMxdCWbKtmuo96z+yra
         tCZr0Z7mvpbwEQ03vi0R2TG3yG60b9xiB+ygwWadYStNsSFNmakx6aCIN0dfj2K+3UR7
         qDXnUuih6bcv6ukO65qpasypBM390ZM5yf1Dcl5uLzmb+0E4IdUXi4tRlWBL6MERIRp7
         fbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhihtk0h3VZF6wrsqju3LieYx83o0ob1adoy35OgSGjKqwUpXMXJbuKxzi04tOzYixIRNH4ynlYKWjhDTeL/wLors//mIk03fh
X-Gm-Message-State: AOJu0YxhdNf7+unb4LDJhO2wTvOzLrbB5n6cxXUTi7udzSZMWghGpsr9
	Tt9NyMadJPkjPtqHmW47G9LD5pgWmFBux/GXkjZpqxtMSnusdAfwSBgMRbRjf00=
X-Google-Smtp-Source: AGHT+IHWVqCWPI3YRRb5LVqqw39FJgrixLKzi0fw2aCaLcXTvO6Rm/mEex9bYq+qCnKGaU8HCoOVdw==
X-Received: by 2002:a05:600c:3154:b0:410:8071:6931 with SMTP id h20-20020a05600c315400b0041080716931mr6781548wmo.20.1709018445251;
        Mon, 26 Feb 2024 23:20:45 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g10-20020adfd1ea000000b0033d282c7537sm10772977wrd.23.2024.02.26.23.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:20:44 -0800 (PST)
Date: Tue, 27 Feb 2024 07:54:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <8a220db4-a784-4dbf-9c6d-dcb4b47c0083@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
 <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
 <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
 <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
 <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>
 <f779be97-66c2-4520-91f2-a9a54e84017c@moroto.mountain>
 <623ce65f-da43-4493-8a21-4fd6dfe86dbb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <623ce65f-da43-4493-8a21-4fd6dfe86dbb@linux.intel.com>

On Tue, Feb 27, 2024 at 04:00:33AM +0800, Ethan Zhao wrote:
> > +                       if (!dev || !dev_is_pci(dev))
> > +                               return -ETIMEDOUT;
> > +                       pdev = to_pci_dev(dev);
> > +                       if (!pci_device_is_present(pdev) &&
> > +                               ite_sid == pci_dev_id(pci_physfn(pdev)))
> >                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Unless the device_rbtree_find() is returning garbage then these things
> > must be true.
> > 
> > +                               return -ETIMEDOUT;
> > 
> > I tried to double check how we were storing devices into the rbtree,
> > but then I discovered that the device_rbtree_find() doesn't exist in
> > linux-next and this patch breaks the build.
> > 
> > This is very frustrating thing.  But let's say a buggy BIOS could mess
> > up the rbtree.  In that situation, we would still want to change the &&
> > to an ||.  If the divice is not present and^W or the rbtree is corrupted
> 
> Maybe you meant
> +                       if (!pci_device_is_present(pdev) ||
> +                               ite_sid != pci_dev_id(pci_physfn(pdev)))

Yep, that's what I was asking.

> 
> Unfortunately, the ite_sid we got from the "Invalidation Queue Error Record Register" is the *PCI Requester-id* of faulty device, that could be different
> BDF as the sid in the ATS invalidation request for devices:
> 
> 1. behind the PCIe to PCI bridges.
> 2. behindConventional PCI Bridges  3.PCI Express* Devices Using Phantom
> Functions  4.Intel® Scalable I/O Virtualization Capable Devices  (e.g. ADI)
> 5. devices with ARI function.
> 6. behind root port without ACS enabled.
> ... ...

Fair enough...  Thanks.

regards,
dan carpenter



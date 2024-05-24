Return-Path: <linux-pci+bounces-7816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B28CE773
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E1DB20D88
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0C12C80F;
	Fri, 24 May 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfCiYQHx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43912C7F8
	for <linux-pci@vger.kernel.org>; Fri, 24 May 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562759; cv=none; b=e2S5RAltxvu34PkkexEdtoVA5sGWWYypBlwhQPCP5IKfzauENrkgCPfrcD4i3h+3Sxyd5RgpQdBZPOIvfDHDAAyJ/JPnkZ6JyioM5zM2z3+hQd0C8z3ANyCU/zZukfCnYFebDdCumXZ9bwmt8SkGute3M3KXnCzYojyoz+Bx2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562759; c=relaxed/simple;
	bh=EtDbG/mTVNJyR2zS1qaWqcywYi1onHVXARebeJcxOWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SScLi5Dh3W1JEv1RyMUG6qNKGV9Xul8vTkfclePyPcwKqssQXGf/p2hrnFLazZkDgJGNrR6X8O1WdM1v3mMbx7WCKKQocf5l9BBXIesGao49e50PITzs+W86cyoGNU1YOT0VsIIY9K4qbH/GDb1jLlvG67R9Yo23QPIJgXkQk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfCiYQHx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so32766645e9.3
        for <linux-pci@vger.kernel.org>; Fri, 24 May 2024 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716562756; x=1717167556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk85nCqz8hNY7JRWhz/zThepuy6o3cVjI0xiL1VXLX0=;
        b=JfCiYQHxWpVMHcp2E9u2Of6WkQRbn2754vi6lwTMgmxhdKTlDNeXMw6EKUEbZG0eBd
         1ZfMMUEK7CVmCjSm2G1eZMg1LACTA/v7V9WnzY8Ts8K8ep5bE0gdAkrHwaHtUW+quK2c
         iTYZeQ3NxHC7Dg606jqVe+AeE5IpsXQK3C2m24L5GUj7eWPX2ffqD4XEkI03LU4TPJ6E
         7Q7mLxJETqaVix0gsffsYlL+r8dvvHugHMscnDafIqIIcTVkp9QwGeVAUde29Br1T7dY
         fg2k03YHdTYk1gGaAXbmnqW9tbpMl2hV+YNb0PUUapollPfikXolu+MF155k2wel66iz
         HFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562756; x=1717167556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk85nCqz8hNY7JRWhz/zThepuy6o3cVjI0xiL1VXLX0=;
        b=KMyADIZNhbJHC2oYce73J+YPAk48UrrMM9jZ+WVB4frYuX2okcR2C5XqhBkVMSFEst
         anlt7lTKQ+P+pZcXE2zRiaZ9RiYjtXQMMVHZJBrh0FlOqLWIP3Up5SMTt2ufdNIbllJ1
         PLaKPntEfmw3w1uSD/lZQirCxQX0za15ZpAk/6D26e5tFWAb7MzmA9eitE1ik6x3vq6T
         mrDxQXzeUgvCgqVyy1sdGLlxF5Qo6N+jHIXcJxyOCMAhAjKsG10VaSjjobLc+Pfc9RAB
         JaQ2S3sHuNLGNdCUdaw1iPrBUg3yC9ciUSjedMHMM487n1BRCPW3G45vT9RiuzXWmLAb
         vW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjG0qg8UqDT/gFaHK04kaoFcwrH+Rj44NisP0P0eMTEBZUiVMvP+p5m0Orl6Xy3DVOTcULHISKMk6DsXOryMkY1YAKbEq2u/Pv
X-Gm-Message-State: AOJu0YwIeAbHx+Wo6XGXLLPyFC8xddNxM6QYALbRhs9dfOOauS1YMi5O
	9Ef2XdSenBhsTCya8zubIRyw+KnB9Rnw6uKDxX2iqfPaciLL2KbnuIorPnKpNJw=
X-Google-Smtp-Source: AGHT+IFq0bCDgKuc4UiHOXzKfU6n5S35HgNDJ778we7FOdrAWRUa/2kR7n0rOXH7nejXsAceU6xa9Q==
X-Received: by 2002:a05:600c:68c3:b0:420:ef93:cd2f with SMTP id 5b1f17b1804b1-42108a79cdfmr16925355e9.21.1716562756144;
        Fri, 24 May 2024 07:59:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970b4esm22917645e9.14.2024.05.24.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:59:15 -0700 (PDT)
Date: Fri, 24 May 2024 17:59:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] PCI: xilinx-nwl: Add phy support
Message-ID: <41d89132-f6bb-4feb-af1d-412206a85afa@moroto.mountain>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
 <20240520145402.2526481-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520145402.2526481-7-sean.anderson@linux.dev>

On Mon, May 20, 2024 at 10:54:01AM -0400, Sean Anderson wrote:
> +static int nwl_pcie_phy_enable(struct nwl_pcie *pcie)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret)
> +			goto err;
> +
> +		ret = phy_power_on(pcie->phy[i]);
> +		if (ret) {
> +			WARN_ON(phy_exit(pcie->phy[i]));
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (--i) {

This doesn't work.  If we fail on the first iteration, then it will
lead to an array underflow.  It should be while (--i >= 0) or
while (i--).  I prefer the first, but the second format works for people
who use unsigned iterators.

> +		WARN_ON(phy_power_off(pcie->phy[i]));
> +		WARN_ON(phy_exit(pcie->phy[i]));
> +	}
> +
> +	return ret;
> +}

regards,
dan carpenter



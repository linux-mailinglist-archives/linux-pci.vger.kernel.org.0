Return-Path: <linux-pci+bounces-28693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443BAC86EC
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D34DA215E4
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF30194C96;
	Fri, 30 May 2025 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOqcLmnd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7119004A
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574794; cv=none; b=XBvTeQExVSanHUXenHh4qOLtMIETxNfsYfBeG4XiA5Kkdpl8yU/+yIhQN6yKG1uMxlXDMIkE6okPho/BsTh0foRx4Yb/WbChp4IJ5YMhzA6K+0NMY8/mru2I+ZA7rJDyGSiQfojqQuSHQXOhaPNwfr90l1mj2xxRmrUadTOFKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574794; c=relaxed/simple;
	bh=wjaoZAmbH6sgCZnO1eKlzeSIJW3PNHdGlp3qm3MddRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxv9IIB10rNdxbKSCVAapvcp3jpo+RN46GHAOIFn1NhFr1eekBjoKgI7k27UqK9w4L9kJMOq2seg1MMITZ6TartNCqrV6dbVfbnbSuslIKlDYyKqrOaD3Zw8RdRudMS+/4T95rn7k0vH43/dzV6y/nLOPkKK7iPocDWxQLhlRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOqcLmnd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2353a2bc210so871305ad.2
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748574792; x=1749179592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N+DPZC1n47L/JnKL6zmQew4sn71lUGxtinjfwrD9vf0=;
        b=WOqcLmndAkAcFugUJ5fzo13csOo72Lkf5bVisG8Q0/FBaUJhe6skj5vf/B/G+44eWl
         TLslrRUaxxw7E3S27M6OYlHfd0RTU2V4gtfQFtOafMWbSlsqtDiNl4cE1wdGPnIyf3e/
         qLH9ScgtzEnAl07i+m89rIRU5heDvWtWV//2WaM4igi+aY6UE0OOXle5p95ldGDUzZOc
         fkSCBJrmGjbql22PiEWUehU+Sb+vgQOTHpYqFJfrWUxUOeJIWEYstSZ4kvFqYO4zk1gq
         kSXA4kj0PR0ll4qVo016WHvxNb505XTXZaNrq/tWOwGhVObNlbaLoTDZTeoLmYd25IGj
         YO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574792; x=1749179592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+DPZC1n47L/JnKL6zmQew4sn71lUGxtinjfwrD9vf0=;
        b=TRiPM0qv1mgw3xDImxSLhL0i7PEyCTuXyOYJG37lFZh/D0ArnnKQHIhyxl+yB+lOBW
         BR+DqtkRM84LrOUwEfoswgp+E5Wl/KaRNvjVpSnY169rZCKuxZavozvd8y3FmHPTsyKA
         CpxdFFTYo0KEHcZdXqlkxfMnNwcuoBio19zfH8eNRoPQtPn1TCWsfUn/lZjt3IEleiHM
         Ir5JR6ENHHd+Pizu0j1SyAYG1juW7Agou3kEWy4DykGG2ptPhRPUM5XV2OnDpyCig7os
         HYlxEliSJZWUIeM5XBorsWBfKBj0GaYUF8ucmbeosxRjuC7rCr+nBS0RqGh3ursEZWuA
         DI3w==
X-Forwarded-Encrypted: i=1; AJvYcCUiK+qLjhdMPsMXkJ438MoGSTNMo4YY7DeDDIXIRIdc4tNj5aULc5pfErkMS4SqM/WMbFlkpqUJxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy010sWz/OMTU9fxmwYKTbPci8pi1RCqI7E2Ax9tXEf+8pEWJXQ
	n90fbSvMdWFMNWq780MQrDJNjteb9MNQscqtbT6OoM2ZOKYiqE1D3if+KJciEIzRqA==
X-Gm-Gg: ASbGncsE0+tud2tVUVJcLXHrLZQSZ4vDWv2yxfu1gyldeLuZzqCqeM045zZuLr7/jmj
	+FEj2YCQ+2hJIbCOTjV+8eLPu6iLxvCvC+Y96ctb5x2qFD1UGUbgMz3qM/OIX36trKzpJOexm4Z
	ezCUjIinsrM59U+oI3toAPmhmeNfpKra4eF/WWVcnFWxcJ0sW2zIMwtgBsnCkhiId1KBLQGu55Y
	Ug13oM2HPmSQ7CIRkcBhMNG78qjtIaHo7wcrA2oRCMRDdrToFwLR5jtYX06y1aaap7vZIo63mCS
	hzvBcXI0tFAmwMHTokVGMq8Js6yKMQ+KwYo1cCYY57imKSaIhUZRwKc7ky/W0w==
X-Google-Smtp-Source: AGHT+IHV4IkY0i9cUrY7xh6Q0CSYoJYenoRdU0u9vfUOZ6yaj5pqiEraof9TCcZDB0o6anzhNBG2Pw==
X-Received: by 2002:a17:902:da47:b0:235:7c6:ebbf with SMTP id d9443c01a7336-235396b7f6amr8116355ad.35.1748574791920;
        Thu, 29 May 2025 20:13:11 -0700 (PDT)
Received: from thinkpad ([120.60.139.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd89e4sm19118435ad.54.2025.05.29.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:13:11 -0700 (PDT)
Date: Fri, 30 May 2025 08:43:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Cyril Brulebois <kibi@debian.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof Wilczy??ski <kwilczynski@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jim Quinlan <james.quinlan@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <txhlqciq5zd4uilon3cnt7ao6as3llle3oachgudzfj5bka577@6mteq4zsvj34>
References: <nt2e4gqhefkqqhce62chepz7atytai2anymrn6ce47vcgubwsq@a6baualpdmty>
 <20250527222522.GA12969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527222522.GA12969@bhelgaas>

On Tue, May 27, 2025 at 05:25:22PM -0500, Bjorn Helgaas wrote:
> On Sat, May 24, 2025 at 02:21:04PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, May 24, 2025 at 08:29:46AM +0200, Lukas Wunner wrote:
> > > On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
> > > > What I would prefer is something like the first paragraph in that
> > > > section: the #ifdef in a header file that declares the function and
> > > > defines a no-op stub, with the implementation in some pwrctrl file.
> > > 
> > > pci_pwrctrl_create_device() is static, but it is possible to #ifdef
> > > the whole function in the .c file and provide the stub in an #else
> > > branch.  That's easier to follow than #ifdef'ing portions of the
> > > function.
> > > 
> > 
> > +1
> 
> I dropped the ball here and didn't get any fix for this in v6.15.
> 

That's unfortunate. Let's try to get it backported through stable list.

> Why do we need pci_pwrctrl_create_device() in drivers/pci/probe.c?
> The obvious thing would have been to put the implementation in
> drivers/pci/pwrctrl with a stub in drivers/pci/pci.h, so I assume
> there's some reason we can't do that?

I assumed initially that pwrctrl dependency would always be there with PCI core.
Since now it is clear that we need to build the function conditionally, we could
move it to drivers/pci/pwrctrl/core.c with stub in drivers/pci/pci.h.

I will submit a patch for that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


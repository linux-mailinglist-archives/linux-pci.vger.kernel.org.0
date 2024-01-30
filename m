Return-Path: <linux-pci+bounces-2824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0FB842BE2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727A71F2136A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B378B4F;
	Tue, 30 Jan 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UphBbX9f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6A78B46
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639795; cv=none; b=T9cUMKcjgHUB4oqqFvDmeAa/07fL2DY8O+d6JK0igHhBp6EXqa/woOUpIJQipbhnMKjkaYMvQV4ly1j3h/XLcCFtEWUNZyWVdSVuUKn1gboAqcQ6ONUM5K1se6haSDPKZeop/TFqDwhgNKoWVGdI99Ksf70GFLcARvCOxjGvJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639795; c=relaxed/simple;
	bh=ikwwqNyc6jFd2II17OfRBnwrHMd8IINbASWuUS4Ug44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDSJ0jWIcjHqiRBMcuADiAkVHFYU7cxJxOccxNckw+LqHlJThL8S/FSN2ucR5FORIFN9oNEviIYM3TLyzEPec2bvvNkmhicXyHIKvppt8XJa2KdpjrOJ41jM6b7hhXY3TjIt2D4hMweIACo+Ty/R2Actyo66BT2VJGixevjDxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UphBbX9f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-295d56c4871so75135a91.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706639793; x=1707244593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vgNv0GUPFWxdfW4TQ+hGQyRUvV2dvHLPxpXYdqFryBE=;
        b=UphBbX9fdOI6BgQLPfZt1Fp310NNHcBlOcZLvogx6jfnVAkKjq9kO+5SucZN5ZOrtS
         1A9BAgjkwt/l++z14mfvV7S/15Y79A3GFqGzc9y6NuB+1utzoFa74i4SFQgnoKlSisLn
         /xhbX1CC3nPSpe+0fyz3Myuse/96AO1sREpfFx6w47rKEGXHn3wzmC3XWWwQVGj5oBHL
         i5aZZhM6G7+ezc/LuB+LFbRuiYOqXfuar3gUJ2rt072c29ITtiYIntMTl6ioT2RcGdXh
         9klrx2gxutYdbuFgKVUrF7T6gBFwdoN7cgKF88gGMbR/BUrCMBt9c8gPNXjCU0VMCrDB
         w3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639793; x=1707244593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgNv0GUPFWxdfW4TQ+hGQyRUvV2dvHLPxpXYdqFryBE=;
        b=wG9IQ/aBDQ9qSR5NdrhKwkC+xm7tRHg3AzmHFdF3M5rV5ijU685Waz3PExpBAvnOQ4
         9jPbxEcHeFyUfpouF6JZjNB/UdVFBsbXgL7ZsGDh4Clj1qFHH3Agyhwaj2mwMCu+DwAI
         FF3QaOOMywXp3UQB72/elDDm8eM3qEtKZa1SByo6FsGxBjW3tiBlj4mBQyitTkROtNwp
         wzFimJbjoh4Ol4VUuFiQKC1lzVy+5pq0shA/9bwV93FMOJZ9/sy+2+UP6mXQiQ7etx6a
         BCeoeHL7LoYFSBCqApOoOhRtQJjj+5afjJG/0r8KT2MBqJtRA9z3dbi3Gp/lAMEwClFK
         pjVg==
X-Gm-Message-State: AOJu0YyKHR0T34sjHTn3kRhWXkAFRuX8EjYUCwKO2AitQ/Nz9phHCPKP
	lbr2GWciIIBqmIp2sg4w7wGdS3HrVL9WTkmZ8fxHhe+DPibxaOT8DW9OtTovOg==
X-Google-Smtp-Source: AGHT+IGq6ucnvVNgc2u60zUK0WDJ2P8/HWXvMXVc+LI3CfgeVdOfvu3uzyW0eLpHYqXEsOqdXuKrag==
X-Received: by 2002:a17:90a:a393:b0:294:7bf1:3cb7 with SMTP id x19-20020a17090aa39300b002947bf13cb7mr4820162pjp.14.1706639792781;
        Tue, 30 Jan 2024 10:36:32 -0800 (PST)
Received: from thinkpad ([103.28.246.123])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001d50ca466e5sm7405864plb.133.2024.01.30.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:36:32 -0800 (PST)
Date: Wed, 31 Jan 2024 00:06:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240130183626.GE4218@thinkpad>
References: <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbkvg92pb-bqEwy2@google.com>

On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > 
> > [...]
> > 
> > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > 
> > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > 
> > > > > > 
> > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > experience.
> > > > > > 
> > > > > > If there are any other usecases, please state them.
> > > > > > 
> > > > > > - Mani
> > > > > >
> > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > being enumerated need to go through an appropriate and device specific
> > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > hence the link-up is not attempted.
> > > > 
> > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > I am not adding any logic/condition around calling the start_link()
> > > itself. I am only avoiding the wait for the link to be up if the
> > > controller driver has not defined start_link().
> > > 
> > 
> > I'm saying that not defining the start_link() callback itself is wrong.
> > 
> Whether the start_link() should be defined or not, is a different
> design discussion. We currently have 2 drivers in upstream (intel-gw and
> dw-plat) which do not have start_link() defined. Waiting for the link to
> come up for the platforms using those drivers is not a good idea. And
> that is what we are trying to avoid.
> 

NO. The sole intention of this patch is to fix the delay observed with _your_
out-of-tree controller driver as you explicitly said before. Impact for the
existing 2 drivers are just a side effect.

> > > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > > negligible. The reason why I'm against not calling start_link() is due to below
> > > > reasons:
> > > > 
> > > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > > that powers up the endpoints during boot, then it creates a dependency with
> > > > userspace to always start the link even though the devices were available.
> > > > That's why we should never fix the behavior of the controller drivers based on a
> > > > single platform.
> > > I wonder how the behavior is changing with this patch. Do you have an
> > > example of a platform which does not have start_link() defined but would
> > > like to still wait for a second for the link to come up?
> > > 
> > 
> > Did you went through my reply completely? I mentioned that the 1s delay would be
> > gone if you add the async flag to your driver and you are ignoring that.
> > 
> Yes, I did go through your suggestion of async probe and that might
> solve my problem of the 1 sec delay. But I would like to fix the problem
> at the core.
> 

There is no problem at the core. The problem is with some controller drivers.
Please do not try to fix a problem which is not there. There are no _special_
reasons for those 2 drivers to not define start_link() callback. I'm trying to
point you in the right path, but you are always chosing the other one.

> > But again, I'm saying that not defining start_link() itself is wrong and I've
> > already mentioned the reasons.
> > 
> > > For example, consider the intel-gw driver. The 1 sec wait time in its
> > > probe path is also a waste because it explicitly starts link training
> > > later in time.
> > > 
> > 
> > I previously mentioned that the intel-gw needs fixing since there is no point in
> > starting the link and waiting for it to come up in its probe() if the DWC core
> > is already doing that.
> > 
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> I think we are at a dead-end in terms of agreeing to a policy. I would
> like the maintainers to pitch in here with their views.

I'm the maintainer of the DWC drivers that you are proposing the patch for. If
you happen to spin future revision of this series, please carry:

Nacked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்


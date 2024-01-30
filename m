Return-Path: <linux-pci+bounces-2816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E8842AAA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1129288680
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C7128388;
	Tue, 30 Jan 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bWOBLVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122412839E
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635151; cv=none; b=GYDElDk9g69hsy6wEL/6nMPkJ/miGM7f+JAH2ZFmBBhYqThbWj17vjD9CN86WRZ+moA2cBQfwwzuleXxhWhmL54+42d8MKJaN/9VS8F4Yn16x73Ssve/cAwKUT0+tEVdSCIqlXQA6Q7UpD4QvrXWF9WIhOWvA4eyZ3dtgPO5Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635151; c=relaxed/simple;
	bh=fBrb9YzehSuOUvimfhwFZF0wJGUNEqzPlZebMJ+rFdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXrtE0Wu3djMMLBFPorKQNwViuO5jvrhEj0yE/kyZLab+jYeBepkBHO3EioWbOj3GepEBDB1rohUV0pjHUMcBNSSg0UAZQMwpWAuLcS0LESsMRI5DiY4GuPDadlHUQV2nXV45Bpx/2YDbcgYITZuzb79CSvv5kapd+LvhEtoVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bWOBLVC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d72f71f222so22368815ad.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706635149; x=1707239949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZUO/BpmoQun+0IwPUerCb59g8xWDXYHRV4sWE/JnR5I=;
        b=2bWOBLVCS8ULbsfjM6fv6QDGu1OUuJbLqrkEgNvri8HHDhz4bWOhHg2Gof6T9k4Xg5
         OuM6TrLrSqvpypKmvixKQMV//LBwp+6JmPwTBia9OxMVT+qq1re3sPX5V3H+m8spOed5
         bmXmFkLicgHT1iQJcsSiGh99nLQq/R/Y0hdKNuNiIL8a+IdlQv1+KTXRjSpfa/ZIJbL1
         Dg+ubbIhNMHnxNB3l070sdcQWTdUHIxzXNFkD+nu4ARc/NxObW160UDF8Yzth8I7BLxN
         X318nfcCAHQZTd55hzWm9IKq/0xbD48t1fdZqbEY3RbfoxiZk/FZe60+tWmoZeK6vqzm
         uymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635149; x=1707239949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUO/BpmoQun+0IwPUerCb59g8xWDXYHRV4sWE/JnR5I=;
        b=ejQ5kCDScKCcAJpjP9YmAlPWvD6AQsEIinEzflNoxf4u8myqtt5pQUy1XZumU/vUKZ
         rd4sz4LlQnvSrSJ7d1YAbP7CYOxaupSBrIp+CSLitfCfgrWvncr2LzsOa8mqoOpOkod3
         JC/AtMx2M0L4En4xqMbqypMHtuq+52HveClHa5QHBD+R/3xi6mvf9p7wcsej6DeCJ2Lp
         J7rQ0PlM7HOy89s3GHKsyXeu5UD3ADgbnOpN4FLwZdXJr48Ao5kqI+Dz6I1VCjoJJ2GO
         NOOrisSfvtnNkFUyMkAwznZPBp1MGyTuqDfatz44EAsXoPqpCLrgLv+ha9XLU7kV3Wq2
         VrIw==
X-Gm-Message-State: AOJu0Yxa5SWsejqYR3Db5wbytrmhosXfaOw/C4YXcs5ckNpNx4/0fTZJ
	I586osy3oFqSo7hVRa9Xh1w3BsE4S282QQ+Lx9xH0CWAtBFOblTa59Rha9JsLg==
X-Google-Smtp-Source: AGHT+IHaX6G2CfzPjoncISH7AtuQt5nlvGmc4prYW5XXM5hCEihuna62wBHHBVZk13w40WkSTUzgxg==
X-Received: by 2002:a17:902:c3d1:b0:1d8:ef9d:7ced with SMTP id j17-20020a170902c3d100b001d8ef9d7cedmr3814492plj.26.1706635148721;
        Tue, 30 Jan 2024 09:19:08 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id g17-20020a170902c99100b001d8f6ae51aasm2906319plc.64.2024.01.30.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:19:08 -0800 (PST)
Date: Tue, 30 Jan 2024 22:48:59 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Zbkvg92pb-bqEwy2@google.com>
References: <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130122906.GE83288@thinkpad>

On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> 
> [...]
> 
> > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > 
> > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > 
> > > > > 
> > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > experience.
> > > > > 
> > > > > If there are any other usecases, please state them.
> > > > > 
> > > > > - Mani
> > > > >
> > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > being enumerated need to go through an appropriate and device specific
> > > > power sequence which gets triggered only when the userspace is up. The
> > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > hence the link-up is not attempted.
> > > 
> > > Still, I do not see the necessity to not call start_link() during probe. If you
> > I am not adding any logic/condition around calling the start_link()
> > itself. I am only avoiding the wait for the link to be up if the
> > controller driver has not defined start_link().
> > 
> 
> I'm saying that not defining the start_link() callback itself is wrong.
> 
Whether the start_link() should be defined or not, is a different
design discussion. We currently have 2 drivers in upstream (intel-gw and
dw-plat) which do not have start_link() defined. Waiting for the link to
come up for the platforms using those drivers is not a good idea. And
that is what we are trying to avoid.

> > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > negligible. The reason why I'm against not calling start_link() is due to below
> > > reasons:
> > > 
> > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > that powers up the endpoints during boot, then it creates a dependency with
> > > userspace to always start the link even though the devices were available.
> > > That's why we should never fix the behavior of the controller drivers based on a
> > > single platform.
> > I wonder how the behavior is changing with this patch. Do you have an
> > example of a platform which does not have start_link() defined but would
> > like to still wait for a second for the link to come up?
> > 
> 
> Did you went through my reply completely? I mentioned that the 1s delay would be
> gone if you add the async flag to your driver and you are ignoring that.
> 
Yes, I did go through your suggestion of async probe and that might
solve my problem of the 1 sec delay. But I would like to fix the problem
at the core.

> But again, I'm saying that not defining start_link() itself is wrong and I've
> already mentioned the reasons.
> 
> > For example, consider the intel-gw driver. The 1 sec wait time in its
> > probe path is also a waste because it explicitly starts link training
> > later in time.
> > 
> 
> I previously mentioned that the intel-gw needs fixing since there is no point in
> starting the link and waiting for it to come up in its probe() if the DWC core
> is already doing that.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
I think we are at a dead-end in terms of agreeing to a policy. I would
like the maintainers to pitch in here with their views.


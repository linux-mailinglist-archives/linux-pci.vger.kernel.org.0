Return-Path: <linux-pci+bounces-2803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D88424EF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 13:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6AF2813BC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FF67E90;
	Tue, 30 Jan 2024 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQKfdz5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87E67E66
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617756; cv=none; b=A8ybsfAl7I1x8zwRNnOh0rE1bUMCj7jTnJKhaJtWbsvJusIM10rCM2ntXXoufubXRtRtSAIxynDSvw3i5mndO2r/KDTkKX9IqmIrFSZKKLjb5qO0Zx5JEo3sOaIP4PIS3U8191m0UoxuLEgERPIpdU8V6mjrFu+kSJdftBqKPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617756; c=relaxed/simple;
	bh=WYV79eqs8EX6+PoVYLFkIJPG5P9GerzOH+CSQWG7gJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVyZ5POCg/W970/m0HZrNrWsnr1D4soq+7gS8g7zbOonHPbn0eV+fW0dF/mQ2grQCeLOlFswQtBWOfTDF+K3m2s4vhRFPHV3a/DKRLn6Brh8bOvfvNxPysm0/TqFn5llFVHyKtpmDoP6OS50fkUK9luCL4mahswEfb9pGcqMsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dQKfdz5t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de2e24ea87so1213309b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 04:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706617754; x=1707222554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7FzOKAxGetGKZLcjTXfQ+63UEVvuNkv8U7bj2gyECQ=;
        b=dQKfdz5tZSp6GsqkgAe0da55D79pAxEs4szIKeYXy8wjQLOOinLouFLwqnASLOXVmZ
         gcB3Qzoivnzu+9tq/OJxQ5p8fAdjtYA0n5JaMVB4i9IwQt1HHyc9COljhuAU1aaR/573
         o5K6QraQbO+SDHYfdGphDZodFUJkAjlgPdGX0YKmjuGtNuCt9yFdvuFpbjGIRWE5wR1E
         DJgr1TWsG4ubhQW5jjP1ps41UWO51dXDrgDxNESQPF8542W5+j0o1Si04qdRLoLyKAo4
         c9xlV60NWrZzXYZzj7xQQ6PWfWnvM0XJ0iycpU7RHih+UTxpyrLe5FNDdkarJNU+IUwr
         2Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617754; x=1707222554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7FzOKAxGetGKZLcjTXfQ+63UEVvuNkv8U7bj2gyECQ=;
        b=bfG+cpzm7VGrtyGG2ZtC8yVYTqQFfGHh/Xz4zGkDfInScHCGjlDjSJxZITwaKqk9a2
         lBhsB06a4IVZTo0L0EvQCV3a4Llp1fR6xU2zE4lHgIIzjaPHGbY05So2trULeTpTmenD
         t8xzu5k049Xp/l5DRilBQILc8FfKonVQss22AFKUeAjq531E7CvmccwgvYjsfnnLejK/
         W6rZOg4N89g1okHlzWlP1vDJQ2zPqti2OYZlU/2n1Pkmqec30QLmX1lFmOus9+eLLZXc
         gluBXMKPDAziUogJWqor9HF5misOy+HRiSYUkafvr6sAqHn+GqzgyB1ksK7CzFl0GfUZ
         MOxg==
X-Gm-Message-State: AOJu0YzWkNpW67238G7nUWogtKMm9biF/cNkhp+S2OOmrozqIRFawJj/
	Ao/GjSxgpgtREWlirMx6p5VY+ibaV5GZ2xnRyoi8wq5Ye5YyVHVRFHR7J6PBgw==
X-Google-Smtp-Source: AGHT+IG81ShMSjJPHN/JsXSWiwEv+/heJXnfbxvVirzY+ZlLtNxTyNJD9lf6Eijrugmb6PklWmMTZw==
X-Received: by 2002:a17:903:186:b0:1d9:11c8:b3c8 with SMTP id z6-20020a170903018600b001d911c8b3c8mr736072plg.64.1706617754147;
        Tue, 30 Jan 2024 04:29:14 -0800 (PST)
Received: from thinkpad ([117.202.188.6])
        by smtp.gmail.com with ESMTPSA id ka7-20020a170903334700b001d7252fef6bsm7101666plb.299.2024.01.30.04.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:29:13 -0800 (PST)
Date: Tue, 30 Jan 2024 17:59:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240130122906.GE83288@thinkpad>
References: <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbi6q1aigV35yy9b@google.com>

On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:

[...]

> > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > 
> > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > 
> > > > 
> > > > Why does it happen as such? What's the problem in starting the link during
> > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > experience.
> > > > 
> > > > If there are any other usecases, please state them.
> > > > 
> > > > - Mani
> > > >
> > > This SoC is targeted for an android phone usecase and the endpoints
> > > being enumerated need to go through an appropriate and device specific
> > > power sequence which gets triggered only when the userspace is up. The
> > > PCIe probe cannot assume that the EPs have been powered up already and
> > > hence the link-up is not attempted.
> > 
> > Still, I do not see the necessity to not call start_link() during probe. If you
> I am not adding any logic/condition around calling the start_link()
> itself. I am only avoiding the wait for the link to be up if the
> controller driver has not defined start_link().
> 

I'm saying that not defining the start_link() callback itself is wrong.

> > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > negligible. The reason why I'm against not calling start_link() is due to below
> > reasons:
> > 
> > 1. If the same SoC gets reused for other platforms, even other android phones
> > that powers up the endpoints during boot, then it creates a dependency with
> > userspace to always start the link even though the devices were available.
> > That's why we should never fix the behavior of the controller drivers based on a
> > single platform.
> I wonder how the behavior is changing with this patch. Do you have an
> example of a platform which does not have start_link() defined but would
> like to still wait for a second for the link to come up?
> 

Did you went through my reply completely? I mentioned that the 1s delay would be
gone if you add the async flag to your driver and you are ignoring that.

But again, I'm saying that not defining start_link() itself is wrong and I've
already mentioned the reasons.

> For example, consider the intel-gw driver. The 1 sec wait time in its
> probe path is also a waste because it explicitly starts link training
> later in time.
> 

I previously mentioned that the intel-gw needs fixing since there is no point in
starting the link and waiting for it to come up in its probe() if the DWC core
is already doing that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


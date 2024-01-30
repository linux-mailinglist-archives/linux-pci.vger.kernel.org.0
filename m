Return-Path: <linux-pci+bounces-2764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB7841C1B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CA31F213E0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FB39FC1;
	Tue, 30 Jan 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytLKj3DB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B951C42
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597170; cv=none; b=q2DgPw203msaGsms9Rx8GSveQixXpOoZx2tCRNYM0x+eebq5wzrVekPsG72EjFgVaJbHe6HjcEbTrVoZKEZAxh/41SfC58vRehi9AFKLn4AgX0tyzrPafWGRp8ksDArv5zRPsM/jaUS06NsiEdz2WmWRzZlFibGWJSGaJywGlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597170; c=relaxed/simple;
	bh=lodBYHWH/ZlMkx1bB7PcbiPOMptlG1O8ndoFQS+9bUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERronJ6/esUDElMhfUvqZ4fMTlSvcmsREV9pHlwcJSYYLnKV+EzjGFYJIqR8AT9kHIAb3WKjN7FSUQlpzZ3nAZVAj8eLr24HYbpzaPpyS7v/2lkr9/TzuxPmaHMbNUUxXhNhNkZdGFQMGY5+JShAxMukNJJeL0uxoKGH9UxpbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytLKj3DB; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be61772d9aso662163b6e.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706597163; x=1707201963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KvrXResZGE4/DvhzRWh+okVrzmaN0fxYjAblKrbqDHM=;
        b=ytLKj3DBwovAcN5MtuJ4zJ/+Q+9Zl/t06c0cF9lfMCZUs+diL/vDczAOjwVFgN8rhJ
         s+/by3SkaYW6jWgLVa1T0rFe1YIGay1k8AfWFmFGBIPL7nPmPjHOvtX49CllDNmK46zT
         MhRYyVdO9ZyDodFEwwn58dPch6x/A322Bs9w9EzNIj2bQkLhvuFv1f/xBlhE+9DBMUmJ
         GxkEYoIMNTPPlIAqAO7/NQqY7GisH6XAFLisJUC+JCq+XLHSDBlG7bZWdw0zm4+VLqTX
         BBiHU4lrkCl7P0j09tJlVjmVlsiqCaQkASa1j6Y8qO4Z+3vG89I4vPfSunnr7484X/rz
         SnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706597163; x=1707201963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvrXResZGE4/DvhzRWh+okVrzmaN0fxYjAblKrbqDHM=;
        b=hvS4MNm0XwX4hZyHo4jfS9Qbnp2XDYrXS8ESeNy7pfEf/9r+XJc/TPK+5FKp0cZGBP
         FvUCR0R60nCZwPsdtat6it8boM1gHQGY8EC4sQ6XWI0UybPPZ1cr/r84D+Ys6Ary6faN
         jsGvX1RCHLcWTnrikLwN1Ms6ZX7qX1pQm7yXAjs1TDwWautaH9VT0pk0MeGUFmGfvKQg
         VY9Ukg+e2nl+BTnObU51i1yqFowrh85owt0Umf9d3IkSX/TB8aEKqlaaOzt7uZv1vqf3
         /s97uNgi0zQ4xfHFPLBOtUCJ2uUgHlxoH2v5JwBxG1UjNa+ZRisjt6duNI8dBcda0p7H
         AiuA==
X-Gm-Message-State: AOJu0YwF3vpCx7CCFGkxqE2P5GdkDkeJmH/xikpgdrdkTTG9gdf4EYyH
	Rs7MioYIX343HTKxOyb9tvBwT2iBFZbHjyL3fo+CSHrrYs5QeBDmcEZaad5jWw==
X-Google-Smtp-Source: AGHT+IGdaihkElksH7nPsmMtAsXQRmOr6amCEam+6ifXhSBS7v1I2WeNhvrg9w75wMxkQaOlyKrsBg==
X-Received: by 2002:a05:6808:e8d:b0:3bd:815d:3cb1 with SMTP id k13-20020a0568080e8d00b003bd815d3cb1mr6036198oil.57.1706597163037;
        Mon, 29 Jan 2024 22:46:03 -0800 (PST)
Received: from thinkpad ([117.202.188.6])
        by smtp.gmail.com with ESMTPSA id f8-20020a056a001ac800b006dde10cb03esm6916318pfv.151.2024.01.29.22.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:46:02 -0800 (PST)
Date: Tue, 30 Jan 2024 12:15:55 +0530
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
Message-ID: <20240130064555.GC32821@thinkpad>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbengMb5zrigs_2Z@google.com>

On Mon, Jan 29, 2024 at 06:56:24PM +0530, Ajay Agarwal wrote:
> On Mon, Jan 29, 2024 at 01:42:54PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 29, 2024 at 01:34:52PM +0530, Ajay Agarwal wrote:
> > > On Mon, Jan 29, 2024 at 12:40:25PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jan 29, 2024 at 12:21:51PM +0530, Ajay Agarwal wrote:
> > > > > On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > > > > > > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > > > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > > > > > started or not, the code waits for the link to come up. Even in
> > > > > > > > > cases where start_link() is not defined the code ends up spinning
> > > > > > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > > > > > gets called during probe, this one second loop for each pcie
> > > > > > > > > interface instance ends up extending the boot time.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Which platform you are working on? Is that upstreamed? You should mention the
> > > > > > > > specific platform where you are observing the issue.
> > > > > > > >
> > > > > > > This is for the Pixel phone platform. The platform driver for the same
> > > > > > > is not upstreamed yet. It is in the process.
> > > > > > > 
> > > > > > 
> > > > > > Then you should submit this patch at the time of the driver submission. Right
> > > > > > now, you are trying to fix a problem which is not present in upstream. One can
> > > > > > argue that it is a problem for designware-plat driver, but honestly I do not
> > > > > > know how it works.
> > > > > > 
> > > > > > - Mani
> > > > > >
> > > > > Yes Mani, this can be a problem for the designware-plat driver. To me,
> > > > > the problem of a second being wasted in the probe path seems pretty
> > > > > obvious. We will wait for the link to be up even though we are not
> > > > > starting the link training. Can this patch be accepted considering the
> > > > > problem in the dw-plat driver then?
> > > > > 
> > > > 
> > > > If that's the case with your driver, when are you starting the link training?
> > > > 
> > > The link training starts later based on a userspace/debugfs trigger.
> > > 
> > 
> > Why does it happen as such? What's the problem in starting the link during
> > probe? Keep it in mind that if you rely on the userspace for starting the link
> > based on a platform (like Android), then if the same SoC or peripheral instance
> > get reused in other platform (non-android), the it won't be a seamless user
> > experience.
> > 
> > If there are any other usecases, please state them.
> > 
> > - Mani
> >
> This SoC is targeted for an android phone usecase and the endpoints
> being enumerated need to go through an appropriate and device specific
> power sequence which gets triggered only when the userspace is up. The
> PCIe probe cannot assume that the EPs have been powered up already and
> hence the link-up is not attempted.

Still, I do not see the necessity to not call start_link() during probe. If you
add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
negligible. The reason why I'm against not calling start_link() is due to below
reasons:

1. If the same SoC gets reused for other platforms, even other android phones
that powers up the endpoints during boot, then it creates a dependency with
userspace to always start the link even though the devices were available.
That's why we should never fix the behavior of the controller drivers based on a
single platform.

2. This will create fragmentation among the DWC glue drivers w.r.t the behavior
and will become a maintenance nightmare (there are enough already).

So, I'd suggest you to use the asynchronous probe mentioned above so that other
drivers may probe in parallel thus avoiding the delay that you are worried about.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


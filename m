Return-Path: <linux-pci+bounces-32306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B01B07BEC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347037A72DA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF22F5C40;
	Wed, 16 Jul 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U8ZB+LKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B12F5C3B
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686766; cv=none; b=HY1/SXj0MZh8d/O18gvFIWhSXC4VUfGLO5H/jLC4uFmXUQGLB5qBSQfEBQ8yfCegxR9rSR4K5D3hkJmmMnp7g537TKg0CNejRz7/LG3qRFAKNQL34e7R9Zr4pgGBZXff7HfQ4PkhCVO5XXYvGx26ih+0fjcAlYQGLU6LIh6VxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686766; c=relaxed/simple;
	bh=GUfyf2plKo8rHN85YZhesmhtOC7FETZyXicnE7/kB64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKoTqcVFfaqHjsYjH+RFbF1cEjd1YnlfA+IO+MnGd8zos8D7QLApSOnP8/6DFh0TB9+DIniWxk9klK73eRr24/8cbTkPZeYCpYlEfBe0Bb/nbQ/DmTOXlFu+AaM9GDuQSeF8uhKt0K8t8mTwvLOfennHepEV1rbUq5QZKzYNF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U8ZB+LKs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2353a2bc210so551885ad.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752686760; x=1753291560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kHHeE2kJpSMXJOVTToRq3RMoJpv6Fr2i3DdKBabil8=;
        b=U8ZB+LKsZmPPtHB1HM/BzCkw5RJSnW1hu2bFsNXupEJmUNK+USeqAHQZNGLsl/Btjj
         GASEoLtePQM2o1/iIp4qPXurgiksQ+oXej6un2OOrM2l3eG/Ak6T0Tamw88xisdxOSl7
         IjrWygoYmaUt3HgoQjg5q6vmu/bvvR2u+NMZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686760; x=1753291560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kHHeE2kJpSMXJOVTToRq3RMoJpv6Fr2i3DdKBabil8=;
        b=bvwSr7zDqWUToC56VW4SguLQPZZFNOhcij6EOyErQBQlfnvCkxtONA//EgSMHVJLox
         3a6CURqqEoM3Eub5t1Mm5AwhAE+AAcL99NurREPt3n+nzf1LuLrtC51DpA6a+2aI/3U7
         qadkKvQb3q40mZAGNwPCOKdXrrxUObDHqEirwdhla/tQQSzHnBPHbGMjCFAirOerRtbD
         h9HhBwlu9O3RW1fYGc79HBpbFZ8RBK6mt7BOk259nbrLxFJXQIW6eZIUvwGQT9rDtLZ5
         30BzsSG19epWGmqqdxR7re5nbXbeTM9fqwUUs13vZoTYwaxYNbQ2AcN3rJacrDakUwVT
         JLWg==
X-Forwarded-Encrypted: i=1; AJvYcCV3vWYQSjs6oyXVuFmGFYGHkfNxCbXEgEhuoWQFI9LPx+0vTWccROvP9AsFsV0StUaQ+rmuRsCJ7Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLEFljO7ZgtfWtv/0UXn9thPf1XS9sGIybK5Tov6J7gU+3Wve
	2IIKLjzwQDR7mZwX3HWRmyhY94t87NFUPBSEkzcNeNh5j/BF/dpyr6lFauW9rUhYiw==
X-Gm-Gg: ASbGncuHajJdqadFSa2n1ag3BUlABPBFi8Ke08lSvXdUg0ELk0yfQ8GYSq6lVEwKRWT
	G93/mS3astCJw0uXE+3B1F4lzXkorgSMWjppcSpSf2SQcumOcgcy50lSEvJVtbZ2pgiLnNVmFim
	Dbm+sShusBlyNELhWHpESahRkmIdNWYVz18f6IgYC7YeHf39/Vrz6c6ZRFq+rTCYdur2yxDDuHm
	oAy8y/tDiYOBk3qQCqXcWcGnWAaR6BbylOc/sWJWEYa90vTL2IyxQTSzTRS6eDrO6Cza4Xo2tSx
	A7UFNtxyTsmWzN8g4wJpoUWmuDfh+PQoBekYKHP9TEwMG4V+HzXzVLMcR20/UhNVZiswobbgKrs
	MQH/qBFBgpHTrch+DjAn8iBzcL5KR3AWo/L/gWPm43X3y8ujSKFz9z6d1ZUAe
X-Google-Smtp-Source: AGHT+IEgRxwzuEwrC/bSIJHQuOCIp213H3FKeMYHG1zJUSxzvhkFVK3NOkI8LhIaYo9Dg+UiGLCMDQ==
X-Received: by 2002:a17:90b:3c06:b0:311:b0ec:135f with SMTP id 98e67ed59e1d1-31c9f459f8bmr4342453a91.30.1752686760162;
        Wed, 16 Jul 2025 10:26:00 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:17f8:90f2:a7bc:b439])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c9f287be2sm1788951a91.23.2025.07.16.10.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:25:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:25:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aHfgpWsC1GlQUIEm@google.com>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
 <aGXEcHTfT2k2ayAj@google.com>
 <tikcdb63ti6hbpypusxdiaoattpuez5rgpsglzllagnqfm5voa@5eornv77pl4i>
 <aHfDRm2S8N8Qus_m@google.com>
 <vatnozecxmzh5bwrapkjcucnfusjz7ugpx2upbwihoioxbf2ko@ydwd65l4peju>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vatnozecxmzh5bwrapkjcucnfusjz7ugpx2upbwihoioxbf2ko@ydwd65l4peju>

On Wed, Jul 16, 2025 at 09:35:38PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 16, 2025 at 08:20:38AM GMT, Brian Norris wrote:
> > On Wed, Jul 16, 2025 at 12:47:10PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:
> > > > On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > > OTOH, I do also believe there are SoCs where DWC PCIe is available, but
> > > > there is no external MSI controller, and so that same problem still may
> > > > exist. I may even have such SoCs available...
> > > > 
> > > 
> > > Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from this limitation.
> > > And the same should be true for other vendors also.
> > > 
> > > Interestingly, the Qcom SoCs route the AER/PME via 'global' SPI interrupt, which
> > > is only handled by the controller driver. This is similar to the 'aer' SPI
> > > interrupt in layerscape platforms.
> > 
> > Yeah, I have some SoCs like this as well. But I also believe that I have
> > INTx available, and that even when MSI doesn't work for AER/PME, INTx
> > might.
> > 
> > Do Qcom SoCs route INTx?
> > 
> 
> Yes, they do. But currently, we can only use it by booting with pcie_pme=nomsi
> cmdline parameter.

Cool, so it sounds like you might be in a better spot than layerscape,
based on the explanations I've seen from them. They seem to require
multiplexing multiple platform-specific interrupts, which isn't as easy
to pretend is a proper INTx line.

> > > So I think there is an incentive in allowing the AER driver to work with vendor
> > > specific IRQs.
> > 
> > Yeah, I suppose even if my SoC (and Qcom, depending on the above answer)
> > might work with INTx, it really does seem like an arbitrary decision
> > about what SoC makers connected which DWC signals, so I suspect this is
> > true.
> > 
> 
> Maybe we should be able to extend the dmi quirk in portdrv.c to allow Root Ports
> or host bridge to use INT-X instead of forcing them to use cmdline params.

Yeah, it sounds like that would be sufficient for non-ITS Qualcomm PCIe,
and also for my SoCs. It's also necessary (but maybe not sufficient) for
Layerscape too.

One complexity: this is not exclusively a "host bridge" quirk. It's also
a quirk of the MSI provider. So for example, looking at
arch/arm64/boot/dts/qcom/x1e80100.dtsi, you have 2 controllers without
GIC ITS, and 2 with GIC ITS, all using the "same" type of bridge.
IIUC, only the former 2 would need to fall back to INTx.

Brian


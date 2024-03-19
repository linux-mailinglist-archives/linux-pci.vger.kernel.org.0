Return-Path: <linux-pci+bounces-4886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937E87F730
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 07:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958791F21CA9
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435257885;
	Tue, 19 Mar 2024 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7pUaJ64"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF584597B
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829218; cv=none; b=dtNjbwERhMmYrR+aHr8n2ATyN3+geaEVGRoqgzNgP3WHWMLzZ+3h+C7ElnNyyqEscqPvxqqXP0JRHvLRJnD6WSApwemOKd/S6HrDIgjJBy1sxRrs7QIAcIoy1tbozCT9LhmcEHS5BRum0J4VKLovkl6YVe0OltCbtmTdZsrGj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829218; c=relaxed/simple;
	bh=i8dPXeaLCtLNoGn50Vpk4m9T4XBsQ5McVgQrpizYOOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4QujYuY11KCKwATXRDuynoiOh7HERg8n39IXDNpimBJ10/2p86qiEU8wqx02qyi/lFgU7tXugpDFXDaU1rHRdFNF581Q77xVcd3GFnyQvR3PUvtTHQhWsrqHiJw4neB6AxmKE/nI+cotkXb7nsd7jY/HAwpagJnAX/0VYY4c/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C7pUaJ64; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def2a1aafaso23191905ad.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710829216; x=1711434016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYeWtNleJl2DTZrkZyl5ddn744Nbjj8PtYemSF7luEY=;
        b=C7pUaJ640FydAVhhfu7KO9MLc1VlGdnSgWms+K8wgl0PXZxclnmDDqBiN4vbmQMFI0
         XP4KYTCCm/VwIQv71IAksD6ManaacwTeKaN1ucwsQdv3A1pEJyXJe5tJ1miHDeVbQ2fy
         56ddZXvuloVx2pBiirllou6+kLU4J7vvz1cSNO6aWg3GqZTa7EoTgtSB8I/FCZ8117Mr
         xJhAKndSAX4x8RtQB71Cc4W/6/iWPzu8IKKYEz4eEl2xbYnd7kkv8hwgyz7K1BJZw2g3
         NJgiE2xjtLjZN4h52od2Ljsx52pBH1qrme82VTZEfFcQvBF6OSM/Aqhly9aOls1iunLn
         k0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829216; x=1711434016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYeWtNleJl2DTZrkZyl5ddn744Nbjj8PtYemSF7luEY=;
        b=Q9mVecqD6WzMlnHKaqKN19x8n1STi29zgniqh/nrSxy7UQfRwD2F8BUKfsinD1pJ+7
         gcR84cAKNedNAW5vc+oIEBNIerIglSDR8Sq774hBgwLPsNnP0QW7HghgfS95c4hBYtcE
         EiWOiLsf+hhMqD6v3/rT57y2tW7Ii1M6EjOh+vRgi4pStWkFFr/nEFPuqQM9u3GR+3Dr
         6K+RqsWVi8UXLQGosr95cc6ECW0T4ToFv2eGVigJOxsGO/z0/LjUBptgCqytQb59pIpy
         d+LmX44lNiq/1OCKYv3AwPR1/taXqlB5iwCD792Wxeraq1uTxGsn71AI0+D9tNkD/6ug
         ARpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDh8oodJnuQ3DJCiqMIaIR3tJ9YmWxJEEsZi/i2spdfREZcGgBYvUK87uLL60N9PcIU5iqTXJCohLkAhRSxawVuy/rYmDy5UTw
X-Gm-Message-State: AOJu0YxM+jpimKv86kT7ingkKkqyt9T1GJnQa9AHuxg9lGQXwtFeoh8Y
	+jsaT/CF8RA+3uKIYakgM9xiKnf92qrb3soafhkGcrAqXPbMpPcKREmBJ5HqFA==
X-Google-Smtp-Source: AGHT+IHAAv9eBZUcUarmGBasu/YbAaZ67ZKQdQymoOPFyhVOFJPbaToj86vG6zi/y+hJRfbg4LYq/w==
X-Received: by 2002:a17:903:22cd:b0:1e0:4cfa:5e65 with SMTP id y13-20020a17090322cd00b001e04cfa5e65mr170960plg.16.1710829216337;
        Mon, 18 Mar 2024 23:20:16 -0700 (PDT)
Received: from thinkpad ([120.138.12.142])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001dd67d69848sm4176936plf.82.2024.03.18.23.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:20:15 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:50:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs
Message-ID: <20240319062011.GD52500@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org>
 <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <20240318043058.GB2748@thinkpad>
 <20798a83-b2e6-4ecd-8e83-e39514b685a8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20798a83-b2e6-4ecd-8e83-e39514b685a8@app.fastmail.com>

On Mon, Mar 18, 2024 at 07:44:21AM +0100, Arnd Bergmann wrote:
> On Mon, Mar 18, 2024, at 05:30, Manivannan Sadhasivam wrote:
> > On Fri, Mar 15, 2024 at 06:29:52PM +0100, Arnd Bergmann wrote:
> >> On Fri, Mar 15, 2024, at 07:44, Manivannan Sadhasivam wrote:
> >> > On Wed, Mar 13, 2024 at 11:58:01AM +0100, Niklas Cassel wrote:
> >
> > But I'm not sure I got the answer I was looking for. So let me rephrase my
> > question a bit.
> >
> > For BAR memory, PCIe spec states that,
> >
> > 'A PCI Express Function requesting Memory Space through a BAR must set the BAR's
> > Prefetchable bit unless the range contains locations with read side effects or
> > locations in which the Function does not tolerate write merging'
> >
> > So here, spec refers the backing memory allocated on the endpoint side as the
> > 'range' i.e, the BAR memory allocated on the host that gets mapped on the
> > endpoint.
> >
> > Currently on the endpoint side, we use dma_alloc_coherent() to allocate the
> > memory for each BAR and map it using iATU.
> >
> > So I want to know if the memory range allocated in the endpoint through
> > dma_alloc_coherent() satisfies the above two conditions in PCIe spec on all
> > architectures:
> >
> > 1. No Read side effects
> > 2. Tolerates write merging
> >
> > I believe the reason why we are allocating the coherent memory on the endpoint
> > first up is not all PCIe controllers are DMA coherent as you said above.
> 
> As far as I can tell, we never have read side effects for memory
> backed BARs, but the write merging is something that depends on
> how the memory is used:
> 
> If you have anything in that memory that relies on ordering,
> you probably want to map it as coherent on the endpoint side,
> and non-prefetchable on the host controller side, and then
> use the normal rmb()/wmb() barriers on both ends between
> serialized accesses. An example of this would be having blocks
> of data separate from metadata that says whether the data is
> valid.
> 
> If you don't care about ordering on that level, I would use
> dma_map_sg() on the endpoint side and prefetchable mapping on
> the host side, with the endpoint using dma_sync_*() to pass
> buffer ownership between the two sides, as controlled by some
> other communication method (non-prefetchable BAR, MSI, ...).
> 

Right now, there are only Test and a couple of NTB drivers making use of the
pci_epf_alloc_space() API and they do not need streaming DMA.

So to conclude, we should just live with coherent allocation/non-prefetch for
now and extend it to streaming DMA/prefetch once we have a function driver that
needs it.

Thanks a lot for your inputs!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-41953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A92C81397
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 795E94E0F2B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39350296BB6;
	Mon, 24 Nov 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Seo4Hn51"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98828725B
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996698; cv=none; b=UmdEsQQKHFDiCl0MUmSOEj2K43fNZ6Y/40TvI2TELTOIYZGZ/QtWSCEH/eEuljNIqSAEWt486XMMjFDiL5zc+ccii//1svzRC259ZVaE+GPF+AfbGuczy6z6UL0Bp2650FO1b28LszYd/IHiLManc84DEWF05zH1LiHVoMaF0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996698; c=relaxed/simple;
	bh=bl8O5g3ALeboQPaSMLXPxJfO5WA5b0CdNxZur/No9/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BymUNdYoqKJ1/R6PiUXxSv+iyW0HxEWrx6gwufrFkmeQdiQpbAAU+Tk+MS30JxE543AUuar365p1J08Pvo8JLO76M4bXI3Q6kels83zJwRTrc64WDeopsfIPkyItIfP1XLOMprAQYMBEqYrNYgMII57JQ1efDMjJcnw+9a84c5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Seo4Hn51; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8823cde292eso48498416d6.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763996695; x=1764601495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJkIX+/oYqHEvlPsJeDpB/URfWFBCeX3FkBVuLqXA3g=;
        b=Seo4Hn51zNHsYulUvqaiu4rhJr7DWdzIuj+88Li+9dl/xNe9BIy072RP0vYvnJEp1D
         PxydQ8Z92OMsqMXoJv6pP4YtHTLVRNM4BaLphkBc5i4b2azg5nTXt2Cjzs9V7Agf+Dsj
         x5yFDsqcmLLT14Jr15kOVnQaCz+ODcD1fDDi8SVXrpxlNkSfnwHgraIAgoHnfJA9dMBe
         JEnwUaE7l7/BjfSgEft70OwdljHBMv/C2iV69fRa9S1cL4jVxh/tjWAbuL45CfcWrK7x
         F0btbk1fnk91rzKcMCjdc0ZgiDuUgks3wzUgjhx45KIiT/YVT11RI8NsJCIHI80A4ggb
         1TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996695; x=1764601495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJkIX+/oYqHEvlPsJeDpB/URfWFBCeX3FkBVuLqXA3g=;
        b=MZD18hqLBblDmIIggkDy6NAbQcO2bUGFqSRU5IAoCVTjKQiMyndZnpr+hxuo4OwSrA
         DbeYEhqT5SvhyGHHIJIoB8/N52yJMfZmbnIhwjzR3wDGrLRFfsLdXOi5azhQpfUvq+nP
         yTtbnA4Hn+q7XuT7PcxSxUaVoKYWH0ggLZYu32OvRxr16Bxc9AoG2YzfeoIAh2yEmfoW
         4LxxbOAtsyK91cmiPP5FiShfmghPDUC3KsAvrOIGEjVGMbQ0cjqK47gmGhRLK/OdvRfA
         EV+biI+SMnlFHF0P67xH1OB701JS26X1uO8R1eQvEJs4Wo2li5q8HUoSWInluPX1RNaR
         gcng==
X-Forwarded-Encrypted: i=1; AJvYcCV/e12PiDitjxngFMGj7vEhj6Xrl7MOui2hw+AjYpu7xKVRpAYPDs9YLulbnUyVc1ftTtM+S7PY+yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVuXg1CXMoS+Undvf689YEuFvCLM0PuBG8PZIYoVfcHhA0y4d
	y+RLtPUyscUKemHN7WaOwbUF3Xmx2hi0sk+kIryhRkjtSTkh8Sq/zZb5EZhlwfkIIcQ=
X-Gm-Gg: ASbGncvs6iNKYibisgYKJV3dtH8EHIgY1zoGGsn/EoXZIYZQSiT7b8LwXpUPamyOyfW
	ht0LxmqL+YdR3Ieljv8x+9fuGU2likfneu2V/4dhfchfDZu4iVItqj3nHj4LaIs2PNvogab1Jhd
	NxOdu4h+vnnwH7pQlZ7oTToeS9kOi5OlNgy5yUrdcNtesgptHoN8RWs14qC4r0eL3JT/sXQqx0A
	Q+3rKq82vc2IPLdeuV2JWwfUTlQW0wuxNTxqMf1Kqsfz2FBummUlmjU9Gy53GZGuDDfzJknjTMw
	UHm9PoO5PsUArUcFXQerAihI9naeg5JjA4vLr+PQ42ENGO+KIvEQNXPIOKcNC2xDyarWK/VCJIX
	QEPmcPNRfzxxjIWn+FlVigWrpE8KDlPRuK+I0KSoUKFXsfVvCeZuIgugIehNKM+vUCiCiIbHyRw
	6/tcYr2CowQXe0nTXXBPUw89Aexp6q8AF7U7pCEFhjpuOT7ZqWs8/Pz0rP
X-Google-Smtp-Source: AGHT+IG20MOuWEIxJFP5dPJrmOS1XZhPinNJnSppXMT9JqNqrVNc22rYssnBqVNHIcufpECT7fuYwg==
X-Received: by 2002:ad4:5942:0:b0:880:5193:1102 with SMTP id 6a1803df08f44-8847c53f239mr191314586d6.56.1763996692032;
        Mon, 24 Nov 2025 07:04:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b28sm100926216d6.1.2025.11.24.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:04:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vNY7W-00000001vQL-3WSH;
	Mon, 24 Nov 2025 11:04:50 -0400
Date: Mon, 24 Nov 2025 11:04:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <20251124150450.GS233636@ziepe.ca>
References: <20251121232642.GG233636@ziepe.ca>
 <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
 <20251122185701.GZ18335@unreal>
 <DEFKSDBXEQS0.3C79SP3HEG1OY@kernel.org>
 <20251123063456.GA18335@unreal>
 <DEFZP148A2NK.29G6N1V1SXT8T@kernel.org>
 <20251123111823.GD16619@unreal>
 <20251124135725.GO233636@ziepe.ca>
 <20251124145332.GB12483@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124145332.GB12483@unreal>

On Mon, Nov 24, 2025 at 04:53:32PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 24, 2025 at 09:57:25AM -0400, Jason Gunthorpe wrote:
> > On Sun, Nov 23, 2025 at 01:18:23PM +0200, Leon Romanovsky wrote:
> > > > >> That sounds a bit odd to me, what exactly do you mean with "reuse the PF for
> > > > >> VFIO"? What do you do with the PF after driver unload instead? Load another
> > > > >> driver? If so, why separate ones?
> > > > >
> > > > > One of the main use cases for SR-IOV is to provide to VM users/customers
> > > > > devices with performance and security promises as physical ones. In this
> > > > > case, the VMs are created through PF and not bound to any driver. Once
> > > > > customer/user requests VM, that VF is bound to vfio-pci driver and
> > > > > attached to that VM.
> > > > >
> > > > > In many cases, PF is unbound too from its original driver and attached
> > > > > to some other VM. It allows for these VM providers to maximize
> > > > > utilization of their SR-IOV devices.
> > > > >
> > > > > At least in PCI spec 6.0.1, it stays clearly that PF can be attached to SI (VM in spec language).
> > > > > "Physical Function (PF) - A PF is a PCIe Function that supports the SR-IOV Extended Capability
> > > > > and is accessible to an SR-PCIM, a VI, or an SI."
> > > > 
> > > > Hm, that's possible, but do we have cases of this in practice where we bind and
> > > > unbind the same PF multiple times, pass it to different VMs, etc.?
> > > 
> > > It is very common case, when the goal is to maximize hardware utilization.
> > 
> > It is a sort of common configuration, but VFIO should be driving the
> > PF directly using its native SRIOV support. There is no need to rebind
> > a driver while SRIOV is still enabled.
> 
> It depends on how you created these VFs. If you created them through
> native driver, you will need to unbind and bind it to VFIO.

That should not be done or encouraged.

Jason


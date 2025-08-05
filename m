Return-Path: <linux-pci+bounces-33443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556BAB1BA65
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 20:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F29E16DBCD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D75299944;
	Tue,  5 Aug 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WL+xheep"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1566298CDE
	for <linux-pci@vger.kernel.org>; Tue,  5 Aug 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419343; cv=none; b=UrQxVAAiSttnEM+wxtKxHg6xJikcMVklYJiL8cCsKjlOXGLnNhTiTzHYsL296egYa4KeUG5SvHO04jNV7RjsiUM5T/Z0xb2w4pzRBUhOfKVv/pYsGus1LnGvfYXe1TV4u9GdfDqHwkN4PLLZMxVyoOJu/7owLUVMYM7fqGPSGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419343; c=relaxed/simple;
	bh=P46mtJ0gCpHpBEjbtuFgOf8BIfh7RrO1hxnNGIV0+78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH55adoUziTNIaIppZd9qgoQABDIKoESAVpOD4uElNTi+/0mF1cLYwr5CC1Y78Pfj1yJlwPpRGFJ1YhhWPYjUTHmCYmEDcEbL20C5EqIyc9s05+r7Vvkh/Y0dpeepw1n33FlAoH/1z2+hr1O9EHXr1RFLTzhxlFtl8UxUYC0cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WL+xheep; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e6696eb47bso631114085a.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2025 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754419340; x=1755024140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7XB7GrHToBPhXF/Sktcv3tgOaDMdGgdpINsfi2+cJw=;
        b=WL+xheepnw+g0TjNay0uouQCrZwZXKbtSEVqV/EsQPwJ6z+Ic+gAQbHdu+Hwz4cKlZ
         lPfdM8pL+Asq9srIoFDLbAgRfH9/PS3EFSjiN2hqqJjVPu8B1OnpuvtCykRv6MzTTAK4
         3IjnEkqLK/Nk2n5IdSzmohjeniUMZE6T3Qx5lNvoQy4V2OrL46QFYfWOrHe19n9jHh05
         Nh5G9+ynnTn6T9F+g4MY93Tl1nscD1nkXMlAAvBXJAmy7hY4jZK3yqwEvbCvjURrIncb
         bzVrtknhiMJ+AXJWEkf3yNPsfCvnBEItK0XgBkLnmpXyI+eIccTNh9jPweSWpzQaUmQF
         OG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754419340; x=1755024140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XB7GrHToBPhXF/Sktcv3tgOaDMdGgdpINsfi2+cJw=;
        b=ZI77C0MRaAm8lGpVEjyC+sPjZO4V2jfoEK0qyDeofs4K0wkKkhm76xYNWpWfbQavDl
         9Td8xEyGU8oduil4QrKIbKfuHzUroXzK9fSjMLtoo2oyE0cs6RV24R/giaCT3uTzFvC9
         b/6cC/az+JlppijGqchlE4MGCeAF/PLT8lULB6CFMqYFcRfWpWaGaiR24NUfGYu7gFn9
         uQT4VfR5savqVjELBRw9gAsW19PQmaaJXFS+VT7jDwnF++AoLmLBJF5xBs48d0NwrXZI
         ZpN5dMoHNGuZrynw9DoAhJW+X8aF6e4Y0AKQWdFw1TQVDeftaTUtE8rhM8bDnscrMrul
         s6QA==
X-Forwarded-Encrypted: i=1; AJvYcCX4N4/h0BIbeePmiBMVvLMaXj+Ny2ARcqMXZlLaJu/9/IeAl4YxiJL+71AVxyETh7Vg570qRFY9HEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOU+vZsSk7grpHA7pd6F87P5lCdXiPkVKg+eQTw4Kg4FAR0kQ
	1Rzngem+pR1kRgY+uTUKerhafvB+sUfJ77HK3BD2JwKZH5hZBckudEuN9pyvjj1mh7o=
X-Gm-Gg: ASbGncvLfNBT3yCppytmBCq7UwukJ19JBttzauZyRhU895hgV4F0uzCeSxXrOZ34kBB
	4ErhwoeAcmeDENu4d8nMnZ4Il8f0A7y1fw4PkcjWNuytHRnx3wA/SSQdSurYIdo/Xm/N1KV/5uk
	BS8isaV1gDsy9aDNEQYDsDDidcuYHIUoDvFnOGNwbzunqRZbYfhV6ZhKl/x0mP+UFw0yTHZCNtJ
	o2Dy/5Jme+T2ffxSMlje8UWaUfO4smmBb3Vqdc4l7AvHTMxPvgs0K4VZMIptR6U9mwBsl+HLEtX
	t3e9yQ8nrMfulakGxRv2gPQyBgL85IfZWhl7sbapS2cNdcEF/TOSIrRGT/NnNEAPokO5itZCq5T
	EeuCzg7s0NEuE6KJiEHzIVUZrgiXmgHN4ucct5gOiPW1G/2dVCZwTG4sCXK/uDpusJ9kD
X-Google-Smtp-Source: AGHT+IFJzYdfGQoh/nIgvuIB92GlB+9KcosE0NpiAsp7dbUcQ9i0SxxUhRh1JZQ7lvAEKF3yp7Ujtg==
X-Received: by 2002:a05:620a:a91a:b0:7e6:30f0:82bd with SMTP id af79cd13be357-7e814dae548mr48217385a.33.1754419340508;
        Tue, 05 Aug 2025 11:42:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f594228sm692985285a.11.2025.08.05.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 11:42:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujMc7-00000001aDl-0KMK;
	Tue, 05 Aug 2025 15:42:19 -0300
Date: Tue, 5 Aug 2025 15:42:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250805184219.GZ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5acy9a8ih6.fsf@kernel.org>
 <20250805172741.GX26511@ziepe.ca>
 <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Aug 05, 2025 at 11:27:36AM -0700, dan.j.williams@intel.com wrote:
> > > Clearing any of the following bits causes the TDI hosted
> > > by the Function to transition to ERROR:
> > > 
> > > • Memory Space Enable
> > > • Bus Master Enable
> > 
> > Oh that's nice, yeah!
> 
> That is useful, but an unmodified PCI driver is going to make separate
> calls to pci_set_master() and pci_enable_device() so it should still be
> the case that those need to be trapped out of the concern that
> writing back zero for a read-modify-write also trips the error state on
> some device that fails the Robustness Principle.

I hope we don't RMW BME and MSE in some weird way like that :(
 
> > Here is where I feel the VMM should be trapping this and NOPing it, or
> > failing that the guest PCI Core should NOP it.
> 
> At this point (vfio shutdown path) the VMM is committed stopping guest
> operations with the device. So ok not to not NOP in this specific path,
> right?

What I said in my other mail was the the T=1 state should have nothing
to do with driver binding. So unbinding vfio should leave the device
in the RUN state just fine.

> > With the ideal version being the TSM and VMM would be able to block
> > the iommu as a functional stand in for BME.
> 
> The TSM block for BME is the LOCKED or ERROR state. That would be in
> conflict with the proposal that the device stays in the RUN state on
> guest driver unbind.

This is a different thing. Leaving RUN says the OS (especially
userspace) does not trust the device.

Disabling DMA, on explict trusted request from the cVM, is entirely
fine to do inside the T=1 state. PCI made it so the only way to do
this is with the IOMMU, oh well, so be it.

> I feel like either the device stays in RUN state and BME leaks, or the
> device is returned to LOCKED on driver unbind. 

Stay in RUN is my vote. I can't really defend the other choice from a
linux driver model perspective.

> Otherwise a functional stand-in for BME that also keeps the device
> in RUN state feels like a TSM feature request for a "RUN but
> BLOCKED" state.

Yes, and probably not necessary, more of a defence against bugs in
depth kind of request. For Linux we would like it if the device can be
in RUN and have DMA blocked off during all times when no driver is
attached.

Jason


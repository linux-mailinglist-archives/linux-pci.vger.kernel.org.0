Return-Path: <linux-pci+bounces-4887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A725A87F734
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 07:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA04282130
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035E4EB5D;
	Tue, 19 Mar 2024 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBMS9GNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642748CFC
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829346; cv=none; b=hHrjSJl4tIxml3YufeFI6w7Y6jo/08p1UmzpK2A3GZRXx40PpVfil8SuXn9HauiTKyj++KRYFqWcPj0X4jvOXC3ybP+w6sA0bTsiVQQ4CosONO8XuuTpwBiIyfoJMCWsAOLHirlcI+MTF4nSadrbhfIQFMYUCt4Op3VoTd2yfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829346; c=relaxed/simple;
	bh=zrUbd9quM46xbDds6wZktjavosE66EDVzp/8OBVGNSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlNuHJkywcIuPGgTT5qm3uODWrEGkzzCSi2pj80oKR5JLGeLrawhJNm6UxXi15EU7kB4wxXgMezZLlfcig5B11tHv6XkToEIOuWmnyduZoSo4GS32xkMRnQrEqrYT8Pfmnu9I0zdGeyy02AQ4s6E1jnm5177Co2XXx7yIYZh+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBMS9GNv; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c398187b4dso129203b6e.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710829344; x=1711434144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p0zx34WGw0aTfNYe3xGMWnxbHzEIrmMIBQySE24qshw=;
        b=yBMS9GNvFrGC3NqrA6ONmfgctRZcWsp50XWEIzLokS6EzHgidb+cOcHLYaXOwEeOj7
         MmFrjqgKGYF4JgUxmIri4xe24IOE00dxAwUvcaOoNysRXncEb8bNTPqQgYsTTKhsA3YC
         6jxYk6Hnr8GyGtbH61kXW8S9mtHgzeSxJC0hyWSdWelML+JTN9MTP89U7DUqqQNtEj/e
         Y6qZQ0mNVY48QmQzQl276lqjqC78OS5f/0x83xdIDIVPEstyI7KZBB9gOQrSAUAq/O+C
         ECqmJGg252Q09ZzQ7JzZozO8OrRk/O7cATaNpUfF2mG1Vg/k9E483f+NleroXSz5j+Su
         AOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829344; x=1711434144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0zx34WGw0aTfNYe3xGMWnxbHzEIrmMIBQySE24qshw=;
        b=ikRe8rDc28YBqbO4vKyRJNRvYqC9Ih6YxbMdIA7V3tfRiLBCwvRBl4iUchKOtfcrLS
         9fgOEujlrqfoOcdHuKUmR0IZJcGcaEsMPK5EfDHDj2ralZ4fWYotR7F5JNnYfNe9KoYw
         TTBY7KE8Dh342dwy4X6srvqjlym02AO8GPcYdkXE0wXwbIaGm1lXTAT+xwEkmHQeL2G3
         linuPhbGTGXrqKA5Hmn14qwXuJgYRjuwPWb0szoE/HcOxtbhuNGe8XslL2hQctUu782v
         asbDoTPe0OklcXCUAyAQLEpJCmYocenXK96W2CbuwFWQVCWLpAu1V0R7DCOP8X8BgUAy
         5CbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu62H+AcG4YpulLaLpf7ETM7zuT8uuzi0aqCDLIApEfIwUt+zWsWLdvPkNYiNl9/RF2jBli78cD1W/A/4APCl64BgFiXslDNa+
X-Gm-Message-State: AOJu0YwLnR1CYZaD8dyn9ZXPHmr59/85wu+S8EdkgBQ9wppQRKrARZ1h
	SMbcz1ZD+094syiGWUV6F5mcnhNNzmu5J+HLcf0TjWKBk1JHIhQuT9LswY+5WA==
X-Google-Smtp-Source: AGHT+IGGmvoyMP+M/41OYBzRdT5d+BFBNftXBBG7ghVB8M78TDgyOYq3al2NR4fZsaDscz67kULhRg==
X-Received: by 2002:a05:6808:3988:b0:3c3:99cb:26c9 with SMTP id gq8-20020a056808398800b003c399cb26c9mr483716oib.18.1710829343889;
        Mon, 18 Mar 2024 23:22:23 -0700 (PDT)
Received: from thinkpad ([120.138.12.142])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e5359e621csm8918037pfn.182.2024.03.18.23.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:22:23 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:52:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs
Message-ID: <20240319062217.GE52500@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org>
 <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <ZfbZ45-ZWZG6Wkcv@ryzen>
 <7003f4e3-fe3c-43d7-8562-efaacc3d65d3@app.fastmail.com>
 <ZfhaIbTcy0vgdT1A@ryzen>
 <7cd98e59-07ce-489a-992d-bd9c52b83ef5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cd98e59-07ce-489a-992d-bd9c52b83ef5@app.fastmail.com>

On Mon, Mar 18, 2024 at 04:49:07PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 18, 2024, at 16:13, Niklas Cassel wrote:
> > On Mon, Mar 18, 2024 at 08:25:36AM +0100, Arnd Bergmann wrote:
> >
> > I personally just care about pci-epf-test, but obviously I don't
> > want to regress any other user of pci_epf_alloc_space().
> >
> > Looking at the endpoint side driver:
> > drivers/pci/endpoint/functions/pci-epf-test.c
> > and the host side driver:
> > drivers/misc/pci_endpoint_test.c
> >
> > On the RC side, allocating buffers that the EP will DMA to is
> > done using: kzalloc() + dma_map_single().
> >
> > On EP side:
> > drivers/pci/endpoint/functions/pci-epf-test.c
> > uses dma_map_single() when using DMA, and signals completion using MSI.
> >
> > On EP side:
> > When reading/writing to the BARs, it simply does:
> > READ_ONCE()/WRITE_ONCE():
> > https://github.com/torvalds/linux/blob/v6.8/drivers/pci/endpoint/functions/pci-epf-test.c#L643-L648
> >
> > There is no dma_sync(), so the pci-test-epf driver currently seems to
> > depend on the backing memory being allocated by dma_alloc_coherent().
> 
> From my reading of that function, this is really some kind
> of command buffer that implements individual structured
> registers and can be accessed from both sides at the same
> time, so it would not actually make sense with the streaming
> interface and wc/prefetchable access in place of explicit
> READ_ONCE/WRITE_ONCE and readl/writel accesses.
> 

Right. We should stick to the current implementation for now until a function
driver with streaming DMA usecase comes in.

- Mani

> >> If you don't care about ordering on that level, I would use
> >> dma_map_sg() on the endpoint side and prefetchable mapping on
> >> the host side, with the endpoint using dma_sync_*() to pass
> >> buffer ownership between the two sides, as controlled by some
> >> other communication method (non-prefetchable BAR, MSI, ...).
> >
> > I don't think that there is no big reason why pci-epf-test is
> > implemented using dma_alloc_coherent() rather than dma_sync()
> > for the memory backing the BARs, but that is the way it is.
> >
> > Since I don't feel like totally rewriting pci-epf-test, and since
> > you say that we shouldn't use dma_alloc_coherent() for the memory
> > backing the BARs together with exporting the BAR as prefetchable,
> > I will drop this patch from the series in the next revision.
> 
> Ok. It might still be useful to extend the driver to also
> allow transferring streaming data through a BAR on the
> endpoint side. From what I can tell, it currently supports
> using either slave DMA or a RC side buffer that ioremapped
> into the endpoint, but that uses a regular ioremap() as well.
> Mapping the RC side buffer as WC should make it possible to
> transfer data from EP to RC more efficiently, but for the RC
> to EP transfers you really want the buffer to be allocated on
> the EP, so you can ioremap_wc() it to the RC for a memcpy_toio,
> or cacheable read from the EP.
> 
>       Arnd

-- 
மணிவண்ணன் சதாசிவம்


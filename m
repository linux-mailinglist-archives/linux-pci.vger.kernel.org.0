Return-Path: <linux-pci+bounces-5217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C521F88D64D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 07:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E911C1C23ABE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD71CA9C;
	Wed, 27 Mar 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR74vXDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B16D1BF35
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520469; cv=none; b=h6XJbXlYS6+PUo8/uRMpcEra8jR1Xw6SbeiWjAog9ry7ZfTZnGNNXs4wlEcx2eYOcexVS+OrMp8mXEz0VKlaM5Zf3qWxSASas0+D8tfsnX9cj875QzrsLz9JPxO7VoVLiW2sXlVGNracB+/M+kHI3ViDd5qBB7Dml5yXWflmQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520469; c=relaxed/simple;
	bh=uduAPsemUiF3kKLePNAdcKhtUX9zK/8F6XPa4ZV8vlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbbmblFxt9CksmCCe4TQHQCgIv61maaX17/MLwY3vIz5JIucCExb7QFbAK+BKOiVEPWd8HGj4n8pwk9aiHOh0q1JYDLTg2TR26SLtqCbhEK1rGi+IOvsgx/bo7KI7ndZuxDohg9mEDAA2buQJL+4/pN+e/2ekGkB2Q9siRW1524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eR74vXDo; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c38eced701so3791578b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711520467; x=1712125267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oRl+Z1tMPz4Q4p1Op9JBulO2ticmDN/cJ3ocaKbgVas=;
        b=eR74vXDoIrz0PDVxYbPLIp8ArPkDhmoBMscrmnR6HOkQLAjSllEQD09m6N3hnIg/eh
         31iWwIPF5w1hnJo/Clx3eAvj4yt1UYx4Rl+5EQYhE36Hj581WL5Ean7nAm0EPtfOCS68
         t73kbA3R2kbuhtdr1WKxUDGKpkPlI1lPcZ9BxN/bYZ1CBu/+qoGQ3LKYEO8wEzd0TWPJ
         yAFtr5znEosgNaokRsZJROA4zIG4McNy5uUPzKH8yTtcRIGRZH601IeVW4FY7GVR7cA6
         bC9RqyW3b2wkTcq5QVwQ+w7Ikwt9I4tMMbh/r3UVhlROTPXrCVuIpdzlsKoLb0+BC3sY
         Ct6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711520467; x=1712125267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRl+Z1tMPz4Q4p1Op9JBulO2ticmDN/cJ3ocaKbgVas=;
        b=UXay8jmqhJi5RlQxJ8WwhRQBpG/JdsccX6hazZel+k4eMOWuPk6PDjjU6Zk9MttwrT
         BVekoF6xUEgPACumDRE6RI1z9cf6nN7M6Jyl7MkJ2pK/SuMUEHJVzWHwSXpy7MN4Wi6s
         DYdBbrWRzWqFNVXz0nvENZskiTrm7AGr0ZAJdDHqIkS8pvhiNlc/Mq7FdRaRW3bxGL8/
         3YGcL77rikJUsHmK1Z7XGVKWG9WRtNlmBe7q/7Ty65M9zJcC3k2/rm0w+beK5BNJAOvD
         VTAnvyoWrjGxidj1qgLApF29jCEo3CRjFbytGuwANEO0a+wi4Oh7VuJmIzRDf/p4s9u3
         xK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpBXxgdGeGeobzbZ5jxOcifqSHtAUqvsKrlXSKjioUTnCJxsSKx8u9wrQ0R5Ym+BC/GNKJGynsBkixOtvCTIe632Qe/sN1tfCP
X-Gm-Message-State: AOJu0Ywo21sg1EAo3KVK3bk6YaTR2ao2L2Z/PTb/27U1Et4HwUn/rvBy
	MCRN6MZDqSAnfqzOEHOP95FOwUGloMJwupN7+5EbpxszJhkgJVr6UsjlomoOBQ==
X-Google-Smtp-Source: AGHT+IFifem00+k2JsG/SxhgHmZdMkGlO6+uZGOIbYeNr0CcoKxBntUKJAzlesnxfHtFmS5UgRoAMg==
X-Received: by 2002:a05:6808:6406:b0:3c3:a606:8076 with SMTP id fg6-20020a056808640600b003c3a6068076mr1912243oib.16.1711520467217;
        Tue, 26 Mar 2024 23:21:07 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79842000000b006e6c3753786sm7099690pfq.41.2024.03.26.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:21:06 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:50:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 05/11] PCI: epf-{mhi/test}: Move DMA initialization to
 EPC init callback
Message-ID: <20240327062021.GB2742@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
 <20240326082636.GG9565@thinkpad>
 <ZgKsBoTvPWWhPO9e@ryzen>
 <ZgLbT1JLn7r_TCwd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgLbT1JLn7r_TCwd@ryzen>

On Tue, Mar 26, 2024 at 03:27:27PM +0100, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 12:05:42PM +0100, Niklas Cassel wrote:
> > On Tue, Mar 26, 2024 at 01:56:36PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Mar 22, 2024 at 05:10:06PM +0100, Niklas Cassel wrote:
> > > > On Thu, Mar 14, 2024 at 08:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > > To maintain uniformity across EPF drivers, let's move the DMA
> > > > > initialization to EPC init callback. This will also allow us to deinit DMA
> > > > > during PERST# assert in the further commits.
> > > > > 
> > > > > For EPC drivers without PERST#, DMA deinit will only happen during driver
> > > > > unbind.
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > 
> > > > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > > > 
> > > > 
> > > > For the record, I was debugging a problem related to EPF DMA recently
> > > > and was dumping the DMA mask for the struct device of the epf driver.
> > > > I was a bit confused to see it as 32-bits, even though the EPC driver
> > > > has it set to 64-bits.
> > > > 
> > > > The current code works, because e.g., pci_epf_test_write(), etc,
> > > > does:
> > > > struct device *dma_dev = epf->epc->dev.parent;
> > > > dma_map_single(dma_dev, ...);
> > > > 
> > > > but it also means that all EPF drivers will do this uglyness.
> > > > 
> > > 
> > > This ugliness is required as long as the dmaengine is associated only with the
> > > EPC.
> > > 
> > > > 
> > > > 
> > > > However, if a EPF driver does e.g.
> > > > dma_alloc_coherent(), and sends in the struct *device for the EPF,
> > > > which is the most logical thing to do IMO, it will use the wrong DMA
> > > > mask.
> > > > 
> > > > Perhaps EPF or EPC code should make sure that the struct *device
> > > > for the EPF will get the same DMA mask as epf->epc->dev.parent,
> > > > so that EPF driver developer can use the struct *epf when calling
> > > > e.g. dma_alloc_coherent().
> > > > 
> > > 
> > > Makes sense. I think it can be done during bind() in the EPC core. Feel free to
> > > submit a patch if you like, otherwise I'll keep it in my todo list.
> > 
> > So we still want to test:
> > -DMA API using the eDMA
> > -DMA API using the "dummy" memcpy dma-channel.
> > 
> > However, it seems like both pci-epf-mhi.c and pci-epf-test.c
> > do either:
> > -Use DMA API
> > or
> > -Use memcpy_fromio()/memcpy_toio() instead of DMA API
> > 
> > 
> > To me, it seems like we should always be able to use
> > DMA API (using either a eDMA or "dummy" memcpy).
> > 
> > I don't really see the need to have the path that does:
> > memcpy_fromio()/memcpy_toio().
> > 
> > I know that for DWC, when using memcpy (and this also
> > memcpy via DMA API), we need to map the address using
> > iATU first.
> > 
> > But that could probably be done using another flag,
> > perhaps rename that flag FLAG_USE_DMA to NEEDS_MAP or
> > something.
> > (Such that we can change these drivers to only have a
> > code path that uses DMA API.)
> 
> Looking at pci-epf-mhi.c, it seems to use names like:
> pci_epf_mhi_iatu_read() and pci_epf_mhi_edma_read().
> 
> This seems to be a very DWC focused naming.
> 
> AFAICT, EPF drivers should work on any PCIe EP controller that implements
> the EPC API.
> 
> Yes, I understand that it is only Qualcomm that uses this MHI interface/bus,
> but what is stopping Qualcomm from using a non-DWC based PCIe EP controller
> in an upcoming SoC?
> 
> Surely that Qualcomm SoC could still implement the MHI interface/bus,
> so perhaps the naming in this EPF driver should use somewhat less
> "EPC vendor specific" function names?
> 

Yeah, agree. This needs to be cleaned up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


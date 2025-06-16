Return-Path: <linux-pci+bounces-29863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCFADB12F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A56165544
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB82292B50;
	Mon, 16 Jun 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="adHw9e5z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D2285C80
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079355; cv=none; b=loomMDO5lDFgCNCQC8+n2inio9QBVZ4wpDdaPtaeN237+6Yzzb5Owm+9hrb8kJzE7KpeQ9bI6bDn30jo0SfuSSZyghvX8ULe3wYs+j6g5An7JgdWAf1v7fexgxOgebV+ofG/H/QQbvhY1aCelLwYvdck0W2mewHjFSArQxwgFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079355; c=relaxed/simple;
	bh=mbyl5OXkWqYUPxXU7YEwGwzWceS42PNsUXDiLKdjHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONAYLINeL2E7Rzx5ryUiR321Me4tV6r5lWP4y/gelSKXsVXkLdIasttxvBQmwmxutefdC6/thSPuHbO/ld2MXYS3Mcm5J8BUVWcHhex+MmLp8Ih1T+MRwai6ptH4nBtz2GOsULaxL86e8U8ZOc9pyDNSqXEi9wYFxNeS8ijC6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=adHw9e5z; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6faf66905baso64318666d6.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750079353; x=1750684153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlPt6HGrhBZHmQKdGeykmC3k0brj4QqdFhzAJiZkO8k=;
        b=adHw9e5zGGe0tObvkCm206nPr7XYfppmXqyx6ru2fg7iN0VEhmk8x1dMlwd5kOGevR
         LrPiZmJRSrXDzXU7fPCV5zoc+udPjLvhFut19IlNDRssW5toyyhHzJEGCgAv0nMgVbP/
         8LUxCTF1XOJh+Uol1xrJAc1p1MPN7BAu0pxfF7bRhiO7inckBk2wSGbPgCyVchrK7PFX
         FxMunE1GYXc1qaLfudxwAYSMtiNiTvqY5tC0WBFHkAQX/JaKXUXw8WYWfU1ZJFNc+tLp
         uqCtTtXQVnwVOF+PSVN8/uKYXJDIBPAld5TsYcjT/W6MUbYpGyewReBbySD4pGO/V5i3
         zl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079353; x=1750684153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlPt6HGrhBZHmQKdGeykmC3k0brj4QqdFhzAJiZkO8k=;
        b=OeHXPiBbGGGDRSNpIDkloM+GtFX6FjMxvb+nsuNNxt4SWeUvlpZNNar0fSe96iShD9
         80dnJLmTVUsPEZ3WXsDf7ry4KWVegMl1bzdcZ6XPHbI1IqHNQSbNfrME6MUf9JQRZmTC
         vl496mRZkOVvWRzdEhtM5aI0TTVvhhFIpfuYFNZ4v0+klWiLuNKeqAxanpuDCnfPP0fM
         je6mRWMfg5epWUNGXMRqjPc2NCc1C4yw0JybACrCzg3qYwX2+YimR5I14pLeCeosDOhL
         p/KePvpW0ACVU2Lkk+v7qyq80AgeH38H1wukFHkEfRQFnb0tViyVRGaZxNDIpmNMyrw+
         wvKw==
X-Forwarded-Encrypted: i=1; AJvYcCXCie+OTCJgY9BWspvlxhDuNzEgWxHCmnVZjUxpct+DT0rMvP25qRqvCrf5WpIrki0AceOR57Vtsw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAxzQfLTo5awFL2my5G7b/vC8/C/eEmq3nVlqqaKwd9YFJ6jg
	rDFGbtukh0/YJ6IhzJ2BslXvuY/ME+D1Js9ivjSW+tL1oi+ccWQh5I4J6pzWe2jsvPM=
X-Gm-Gg: ASbGnctztPHHQQtAq/iS5RnHfLL8bqfry+/O+mIm0RPIoZUXs3m5uCFSl7xF+jUeszw
	5IcdEnnbWjihwjmhBIrFCL+eUArsJ2kwW8+hlMBzVFkOfXXKI8eTua+vxWs1KAL609h2xIANWq8
	Wdg+aqavjowAI1qTFB/VmkyuCeZK7XN+7Ln81LNznMCihMTFKsIDnSyZEdKxlbnu6+rpAq1UTAl
	O6LB+mTRyO8cCHMNjBEiLQpvZ6Km0pTk7z8Xbhi5deEvLN+pglAUGAf/HH2RBoCDQWkTM3EGlB1
	wrIB02fR0t10J8eoss00MlsbJpNVcb1j3B2d+u6T4/LspifYjJRxF1/xsd3sbmP4Xat/o3i/OS6
	sw2J4YtQdUQ4pRzh8q9KQ0wwPqOAJ2Vn+dHc83A==
X-Google-Smtp-Source: AGHT+IFYwnfrlyEOgdj8TrGnzF9X6IlaZQJ38GRIzTE1wgTjrgnCanKObhnDaStP1HkHOZyR/IYWjw==
X-Received: by 2002:ad4:5d6f:0:b0:6fa:d8bb:294c with SMTP id 6a1803df08f44-6fb47726e99mr137566516d6.14.1750079352531;
        Mon, 16 Jun 2025 06:09:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20f67sm50759076d6.16.2025.06.16.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:09:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uR9aJ-00000005gPp-17Iv;
	Mon, 16 Jun 2025 10:09:11 -0300
Date: Mon, 16 Jun 2025 10:09:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <20250616130911.GA1354058@ziepe.ca>
References: <20250610163045.GI543171@nvidia.com>
 <20250613192709.GA971579@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613192709.GA971579@bhelgaas>

On Fri, Jun 13, 2025 at 02:27:09PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 01:30:45PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 04:37:58PM +0100, Robin Murphy wrote:
> > > On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> > > > Hi all,
> > > > 
> > > > Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> > > > before initiating a Function Level Reset, and then ensure no invalidation
> > > > requests being issued to a device when its ATS capability is disabled.
> > > 
> > > Not really - what it says is that software should not expect to receive
> > > invalidate completions from a function which is in the process of being
> > > reset or powered off, and if software doesn't want to be confused by that
> > > then it should take care to wait for completion or timeout of all
> > > outstanding requests, and avoid issuing new requests, before initiating such
> > > a reset or power transition.
> > 
> > The commit message can be more precise, but I agree with the
> > conclusion that the right direction for Linux is to disable and block
> > ATS, instead of trying to ignore completion time out events, or trying
> > to block page table mutations. Ie do what the implementation note
> > says..
> > 
> > Maybe:
> > 
> > PCIe permits a device to ignore ATS invalidation TLPs while it is
> > processing FLR. This creates a problem visible to the OS where ATS
> > invalidation commands will time out. For instance a SVA domain will
> > have no coordination with a FLR event and can racily issue ATC
> > invalidations into a resetting device.
> 
> The sec 10.3.1 implementation note mentions FLR specifically, but it
> seems like *any* kind of reset would be vulnerable, e.g., SBR,
> external PERST# assert, etc?

Yes, there are a bunch of states where a PCI devices is permitted to
ignore ATC invalidation TLPs.. Aside from all the resets power
management is also a problem.

Jason


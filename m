Return-Path: <linux-pci+bounces-7574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11678C76F9
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DE2835F0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF965145B3D;
	Thu, 16 May 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMXdwarB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7172145B28;
	Thu, 16 May 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864357; cv=none; b=dSxpE5jg0laHDVcQ1liooeCokvS8e4SVKYhvT0qOT4UJT7BYYvsQMdocsfIC+WUPSJXfzDUKDkiXLEnHdoa7boprIz1LPxpKyjlmC7awFQQSmpGAzni+H7oK9xPW17FT8Yt7e1AnHzgO3vX+oRmUewVDt8E8pnVBRWXahznbvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864357; c=relaxed/simple;
	bh=ffkwtfRAcATYYGVuq3fnxSpseSR1d1ylnA6E2Bt/nG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT2iLmLOR3TDmOe/lu+lkHwGZ7EvlMsss4HkyQzXM7kBs1GDMsn7c1Qnf/L+SDV2+ligYX+i3uDPGW5HoRd/Ot14thvbZnNPUiFV+0nM1+wMKtO3LqpLyZ9citltxNwXP25BgATVSignp//5bKxfAWhDH7UuFa73XT4pBIxGlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMXdwarB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE83C113CC;
	Thu, 16 May 2024 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715864357;
	bh=ffkwtfRAcATYYGVuq3fnxSpseSR1d1ylnA6E2Bt/nG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMXdwarBN/YvsIjHd98g7mTumujPMRAmaABhG0bpcq+W/EcpSn2zbt2ZUSze1CnMR
	 XT+x7Op9ESlE2zIsLli5A2r5RX5wLBfc8t7kv0Zwmocv7krBeZENXdNKW6tF9gIBYD
	 J/PNXGoq1kRVL8YHbzHm5uflFe9S3l0jw3VeHNSAqXRV+8gJRm8lQqKzhu0oROmCF9
	 vwU7GVdy6UkuBZo1eMcJd/UREohdrsURhPUpQ7JUawkgGibdG2Gi0dHnmwZvok01Tb
	 qmPb2Cw9X/JlTY43w/viFip8hrK/ec+KVh9uiW4Oj+EpqmksoPrtE8TQcvugpDi5Uz
	 4lAOHST9eN3Hg==
Date: Thu, 16 May 2024 14:59:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240516125913.GC11261@thinkpad>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>

On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> Hi virtio folks,
> 

You forgot to CC the actual Virtio folks. I've CCed them now.

> I'm writing to discuss finding a workaround with Virtio drivers and legacy
> devices with limited memory access.
> 
> # Background
> The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> indicate devices requiring restricted memory access or IOMMU translation. This
> feature bit resides at position 33 in the 64-bit Features register on modern
> interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> API that handles to use of appropriate memory.
> 
> # Problem
> However, legacy devices only have a 32-bit register for the features bits.
> Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> result, legacy devices with restricted memory access cannot function
> properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> 
> # Proposed Solutions
> I know these are not ideal, but I propose the following solution.
> Driver-side:
>     - Implement special handling similar to xen_domain.
> In xen_domain, linux virtio driver enables to use the DMA API.
>     - Introduce a CONFIG option to adjust the DMA API behavior.
> Device-side:
> Due to indistinguishability from the guest's perspective, a device-side
> solution might be difficult.
> 
> I'm open to any comments or suggestions you may have on this issue or
> alternative approaches.
> 
> [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> The Linux PCIe endpoint framework is used to implement the virtio-net device on
> a legacy interface. This is necessary because of the framework and hardware
> limitation.
> 

We can fix the endpoint framework limitation, but the problem lies with some
platforms where we cannot write to vendor capability registers and still have
IOMMU.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-8082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC38D4EAC
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29A41F22A97
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6FF17D881;
	Thu, 30 May 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvKzIUbD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310B145A01;
	Thu, 30 May 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081681; cv=none; b=DF3YRDsow+pXmxSGL/9wiOqH5zI7BVeO+fBJA5MGL/u7qwqRJcNouziG5TgTuqY3qQQOEx0r9pN7oNYSonCDZKZ39uKih78RwbC2A++A8fhYwYd+nKXmFKRYvO1jKb6nyomwido4OKnB4XHkxJS7/w0uSMiIgZ+AtcuEq6TX5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081681; c=relaxed/simple;
	bh=3/zdBTPSJJf8HlvOufHkYXn47FBd5IAwPdehy8BAi2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXFarB3Ukiqfksudmyq7vEOnflDfLst3W52dzQgljhAvfEl45ETkZd+hVwmF0P0o9U2fQOQxl7qWOVAIWG5OlXpYebNncblwHURjdFdOBVV8DE9pxFYVj7b5jrFaATR+kmrgewGU23RWecyvOb+sR1zoETBsFKugOq0lNYr21PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvKzIUbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81810C2BBFC;
	Thu, 30 May 2024 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717081680;
	bh=3/zdBTPSJJf8HlvOufHkYXn47FBd5IAwPdehy8BAi2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvKzIUbD6I6xCDDUTNyTFHbkeN9/F7TPCrh/1IKTMcBmZqyiD0JLFoD4I+aywctNN
	 Hx6Pw/EypbUoXopkBa+dXDOBiKx5D54083+/S4pIleTI6OeRVsrFDfO9IzvuDmTsE1
	 4LJO8N9ViuMMe37iTFWT0vxL+3cYNsM8/bIFvkvuvV5diNV1Zm8uVOZRnJYTCxQASz
	 ID7AHl4ANkIvt/0EUHTXRt9jIROuAOWl3LuDpn+gmz9hil6XhXDvn+dA24rTNsk3Va
	 Y9wEaKfO/TYhxKe0tm35VFnv+be/av3PAFtZqBx8VigPGCcsCfLgOoK6Iopn/9dXmi
	 GyhRiMRaE4GIg==
Date: Thu, 30 May 2024 20:37:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240530150727.GA11438@thinkpad>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <CANXvt5rQdhS5XBnHFmFiN=fPO975jQ8dosH0L0ZP_51dd6cXag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5rQdhS5XBnHFmFiN=fPO975jQ8dosH0L0ZP_51dd6cXag@mail.gmail.com>

On Mon, May 20, 2024 at 07:24:32PM +0900, Shunsuke Mie wrote:
> 2024年5月16日(木) 21:59 Manivannan Sadhasivam <mani@kernel.org>:
> >
> > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > Hi virtio folks,
> > >
> >
> > You forgot to CC the actual Virtio folks. I've CCed them now.
> Oops. thank you.
> > > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > > devices with limited memory access.
> > >
> > > # Background
> > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > > indicate devices requiring restricted memory access or IOMMU translation. This
> > > feature bit resides at position 33 in the 64-bit Features register on modern
> > > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > > API that handles to use of appropriate memory.
> > >
> > > # Problem
> > > However, legacy devices only have a 32-bit register for the features bits.
> > > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > > result, legacy devices with restricted memory access cannot function
> > > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > >
> > > # Proposed Solutions
> > > I know these are not ideal, but I propose the following solution.
> > > Driver-side:
> > >     - Implement special handling similar to xen_domain.
> > > In xen_domain, linux virtio driver enables to use the DMA API.
> > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > Device-side:
> > > Due to indistinguishability from the guest's perspective, a device-side
> > > solution might be difficult.
> > >
> > > I'm open to any comments or suggestions you may have on this issue or
> > > alternative approaches.
> > >
> > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > > a legacy interface. This is necessary because of the framework and hardware
> > > limitation.
> > >
> >
> > We can fix the endpoint framework limitation, but the problem lies with some
> > platforms where we cannot write to vendor capability registers and still have
> > IOMMU.
> I agree, this is a problem caused by the inability to set the
> capability. I'm not sure, but are there any chips that support this?

Most of the recent endpoint platforms should support this feature.

> Also, I wasn't aware of the IOMMU issue. I thought that if the Linux
> DMA subsystem could handle IOMMU properly, there wouldn't be any
> problems. Is that incorrect?

The issue is, legacy virtio PCI device only has 32bits. So they cannot support
VIRTIO_F_ACCESS_PLATFORM which is located at bit 33 as you explained.

And if this bit is not set, then DMA APIs won't be used by the virtio stack.

I think it is best to add support for modern virtio PCI device to make use of
IOMMU. Legacy devices can continue to use physical address.

- Mani

> 
> Shunsuke,
> Best
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 

-- 
மணிவண்ணன் சதாசிவம்

